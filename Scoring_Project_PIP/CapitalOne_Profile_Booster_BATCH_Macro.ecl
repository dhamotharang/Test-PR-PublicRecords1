EXPORT CapitalOne_Profile_Booster_BATCH_Macro (roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing, Scoring, ProfileBooster, Scoring_Project_Macros;

		unsigned8 no_of_records := records_ToRun;
		integer retry := Retry;
		integer timeout := Timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		gateways := Gateway;
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;

		// String roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; ; 
		// String Infile_name :=  '~bbraaten::in::test_ProfileBooster_capone';
		// String outfile_name := '~bbraaten::out::test::Profilebooster_20160909' ;


		//*********** SETTINGS ********************************


		DataRestrictionMask := scoring_project_pip.User_Settings_Module.Profile_Booster_Capital_One.DRM;  
		DataPermissionMask := scoring_project_pip.User_Settings_Module.Profile_Booster_Capital_One.DPM;
		HISTORYDATE := 999999;
		AttributesVersionRequest := scoring_project_pip.User_Settings_Module.Profile_Booster_Capital_One.AttributesVersionRequest;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************
		
layout_input := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;

    ds_raw_input := distribute(IF(no_of_records > 0, CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records),
                            DATASET( infile_name, layout_input, thor)),(integer)accountnumber);
														

wseq_layout := RECORD
 layout_input input; 
 string30 old_account ;
END;

wseq_layout getSeq(ds_raw_input le, INTEGER c) := TRANSFORM
  self.old_account   				:= (string)le.AccountNumber;
  self.input.AccountNumber 	:= c;
	self.input							 	:= le;
end;

wseq := project(ds_raw_input, getSeq(left, counter));

PB_input_batch := record
	dataset(ProfileBooster.Layouts.Layout_PB_In) batch_in;
	unsigned1 DPPAPurpose      					:= 0;		//does not apply
	unsigned1 GLBPurpose       					:= 0;		//does not apply
	string5		IndustryClass							:= '';
	string50 	DataRestrictionMask       := DataRestrictionMask;
	string9   AttributesVersionRequest	:= AttributesVersionRequest;
	string50 	DataPermissionMask       	:= DataPermissionMask;
END;


PB_input_batch inputTForm(wseq le, INTEGER c) := TRANSFORM
	r2 := project(ut.ds_oneRecord, transform(ProfileBooster.Layouts.Layout_PB_In, 
  self.AcctNo  	     := (string)le.input.AccountNumber;
  self.seq        	 := c;
	self.name_full    := le.input.FirstName ;
	// self.Name_Middle   := le.input.MiddleName; 
	// self.Name_Last     := le.input.LastName ; 
	self.Name_Suffix   := ''; 
	self.ssn           := le.input.SSN;
	self.dob           := le.input.DateOfBirth;
	self.phone10       := le.input.HomePhone;
	self.street_addr   := le.input.StreetAddress; 
	self.City_name     := le.input.City;
	self.st            := le.input.State;
	self.z5            := le.input.Zip;
	self.historydate   := (integer)le.input.historydateyyyymm;  //to run in archive mode
	// self.historydate   := 999999;	//to run in current mode
	self					     := []));	//to run in current mode
	SELF.batch_in := r2;
end;

soap_in := distribute(project(wseq, inputTForm(left, counter)));

newsoap := soap_in;


xlayout := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
	
	ProfileBooster.Layouts.Layout_PB_BatchOutFlat;
	STRING errorcode;
END;

xlayout myFail(soap_in le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

PBResults := soapcall(newsoap, roxieIP,
				'ProfileBooster.Batch_Service', 
				{newsoap}, 
				DATASET(xlayout),
				PARALLEL(threads), 
				onFail(myFail(LEFT)));
	

finalLayout := RECORD
Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout
END;

finalLayout getFile_Ind(PBResults le, wseq ri) := TRANSFORM
		SELF.seq 					:= (integer)ri.input.accountnumber;
		SELF.AcctNo 			:= ri.old_account;
		SELF							:= le;
end;

finalResults := join(PBResults, wseq,
										 (integer)left.AcctNo = (integer)right.input.accountnumber,
										 getFile_Ind(left, right), left outer);

		final_output := output(finalResults, , outfile_name, thor, compressed, overwrite);
	RETURN final_output;

ENDMACRO;