import lib_fileservices;

EXPORT SuperFiles  := MODULE

	EXPORT clearFiles () := FUNCTION
		action := SEQUENTIAL(
								FileServices.StartSuperFileTransaction (),
								FileServices.ClearSuperFile(HealthCareProvider.Files.Ingenix_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Ingenix_Father_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Ingenix_GrandFather_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Ingenix_Delete_SF,true),																				

								FileServices.ClearSuperFile(HealthCareProvider.Files.AMS_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.AMS_Father_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.AMS_GrandFather_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.AMS_Delete_SF,true),																				

								FileServices.ClearSuperFile(HealthCareProvider.Files.NPPES_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.NPPES_Father_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.NPPES_GrandFather_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.NPPES_Delete_SF,true),																				

								FileServices.ClearSuperFile(HealthCareProvider.Files.DEA_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.DEA_Father_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.DEA_GrandFather_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.DEA_Delete_SF,true),																				

								FileServices.ClearSuperFile(HealthCareProvider.Files.ProfLic_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.ProfLic_Father_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.ProfLic_GrandFather_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.ProfLic_Delete_SF,true),																				

								FileServices.ClearSuperFile(HealthCareProvider.Files.ProfLic_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.ProfLic_Father_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.ProfLic_GrandFather_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.ProfLic_Delete_SF,true),																				

								FileServices.ClearSuperFile(HealthCareProvider.Files.Person_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Person_Father_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Person_GrandFather_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Person_Delete_SF,true),																				

								FileServices.ClearSuperFile(HealthCareProvider.Files.Facility_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Facility_Father_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Facility_GrandFather_SF,true),																				
								FileServices.ClearSuperFile(HealthCareProvider.Files.Facility_Delete_SF,true),																				

							FileServices.FinishSuperFileTransaction ()																					 																					 
						);
		return action;
	END;
END;