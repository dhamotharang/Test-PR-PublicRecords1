EXPORT Chase_BIID_BATCH_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT models, Risk_Indicators, Business_Risk, ut, riskwise, scoring;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		gateways := Gateway;
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
		Gateway := DATASET([], Gateway.Layouts.Config);


		//*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.BIID_BATCH_Chase_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.BIID_BATCH_Chase_settings.GLB;
		DRM:=Scoring_Project_PIP.User_Settings_Module.BIID_BATCH_Chase_settings.DRM;
		HISTORYDATE := 999999;
			
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	
		 
		layout_input:=Record
				Scoring_Project_Macros.Regression.global_layout;
				Scoring_Project_Macros.Regression.pii_layout;
				Scoring_Project_Macros.Regression.bus_layout;
				Scoring_Project_Macros.Regression.runtime_layout;
		END;
						
		ds_raw_input := distribute(IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records)),(integer)accountnumber);
								
    //*********** CHASE BUSINESSINSTANTID BATCH SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			DATASET(Business_Risk.Layout_Input_Moxie_2) batch_in;
			boolean hb := false;
			integer glb;
			integer dppa;
			boolean IncludeFraudScores := true;
			boolean IsPOBoxCompliant := false;
			boolean ofac_only := false;
			boolean ExcludeWatchLists := false;
			unsigned1 OFAC_version :=2;
			boolean Include_Additional_watchlists := true;
			boolean Include_Ofac := true;
			real Global_WatchList_Threshold :=.84;
			boolean use_dob_filter := FALSE;
			integer2 dob_radius := 2;
			string  model_name_value := '';
			boolean IncludeTargus3220 := true ;
			boolean IncludeMSoverride:= FALSE;
			boolean IncludeDLVerification:= FALSE;
			string AttributesVersionRequest:= 'BIIDATTRIBUTESV1';
			boolean Include_ALL_Watchlist:= FALSE;
			boolean Include_BES_Watchlist:= FALSE;
			boolean Include_CFTC_Watchlist:= FALSE;
			boolean Include_DTC_Watchlist:= FALSE;
			boolean Include_EUDT_Watchlist:= FALSE;
			boolean Include_FBI_Watchlist:= FALSE;
			boolean Include_FCEN_Watchlist:= FALSE;
			boolean Include_FAR_Watchlist:= FALSE;
			boolean Include_IMW_Watchlist:= FALSE;
			boolean Include_OFAC_Watchlist:= FALSE;
			boolean Include_OCC_Watchlist:= FALSE;
			boolean Include_OSFI_Watchlist:= FALSE;
			boolean Include_PEP_Watchlist:= FALSE;
			boolean Include_SDT_Watchlist:= FALSE;
			boolean Include_BIS_Watchlist:= FALSE;
			boolean Include_UNNT_Watchlist:= FALSE;
			boolean Include_WBIF_Watchlist:= FALSE;
		END;

		Business_Risk.Layout_Input_Moxie_2 make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.acctno := (string)le.accountnumber;
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
		end;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			self.dppa := (integer)DPPA;
			self.glb := (integer)GLB;
			self.includefraudscores := true;
		END;

    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
	
		//Soap output layout
		layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 			
			string errorcode := '';
			business_risk.Layout_Final_Denorm; 
			string3 fd_score1;
			string3 fd_score2;
			string3 fd_score3;
			string4	fd_Reason1;
			string100	fd_Desc1;
			string4	fd_Reason2;
			string100	fd_Desc2;
			string4	fd_Reason3;
			string100	fd_Desc3;
			string4	fd_Reason4;
			string100	fd_Desc4;
			DATASET(Models.Layout_Model) models;
			string1 rep_lien_unrel_lvl := ''; 
			string1 rep_prop_owner := ''; 
			string2 rep_prof_license_category := ''; 
			string1 rep_accident_count := ''; 
			string1 rep_paydayloan_flag := ''; 
			string2 rep_age_lvl := ''; 
			string1 rep_bankruptcy_count := ''; 
			string1 rep_ssns_per_adl := ''; 
			string1 rep_past_arrest := ''; 
			string3 rep_add1_lres_lvl := ''; 
			string1 rep_criminal_assoc_lvl := ''; 
			string1 rep_felony_count := '';
		END;

		layout_Soap_output myfail(soap_in L) := transform
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.account:=l.batch_in[1].acctno;
			self := L;
			self := [];
		end;

    //*********** PERFORMING SOAPCALL TO ROXIE ************ 

		Soap_output := soapcall(soap_in, roxieIP,
						'Business_Risk.InstantID_Batch_Service', {soap_in},
						dataset(layout_Soap_output), RETRY(retry), TIMEOUT(timeout),
						PARALLEL(threads), onfail(myfail(LEFT)));
						
						
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
			
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_CHASE_BusinessInstantId_Global_Layout;			 
		END;

		ds_slim := PROJECT(Soap_output,TRANSFORM(Global_output_lay,self.bnap:=left.bnap_indicator;
																								 self.bnas:=left.bnas_indicator;
																								 self.bnat:=left.bnat_indicator;
																								 self.acctno:=left.account;
																								 SELF := LEFT;
																								 SELF := [];
							                               ));


		// calling IID macro to capture DID for appending to final output  
		did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate);
					
												
		//**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 		 
					
		Global_output_lay did_append(did_results l, ds_slim r) := TRANSFORM
																																self.did := l.did;
																																self := r;
		                                                          END;
					
		res := JOIN(did_results, ds_slim, left.acctno =right.acctno, did_append(left, right),right outer);
					
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
		final_output := output(ds_with_extras,,outfile_name, thor, compressed, OVERWRITE);

		RETURN final_output;

ENDMACRO;