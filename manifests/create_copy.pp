class windows::create_copy(
  $logoutput       = 'on_failure',
  $vss_shadow_size = '1'
){
  # https://lark-it.atlassian.net/browse/FCB-141
  $pcw_source_dir      = 'c:/larktemp/scripts'
  $pcw_destination_dir = 'c:/PCW'
  dsc_file {'PCW Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $pcw_source_dir,
  }

  # https://lark-it.atlassian.net/browse/FCB-142
  exec { 'Copy PCW':
    command   => "Copy-Item -Path \"${pcw_source_dir}\" -Destination \"${pcw_destination_dir}/\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'PCW Directory' ],
    # onlyif or unless "if(command to run if to check if PCW tools is installed){ exit 0 }else{ exit 1 }",
    # onlyif or unless will be needed to check to see if PCW tools is installed already here.
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-164
  # https://puppet.com/docs/puppet/4.10/resources_exec_windows.html
#  exec { 'Run SEO Config Script':
#    #command   => "cmd.exe /c ${pcw_destination_dir}\\pcw-set.cmd;Exit 0",
#    command   => "${pcw_destination_dir}/pcw-set.ps1",
#    provider  => powershell,
#    logoutput => $logoutput,
#    #logoutput => true,
#    require   => Exec[ 'Copy PCW' ],
#    # onlyif or unless "if(command to run if to check if command has already been run){ exit 0 }else{ exit 1 }",
#    # Typically there is some flag here to tell if this has been run successfully
#    # I don't have source files here
#  }

  # https://lark-it.atlassian.net/browse/FCB-150
  dsc_file {'Temp Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:/Temp',
  }

  #https://lark-it.atlassian.net/browse/FCB-143
  $toolbox_source_dir      = 'c:/larktemp/VMWare Tools'
  $toolbox_destination_dir = 'c:/Toolbox'
  dsc_file {'Toolbox Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $toolbox_destination_dir,
  }

  # https://lark-it.atlassian.net/browse/FCB-144
  exec { 'Copy Toolbox':
    command   => "Copy-Item -Path \"${toolbox_source_dir}\" -Destination \"${toolbox_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'Toolbox Directory' ],
    # onlyif or unless "if(command to run if to check if toolbox tools is installed){ exit 0 }else{ exit 1 }",
    # onlyif or unless will be needed to check to see if toolbox tools is installed already here.
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-145
  $powershell_source_dir      = 'c:/larktemp/VMWare Tools'
  $powershell_destination_dir = "${toolbox_destination_dir}/powershellscripts"
  dsc_file {'powershellscripts Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $powershell_destination_dir,
    require             => Dsc_file[ 'Toolbox Directory' ],
  }

  # https://lark-it.atlassian.net/browse/FCB-146
  exec { 'Copy powershellscripts':
    command   => "Copy-Item -Path \"${powershell_source_dir}\" -Destination \"${powershell_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'powershellscripts Directory' ],
    # onlyif or unless "if(command to run if to check if powershellscript are already installed){ exit 0 }else{ exit 1 }",
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-149
  dsc_file {'InstallLogs Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:/InstallLogs',
  }

  # https://lark-it.atlassian.net/browse/FCB-147
  $install_source_dir      = 'c:/larktemp'
  $install_destination_dir = 'c:/Install'
  dsc_file {'Install Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $install_destination_dir,
  }

  # https://lark-it.atlassian.net/browse/FCB-148
  exec { 'Copy Install':
    command   => "Copy-Item -Path \"${install_source_dir}\" -Destination \"${install_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'Install Directory' ],
    # onlyif or unless "if(command to run if to check if Install files already installed){ exit 0 }else{ exit 1 }",
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-151
  $infosec_file            = 'InfoSec64.ps1'
  $infosec_source_file     = "${install_destination_dir}/larktemp/scripts/${infosec_file}"
  $infosec_destination_dir = 'c:/windows/security'
  $infosec_copy_cmd        = "Copy-Item -Path \"${infosec_source_file}\" -Destination \"${infosec_destination_dir}/${infosec_file}\" -Force"
  #notify{"infosec cmd: ${infosec_copy_cmd}":}
  exec { "Copy ${infosec_file}":
    command   => $infosec_copy_cmd,
    provider  => powershell,
    logoutput => $logoutput,
    unless    => "if(Test-Path ${infosec_destination_dir}/${infosec_file}}){ exit 0 }else{ exit 1 }",
    require   => Exec[ 'Copy Install' ],
  }

  # notify{"Nick ${infosec_destination_dir}/${infosec_file}":}
  # https://lark-it.atlassian.net/browse/FCB-165
#  exec { 'Run CIS Security Script':
#    #command   => "start-process \"cmd.exe\" \"/c ${infosec_destination_dir}/${infosec_file}\"",
#    command   => "${infosec_destination_dir}/${infosec_file}",
#    provider  => powershell,
#    logoutput => $logoutput,
#    #logoutput => true,
#    require   => Exec[ "Copy ${infosec_file}" ],
#    # onlyif or unless "if(command to run if to check if command has already been run){ exit 0 }else{ exit 1 }",
#    # Typically there is some flag here to tell if this has been run successfully
#    # I don't have source files here
#  }

  # https://lark-it.atlassian.net/browse/FCB-139
  # example delete for testing: vssadmin delete ShadowStorage /For=C: /On=C:
  # example list for testing: vssadmin list ShadowStorage
  # $vss_shadow_size='1'
  exec { "Resize VSS Admin Shadow Storage to 1GB":
    command   => "vssadmin add ShadowStorage /For=C: /On=C: /MaxSize=${vss_shadow_size}G",
    provider  => powershell,
    logoutput => $logoutput,
    unless    => "vssadmin list ShadowStorage |Select-String \"Maximum Shadow Copy Storage space: ${vss_shadow_size}.00 GB\"",
  }

  # https://lark-it.atlassian.net/browse/FCB-140
  # https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/boot-parameters-to-configure-dep-and-pae
  # https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/bcdedit-command-line-options
  #  start-process bcdedit.exe "/set {current} nx AlwaysOn"
  #  verfiy with: bcdedit /v
  exec { 'Set DEP with BCEDIT':
    command   => "start-process bcdedit.exe \"/set {current} nx OptIn\"",
    provider  => powershell,
    logoutput => $logoutput,
    #unless    => "bcdedit /v|Select-String nx|Select-String OptIn",
    unless    => "if(bcdedit /v|Select-String OptIn){ exit 0 }else{ exit 1 }",
  }
}
