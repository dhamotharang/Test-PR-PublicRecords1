/*
DRAFT THIS IS IMPORTED FROM AL DISTRIX .. to be uses as template 
 ************************************
BUILD common offender from filE_wv_offender
Author: Jayant Sardeshmukh 
Code Started on: Oct 7, 2007
Code Finished on: Oct 7,2007  (working schedule is Mon,Wed,Fri)
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1.A straightforward  mapping of FILE_doc_WV_offender to Common Offender Format

//-------------------------------------------------------------------
DOCUMENTING USED/UNUSED FIELDS from supplied input
export layout_doc_wv_offender := RECORD, MAXLENGTH(400)
string ID;
String Name;
String FirstName;
String MiddleName;
String LastName;
String Suffix;
String Height;
x String Weight;
String BirthDate;
String Gender;
x String BookingDate;
x String Facility;
x String ImprisonmentStatus;
String CourtInfoNumber;
x String IssuingAgencyLocation;
x String PhotoName;
END;


*/
// Imports
import Crim_common;
import Address, Ut, lib_stringlib;
// Transforms
ds_combo_offender := DOC.file_doc_wv;

blnk:=['', '0','00','000'];
//FUNCTIONS 

//
// Returns height in inches from f' in'' Format
//
String heightToInches(String s) := FUNCTION
heightpattern :='([0-9]+)[^0-9]+([0-9]+)';
height_ft:=(integer)REGEXFIND(heightpattern,s,1);
height_in:=(integer)REGEXFIND(heightpattern,s,2);
return (string)(height_ft*12+height_in);
END;


crim_common.Layout_In_DOC_Offender.previous WV_offender_to_offender2(ds_combo_offender L) := 
TRANSFORM
//
		// The following 2 fields used in party_status_desc;
	nam:=TRIM((L.NAME),LEFT,RIGHT);
	    String78 clean_name := address.CleanPersonLFM73(trim(regexreplace('^O ',nam,'O')));
		
/*
NOTE FIELD ORDER NOW MATCHES ArrestLOG Transsform order
*/

self.process_date		:= L.received_date;
self.offender_key		:= 'WVDOC'+ trim(L.ID,left, right) ; 
self.vendor				:= 'WV';
//self.state_origin		:= 'WV';
self.data_type			:= '1'; // PLEASE CONFIRM THIS IS OK .. 
self.source_file		:= 'WV-courtventures-DOC';
//self.case_number		:= '';
//self.case_court			:= '';
//self.case_name			:= '';
//self.case_type			:= '';
//self.case_type_desc		:= ''; // doesn't apply to DOC, would have to rollup and keep them all, was: L.CourtInfoNumber; // List of statutes 
//self.case_filing_dt		:= '';
self.pty_nm				:= L.NAME; 
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= L.LastName; 
self.orig_fname			:= L.FirstName; 
self.orig_mname			:= L.MiddleName; 
self.orig_name_suffix	:= L.Suffix;
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= L.ID;// OK?
//self.dl_num				:= '';
//self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= commonFn.DateToStandard(L.BirthDate);
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= '';
self.race_desc			:= '';
self.sex				:= L.Gender; // Mapping may be required - will truncate to M/F
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= heightToInches(L.Height);// Convert 5' 11'' format to inches! 
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= L.ImprisonmentStatus+ ' was reported on: ' + L.received_date[5..6]+'/'+L.received_date[7..8]+'/'+L.received_date[1..4];
self.prim_range 		:= ''; 
self.predir 			:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 			:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 		:= '';
self.lot 				:= '';
self.lot_order 			:= '';
self.dpbc 				:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 			:= '';
self.msa 				:= '';
self.geo_blk 			:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title				:= clean_name[1..5];
self.fname				:= clean_name[6..25];
self.mname				:= clean_name[26..45];
self.lname				:= clean_name[46..65];
self.name_suffix		:= clean_name[66..70];
self.cleaning_score		:= clean_name[71..73];

// OFfender2 Extensions
//self.did 		 		:= '';
//self.pgid				:= '';
//self.ssn				:= '';//SOCIAL_SECURITY_NUMBER;

end;


ds_offender_mapped := project(ds_combo_offender, WV_offender_to_offender2(left));
ds_offender_sorted := sort(distribute(ds_offender_mapped,hash(offender_key)), offender_key,process_date,local);
ds_offender_dedup  := dedup(ds_offender_sorted, left.offender_key = right.offender_key, right, local);

export map_doc_WV_offender := ds_offender_dedup: PERSIST('~thor_data400::persist::doc::map_wv_offender');





