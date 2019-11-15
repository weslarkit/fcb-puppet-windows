class windows::vmware (
  $logoutput    = 'on_failure',
  $source_dir   ='c:\larktemp\VMWare Tools',
  $vm_tools_dir ='c:\temp\VM-Tools',
){
 
  # https://lark-it.atlassian.net/browse/FCB-152
  exec { 'Copy VMware Tools to C:\Temp':
    command   => "Copy-Item -Path \"${source_dir}\" -Destination \"${vm_tools_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    # onlyif or unless "if(command to run if to check if vmware tools is installed){ exit 0 }else{ exit 1 }",
    #onlyif or unless will be needed to check to see if vmware tools is installed already here.  
    #The azure vm would not let me install vmware tools as it wasn't a vmware vm.  
  }   

  # https://lark-it.atlassian.net/browse/FCB-153
  exec { 'Install VMware Tools':
    command     => "${vm_tools_dir}\setup64.exe /S /v\"/qn REBOOT=R\"",
    provider    => powershell,
    subscribe   => Exec[ 'Copy VMware Tools to C:\Temp' ],
    logoutput   => $logoutput,
    refreshonly => true,
  }

  # https://lark-it.atlassian.net/browse/FCB-155
  exec { "Remove ${vm_tools_dir} Folder":
    command   => "Remove-Item –path ${vm_tools_dir} -force -recurse",
    onlyif    => "if(Test-Path ${vm_tools_dir}){ exit 0 }else{ exit 1 }",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Exec[ 'Install VMware Tools' ],
  }
}
