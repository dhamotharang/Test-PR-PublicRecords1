import scrubs,Scrubs_FCRA_Opt_Out,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return ordered(
				scrubs.ScrubsPlus('FCRA_Opt_Out','Scrubs_FCRA_Opt_Out','Scrubs_FCRA_Opt_Out_Address','Address',pVersion,emailList,false),
				scrubs.ScrubsPlus('FCRA_Opt_Out','Scrubs_FCRA_Opt_Out','Scrubs_FCRA_Opt_Out_DID_SSN','DID_SSN',pVersion,emailList,false)
				);

end;