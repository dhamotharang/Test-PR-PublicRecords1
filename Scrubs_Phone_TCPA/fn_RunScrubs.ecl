IMPORT Scrubs, Scrubs_Phone_TCPA;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := FUNCTION

    RETURN SEQUENTIAL
		
    (
            scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_Phone_TCPA_Wireless_to_Wireline2',					'Wireless_to_Wireline2'					,pVersion	,emailList	,false),
            scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_Phone_TCPA_Wireless_to_Wireline2_NoRange',	'Wireless_to_Wireline2_NoRange'	,pVersion	,emailList	,false),
            scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_Phone_TCPA_Wireline_to_Wireless2',					'Wireline_to_Wireless2'					,pVersion	,emailList	,false),
            scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_Phone_TCPA_Wireline_to_Wireless2_NoRange',	'Wireline_to_Wireless2_NoRange'	,pVersion	,emailList	,false),
						scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_Phone_TCPA_BaseFile2',											'BaseFile2'											,pVersion	,emailList	,false)
    );

END;