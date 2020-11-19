EXPORT Chase_PIO2_BATCH_Macro(roxie_ip,Gateway_dummy, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, Risk_Indicators, RiskWise, UT;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		gateways := Gateway;
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
		fcraroxie := riskwise.shortcuts.staging_fcra_roxieIP; 
  	Gateway := DATASET([], Gateway.Layouts.Config);

		//*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_BATCH_Chase_PIO2_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_BATCH_Chase_PIO2_settings.GLB;
		DRM:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_BATCH_Chase_PIO2_settings.DRM;
		DPM:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_BATCH_Chase_PIO2_settings.DPM;
		HISTORYDATE := 999999;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	
		
		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;
			
		ds_raw_input := distribute(IF(no_of_records <= 0, DATASET( infile_name, layout_input, thor), 
	                                CHOOSEN(DATASET( infile_name, layout_input,  thor), no_of_records)),(integer)accountnumber);

	   //*********** CHASE PIO2 BATCH SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			string tribcode := '';	
			DATASET(RiskWise.Layout_PB1O_BatchIn) batch_in;
			unsigned1	DPPAPurpose:= '';
			unsigned1	GLBPurpose:= '';
			STRING DataRestrictionMask := '';
			STRING DataPermissionMask := '';
			integer	HistoryDateyyyymm := '';
			string Gateways := '';
			end;
			
		sghatti.Layout_PB1O_BatchIn make_batch_in(ds_raw_input le, integer c) := transform
			self.acctno :=(string) le.accountnumber;	
			self.name_first := le.firstname;
			self.name_last := le.lastname;
			self.street_addr := le.streetaddress;
			self.p_city_name:= le.city;
			self.st := le.state;
			self.z5 := le.zip;
			self.home_phone := le.homephone;
			self.ssn := le.ssn;
			self.dob := le.dateofbirth;
			self.historydateyyyymm := historydate;
			self := le;
			self := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			self.batch_in := batch;
			self.tribcode := 'pi02';
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.datarestrictionmask := drm;
			self.DataPermissionMask := dpm;
			self.historydateyyyymm := historydate;
		END;

    //ds_soap_in
		soap_in := DISTRIBUTE(project(ds_raw_input,append_settings(LEFT, counter)), random());

		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout;			 
		END;

		Global_output_lay myFail(soap_in l) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.acctno := l.batch_in[1].acctno;
			SELF := [];
		END;
		
		//*********** PERFORMING SOAPCALL TO ROXIE ************ 

		Soap_output := SOAPCALL(soap_in, roxieIP,
						'RiskWise.PRIO_Batch_Service', {soap_in}, 
						DATASET(Global_output_lay),
						RETRY(retry), TIMEOUT(timeout),
						PARALLEL(threads), onFail(myFail(LEFT)));

		// calling IID macro to capture DID for appending to final output 		
	  did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HISTORYDATE); 
 
    //**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 					
		Global_output_lay did_append(did_results l, Soap_output r) := TRANSFORM
					self.did := l.did;
					self := r;
		END;
					
		res := JOIN(did_results, Soap_output, left.acctno = right.acctno, did_append(left, right),right outer);
		 
    //Appeding additional internal extras to Soap output file 
					
		Global_output_lay internal_extras_append(res l, soap_in r) := TRANSFORM
			self.DID := l.did; 
			self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
			self.FNamePop := r.batch_in[1].Name_First<>'';
			self.LNamePop := r.batch_in[1].Name_Last<>'';
			self.AddrPop := r.batch_in[1].street_addr<>'';
			self.SSNLength := (string)(length(trim(r.batch_in[1].ssn,left,right))) ;
			self.DOBPop := r.batch_in[1].dob<>'';
			self.EmailPop := r.batch_in[1].email<>'';
			self.IPAddrPop := r.batch_in[1].ip_addr<>''; 
			self.HPhnPop := r.batch_in[1].Home_Phone<>'';
			self := l;
			self := [];
		END;
						
		ds_with_extras:=join(res,soap_in,left.acctno=(string)right.batch_in[1].acctno ,internal_extras_append(left, right));	

    //final file out to thor
		final_output := output(ds_with_extras,, outfile_name, thor, compressed, OVERWRITE);

		RETURN final_output;
		
ENDMACRO;