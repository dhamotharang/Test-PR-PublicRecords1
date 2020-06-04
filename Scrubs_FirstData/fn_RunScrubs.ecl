import Scrubs_FirstData,scrubs;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('FirstData','Scrubs_FirstData','Scrubs_FirstData','',pVersion,emailList,false);

end;