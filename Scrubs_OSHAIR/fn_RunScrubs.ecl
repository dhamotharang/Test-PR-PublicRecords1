import scrubs,Scrubs_OSHAIR,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return sequential(
        scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_Accidents','Accident_Raw',pVersion,emailList,false);
				scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_AccidentAbstract','AccidentAbstract_Raw',pVersion,emailList,false);
        scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_AccidentInjury','AccidentInjury_Raw',pVersion,emailList,false);
        scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_GenDutyStd','GenDutyStd_Raw',pVersion,emailList,false);
        scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_Inspection','Inspection_Raw',pVersion,emailList,false);
				scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_OptionalInfo','OptionalInfo_Raw',pVersion,emailList,false);
        scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_RelatedActivity','RelatedActivity_Raw',pVersion,emailList,false);
        scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_StrategicCodes','StrategicCodes_Raw',pVersion,emailList,false);				
        scrubs.ScrubsPlus('OSHAIR','Scrubs_OSHAIR','Scrubs_OSHAIR_Violation','Violation_Raw',pVersion,emailList,false);				
    );

end;