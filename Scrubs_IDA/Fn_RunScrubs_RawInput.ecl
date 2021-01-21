import scrubs,Scrubs_IDA,std,ut,tools;

EXPORT Fn_RunScrubs_RawInput(string pVersion, string emailList = '') := function

    return SEQUENTIAL(
        scrubs.ScrubsPlus('IDA','Scrubs_IDA','Scrubs_IDA_RawInput','RawInput',pVersion,emailList,false)
        //,Scrubs_IDA.Fn_Scrubs_PassFail(pVersion)  //To be activated at a later date
    );
        
end;