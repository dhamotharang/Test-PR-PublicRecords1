/*
DRAFT THIS IS IMPORTED FROM map_doc_wv_offender .. to be uses as template 
 ************************************
BUILD common offender from file_doc_ri
Author: Jayant Sardeshmukh 
Code Started on: Dec 3, 2007
Code Finished on: Dec 3,2007  (working schedule is Mon,Wed,Fri)
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1.A straightforward  mapping of FILE_doc_ri_offender to Common Offender Format

//-------------------------------------------------------------------
DOCUMENTING USED/UNUSED FIELDS from supplied input
export layout_doc_ri := RECORD, MAXLENGTH(1000)
String received_date;
String ID;
String LastName;
String FirstName;
String MiddleInitial;
String NameType;
String Race;
String Sex;
xString Age;
xString LastResidence;
xString Security;
xString Sentence_CaseNo;
xString Sentence_Count;
xString Sentence_DateImposed;
xString Sentence_RetroDate;
String Sentence_SenStatus;
xString Sentence_Term_YR_MO_DAY;
xString Sentence_Desc;
xString Sentence_GoodTimeReleaseDate;
xString Charges_CommitDate;
xString Charges_CaseNumber;
xString Charges_BailType;
xString Charges_BailAmount;
xString Charges_Disposition;
xString Charges_Description;
xString Charges_DispositionDate;
END;

*/
// Imports
import Crim_common;
import Address, Lib_AddrClean, Ut, lib_stringlib;
// Transforms
ds_combo_offender := DOC.file_doc_ri;

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


crim_common.Layout_In_DOC_Offender.previous ri_offender_to_offender2(ds_combo_offender L) := 
TRANSFORM
//
		// The following 2 fields used in party_status_desc;
	nam:=TRIM((L.LastName+' '+L.FirstName+' '+L.MiddleInitial ),LEFT,RIGHT);
	    String78 clean_name := AddrCleanLib.CleanPersonLFM73(trim(regexreplace('^O ',nam,'O')));

   string182 cleanaddress:=	addrcleanlib.cleanaddress182('',L.lastresidence +', RI');	
/*
NOTE FIELD ORDER NOW MATCHES ArrestLOG Transsform order
*/

self.process_date		:= L.received_date;
self.offender_key		:= 'RIDOC'+ trim(L.ID,left, right) ; 
self.vendor				:= 'RI';
//self.state_origin		:= 'RI';
self.data_type			:= '1'; // PLEASE CONFIRM THIS IS OK .. 
self.source_file		:= 'RI-courtventures-DOC';
//self.case_number		:= '';
//self.case_court			:= '';
//self.case_name			:= '';
//self.case_type			:= '';
//self.case_type_desc		:= ''; // doesn't apply to DOC, would have to rollup and keep them all, was: L.CourtInfoNumber; // List of statutes 
//self.case_filing_dt		:= '';
self.pty_nm				:= trim(L.LastName)+', '+trim(L.FirstName)+' '+L.MiddleInitial; 
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= L.LastName; 
self.orig_fname			:= L.FirstName; 
self.orig_mname			:= L.MiddleInitial; 
self.orig_name_suffix	:= '';
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
self.dob				:= '';//commonFn.DateToStandard(L.BirthDate);
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= trim(L.lastresidence)+', '+'RI';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= ''; //L.Race;
self.race_desc			:= L.Race;
self.sex				:= L.Sex; // Mapping may be required - will truncate to M/F
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';//heightToInches(L.Height);// Convert 5' 11'' format to inches! 
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= trim(L.security) + ' as of ' + L.received_date[5..6]+'/'+L.received_date[7..8]+'/'+L.received_date[1..4];
self.prim_range 	:= CleanAddress[1..10]; 
self.predir 		:= cleanaddress[11..12];					   
self.prim_name 		:= cleanaddress[13..40];
self.addr_suffix 	:= cleanaddress[41..44];
self.postdir 		:= cleanaddress[45..46];
self.unit_desig 	:= cleanaddress[47..56];
self.sec_range 		:= cleanaddress[57..64];
self.p_city_name 	:= if(cleanaddress[65..89]='',l.lastresidence,cleanaddress[65..89]);
self.v_city_name 	:= if(cleanaddress[90..114]='',l.lastresidence,cleanaddress[90..114]);
self.state 			:= if(cleanaddress[115..116]='','RI',cleanaddress[115..116]);
self.zip5 			:= cleanaddress[117..121];
self.zip4 			:= cleanaddress[122..125];
self.cart 			:= cleanaddress[126..129];
self.cr_sort_sz 	:= cleanaddress[130];
self.lot 			:= cleanaddress[131..134];
self.lot_order 		:= cleanaddress[135];
self.dpbc 			:= cleanaddress[136..137];
self.chk_digit 		:= cleanaddress[138];
self.rec_type 		:= cleanaddress[139..140];
self.ace_fips_st	:= cleanaddress[141..142];
self.ace_fips_county:= cleanaddress[143..145];
self.geo_lat 		:= cleanaddress[146..155];
self.geo_long 		:= cleanaddress[156..166];
self.msa 			:= cleanaddress[167..170];
self.geo_blk 		:= cleanaddress[171..177];
self.geo_match 		:= cleanaddress[178];
self.err_stat 		:= cleanaddress[179..182];

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


ds_offender_mapped := project(ds_combo_offender, ri_offender_to_offender2(left));
ds_offender_sorted := sort(distribute(ds_offender_mapped,hash(offender_key)), offender_key,process_date,local);
ds_offender_dedup  := dedup(ds_offender_sorted, left.offender_key = right.offender_key, right, local);

export map_doc_ri_offender := ds_offender_dedup: PERSIST('~thor_data400::persist::doc::map_ri_offender');





