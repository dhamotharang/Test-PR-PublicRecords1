EXPORT Chase_BIID_BATCH_Macro(roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

import models, Risk_Indicators, Business_Risk, ut, riskwise;


IMPORT Models, Risk_Indicators, RiskWise, UT, scoring;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


/* *****************************************************
 *                      Main Script                    *
 *******************************************************/

layout:= RECORD
  string date_added;
  string source_info;
  unsigned6 bdid;
  unsigned2 score;
  string30 acctno;
  string120 name_company;
  string120 alt_company_name;
  string65 street_addr;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string4 zip4;
  string10 lat;
  string11 long;
  string1 addr_type;
  string4 addr_status;
  string9 fein;
  string10 phoneno;
  string16 ip_addr;
  string120 unparsedfullname;
  string20 name_first;
  string20 name_middle;
  string20 name_last;
  string5 name_suffix;
  string20 name_last_alt;
  string65 street_addr2;
  string10 prim_range_2;
  string2 predir_2;
  string28 prim_name_2;
  string4 addr_suffix_2;
  string2 postdir_2;
  string10 unit_desig_2;
  string8 sec_range_2;
  string25 p_city_name_2;
  string2 st_2;
  string5 z5_2;
  string4 zip4_2;
  string9 ssn;
  string8 dob;
  string10 phone_2;
  string3 rep_age;
  string25 dl_number;
  string2 dl_state;
  string100 rep_email;
  unsigned3 historydateyyyymm;




 END;

// f1 := IF(recordsOnInput = 0, 
                // DATASET(inputFile, Layout, CSV(QUOTE('"'))),
                // CHOOSEN(DATASET(inputFile, Layout, csv(QUOTE('"'))), recordsOnInput));
								
f1 := IF(no_of_records = 0, 
                DATASET(ut.foreign_prod +Infile_name, Layout, CSV(HEADING(single), QUOTE('"')) ),
                CHOOSEN(DATASET(ut.foreign_prod +Infile_name, Layout, CSV(HEADING(single), QUOTE('"')) ), no_of_records));

								
f := DISTRIBUTE(f1, RANDOM());
//f := f1 (AccountNumber = '6'); //Use to test single customer number
// output(f);



layout_soap_input := RECORD
	DATASET(Business_Risk.Layout_Input_Moxie_2) batch_in;
	STRING dppapurpose;
	String GLBPurpose;
END;

Business_Risk.Layout_Input_Moxie_2 make_batch_in(f le, integer c) := TRANSFORM




// self.acctno := le.acctno;




// self.name_company := le.companyname;
// self.street_addr := le.addr;
// self.p_city_name := le.city;
// self.st := le.state;
// self.z5 := le.zip;


// self.phoneno := le.businessphone;
// self.fein := le.taxidnumber;
// self.name_first := le.representativefirstname;
// self.name_last := le.representativelastname;
// self.street_addr2 := le.representativeaddr;
// self.p_city_name_2 := le.representativecity;
// self.st_2 := le.representativestate;
// self.z5_2 := le.representativezip;
// self.ssn := le.representativessn;
// self.dob := le.representativedob;
// self.phone_2 := le.representativehomephone;
self := le;
self := [];
end;

layout_soap_input make_rv_in(f le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	self.dppapurpose := '3';
	self.GLBPurpose := '1';
	END;

indata := DISTRIBUTE(PROJECT(F, make_rv_in(LEFT, counter)), Random());
// output(indata, named('biid_in'));

errx := record
	string errorcode := '';
	business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
	DATASET(Models.Layout_Model) models;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;



results := soapcall(indata, roxieIP,
				'Business_Risk.InstantID_Batch_Service', {indata},
				dataset(errx), RETRY(retry), TIMEOUT(timeout),
				PARALLEL(threads), onfail(err_out(LEFT)));


// output(results, named('biid_results'));

layout1:=RECORD
  string errorcode;
  string12 bdid;
  string30 account;
  string120 company_name;
  string120 alt_company_name;
  string100 addr1;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string4 zip4;
  string10 lat;
  string11 long;
  string1 addr_type;
  string4 addr_status;
  string9 fein;
  string10 phone10;
  string16 ip_addr;
  string20 rep_fname;
  string20 rep_mname;
  string20 rep_lname;
  string5 rep_name_suffix;
  string20 rep_alt_lname;
  string100 rep_addr1;
  string25 rep_p_city_name;
  string2 rep_st;
  string5 rep_z5;
  string4 rep_zip4;
  string9 rep_ssn;
  string8 rep_dob;
  string10 rep_phone;
  string3 rep_age;
  string25 rep_dl_num;
  string2 rep_dl_state;
  string100 rep_email;
  string32 riskwiseid;
  string1 cnamematchflag;
  string1 addrmatchflag;
  string1 citymatchflag;
  string1 statematchflag;
  string1 zipmatchflag;
  string1 phonematchflag;
  string1 feinmatchflag;
  string1 vernotrecentflag;
  string120 vercmpy;
  string50 veraddr;
  string30 vercity;
  string2 verstate;
  string5 verzip;
  string20 vercounty;
  string10 verphone;
  string9 verfein;
  string1 bnap;
  string1 bnat;
  string1 bnas;
  string2 bvi;
  string2 ar2bi;
  string3 additional_score_1;
  string3 additional_score_2;
  string4 pri_1;
  string100 pri_desc_1;
  string4 pri_2;
  string100 pri_desc_2;
  string4 pri_3;
  string100 pri_desc_3;
  string4 pri_4;
  string100 pri_desc_4;
  string4 pri_5;
  string100 pri_desc_5;
  string4 pri_6;
  string100 pri_desc_6;
  string4 pri_7;
  string100 pri_desc_7;
  string4 pri_8;
  string100 pri_desc_8;
  string120 bestcompanyname;
  string3 bestcompanynamescore;
  string50 bestaddr;
  string30 bestcity;
  string2 beststate;
  string5 bestzip;
  string4 bestzip4;
  string3 bestaddrscore;
  string9 bestfein;
  string3 bestfeinscore;
  string10 bestphone;
  string3 bestphonescore;
  string10 addrmatchphone;
  string120 phonematchcompany;
  string50 phonematchaddr;
  string30 phonematchcity;
  string2 phonematchstate;
  string5 phonematchzip;
  string4 phonematchzip4;
  string120 feinmatchcompany1;
  string50 feinmatchaddr1;
  string30 feinmatchcity1;
  string2 feinmatchstate1;
  string5 feinmatchzip1;
  string4 feinmatchzip4_1;
  string120 feinmatchcompany2;
  string50 feinmatchaddr2;
  string30 feinmatchcity2;
  string2 feinmatchstate2;
  string5 feinmatchzip2;
  string4 feinmatchzip4_2;
  string120 feinmatchcompany3;
  string50 feinmatchaddr3;
  string30 feinmatchcity3;
  string2 feinmatchstate3;
  string5 feinmatchzip3;
  string4 feinmatchzip4_3;
  string1 baddrtype;
  string1 bphonetype;
  string120 recentbkname;
  string50 recentbkaddr;
  string30 recentbkcity;
  string2 recentbkstate;
  string5 recentbkzip;
  string4 recentbkzip4;
  string5 recentbktype;
  string8 recentbkdate;
  string4 totalbkcount;
  string120 recentlienname;
  string50 recentlienaddr;
  string30 recentliencity;
  string2 recentlienstate;
  string5 recentlienzip;
  string4 recentlienzip4;
  string8 recentliendate;
  string50 recentlientype;
  string4 releasedliencount;
  string4 unreleasedliencount;
  string8 dt_first_seen_min;
  string8 dt_last_seen_max;
  string60 watchlist_table;
  string10 watchlist_record_number;
  string120 watchlist_program;
  string120 watchlist_cmpy;
  string50 watchlist_address;
  string30 watchlist_city;
  string2 watchlist_state;
  string9 watchlist_zip;
  string30 watchlist_country;
  string1 repnameverflag;
  string20 repfnameverify;
  string20 replnameverify;
  string1 repaddrverflag;
  string50 repaddrverify;
  string1 repcityverflag;
  string25 repcityverify;
  string1 repstateverflag;
  string2 repstateverify;
  string1 repzipverflag;
  string5 repzipverify;
  string1 repzip4verflag;
  string4 repzip4verify;
  string20 repcountyverify;
  string1 repphoneverflag;
  string10 repphoneverify;
  string1 repssnverflag;
  string9 repssnverify;
  string1 repdobverflag;
  string8 repdobverify;
  string2 repnas_score;
  string2 repnap_score;
  string2 repcvi;
  string3 rep_additional_score1;
  string3 rep_additional_score2;
  string4 rep_pri_1;
  string100 rep_pri_desc_1;
  string4 rep_pri_2;
  string100 rep_pri_desc_2;
  string4 rep_pri_3;
  string100 rep_pri_desc_3;
  string4 rep_pri_4;
  string100 rep_pri_desc_4;
  string4 rep_pri_5;
  string100 rep_pri_desc_5;
  string4 rep_pri_6;
  string100 rep_pri_desc_6;
  string4 rep_followup_1;
  string150 rep_followup_desc_1;
  string4 rep_followup_2;
  string150 rep_followup_desc_2;
  string4 rep_followup_3;
  string150 rep_followup_desc_3;
  string4 rep_followup_4;
  string150 rep_followup_desc_4;
  string20 repbestfname;
  string20 repbestlname;
  string50 repbestaddr1;
  string30 repbestcity;
  string2 repbeststate;
  string5 repbestzip;
  string4 repbestzip4;
  string8 repbestdob;
  string9 repbestssn;
  string10 repbestphone;
  string1 areacodesplitflag;
  string8 areacodesplitdate;
  string3 altareacode;
  string20 repphonefname;
  string20 repphonelname;
  string50 repphoneaddr1;
  string30 repphonecity;
  string2 repphonestate;
  string5 repphonezip;
  string4 repphonezip4;
  string10 repphonefromaddr;
  string8 repssnearlydate;
  string8 repssnlatedate;
  string2 repssnissuestate;
  string60 repwatchlist_table;
  string10 repwatchlist_record_number;
  string120 repwatchlist_program;
  string20 repwatchlist_lname;
  string20 repwatchlist_fname;
  string50 repwatchlist_address;
  string30 repwatchlist_city;
  string2 repwatchlist_state;
  string9 repwatchlist_zip;
  string30 repwatchlist_country;
  string4 repwatchlist_num_with_name;
  string4 dist_homeaddr_busaddr;
  string4 dist_homephone_busaddr;
  string4 dist_homeaddr_busphone;
  string4 dist_homephone_busphone;
  string4 dist_homephone_homeaddr;
  string4 dist_busphone_busaddr;
  string50 hist_addr_1;
  string30 hist_city_1;
  string2 hist_state_1;
  string5 hist_zip_1;
  string4 hist_zip4_1;
  string10 hist_phone_1;
  string6 hist_date_last_seen_1;
  string50 hist_addr_2;
  string30 hist_city_2;
  string2 hist_state_2;
  string5 hist_zip_2;
  string4 hist_zip4_2;
  string10 hist_phone_2;
  string6 hist_date_last_seen_2;
  string50 hist_addr_3;
  string30 hist_city_3;
  string2 hist_state_3;
  string5 hist_zip_3;
  string4 hist_zip4_3;
  string10 hist_phone_3;
  string6 hist_date_last_seen_3;
  string20 alt_fname_1;
  string20 alt_lname_1;
  string6 alt_date_last_seen_1;
  string20 alt_fname_2;
  string20 alt_lname_2;
  string6 alt_date_last_seen_2;
  string20 alt_fname_3;
  string20 alt_lname_3;
  string6 alt_date_last_seen_3;
  string8 sic_code;
  string8 naics_code;
  string105 business_description;
  unsigned1 recordcount;
  string1 hist_addr_1_isbest;
  string1 hist_addr_2_isbest;
  string1 hist_addr_3_isbest;
  string3 subjectssncount;
  string20 rep_verdl;
  string8 rep_deceaseddate;
  string8 rep_deceaseddob;
  string15 rep_deceasedfirst;
  string20 rep_deceasedlast;
  string120 sos_filing_name;
  string60 watchlist_table_2;
  string120 watchlist_program_2;
  string10 watchlist_record_number_2;
  string20 watchlist_fname_2;
  string20 watchlist_lname_2;
  string65 watchlist_address_2;
  string25 watchlist_city_2;
  string2 watchlist_state_2;
  string5 watchlist_zip_2;
  string30 watchlist_country_2;
  string200 watchlist_cmpy_2;
  string60 watchlist_table_3;
  string120 watchlist_program_3;
  string10 watchlist_record_number_3;
  string20 watchlist_fname_3;
  string20 watchlist_lname_3;
  string65 watchlist_address_3;
  string25 watchlist_city_3;
  string2 watchlist_state_3;
  string5 watchlist_zip_3;
  string30 watchlist_country_3;
  string200 watchlist_cmpy_3;
  string60 watchlist_table_4;
  string120 watchlist_program_4;
  string10 watchlist_record_number_4;
  string20 watchlist_fname_4;
  string20 watchlist_lname_4;
  string65 watchlist_address_4;
  string25 watchlist_city_4;
  string2 watchlist_state_4;
  string5 watchlist_zip_4;
  string30 watchlist_country_4;
  string200 watchlist_cmpy_4;
  string60 watchlist_table_5;
  string120 watchlist_program_5;
  string10 watchlist_record_number_5;
  string20 watchlist_fname_5;
  string20 watchlist_lname_5;
  string65 watchlist_address_5;
  string25 watchlist_city_5;
  string2 watchlist_state_5;
  string5 watchlist_zip_5;
  string30 watchlist_country_5;
  string200 watchlist_cmpy_5;
  string60 watchlist_table_6;
  string120 watchlist_program_6;
  string10 watchlist_record_number_6;
  string20 watchlist_fname_6;
  string20 watchlist_lname_6;
  string65 watchlist_address_6;
  string25 watchlist_city_6;
  string2 watchlist_state_6;
  string5 watchlist_zip_6;
  string30 watchlist_country_6;
  string200 watchlist_cmpy_6;
  string60 watchlist_table_7;
  string120 watchlist_program_7;
  string10 watchlist_record_number_7;
  string20 watchlist_fname_7;
  string20 watchlist_lname_7;
  string65 watchlist_address_7;
  string25 watchlist_city_7;
  string2 watchlist_state_7;
  string5 watchlist_zip_7;
  string30 watchlist_country_7;
  string200 watchlist_cmpy_7;
  string60 repwatchlist_table_2;
  string120 repwatchlist_program_2;
  string10 repwatchlist_record_number_2;
  string20 repwatchlist_fname_2;
  string20 repwatchlist_lname_2;
  string65 repwatchlist_address_2;
  string25 repwatchlist_city_2;
  string2 repwatchlist_state_2;
  string5 repwatchlist_zip_2;
  string30 repwatchlist_country_2;
  string200 repwatchlist_entity_name_2;
  string60 repwatchlist_table_3;
  string120 repwatchlist_program_3;
  string10 repwatchlist_record_number_3;
  string20 repwatchlist_fname_3;
  string20 repwatchlist_lname_3;
  string65 repwatchlist_address_3;
  string25 repwatchlist_city_3;
  string2 repwatchlist_state_3;
  string5 repwatchlist_zip_3;
  string30 repwatchlist_country_3;
  string200 repwatchlist_entity_name_3;
  string60 repwatchlist_table_4;
  string120 repwatchlist_program_4;
  string10 repwatchlist_record_number_4;
  string20 repwatchlist_fname_4;
  string20 repwatchlist_lname_4;
  string65 repwatchlist_address_4;
  string25 repwatchlist_city_4;
  string2 repwatchlist_state_4;
  string5 repwatchlist_zip_4;
  string30 repwatchlist_country_4;
  string200 repwatchlist_entity_name_4;
  string60 repwatchlist_table_5;
  string120 repwatchlist_program_5;
  string10 repwatchlist_record_number_5;
  string20 repwatchlist_fname_5;
  string20 repwatchlist_lname_5;
  string65 repwatchlist_address_5;
  string25 repwatchlist_city_5;
  string2 repwatchlist_state_5;
  string5 repwatchlist_zip_5;
  string30 repwatchlist_country_5;
  string200 repwatchlist_entity_name_5;
  string60 repwatchlist_table_6;
  string120 repwatchlist_program_6;
  string10 repwatchlist_record_number_6;
  string20 repwatchlist_fname_6;
  string20 repwatchlist_lname_6;
  string65 repwatchlist_address_6;
  string25 repwatchlist_city_6;
  string2 repwatchlist_state_6;
  string5 repwatchlist_zip_6;
  string30 repwatchlist_country_6;
  string200 repwatchlist_entity_name_6;
  string60 repwatchlist_table_7;
  string120 repwatchlist_program_7;
  string10 repwatchlist_record_number_7;
  string20 repwatchlist_fname_7;
  string20 repwatchlist_lname_7;
  string65 repwatchlist_address_7;
  string25 repwatchlist_city_7;
  string2 repwatchlist_state_7;
  string5 repwatchlist_zip_7;
  string30 repwatchlist_country_7;
  string200 repwatchlist_entity_name_7;
  string1 pri_seq_1;
  string1 pri_seq_2;
  string1 pri_seq_3;
  string1 pri_seq_4;
  string1 pri_seq_5;
  string1 pri_seq_6;
  string1 pri_seq_7;
  string1 pri_seq_8;
  string1 rep_pri_seq_1;
  string1 rep_pri_seq_2;
  string1 rep_pri_seq_3;
  string1 rep_pri_seq_4;
  string1 rep_pri_seq_5;
  string1 rep_pri_seq_6;
  string1 watchlist_seq_1;
  string1 watchlist_seq_2;
  string1 watchlist_seq_3;
  string1 watchlist_seq_4;
  string1 watchlist_seq_5;
  string1 watchlist_seq_6;
  string1 watchlist_seq_7;
  string1 repwatchlist_seq_1;
  string1 repwatchlist_seq_2;
  string1 repwatchlist_seq_3;
  string1 repwatchlist_seq_4;
  string1 repwatchlist_seq_5;
  string1 repwatchlist_seq_6;
  string1 repwatchlist_seq_7;
  // DATASET(layout_model) models;
 END;



NewRecs := PROJECT(results,TRANSFORM(layout1,self.bnap:=left.bnap_indicator;
                                             self.bnas:=left.bnas_indicator;
																						 self.bnat:=left.bnat_indicator;
																						 SELF :=
          LEFT));


// output(results, named('biid_results'));
op_final := output(NewRecs,, outfile_name, CSV(HEADING(2), QUOTE('"')), OVERWRITE);

fin_res := sequential(op_final);

return fin_res;

endmacro;