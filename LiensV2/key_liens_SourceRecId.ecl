import data_services, doxie;

in_file	:= LiensV2.file_liens_party_BIPV2;
																			 
export Key_liens_SourceRecId := index(in_file,{persistent_record_id},{TMSID,RMSID}
				,Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::party::SourceRecId_'+ Doxie.Version_SuperKey);		
				                                                