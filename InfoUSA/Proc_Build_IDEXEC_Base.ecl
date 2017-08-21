IMPORT ut;

dBaseOut		 	:= InfoUSA.update_IDEXEC ;

ut.MAC_SF_BuildProcess(dBaseout ,'~thor_data400::base::INFOUSA::IDEXEC',Outbase, 2);

EXPORT Proc_Build_IDEXEC_Base := Outbase;

