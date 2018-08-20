IMPORT LinkingTools, STD, BIPV2, Data_Services, tools;												
						
EXPORT BIPStats(STRING versionIn)	:= FUNCTION						

pContactBaseFile := DATASET(data_services.foreign_prod + 'thor_data400::base::fbnv2::contact',
                              fbnv2.Layout_Common.Contact_AID , flat)
															(tmsid[1..3] not in ['ACU']); 
pBusinessBaseFile := DATASET(data_services.foreign_prod + 'thor_data400::base::fbnv2::business',
                               fbnv2.Layout_Common.Business_AID , flat)
															 (tmsid[1..3] not in ['ACU']); 	
															 
pContactFatherFile := DATASET(data_services.foreign_prod + 'thor_data400::base::fbnv2::contact_father',
                              fbnv2.Layout_Common.Contact_AID , flat)
															(tmsid[1..3] not in ['ACU']); 
pBusinessFatherFile := DATASET(data_services.foreign_prod + 'thor_data400::base::fbnv2::business_father',
                               fbnv2.Layout_Common.Business_AID , flat)
															 (tmsid[1..3] not in ['ACU']); 				
					
baseAsBusinessLinking := FBNV2.fFBNV2_As_Business_Linking(pContactBaseFile,pBusinessBaseFile);

fatherAsBusinessLinking := FBNV2.fFBNV2_As_Business_Linking(pContactFatherFile,pBusinessFatherFile);								

outputStatReport := BIPV2.BIPStatsReport(baseAsBusinessLinking
                                         ,fatherAsBusinessLinking
                                         ,_dataset().name
																				 ,versionIn
																				 ,FBNV2._Flags.IsTesting);

return outputStatReport;

END;