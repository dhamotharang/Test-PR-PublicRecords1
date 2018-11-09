import scrubs,scrubs_risk_indicators,std,ut,tools;

EXPORT fn_RunScrubs(string pversion, string emailList):=function

	loadfile:=Scrubs_Risk_Indicators.KeyGrowth_In_Risk_Indicators(pVersion);

	return Scrubs.ScrubsPlus_PassFile(loadfile,'Risk_Indicators','Scrubs_Risk_Indicators','Scrubs_Risk_Indicators_KeyGrowth','KeyGrowth',pVersion,emailList,false);

end;