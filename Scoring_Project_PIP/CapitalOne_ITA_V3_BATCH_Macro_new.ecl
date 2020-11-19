EXPORT CapitalOne_ITA_V3_BATCH_Macro_new (roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing, Scoring;

		unsigned8 no_of_records := records_ToRun;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		gateways := Gateway;
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;

		//*********** SETTINGS ********************************

		DPPA := scoring_project_pip.User_Settings_Module.ITA_V3_CapOne_settings.DPPA;
		GLB := scoring_project_pip.User_Settings_Module.ITA_V3_CapOne_settings.GLB;
		DRM := scoring_project_pip.User_Settings_Module.ITA_V3_CapOne_settings.DRM;  
		DPM := scoring_project_pip.User_Settings_Module.ITA_V3_CapOne_settings.DPM;
		HISTORYDATE := 999999;
		VERSION := scoring_project_pip.User_Settings_Module.ITA_V3_CapOne_settings.Version;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************
		
		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

    ds_raw_input := distribute(IF(no_of_records > 0, CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records),
                            DATASET( infile_name, layout_input, thor)),(integer)accountnumber);

		//*********** ITA SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
			INTEGER DPPAPurpose;
			INTEGER GLBPurpose;
			STRING DataRestrictionMask;
			STRING DataPermissionMask;
			STRING ModelName;
			INTEGER Version;
			INTEGER HistoryDateYYYYMM;
		END;

		Risk_Indicators.Layout_Batch_In make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.seq := c;
			SELF.acctno := (string)le.AccountNumber;
			SELF.Name_First := le.firstname;
			SELF.Name_Middle := le.middlename;
			SELF.Name_Last := le.lastname;
			SELF.street_addr := le.streetaddress;
			SELF.p_City_name := le.city;
			SELF.St := le.state;
			SELF.z5 := le.zip;
			SELF.Home_Phone := le.HomePhone;
			SELF.SSN := le.PLACEHOLDER_1;// pionted to hardcoded ssn's column instead of calling bocashell and getting ssns
			SELF.DOB := le.DateOfBirth;
			SELF.Work_Phone := le.WorkPhone;
			self.historydateyyyymm := HistoryDate ;
			SELF := le;
			SELF := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			SELF.DPPAPurpose := DPPA;  
			SELF.GLBPurpose := GLB;  
			SELF.DataRestrictionMask := DRM;
			SELF.DataPermissionMask := DPM;
			SELF.Version := VERSION;
			SELF.HistoryDateYYYYMM := HISTORYDATE;
			SELF := [];
		END;

		//ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), RANDOM());

		//Soap output layout
		layout_Soap_output := RECORD
			unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
			Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.acctno:=le.batch_in[1].acctno;
			SELF := le;
			SELF := [];
		END;

		//*********** PERFORMING SOAPCALL TO ROXIE ************

		Soap_output := SOAPCALL(soap_in, roxieIP,
						'Models.ITA_Batch_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						PARALLEL(threads), onFail(myFail(LEFT)));				

		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************

		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout;			 
		END;
		
	  //Mapping Version3 attributes to v3 attributes
		Global_output_lay v3_trans(layout_Soap_output le, unsigned6 c) := TRANSFORM
					self.time_ms := le.time_ms;
			SELF.seq := (string)c;
			 self.v3__ageoldestrecord := le.Version3__ageoldestrecord;
			 self.v3__agenewestrecord := le.Version3__agenewestrecord;
			 self.v3__srcsconfirmidaddrcount := le.Version3__srcsconfirmidaddrcount;
			 self.v3__creditbureaurecord := le.Version3__creditbureaurecord;
			 self.v3__invalidssn := le.Version3__invalidssn;
			 self.v3__invalidphone := le.Version3__invalidphone;
			 self.v3__invalidaddr := le.Version3__invalidaddr;
			 self.v3__ssndeceased := le.Version3__ssndeceased;
			 self.v3__ssnissued := le.Version3__ssnissued;
			 self.v3__verificationfailure := le.Version3__verificationfailure;
			 self.v3__ssnnotfound := le.Version3__ssnnotfound;
			 self.v3__ssnfoundother := le.Version3__ssnfoundother;
			 self.v3__phoneother := le.Version3__phoneother;
			 self.v3__verifiedname := le.Version3__verifiedname;
			 self.v3__verifiedssn := le.Version3__verifiedssn;
			 self.v3__verifiedphone := le.Version3__verifiedphone;
			 self.v3__verifiedphonefullname := le.Version3__verifiedphonefullname;
			 self.v3__verifiedphonelastname := le.Version3__verifiedphonelastname;
			 self.v3__verifiedaddress := le.Version3__verifiedaddress;
			 self.v3__verifieddob := le.Version3__verifieddob;
			 self.v3__subjectssncount := le.Version3__subjectssncount;
			 self.v3__subjectaddrcount := le.Version3__subjectaddrcount;
			 self.v3__subjectphonecount := le.Version3__subjectphonecount;
			 self.v3__subjectssnrecentcount := le.Version3__subjectssnrecentcount;
			 self.v3__subjectaddrrecentcount := le.Version3__subjectaddrrecentcount;
			 self.v3__subjectphonerecentcount := le.Version3__subjectphonerecentcount;
			 self.v3__ssnidentitiescount := le.Version3__ssnidentitiescount;
			 self.v3__ssnaddrcount := le.Version3__ssnaddrcount;
			 self.v3__ssnidentitiesrecentcount := le.Version3__ssnidentitiesrecentcount;
			 self.v3__ssnaddrrecentcount := le.Version3__ssnaddrrecentcount;
			 self.v3__inputaddridentitiescount := le.Version3__inputaddridentitiescount;
			 self.v3__inputaddrssncount := le.Version3__inputaddrssncount;
			 self.v3__inputaddrphonecount := le.Version3__inputaddrphonecount;
			 self.v3__inputaddridentitiesrecentcount := le.Version3__inputaddridentitiesrecentcount;
			 self.v3__inputaddrssnrecentcount := le.Version3__inputaddrssnrecentcount;
			 self.v3__inputaddrphonerecentcount := le.Version3__inputaddrphonerecentcount;
			 self.v3__phoneidentitiescount := le.Version3__phoneidentitiescount;
			 self.v3__phoneidentitiesrecentcount := le.Version3__phoneidentitiesrecentcount;
			 self.v3__ssnlastnamecount := le.Version3__ssnlastnamecount;
			 self.v3__subjectlastnamecount := le.Version3__subjectlastnamecount;
			 self.v3__lastnamechangecount01 := le.Version3__lastnamechangecount01;
			 self.v3__lastnamechangecount03 := le.Version3__lastnamechangecount03;
			 self.v3__lastnamechangecount06 := le.Version3__lastnamechangecount06;
			 self.v3__lastnamechangecount12 := le.Version3__lastnamechangecount12;
			 self.v3__lastnamechangecount24 := le.Version3__lastnamechangecount24;
			 self.v3__lastnamechangecount36 := le.Version3__lastnamechangecount36;
			 self.v3__lastnamechangecount60 := le.Version3__lastnamechangecount60;
			 self.v3__sfduaddridentitiescount := le.Version3__sfduaddridentitiescount;
			 self.v3__sfduaddrssncount := le.Version3__sfduaddrssncount;
			 self.v3__ssnrecent := le.Version3__ssnrecent;
			 self.v3__ssnnonus := le.Version3__ssnnonus;
			 self.v3__ssn3years := le.Version3__ssn3years;
			 self.v3__ssnafter5 := le.Version3__ssnafter5;
			 self.v3__ssnissuedpriordob := le.Version3__ssnissuedpriordob;
			 self.v3__relativescount := le.Version3__relativescount;
			 self.v3__relativesbankruptcycount := le.Version3__relativesbankruptcycount;
			 self.v3__relativesfelonycount := le.Version3__relativesfelonycount;
			 self.v3__relativespropownedcount := le.Version3__relativespropownedcount;
			 self.v3__relativespropownedtaxtotal := le.Version3__relativespropownedtaxtotal;
			 self.v3__relativesdistanceclosest := le.Version3__relativesdistanceclosest;
			 self.v3__inputaddrdwelltype := le.Version3__inputaddrdwelltype;
			 self.v3__inputaddrlandusecode := le.Version3__inputaddrlandusecode;
			 self.v3__inputaddrapplicantowned := le.Version3__inputaddrapplicantowned;
			 self.v3__inputaddrfamilyowned := le.Version3__inputaddrfamilyowned;
			 self.v3__inputaddroccupantowned := le.Version3__inputaddroccupantowned;
			 self.v3__inputaddragelastsale := le.Version3__inputaddragelastsale;
			 self.v3__inputaddrnotprimaryres := le.Version3__inputaddrnotprimaryres;
			 self.v3__inputaddractivephonelist := le.Version3__inputaddractivephonelist;
			 self.v3__curraddrdwelltype := le.Version3__curraddrdwelltype;
			 self.v3__curraddrlandusecode := le.Version3__curraddrlandusecode;
			 self.v3__curraddrapplicantowned := le.Version3__curraddrapplicantowned;
			 self.v3__curraddrfamilyowned := le.Version3__curraddrfamilyowned;
			 self.v3__curraddroccupantowned := le.Version3__curraddroccupantowned;
			 self.v3__curraddragelastsale := le.Version3__curraddragelastsale;
			 self.v3__curraddractivephonelist := le.Version3__curraddractivephonelist;
			 self.v3__prevaddrdwelltype := le.Version3__prevaddrdwelltype;
			 self.v3__prevaddrlandusecode := le.Version3__prevaddrlandusecode;
			 self.v3__prevaddrapplicantowned := le.Version3__prevaddrapplicantowned;
			 self.v3__prevaddrfamilyowned := le.Version3__prevaddrfamilyowned;
			 self.v3__prevaddroccupantowned := le.Version3__prevaddroccupantowned;
			 self.v3__prevaddragelastsale := le.Version3__prevaddragelastsale;
			 self.v3__prevaddractivephonelist := le.Version3__prevaddractivephonelist;
			 self.v3__inputcurraddrmatch := le.Version3__inputcurraddrmatch;
			 self.v3__inputcurraddrstatediff := le.Version3__inputcurraddrstatediff;
			 self.v3__inputprevaddrmatch := le.Version3__inputprevaddrmatch;
			 self.v3__currprevaddrstatediff := le.Version3__currprevaddrstatediff;
			 self.v3__educationattendedcollege := le.Version3__educationattendedcollege;
			 self.v3__educationprogram2yr := le.Version3__educationprogram2yr;
			 self.v3__educationprogram4yr := le.Version3__educationprogram4yr;
			 self.v3__educationprogramgraduate := le.Version3__educationprogramgraduate;
			 self.v3__educationinstitutionprivate := le.Version3__educationinstitutionprivate;
			 self.v3__educationinstitutionrating := le.Version3__educationinstitutionrating;
			 self.v3__educationfieldofstudytype := le.Version3__educationfieldofstudytype;
			 self.v3__statusmostrecent := le.Version3__statusmostrecent;
			 self.v3__statusprevious := le.Version3__statusprevious;
			 self.v3__statusnextprevious := le.Version3__statusnextprevious;
			 self.v3__addrchangecount01 := le.Version3__addrchangecount01;
			 self.v3__addrchangecount03 := le.Version3__addrchangecount03;
			 self.v3__addrchangecount06 := le.Version3__addrchangecount06;
			 self.v3__addrchangecount12 := le.Version3__addrchangecount12;
			 self.v3__addrchangecount24 := le.Version3__addrchangecount24;
			 self.v3__addrchangecount36 := le.Version3__addrchangecount36;
			 self.v3__addrchangecount60 := le.Version3__addrchangecount60;
			 self.v3__propownedcount := le.Version3__propownedcount;
			 self.v3__propownedhistoricalcount := le.Version3__propownedhistoricalcount;
			 self.v3__predictedannualincome := le.Version3__predictedannualincome;
			 self.v3__propageoldestpurchase := le.Version3__propageoldestpurchase;
			 self.v3__propagenewestpurchase := le.Version3__propagenewestpurchase;
			 self.v3__propagenewestsale := le.Version3__propagenewestsale;
			 self.v3__proppurchasedcount01 := le.Version3__proppurchasedcount01;
			 self.v3__proppurchasedcount03 := le.Version3__proppurchasedcount03;
			 self.v3__proppurchasedcount06 := le.Version3__proppurchasedcount06;
			 self.v3__proppurchasedcount12 := le.Version3__proppurchasedcount12;
			 self.v3__proppurchasedcount24 := le.Version3__proppurchasedcount24;
			 self.v3__proppurchasedcount36 := le.Version3__proppurchasedcount36;
			 self.v3__proppurchasedcount60 := le.Version3__proppurchasedcount60;
			 self.v3__propsoldcount01 := le.Version3__propsoldcount01;
			 self.v3__propsoldcount03 := le.Version3__propsoldcount03;
			 self.v3__propsoldcount06 := le.Version3__propsoldcount06;
			 self.v3__propsoldcount12 := le.Version3__propsoldcount12;
			 self.v3__propsoldcount24 := le.Version3__propsoldcount24;
			 self.v3__propsoldcount36 := le.Version3__propsoldcount36;
			 self.v3__propsoldcount60 := le.Version3__propsoldcount60;
			 self.v3__watercraftcount := le.Version3__watercraftcount;
			 self.v3__watercraftcount01 := le.Version3__watercraftcount01;
			 self.v3__watercraftcount03 := le.Version3__watercraftcount03;
			 self.v3__watercraftcount06 := le.Version3__watercraftcount06;
			 self.v3__watercraftcount12 := le.Version3__watercraftcount12;
			 self.v3__watercraftcount24 := le.Version3__watercraftcount24;
			 self.v3__watercraftcount36 := le.Version3__watercraftcount36;
			 self.v3__watercraftcount60 := le.Version3__watercraftcount60;
			 self.v3__aircraftcount := le.Version3__aircraftcount;
			 self.v3__aircraftcount01 := le.Version3__aircraftcount01;
			 self.v3__aircraftcount03 := le.Version3__aircraftcount03;
			 self.v3__aircraftcount06 := le.Version3__aircraftcount06;
			 self.v3__aircraftcount12 := le.Version3__aircraftcount12;
			 self.v3__aircraftcount24 := le.Version3__aircraftcount24;
			 self.v3__aircraftcount36 := le.Version3__aircraftcount36;
			 self.v3__aircraftcount60 := le.Version3__aircraftcount60;
			 self.v3__derogcount := le.Version3__derogcount;
			 self.v3__felonycount := le.Version3__felonycount;
			 self.v3__felonycount01 := le.Version3__felonycount01;
			 self.v3__felonycount03 := le.Version3__felonycount03;
			 self.v3__felonycount06 := le.Version3__felonycount06;
			 self.v3__felonycount12 := le.Version3__felonycount12;
			 self.v3__felonycount24 := le.Version3__felonycount24;
			 self.v3__felonycount36 := le.Version3__felonycount36;
			 self.v3__felonycount60 := le.Version3__felonycount60;
			 self.v3__arrestcount := le.Version3__arrestcount;
			 self.v3__arrestcount01 := le.Version3__arrestcount01;
			 self.v3__arrestcount03 := le.Version3__arrestcount03;
			 self.v3__arrestcount06 := le.Version3__arrestcount06;
			 self.v3__arrestcount12 := le.Version3__arrestcount12;
			 self.v3__arrestcount24 := le.Version3__arrestcount24;
			 self.v3__arrestcount36 := le.Version3__arrestcount36;
			 self.v3__arrestcount60 := le.Version3__arrestcount60;
			 self.v3__liencount := le.Version3__liencount;
			 self.v3__lienfiledcount := le.Version3__lienfiledcount;
			 self.v3__lienfiledcount01 := le.Version3__lienfiledcount01;
			 self.v3__lienfiledcount03 := le.Version3__lienfiledcount03;
			 self.v3__lienfiledcount06 := le.Version3__lienfiledcount06;
			 self.v3__lienfiledcount12 := le.Version3__lienfiledcount12;
			 self.v3__lienfiledcount24 := le.Version3__lienfiledcount24;
			 self.v3__lienfiledcount36 := le.Version3__lienfiledcount36;
			 self.v3__lienfiledcount60 := le.Version3__lienfiledcount60;
			 self.v3__lienreleasedcount := le.Version3__lienreleasedcount;
			 self.v3__lienreleasedcount01 := le.Version3__lienreleasedcount01;
			 self.v3__lienreleasedcount03 := le.Version3__lienreleasedcount03;
			 self.v3__lienreleasedcount06 := le.Version3__lienreleasedcount06;
			 self.v3__lienreleasedcount12 := le.Version3__lienreleasedcount12;
			 self.v3__lienreleasedcount24 := le.Version3__lienreleasedcount24;
			 self.v3__lienreleasedcount36 := le.Version3__lienreleasedcount36;
			 self.v3__lienreleasedcount60 := le.Version3__lienreleasedcount60;
			 self.v3__bankruptcycount := le.Version3__bankruptcycount;
			 self.v3__bankruptcycount01 := le.Version3__bankruptcycount01;
			 self.v3__bankruptcycount03 := le.Version3__bankruptcycount03;
			 self.v3__bankruptcycount06 := le.Version3__bankruptcycount06;
			 self.v3__bankruptcycount12 := le.Version3__bankruptcycount12;
			 self.v3__bankruptcycount24 := le.Version3__bankruptcycount24;
			 self.v3__bankruptcycount36 := le.Version3__bankruptcycount36;
			 self.v3__bankruptcycount60 := le.Version3__bankruptcycount60;
			 self.v3__evictioncount := le.Version3__evictioncount;
			 self.v3__evictioncount01 := le.Version3__evictioncount01;
			 self.v3__evictioncount03 := le.Version3__evictioncount03;
			 self.v3__evictioncount06 := le.Version3__evictioncount06;
			 self.v3__evictioncount12 := le.Version3__evictioncount12;
			 self.v3__evictioncount24 := le.Version3__evictioncount24;
			 self.v3__evictioncount36 := le.Version3__evictioncount36;
			 self.v3__evictioncount60 := le.Version3__evictioncount60;
			 self.v3__nonderogcount := le.Version3__nonderogcount;
			 self.v3__nonderogcount01 := le.Version3__nonderogcount01;
			 self.v3__nonderogcount03 := le.Version3__nonderogcount03;
			 self.v3__nonderogcount06 := le.Version3__nonderogcount06;
			 self.v3__nonderogcount12 := le.Version3__nonderogcount12;
			 self.v3__nonderogcount24 := le.Version3__nonderogcount24;
			 self.v3__nonderogcount36 := le.Version3__nonderogcount36;
			 self.v3__nonderogcount60 := le.Version3__nonderogcount60;
			 self.v3__profliccount := le.Version3__profliccount;
			 self.v3__profliccount01 := le.Version3__profliccount01;
			 self.v3__profliccount03 := le.Version3__profliccount03;
			 self.v3__profliccount06 := le.Version3__profliccount06;
			 self.v3__profliccount12 := le.Version3__profliccount12;
			 self.v3__profliccount24 := le.Version3__profliccount24;
			 self.v3__profliccount36 := le.Version3__profliccount36;
			 self.v3__profliccount60 := le.Version3__profliccount60;
			 self.v3__proflicexpirecount01 := le.Version3__proflicexpirecount01;
			 self.v3__proflicexpirecount03 := le.Version3__proflicexpirecount03;
			 self.v3__proflicexpirecount06 := le.Version3__proflicexpirecount06;
			 self.v3__proflicexpirecount12 := le.Version3__proflicexpirecount12;
			 self.v3__proflicexpirecount24 := le.Version3__proflicexpirecount24;
			 self.v3__proflicexpirecount36 := le.Version3__proflicexpirecount36;
			 self.v3__proflicexpirecount60 := le.Version3__proflicexpirecount60;
			 self.v3__propnewestsalepurchaseindex := le.Version3__propnewestsalepurchaseindex;
			 self.v3__subprimesolicitedcount := le.Version3__subprimesolicitedcount;
			 self.v3__subprimesolicitedcount01 := le.Version3__subprimesolicitedcount01;
			 self.v3__subprimesolicitedcount03 := le.Version3__subprimesolicitedcount03;
			 self.v3__subprimesolicitedcount06 := le.Version3__subprimesolicitedcount06;
			 self.v3__subprimesolicitedcount12 := le.Version3__subprimesolicitedcount12;
			 self.v3__subprimesolicitedcount24 := le.Version3__subprimesolicitedcount24;
			 self.v3__subprimesolicitedcount36 := le.Version3__subprimesolicitedcount36;
			 self.v3__subprimesolicitedcount60 := le.Version3__subprimesolicitedcount60;
			 self.v3__derogseverityindex := le.Version3__derogseverityindex;
			 self.v3__derogage := le.Version3__derogage;
			 self.v3__felonyage := le.Version3__felonyage;
			 self.v3__arrestage := le.Version3__arrestage;
			 self.v3__lienfiledage := le.Version3__lienfiledage;
			 self.v3__lienreleasedage := le.Version3__lienreleasedage;
			 self.v3__bankruptcyage := le.Version3__bankruptcyage;
			 self.v3__bankruptcytype := le.Version3__bankruptcytype;
			 self.v3__evictionage := le.Version3__evictionage;
			 self.v3__proflicage := le.Version3__proflicage;
			 self.v3__proflictypecategory := le.Version3__proflictypecategory;
			 self.v3__prsearchcollectioncount := le.Version3__prsearchcollectioncount;
			 self.v3__prsearchcollectioncount01 := le.Version3__prsearchcollectioncount01;
			 self.v3__prsearchcollectioncount03 := le.Version3__prsearchcollectioncount03;
			 self.v3__prsearchcollectioncount06 := le.Version3__prsearchcollectioncount06;
			 self.v3__prsearchcollectioncount12 := le.Version3__prsearchcollectioncount12;
			 self.v3__prsearchcollectioncount24 := le.Version3__prsearchcollectioncount24;
			 self.v3__prsearchcollectioncount36 := le.Version3__prsearchcollectioncount36;
			 self.v3__prsearchcollectioncount60 := le.Version3__prsearchcollectioncount60;
			 self.v3__prsearchidvfraudcount := le.Version3__prsearchidvfraudcount;
			 self.v3__prsearchidvfraudcount01 := le.Version3__prsearchidvfraudcount01;
			 self.v3__prsearchidvfraudcount03 := le.Version3__prsearchidvfraudcount03;
			 self.v3__prsearchidvfraudcount06 := le.Version3__prsearchidvfraudcount06;
			 self.v3__prsearchidvfraudcount12 := le.Version3__prsearchidvfraudcount12;
			 self.v3__prsearchidvfraudcount24 := le.Version3__prsearchidvfraudcount24;
			 self.v3__prsearchidvfraudcount36 := le.Version3__prsearchidvfraudcount36;
			 self.v3__prsearchidvfraudcount60 := le.Version3__prsearchidvfraudcount60;
			 self.v3__prsearchothercount := le.Version3__prsearchothercount;
			 self.v3__prsearchothercount01 := le.Version3__prsearchothercount01;
			 self.v3__prsearchothercount03 := le.Version3__prsearchothercount03;
			 self.v3__prsearchothercount06 := le.Version3__prsearchothercount06;
			 self.v3__prsearchothercount12 := le.Version3__prsearchothercount12;
			 self.v3__prsearchothercount24 := le.Version3__prsearchothercount24;
			 self.v3__prsearchothercount36 := le.Version3__prsearchothercount36;
			 self.v3__prsearchothercount60 := le.Version3__prsearchothercount60;
			 self.v3__inputphonestatus := le.Version3__inputphonestatus;
			 self.v3__inputphonepager := le.Version3__inputphonepager;
			 self.v3__inputphonemobile := le.Version3__inputphonemobile;
			 self.v3__inputphonetype := le.Version3__inputphonetype;
			 self.v3__inputareacodechange := le.Version3__inputareacodechange;
			 self.v3__phoneotherageoldestrecord := le.Version3__phoneotherageoldestrecord;
			 self.v3__phoneotheragenewestrecord := le.Version3__phoneotheragenewestrecord;
			 self.v3__invalidphonezip := le.Version3__invalidphonezip;
			 self.v3__inputaddrvalidation := le.Version3__inputaddrvalidation;
			 self.v3__inputaddrhighrisk := le.Version3__inputaddrhighrisk;
			 self.v3__inputphonehighrisk := le.Version3__inputphonehighrisk;
			 self.v3__inputaddrprison := le.Version3__inputaddrprison;
			 self.v3__curraddrprison := le.Version3__curraddrprison;
			 self.v3__prevaddrprison := le.Version3__prevaddrprison;
			 self.v3__historicaladdrprison := le.Version3__historicaladdrprison;
			 self.v3__inputzippobox := le.Version3__inputzippobox;
			 self.v3__inputzipcorpmil := le.Version3__inputzipcorpmil;
			 self.did := (integer)le.did;
			 self := le;
			 self := [];
		END;

		ds_slim := PROJECT(Soap_output, v3_trans(LEFT,counter));
		
// output(ds_slim);
		// calling IID macro to capture DID for appending to final output
		// did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate);


		//**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS ***************************

		// Global_output_lay did_append(did_results l, ds_slim r) := TRANSFORM
																												   // self.did := l.did;
																												   // self := r;
																												   // self:=[];
																											     // END;
      
		// res := JOIN(did_results,ds_slim, left.acctno = right.acctno, did_append(left, right),right outer);

    //Appeding additional internal extras to Soap output file
    ds_with_extras := JOIN(ds_slim, soap_in, left.acctno =right.batch_in[1].acctno,
   											TRANSFORM(Global_output_lay,
																	self.did := left.did;
   														   	self.historydate:=(string)right.batch_in[1].historydateyyyymm;
   																self.fnamepop:=right.batch_in[1].name_first<>'';
   																self.lnamepop:= right.batch_in[1].name_last<>'';
   																self.addrpop:= right.batch_in[1].street_addr<>'';
   																self.ssnlength:= (string)(length(trim(right.batch_in[1].ssn))) ;
   																self.dobpop:= right.batch_in[1].dob<>'';
   																self.hphnpop:= right.batch_in[1].home_phone<>'';
   																self := left;
   																self := []
   																));

		//final file out to thor							
		final_output := output(ds_with_extras, , outfile_name, thor, compressed, overwrite);
		
		RETURN final_output;

ENDMACRO;