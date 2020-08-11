//NonFCRA Query Header Stats Watchdog Header
//W20200810-174548	Prod 

IMPORT _control, Header, Doxie, watchdog, ut, data_services;
export NonFCRA_QueryHeaderStatsWatchdogHdr(string pHostname, string pTarget, string pContact ='\' \'') := function

filedate := (STRING8)Std.Date.Today();
rpt_yyyymmdd := filedate[1..8];

Layout_hdr_data_key := RECORD
  unsigned6 s_did;
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
  unsigned4 global_sid;
  unsigned8 record_sid;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
END;

//Doxie.Key_Header
rec_nonkeyed_fields := Layout_hdr_data_key  - [s_did];
ds_hdr_key := PULL(INDEX({unsigned6 s_did}, rec_nonkeyed_fields, Data_Services.foreign_prod+'thor_data400::key::header_qa'));

Layout_hdr_data_topull := RECORD
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  udecimal9 current_age :=0;
END;

Layout_hdr_data_topull collecthdr (ds_hdr_key l) := transform
	self.current_age := ut.Age(l.dob);
	self := l;
end;

hdr_key := project(ds_hdr_key,collecthdr(left));

//sort files by DID
base_wdog_best := dataset(ut.foreign_prod + 'thor_data400::BASE::Watchdog_best', watchdog.layout_key, flat);

layout_watchdog_to_check := RECORD
  unsigned6 did;
  // qstring10 phone;
  // qstring9 ssn;
  // integer4 dob;
  // qstring20 fname;
  // qstring20 mname;
  // qstring20 lname;
  // qstring10 prim_range;
  // qstring28 prim_name;
  // qstring25 city_name;
  // string2 st;
  // qstring5 zip;
  qstring15 dl_number := '';
  string10 adl_ind := '';
  // udecimal9 current_age :=0;
end;
 
layout_watchdog_to_check collectwatchdog (base_wdog_best l) := transform
	// SELF.current_age  := ut.Age(l.dob);  
	self := l;
end;

watchdog_to_Check := project(base_wdog_best(did <> 0),layout_watchdog_to_check);
 
srt_hdr_key  := sort(distribute(hdr_key, hash(did)), did, local) : INDEPENDENT;
srt_wtchdog  := sort(distribute(watchdog_to_check,hash(did)),did,local): INDEPENDENT;

Hdr_watchdog := join(srt_hdr_key,srt_wtchdog,
                     left.did = right.did);
					 
//Output tables that break out the segments
tbl_HeaderCoreSegmentsJoin := table(Hdr_watchdog,{adl_ind,cnt:=count(group)},adl_ind,few);
tbl_WatchDogHeaderCoreSegments := table(watchdog_to_Check,{adl_ind,cnt:=count(group)},adl_ind,few);

// Can you break it down by LexID?
 // i.e. identity = single LexID/single consumer/person.
// As for the other questions, if
 // the LexID has 1 or more address on file, that would be considered an address.
// For SSN and DOB, I’m looking for
 // the % of our LexID’s that have both a Name and Address, then Name, Address,
 // DOB, then Name, Address, SSN, etc.  It does not have to be a ‘best
 // address’ or ‘best SSN’ or ‘best DOB’, just whether or not their LexID profile
 // has that data element present on it or not.
// Partial DOB’s are fine, we can
 // count that as a DOB, i.e. yes they have a DOB on file.
// Could you provide a breakdown of the coverage we have in sources that inform InstantID or in our database in general?
// % of records or identities that have Name and Address
// % of records or identities that have Name, Address, and DOB
// % of records or identities that have Name, Address, and DL Number
// % of records or identities that have Name, Address, and SSN
// % of records or identities that have Name, Address, SSN, and DOB
// % of records or identities that have Name, Address, SSN, DOB, and DL Number
// % of records or identities that have Name, Address, Phone
 // Even better, could you provide the above breakdown by 18-24 year olds vs. non 18-24 year olds?

// % of records or identities that have Name and Address
did_address := dedup(sort(distribute(hdr_watchdog(lname <> '' and prim_name <> '' and city_name <> '' and st <> ''),hash(did)),did,local),did,local);
tbl_DIDAddressHasNameAndAddress := table(did_address,{adl_ind,cnt:=count(group)},adl_ind,few);
 
// % of records or identities that have Name, Address, and DOB
 did_dob_address := dedup(sort(distribute(hdr_watchdog(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and dob <> 0),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndDOB := table(did_dob_address,{adl_ind,cnt:=count(group)},adl_ind,few);
  
// % of records or identities that have Name, Address, and DL Number
did_DL_address := dedup(sort(distribute(hdr_watchdog(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and dl_number <> ''),hash(did)),did,local),did,local);
tbl_DIDAddressHasNameAndAddressAndDL := table(did_DL_address,{adl_ind,cnt:=count(group)},adl_ind,few);
 
  // % of records or identities that have Name, Address, and SSN
 did_ssn_address := dedup(sort(distribute(hdr_watchdog(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> ''),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndSSN := table( did_ssn_address,{adl_ind,cnt:=count(group)},adl_ind,few);
 
  // % of records or identities that have Name, Address, SSN, and DOB
 did_ssn_DOB_address := dedup(sort(distribute(hdr_watchdog(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> '' and dob <> 0),hash(did)),did,local),did,local);
tbl_DIDAddressHasNameAndAddressAndSSNandDOB :=  table( did_ssn_DOB_address,{adl_ind,cnt:=count(group)},adl_ind,few);
 
   // % of records or identities that have Name, Address, SSN, DOB, and DL Number
 did_ssn_DOB_DL_address := dedup(sort(distribute(hdr_watchdog(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> '' and dob <> 0 and dl_number <> ''),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDL := table(did_ssn_DOB_DL_address,{adl_ind,cnt:=count(group)},adl_ind,few);
 
   // % of records or identities that have Name, Address, Phone
 did_Phone_address := dedup(sort(distribute(hdr_watchdog(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and phone <> '' ),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndPhone := table(did_Phone_address,{adl_ind,cnt:=count(group)},adl_ind,few);

  //18-24 year olds
 hdr_watchdog_18_24 := hdr_watchdog(current_age between 18 and 24);
 //  % of records or identities that have Name and Address
 did_address_1814 := dedup(sort(distribute(hdr_watchdog_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> ''),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddress1824 := table(did_address_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
   
 // % of records or identities that have Name, Address, and DOB
 did_dob_address_1814 := dedup(sort(distribute(hdr_watchdog_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and dob <> 0),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndDOB1824 := table(did_dob_address_1814,{adl_ind,cnt:=count(group)},adl_ind,few);

// % of records or identities that have Name, Address, and DL Number
did_DL_address_1814 := dedup(sort(distribute(hdr_watchdog_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and dl_number <> ''),hash(did)),did,local),did,local);
tbl_DIDAddressHasNameAndAddressAndDL1824 :=  table(did_DL_address_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
  // % of records or identities that have Name, Address, and SSN
 did_ssn_address_1814 := dedup(sort(distribute(hdr_watchdog_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> ''),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndSSN1824 := table( did_ssn_address_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
    // % of records or identities that have Name, Address, SSN, and DOB
 did_ssn_DOB_address_1814 := dedup(sort(distribute(hdr_watchdog_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> '' and dob <> 0),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndSSNandDOB1824 := table( did_ssn_DOB_address_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
   
 // % of records or identities that have Name, Address, SSN, DOB, and DL Number
 did_ssn_DOB_DL_address_1814 := dedup(sort(distribute(hdr_watchdog_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> '' and dob <> 0 and dl_number <> ''),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDL1824 := table(did_ssn_DOB_DL_address_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
 // % of records or identities that have Name, Address, Phone
 did_Phone_address_1814 := dedup(sort(distribute(hdr_watchdog_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and phone <> '' ),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndPhone1824 :=  table(did_Phone_address_1814, {adl_ind,cnt:=count(group)},adl_ind,few);

//not 18-24 year olds
 hdr_watchdog_not_18_24 := hdr_watchdog(current_age not between 18 and 24);
 //  % of records or identities that have Name and Address
 did_address_Not_1814 := dedup(sort(distribute(hdr_watchdog_not_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> ''),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressNot1824 := table(did_address_Not_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
 // % of records or identities that have Name, Address, and DOB
 did_dob_address_Not_1814 := dedup(sort(distribute(hdr_watchdog_not_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and dob <> 0),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndDOBNot1824 := table(did_dob_address_Not_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
// % of records or identities that have Name, Address, and DL Number
did_DL_address_Not_1814 := dedup(sort(distribute(hdr_watchdog_not_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and dl_number <> ''),hash(did)),did,local),did,local);
tbl_DIDAddressHasNameAndAddressAndDLNot1824 := table(did_DL_address_Not_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
 // % of records or identities that have Name, Address, and SSN
 did_ssn_address_Not_1814 := dedup(sort(distribute(hdr_watchdog_not_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> ''),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndSSNNot1824 := table( did_ssn_address_Not_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
 // % of records or identities that have Name, Address, SSN, and DOB
 did_ssn_DOB_address_Not_1814 := dedup(sort(distribute(hdr_watchdog_not_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> '' and dob <> 0),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndSSNandDOBNot1824 := table( did_ssn_DOB_address_Not_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
 // % of records or identities that have Name, Address, SSN, DOB, and DL Number
 did_ssn_DOB_DL_address_Not_1814 := dedup(sort(distribute(hdr_watchdog_not_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and ssn <> '' and dob <> 0 and dl_number <> ''),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDLNot1824 := table(did_ssn_DOB_DL_address_Not_1814,{adl_ind,cnt:=count(group)},adl_ind,few);
  
 // % of records or identities that have Name, Address, Phone
 did_Phone_address_Not_1814 := dedup(sort(distribute(hdr_watchdog_not_18_24(lname <> '' and prim_name <> '' and city_name <> '' and st <> '' and phone <> '' ),hash(did)),did,local),did,local);
 tbl_DIDAddressHasNameAndAddressAndPhoneNot1824 := table(did_Phone_address_Not_1814,{adl_ind,cnt:=count(group)},adl_ind,few);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_HeaderCoreSegmentsJoin:= STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_NonFCRA_HeaderCoreSegmentsJoin_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_NonFCRA_HeaderCoreSegmentsJoin_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);
																				
despray_WatchDogHeaderCoreSegments:= STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_NonFCRA_WatchDogHeaderCoreSegments_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_NonFCRA_WatchDogHeaderCoreSegments_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);
																				
despray_DIDAddressHasNameAndAddress:= STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddress_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddress_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);

despray_DIDAddressHasNameAndAddressAndDOB:= STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndDOB_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndDOB_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);

despray_DIDAddressHasNameAndAddressAndDL := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndDL_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndDL_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true); 

despray_DIDAddressHasNameAndAddressAndSSN := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSN_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSN_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);  

despray_DIDAddressHasNameAndAddressAndSSNandDOB := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSNandDOB_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSNandDOB_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);   

despray_DIDAddressHasNameAndAddressAndSSNandDOBAndDL := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDL_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDL_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);   

despray_DIDAddressHasNameAndAddressAndPhone := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndPhone_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndPhone_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);     

 despray_DIDAddressHasNameAndAddress1824 := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddress1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddress1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true); 

 despray_DIDAddressHasNameAndAddressAndDOB1824 := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndDOB1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndDOB1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);   

despray_DIDAddressHasNameAndAddressAndDL1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndDL1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndDL1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);   
																				
 despray_DIDAddressHasNameAndAddressAndSSN1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSN1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSN1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);      

  despray_DIDAddressHasNameAndAddressAndSSNandDOB1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSNandDOB1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSNandDOB1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);     

 despray_DIDAddressHasNameAndAddressAndSSNandDOBAndDL1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDL1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDL1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);    

 despray_DIDAddressHasNameAndAddressAndPhone1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndPhone1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndPhone1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);  

 despray_DIDAddressHasNameAndAddressNot1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressNot1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressNot1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);    

 despray_DIDAddressHasNameAndAddressAndDOBNot1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndDOBNot1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndDOBNot1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);  

 despray_DIDAddressHasNameAndAddressAndDLNot1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndDLNot1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndDLNot1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);      

 despray_DIDAddressHasNameAndAddressAndSSNNot1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSNNot1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSNNot1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);    

despray_DIDAddressHasNameAndAddressAndSSNandDOBNot1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSNandDOBNot1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSNandDOBNot1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);   

despray_DIDAddressHasNameAndAddressAndSSNandDOBAndDLNot1824  := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDLNot1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDLNot1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);  
																				
   despray_DIDAddressHasNameAndAddressAndPhoneNot1824   := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_DIDAddressHasNameAndAddressAndPhoneNot1824_'+ filedate +'.csv', 
																				pHostname, 
																				pTarget + '/tbl_DIDAddressHasNameAndAddressAndPhoneNot1824_'+ filedate +'.csv' 
																				//charlene's team will create the monthly folder yyyymmdd otherwise HPCC creates the folder
																				,,,,true);   																				

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(tbl_HeaderCoreSegmentsJoin,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_HeaderCoreSegmentsJoin_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_WatchDogHeaderCoreSegments,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_WatchDogHeaderCoreSegments_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddress,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddress_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndDOB,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndDOB_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndDL,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndDL_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSN,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSN_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSNandDOB,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSNandDOB_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDL,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSNandDOBAndDL_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndPhone,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndPhone_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddress1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddress1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndDOB1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndDOB1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndDL1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndDL1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSN1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSN1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSNandDOB1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSNandDOB1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDL1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSNandDOBAndDL1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndPhone1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndPhone1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressNot1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressNot1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndDOBNot1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndDOBNot1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndDLNot1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndDLNot1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSNNot1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSNNot1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSNandDOBNot1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSNandDOBNot1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndSSNandDOBAndDLNot1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndSSNandDOBAndDLNot1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(tbl_DIDAddressHasNameAndAddressAndPhoneNot1824,,'~thor_data400::data_insight::data_metrics::tbl_NonFCRA_DIDAddressHasNameAndAddressAndPhoneNot1824_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,despray_HeaderCoreSegmentsJoin
					,despray_WatchDogHeaderCoreSegments
					,despray_DIDAddressHasNameAndAddress
					,despray_DIDAddressHasNameAndAddressAndDOB
					,despray_DIDAddressHasNameAndAddressAndDL
					,despray_DIDAddressHasNameAndAddressAndSSN
					,despray_DIDAddressHasNameAndAddressAndSSNandDOB
					,despray_DIDAddressHasNameAndAddressAndSSNandDOBAndDL
					,despray_DIDAddressHasNameAndAddressAndPhone
					,despray_DIDAddressHasNameAndAddress1824
					,despray_DIDAddressHasNameAndAddressAndDOB1824
					,despray_DIDAddressHasNameAndAddressAndDL1824
					,despray_DIDAddressHasNameAndAddressAndSSN1824
					,despray_DIDAddressHasNameAndAddressAndSSNandDOB1824
					,despray_DIDAddressHasNameAndAddressAndSSNandDOBAndDL1824
					,despray_DIDAddressHasNameAndAddressAndPhone1824
					,despray_DIDAddressHasNameAndAddressNot1824
					,despray_DIDAddressHasNameAndAddressAndDOBNot1824
					,despray_DIDAddressHasNameAndAddressAndDLNot1824
					,despray_DIDAddressHasNameAndAddressAndSSNNot1824
					,despray_DIDAddressHasNameAndAddressAndSSNandDOBNot1824
					,despray_DIDAddressHasNameAndAddressAndSSNandDOBAndDLNot1824
					,despray_DIDAddressHasNameAndAddressAndPhoneNot1824) :
					Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + pContact, 'NonFCRA Group: NonFCRA_QueryHeaderStatsWatchdogHdr Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + pContact, 'NonFCRA Group:  NonFCRA_QueryHeaderStatsWatchdogHdr Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
					);
return email_alert;

end;