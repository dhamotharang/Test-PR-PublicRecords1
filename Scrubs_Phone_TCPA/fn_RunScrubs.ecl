IMPORT Scrubs, Scrubs_Phone_TCPA;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := FUNCTION

    RETURN SEQUENTIAL
		
    (
            scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_PhoneFinder_Wireless_to_Wireline',					'Wireless_to_Wireline'					,pVersion	,emailList	,false),
            scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_PhoneFinder_Wireless_to_Wireline_NoRange',	'Wireless_to_Wireline_NoRange'	,pVersion	,emailList	,false),
            scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_PhoneFinder_Wireline_to_Wireless',					'Wireline_to_Wireless'					,pVersion	,emailList	,false),
            scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_PhoneFinder_Wireline_to_Wireless_NoRange',	'Wireline_to_Wireless_NoRange'	,pVersion	,emailList	,false),
						scrubs.ScrubsPlus('Phone_TCPA','Scrubs_Phone_TCPA','Scrubs_PhoneFinder_BaseFile',											'BaseFile'											,pVersion	,emailList	,false)
    );

END;