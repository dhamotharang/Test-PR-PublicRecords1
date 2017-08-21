import lib_fileservices,_control,lib_stringlib,Versioncontrol,hxmx;

export fspray (string pversion, string dir):=function
files := DATASET([
{_Control.IPAddress.edata11
,'/data_lib_2_hus2/hxmx/' + dir   //Location to be determined by operations                
,'*MX*.txt'                           
,0                                                     
,'~thor_data400::in::hxmx::'+pversion+'_mx_claims'   
,[{'~thor_data400::in::hxmx_claims::MX_'+dir}]    
,'thor400_44'
,pversion
,'[0-9]{8}'
,'VARIABLE'
,''
,10000
,'|'
},

{_Control.IPAddress.edata11
,'/data_lib_2_hus2/hxmx/' + dir   //Location to be determined by operations                
,'*HX*.txt'                           
,0                                                     
,'~thor_data400::in::hxmx::'+pversion+'_hx_claims'   
,[{'~thor_data400::in::hxmx_claims::HX_'+dir}]    
,'thor400_44'
,pversion
,'[0-9]{8}'
,'VARIABLE'
,''
,10000
,'|'
}

], VersionControl.Layout_Sprays.Info);

// return VersionControl.fSprayInputFiles(file);
	return	VersionControl.fSprayInputFiles(files, pAddCounter := true);

end;