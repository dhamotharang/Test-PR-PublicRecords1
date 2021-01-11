EXPORT Chase_CBBL_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT riskwise, Scoring, risk_indicators, ut;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		Gateway := DATASET([], Gateway.Layouts.Config);
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;

		//*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.CBBL_Scores_XML_Chase_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.CBBL_Scores_XML_Chase_settings.GLB;
		DRM:=Scoring_Project_PIP.User_Settings_Module.CBBL_Scores_XML_Chase_settings.DRM;
		DPM:=Scoring_Project_PIP.User_Settings_Module.CBBL_Scores_XML_Chase_settings.DPM;
		HISTORYDATE := 999999;
			
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.bus_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := distribute(IF(no_of_records = 0, dataset( Infile_name, layout_input,  thor), ChooseN(dataset( infile_name, layout_input,  thor), no_of_records)),(integer)accountnumber);
		
		//*********** CHASE CBBL XML SETUP AND SOAPCALL ******************

		sghatti.Layout_BC1O_soapcall into_BC1O_input(ds_raw_input le) := transform
			self.acctno := (string)le.accountnumber;	
			self.account := (string)le.accountnumber;	
			self.first := le.firstname;
			self.last := le.lastname;
			self.addr := le.streetaddress;
			self.city:= le.city;
			self.state := le.state;
			self.zip := le.zip;
			self.hphone := le.homephone;
			self.socs := le.ssn;
			self.dob := le.dateofbirth;
			self.HistoryDateYYYYMM := HistoryDate;
			self.cmpy := le.name_company;
			self.cmpyaddr := le.street_addr2;
			self.cmpycity := le.p_city_name_2;
			self.cmpystate := le.st_2;
			self.cmpyzip := le.z5_2;
			self.cmpyphone := le.phoneno;
			self.fin := le.fein;
			self.tribcode := 'cbbl';  
			self.dppapurpose := DPPA;
			self.glbpurpose := GLB;
			self.DataRestrictionMask := DRM; 
			self.DataPermissionMask := DPM; 
			self := le;
			self := [];
		end;

    //ds_soap_in
		soap_in := DISTRIBUTE(project(ds_raw_input,into_BC1O_input(LEFT)), Random());

	  //Soap output layout		
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_CBBL_Global_Layout;			 
		END;

		Global_output_lay myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.acctNo:=le.acctNo;
			SELF := le;
			SELF := [];
		END;
		
		//*********** PERFORMING SOAPCALL TO ROXIE ************ 

		Soap_output := SOAPCALL(soap_in, roxieIP,
						'RiskWise.RiskWiseMainBC1O', {soap_in}, 
						DATASET(Global_output_lay),
						RETRY(retry), TIMEOUT(timeout), LITERAL,
						XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
						PARALLEL(threads), onFail(myFail(LEFT)));


		ds_slim := project(Soap_output, transform(recordof(Soap_output),
								 self.acctno := left.account,
	   						 self := left));
		
		// calling IID macro to capture DID for appending to final output 	 
					
		Risk_Indicators.layout_input into_did_input(ds_raw_input le) := TRANSFORM
						self.seq := (integer)le.accountnumber;
						
						self.fname := le.firstname;
						self.mname := le.middlename;
						self.lname := le.lastname;
						self.in_streetaddress := le.streetaddress;
						self.in_city := le.city;
						self.in_state := le.state;
						self.in_zipcode := le.zip;
						self.phone10 := le.homephone;
						self.ssn := le.ssn;
						self.dob := le.dateofbirth;
						self.wphone10 := le.workphone;
						self.dl_number := le.dlnumber;
						self.dl_state := le.dlstate;
						self.email_address := le.email;
						self.employer_name := le.company;
						SELF := [];
					END;
							
	  did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate); 
					
		//**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 		
		
		Global_output_lay did_append(did_results l, ds_slim r) := TRANSFORM
					self.did := l.did;
					// self.errorcode:=r.errorcode;
					self := r;
		END;
					
		res := JOIN(did_results, ds_slim, left.acctno = right.acctno, did_append(left, right),right outer);
	
	  //Appeding additional internal extras to Soap output file 				
		Global_output_lay internal_extras_append(res l, soap_in r) := TRANSFORM
							self.DID := l.did; 
							// self.errorcode:=l.errorcode;
							self.historydate := (string)r.HistoryDateYYYYMM;
							self.FNamePop := r.first<>'';
							self.LNamePop := r.last<>'';
							self.AddrPop := r.addr<>'';
							self.SSNLength := (string)(length(trim(r.socs,left,right))) ;
							self.DOBPop := r.dob<>'';
							self.EmailPop := r.emailaddr<>'';
							self.IPAddrPop := r.ipaddr<>'';
							self.HPhnPop := r.hphone<>'';
							self := l;
						  self := [];
					END;
						
		ds_with_extras:=join(res,soap_in,left.acctno=(string)right.acctno ,internal_extras_append(left, right));	
			 
    //final file out to thor
		output(ds_with_extras,,outfile_name, thor, compressed, OVERWRITE);
    output(ds_with_extras,,outfile_name +'_CSV_copy', CSV(heading(single), quote('"')), overwrite,expire(14));
				
		RETURN 0;

ENDMACRO;