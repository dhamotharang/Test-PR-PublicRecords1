﻿//EXPORT BocaShell_54_nonFCRA_cert_MACRO := 'todo';
EXPORT BocaShell_54_nonFCRA_cert_MACRO( bs_version, nonfcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun, retro_date = 999999):= functionmacro

			IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, std, UT, Scoring_Project_PIP;

			unsigned8 no_of_records := records_ToRun;
			integer retry := retry;
			integer timeout := timeout;
			integer threads := Thread;
			integer version := bs_version;

			String neutralroxieIP := neutralroxie_IP ; 
			String roxieIP := nonfcraroxie_IP ;

			infile_name :=  Input_file_name;

			String out_name_head :=  Output_file_name ;

			string8 today := ut.GetDate;
			integer archive_date := retro_date;

			bs_service := 'risk_indicators.Boca_Shell';

			//*********** SETTINGS ************************************

			RemoveFares := scoring_project_pip.User_Settings_Module.BocaShell_54_NONFCRA_settings.RemoveFares;	// change this to TRUE for FARES filtering
			LeadIntegrityMode := scoring_project_pip.User_Settings_Module.BocaShell_54_NONFCRA_settings.LeadIntegrityMode;  // change this to TRUE for LeadIntegrity modeling

			DRM := scoring_project_pip.User_Settings_Module.BocaShell_54_NONFCRA_settings.DRM;  // byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
			                                                                                   // byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
			DPPA := scoring_project_pip.User_Settings_Module.BocaShell_54_NONFCRA_settings.DPPA;
			GLB := scoring_project_pip.User_Settings_Module.BocaShell_54_NONFCRA_settings.GLB;

			//*********************************************************


			//********* input file generation *************************
			
			layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
			END;

			ds_raw_input := dataset (infile_name, layout_input, thor);

			ds_raw_input_project := project(ds_raw_input,TRANSFORM(layout_input, self.historydateyyyymm := archive_date, self:= LEFT));

			ds_input := IF (no_of_records = 0, ds_raw_input_project, CHOOSEN (ds_raw_input_project, no_of_records));

			//*********************************************************


			//*********** BOCASHELL SETUP AND SOAPCALL ******************
			
			layout_soap_input := RECORD
			STRING old_account_number;
			Risk_Indicators.Layout_InstID_SoapCall;
			END;


			layout_soap_input assignAccount (ds_input le, INTEGER c) := TRANSFORM
			SELF.old_account_number := (STRING)le.AccountNumber;
			SELF.AccountNumber := (STRING)c;

			SELF.GLBPurpose  := GLB;
			SELF.DPPAPurpose := DPPA;

			self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', (string)le.historydateyyyymm) => (unsigned)le.historydateyyyymm[..6],
			regexfind('^\\d{8}$',        (string)le.historydateyyyymm) => (unsigned)le.historydateyyyymm[..6],
			(unsigned)le.historydateyyyymm
			);

			self.historyDateTimeStamp := map(
			(string)le.historydateyyyymm in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', (string)le.historydateyyyymm) => (string)le.historydateyyyymm,
			regexfind('^\\d{8}$',        (string)le.historydateyyyymm) => (string)le.historydateyyyymm +   ' 00000100',
			regexfind('^\\d{6}$',        (string)le.historydateyyyymm) => (string)le.historydateyyyymm + '01 00000100',		                                                
			(string)le.historydateyyyymm
			);

			SELF.IncludeScore := true;
			SELF.datarestrictionmask := DRM;
			SELF.RemoveFares := RemoveFares;
			self.bsversion := version;				
			SELF := le;
			SELF := [];
			END;
			
			//ds_soap_in
			ds_soap_in := Distribute(PROJECT (ds_input, assignAccount (LEFT,COUNTER)), random());

			// ds_soap_output									
			ds_soap_output := Scoring_Project_PIP.test_BocaShell_SoapCall  (PROJECT (ds_soap_in, TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, SELF := LEFT)),
			                                                                                           bs_service, roxieIP, threads);


			//GLOBAL OUTPUT LAYOUT
			Global_output_lay:= RECORD	 
			Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;			 
			END;

			
			Global_output_lay trans(ds_soap_output le, layout_soap_input ri) :=	TRANSFORM
			SELF.AccountNumber := ri.old_account_number;
			SELF := le;
			END;

			ds_soap_output_pjt := JOIN (ds_soap_output,ds_soap_in,LEFT.seq=(unsigned)RIGHT.accountnumber,trans(LEFT,RIGHT));

			//final file out to thor
			// final_output := OUTPUT (ds_soap_output_pjt, , out_name_head , thor,cluster('thor50_dev'),compressed, overwrite,expire(60));
			 OUTPUT (ds_soap_output_pjt, , out_name_head , thor,compressed, overwrite);
OUTPUT(ds_soap_output_pjt, , out_name_head +'_CSV_copy', CSV(heading(single), quote('"')), overwrite,expire(14));  

			return 0;

ENDMACRO;

