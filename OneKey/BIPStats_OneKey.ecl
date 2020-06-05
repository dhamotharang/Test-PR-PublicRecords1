IMPORT LinkingTools, STD, BIPV2, Data_Services, tools, OneKey;	
							
EXPORT BIPStats_OneKey(STRING versionIn) := FUNCTION									

  baseAsBusinessLinking   := fOneKey_As_Business_Linking(OneKey.Files().base.qa);
  fatherAsBusinessLinking := fOneKey_As_Business_Linking(OneKey.Files().base.father);						

  outputStatReport := BIPV2.BIPStatsReport(baseAsBusinessLinking, fatherAsBusinessLinking, 'OneKey', versionIn, TRUE);

  RETURN outputStatReport;

END;