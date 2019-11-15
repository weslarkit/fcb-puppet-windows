class windows::cis_security {

  # https://lark-it.atlassian.net/browse/FCB-165
  # Reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Service\eventlog\Security /v MaxSize /t REG_DWORD /d 0xc840000 /f
  dsc_registry {'Security MaxSize':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security',
    dsc_valuename => 'MaxSize',
    dsc_valuedata => '84000',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'Security Retention':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security',
    dsc_valuename => 'Retention',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'Security AutoBackupLogFiles':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security',
    dsc_valuename => 'AutoBackupLogFiles',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'System MaxSize':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\System',
    dsc_valuename => 'MaxSize',
    dsc_valuedata => '84000',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'System Retention':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\System',
    dsc_valuename => 'Retention',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'System AutoBackupLogFiles':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\System',
    dsc_valuename => 'AutoBackupLogFiles',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\services\Tcpip6\Parameters /v DisabledComponents /t REG_DWORD /d 0xffffffff
  # Bug: https://github.com/PowerShell/xPSDesiredStateConfiguration/issues/332
  # https://github.com/puppetlabs/puppetlabs-dsc/blob/master/lib/puppet/type/dsc_registry.rb
  dsc_registry {'Tcpip6 DisabledComponents':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip6\Parameters',
    dsc_hex       => true,
    dsc_valuename => 'DisabledComponents',
    dsc_valuedata => 'ffffffff',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\services\W32Time /v start /t REG_DWORD /d 2 /f
  dsc_registry {'W32Time Start':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time',
    dsc_valuename => 'start',
    dsc_valuedata => '2',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  #  reg add HKLM\SYSTEM\CurrentControlSet\services\W32Time\Parameter /v NtpServer /t REG_SZ /d ntp.1.aaa.com,0x9 /f
  $ntp_server = 'ntp.1.aaa.com'
  dsc_registry {'W32Time NtpServer':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\Parameters',
    dsc_valuename => 'NtpServer',
    dsc_valuedata => "${ntp_server},0x9",
    dsc_force     => true,
  }

  # reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers /v 6 /t REG_SZ /d ntp.1.aaa.com /f
  dsc_registry {'W32Time 6':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers',
    dsc_valuename => '6',
    dsc_valuedata => "${ntp_server}",
    dsc_force     => true,
  }

  # reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers /t REG_SZ /d 6 /f
  dsc_registry {'W32Time Default':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers',
    dsc_valuename => '',
    dsc_valuedata => '6',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v ActiveTimeBias /t REG_DWORD /d 0xf0 /f
  dsc_registry {'TimeZoneInformation ActiveTimeBias':
    dsc_ensure    => 'Present',
    dsc_hex       => true,
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'ActiveTimeBias',
    dsc_valuedata => '0xf0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v Bias /t REG_DWORD /d 0x12c /f
  dsc_registry {'TimeZoneInformation Bias':
    dsc_ensure    => 'Present',
    dsc_hex       => true,
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'Bias',
    dsc_valuedata => '0x12c',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v DaylightBias /t REG_DWORD /d 0xffffffc4 /f
  dsc_registry {'TimeZoneInformation DaylightBias':
    dsc_ensure    => 'Present',
    dsc_hex       => true,
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'DaylightBias',
    dsc_valuedata => '0xffffffc4',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v DaylightName /t REG_SZ /d "Eastern Daylight Time" /f
  dsc_registry {'TimeZoneInformation DaylightName':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'DaylightName',
    dsc_valuedata => 'Eastern Daylight Time',
    dsc_force     => true,
    notify        => Exec[ 'w32tm resync' ],
    before        => Dsc_service[ 'enable_w32time' ],
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v StandardName /t REG_SZ /d "Eastern Standard Time" /f
  dsc_registry {'TimeZoneInformation StandardName':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'StandardName',
    dsc_valuedata => 'Eastern Standard Time',
    dsc_force     => true,
    notify        => Exec[ 'w32tm resync' ],
    before        => Dsc_service[ 'enable_w32time' ],
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v TimeZoneKeyName /t REG_SZ /d "Eastern Standard Time" /f
  dsc_registry {'TimeZoneInformation TimeZoneKeyName':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'TimeZoneKeyName',
    dsc_valuedata => 'Eastern Standard Time',
    dsc_force     => true,
  }

  # net stop w32time
  dsc_service{'enable_w32time':
    dsc_ensure => 'present',
    dsc_name   => 'w32time',
    dsc_state  => 'Running',
  }

  exec { 'w32tm resync':
    command     => 'w32tm /resync',
    refreshonly => true,
    path        => ['c:/windows/system32'],
    provider    => powershell,
    subscribe    => Dsc_service[ 'enable_w32time' ],  
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Services\MpsSvc /v start /t REG_DWORD /d 4 /f
  dsc_registry {'MpsSvc Start':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MpsSvc',
    dsc_valuename => 'start',
    dsc_valuedata => '4',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection /v start /t REG_DWORD /d 4 /f
  dsc_registry {'ShellHWDetection Start':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ShellHWDetection',
    dsc_valuename => 'start',
    dsc_valuedata => '4',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Services\HidServ /v start /t REG_DWORD /d 4 /f
  dsc_registry {'HidServ Start':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HidServ',
    dsc_valuename => 'start',
    dsc_valuedata => '4',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess /f
  dsc_registry {'SharedAccess':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess',
    dsc_valuename => '',
    dsc_valuedata => '',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Services\sacsvr /v start /t REG_DWORD /d 4 /f
  dsc_registry {'Sacsvr Start':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sacsvr',
    dsc_valuename => 'start',
    dsc_valuedata => '4',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v legalnoticecaption /t REG_SZ /d "First Citizens Bank Logon Notice" /f
  dsc_registry {'System Legalnoticecaption':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',
    dsc_valuename => 'legalnoticecaption',
    dsc_valuedata => 'First Citizens Bank Logon Notice',
    dsc_force     => true,
  }

  # reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v legalnoticetext /t REG_SZ /d "The information on this network is the property of First Citizens Bank" /f
  dsc_registry {'System Legalnoticetext':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',
    dsc_valuename => 'legalnoticetext',
    dsc_valuedata => 'The information on this network is the property of First Citizens Bank',
    dsc_force     => true,
  }
}
