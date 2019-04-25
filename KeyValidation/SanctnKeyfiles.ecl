EXPORT SanctnKeyfiles := module 

import sanctn, doxie_files, doxie,ut,Data_Services,autokey, autokeyb2;

// key bdid
Export       key_bdid                            :=  Sanctn.key_sanctn_BDID;

// key casenum
Export       key_casenum                         :=  sanctn.key_sanctn_casenum;

// key did
Export       key_did                             :=  sanctn.key_sanctn_DID;

// key incident_midex
Export       key_incident_midex									 :=  sanctn.key_incident_midex;
// key incident
Export       key_incident												 :=  sanctn.Key_SANCTN_incident;
// key license_midex
Export       key_license_midex									 :=  sanctn.key_license_midex;
//key license nbr
Export       key_license_nbr                     :=  sanctn.key_license_nbr;
// key Linkids
Export       key_linkids                         :=  sanctn.Key_SANCTN_LinkIds.key;
//key midex_rpt_nbr
Export       key_midex_rpt_nbr                   :=  sanctn.key_MIDEX_RPT_NBR;
//key nmls_id
Export       key_nmls_id                         :=  sanctn.key_nmls_id;
// key_nmls_midex
Export       key_nmls_midex                      :=  sanctn.key_nmls_midex;
// key party_aka_dba
Export       key_party_aka_dba                   :=  sanctn.key_party_aka_dba;
//key party
Export       key_party                           :=  sanctn.Key_SANCTN_party;
//key rebuttal
Export       key_rebuttal                        :=  sanctn.key_rebuttal_text;
// key ssn4
Export       key_ssn4                            :=  sanctn.key_SSN4;
     
//key autokey payload
Export       key_autokeypayload                  := sanctn.Key_SANCTN_autokey_payload;	


	//Attribute that refers to Zip Autokey key file
	export keyFile_AutoKeyZip := Autokey.Key_Zip(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');
	
// Attribute that refers to NON FCRA ZIPB2
	  Export KeyFile_ZIPB2     := Autokeyb2.Key_Zip(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');

 	  //Attribute that refers to StName Autokey key file
		export keyFile_AutoKeyStName := Autokey.Key_StName(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');

 	  //Attribute that refers to NON FCRA Stnameb2 Autokey key file
    EXPORT keyFile_AutoKeyStnameb2 := Autokeyb2.Key_StName(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');			

	 //Attribute that refers to NON FCRA nameb2 Autokey key file
    EXPORT keyFile_AutoKeynameb2:= Autokeyb2.Key_Name(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');	

			//Attribute that refers to FCRA name Autokey key file
	  EXPORT keyFile_AutoKeyname := Autokey.Key_Name(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');
	  
	
			//Attribute that refers to NON FCRA citystnameb2 Autokey key file
		EXPORT keyFile_AutoKeycitystatenameb2 := Autokeyb2.Key_CityStName(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');		
	  
		//Attribute that refers to NON FCRA citystname Autokey key file
   
	  EXPORT keyFile_AutoKeyCityStname := Autokey.Key_CityStName(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');
	
	  //Attribute that refers to NON FCRA addressb2 Autokey key file
    EXPORT keyFile_AutoKeyaddressb2 := Autokeyb2.Key_Address(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');	
		
		//Attribute that refers to NON FCRA address Autokey key file
    EXPORT keyFile_AutoKeyaddress := Autokey.Key_Address(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');	
		//Attribute that refers to SSN2 Autokey key file
	export keyFile_AutoKeySSN2 := Autokey.Key_SSN2(Data_Services.Data_location.Prefix('sanctn')+'thor_data400::key::Sanctn::');

	  //Attribute that refers to NON FCRA namewords2 Autokey key file
    EXPORT keyFile_AutoKeynamewords2 := Autokeyb2.Key_NameWords(Data_Services.Data_location.Prefix('Sanctn')+'thor_data400::key::Sanctn::');		
	
end;