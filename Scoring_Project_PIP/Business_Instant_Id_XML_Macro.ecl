EXPORT Business_Instant_Id_XML_Macro(roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT models, Risk_Indicators, Business_Risk, ut, riskwise;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name;
		Gateway := DATASET([], Gateway.Layouts.Config);

		//*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.BIID_XML_Generic_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.BIID_XML_Generic_settings.GLB;
		DRM:=Scoring_Project_PIP.User_Settings_Module.BIID_XML_Generic_settings.DRM;
    HISTORYDATE := 999999;
			
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************
									
		layout_input:=RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.bus_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		  END;

		ds_raw_input := distribute(IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor) ,
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records)),(integer)accountnumber);

    //*********** BUSINESSINSTANTID XML SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			String30 accountnumber;
			string HistoryDateYYYYMM;
			string GLBPurpose;
			string DPPAPurpose;
			string DataRestrictionMask;
			string businessphone;
			string addr;
			string city;
			string companyname;
			string state;
			string taxidnumber;
			string zip;
			string representativedob;
			string representativefirstname;
			string representativehomephone;
			string representativelastname;
			string representativessn;
			string representativestate;
			string representativezip;
		END;

		//ds_soap_in
		soap_in := Distribute(project(ds_raw_input, TRANSFORM(layout_soap_input,
		                                               self.accountnumber := (string)left.accountnumber;																									 
																									 self.HistoryDateYYYYMM := (string)HistoryDate;
																									 self.DPPAPurpose := (string)DPPA;
																									 self.GLBPurpose := (string)GLB;	
																									 self.DataRestrictionMask := DRM;	
																									 self.businessphone := left.phoneno;
																									 self.addr := left.street_addr2;
																									 self.city := left.p_city_name_2;
																									 self.companyname := left.name_company;
																									 self.state := left.st_2;
																									 self.zip := left.z5_2;
																									 self.taxidnumber:=left.fein;
																									 self.representativedob := left.dateofbirth;
																									 self.representativefirstname := left.firstname;
																									 self.representativehomephone := left.homephone;
																									 self.representativelastname := left.lastname;
																									 self.representativessn := left.ssn;
																									 self.representativestate := left.state;
																									 self.representativezip := left.zip;
																		)), Random());

    //Soap output layout
	  layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 			
			string errorcode := '';
				business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
				DATASET(Models.Layout_Model) models;
			 END;
			 
	  layout_Soap_output myFail(soap_in L) := TRANSFORM
				SELF.errorcode := FAILCODE + FAILMESSAGE;
				self.account:=L.accountnumber;
				self.company_name := L.companyname;
				self.addr1 := L.addr;
				self.p_city_name := L.city;
				self.st := L.state;
				self.z5 := L.zip;
				self.phone10 := L.businessphone;
				self := L;
				self := [];
			 END;

    //******* Performing Soapcall to Roxie *************************************
		Soap_output := soapcall(soap_in, roxieIP,
						'Business_Risk.InstantID_Service', {soap_in},
						dataset(layout_Soap_output), 
						RETRY(retry), TIMEOUT(timeout), LITERAL,
						XPATH('Business_Risk.InstantID_ServiceResponse/Results/Result/Dataset[@name=\'Result 1\']/Row'),
						PARALLEL(threads), onfail(myFail(LEFT)));
						

    // ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************

		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout;			 
		END;

		ds_slim := PROJECT(Soap_output,TRANSFORM(Global_output_lay,self.bnap:=left.bnap_indicator;
																								 self.bnas:=left.bnas_indicator;
																								 self.bnat:=left.bnat_indicator;
																								 self.acctno:=left.account;
																								 SELF :=LEFT;
																								 SELF:=[];
																								 ));
							
		// calling IID macro to capture DID for appending to final output			
	  did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate);
						 
	  //**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS ***************************
		
		Global_output_lay did_append(did_results l, ds_slim r) := TRANSFORM
						 self.did := l.did;
						 self := r;
						 end;
						 
		res := JOIN(did_results, ds_slim, left.acctno = right.acctno, did_append(left, right),right outer);
		
		//Appeding additional internal extras to Soap output file		
		Global_output_lay internal_extras_append(res l, soap_in r) := TRANSFORM
								self.DID := l.did; 
								self.historydate := (string)r.HistoryDateYYYYMM;
								self.FNamePop := r.representativefirstname<>'';
								self.LNamePop := r.representativelastname<>'';
								self.AddrPop := r.addr<>'';
								self.SSNLength := (string)(length(trim(r.representativessn,left,right))) ;
								self.DOBPop := r.representativedob<>'';
								self.HPhnPop := r.representativehomephone<>'';
								self := l;
							  self := [];
							END;
							
		ds_with_extras:=join(res,soap_in,left.acctno=(string)right.accountnumber ,internal_extras_append(left, right));	

		//final file out to thor
		final_output := output(ds_with_extras,, outfile_name,thor,compressed, OVERWRITE);

		RETURN final_output;
		
ENDMACRO;