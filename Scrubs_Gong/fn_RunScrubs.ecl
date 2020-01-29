import Scrubs_Gong,Scrubs,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion = '20200129_TEST',string EmailList = '') := FUNCTION 

    return scrubs.ScrubsPlus('File_Neustar','Scrubs_Gong','Scrubs_gong_neustar_in','',pVersion,EmailList,false);

END;