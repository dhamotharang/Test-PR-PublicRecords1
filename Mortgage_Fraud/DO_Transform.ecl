import Address, Risk_Indicators, Riskwise, ut, Mortgage_Fraud, Gateway;

//======================================
//=== Mortgage Fraud Report          ===
//===     Transforms                 === 
//======================================
EXPORT DO_Transform   := MODULE
  
 EXPORT ON_INPUT()  := FUNCTION 
	    STRING30 account_value := ''       : stored('AccountNumber');	 
	    STRING30 fname_val := ''           : stored('FirstName');
      STRING30 mname_val := ''           : stored('MiddleName');
      STRING30 lname_val := ''           : stored('LastName');
      STRING5 suffix_val := ''           : stored('NameSuffix');
      STRING120 addr1_val := ''          : stored('StreetAddress');
      STRING25 city_val := ''            : stored('City');
      STRING2 state_val := ''            : stored('State');
      STRING5 zip_value := ''            : stored('Zip');
      STRING25 country_value := ''       : stored('Country');
      STRING9 ssn_value := ''            : stored('ssn');
      STRING8 dob_value := ''            : stored('DateOfBirth');
      UNSIGNED1 age_value := 0           : stored('Age');
      STRING20 dl_number_value := ''     : stored('DLNumber');
      STRING2 dl_state_value := ''       : stored('DLState');
      STRING100 email_value := ''        : stored('Email');
      STRING45 ip_value := ''            : stored('IPAddress');
      STRING10 phone_value := ''         : stored('HomePhone');
      STRING10 wphone_value := ''        : stored('WorkPhone');
      STRING100 employe_name_value := '' : stored('EmployerName');
      STRING30 prev_lname_value := ''    : stored('FormerName');
	 
	    STRING30 fname_val2 := ''          : stored('FirstName2');
      STRING30 mname_val2 := ''          : stored('MiddleName2');
      STRING30 lname_val2 := ''          : stored('LastName2');
      STRING5 suffix_val2 := ''          : stored('NameSuffix2');
      STRING120 addr1_val2 := ''         : stored('StreetAddress2');
      STRING25 city_val2 := ''           : stored('City2');
      STRING2 state_val2 := ''           : stored('State2');
      STRING5 zip_value2 := ''           : stored('Zip2');
      STRING25 country_value2 := ''      : stored('Country2');
      STRING9 ssn_value2 := ''           : stored('ssn2');
      STRING8 dob_value2 := ''           : stored('DateOfBirth2');
      UNSIGNED1 age_value2 := 0          : stored('Age2');
      STRING20 dl_number_value2 := ''    : stored('DLNumber2');
      STRING2 dl_state_value2 := ''      : stored('DLState2');
      STRING100 email_value2 := ''       : stored('Email2');
      STRING45 ip_value2 := ''           : stored('IPAddress2');
      STRING10 phone_value2 := ''        : stored('HomePhone2');
      STRING10 wphone_value2 := ''       : stored('WorkPhone2');
      STRING100 employe_name_value2 := '' : stored('EmployerName2');
      STRING30 prev_lname_value2 := ''    : stored('FormerName2');
			
			unsigned3 history_date := 999999	: stored('HistoryDateYYYYMM');
      string20	historyDateTimeStamp := '' : stored('historyDateTimeStamp');  // new for shell 5.0
	 
   rec := RECORD
     UNSIGNED4 seq;
   END;
	 
   d_internal := dataset([{(unsigned)account_value}],rec);

   Mortgage_Fraud.layouts.Layout_CIID_BtSt_In into_btst_in(d_internal int) := transform
 	   clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(addr1_val, city_val, state_val, zip_value);	
	   dl_num_clean := riskwise.cleanDL_num(dl_number_value);
	
	   self.Borrower1_In.seq := int.seq;
	
	   self.Borrower1_In.historydate := if(historyDateTimeStamp<>'',(unsigned)historyDateTimeStamp[1..6], history_date);
	   self.Borrower1_In.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
	
	   self.Borrower1_In.fname := stringlib.stringtouppercase(fname_val);
	   self.Borrower1_In.mname := stringlib.stringtouppercase(mname_val);
	   self.Borrower1_In.lname := stringlib.stringtouppercase(lname_val);
	   self.Borrower1_In.suffix := stringlib.stringtouppercase(suffix_val);
	   self.Borrower1_In.in_streetAddress := stringlib.stringtouppercase(addr1_val);
	   self.Borrower1_In.in_city := stringlib.stringtouppercase(city_val);
	   self.Borrower1_In.in_state := stringlib.stringtouppercase(state_val);
	   self.Borrower1_In.in_zipCode := zip_value;
	   self.Borrower1_In.prim_range := clean_a[1..10];
	   self.Borrower1_In.predir := clean_a[11..12];
	   self.Borrower1_In.prim_name := clean_a[13..40];
	   self.Borrower1_In.addr_suffix := clean_a[41..44];
	   self.Borrower1_In.postdir := clean_a[45..46];
	   self.Borrower1_In.unit_desig := clean_a[47..56];
	   self.Borrower1_In.sec_range := clean_a[57..65];
	   self.Borrower1_In.p_city_name := clean_a[90..114];
	   self.Borrower1_In.st := clean_a[115..116];
	   self.Borrower1_In.z5 := clean_a[117..121];
	   self.Borrower1_In.zip4 := clean_a[122..125];
	   self.Borrower1_In.lat := clean_a[146..155];
	   self.Borrower1_In.long := clean_a[156..166];
	   self.Borrower1_In.addr_type := clean_a[139];
	   self.Borrower1_In.addr_status := clean_a[179..182];
	   self.Borrower1_In.county := clean_a[143..145];
	   self.Borrower1_In.geo_blk := clean_a[171..177];
	   self.Borrower1_In.ssn		:= ssn_value;
	   self.Borrower1_In.dob		:= dob_value;
	   self.Borrower1_In.age := if (age_value = 0 and (integer)dob_value != 0, 
														(STRING3)ut.GetAgeI_asOf((unsigned)dob_value, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
														(STRING3)age_value);
	   self.Borrower1_In.dl_number := stringlib.stringtouppercase(dl_num_clean);
	   self.Borrower1_In.dl_state := stringlib.stringtouppercase(dl_state_value);
	   self.Borrower1_In.email_address	:= stringlib.stringtouppercase(email_value);
	   SELF.Borrower1_In.ip_address := ip_value;
	   self.Borrower1_In.phone10 := phone_value;
	   self.Borrower1_In.wphone10 := wphone_value;
	   self.Borrower1_In.employer_name := stringlib.stringtouppercase(employe_name_value);		
	   SELF.Borrower1_In.lname_prev := stringlib.stringtouppercase(prev_lname_value);

     clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr1_val2, city_val2, state_val2, zip_value2);	
	   dl_num_clean2 := riskwise.cleanDL_num(dl_number_value2);
	
	   self.Borrower2_In.seq := int.seq;
	
	   self.Borrower2_In.historydate := if(historyDateTimeStamp<>'',(unsigned)historyDateTimeStamp[1..6], history_date);
	   self.Borrower2_In.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
	
	   self.Borrower2_In.fname := stringlib.stringtouppercase(fname_val2);
	   self.Borrower2_In.mname := stringlib.stringtouppercase(mname_val2);
	   self.Borrower2_In.lname := stringlib.stringtouppercase(lname_val2);
	   self.Borrower2_In.suffix := stringlib.stringtouppercase(suffix_val2);
	   self.Borrower2_In.in_streetAddress := stringlib.stringtouppercase(addr1_val2);
	   self.Borrower2_In.in_city := stringlib.stringtouppercase(city_val2);
	   self.Borrower2_In.in_state := stringlib.stringtouppercase(state_val2);
	   self.Borrower2_In.in_zipCode := zip_value2;
	   self.Borrower2_In.prim_range := clean_a2[1..10];
	   self.Borrower2_In.predir := clean_a2[11..12];
	   self.Borrower2_In.prim_name := clean_a2[13..40];
	   self.Borrower2_In.addr_suffix := clean_a2[41..44];
	   self.Borrower2_In.postdir := clean_a2[45..46];
	   self.Borrower2_In.unit_desig := clean_a2[47..56];
	   self.Borrower2_In.sec_range := clean_a2[57..65];
	   self.Borrower2_In.p_city_name := clean_a2[90..114];
	   self.Borrower2_In.st := clean_a2[115..116];
	   self.Borrower2_In.z5 := clean_a2[117..121];
	   self.Borrower2_In.zip4 := clean_a2[122..125];
	   self.Borrower2_In.lat := clean_a2[146..155];
	   self.Borrower2_In.long := clean_a2[156..166];
	   self.Borrower2_In.addr_type := clean_a2[139];
	   self.Borrower2_In.addr_status := clean_a2[179..182];
	   self.Borrower2_In.county := clean_a2[143..145];
	   self.Borrower2_In.geo_blk := clean_a2[171..177];
	   self.Borrower2_In.ssn		:= ssn_value2;
	   self.Borrower2_In.dob		:= dob_value2;
	   self.Borrower2_In.age := if (age_value2 = 0 and (integer)dob_value2 != 0, 
														(STRING3)ut.GetAgeI_asOf((unsigned)dob_value2, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
														(STRING3)age_value2);
	   self.Borrower2_In.dl_number := stringlib.stringtouppercase(dl_num_clean2);
	   self.Borrower2_In.dl_state := stringlib.stringtouppercase(dl_state_value2);
	   self.Borrower2_In.email_address	:= stringlib.stringtouppercase(email_value2);
	   self.Borrower2_In.ip_address := ip_value2;
	   self.Borrower2_In.phone10 := phone_value2;
	   self.Borrower2_In.wphone10 := wphone_value2;
	   self.Borrower2_In.employer_name := stringlib.stringtouppercase(employe_name_value2);		
	   self.Borrower2_In.lname_prev := stringlib.stringtouppercase(prev_lname_value2);
	
	   self := [];
   END;                  // end of this TRANSFORM
   
	prep := project(d_internal,into_btst_in(LEFT)); 
	 
	RETURN prep;  
  END;                   // end of this FUNCTION
	
	
	
	 EXPORT ON_GATEWAY(version)  := FUNCTION
     gateways_in := Gateway.Configuration.Get();
     Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	      self.servicename := le.servicename;
	      self.url := if(Gateway.Configuration.IsNetAcuity(le.servicename) or le.servicename='veris' or 
			              (version >= 50 and stringlib.StringToLowerCase(trim(le.servicename)) in [Gateway.Constants.ServiceName.DeltaInquiry]), le.url,  ''); //netacuity will be the only gateway we use in the bocashell processing, default to no gateway call			 
	      self := le;
     END;                 // end of this TRANSFORM
   
	   gateways := project(gateways_in, gw_switch(left));
	 RETURN gateways;
   END;                   // end of this FUNCTION
	
END;                     // end of this MODULE 