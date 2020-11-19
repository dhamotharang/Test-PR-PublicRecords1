EXPORT Chase_PIO2_XML_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, Risk_Indicators, RiskWise, Scoring, UT;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		Gateway := DATASET([], Gateway.Layouts.Config);
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name;
		fcraRoxie  := riskwise.shortcuts.staging_fcra_roxieIP; 
	

		//*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_XML_Chase_PIO2_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_XML_Chase_PIO2_settings.GLB;
		DRM:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_XML_Chase_PIO2_settings.DRM;
		DPM:=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_XML_Chase_PIO2_settings.DPM;
		// ISFCRA :=Scoring_Project_PIP.User_Settings_Module.PRIO_Scores_XML_Chase_PIO2_settings.isFCRA;
		HISTORYDATE := 999999;

    //*****************************************************

	  //************** INPUT FILE GENERATION ****************	
		
		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := distribute(IF(no_of_records <= 0, dataset( infile_name, layout_input, thor), CHOOSEN(DATASET( infile_name, layout_input, thor), no_of_records)),(integer)accountnumber);

    //*********** CHASE PIO2 XML SETUP AND SOAPCALL ******************

		sghatti.Layout_PRIO_Soapcall into_PRIO_input(ds_raw_input le) := transform
			self.acctno := (string)le.accountnumber;
			self.account := (string)le.accountnumber;
			self.tribcode := 'pi02'; 
			self.first := le.firstname;
			self.last := le.lastname;
			self.addr := le.streetaddress;
			self.city:= le.city;
			self.state := le.state;
			self.zip := le.zip;
			self.hphone := le.homephone;
			self.socs := le.ssn;
			self.dob := le.dateofbirth;
			self.historydateyyyymm := historydate;
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.datarestrictionmask := drm;
			self.DataPermissionMask := dpm;
			self := le;
			self := [];
		end;

    //ds_soap_in
		soap_in := DISTRIBUTE(project(ds_raw_input,into_PRIO_input(LEFT)), RANDOM());
	
    //Soap output layout		
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout;			 
		END;

		Global_output_lay myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.acctno:=le.account;
			SELF := le;
			SELF := [];
		END;

    //*********** PERFORMING SOAPCALL TO ROXIE ************
		
		// serviceName := if(isFCRA, 'RiskWiseFCRA.RiskWiseMainPRIO', 'RiskWise.RiskWiseMainPRIO');
		// ip := if(isFCRA, fcraRoxie, roxieIP);
		
		Soap_output := SOAPCALL(soap_in, roxieIP,
						'RiskWise.riskwisemainprio', {soap_in}, 
						DATASET(Global_output_lay),
						RETRY(retry), TIMEOUT(timeout), 
						XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
						PARALLEL(threads), onFail(myFail(LEFT)));


		ds_slim := project(Soap_output, transform(recordof(Soap_output),
								 self.acctno := left.account,
								 self := left));
								 							 
		// calling IID macro to capture DID for appending to final output 		
		did_results:=Scoring_Project_PIP.IID_macro(ds_raw_input,threads,roxieIP,DPPA,GLB,DRM,HISTORYDATE); 
					
    //**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 
	
		Global_output_lay did_append(did_results l, ds_slim r) := TRANSFORM
					self.did := l.did;
					self := r;
		END;
					
		res := JOIN(did_results, ds_slim, left.acctno = right.acctno, did_append(left, right),right outer);
					
		//Appeding additional internal extras to Soap output file     
		Global_output_lay internal_extras_append(res l, soap_in r) := TRANSFORM
							self.DID := l.did; 
							self.historydate := (string)r.HistoryDateYYYYMM;
							self.FNamePop := r.first<>'';
							self.LNamePop := r.last<>'';
							self.AddrPop := r.addr<>'';
							self.SSNLength := (string)(length(trim(r.socs,left,right))) ;
							self.DOBPop := r.dob<>'';
							self.EmailPop := r.email<>'';
							self.HPhnPop := r.hphone<>'';
							self := l;
						  self := [];
	        END;
						
		ds_with_extras:=join(res,soap_in,left.acctno=(string)right.acctno ,internal_extras_append(left, right));	
								 
		 //final file out to thor
		 output(ds_with_extras,, outfile_name, thor,compressed, OVERWRITE);
		 output(ds_with_extras,, outfile_name +'_CSV_copy', CSV(heading(single), quote('"')), overwrite,expire(14));
		
		RETURN 0;

ENDMACRO;