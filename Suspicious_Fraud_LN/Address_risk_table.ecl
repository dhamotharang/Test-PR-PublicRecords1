import header,ut,Business_Header,header_quick,doxie_build,risk_indicators,mdr,Address, uspis_hotlist,riskwise,inquiry_acclogs,advo,aca,watchdog;
//export Address_Risk_Table(dataset(header.layout_header) infile) := function
export Address_risk_table(boolean isFCRA) := function

has_valid_addr(string28 prim_name,string5 zip, string4 zip4) := trim(prim_name)<>'' and length(trim(stringlib.StringFilter(zip,'0123456789')))=5 and (integer)zip<>0;
has_valid_personal_addr(string28 prim_name, string5 zip, string4 zip4) := prim_name[1..6] != 'PO BOX' and trim(prim_name)<>'' and length(trim(stringlib.StringFilter(zip,'0123456789')))=5 and (integer)zip<>0
and zip4 not in ['9999','0000'];

h_full := if(isFCRA,doxie_build.file_FCRA_header_building,doxie_build.file_header_building)(has_valid_personal_addr((string28)prim_name,(string5)zip, (string4)zip4) and ~risk_indicators.iid_constants.filtered_source(src, st));

h_quick := project( header_quick.file_header_quick (has_valid_personal_addr((string28)prim_name,(string5)zip,(string4)zip4) and ~risk_indicators.iid_constants.filtered_source(src, st)), 
transform(header.Layout_Header, self.src := IF(left.src in ['QH', 'WH'], MDR.sourceTools.src_Equifax, left.src), self := left));							

df_bus := business_header.files('').base.business_headers.qa(has_valid_addr((string28)prim_name,(string5)zip,(string4)zip4));
//all US address 

/*0 = business or unknown, 1 = single fmaily, 2 = multi-family, 9 = po box*/
dk_advo := pull(Advo.Key_Addr1(has_valid_addr(prim_name,zip, zip4)));

//inquiry address

dk_inquiry_addr := pull(Inquiry_AccLogs.Key_Inquiry_Address + Inquiry_AccLogs.Key_Inquiry_Address_update)(has_valid_addr(prim_name,zip, person_q.zip4 ));

dk_inquiry := dk_inquiry_addr(person_q.fname != '' and person_q.lname != '' and bus_intel.vertical != 'PENDING ASSIGNMENT' and bus_intel.industry != 'BLANK' );

//HRI created from business header
dk_HRI := risk_indicators.files('').HRIAddressSicCode.built(has_valid_addr(prim_name,zip,zip4));

//Criminal records

//USPIS hot file - 

dk_USPIS := pull(USPIS_HotList.key_addr_search_zip(has_valid_addr(prim_name,zip,zip4) and trim(comments) <> ''));

//ACA -- checking prison 

dk_ACA :=  pull(aca.key_aca_addr(has_valid_addr(prim_name,zip,zip4)));


watchdog_bestaddr := Watchdog.File_Best;

watchdog_bestaddr_slim := project(watchdog_bestaddr, transform(Suspicious_Fraud_LN.layouts.slim_address, self.prim_range := (string10)left.prim_range, 
self.predir := (string2)left.predir,self.prim_name := (string28)left.prim_name, self.suffix:= (string4)left.suffix,self.postdir := (string2)left.postdir,
self.unit_desig := (string10)left.unit_desig,self.sec_range := (string8)left.sec_range, self.city_name := (string25)left.city_name,self.zip :=(string5)left.zip,
self.dt_first_seen := (unsigned3)left.addr_dt_first_seen, self.dt_last_seen := left.addr_dt_last_seen, 
self.address_id := hash64(self.prim_range,self.predir,self.prim_name,self.suffix,self.postdir,self.unit_desig,self.sec_range, self.city_name,left.st,self.zip),
self.bdid := (unsigned6)left.bdid,self := left, self := []));

//combine all addr sources

h_full_quick_slim := project(h_full + h_quick, transform(Suspicious_Fraud_LN.layouts.slim_address, self.prim_range := (string10)left.prim_range, 
self.predir := (string2)left.predir,self.prim_name := (string28)left.prim_name, self.suffix:= (string4)left.suffix,self.postdir := (string2)left.postdir,
self.unit_desig := (string10)left.unit_desig,self.sec_range := (string8)left.sec_range, self.city_name := (string25)left.city_name,self.zip :=(string5)left.zip,
self.address_id := hash64(self.prim_range,self.predir,self.prim_name,self.suffix,self.postdir,self.unit_desig,self.sec_range, self.city_name,left.st,self.zip),
self := left, self := []));

df_bus_slim := project(df_bus, transform(Suspicious_Fraud_LN.layouts.slim_address, self.prim_range := (string10)left.prim_range, 
self.predir := (string2)left.predir,self.prim_name := (string28)left.prim_name, self.suffix:= (string4)left.addr_suffix,self.postdir := (string2)left.postdir,
self.unit_desig := (string10)left.unit_desig,self.sec_range := (string8)left.sec_range,self.city_name := (string25)left.city,self.st := (string2)left.state,self.zip :=(string5)left.zip, 
self.address_id := hash64(self.prim_range,self.predir,self.prim_name,self.suffix,self.postdir,self.unit_desig,self.sec_range,self.city_name,self.st,self.zip),
self.dt_first_seen :=(unsigned3)left.dt_first_seen[1..6], 
self.dt_last_seen :=(unsigned3)left.dt_last_seen[1..6],
self.dt_vendor_first_reported :=(unsigned3)left.dt_vendor_first_reported[1..6], 
self.dt_vendor_last_reported :=(unsigned3)left.dt_vendor_last_reported[1..6],
self := left, self := []));
dk_advo_slim  := project(dk_advo, transform(Suspicious_Fraud_LN.layouts.slim_address, 

self.address_id := hash64(left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name,left.st,left.zip);

self.dt_first_seen :=(unsigned3)left.date_first_seen[1..6], 
self.dt_last_seen :=(unsigned3)left.date_last_seen[1..6],
self.dt_vendor_first_reported :=(unsigned3)left.date_vendor_first_reported[1..6], 
self.dt_vendor_last_reported :=(unsigned3)left.date_vendor_last_reported[1..6],

self.suffix := left.addr_suffix,
self.city_name := left.v_city_name,

self.dt_first_seen_vacant := if(left.address_vacancy_indicator = 'Y' and trim(left.prim_name,left,right)[1..6] != 'PO BOX',Suspicious_Fraud_LN.fn_dt_first_seen(self.dt_vendor_first_reported,self.dt_first_seen), 0),
self.dt_last_seen_vacant := if(left.address_vacancy_indicator = 'Y'  and trim(left.prim_name,left,right)[1..6] != 'PO BOX',Suspicious_Fraud_LN.fn_dt_last_seen(self.dt_vendor_last_reported,self.dt_last_seen),0),
self.dt_first_seen_educational_institution := if(left.seasonal_delivery_indicator = 'E',Suspicious_Fraud_LN.fn_dt_first_seen(self.dt_vendor_first_reported,self.dt_first_seen),0),
self.dt_last_seen_educational_institution := if(left.seasonal_delivery_indicator = 'E', Suspicious_Fraud_LN.fn_dt_last_seen(self.dt_vendor_last_reported,self.dt_last_seen),0),
self.dt_first_seen_CMRA := if(left.drop_indicator = 'C', Suspicious_Fraud_LN.fn_dt_first_seen(self.dt_vendor_first_reported,self.dt_first_seen),0),
self.dt_last_seen_CMRA := if(left.drop_indicator = 'C', Suspicious_Fraud_LN.fn_dt_last_seen(self.dt_vendor_first_reported,self.dt_first_seen),0),
self.dt_first_seen_pobox_vacant := if(left.address_vacancy_indicator = 'Y' and trim(left.prim_name,left,right)[1..6]  = 'PO BOX',Suspicious_Fraud_LN.fn_dt_first_seen(self.dt_vendor_first_reported,self.dt_first_seen),0),
self.dt_last_seen_pobox_vacant := if(left.address_vacancy_indicator = 'Y' and trim(left.prim_name,left,right)[1..6]  = 'PO BOX',Suspicious_Fraud_LN.fn_dt_last_seen(self.dt_vendor_first_reported,self.dt_first_seen),0),

self := left, self := []));

dk_inquiry_slim  := project(dk_inquiry, transform(Suspicious_Fraud_LN.layouts.slim_address,
self.prim_range := trim(left.person_q.prim_range,left,right), 
self.predir := trim(left.person_q.predir,left,right),
self.prim_name := trim(left.person_q.prim_name,left,right),
self.suffix:= trim(left.person_q.addr_suffix,left,right),
self.postdir := trim(left.person_q.postdir,left,right),
self.unit_desig := trim(left.person_q.unit_desig, left,right),
self.sec_range := trim(left.person_q.sec_range,left,right),
self.city_name := trim(left.person_q.v_city_name, left,right),
self.st := trim(left.person_q.st,left,right),
self.zip := trim(left.person_q.zip,left,right), 
self.address_id := hash64(self.prim_range,self.predir,self.prim_name,self.suffix,self.postdir,self.unit_desig,self.sec_range, 
self.city_name,self.st,self.zip);
self.log_date := trim(left.search_info.datetime[1..8]),
self.good_fraudsearch_inquiry := Inquiry_AccLogs.shell_constants.Valid_Suspicious_Fraud_Inquiry((unsigned3)ut.getdate[1..6], self.log_date, left.bus_intel.industry,left.search_info.function_description,left.bus_intel.use), 
self := left,self := []));
dk_HRI_slim := project(dk_HRI,transform(Suspicious_Fraud_LN.layouts.slim_address,self.suffix := left.addr_suffix,self.city_name := left.city,self.st := left.state, 
self.address_id := hash64(left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range, left.city, left.state,left.zip),
self.dt_first_seen_transient := left.dt_first_seen,
self.dt_last_seen_transient  := if(left.dt_first_seen > 0, (unsigned3)ut.GetDate[1..6], 0),

self := left, self := []));
dk_USPIS_slim := project(dk_USPIS,transform(Suspicious_Fraud_LN.layouts.slim_address,self.city_name := left.v_city_name,self.suffix := left.addr_suffix,
self.address_id := hash64(left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range, left.v_city_name, left.st,left.zip);
self.dt_first_seen_USPISHotList := (unsigned3)left.dt_first_reported[1..6], 
self.dt_last_seen_USPISHotList := (unsigned3)left.dt_last_reported[1..6],
self := left, self := []));

dk_ACA_slim := project(dk_ACA,transform(Suspicious_Fraud_LN.layouts.slim_address, 
self.address_id := hash64(left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name, left.st,left.zip);
self.suffix := left.addr_suffix,
self.city_name := left.v_city_name;
self.dt_first_seen_prison := if(left.zip != '', (unsigned3)ut.GetDate[1..6], 0),
self.dt_last_seen_prison := if(left.zip != '', (unsigned3)ut.GetDate[1..6], 0),
self := left, self := []));

//count A01
out_A01_dates := //Suspicious_Fraud_LN.fn_Addr_A01(dk_HRI_slim);
dk_HRI_slim;
//count A02 dates
out_A02_dates := dk_USPIS_slim;
//count A03 and A04
out_A03_04_dates := Suspicious_Fraud_LN.fn_Addr_A03_A04(dk_inquiry_slim);

//count A07
out_A07_09_17_18_dates := dk_advo_slim;
//count A08
out_A08_dates := Suspicious_Fraud_LN.fn_Addr_A08(watchdog_bestaddr_slim);

//count A10
out_A10_dates := Suspicious_Fraud_LN.fn_Addr_A10(df_bus_slim);

//count A11

out_A11_dates := dk_ACA_slim;

h_addr_A01_02_03_04_07_08_09_10_11_17_18_dates := out_A01_dates + out_A02_dates + out_A03_04_dates + 
out_A07_09_17_18_dates + out_A08_dates  + out_A10_dates + out_A11_dates : persist('~thor_data400::persist::d_addr_all_risk_codes');


h_addr_combine_dist := distribute(h_addr_A01_02_03_04_07_08_09_10_11_17_18_dates,address_id);

h_addr_combine_sort := sort(h_addr_combine_dist,address_id,-address_type,local);

Suspicious_Fraud_LN.layouts.slim_address trollup_all(h_addr_combine_sort ri, h_addr_combine_sort le) := transform

self.dt_first_seen_transient := ut.min2(le.dt_first_seen_transient, ri.dt_first_seen_transient);
self.dt_first_seen_uspishotlist := ut.min2(le.dt_first_seen_uspishotlist, ri.dt_first_seen_uspishotlist);
self.dt_first_seen_searchcountyear := ut.min2(le.dt_first_seen_searchcountyear, ri.dt_first_seen_searchcountyear);
self.dt_first_seen_searchcountmonth := ut.min2(le.dt_first_seen_searchcountmonth, ri.dt_first_seen_searchcountmonth);
self.dt_first_seen_vacant := ut.min2(le.dt_first_seen_vacant, ri.dt_first_seen_vacant);
self.dt_first_seen_didcnt := ut.min2(le.dt_first_seen_didcnt, ri.dt_first_seen_didcnt);
self.dt_first_seen_educational_institution := ut.min2(le.dt_first_seen_educational_institution, ri.dt_first_seen_educational_institution);
//self.dt_first_seen_not_personal_property := ut.min2(le.dt_first_seen_not_personal_property, ri.dt_first_seen_not_personal_property);
self.dt_first_seen_bdidcnt := ut.min2(le.dt_first_seen_bdidcnt, ri.dt_first_seen_bdidcnt);
self.dt_first_seen_prison := ut.min2(le.dt_first_seen_prison, ri.dt_first_seen_prison);
self.dt_first_seen_cmra := ut.min2(le.dt_first_seen_cmra, ri.dt_first_seen_cmra);
self.dt_first_seen_pobox_vacant := ut.min2(le.dt_first_seen_pobox_vacant, ri.dt_first_seen_pobox_vacant);
self.dt_last_seen_transient := ut.max2(le.dt_last_seen_transient, ri.dt_last_seen_transient);
self.dt_last_seen_uspishotlist := ut.max2(le.dt_last_seen_uspishotlist, ri.dt_last_seen_uspishotlist);
self.dt_last_seen_searchcountyear := ut.max2(le.dt_last_seen_searchcountyear, ri.dt_last_seen_searchcountyear);
self.dt_last_seen_searchcountmonth := ut.max2(le.dt_last_seen_searchcountmonth, ri.dt_last_seen_searchcountmonth);
self.dt_last_seen_vacant := ut.max2(le.dt_last_seen_vacant, ri.dt_last_seen_vacant);
self.dt_last_seen_didcnt := ut.max2(le.dt_last_seen_didcnt, ri.dt_last_seen_didcnt);
self.dt_last_seen_educational_institution := ut.max2(le.dt_last_seen_educational_institution, ri.dt_last_seen_educational_institution);
//self.dt_last_seen_not_personal_property := ut.max2(le.dt_last_seen_not_personal_property, ri.dt_last_seen_not_personal_property);
self.dt_last_seen_bdidcnt := ut.max2(le.dt_last_seen_bdidcnt, ri.dt_last_seen_bdidcnt);
self.dt_last_seen_prison := ut.max2(le.dt_last_seen_prison, ri.dt_last_seen_prison);
self.dt_last_seen_cmra := ut.max2(le.dt_last_seen_cmra, ri.dt_last_seen_cmra);
self.dt_last_seen_pobox_vacant := ut.max2(le.dt_last_seen_pobox_vacant, ri.dt_last_seen_pobox_vacant);
self.address_type := if(le.address_type = '2', le.address_type, ri.address_type);
self.comments := if(le.comments <> '', le.comments, ri.comments);
self := le;

end;

h_addr_combine_rollup := rollup(h_addr_combine_sort,left.address_id = right.address_id,trollup_all(left,right),local) : persist('~thor_data400::persist::d_addr_all_risk_codes_no_POBOX');
//h_addr_combine_rollup := dataset('~thor_data400::persist::d_addr_all_risk_codes_no_POBOX', Suspicious_Fraud_LN.layouts.slim_address, flat);
//remove multiple dwelling without unit number
 
h_addr_combine_rollup_no_units := h_addr_combine_rollup(~(address_type = '2' and sec_range = '')) ;


 //final results
string		lRegEx			:=	'\\,[ ]*$';

fn_remove_ending_comma(string lTestString) := regexreplace(lRegEx, lTestString, '');

suspicious_addr_final_rec := Suspicious_Fraud_LN.layouts.extract_address_final;

suspicious_fraud_ln.layouts.extract_address_final tmakefatrecord(h_addr_combine_rollup_no_units Le) := transform

address1 := trim(le.prim_range + ' ' + le.predir + ' ' + le.prim_name + ' '  + le.suffix + ' ' + le.postdir + ' '
                         + le.unit_desig + ' ' + le.sec_range, left,right);
address2 := trim(trim(le.city_name,left,right) + if(le.city_name <> '',', ',' ') +
									 le.st + ' ' + le.zip, left,right);
string182 clean_address := Address.CleanAddress182(address1, address2);																								   	

string1 err_stat		:=	clean_address[179]	;

self.street_address := if(err_stat != 'E', address1, '');
self.suspicious_risk_code := 
 
 fn_remove_ending_comma(trim(if(le.dt_first_seen_transient != 0 ,'A01' + ',', '') +
 if(le.dt_first_seen_USPISHotList != 0,'A02' +  ',' , '') + 
 if(le.dt_first_seen_SearchCountYear != 0,'A03' +  ',' , '') + 
 if(le.dt_first_seen_SearchCountMonth != 0,'A04' +  ',' , '') +
 if(le.dt_first_seen_vacant != 0,'A07' + ',', '')  +
 if(le.dt_first_seen_DIDcnt != 0, 'A08' +  ',' , '') + 
 if(le.dt_first_seen_educational_institution != 0, 'A09' +  ',' , '') + 
 if(le.dt_first_seen_BDIDcnt != 0, 'A10' +  ',' , '') + 
 if(le.dt_first_seen_prison!= 0, 'A11' + ',', '') +
 if(le.dt_first_seen_CMRA != 0, 'A17' +  ',' , '') + 
 if(le.dt_first_seen_pobox_vacant != 0,'A18' +  ',' , '')
, left,right)),
self.dt_first_seen := (unsigned3)ut.min2( 
ut.Min2(ut.Min2(ut.Min2(le.dt_first_seen_transient,le.dt_first_seen_USPISHotList),
ut.Min2(le.dt_first_seen_SearchCountYear,le.dt_first_seen_SearchCountMonth)),
ut.Min2(ut.Min2(le.dt_first_seen_vacant,le.dt_first_seen_DIDcnt),
ut.Min2(le.dt_first_seen_educational_institution,le.dt_first_seen_BDIDcnt))),
ut.Min2(ut.Min2(le.dt_first_seen_prison,le.dt_first_seen_CMRA),le.dt_first_seen_pobox_vacant));
self.dt_last_seen := (unsigned3)ut.MAX2( 
ut.max2(ut.max2(ut.max2(le.dt_last_seen_transient,le.dt_last_seen_USPISHotList),
ut.max2(le.dt_last_seen_SearchCountYear,le.dt_last_seen_SearchCountMonth)),
ut.max2(ut.max2(le.dt_last_seen_vacant,le.dt_last_seen_DIDcnt),
ut.max2(le.dt_last_seen_educational_institution,le.dt_last_seen_BDIDcnt))),
ut.max2(ut.max2(le.dt_last_seen_prison,le.dt_last_seen_CMRA),le.dt_last_seen_pobox_vacant));

self.uspis_comments := row(Le,suspicious_fraud_ln.layouts.layout_uspis_comments);
self := Le;

end;

file_fat := project(h_addr_combine_rollup_no_units(prim_name <> '' and trim(prim_name)not in ['\'', '0']), tmakefatrecord(left));

file_fat_sort :=  sort(file_fat(suspicious_risk_code <> '' and street_address <> ''),address_id,local);

suspicious_fraud_ln.layouts.extract_address_final tmakechildren(suspicious_fraud_ln.layouts.extract_address_final Le, suspicious_fraud_ln.layouts.extract_address_final Ri) := transform

self.uspis_comments := Le.uspis_comments + row({ri.uspis_comments[1].comments},suspicious_fraud_ln.layouts.layout_uspis_comments);
self := Le;
end;

outf_rollup := rollup(file_fat_sort,address_id,tmakechildren(left, right));
//cleanup address


outf_final := project(outf_rollup(dt_last_seen >= dt_first_seen), suspicious_fraud_ln.layouts.extract_address);


return outf_final;

end;
