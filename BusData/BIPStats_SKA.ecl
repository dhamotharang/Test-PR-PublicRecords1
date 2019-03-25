IMPORT LinkingTools, STD, BIPV2, Data_Services, tools;	
							
EXPORT BIPStats_SKA(STRING versionIn) 
:= FUNCTION									

New_verified_base := DATASET('~thor_data400::base::ska_verified_w20190204-114227', busdata.layout_SKA_Verified_bdid, THOR);
New_nixie_base := DATASET('~thor_data400::base::ska_nixie_w20190204-114227', busdata.layout_ska_nixie_bdid, THOR);

baseAsBusinessLinking   := fSKA_As_Business_Linking(New_verified_base, New_nixie_base);
fatherAsBusinessLinking := fSKA_As_Business_Linking(File_SKA_Verified_Base, File_SKA_Nixie_Base);						

outputStatReport := BIPV2.BIPStatsReport( baseAsBusinessLinking
                                         ,fatherAsBusinessLinking
                                         ,'SKA'
																		,versionIn
																		,TRUE);

return outputStatReport;

END;