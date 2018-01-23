﻿// #workunit('name','NonFCRA-BestBuy Chargeback Defender');
// #option ('hthorMemoryLimit', 1000);
// #option ('linkCountedRows', false);
EXPORT BestBuy_CDS_CDN1109_1_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT RiskWise, Risk_Indicators, ut, iesp, Models;

/* ********************************************************************************
 *                                   Main Options                                 *
 **********************************************************************************/


unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String RoxieIP := roxie_ip; 
String gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


DPPAPurpose := 3;
GLBPurpose := 1;

DataRestrictionMask := '000000000000';

/* ********************************************************************************
 *  Other Options - Shouldn't need much adjustment  *
 **********************************************************************************/
ServiceName := 'Models.ChargebackDefender_Service';

/* ********************************************************************************
 *  Standard PII layout for Chargeback Defender - Shouldn't need much adjustment  *
 **********************************************************************************/
BTST_in := record
  string Seqnum := '';
	string30 accountnumber := '';
  string30 firstname := '';
  string30 middlename := '';
  string30 lastname := '';
  string5 suffix := '';
	string120 streetaddress := '';
	string25 city := '';
	string2 state := '';
	string5 zip := '';
	string25 country := '';
	string9 ssn := '';
	string8 dateofbirth := '';
	unsigned1 age := 0;
	string20 dlnumber := '';
	string2 dlstate := '';
	string100 email := '';
	string120 ipaddress := '';
	string10 homephone := '';
	string10 workphone := '';
	string100 employername := '';
	string30 formername := '';
	string30 firstname2 := '';
	string30 middlename2 := '';
	string30 lastname2 := '';
	string5 suffix2 := '';
	string120 streetaddress2 := '';
	string25 city2 := '';
	string2 state2 := '';
	string5 zip2 := '';
	string25 country2 := '';
	string9 ssn2 := '';
	string8 dateofbirth2 := '';
	unsigned1 age2 := 0;
	string20 dlnumber2 := '';
	string2 dlstate2 := '';
	string100 email2 := '';
	string120 ipaddress2 := '';
	string10 homephone2 := '';
	string10 workphone2 := '';
	string100 employername2 := '';
	string30 formername2 := '';
	string6 historydateyyyymm := '';
end;

/* ********************************************************************************
 * Custom Best Buy Inputs - These should be at the end of the standard Chargeback *
 * Defender PII layout, if not - adjust these names and BTSTCustom accordingly.   *
 **********************************************************************************/
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

layout_input :=RECORD
  Scoring_Project_Macros.Regression.global_layout;
  Scoring_Project_Macros.Regression.pii_layout pii1;
  Scoring_Project_Macros.Regression.pii_layout pii2;
 Scoring_Project_Macros.Regression.runtime_layout;
	BTSTCustomIn;
 END;


 // f:= IF(records > 0, CHOOSEN(DATASET(inputFileName, BTSTCustom, CSV(HEADING(single), QUOTE('"'))), records),
                            // DATASET(inputFileName, BTSTCustom, CSV(HEADING(single), QUOTE('"'))));

f:= IF(no_of_records > 0, CHOOSEN(DATASET(ut.foreign_prod + infile_name, layout_input, CSV(HEADING(single), QUOTE('"'))), no_of_records),
                            DATASET(ut.foreign_prod + infile_name, layout_input, CSV(HEADING(single), QUOTE('"')) ));

rawInput := f;
//Rawinput := f (SeqNum = '20');


/* ********************************************************************************
 *  Main Code Section - Shouldn't need to adjust much below here.                 *
 **********************************************************************************/
// OUTPUT(CHOOSEN(rawInput, 10), NAMED('Raw_Input'));
// OUTPUT(COUNT(rawInput), NAMED('Raw_Count'));


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

Models.Layout_Score_Chooser getScoreInput(rawInput le) := TRANSFORM
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

layout_soap_in to_soap(rawInput le) := TRANSFORM
	self.HistoryDateYYYYMM := '999999'; 
	self.dppapurpose := DPPAPurpose;
	self.glbpurpose := GLBPurpose;
		
	self.scores := PROJECT(le, getScoreInput(LEFT)); 

	self.DataRestrictionMask := DataRestrictionMask;  // to allow use everything
	
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
	
	self.account :=(string) le.accountnumber;
  self := le;
	self := [];
end;

soap_in := PROJECT(rawInput, to_soap(LEFT));
// OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAP_In'));
 
   layout_with_errcode := RECORD
      	STRING200 errorcode;
      	Models.Layout_Chargeback_Out;
      END;
      
      layout_with_errcode myFail( soap_in le ) := TRANSFORM
      	SELF.errorcode := FAILCODE + FAILMESSAGE;
      	SELF := le;
      	SELF := [];
      END;
      
      soapresults := SOAPCALL(soap_in, 
      												RoxieIP, 
      												ServiceName, 
      												{soap_in}, 
      												DATASET(layout_with_errcode),
      												RETRY(retry), TIMEOUT(timeout),
      												ONFAIL(myFail(LEFT)), 
      												PARALLEL(threads));
      												
      // OUTPUT(CHOOSEN(soapresults, eyeball), NAMED('Sample_SOAP_Results'));
      
       Layout_Chargeback := RECORD
         	STRING30 account := '';
         	STRING2  socsverlevel := '';
         	STRING2  phoneverlevel := '';
         	STRING20 correctlast := '';
         	STRING10 correcthphone := '';
         	STRING9  correctsocs := '';
         	STRING50 correctaddr := '';
         	STRING3  altareacode := '';
         	STRING8  areacodesplitdate := '';
         	STRING15 verfirst := '';
         	STRING20 verlast := '';
         	STRING50 veraddr := '';
         	STRING30 vercity := '';
         	STRING2  verstate := '';
         	STRING5  verzip5 := '';
         	STRING4  verzip4 := '';
         	STRING10 nameaddrphone := '';
         	STRING1  hphonetypeflag := '';
         	STRING1  dwelltypeflag := '';
         	STRING6  sic := '';
         	
         	STRING2  phoneverlevel2 := '';
         	STRING20 correctlast2 := '';
         	STRING10 correcthphone2 := '';
         	STRING50 correctaddr2 := '';
         	STRING3  altareacode2 := '';
         	STRING8  areacodesplitdate2 := '';
         	STRING15 verfirst2 := '';
         	STRING20 verlast2 := '';
         	STRING50 veraddr2 := '';
         	STRING30 vercity2 := '';
         	STRING2  verstate2 := '';
         	STRING5  verzip52 := '';
         	STRING4  verzip42 := '';
         	STRING10 nameaddrphone2 := '';
         	STRING1  hphonetypeflag2 := '';
         	STRING1  dwelltypeflag2 := '';
         	STRING6  sic2 := '';
         	
         	// score
         	string3	 cb_score;
         	string2  cb_reason1;
         	string2  cb_reason2;
         	string2  cb_reason3;
         	string2  cb_reason4;
         	string2  cb_reason5;
         	string2  cb_reason6;
         	
         	string2  cb_reason7;
         	string2  cb_reason8;
         	string2  cb_reason9;
         	string2  cb_reason10;
         	string2  cb_reason11;
         	string2  cb_reason12;
         	
         	string200 errorcode;
         end;
         
         layout_chargeback flatten(soapresults le) := transform
         
         	self.account := le.accountnumber;
         
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
         	self := le.chargeback;
         	
         end;
         
         soap_out  := project(soapresults,flatten(left));
         
         
         op_final := output(Soap_out,, outfile_name, CSV(HEADING(single), QUOTE('"')), OVERWRITE);
         
         // fin_res := sequential(op_final);




return op_final;

endmacro;