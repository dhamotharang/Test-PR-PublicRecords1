IMPORT  doxie,mdr;
EXPORT keys := MODULE

EXPORT key_liens_main := INDEX(FILES.liensv2_fcra_main,{flag_file_id}, 
        {FILES.liensv2_fcra_main},
				    Constants.KeyName_liens_main + doxie.Version_SuperKey +'ffid');
		
				End;