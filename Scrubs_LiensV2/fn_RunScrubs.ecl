import scrubs,scrubs_liensv2,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('LiensV2','Scrubs_LiensV2','Scrubs_Liens_Party','party',((String)Std.Date.Today())+'a','david.dittman@lexisnexis.com',false),
scrubs.ScrubsPlus('LiensV2','Scrubs_LiensV2','Scrubs_Liens_Main','main',((String)Std.Date.Today())+'a','david.dittman@lexisnexis.com',false)
);

end;