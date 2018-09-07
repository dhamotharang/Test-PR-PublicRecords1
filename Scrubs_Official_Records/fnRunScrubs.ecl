import scrubs,Scrubs_Official_Records,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return ordered(
				scrubs.ScrubsPlus('Official_Records','Scrubs_Official_Records','Scrubs_Official_Records_Document','Document',pVersion,emailList,false),
				scrubs.ScrubsPlus('Official_Records','Scrubs_Official_Records','Scrubs_Official_Records_Party','Party',pVersion,emailList,false),
				);

end;