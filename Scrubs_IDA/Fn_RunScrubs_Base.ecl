import scrubs,Scrubs_IDA,std,ut,tools;

EXPORT fn_RunScrubs_Base(string pVersion, string emailList = '') := function

    RETURN SEQUENTIAL(
        scrubs.ScrubsPlus('IDA','Scrubs_IDA','Scrubs_IDA_Base','Base', pVersion, emailList,false),
        Scrubs_IDA.Fn_Comparison
    );

END;