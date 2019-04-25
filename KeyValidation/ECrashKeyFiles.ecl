EXPORT ECrashKeyFiles := module 

import FLAccidents_Ecrash , Autokeyb2,Autokey,Data_Services, Doxie, ut;;

//Export Attribute vin 

Export Key_vin := FLAccidents_Ecrash.Key_EcrashV2_vin;

Export Key_vin7 := FLAccidents_Ecrash.Key_EcrashV2_vin7;

Export Key_tagnbr := FLAccidents_Ecrash.Key_EcrashV2_tagnbr;

Export Key_supplemental := FLAccidents_Ecrash.Key_EcrashV2_supplemental;

Export Key_standlocation := FLAccidents_Ecrash.Key_EcrashV2_standlocation;

Export Key_reportlinkid := FLAccidents_Ecrash.Key_eCrashv2_ReportLinkId;

Export Key_reportid := FLAccidents_Ecrash.Key_EcrashV2_reportid;

Export Key_prefname_state := FLAccidents_Ecrash.Key_EcrashV2_prefname_state;

Export Key_photoid := FLAccidents_Ecrash.Key_ecrashV2_PhotoId;

Export Key_partialaccnbr := FLAccidents_Ecrash.Key_EcrashV2_Partial_Report_Nbr;

Export Key_linkids := FLAccidents_Ecrash.Key_EcrashV2_linkids.key;

Export Key_lastname_state := FLAccidents_Ecrash.Key_eCrashv2_LastName;

Export Key_dol := FLAccidents_Ecrash.Key_EcrashV2_dol;

Export Key_dlnbr := FLAccidents_Ecrash.Key_EcrashV2_dlnbr;

Export Key_did := FLAccidents_Ecrash.Key_EcrashV2_did;

Export Key_deltadate := FLAccidents_Ecrash.Key_EcrashV2_deltadate;

Export Key_bdid := FLAccidents_Ecrash.Key_EcrashV2_bdid;

Export Key_agencyid_sentdate := FLAccidents_Ecrash.Key_EcrashV2_agencyid_sentdate;

Export Key_accnbr := FLAccidents_Ecrash.Key_EcrashV2_accnbr;

Export Key_accnbrv1 := FLAccidents_Ecrash.Key_EcrashV2_accnbrv1;

//Export Key_partialaccnbr := FLAccidents_Ecrash.Key_EcrashV2_Partial_Report_Nbr;

export Key_ByAgencyID   := FLAccidents_Ecrash.Key_eCrash_ByAgencyID;
									   	
Export Key_ByDow        := FLAccidents_Ecrash.Key_eCrash_ByDOW;
									   
Export Key_ByMOY        :=  FLAccidents_Ecrash.Key_eCrash_byMOY;

Export Key_ByHOD        := FLAccidents_Ecrash.Key_eCrash_ByHOD;

Export Key_ByInter 			:= FLAccidents_Ecrash.Key_eCrash_ByInter;

Export Key_ByCollisionType := FLAccidents_Ecrash.Key_eCrash_ByCollisionType;

Export Key_ECrash7 := FLAccidents_Ecrash.Key_ECrash7;

Export Key_ECrash6 := FLAccidents_Ecrash.Key_ECrash6;

Export Key_ECrash5 := FLAccidents_Ecrash.Key_ECrash5;

Export Key_ECrash4 := FLAccidents_Ecrash.Key_ECrash4;

Export Key_Ecrash3v  := FLAccidents_Ecrash.Key_ECrash3v;

Export Key_Ecrash2v  := FLAccidents_Ecrash.Key_ECrash2v;
 
Export Key_ECrash1 := FLAccidents_Ecrash.Key_ECrash1;

Export Key_ECrash0 := FLAccidents_Ecrash.Key_ECrash0;


// AUTO KEYS

	//Attribute that refers to Zip Autokey key file
	export keyFile_AutoKeyZip := Autokey.Key_Zip(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');
	
// Attribute that refers to NON FCRA ZIPB2
	  Export KeyFile_ZIPB2     := Autokeyb2.Key_Zip(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');

 	  //Attribute that refers to StName Autokey key file
		export keyFile_AutoKeyStName := Autokey.Key_StName(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');

 	  //Attribute that refers to NON FCRA Stnameb2 Autokey key file
    EXPORT keyFile_AutoKeyStnameb2 := Autokeyb2.Key_StName(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');			

			//Attribute that refers to FCRA name Autokey key file
	  EXPORT keyFile_AutoKeyname := Autokey.Key_Name(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');
	  
	
			//Attribute that refers to NON FCRA citystnameb2 Autokey key file
		EXPORT keyFile_AutoKeycitystatenameb2 := Autokeyb2.Key_CityStName(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');		
	  
		//Attribute that refers to NON FCRA citystname Autokey key file
   
	  EXPORT keyFile_AutoKeyCityStname := Autokey.Key_CityStName(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');
	
	  //Attribute that refers to NON FCRA addressb2 Autokey key file
    EXPORT keyFile_AutoKeyaddressb2 := Autokeyb2.Key_Address(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');	
		
		//Attribute that refers to NON FCRA address Autokey key file
    EXPORT keyFile_AutoKeyaddress := Autokey.Key_Address(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');	
	
	 //Attribute that refers to NON FCRA nameb2 Autokey key file
    EXPORT keyFile_AutoKeynameb2:= Autokeyb2.Key_Name(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');	
	
	  //Attribute that refers to NON FCRA namewords2 Autokey key file
    EXPORT keyFile_AutoKeynamewords2 := Autokeyb2.Key_NameWords(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashv2::autokey::');		
	
	  export Key_File_Payload   := FLAccidents_Ecrash.Key_EcrashV2_payload;	

end;