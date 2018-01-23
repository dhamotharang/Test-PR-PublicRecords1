EXPORT Business_Instant_Id_Batch_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT models, Risk_Indicators, Business_Risk, ut, riskwise;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
	  Gateway := DATASET([], Gateway.Layouts.Config);
		
		//*********** SETTINGS ********************************

			DPPA:= scoring_project_pip.User_Settings_Module.BIID_BATCH_Generic_settings.DPPA;
			GLB:= scoring_project_pip.User_Settings_Module.BIID_BATCH_Generic_settings.GLB;
			DRM:= scoring_project_pip.User_Settings_Module.BIID_BATCH_Generic_settings.DRM;
      HISTORYDATE := 999999;
			
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	
	
		layout_input:=Record
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.bus_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		End;
										
		ds_raw_input := IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records));
	
    //*********** BUSINESSINSTANTID BATCH SETUP AND SOAPCALL ******************
		
		layout_soap_input := RECORD
			DATASET(Business_Risk.Layout_Input_Moxie_2) batch_in;
			STRING dppapurpose;
			String GLBPurpose;
		END;

		Business_Risk.Layout_Input_Moxie_2 make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.acctno :=(string) le.AccountNumber;
			self.name_company := le.name_company;
			self.street_addr := le.street_addr2;
			self.p_city_name := le.p_city_name_2;
			self.st := le.st_2;
			self.z5 := le.z5_2;
			self.phoneno := le.phoneno;
			self.fein := le.fein;
			self.name_first := le.firstname;
			self.name_last := le.lastname;
			self.street_addr2 := le.streetaddress;
			self.p_city_name_2 := le.city;
			self.st_2 := le.state;
			self.z5_2 := le.zip;
			self.ssn := le.ssn;
			self.dob := le.dateofbirth;
			self.phone_2 := le.homephone;
			self.HistoryDateYYYYMM := HistoryDate;
			self := le;
			self := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			self.dppapurpose :=(string)DPPA;
			self.GLBPurpose := (string)GLB;
			END;
			
    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
		//Soap output layout
    layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 			
			string errorcode := '';
			business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;  
			DATASET(Models.Layout_Model) models;
		END;

		layout_Soap_output myFail(soap_in L) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.account:=l.batch_in[1].acctno;
			self := L;
			self := [];
		END;

    //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		Soap_output := soapcall(soap_in, roxieIP,
						'Business_Risk.InstantID_Batch_Service', {soap_in},
						dataset(layout_Soap_output), RETRY(retry), TIMEOUT(timeout),
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
																								 SELF :=[];
																								 ));
			 
	  // calling IID macro to capture DID for appending to final output 		
	  did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate);  
	
	  //**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 
					 
		Global_output_lay did_append(did_results l, ds_slim r) := TRANSFORM
		  self.did := l.did;
		  self := r;
		  END;
		 
		res := JOIN(did_results, ds_slim, left.acctno = right.acctno, did_append(left, right),right outer);
		
		//Appeding additional internal extras to Soap output file 
		Global_output_lay internal_extras_append(res l, soap_in r) := TRANSFORM
												self.DID := l.did; 
												self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
												self.FNamePop := r.batch_in[1].Name_First<>'';
												self.LNamePop := r.batch_in[1].Name_Last<>'';
												self.AddrPop := r.batch_in[1].street_addr<>'';
												self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
												self.DOBPop := r.batch_in[1].dob<>'';
												self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
												self.HPhnPop := r.batch_in[1].phone_2<>'';
									      self := l;
			                  self := [];
			                  END;
			
	  ds_with_extras:=join(res,soap_in,left.acctno=(string)right.batch_in[1].acctno ,internal_extras_append(left, right));

	  //final file out to thor
		final_output := output(ds_with_extras,, outfile_name, thor,compressed, OVERWRITE);

		RETURN final_output;

ENDMACRO;