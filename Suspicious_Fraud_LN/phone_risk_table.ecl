import header,ut,Inquiry_AccLogs,gong,riskwise,doxie,risk_indicators,watchdog,doxie_files, doxie_build, mdr, header_quick,phonesplus_v2,Suspicious_Fraud_LN;

export phone_Risk_Table(boolean isFCRA) := function

key_phonesplus := Phonesplus_v2.Key_Phonesplus_Did((unsigned)cellphone > 0);

suspicious_phone_slim_rec := Suspicious_Fraud_LN.layouts.slim_phone;

suspicious_phone_final_rec := Suspicious_Fraud_LN.layouts.extract_phone;

key_phonesplus_slim := project(key_phonesplus, transform(suspicious_phone_slim_rec,
self.phone10 := left.cellphone, 
  self.dt_first_seen := Suspicious_Fraud_LN.fn_dt_first_seen(left.datevendorfirstreported, left.datefirstseen);
	self.dt_last_seen := Suspicious_Fraud_LN.fn_dt_last_seen(left.datevendorlastreported, left.datelastseen);
self := left, self := []));

key_phonesplus_has_pager := key_phonesplus_slim(append_phone_type = 'PAGE');

key_phonesplus_non_pager := key_phonesplus_slim(~(append_phone_type = 'PAGE'));

key_phone := IF(isFCRA, Gong.Key_FCRA_Business_Header_Phone_Table_Filtered_V2, Risk_Indicators.Key_Phone_Table_v2);

//append phone type from fraudpoint
key_phone_dist := distribute(key_phone, hash(phone10));
			
			suspicious_phone_slim_rec tappendflag(key_phonesplus_non_pager le,	key_phone_dist ri) := transform
			
			self.hriskphoneflag := 
						risk_indicators.PRIIPhoneRiskFlag(le.phone10).phoneRiskFlag(ri.nxx_type, ri.potDisconnect, ri.sic_code),
			self.hphonetypeflag :=				
						risk_indicators.PRIIPhoneRiskFlag(le.phone10).PWphoneRiskFlag(ri.nxx_type, ri.sic_code);
												
						self := le;
						
						end;

 key_phonesplus_has_type:= 
				join(distribute(key_phonesplus_non_pager,hash(phone10)), key_phone_dist,
					(integer)left.phone10 != 0 and
					left.phone10=right.phone10,
					tappendflag(left,right),left outer, local,
					ATMOST(left.phone10 =right.phone10, RiskWise.max_atmost), keep(100));
	
//append phone type

key_phone_type := project(key_phone, transform(suspicious_phone_slim_rec,

self.hriskphoneflag := 
						risk_indicators.PRIIPhoneRiskFlag(left.phone10).phoneRiskFlag(left.nxx_type, left.potDisconnect, left.sic_code),
	
self.hphonetypeflag := 
						risk_indicators.PRIIPhoneRiskFlag(left.phone10).PWphoneRiskFlag(left.nxx_type, left.sic_code),
						 self.dt_first_seen := left.dt_first_seen;
						self.dt_last_seen := if(left.iscurrent, (unsigned3)ut.GetDate[1..6], 0);
            self.dt_first_seen_pager := if(self.hriskphoneflag = '2' or self.hphonetypeflag = '2', self.dt_first_seen, 0),
  					self.dt_last_seen_pager := if(self.hriskphoneflag = '2' or self.hphonetypeflag = '2', self.dt_last_seen, 0),
						self.dt_first_seen_transient_commercial :=  if(self.hriskphoneflag = '6', self.dt_first_seen, 0),
           	self.dt_last_seen_transient_commercial :=  if(self.hriskphoneflag = '6', self.dt_last_seen, 0),
 
						self.dt_first_seen_disconnect :=  if(self.hriskphoneflag = '5', self.dt_first_seen, 0),
           	self.dt_last_seen_disconnect :=  if(self.hriskphoneflag = '5', self.dt_last_seen, 0),
            self.dt_first_seen_payphone :=  if(self.hphonetypeflag = 'A' or regexfind('PAYPHONE|PAY PHONE', left.lname), self.dt_first_seen, 0),
           	self.dt_last_seen_payphone :=  if(self.hphonetypeflag = 'A' or regexfind('PAYPHONE|PAY PHONE', left.lname), self.dt_last_seen, 0),
							self := left, self := [] ));				
/*self.phone_type := map(hriskphoneflag = '2' or hphonetypeflag = '2' => '2', 
                       hriskphoneflag = '5' => '5', 
                       hriskphoneflag = '6' => '6',
                       hphonetypeflag = 'A' or regexfind('PAYPHONE|PAY PHONE', lname) => 'A', hphonetypeflag),
						           self := left, self := [] ));

key_phonesplus_pager := project(key_phonesplus_has_pager, transform(suspicious_phone_slim_rec
					//	self.phone_type := left.append_phone_type,
					  self.dt_first_seen_pager := if(left.append_phone_type = 'PAGE', fn_date_first_seen(left.datefirstseen,left.datevendorfirstreported), 0),
  					self.dt_last_seen_pager := if(left.append_phone_type = 'PAGE', fn_date_last_seen(left.datelastseen,left.datevendorlastreported), 0),
						self := left, self := []));*/
						
						
key_phonesplus_type := project(key_phonesplus_has_type + key_phonesplus_has_pager, transform(suspicious_phone_slim_rec,
					//	self.phone_type := left.append_phone_type,
					
					  self.dt_first_seen_pager := if(left.hriskphoneflag = '2' or left.hphonetypeflag = '2' or left.append_phone_type = 'PAGE', left.dt_first_seen, 0),
  					self.dt_last_seen_pager := if(left.hriskphoneflag = '2' or left.hphonetypeflag = '2' or left.append_phone_type = 'PAGE', left.dt_last_seen, 0),
						self.dt_first_seen_transient_commercial :=  if(left.hriskphoneflag = '6', left.dt_first_seen, 0),
           	self.dt_last_seen_transient_commercial :=  if(left.hriskphoneflag = '6', left.dt_last_seen, 0),
 
						self.dt_first_seen_disconnect :=  if(left.hriskphoneflag = '5', left.dt_first_seen, 0),
           	self.dt_last_seen_disconnect :=  if(left.hriskphoneflag = '5', left.dt_last_seen, 0),
            self.dt_first_seen_payphone :=  if(left.hphonetypeflag = 'A' or regexfind('PAYPHONE|PAY PHONE', left.lname), left.dt_first_seen, 0),
           	self.dt_last_seen_payphone :=  if(left.hphonetypeflag = 'A' or regexfind('PAYPHONE|PAY PHONE', left.lname), left.dt_last_seen, 0),
					
						self := left, self := []));
	
	//count DID per phone10
	
	phone_combine := key_phone_type + key_phonesplus_slim;
	

	phone_DID_rec := record
	
	phone_combine.phone10;
	phone_combine.DID;
  dt_first_seen := min(group, if(phone_combine.dt_first_seen = 0, 999999, phone_combine.dt_first_seen));
  dt_last_seen :=  max(group, phone_combine.dt_last_seen);
	
	cnt := COUNT(GROUP);
	end;
	
Phone_DID_cnt := table(distribute(phone_combine((unsigned6)did > 0),hash(phone10)), phone_DID_rec, phone10, DID, local): persist('~thor_data400::persist::d_full_phone_did');

Suspicious_Fraud_LN.fn_phone_P09(Phone_DID_cnt, out_P09_dates)

//inquiry tracking
goodphone(string10 s) := (INTEGER)s<>0 AND LENGTH(Stringlib.stringfilter(s,'0123456789'))=10;

key_inquiry_phone_slim := project((pull(Inquiry_AccLogs.Key_Inquiry_Phone) + pull(Inquiry_AccLogs.Key_Inquiry_Phone_Update))(goodphone(phone10)),
transform(suspicious_phone_slim_rec,
self.log_date := trim(left.search_info.datetime[1..8]),
self.good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.Valid_Suspicious_Fraud_Inquiry((unsigned3)ut.getdate[1..6], self.log_date, left.bus_intel.industry,left.search_info.function_description,left.bus_intel.use), 
self := left,self := []));

Suspicious_Fraud_LN.fn_phone_P03_P04(key_inquiry_phone_slim, out_P03_04_dates);

//combine all risk files 
h_Phone_P01_02_03_04_07_08_09_dates := phone_combine + out_P03_04_dates + out_P09_dates;
//getting good phone
h_Phone_P01_02_03_04_07_08_09_clean := project(h_Phone_P01_02_03_04_07_08_09_dates, transform(Suspicious_Fraud_LN.layouts.slim_phone,
self.phone10 := Phonesplus_v2.Fn_Clean_Phone10(left.phone10), self := left))(~(phone10[1..3] = '000' or phone10[4..10] = '0000000')): persist('~thor_data400::persist::d_Phoneall_risk_codes');

h_Phone_combine_dist := distribute(h_Phone_P01_02_03_04_07_08_09_clean,hash(phone10));
h_Phone_combine_sort := sort(h_Phone_combine_dist,phone10,local);

Suspicious_Fraud_LN.layouts.slim_phone trollup_all(h_Phone_combine_sort ri, h_Phone_combine_sort le) := transform
	
self.dt_first_seen_pager := ut.min2(le.dt_first_seen_pager, ri.dt_first_seen_pager);
self.dt_first_seen_transient_commercial := ut.min2(le.dt_first_seen_transient_commercial, ri.dt_first_seen_transient_commercial);
self.dt_first_seen_searchcountyear := ut.min2(le.dt_first_seen_searchcountyear, ri.dt_first_seen_searchcountyear);
self.dt_first_seen_searchcountmonth := ut.min2(le.dt_first_seen_searchcountmonth, ri.dt_first_seen_searchcountmonth);
self.dt_first_seen_disconnect := ut.min2(le.dt_first_seen_disconnect, ri.dt_first_seen_disconnect);
self.dt_first_seen_payphone := ut.min2(le.dt_first_seen_payphone, ri.dt_first_seen_payphone);
self.dt_first_seen_DIDcnt := ut.min2(le.dt_first_seen_DIDcnt, ri.dt_first_seen_DIDcnt);

self.dt_last_seen_pager := ut.max2(le.dt_last_seen_pager, ri.dt_last_seen_pager);
self.dt_last_seen_transient_commercial := ut.max2(le.dt_last_seen_transient_commercial, ri.dt_last_seen_transient_commercial);
self.dt_last_seen_searchcountyear := ut.max2(le.dt_last_seen_searchcountyear, ri.dt_last_seen_searchcountyear);
self.dt_last_seen_searchcountmonth := ut.max2(le.dt_last_seen_searchcountmonth, ri.dt_last_seen_searchcountmonth);
self.dt_last_seen_disconnect := ut.max2(le.dt_last_seen_disconnect, ri.dt_last_seen_disconnect);
self.dt_last_seen_payphone := ut.max2(le.dt_last_seen_payphone, ri.dt_last_seen_payphone);
self.dt_last_seen_DIDcnt := ut.max2(le.dt_last_seen_DIDcnt, ri.dt_last_seen_DIDcnt);

self := le;

end;

h_Phone_rollup := rollup(h_Phone_combine_sort,left.phone10 = right.phone10,trollup_all(left,right),local) : persist('~thor_data400::persist::d_Phone_all_risk_codes_rollup');
//h_Phone_rollup := dataset('~thor_data400::persist::d_Phone_all_risk_codes_rollup', Suspicious_Fraud_LN.layouts.temp_phone, flat);
 
string		lRegEx			:=	'\\,[ ]*$';

fn_remove_ending_comma(string lTestString) := regexreplace(lRegEx, lTestString, '');


outf_phone := project(h_Phone_rollup, transform(suspicious_Phone_final_rec, 
self.phone := left.phone10,
self.suspicious_risk_code := 
 fn_remove_ending_comma(trim(if(left.dt_first_seen_pager not in [0,999999] ,'P01' + ',', '') +
 if(left.dt_first_seen_transient_commercial not in [0,999999],'P02' +  ',' , '') +
 if(left.dt_first_seen_SearchCountYear not in [0,999999], 'P03' +  ',' , '') + 
 if(left.dt_first_seen_SearchCountMonth not in [0,999999], 'P04' +  ',' , '') + 
 if(left.dt_first_seen_disconnect not in [0,999999], 'P07' +  ',' , '') + 
 if(left.dt_first_seen_payphone not in [0,999999], 'P08' +  ',' , '') +
 if(left.dt_first_seen_DIDcnt not in [0,999999], 'P09' +  ',' , '')
, left,right)),
self.dt_first_seen := (unsigned3)
ut.Min2(ut.Min2(ut.Min2(left.dt_first_seen_pager,left.dt_first_seen_transient_commercial),
ut.Min2(left.dt_first_seen_SearchCountYear,left.dt_first_seen_SearchCountMonth)),
ut.Min2(ut.Min2(left.dt_first_seen_disconnect,left.dt_first_seen_payphone), left.dt_first_seen_DIDcnt)),

self.dt_last_seen := (unsigned3) 
ut.Max2(ut.Max2(ut.Max2(left.dt_last_seen_pager,left.dt_last_seen_transient_commercial),
ut.Max2(left.dt_last_seen_SearchCountYear,left.dt_last_seen_SearchCountMonth)),
ut.Max2(ut.Max2(left.dt_last_seen_disconnect,left.dt_last_seen_payphone), left.dt_last_seen_DIDcnt)),
self := left));

 outf_final :=  dedup(sort(outf_phone(suspicious_risk_code <> '' and dt_last_seen >= dt_first_seen),phone,local), phone,local);
 
 return outf_final;
 
 end;