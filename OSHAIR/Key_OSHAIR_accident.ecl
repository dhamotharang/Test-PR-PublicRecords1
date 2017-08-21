Import Data_Services, doxie_files, doxie,ut;

f_oshair := OSHAIR.file_out_accident_cleaned;

slimLayout	:=	record
		OSHAIR.layout_OSHAIR_accident_clean	 
		  - dt_first_seen	- dt_last_seen						 
			- dt_vendor_first_reported - dt_vendor_last_reported;	  
end;

NewKeyBuild	:=	project(f_oshair, TRANSFORM(slimLayout,SELF := LEFT;));

export Key_OSHAIR_accident := index(NewKeyBuild
                                   ,{Activity_Number}
								   ,{NewKeyBuild}
								   ,ut.foreign_prod+'thor_data400::key::oshair::accident_'+doxie.Version_SuperKey);
