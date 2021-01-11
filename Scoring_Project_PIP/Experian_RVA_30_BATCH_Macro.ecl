EXPORT Experian_RVA_30_BATCH_Macro(fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP; 
		String fcraroxieIP := fcraroxie_IP;
		Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name;
		archive_date := (integer)ut.getdate ;

		//*********** SETTINGS ********************************

		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Experian_settings.DRM;
		IncludeVersion3:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Experian_settings.IncludeVersion3;
		HistoryDate := 999999;
		// PCG_Dev := 'http://delta_dempers_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		PCG_Cert := 'http://ln_api_dempsey_dev:g0n0l3s!@10.176.68.149:7720/WsSupport/?ver_=2.0'; //-- testing on DEV servers
		integer FFD := 1;
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

		layout_input:=Record
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		End;

		ds_raw_input := distribute(IF(no_of_records <= 0, dataset( infile_name, layout_input, thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records)),(integer)accountnumber);
																
																
    //*********** Experian RV V3 BATCH SETUP AND SOAPCALL ******************
		
		layout_soap_input := RECORD
			DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
			STRING DataRestrictionMask;
			boolean IncludeVersion3;
			string FFDOptionsMask ;
		END;

		Risk_Indicators.Layout_Batch_In make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.seq := c;
			self.acctno :=(string) le.accountnumber;
			self.name_first := le.firstname;
			self.name_middle := le.middlename;
			self.name_last := le.lastname;
			self.street_addr := le.streetaddress;
			self.p_city_name := le.city;
			self.st := le.state;
			self.z5 := le.zip;
			self.home_phone := le.homephone;
			self.ssn := le.ssn;
			self.dob := le.dateofbirth;
			self.work_phone := le.workphone;
			self.historydateyyyymm := historydate ;
			self := le;
			self := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			self.batch_in := batch;
			// SELF.gateways := DATASET([{'neutralroxie', neutralroxieIP}], risk_indicators.layout_gateways_in);
			SELF.Gateways := DATASET([{'neutralroxie', NeutralRoxieIP}, // TransUnion Gateway
						{'delta_personcontext', PCG_Cert}], Risk_Indicators.Layout_Gateways_In);
			// self.isprescreen := isprescreen;		
			self.includeversion3 := includeversion3;
			self.FFDOptionsMask := (string)FFD;

			self.datarestrictionmask := drm;
		END;
					
		 //ds_soap_in
		 soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), RANDOM());
	
	  //Soap output layout
		layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
			
			models.Layout_RiskView_Batch_Out;
			string200 errorcode;
		END;
					 
		layout_Soap_output myfail(soap_in L) := transform
			// self.time_ms := l.time_ms;  
		
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
												
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
		
layout_Soap_output trans_rollup(layout_Soap_output l, layout_Soap_output r) := transform
	self.Did := r.Did;

	self := l;
End;
					
soap_output_withDID := rollup(soap_output, ((integer)left.acctno = (integer)right.acctno and left.acctno <>''), trans_rollup(left,right));				
		
		
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout;			 
		END;

		 //**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 
		 
		Global_output_lay v3_trans(soap_output_withDID L, soap_in R) := transform
														 self.time_ms := l.time_ms;  
			
			self.accountnumber :=(string) L.acctno;
			self.DID :=(integer) l.did; 
			self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
			self.FNamePop := r.batch_in[1].Name_First<>'';
			self.LNamePop := r.batch_in[1].Name_Last<>'';
			self.AddrPop := r.batch_in[1].street_addr<>'';
			self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
			self.DOBPop := r.batch_in[1].dob<>'';
			self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
			self.HPhnPop := r.batch_in[1].Home_Phone<>'';   	
			self.history_date := (string)r.batch_in[1].HistoryDateYYYYMM;
			self.invalidssn := L.isSSNInvalid;	
			SELF.verifiedphonefullname:=  L.isPhoneFullNameMatch ;
			SELF.verifiedphonelastname:=  L.isPhoneLastNameMatch ;
			SELF.invalidphone:=  L.isPhoneInvalid;
			SELF.invalidaddr:=  L.isAddrInvalid;
			SELF.invaliddl:=  L.isDLInvalid;
			SELF.ssndeceased:=  L.isDeceased;
			SELF.ssnvalid:=  L.isSSNValid;
			SELF.recentissue:=  L.isRecentIssue;
			SELF.nonus:=  L.isNonUS;
			SELF.issued3:=  L.isIssued3;
			SELF.issuedage5:=  L.isIssuedAge5;
			SELF.iaownedbysubject:=  L.IAisOwnedBySubject;
			SELF.iafamilyowned:=  L.IAisFamilyOwned;
			SELF.iaoccupantowned:=  L.IAisOccupantOwned;
			SELF.ianotprimaryres:=  L.IAisNotPrimaryRes;
			SELF.caownedbysubject:=  L.CAisOwnedBySubject;
			SELF.cafamilyowned:=  L.CAisFamilyOwned;
			SELF.caoccupantowned:=  L.CAisOccupantOwned;
			SELF.canotprimaryres:=  L.CAisNotPrimaryRes;
			SELF.paownedbysubject:=  L.PAisOwnedBySubject;
			SELF.pafamilyowned:=  L.PAisFamilyOwned;
			SELF.paoccupantowned:=  L.PAisOccupantOwned;
			SELF.inputcurrmatch:=  L.isInputCurrMatch;
			SELF.diffstate:=  L.isDiffState;
			SELF.inputprevmatch:=  L.isInputPrevMatch;
			SELF.diffstate2:=  L.isDiffState2;
			SELF.addrhighrisk:=  L.isAddrHighRisk;
			SELF.phonehighrisk:=  L.isPhoneHighRisk;
			SELF.addrprison:=  L.isAddrPrison;
			SELF.zippobox:=  L.isZipPOBox;
			SELF.zipcorpmil:=  L.isZipCorpMil;
			SELF.phonepager:=  L.isPhonePager;
			SELF.phonemobile:=  L.isPhoneMobile;
			SELF.phonezipmismatch:=  L.isPhoneZipMismatch;
			SELF := L;
			SELF := [];
		
		END;
			 
		resu := JOIN(soap_output_withDID,soap_in,LEFT.Acctno=(string)RIGHT.batch_in[1].acctno,v3_trans(LEFT,RIGHT));

	  //final file out to thor
		final_output := output(resu,, outfile_name, thor, compressed, OVERWRITE);
// output(soap_output_withDID,named('soap_output_withDID'));
		// output(soap_in,named('soap_in'));
		RETURN final_output;

ENDMACRO;