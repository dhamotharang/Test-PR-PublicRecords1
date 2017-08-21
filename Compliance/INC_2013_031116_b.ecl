// An example of a request from IADP (usually from Kris Prenat):
/*
Chris,

We are requesting your assistance in completing a Data Provider Analysis for INC-2013-031116. The attached file contains 29 transactions.  Please provide the following:

1.	â€œSearch_Results_Summaryâ€ - The original data provider analysis. Please include the Sole-Sourced LexID count on this tab in addition to your normal findings.  If no sole-source analysis was done on the source, please indicate no analysis was done with the â€œn/aâ€ notation.
2.	â€œSole_Sourced_Summaryâ€ â€“ A summary of the number of consumers whose information was exposed where any of the following data sources were sole-sourced: 
a.	DMVs
b.	Equifax 
c.	Experian
d.	TransUnion
e.	TUCS_Ptrack (CP TUCS) 
f.	FARES
g.	LSSi
h.	Targus
3.	 â€œAll_sole_sourcedâ€ â€“ The record details for the consumers whose information was exposed from a sole-source; this data is used to create the Sole-Sourced Summary

NOTES:   
1.	These searches are from the Law Enforcement app; therefore the built in permissible uses are: DPPA_AGENCY, and GLBA_LAWENFORCEMENT
2.	This file does not have an orig_LexID column; however, there are lexIDs (ADLs) in the DocumentNum column for some of the transactions that should be taken into account. 
3.	There is info in the UID field of the DocumentNum column that should be taken into account. (23 of 29 transaction contain UID info)
4.	There are several different type of searches in this file, including IMAGE_ACCESS transactions

Thank you,
Kris

Kris Prenat, CFE 
Sr. Investigator, Information Assurance & Data Protection
Reed Elsevier, 9443 Springboro Pike, Miamisburg OH  45342
ï€¨: 937-247-3438
ï€ª: kris.prenat@reedelsevier.com  
www.reedelsevier.com 
*/
//******************************************************************************************************
//output(Compliance.In_INC_2013_031116_b);

IMPORT COMPLIANCE, ut;


version := '20150305';	//Date of request from Kris Prenat
versionb := 'no_DID_list';	//alternate output, if necessary


orig_file_name := 'INC_2013_031116_b';		

in_file := Compliance.In_INC_2013_031116_b;		//  27 rows

//----------

string ToCaps(string s) := stringlib.stringToUpperCase(s);
string CleanSpaces(string s) := stringlib.StringCleanSpaces(s);


eval_file := in_file;

Compliance.Layout_In	xRows(eval_file LE, integer cntr)	:=
		TRANSFORM
			self.append_row_ID := cntr;
			self.search_str := LE.edited_search_terms;
			
			self := LE;
		END;	

file_in := PROJECT(eval_file, xRows(LEFT, counter));

output(sort(distribute(file_in, hash(append_row_id)), append_row_id, local,skew(1.0)),all, named('file_in' + orig_file_name));

//---------------------------------------------------
#OPTION('multiplePersistInstances',FALSE); 

qry_parms_orig := PROJECT(file_in, Compliance.ExtractParms_v4(LEFT));	//into Compliance.Layout_Parms_v4

qry_parms_results := sort(distribute(qry_parms_orig, hash(append_row_id)), append_row_ID, local,skew(1.0)):PERSIST('~thor400_92::persist::compliance::parms_' + orig_file_name + '_' + version);						

OUTPUT(sort(qry_parms_results, orig_rid,append_row_id, skew(1.0)),ALL, named('qry_parms_results_'+orig_file_name));

OUTPUT(qry_parms_results(NOT REGEXFIND('U',class)), all, named('qry_parms_results_noUID'+orig_file_name));

//--------------

tbl_class := TABLE(qry_parms_results, {class, rec_count := count(group)}, class, few);
output(sort(tbl_class, class), all, named('search_class_distribution_' + orig_file_name));

tbl_class_parms := TABLE(qry_parms_results, {class,which_parms, rec_count := count(group)}, class,which_parms, few);
output(sort(tbl_class_parms, class,which_parms), all, named('search_class_which_parms_distribution_' + orig_file_name));

tbl_missingclass := TABLE(qry_parms_results(which_parms <> class), {class,which_parms,append_row_id, rec_count := count(group)}, class,which_parms,append_row_id, few);
output(topn(tbl_missingclass, 1000, class,which_parms,append_row_id), all, named('search_class_missing_which_parms_' + orig_file_name));

//rs_noclass := PROJECT(qry_parms_results(class = ''),Compliance.Layout_Out_v2);
rs_noclass := PROJECT(qry_parms_results(class = ''),Compliance.Layout_Out_v3);
output(sort(distribute(rs_noclass,hash(append_row_ID)), append_row_ID, local), all, named('no_search_class_' + orig_file_name));

//---------------------------------------------------

//layout_orig_out := Compliance.Layout_Out_v2 - Compliance.Layout_PHeader - [tag_num,vin_num]; 

//Parms names are the same as PHDR names; so change them to "srch_" + name:
qry := qry_parms_results;
/*
Compliance.Layout_orig_out X_out_orig(Compliance.Layout_Parms_v4 LE) := 

	TRANSFORM
		SELF.srch_class := LE.class;
		SELF.srch_uid := LE.uid;
		
		SELF.srch_criteria := LE.searchstr;
		SELF.srch_fname := LE.fname;
		SELF.srch_mname := LE.mname;
		SELF.srch_lname := LE.lname;
		SELF.srch_fullname := LE.fullname;
		SELF.srch_busname := LE.busname;
//		SELF.srch_address := LE.address;
//		SELF.srch_city := LE.city;
//		SELF.srch_state := LE.state;
//		SELF.srch_zip := LE.zip;
		SELF.srch_address := IF(LE.address <> '' AND REGEXFIND ('5E101', LE.addr_clnr_string),	// If the cleaner has no output then return the original data
														LE.address, LE.addr_clnr_string[1..46] + ' ' + LE.addr_clnr_string[57..64]);		//TRIM(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir,ALL)		
		SELF.srch_city 		:= IF(LE.city <> '' AND REGEXFIND ('5E101', LE.addr_clnr_string),
														LE.city, LE.addr_clnr_string[65..89]);
		SELF.srch_state 	:= IF(LE.state <> '' AND REGEXFIND ('5E101', LE.addr_clnr_string),
														LE.state, LE.addr_clnr_string[115..116]);
		SELF.srch_zip 		:= IF(LE.zip <> '' AND REGEXFIND ('5E101', LE.addr_clnr_string),
														LE.zip, LE.addr_clnr_string[117..121]);

		SELF.srch_ssn := LE.ssn;
		SELF.srch_dob := LE.dob;
		SELF.srch_phone := LE.phone;
		
		SELF.srch_tag := trim(LE.tag, all);
		SELF.srch_vin := trim(LE.vin, all);
		
			
		SELF := LE;
		
	END;
*/

qry_orig_formatted := PROJECT(qry, Compliance.Dataset_searched_V2(LEFT)); //into Compliance.Layout_orig_out
qry_orig_formatted_save := sort(distribute(qry_orig_formatted, hash(append_row_id)), append_row_ID, local,skew(1.0)):PERSIST('~thor40_241::persist::compliance::qry_orig_formatted_out_' + orig_file_name + '_' + version);

//----------
/*
OUTPUT(choosen(qry_orig_formatted, 500), named('qry_orig_formatted_sample'));


unique_srchstrings := DEDUP(sort(distribute(qry_orig_formatted, hash(srch_class)),
																srch_class, srch_uid, srch_ssn, srch_state, srch_city, srch_zip, srch_address, srch_lname, srch_fname, srch_mname, srch_dob, srch_phone, srch_fullname, srch_busname
																, local, skew(1.0)),
														srch_class, srch_uid, srch_ssn, srch_state, srch_city, srch_zip, srch_address, srch_lname, srch_fname, srch_mname, srch_dob, srch_phone, srch_fullname, srch_busname
														,all, local
														);

output(count(unique_srchstrings), named('count_unique_srchstrings'));														

tbl_unique_srchstrings := TABLE(unique_srchstrings, {srch_class,row_count := count(group)}, srch_class, few);
output(sort(distribute(tbl_unique_srchstrings, hash(srch_class)), srch_class, local), all, named('tbl_unique_srchstrings'));
			
unique_srchstrings_byFile := DEDUP(sort(distribute(qry_orig_formatted, hash(srch_class)),
																file, srch_class, srch_uid, srch_ssn, srch_state, srch_city, srch_zip, srch_address, srch_lname, srch_fname, srch_mname, srch_dob, srch_phone, srch_fullname, srch_busname
																, local, skew(1.0)),
														file, srch_class, srch_uid, srch_ssn, srch_state, srch_city, srch_zip, srch_address, srch_lname, srch_fname, srch_mname, srch_dob, srch_phone, srch_fullname, srch_busname
														,all, local
														);

tbl_unique_srchstrings_byFile := TABLE(unique_srchstrings_byFile, {file, srch_class,row_count := count(group)}, file, srch_class, few);
output(sort(distribute(tbl_unique_srchstrings_byFile, hash(file)), file, srch_class, local), all, named('tbl_unique_srchstrings_byFile'));	

OUTPUT(TABLE(qry_orig_formatted,{file,row_count := count(group)}, file, few), ALL, named('byFile'));
OUTPUT(TABLE(qry_orig_formatted,{Data_Src, file,row_count := count(group)}, Data_Src, file, few), ALL, named('byDataSrcAndFile'));
OUTPUT(TABLE(qry_orig_formatted,{DPPA,row_count := count(group)}, DPPA, few), ALL, named('byDPPA'));
OUTPUT(TABLE(qry_orig_formatted,{Data_Src, DPPA,GLBA,row_count := count(group)}, Data_Src, DPPA,GLBA, few), ALL, named('byDataSrcAndDppaAndGlba'));
OUTPUT(TABLE(qry_orig_formatted,{srch_dataset, srch_class,row_count := count(group)}, srch_dataset, srch_class, few), ALL, named('srch_class_by_srch_dataset'));
*/
//------------------------------------------------------------------------------------------------------------//-----------------------------------

//qry_orig_formatted_out := DATASET(ut.foreign_dataland+'thor40_241::persist::compliance::qry_orig_formatted_out_' + orig_file_name + '_' + version, layout_orig_out, thor);
qry_orig_formatted_out := qry_orig_formatted;

//layout_results :=
//	RECORD
//		compliance.Layout_Out_v2;
//		string srch_dataset := '';
//		string source_value := '';
//	END;

//-----------------------------------------------------------------------------------

//Datasets to search:
// Person Header (Relatives, Associates)
// Email Addresses
// CRIMS Offender
// Sex Offender

//-----------------------------------------------

// PERSON HEADER

set_PHDR_FILE_values := [
													 'ADDRCOUNT'
													,'ADDRREPORT'
													,'ASSETREPORT'
													,'CAPSW'
													,'CLR'
													,'COMPREPORT'					//March 2014: Can't simulate Comp Reports
													,'CPRS'								//March 2014: Can't simulate Comp Reports
													,'CPRS,CLR,FAP'				//March 2014: Can't simulate Comp Reports
													,'CPRS,FAP'						//March 2014: Can't simulate Comp Reports
													,'CP_ROLLPERSSRCH'		//March 2014
													,'FAL'
													,'FAL,PRPHIS,FAP,CPRS'//March 2014: Can't simulate Comp Reports
													,'FAP'
													,'FAP,CLR'
													,'FAP,CPRS'							//March 2014: Can't simulate Comp Reports
													,'FAP,CPRS,PRPHIS'			//March 2014: Can't simulate Comp Reports
													,'FINDERREPORT'
													,'GV_ADDRREPORT'
													,'GV_COMPREPORT'				//March 2014: Can't simulate Comp Reports
													,'IDREPT'
													,'LOCATIONREPORT'
													,'LOCATIONSEARCH'
													,'NA'										//March 2014: Can't simulate Comp Reports
													,'NSASSOCIATES'					//March 2014: Can't simulate Comp Reports
													,'NSNEIGHBORS'					//March 2014: Can't simulate Comp Reports
													,'NSRELATIVES'					//March 2014: Can't simulate Comp Reports
													,'PRPHIS'								//Is this Property History report?
													,'RNASEARCH'						//March 2014: Can't simulate Comp Reports
													,'ROLLPERSEARCH'
													,'RTPERSONSEARCH'				//Can't simulate real-time
													,'SOURCEDCO'						//Usually there's no seacrh string with this "FILE" value
													,'STATEWIDEPERSSRC'
													,'SUMMARYREPORT'
													
													,'AFINDICATORS'			// 2 searches with PII. All others, state only => skip
													,'SOCNETSRCH'				// this is a gateway, but the app returns PII data
													
													,'DLSEARCH2'				// Drivers: Filter later
													,'PROPSEARCHA2'			// RP Tax: Filter later
													,'PROPSEARCHD2'			// RP Deeds: Filter later
													,'RPROP'						// Real Property: Filter later
													,'VOTERSEARCH2'			// Voters: Filter later
													];


qry_PHDR := qry_orig_formatted_out(file = '' OR file IN set_PHDR_FILE_values);

//-------------------------------

Layout_pre_key :=
	RECORD
		Header.layout_header_v2;
		string1 valid_dob;
		unsigned6 hhid;
		string18 county_name;
		string120 listed_name;
		string10 listed_phone;
		unsigned4 dod;
		string1 death_code;
		unsigned4 lookup_did;
 END;
 
layout_header_key := 
RECORD
//  unsigned6 s_did;
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
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;

ds_header_key := INDEX({unsigned6 s_did}, layout_header_key, ut.foreign_prod+'thor_data400::key::header_qa');

hdr := PROJECT(ds_header_key, Layout_pre_key);

//--------------------------

//output(hdr);
//compliance.Layout_Out_v2 xfmPHDR(Layout_pre_key LE, Compliance.Layout_Parms_v3 RI) := 
compliance.Layout_Out_v3 xfmPHDR(Layout_pre_key LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.src;

		self.source_value := LE.src;
		
		SELF := LE;
		SELF := RI;
	END;

rs_FLCS 	:= JOIN(hdr, qry_PHDR(srch_class = 'FLCS'),LEFT.lname=RIGHT.srch_lname AND ((LEFT.fname=RIGHT.srch_fname) OR (RIGHT.srch_fname[2]= '' AND LEFT.fname[1]=RIGHT.srch_fname[1])) AND LEFT.st=RIGHT.srch_state AND LEFT.city_name=RIGHT.srch_city , xfmPHDR(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));
rs_FLCSZ 	:= JOIN(hdr, qry_PHDR(srch_class = 'FLCSZ'),LEFT.lname=RIGHT.srch_lname AND ((LEFT.fname=RIGHT.srch_fname) OR (RIGHT.srch_fname[2]= '' AND LEFT.fname[1]=RIGHT.srch_fname[1])) AND LEFT.st=RIGHT.srch_state AND LEFT.city_name=RIGHT.srch_city AND LEFT.zip=RIGHT.srch_zip , xfmPHDR(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));
rs_FML 		:= JOIN(hdr, qry_PHDR(srch_class = 'FML'),LEFT.lname=RIGHT.srch_lname AND ((LEFT.fname=RIGHT.srch_fname) OR (RIGHT.srch_fname[2]= '' AND LEFT.fname[1]=RIGHT.srch_fname[1])) AND ((LEFT.mname=RIGHT.srch_mname) OR (RIGHT.srch_mname[2] = '' AND LEFT.mname[1]=RIGHT.srch_mname[1])) , xfmPHDR(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));
rs_FMLCS 	:= JOIN(hdr, qry_PHDR(srch_class = 'FMLCS'),LEFT.lname=RIGHT.srch_lname AND ((LEFT.fname=RIGHT.srch_fname) OR (RIGHT.srch_fname[2]= '' AND LEFT.fname[1]=RIGHT.srch_fname[1])) AND ((LEFT.mname=RIGHT.srch_mname) OR (RIGHT.srch_mname[2] = '' AND LEFT.mname[1]=RIGHT.srch_mname[1])) AND LEFT.st=RIGHT.srch_state AND LEFT.city_name=RIGHT.srch_city , xfmPHDR(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));
rs_U 			:= JOIN(hdr, qry_PHDR(srch_class = 'U'),LEFT.did=RIGHT.srch_uid , xfmPHDR(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));

//----------

rs_PHDR_results :=	rs_FLCS + 
										rs_FLCSZ + 
										rs_FML + 
										rs_FMLCS + 
										rs_U
										:PERSIST('~thor400_92::persist::compliance::PHDR_results_' + orig_file_name + '_' + version);

OUTPUT(sort(distribute(choosen(rs_PHDR_results,1000), hash(append_row_id)), append_row_id, local,skew(1.0)), all, named('PHDR_results_sample_' + orig_file_name));

//----------

//PHDR_results := DATASET(ut.foreign_dataland+'thor40_241::persist::compliance::PHDR_results_' + orig_file_name + '_' + version, compliance.Layout_Out_v2, thor);
PHDR_results := rs_PHDR_results;

tbl_IDs_PHdr_results := TABLE(PHDR_results, {append_row_id, rec_count := count(group)}, append_row_id, few);

IDs_noHits := JOIN(sort(distribute(qry_PHDR, hash(append_row_id)), append_row_id, local,skew(1.0)),
										tbl_IDs_PHdr_results, LEFT.append_row_id = RIGHT.append_row_id, TRANSFORM(LEFT), LEFT ONLY, LOOKUP);

output(sort(distribute(IDs_noHits, hash(append_row_id)), append_row_id, local,skew(1.0)), ALL, named('IDs_with_NoHits_PHDR_' + orig_file_name));

tbl_PHdr_noHits_class := TABLE(IDs_noHits, {srch_class, rec_count := count(group)}, srch_class, few);
output(sort(distribute(tbl_PHdr_noHits_class, hash(srch_class)), srch_class, local,skew(1.0)), ALL, named('IDs_with_NoHits_PHDR_SrchClass_' + orig_file_name));

//------------

ds_ALL_PHDR_search_results := PHDR_results; 

//------------------------------------------------------------------
//Additional Datasets searched: Email, Crims, SOFF

//------------------------------------------------------------------

// Email Addresses	(1 rows)

Base_Email_Addr := DATASET(ut.foreign_prod + 'thor_data400::base::email_data', Email_Data.Layout_Email.Scrubs_bits_base, THOR);


Email_searched := regexfind('EMAILSEARCH', qry_orig_formatted_out.file);
qry_Email := qry_orig_formatted_out(Email_searched);

//-----

Email_rs_FLCS 	:= JOIN(Base_Email_Addr, qry_Email(srch_class = 'FLCS'),LEFT.clean_name.lname=RIGHT.srch_lname AND ((LEFT.clean_name.fname=RIGHT.srch_fname) OR (RIGHT.srch_fname[2]= '' AND LEFT.clean_name.fname[1]=RIGHT.srch_fname[1])) AND LEFT.clean_address.st=RIGHT.srch_state AND LEFT.clean_address.v_city_name=RIGHT.srch_city , Compliance.xfmEMAIL(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));

rs_results_EMAIL :=	Email_rs_FLCS
										:PERSIST('~thor400_92::persist::compliance::EMAIL_results_' + orig_file_name + '_' + version);

OUTPUT(sort(distribute(choosen(rs_results_EMAIL,1000), hash(append_row_id)), append_row_id, local,skew(1.0)), all, named('EMAIL_results_sample_' + orig_file_name));


tbl_IDs_Email := TABLE(rs_results_EMAIL, {append_row_id, rec_count := count(group)}, append_row_id, few);
output(sort(tbl_IDs_Email, append_row_id, skew(1.0)), ALL, named('IDs_with_results_' + 'Email' + '_' + orig_file_name + '_' + version));
//-----

results_Email := DATASET('~thor400_92::persist::compliance::EMAIL_results_' + orig_file_name + '_' + version, Compliance.Layout_Out_v3,thor); 

//-----------------------------------------------------------------------

// CRIMs	(2 rows)

CRIM_Offender	:= DATASET(ut.foreign_prod+'thor_data400::base::corrections_offenders_public', corrections.layout_offender, flat);

CRIM_searched := regexfind('(CIVILCOURTSEARCH|COURTSEARCH|CRIMREPORT|CRIMSEARCH|NATCRM)', qry_orig_formatted_out.file);
qry_CRIM := qry_orig_formatted_out(CRIM_searched);

//-----

//srch_class "U" = DOC Number
Crim_rs_FML := JOIN(CRIM_Offender, qry_CRIM(srch_class = 'FML'),LEFT.lname=RIGHT.srch_lname AND ((LEFT.fname=RIGHT.srch_fname) OR (RIGHT.srch_fname[2]= '' AND LEFT.fname[1]=RIGHT.srch_fname[1])) AND ((LEFT.mname=RIGHT.srch_mname) OR (RIGHT.srch_mname[2] = '' AND LEFT.mname[1]=RIGHT.srch_mname[1])) , Compliance.xfmCRIM(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));
Crim_rs_UFLS := JOIN(CRIM_Offender, qry_CRIM(srch_class = 'UFLS'),LEFT.doc_num = (string) RIGHT.srch_uid , Compliance.xfmCRIM(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));

rs_results_CRIM :=	Crim_rs_FML + 
										Crim_rs_UFLS
										:PERSIST('~thor400_92::persist::compliance::CRIM_results_' + orig_file_name + '_' + version);

OUTPUT(sort(distribute(choosen(rs_results_CRIM,1000), hash(append_row_id)), append_row_id, local,skew(1.0)), all, named('CRIM_results_sample_' + orig_file_name));


tbl_IDs_CRIM := TABLE(rs_results_CRIM, {append_row_id, rec_count := count(group)}, append_row_id, few);
output(sort(tbl_IDs_CRIM, append_row_id, skew(1.0)), ALL, named('IDs_with_results_' + 'CRIM' + '_' + orig_file_name + '_' + version));
//-----

results_CRIM := DATASET('~thor400_92::persist::compliance::CRIM_results_' + orig_file_name + '_' + version, Compliance.Layout_Out_v3,thor); 

//-----------------------------------------------------------------------

// SOFF	(1 rows)

SO_Offender			:= DATASET(ut.foreign_prod+'thor_data400::base::sex_offender_main'+ doxie_build.buildstate,sexoffender.layout_out_main,flat);

SOFF_searched := regexfind('SEXOFFSEARCH', qry_orig_formatted_out.file);
qry_SOFF := qry_orig_formatted_out(SOFF_searched);

//-----

SOFF_rs_FLSD := JOIN(SO_Offender, qry_SOFF(srch_class = 'FLSD'),LEFT.lname=RIGHT.srch_lname AND ((LEFT.fname=RIGHT.srch_fname) OR (RIGHT.srch_fname[2]= '' AND LEFT.fname[1]=RIGHT.srch_fname[1])) AND LEFT.st=RIGHT.srch_state AND (integer4) LEFT.dob=RIGHT.srch_dob , Compliance.xfmSOFF(LEFT, RIGHT),  MANY LOOKUP ,skew(1.0));


rs_results_SOFF :=	SOFF_rs_FLSD
										:PERSIST('~thor400_92::persist::compliance::SOFF_results_' + orig_file_name + '_' + version);

OUTPUT(sort(distribute(choosen(rs_results_SOFF,1000), hash(append_row_id)), append_row_id, local,skew(1.0)), all, named('SOFF_results_sample_' + orig_file_name));


tbl_IDs_SOFF := TABLE(rs_results_SOFF, {append_row_id, rec_count := count(group)}, append_row_id, few);
output(sort(tbl_IDs_SOFF, append_row_id, skew(1.0)), ALL, named('IDs_with_results_' + 'SOFF' + '_' + orig_file_name + '_' + version));
//-----

results_SOFF := DATASET('~thor400_92::persist::compliance::SOFF_results_' + orig_file_name + '_' + version, Compliance.Layout_Out_v3,thor); 

//----------------------------------------------------------------------------------------

 //All Result files combined:

results_Non_PHDR := results_CRIM
										+ results_Email
										+ results_SOFF 
										:INDEPENDENT
										;


Non_Phdr_IDs := DEDUP(sort(distribute(results_Non_PHDR, hash(append_row_id))
													,append_row_id, local,skew(1.0))
											, append_row_id, all);
											
set_Non_Phdr_IDs := SET(sort(Non_Phdr_IDs, append_row_id, skew(1.0)),append_row_id);

OUTPUT(count(set_Non_Phdr_IDs),named('count_set_Non_Phdr_IDs'));
OUTPUT(set_Non_Phdr_IDs, all ,named('set_Non_Phdr_IDs'));

//-------------------------------

//results_PHDR_only := ds_ALL_PHDR_search_results;
results_PHDR_only := ds_ALL_PHDR_search_results(append_row_id NOT IN set_Non_Phdr_IDs);

Phdr_IDs := DEDUP(sort(distribute(results_PHDR_only, hash(append_row_id))
													,append_row_id, local,skew(1.0))
											, append_row_id, all);
											
set_Phdr_IDs := SET(Phdr_IDs, append_row_id);

OUTPUT(count(set_Phdr_IDs),named('set_Phdr_append_row_IDs'+'_count'));
//OUTPUT(set_Phdr_IDs, all ,named('set_Phdr_IDs'));

OUTPUT(Non_Phdr_IDs(append_row_id IN set_Phdr_IDs), named('Non_Phdr_IDs_overlap_with_Phdr'));
OUTPUT(Phdr_IDs(append_row_id IN set_Non_Phdr_IDs), named('Phdr_IDs_overlap_with_Non_Phdr'));

//----------

//rs_results_all := results_PHDR_only;
rs_results_all := results_PHDR_only 
									+ results_Non_PHDR 
									:INDEPENDENT
									;


rs_results_all_sort := sort(rs_results_all, append_row_id, skew(1.0)):PERSIST('~thor400_92::persist::compliance::rs_results_all_' + orig_file_name + '_' + version);

output(rs_results_all_sort, named('rs_results_all'+'_sample'));
OUTPUT(count(rs_results_all_sort),named('rs_results_all'+'_count'));

//--------------------

//rs_results_all := DATASET('~thor400_92::persist::compliance::rs_results_all_' + orig_file_name + '_' + version, Compliance.Layout_Out_v3, thor);


//Source List per RID (not append_row_ID)
rs_Sets_IDs_and_Sources := TABLE(rs_results_all
																,{srch_dataset, orig_RID, source_value, rec_count := count(group)}
																,srch_dataset, orig_RID, source_value
																,FEW);

//OUTPUT(sort(rs_Sets_IDs_and_Sources, srch_dataset,orig_RID,source_value, skew(1.0)),,'~thor400_92::persist::compliance::Sets_IDs_and_Sources_' + orig_file_name + '_' + version + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//Number of Searches per SOURCE
Source_rows := DEDUP(sort(distribute(rs_results_all, hash(source_value,orig_RID))
												, source_value,orig_RID, local,skew(1.0))
										, source_value,orig_RID, all,local);
										
//OUTPUT(sort(TABLE(Source_rows, {source_value, search_count := count(group)}, source_value, few), source_value), all, named('NumberOfSearchesPerSource'));

//Number of DIDs per SOURCE
Source_DIDs := DEDUP(sort(distribute(rs_results_all, hash(source_value,did))
												, source_value,did, local,skew(1.0))
										, source_value,did, all,local);
										
//OUTPUT(sort(TABLE(Source_DIDs, {source_value, did_count := count(group)}, source_value, few), source_value), all, named('NumberOfDidsPerSource'));

//--------------------------------------------------------------------------------------------------------------

//  Apply all restrictions and constraints; double-check for Boolean searches, like "age-range".

rs_results_all_saved := DATASET('~thor400_92::persist::compliance::rs_results_all_' + orig_file_name + '_' + version, Compliance.Layout_Out_v3, thor);

//------------

//* There are no rows with "Age-Range" in the search criteria: 
PHDR_results_AgeUnRestricted := rs_results_all_saved;

//------------

//** Apply DPPA/GLBA restrictions:

//--GLB is all or nothing
rs_results_all_GLB_restricted := PHDR_results_AgeUnRestricted((GLBA IN ['GLB-NONE', ''] AND Mdr.sourcetools.SourceIsGLB(src) = TRUE));

OUTPUT(TABLE(rs_results_all_GLB_restricted, {source_value, append_row_id, record_count := count(group)}, source_value, append_row_id,few), all, named('tbl_results_all_GLB_restricted'));


rs_results_all_GLB_unrestricted := PHDR_results_AgeUnRestricted(NOT(GLBA IN ['GLB-NONE', ''] AND Mdr.sourcetools.SourceIsGLB(src) = TRUE));


//--Take out DPPA = 'NONE' 
rs_results_all_DPPA_NONE := rs_results_all_GLB_unrestricted((DPPA IN ['NONE', ''] AND Mdr.sourcetools.SourceIsDPPA(src) = TRUE));

OUTPUT(TABLE(rs_results_all_DPPA_NONE, {source_value, append_row_id, record_count := count(group)}, source_value, append_row_id,few), all, named('tbl_rs_results_all_DPPA_NONE'));


rs_results_all_DPPA_other_selected := rs_results_all_GLB_unrestricted(NOT(DPPA IN ['NONE', ''] AND Mdr.sourcetools.SourceIsDPPA(src) = TRUE));


//--DPPA also has restricted sources Table in CodesV3

rs_results_all_DPPA := JOIN(sort(distribute(rs_results_all_DPPA_other_selected, hash(Data_Src,dppa)), Data_Src,dppa, local)
														,sort(distribute(Compliance.File_Compliance_DPPA.file_Compliance_DPPA_Uses, hash(DataSrc,DPPA_Name)), DataSrc,DPPA_Name, local)
														,trim(left.Data_Src) = trim(right.DataSrc)
														 AND
														 trim(left.dppa) = trim(right.DPPA_Name)
														 ,LEFT OUTER
														 ,LOOKUP
														);
																

rs_results_all_DPPA_uses := JOIN(sort(distribute(rs_results_all_DPPA, hash(DPPA_Code_LN,source_value)), DPPA_Code_LN,source_value, local)
																,sort(distribute(Compliance.File_Compliance_DPPA.file_DPPA_Uses, hash(codesV3_code,source_code)), codesV3_code,source_code, local)
																,trim(left.DPPA_Code_LN) = trim(right.codesV3_code)
																 AND
																 trim(left.source_value) = trim(right.source_code)
																 ,LEFT OUTER
																 ,LOOKUP
																);
																
OUTPUT(rs_results_all_DPPA_uses(dppa_restriction <> ''), named('sample_rs_results_all_DPPA_uses'));

rs_results_all_GLB_DPPA_restricted := rs_results_all_DPPA_uses(dppa_restriction <> '');

// Save this file - what was left out because of DPPA //
OUTPUT(sort(rs_results_all_GLB_DPPA_restricted, append_row_id, skew(1.0)),,'~thor400_92::in::compliance::rs_results_all_GLB_DPPA_Restricted_' + orig_file_name + '_' + version + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

// Save this file - as an IN file - for further research down the road //
rs_results_all_GLB_DPPA_Unrestricted := SORT(rs_results_all_DPPA_uses(dppa_restriction = ''), append_row_id, skew(1.0)):PERSIST('~thor400_92::persist::compliance::rs_results_all_GLB_DPPA_Unrestricted_' + orig_file_name + '_' + version);

OUTPUT(rs_results_all_GLB_DPPA_Unrestricted, named('sample_'+'results_all_Unrestricted_' + orig_file_name + '_' + version));
OUTPUT(COUNT(rs_results_all_GLB_DPPA_Unrestricted), named('count_'+'results_all_Unrestricted_' + orig_file_name + '_' + version));
OUTPUT(sort(rs_results_all_GLB_DPPA_Unrestricted,append_row_id, skew(1.0)),,'~thor400_92::in::compliance::rs_results_all_GLB_DPPA_Unrestricted_' + orig_file_name + '_' + version + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//---------------------

results_all_Unrestricted := rs_results_all_GLB_DPPA_Unrestricted;
OUTPUT(count(results_all_Unrestricted),named('results_all_Unrestricted'+'_count'));

//Source List per RID
rs_Sets_IDs_and_Sources_final := TABLE(results_all_Unrestricted
																			,{srch_dataset, orig_RID, source_value, rec_count := count(group)}
																			,srch_dataset, orig_RID, source_value
																			,FEW);

OUTPUT(sort(rs_Sets_IDs_and_Sources_final, srch_dataset,orig_RID,source_value, skew(1.0)),,'~thor400_92::persist::compliance::Sets_IDs_and_Sources_' + orig_file_name + '_' + version + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//Number of Searches per SOURCE
Source_rows_final := DEDUP(sort(distribute(results_all_Unrestricted, hash(source_value,orig_RID))
															, source_value,orig_RID, local,skew(1.0))
													, source_value,orig_RID, all,local);
										
OUTPUT(TABLE(Source_rows_final, {source_value, search_count := count(group)}, source_value, few), all, named('NumberOfSearchesPerSource_Final'));

//Number of DIDs per SOURCE
Source_DIDs_final := DEDUP(sort(distribute(results_all_Unrestricted, hash(source_value,did))
															, source_value,did, local,skew(1.0))
													, source_value,did, all,local);
										
OUTPUT(TABLE(Source_DIDs_final, {source_value, did_count := count(group)}, source_value, few), all, named('NumberOfDidsPerSource_Final'));

//-----------------------

ds_ALL_SEARCH_RESULTS := results_all_Unrestricted;



	//Count DIDs:
DID_dup := DEDUP(sort(distribute(ds_ALL_SEARCH_RESULTS(did <> 0), hash(orig_RID,did))
																,orig_RID,did,-dt_last_seen, local, skew(1.0))
													 ,orig_RID,did, all,local);
													 
output(count(DID_dup), named('DIDs_by_rid_count'));													 


	//Count DID-Names:
DIDName_dup := DEDUP(sort(distribute(ds_ALL_SEARCH_RESULTS(did <> 0,fname <> '',lname <> ''), hash(orig_RID,did,fname,lname))
																,orig_RID,did,fname,lname,-dt_last_seen, local, skew(1.0))
													 ,orig_RID,did,fname,lname, all,local);
													 
output(count(DIDName_dup), named('DIDNames_by_rid_count'));													 

//Count DID-Addrs:
DIDAddr_dup := DEDUP(sort(distribute(ds_ALL_SEARCH_RESULTS(did <> 0,prim_range <> '',prim_name <> '',sec_range <> '',zip <> ''), hash(orig_RID,did,prim_range,prim_name,sec_range,zip))
																,orig_RID,did,prim_range,prim_name,sec_range,zip,-dt_last_seen, local, skew(1.0))
													 ,orig_RID,did,prim_range,prim_name,sec_range,zip, all,local);
													 
output(count(DIDAddr_dup), named('DIDAddrs_by_rid_count'));

//Count DID-SSNs:
DIDSSN_dup := DEDUP(sort(distribute(ds_ALL_SEARCH_RESULTS(did <> 0,SSN <> ''), hash(orig_RID,did,SSN))
																,orig_RID,did,SSN,-dt_last_seen, local, skew(1.0))
													 ,orig_RID,did,SSN, all,local);
													 
output(count(DIDSSN_dup), named('DIDSSNs_by_rid_count'));

//Count DID-DOBs:
DIDDOB_dup := DEDUP(sort(distribute(ds_ALL_SEARCH_RESULTS(did <> 0,DOB <> 0), hash(orig_RID,did,DOB))
																,orig_RID,did,DOB,-dt_last_seen, local, skew(1.0))
													 ,orig_RID,did,DOB, all,local);
													 
output(count(DIDDOB_dup), named('DIDDOBs_by_rid_count'));

//---------------------------------------------------------------------------------------------------------------------

layout_results := Compliance.Layout_Out_v3;

layout_results_plus := 
	RECORD
		layout_results;
		Compliance.File_Compliance_DPPA.layout_Compliance_DPPA_Uses;
		Compliance.File_Compliance_DPPA.layout_DPPA_Uses;
	END;
	
	
//Summary Report: Calculate the count of source codes for each RID; 
//								the combination of sources for each RID;
//								the record count for each RID;
//              	the set of DIDs for each RID.

layout_orig_out_v2 := Compliance.Layout_orig_out;


rec_src_set :=
	RECORD
	,maxlength(100000)
			layout_orig_out_v2 - [source_value];
			
			string		did_list := '';
			integer4  did_count := 0;
			integer6	srch_results_record_count := 0;
		  integer4  source_count := 0;
			string		source_value := '';
	END;


//------

	//get DID counts: 

rec_src_set xfmDID(DID_dup L) :=
	TRANSFORM
		self.did_list := IF((string) L.did = '0', REGEXREPLACE('0',(string) L.did, ''), (string) L.did);
		SELF.did_count := 1;
		
		SELF := L;
	END;

ds_DIDs := PROJECT(DID_dup, xfmDID(left));	


rec_src_set Xdid_set(rec_src_set L, rec_src_set R) :=
	TRANSFORM
		SELF.did_list := TRIM(L.did_list + ' ' + R.did_list);
		SELF.did_count := L.did_count + 1;
		
		SELF.orig_LexID := TRIM(L.orig_LexID + ' ' + R.orig_LexID);
		
		SELF := L;
		SELF := R;
	END;
	
DID_rollup := ROLLUP(sort(ds_DIDs, orig_RID, skew(1.0))
										 , LEFT.orig_RID = RIGHT.orig_RID
										 , Xdid_set(LEFT,RIGHT)
										);	

output(choosen(DID_rollup,50), named('DID_rollup_sample'));

//------

// To get Search Results Record Counts: 
rec_src_set Xrec_comb(ds_ALL_SEARCH_RESULTS L) :=
	TRANSFORM
		SELF.srch_results_record_count := 1;
		
		SELF := L;
	END;

	// where source is populated	
ds_allrows_recs := PROJECT(ds_ALL_SEARCH_RESULTS, Xrec_comb(left));

rec_src_set Xrecs(rec_src_set L, rec_src_set R) :=
	TRANSFORM
		SELF.srch_results_record_count := L.srch_results_record_count + 1;
		
		SELF := L;
		SELF := R;
	END;
	
ds_allrows_rec_rollup := ROLLUP(sort(ds_allrows_recs(source_value <> ''), orig_RID, skew(1.0))
																			 , LEFT.orig_RID = RIGHT.orig_RID
																			 , Xrecs(LEFT,RIGHT)
																			);	

ds_allrows_recs_all := ds_allrows_recs(source_value = '') + ds_allrows_rec_rollup;

OUTPUT(choosen(ds_allrows_recs_all,50), named('Record_counts_sample'));



//-----   To get source counts: one record per RID and source_value/src

ds_allrows_out_dup := DEDUP(sort(distribute(ds_ALL_SEARCH_RESULTS, hash(orig_RID))
																,orig_RID,source_value,-dt_last_seen, local, skew(1.0))
													 ,orig_RID,source_value, all,local);


rec_src_set Xsrc_comb(ds_allrows_out_dup L) :=
	TRANSFORM
		SELF.source_count := 1;
		
		SELF := L;
	END;

ds_allrows_src := PROJECT(ds_allrows_out_dup, Xsrc_comb(left));	


rec_src_set Xsrc_set(rec_src_set L, rec_src_set R) :=
	TRANSFORM
		SELF.source_value := TRIM(L.source_value + '---' + R.source_value);
		SELF.source_count := L.source_count + 1;
		
		SELF := L;
		SELF := R;
	END;
	
ds_allrows_src_rollup := ROLLUP(sort(ds_allrows_src(source_value <> ''), orig_RID, source_value, skew(1.0))
																			 , LEFT.orig_RID = RIGHT.orig_RID
																			 , Xsrc_set(LEFT,RIGHT)
																			);	

ds_allrows_srcs_all := ds_allrows_src(source_value = '') + ds_allrows_src_rollup;

OUTPUT(choosen(ds_allrows_srcs_all,50), named('Source_counts_sample'));

//------------------------------

//Get the record-count data
rec_src_set xfmRecCount(ds_allrows_srcs_all LE, ds_allrows_recs_all RI) :=
	TRANSFORM
		SELF.srch_results_record_count := RI.srch_results_record_count;
				
		SELF := LE;
//		SELF := RI;
	END;

with_Rec_count := JOIN(sort(ds_allrows_srcs_all, orig_RID, skew(1.0)),
																	 sort(ds_allrows_recs_all, orig_RID, skew(1.0))
																	 ,LEFT.orig_RID = RIGHT.orig_RID
																	 ,xfmRecCount(left,right)
																	 ,LEFT OUTER
																	 ,skew(1.0)
																	);

//------------

//Get the DID-count data
rec_src_set xfmDidCount(with_Rec_count LE, DID_rollup RI) :=
	TRANSFORM
		SELF.did_list := RI.did_list;
		SELF.did_count := RI.did_count;
		
		SELF.srch_class := LE.srch_class;
		SELF.srch_results_record_count := LE.srch_results_record_count;
		SELF.source_count := LE.source_count;
		SELF.source_value := LE.source_value;		
				
		SELF := LE;
		SELF := RI;
	END;

ds_allrows_out_cnt_summary := JOIN(sort(with_Rec_count, orig_RID, skew(1.0)),
																	 sort(DID_rollup, orig_RID, skew(1.0))
																	 ,LEFT.orig_RID = RIGHT.orig_RID
																	 ,xfmDidCount(left,right)
																	 ,LEFT OUTER
																	 ,skew(1.0)
																	);

//---------------
																	

ds_summary_out := sort(ds_allrows_out_cnt_summary, orig_RID, skew(1.0)):PERSIST('~thor400_92::persist::compliance::Summary_' + orig_file_name + '_' + version);

OUTPUT(choosen(ds_summary_out,50), named('Summary_thorFile_sample'));
OUTPUT(count(ds_summary_out), named('Summary_thorFile_count'));

OUTPUT(ds_summary_out,,'~thor400_92::persist::compliance::Summary_' + orig_file_name + '_' + version + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//---------------

//All Rows, Final:

//ds_summary_out_search_results := DATASET('~thor400_92::persist::compliance::Summary_' + orig_file_name + '_' + version, rec_src_set, thor);
ds_summary_out_search_results := ds_summary_out;

//If not all rows have search results:
ds_all_rows_out_final := JOIN(sort(qry_orig_formatted_out, orig_RID, skew(1.0))
															,sort(ds_summary_out_search_results, orig_RID, skew(1.0))
															,left.orig_RID = right.orig_RID
															,LEFT OUTER
															,skew(1.0)
														 );


ds_summary_out_all_rows := sort(ds_all_rows_out_final, orig_RID, skew(1.0));
//ds_summary_out_all_rows := sort(ds_summary_out_search_results, orig_RID, skew(1.0));

OUTPUT(ds_summary_out_all_rows,,'~thor400_92::persist::compliance::' + orig_file_name + '_' + version + '_all_rows.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

OUTPUT(choosen(ds_summary_out_all_rows, 50));
output(count(ds_summary_out_all_rows), named('count_summary_out_all_rows'));

//-----------------------------------------------------------------------------------------------------------------------------

//When output to Excel, several rows were messed up because "did list" was too large
// for excel parsing. Taking out the DID list field:

summary_out_all_DIDlist := DATASET('~thor400_92::persist::compliance::' + orig_file_name + '_' + version + '_all_rows.csv',
														rec_src_set
														,csv(heading(single), separator('|'),terminator('\r\n'),quote('\"'))
													);

rec_no_did_list :=	rec_src_set - [did_list];

summary_out_all_NoDIDlist := PROJECT(summary_out_all_DIDlist,rec_no_did_list);
												
OUTPUT(summary_out_all_NoDIDlist, named('summary_out_all_NoDIDlist'));												
OUTPUT(summary_out_all_NoDIDlist,,'~thor400_92::persist::compliance::' + orig_file_name + '_' + versionb + '_all_rows.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//-----------------------------------------------------------------------------------------------------------------------------
EXPORT INC_2013_031116_b := '';