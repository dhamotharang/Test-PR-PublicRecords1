EXPORT RV_Scores_Attributes_V4_BATCH_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name1_score, Output_file_name2_attr, records_ToRun):= FUNCTIONMACRO
IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP ;
		Infile_name :=  Input_file_name;
		String outfile_name1 :=  Output_file_name1_score ;
		String outfile_name2 :=  Output_file_name2_attr ;


		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V4_BATCH_Generic_settings.DRM;
		IncludeVersion4:=Scoring_Project_PIP.User_Settings_Module.RV_Scores_V4_BATCH_Generic_settings.IncludeVersion4;
		HistoryDate := 999999;


		// PCG_Dev := 'http://delta_dempers_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		PCG_Cert := 'http://ln_api_dempsey_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		integer FFD := 1;
		
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;
		 
	   ds_raw_input := distribute(IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records)),(integer)accountnumber);
										
    //*********** RV Scores V4 BATCH SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
			STRING DataRestrictionMask;
			boolean IncludeVersion4;
			boolean IncludeAllScores;
			string FFDOptionsMask ;
			integer FlagshipVersion;

		END;

		Risk_Indicators.Layout_Batch_In make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.seq := c;
			SELF.acctno := (string)le.accountnumber;
			SELF.Name_First := le.FirstName;
			SELF.Name_Middle := le.MiddleName;
			SELF.Name_Last := le.LastName;
			SELF.street_addr := le.StreetAddress;
			SELF.p_City_name := le.CITY;
			SELF.St := le.STATE;
			SELF.z5 := le.ZIP;
			SELF.Home_Phone := le.HomePhone;
			SELF.SSN := le.SSN;
			SELF.DOB := le.DateOfBirth;
			SELF.Work_Phone := le.WorkPhone;
			self.historydateyyyymm := HistoryDate ;
			SELF := le;
			SELF := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			// SELF.gateways := DATASET([{'neutralroxie', neutralroxieIP}], risk_indicators.layout_gateways_in);
			SELF.Gateways := DATASET([{'neutralroxie', NeutralRoxieIP}, // TransUnion Gateway
								{'delta_personcontext', PCG_Cert}], Risk_Indicators.Layout_Gateways_In);
			self.IncludeVersion4 := IncludeVersion4;
			self.IncludeAllScores := true;
			SELF.DataRestrictionMask := DRM;
			SELF.FlagshipVersion := 4;
			self.FFDOptionsMask := (string)FFD;

			self := [];
		END;
			
	  //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
		//Soap output layout
		layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
		
		models.Layout_RiskView_Batch_Out;
			string200 errorcode;
		END;
					 
		layout_Soap_output myfail(soap_in L) := transform
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.acctno := l.batch_in[1].acctno;
			self := [];
		end;

    //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		Soap_output := soapcall(soap_in, fcraroxieIP ,
												'models.RiskView_Batch_Service', 
												{soap_in},
												dataset(layout_Soap_output), 
												RETRY(retry), TIMEOUT(timeout),
												XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
												parallel(threads) ,
												onfail(myfail(LEFT)));

layout_Soap_output trans_rollup(layout_Soap_output l, layout_Soap_output r) := transform
	self.Did := r.Did;

	self := l;
End;
					
soap_output_withDID := rollup(soap_output, ((integer)left.acctno = (integer)right.acctno and left.acctno <>''), trans_rollup(left,right));				

		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout;			 
		END;

    //Appeding additional internal extras to Soap output file 
		//Mapping Version4 scores and reason codes
		rv_scores_v4 := join(soap_output_withDID, soap_in  , 
												 left.acctno = (string)right.batch_in[1].acctno,			
			                       TRANSFORM(Global_output_lay, 
														 self.time_ms := left.time_ms;  

			                         	self.acctno := left.acctno;		
																self.rv_score_auto :=  left.score1  ;
																self.rv_auto_reason :=  left.reason1  ;
																self.rv_auto_reason2 :=  left.reason2  ;
																self.rv_auto_reason3 :=  left.reason3  ;
																self.rv_auto_reason4 :=  left.reason4  ;
																self.rv_auto_reason5 :=  left.reason21  ;
																self.rv_score_bank :=  left.score2  ;
																self.rv_bank_reason :=  left.reason5  ;
																self.rv_bank_reason2 :=  left.reason6  ;
																self.rv_bank_reason3 :=  left.reason7  ;
																self.rv_bank_reason4 :=  left.reason8  ;
																self.rv_bank_reason5 :=  left.reason22  ;
																self.rv_score_retail :=  left.score3  ;
																self.rv_retail_reason :=  left.reason9  ;
																self.rv_retail_reason2 :=  left.reason10  ;
																self.rv_retail_reason3 :=  left.reason11  ;
																self.rv_retail_reason4 :=  left.reason12  ;
																self.rv_retail_reason5 :=  left.reason23  ;
																self.rv_score_telecom :=  left.score4  ;
																self.rv_telecom_reason :=  left.reason13  ;
																self.rv_telecom_reason2 :=  left.reason14  ;
																self.rv_telecom_reason3 :=  left.reason15  ;
																self.rv_telecom_reason4 :=  left.reason16  ;
																self.rv_telecom_reason5 :=  left.reason24  ;
																self.rv_score_money :=  left.score5  ;
																self.rv_money_reason :=  left.reason17  ;
																self.rv_money_reason2 :=  left.reason18  ;
																self.rv_money_reason3 :=  left.reason19  ;
																self.rv_money_reason4 :=  left.reason20  ;
																self.rv_money_reason5 :=  left.reason25  ;
																self.rv_score_prescreen :='';
																self.rv_prescreen_reason :='';
																self.DID := (integer) left.did; 
																self.historydate := (string)right.batch_in[1].HistoryDateYYYYMM;
																self.FNamePop := right.batch_in[1].Name_First<>'';
																self.LNamePop := right.batch_in[1].Name_Last<>'';
																self.AddrPop := right.batch_in[1].street_addr<>'';
																self.SSNLength := (string)(length(trim(right.batch_in[1].ssn,left,right))) ;
																self.DOBPop := right.batch_in[1].dob<>'';				
																self.IPAddrPop := right.batch_in[1].ip_addr<>''; 					
																self.HPhnPop := right.batch_in[1].Home_Phone<>'';
																self := left;
																self:=[];
				                     ));			
														 
		Global_output_lay2:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Generic_Attributes_V4_Global_Layout;			 
		END;

		//Appeding additional internal extras to Soap output file 
		Global_output_lay2 normit(soap_output_withDID L, soap_in R) := transform
			SELF.accountnumber :=(string) R.batch_in[1].acctno;
			self.DID := (integer)l.did; 
			self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
			self.FNamePop := r.batch_in[1].Name_First<>'';
			self.LNamePop := r.batch_in[1].Name_Last<>'';
			self.AddrPop := r.batch_in[1].street_addr<>'';
			self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
			self.DOBPop := r.batch_in[1].dob<>'';
			self.IPAddrPop := r.batch_in[1].ip_addr<>'';
			self.HPhnPop := r.batch_in[1].Home_Phone<>'';
		  self := L;
			self := [];
		END;
			 
		ds_with_extras2 := JOIN(soap_output_withDID,soap_in,LEFT.Acctno=(string)RIGHT.batch_in[1].acctno,normit(LEFT,RIGHT));

		//scores
				 output(rv_scores_v4 ,,outfile_name1, thor, compressed, overwrite);
//attributes
		output(ds_with_extras2 ,,outfile_name2, thor, compressed, overwrite);
		
		 // output(soap_output_withDID,named('Soap_output'));
		// output(soap_in,named('soap_in'));
return 0;
endmacro;
		 
