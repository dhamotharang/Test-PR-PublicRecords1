IMPORT LinkingTools, STD, BIPV2, Data_Services, tools;	
							
EXPORT BIPStats(STRING versionIn) 
:= FUNCTION									

pBaseFile	  := 	Files().base.qa;
pFatherFile	:= 	Files().base.father;

baseAsBusinessLinking   := As_Business_Linking(_Constants().IsDataland,pBaseFile ,false);
fatherAsBusinessLinking := As_Business_Linking(_Constants().IsDataland,pFatherFile,false);						

outputStatReport := BIPV2.BIPStatsReport( baseAsBusinessLinking
                                         ,fatherAsBusinessLinking
                                         ,_dataset().name
																				 ,versionIn
																				 ,Equifax_Business_Data._Flags.IsTesting);

return outputStatReport;

END;