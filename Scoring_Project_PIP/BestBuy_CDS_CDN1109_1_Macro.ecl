EXPORT BestBuy_CDS_CDN1109_1_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT RiskWise, Risk_Indicators, ut, iesp, Models;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String RoxieIP := roxie_ip; 
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
		Gateway := DATASET([], Gateway.Layouts.Config);
		ServiceName := 'Models.ChargebackDefender_Service';

		//*********** SETTINGS ********************************

		DPPA := Scoring_Project_PIP.User_Settings_Module.ChargeBackDefender_BestBuy_settings.DPPA;
		GLB := Scoring_Project_PIP.User_Settings_Module.ChargeBackDefender_BestBuy_settings.GLB;
		DRM := Scoring_Project_PIP.User_Settings_Module.ChargeBackDefender_BestBuy_settings.DRM; 
		HISTORYDATE := 999999;
		VERSION := scoring_project_pip.User_Settings_Module.ChargeBackDefender_BestBuy_settings.Version;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************
		
		layout_input :=RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout pii1;
			Scoring_Project_Macros.Regression.pii_layout pii2;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

    ds_raw_input:= IF(no_of_records > 0, CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records),
                            DATASET( infile_name, layout_input, thor));
															
		
		//*********** CHARGEBACKDEFENDER SETUP AND SOAPCALL ******************
		
    BTSTCustomIn := RECORD
			STRING bb_Item_Lines_ := '';
			STRING bb_Line_Type_Header_ := '';
			STRING bb_CC_Type_ := '';
			STRING bb_CVV_Description_ := '';
			STRING bb_Entry_Type_ := '';
			STRING bb_Marked_For_Full_Name_H := '';
			STRING bb_Original_Total_Amount_ := '';
			STRING bb_PayPal_Customer_ID_ := '';
			STRING bb_Ship_Mode_ := '';
			STRING TM_Browser_Language_ := '';
			STRING TM_Device_Result_ := '';
			STRING TM_Policy_Score_ := '';
			STRING TM_Proxy_Ip_Geo_ := '';
			STRING TM_Reason_Code_ := '';
			STRING TM_Time_Zone_Hours_ := '';
			STRING TM_True_Ip_Geo_ := '';
			STRING TM_True_Ip_Region_ := '';
			STRING pf_raw_avs_code := '';
		END;

		pii_layout := RECORD
			 string firstname;
			 string middlename;
			 string lastname;
			 string streetaddress;
			 string city;
			 string state;
			 string zip;
			 string homephone;
			 string ssn;
			 string dateofbirth;
			 string workphone;
			 string income;
			 string dlnumber;
			 string dlstate;
			 string balance;
			 string chargeoffd;
			 string formername;
			 string email;
			 string company;
			 integer8 historydateyyyymm;
			 string placeholder_1;
			 string placeholder_2;
			 string placeholder_3;
			 string placeholder_4;
			 string placeholder_5;
		END;		
		
		layout_input_pjt :=RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout pii1;
			Scoring_Project_Macros.Regression.pii_layout pii2;
			Scoring_Project_Macros.Regression.runtime_layout;
			BTSTCustomIn;
		END;													
														
		ds_raw_input_pjt:=PROJECT(ds_raw_input,TRANSFORM(layout_input_pjt,SELF :=LEFT));
			
	  layout_soap_in := record
			string account;
			string first;
			string middle;
			string last;
			string addr;
			string city;
			string state;
			string zip;
			string hphone;
			string socs;
			string email;
			string drlc;
			string drlcstate;
			string first2;
			string last2;
			string middle2;
			string addr2;
			string city2;
			string state2;
			string zip2;
			string hphone2;
			string ipaddr;
			string HistoryDateYYYYMM;
			INTEGER GLBPurpose;
			INTEGER DPPAPurpose;
			dataset(Models.Layout_Score_Chooser) scores;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			string DataRestrictionMask;
	  end;

		Models.Layout_Score_Chooser getScoreInput(ds_raw_input_pjt le) := TRANSFORM
			SELF.Name := 'Models.ChargebackDefender_Service';
			SELF.URL := '';
			
			p1 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Version'; SELF.Value := 'CDN1109_1'));
			p2 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Ship_Mode_'; SELF.Value := le.bb_Ship_Mode_));
			p3 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Original_Total_Amount_'; SELF.Value := le.bb_Original_Total_Amount_));
			p4 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Item_Lines_'; SELF.Value := le.bb_Item_Lines_));
			p5 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'CVV_Description_'; SELF.Value := le.bb_CVV_Description_));
			p6 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Payment_Type_'; SELF.Value := le.bb_CC_Type_));
			p7 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'AVS_Code_'; SELF.Value := le.pf_raw_avs_code));
			p8 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Device_Result_'; SELF.Value := le.TM_Device_Result_));
			p9 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'True_IP_Region_'; SELF.Value := le.TM_True_Ip_Region_));
			p10 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Browser_Language_'; SELF.Value := le.TM_Browser_Language_));
			p11 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Proxy_IP_Geo_'; SELF.Value := le.TM_Proxy_Ip_Geo_));
			p12 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Reason_Code_'; SELF.Value := le.TM_Reason_Code_));
			p13 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Time_Zone_Hours_'; SELF.Value := le.TM_Time_Zone_Hours_));
			p14 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'True_IP_Geo_'; SELF.Value := le.TM_True_Ip_Geo_));
			p15 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Policy_Score_'; SELF.Value := le.TM_Policy_Score_));
			p16 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Marked_For_Full_Name_H_'; SELF.Value := le.bb_Marked_For_Full_Name_H));
			p17 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Entry_Type_'; SELF.Value := le.bb_Entry_Type_));
			p18 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Line_Type_(Header)_'; SELF.Value := le.bb_Line_Type_Header_));
			p19 := PROJECT(ut.ds_oneRecord, TRANSFORM(Models.Layout_Parameters, SELF.Name := 'Paypal_Email_Address_'; SELF.Value := le.bb_PayPal_Customer_ID_));
			
			p := p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9 + p10 + p11 + p12 + p13 + p14 + p15 + p16 + p17 + p18 + p19;
			
			SELF.parameters := p;
		END;

		layout_soap_in append_settings(ds_raw_input_pjt le) := TRANSFORM
			self.HistoryDateYYYYMM := (string)HistoryDate; 
			self.dppapurpose := DPPA;
			self.glbpurpose := GLB;
			self.scores := PROJECT(le, getScoreInput(LEFT)); 
			self.DataRestrictionMask := DRM;  
			self.first := le.pii1.firstname;
			self.middle := le.pii1.middlename;
			self.last := le.pii1.lastname;
			self.addr := le.pii1.streetaddress;
			self.city := le.pii1.city;
			self.state := le.pii1.state;
			self.zip := le.pii1.zip;
			self.hphone := le.pii1.homephone;
			self.socs := le.pii1.ssn;
			self.email := le.pii1.email;
			self.drlc := le.pii1.dlnumber;
			self.drlcstate := le.pii1.dlstate;
			self.first2 := le.pii2.firstname;
			self.middle2 := le.pii2.middlename;
			self.last2 := le.pii2.lastname;
			self.addr2 := le.pii2.streetaddress;
			self.city2 := le.pii2.city;
			self.state2 := le.pii2.state;
			self.zip2 := le.pii2.zip;
			self.hphone2 := le.pii2.homephone;
			self.account :=(string)le.accountnumber;
			self := le;
			self := [];
		end;

		//ds_soap_in
		soap_in := distribute(PROJECT(ds_raw_input_pjt, append_settings(LEFT)), random());
		 
 	  //Soap output layout
    layout_Soap_output := RECORD
			STRING200 errorcode;
			STRING30 accountnumber;
			Models.Layout_Chargeback_Out;
		END;
      
		layout_Soap_output myFail( soap_in le ) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF.accountnumber:=le.account;
			SELF := le;
			SELF := [];
		END;
			
    //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
    Soap_output := SOAPCALL(soap_in, 
      												RoxieIP, 
      												ServiceName, 
      												{soap_in}, 
      												DATASET(layout_Soap_output),
      												RETRY(retry), TIMEOUT(timeout),
      												ONFAIL(myFail(LEFT)), 
      												PARALLEL(threads));
      												
   	// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************

  
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		   Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BestBuy_CDS_CDN1109_1_Global_Layout;			 
		END;

    Global_output_lay flatten(Soap_output le) := transform
            
			self.acctno := le.accountnumber;
		
			self.cb_score   := le.models.scores[1].i;
			bt_reasons := le.models.scores[1].riskindicatorsets(Name='BillTo');
			self.cb_reason1 := bt_reasons[1].reason_codes[1].reason_code;
			self.cb_reason2 := bt_reasons[1].reason_codes[2].reason_code;
			self.cb_reason3 := bt_reasons[1].reason_codes[3].reason_code;
			self.cb_reason4 := bt_reasons[1].reason_codes[4].reason_code;
			self.cb_reason5 := bt_reasons[1].reason_codes[5].reason_code;
			self.cb_reason6 := bt_reasons[1].reason_codes[6].reason_code;
			
			st_reasons := le.models.scores[1].riskindicatorsets(Name='ShipTo');
			self.cb_reason7 := st_reasons[1].reason_codes[1].reason_code;
			self.cb_reason8 := st_reasons[1].reason_codes[2].reason_code;
			self.cb_reason9 := st_reasons[1].reason_codes[3].reason_code;
			self.cb_reason10 := st_reasons[1].reason_codes[4].reason_code;
			self.cb_reason11 := st_reasons[1].reason_codes[5].reason_code;
			self.cb_reason12 := st_reasons[1].reason_codes[6].reason_code;
			
			self.errorcode := le.errorcode;
			self.historydate:='';
			self := le.chargeback;
			self:=[];
				            	
    end;
            
    ds_slim  := project(Soap_output,flatten(left));
      
  	// calling IID macro to capture DID for appending to final output 
		
		did_layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;
	
		did_layout_input func(ds_raw_input l):=transform
			self.FirstName:=l.pii1.FirstName;
			self.MiddleName:=l.pii1.MiddleName;
			self.LastName:=l.pii1.LastName;
			self.StreetAddress:=l.pii1.StreetAddress;			
			self.City:=l.pii1.City;
			self.State:=l.pii1.State;
			self.Zip:=l.pii1.Zip;
			self.HomePhone:=l.pii1.HomePhone;			
			self.SSN:=l.pii1.SSN;
			self.DateOfBirth:=l.pii1.DateOfBirth;
			self.WorkPhone:=l.pii1.WorkPhone;
			self.income:=l.pii1.income;			
			self.DLNumber:=l.pii1.DLNumber;
			self.DLState:=l.pii1.DLState;
			self.BALANCE:=l.pii1.BALANCE;
			self.CHARGEOFFD:=l.pii1.CHARGEOFFD;		
			self.FormerName:=l.pii1.FormerName;
			self.EMAIL:=l.pii1.EMAIL;
			self.COMPANY:=l.pii1.COMPANY;
			self.historydateyyyymm:=HistoryDate;			
	    self.PLACEHOLDER_1:=l.pii1.PLACEHOLDER_1;
			self.PLACEHOLDER_2:=l.pii1.PLACEHOLDER_2;
			self.PLACEHOLDER_3:=l.pii1.PLACEHOLDER_3;
			self.PLACEHOLDER_4:=l.pii1.PLACEHOLDER_4;
	    self.PLACEHOLDER_5:=l.pii1.PLACEHOLDER_5;
	    self:=l;
	    self:=[];
		end;

		did_infile := project(ds_raw_input,func(left));
           
		did_results:=Scoring_Project_PIP.IID_macro(did_infile,threads,roxieIP,DPPA,GLB,DRM,HistoryDate);            
               
	  //**************** ADDING DID'S & INTERNAL EXTRAS TO RESULTS *************************** 
		
		Global_output_lay did_append(did_results l, ds_slim r) := TRANSFORM
									 self.did := l.did;
									 self := r;
									 end;
									 
		res := JOIN(did_results, ds_slim, left.acctno = right.acctno, did_append(left, right), right outer);
   
	  //Appeding additional internal extras to Soap output file
		Global_output_lay internal_extras_append(res l, soap_in r) := TRANSFORM
																			self.did := l.did; 
																			self.historydate:=(string)r.historydateyyyymm;
																			self.fnamepop:=r.first<>'';
																			self.lnamepop:= r.last<>'';
																			self.addrpop:= r.addr<>'';
																			self.ssnlength:= (string)(length(trim(r.socs))) ;
																			self.emailpop:=r.email<>'';
																			self.ipaddrpop:=r.ipaddr<>'';
																			self.hphnpop:= r.hphone<>'';
																			self := l;
											              	self := [];
												              END;
												
		ds_with_extras:=join(res, soap_in, left.acctno=(string)right.account, internal_extras_append(left, right));	
									
		//final file out to thor										
		final_output := output(ds_with_extras,, outfile_name, thor, compressed, OVERWRITE);
	 
		RETURN final_output;

ENDMACRO;