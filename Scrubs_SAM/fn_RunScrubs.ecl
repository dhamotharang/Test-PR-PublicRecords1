IMPORT Scrubs,Scrubs_SAM;

EXPORT fn_RunScrubs(STRING pVersion, STRING emailList = '') := FUNCTION
    RETURN scrubs.ScrubsPlus('SAM', 'Scrubs_SAM', 'Scrubs_SAM_Input', 'Input', pVersion, emailList, FALSE);
END;