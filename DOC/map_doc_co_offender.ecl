/*
DRAFT THIS IS IMPORTED FROM AL DISTRIX .. to be uses as template 
 ************************************
BUILD common offender from filE_wv_offender
Author: Jayant Sardeshmukh 
Code Started on: Oct 8, 2007
Code Finished on: Oct 8,2007  (working schedule is Mon,Wed,Fri)
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1.A straightforward  mapping of FILE_doc_co_offender to Common Offender Format
export layout_doc_co_offender := RECORD , MAXLENGTH(400)
String ID; 
String Name; 
String FirstName; 
String MiddleName; 
String LastName; 
String Suffix; 
String DOB; 
String Ethnicity; 
String Gender; 
String HairColor; 
String EyeColor; 
String Height; 
xString Weight; 
String DOCNumber; 
xString EstParoleEligibilityDate; 
xString NextParoleHearingDate; 
xString EstMandatoryReleaseDate; 
xString EstSentenceDischargeDate; 
xString CurrentFacilityAssignment; 
xString SentenceDate; 
xString Sentence; 
String County; 
String CaseNumber; 
String Offense; 
xString PhotoName; 
END;


*/
// Imports
import Crim_common;
import Address, Ut, lib_stringlib;
// Transforms
ds_combo_offender := DOC.file_doc_co;

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


crim_common.Layout_In_DOC_Offender.previous CO_offender_to_offender2(ds_combo_offender L) := 
TRANSFORM
//
		// The following 2 fields used in party_status_desc;
	nam:=TRIM((L.NAME),LEFT,RIGHT);
	    String78 clean_name := Address.CleanPersonLFM73(trim(regexreplace('^O ',nam,'O')));
		
/*
NOTE FIELD ORDER NOW MATCHES ArrestLOG Transsform order
*/

self.process_date		:= L.received_date; // stringlib.getdateyyyymmdd();
self.offender_key		:= 'CO'+ 'DOC'+ trim(L.ID,left, right) ; 
self.vendor				:= 'CO';
//self.state_origin		:= 'CO';
self.data_type			:= '1'; // doc  
self.source_file		:= 'CO-courtventures_doc';
//self.case_number		:= ''; // removed case number L.CaseNumber;
//self.case_court			:= '';
//self.case_name			:= '';
//self.case_type			:= '';
//self.case_type_desc		:= '';//L.Offense?
//self.case_filing_dt		:= '';
self.pty_nm				:= L.Name; 
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= L.LastName; 
self.orig_fname			:= L.FirstName; 
self.orig_mname			:= L.MiddleName; 
self.orig_name_suffix	:= L.Suffix;
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= L.DOCNumber;
self.ins_num			:= '';
self.id_num				:= L.ID;// OK?
//self.dl_num				:= '';
//self.dl_state			:= '';
self.citizenship		:= '';
self.dob				    := IF (stringlib.stringfind(L.DOB,'/',1) <> 0, CommonFn.DateToStandard(L.DOB),stringlib.stringfindreplace(L.DOB,'-','')); //commonFn.DateToStandard(L.DOB);
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= ''; //  L.Ethnicity;
self.race_desc			:= L.Ethnicity;// Appears to be already mapped in the input!
self.sex				:= L.Gender; //
self.hair_color			:= ''; // L.HairColor;
self.hair_color_desc	:= L.HairColor;// Appears to be already mapped in the input!
self.eye_color			:= ''; // L.EyeColor;
self.eye_color_desc		:= L.EyeColor;// Appears to be already mapped in the input!
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= heightToInches(L.Height);// Convert 5' 11'' format to inches! 
self.weight				:= L.weight;
self.party_status		:= '';
self.party_status_desc	:= 'Last reported on: ' + L.received_date[5..6]+'/'+L.received_date[7..8]+'/'+L.received_date[1..4];
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


ds_offender_mapped := project(ds_combo_offender, CO_offender_to_offender2(left));
ds_offender_sorted := sort(distribute(ds_offender_mapped,hash(offender_key)), offender_key,process_date,local);
ds_offender_dedup  := dedup(ds_offender_sorted, left.offender_key = right.offender_key, right, local);

export map_doc_CO_offender := ds_offender_dedup: PERSIST('~thor_data400::persist::doc::map_co_offender');

