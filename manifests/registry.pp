class windows::registry {

  # https://lark-it.atlassian.net/browse/FCB-138
  dsc_registry {'deny_ts_connection':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server',
    dsc_valuename => 'DenyTSConnection',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # https://lark-it.atlassian.net/browse/FCB-161
  # https://docs.microsoft.com/en-us/windows-server/security/tls/tls-registry-settings
  dsc_registry {'Server Disable TLS 1.0':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server',
    dsc_valuename => 'Enabled',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'Client Disable TLS 1.0':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client',
    dsc_valuename => 'Enabled',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # https://lark-it.atlassian.net/browse/FCB-162
  dsc_registry {'Disable Triple DES 168':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168',
    dsc_valuename => 'Enabled',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # https://lark-it.atlassian.net/browse/FCB-156
  dsc_registry {'WMI Standalone':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost',
    dsc_valuename => 'winmgmt',
    dsc_valuedata => 'winmgmt',
  }

  # https://lark-it.atlassian.net/browse/FCB-158
  # https://www.microsoftpressstore.com/articles/article.aspx?p=2217263&seqNum=8
  # https://docs.microsoft.com/en-us/powershell/module/nettcpip/set-netipv4protocol?view=win10-ps
  # https://social.technet.microsoft.com/Forums/windows/en-US/0d0da348-3b8b-4790-8aa2-60740a02536f/windows-7-and-igmp-multicast?forum=w7itpronetworking
  # https://superuser.com/questions/788347/how-do-i-disable-multicast-on-the-tcp-ip-stack-for-windows
  dsc_registry {'Disable Multicast':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSCLIENT',
    dsc_valuename => 'EnableMulticast',
    dsc_valuetype => 'Dword',
    dsc_valuedata => '0',
  }

  dsc_registry {'EnableDevolutionLevelControl':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSCLIENT',
    dsc_valuename => 'EnableDevolutionLevelControl',
    dsc_valuetype => 'Dword',
    dsc_valuedata => '1',
  }

  dsc_registry {'DomainNameDevolutionLevel':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSCLIENT',
    dsc_valuename => 'DomainNameDevolutionLevel',
    dsc_valuetype => 'Dword',
    dsc_valuedata => '2',
  }

  dsc_registry {'UseDomainNameDevolution':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSCLIENT',
    dsc_valuename => 'UseDomainNameDevolution',
    dsc_valuetype => 'Dword',
    dsc_valuedata => '1',
  }

  dsc_registry {'SearchList':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSCLIENT',
    dsc_valuename => 'SearchList',
    dsc_valuedata => 'fcpd.fcbint.net,fcqa.fcbint.net,fcb.com,aaa.com',
  }

  # https://lark-it.atlassian.net/browse/FCB-160
  dsc_registry {'Disable Server Manager at Startup Login: DoNotOpenServerManagerAtLogin':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager',
    dsc_valuename => 'DoNotOpenServerManagerAtLogon',
    dsc_valuetype => 'Dword',
    dsc_valuedata => '1',
  }

  dsc_registry {'Disable Server Manager at Startup Login: DoNotOpenInitialConfigurationTasksAtLogon':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Oobe',
    dsc_valuename => 'DoNotOpenInitialConfigurationTasksAtLogon',
    dsc_valuetype => 'Dword',
    dsc_valuedata => '1',
  }

}
