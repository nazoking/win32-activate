require "win32/activate/version"
require 'win32/api'
require 'win32ole'

module Win32
  class Activate
    # Do window activate by process id.
    # If pid is nil, activate window by current process id.
    def self.active(pid=nil)
    	self.new.activate_process_window( pid || Process.pid )
    end
    # Create dictionay of { pid => hwnd }
    def create_pid_to_hwnd_dic
      dic = {}
      EnumWindows.call( Win32::API::Callback.new('LP', 'I'){ |handle, param| 
  	    pid=[0].pack('L');
  	    GetWindowThreadProcessId.call(handle, pid);
  	    dic[pid.unpack('L')[0]] = handle
      }, nil )
      dic
    end

    # Convert pid to window handler. if process not has window, return nil
    def pid_to_hwnd
      @pid_to_hwnd = create_pid_to_hwnd_dic unless @pid_to_hwnd
      @pid_to_hwnd
    end

    # Windows Management Instrumentation Object (OLE)
    def wmi
      @wmi ||= WIN32OLE.connect("winmgmts:root/CIMV2")
      @wmi
    end

    # Windows Scripting Host (OLE)
    def wsh
      @wsh ||= WIN32OLE.new('Wscript.Shell')
      @wsh
    end

    # Find parent process id ( by WMI )
    def find_parent_pid pid
      ppid = nil
      wmi.ExecQuery("SELECT * FROM Win32_Process WHERE ProcessID=#{pid}").each{|i|
        ppid = i.ParentProcessID
      }
      return ppid
    end

    # Find process id and window handler.
    # If process has not window handler, find parent process, parent's parent process ...
    # If result of search parent process reach to nil, then return nil
    def find_parent_process_with_hwnd pid
      while hwnd=pid_to_hwnd[pid].nil?
        pid = find_parent_pid(pid)
        return nil unless pid
      end
      return [pid,hwnd]
    end

    # Find parent process that has window handler, and set window activa ( by WSH )
    def activate_process_window( pid )
      pid , hwnd = find_parent_process_with_hwnd(pid)
      wsh.AppActivate(pid) if pid
    end

    # windows api GetWindowThreadProcessId
	GetWindowThreadProcessId = Win32::API.new('GetWindowThreadProcessId', 'LP', 'L', 'user32')
    # windows api EnumWindows
	EnumWindows = Win32::API.new('EnumWindows', 'KP', 'L', 'user32')
  end
end
