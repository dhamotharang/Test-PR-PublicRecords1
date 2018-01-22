EXPORT CapitalOne_RVAttributes_V3_Macro(fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP ;
		Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;

		//*********** SETTINGS ********************************

		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_CapOne_settings.DRM;
		ISPRESCREEN:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_CapOne_settings.IsPreScreen;
		INCLUDEVERSION3:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_CapOne_settings.IncludeVersion3;
		ISFCRA:=if(Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_CapOne_settings.isFCRA=true,'FCRA','NONFCRA');
		HISTORYDATE := 999999;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	
			
		layout_input :=RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := IF(no_of_records <= 0, dataset( infile_name, layout_input,thor) ,
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));

    //*********** CapitalOne RVAttributes V3 BATCH SETUP AND SOAPCALL ******************
		
		layout_soap_input := RECORD
			DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
			STRING DataRestrictionMask;
			boolean IncludeVersion3;
			BOOLEAN IsPreScreen;	
		END;

		Risk_Indicators.Layout_Batch_In make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.seq := c;
			SELF.acctno := (string)le.AccountNumber;
			SELF.Name_First := le.FirstName;
			SELF.Name_Middle := le.MiddleName;
			SELF.Name_Last := le.LastName;
			SELF.street_addr := le.StreetAddress;
			SELF.p_City_name := le.City;
			SELF.St := le.State;
			SELF.z5 := le.Zip;
			SELF.SSN := le.SSN;
			SELF.historydateyyyymm := HistoryDate;
			SELF := le;
			SELF := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			SELF.gateways := DATASET([{'FCRA', neutralroxieIP}], risk_indicators.layout_gateways_in);
			SELF.IsPreScreen := IsPreScreen;		
			self.IncludeVersion3 := IncludeVersion3;
			SELF.DataRestrictionMask := DRM;
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
												parallel(threads) ,
												onfail(myfail(LEFT)));


		/************************************************
		 *  Added output for new layout - Nathan 5/5    *
		 ************************************************/
		/* Commented out writing file ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3_XXXXXXXX_1_batchlay on 7/29/16.
			 Doesn't look like this is being used anywhere

		batchlay_with_extras := record
		Scoring_Project_Macros.Global_Output_Layouts.RiskViewAttributes_v3;
    end;

		batchlay_with_extras add_iextras(Soap_output l, soap_in r) := TRANSFORM
					self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
					self.FNamePop := r.batch_in[1].Name_First<>'';
					self.LNamePop := r.batch_in[1].Name_Last<>'';
					self.AddrPop := r.batch_in[1].street_addr<>'';
					self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
					self.DOBPop := r.batch_in[1].dob<>'';
					self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
					self.HPhnPop := r.batch_in[1].Home_Phone<>'';
				  self := l;
		      self := [];
		   END;
	
		batch_final_output := join(Soap_output, soap_in, left.acctno = (string)right.batch_in[1].acctno, add_iextras(left, right));

		batch_outfile_name := outfile_name + '_batchlay';
		op_batch_final := output(batch_final_output,, batch_outfile_name, thor, compressed, overwrite);
		*/	
		/************************************************/

		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
				

		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V3_Global_Layout;		 
		END;

		rv_attributes_v3 := project(Soap_output, 
			TRANSFORM(Global_output_lay, 
				self.time_ms := left.time_ms;
					SELF.accountnumber := left.acctno;
					SELF.history_date := (string)HISTORYDATE;
					SELF.invalidssn := left.isSSNInvalid;	
					SELF.verifiedphonefullname:=  left.isPhoneFullNameMatch ;
					SELF.verifiedphonelastname:=  left.isPhoneLastNameMatch ;
					SELF.invalidphone:=  left.isPhoneInvalid;
					SELF.invalidaddr:=  left.isAddrInvalid;
					SELF.invaliddl:=  left.isDLInvalid;
					SELF.ssndeceased:=  left.isDeceased;
					SELF.ssnvalid:=  left.isSSNValid;
					SELF.recentissue:=  left.isRecentIssue;
					SELF.nonus:=  left.isNonUS;
					SELF.issued3:=  left.isIssued3;
					SELF.issuedage5:=  left.isIssuedAge5;
					SELF.iaownedbysubject:=  left.IAisOwnedBySubject;
					SELF.iafamilyowned:=  left.IAisFamilyOwned;
					SELF.iaoccupantowned:=  left.IAisOccupantOwned;
					SELF.ianotprimaryres:=  left.IAisNotPrimaryRes;
					SELF.caownedbysubject:=  left.CAisOwnedBySubject;
					SELF.cafamilyowned:=  left.CAisFamilyOwned;
					SELF.caoccupantowned:=  left.CAisOccupantOwned;
					SELF.canotprimaryres:=  left.CAisNotPrimaryRes;
					SELF.paownedbysubject:=  left.PAisOwnedBySubject;
					SELF.pafamilyowned:=  left.PAisFamilyOwned;
					SELF.paoccupantowned:=  left.PAisOccupantOwned;
					SELF.inputcurrmatch:=  left.isInputCurrMatch;
					SELF.diffstate:=  left.isDiffState;
					SELF.inputprevmatch:=  left.isInputPrevMatch;
					SELF.diffstate2:=  left.isDiffState2;
					SELF.addrhighrisk:=  left.isAddrHighRisk;
					SELF.phonehighrisk:=  left.isPhoneHighRisk;
					SELF.addrprison:=  left.isAddrPrison;
					SELF.zippobox:=  left.isZipPOBox;
					SELF.zipcorpmil:=  left.isZipCorpMil;
					SELF.phonepager:=  left.isPhonePager;
					SELF.phonemobile:=  left.isPhoneMobile;
					SELF.phonezipmismatch:=  left.isPhoneZipMismatch;
																		self.total_number_derogs := left.total_number_derogs_v2;
																		// self.date_last_derog := left.date_last_derog_v2;																							
																							self.property_owned_total := left.property_owned_total_v2;
																							self.property_owned_assessed_total := left.property_owned_assessed_total_v2;
																							self.property_historically_owned := left.property_historically_owned_v2;
					SELF.did:=(integer)left.did;
					SELF := left;
					SELF:=[];
				));			

	  //Appeding additional internal extras to Soap output file 
		Global_output_lay internal_extras_append(rv_attributes_v3 l, soap_in r) := TRANSFORM
																self.DID := (integer)l.did; 
																self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
																self.FNamePop := r.batch_in[1].Name_First<>'';
																self.LNamePop := r.batch_in[1].Name_Last<>'';
																self.AddrPop := r.batch_in[1].street_addr<>'';
																self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
																self.DOBPop := r.batch_in[1].dob<>'';
																self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
																self.HPhnPop := r.batch_in[1].Home_Phone<>'';
                                self := l;
																self := [];
			                        END;
			
		ds_with_extras:=join(rv_attributes_v3,soap_in,left.accountnumber=(string)right.batch_in[1].acctno ,internal_extras_append(left, right));	
		
    //final file out to thor
		final_output := output(ds_with_extras,, outfile_name, thor, compressed, overwrite);

		// RETURN sequential (op_batch_final, final_output);  // per commenting out code above
		RETURN final_output;

ENDMACRO;