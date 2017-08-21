Import Data_Services, doxie_files, doxie,ut;

f_oshair := OSHAIR.file_out_hazardous_substance_cleaned;

slimLayout	:=	record
		OSHAIR.layout_OSHAIR_hazardous_substance_clean	 
		  - dt_first_seen	- dt_last_seen						 
			- dt_vendor_first_reported - dt_vendor_last_reported;	  
end;

NewKeyBuild	:=	project(f_oshair, TRANSFORM(slimLayout,SELF := LEFT;));

export Key_OSHAIR_payload_hazardous_substance := index(NewKeyBuild
                                          ,{Activity_Number}
										  ,{NewKeyBuild}
										  ,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::oshair::payload_hazardous_substance_'+doxie.Version_SuperKey);
