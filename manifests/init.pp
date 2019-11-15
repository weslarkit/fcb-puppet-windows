class windows {
  #include windows::vmware

  class{ 'windows::create_copy':
    require => Exec[ 'Enable WinRM' ],
  }

  #class{ 'windows::registry':
  #  require => Exec[ 'Enable WinRM' ],
  #}
  
  # https://lark-it.atlassian.net/browse/FCB-159
  # https://support.microsoft.com/en-us/help/974504/the-windows-remote-manager-winrm-service-does-not-start-after-you-unin
  exec { 'Enable WinRM':
    command  => 'winrm qc -quiet; Exit 0',
    unless   => 'if(winrm enumerate winrm/config/listener|Select-String 5985){ exit 0 }else{ exit 1 }',  
    path     => ['c:/windows/system32'],
    provider => powershell,
  }

  # https://lark-it.atlassian.net/browse/FCB-157
  exec { 'Disable TCP Chminey Offload':
    command  => 'netsh int tcp set global chimney=disabled',
    unless   => 'if(netsh int tcp show global|Select-String "Chimney Offload State"|Select-String disabled){ exit 0 }else{ exit 1 }',
    path     => ['c:/windows/system32'],
    provider => powershell,
  }
}
