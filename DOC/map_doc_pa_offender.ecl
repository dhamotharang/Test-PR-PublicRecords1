/*
DRAFT THIS IS IMPORTED FROM AL DISTRIX .. to be uses as template 
 ************************************
BUILD common offender from file_doc_pa
Author: Jayant Sardeshmukh 
Code Started on: Dec 5, 2007
Code Finished on: Dec,2007  (working schedule is Mon,Wed,Fri)
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1.A straightforward  mapping of FILE_doc_PA to Common Offender Format

//-------------------------------------------------------------------
DOCUMENTING USED/UNUSED FIELDS from supplied input
export layout_doc_pa := RECORD , MAXLENGTH(1000)
String receive_date;
String ID;
String Name;
xString Name_type;
xString Age;
String Dob;
String Race;
String Height;
String Current_location;
xString Permanent_Location;
xString Committing_County;
String Sex;
xString Citizenship;
String Complexion;
xString Update;
END;

*/
// Imports
import Crim_common;
import Address, Ut, lib_stringlib;
// Transforms
ds_combo_offender := DOC.file_doc_PA;

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


crim_common.Layout_In_DOC_Offender.previous PA_offender_to_offender2(ds_combo_offender L) := TRANSFORM
	nam:=TRIM((L.NAME),LEFT,RIGHT);
	    String78 clean_name := address.CleanPersonFML73(trim(regexreplace('^O ',nam,'O')));

self.process_date		:= Crim_Common.Version_In_DOC_Offender; //L.receive_date;
self.offender_key		:= 'PADOC'+ trim(L.ID,left, right) ; 
self.vendor				:= 'PA';
self.data_type			:= '1'; // PLEASE CONFIRM THIS IS OK .. 
self.source_file		:= 'PA-courtventures-DOC';
self.pty_nm				:= L.NAME; 
self.pty_nm_fmt			:= 'F';
self.orig_lname			:= '';// L.LastName; 
self.orig_fname			:= '';// L.FirstName; 
self.orig_mname			:= '';// L.MiddleName; 
self.orig_name_suffix	:= '';// L.Suffix;
self.pty_typ			:= if(L.NAME_TYPE ='Also Known As', '2', '0');
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= L.ID;// OK?
self.citizenship		:= '';
self.dob				:= commonFn.DateToStandard(L.DOB);
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= '';
self.street_address_2	:= '';
self.street_address_3	:= '';
self.street_address_4	:= '';
self.street_address_5	:= '';
self.race				:= L.RACE;
self.race_desc			:= L.RACE; // Already Expanded!
self.sex				:= L.SEX; // Mapping may be required - will truncate to M/F
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= L.COMPLEXION;
self.skin_color_desc	:= L.COMPLEXION; // already Expanded!
self.height				:= heightToInches(L.Height);// Convert 5' 11'' format to inches! 
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= '';
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
self.title				:= '';
self.fname				:= '';
self.mname				:= '';
self.lname				:= '';
self.name_suffix		:= '';
self.cleaning_score		:= '';

end;


mapped_PAoff := project(ds_combo_offender, PA_offender_to_offender2(left));

dedFile := dedup(sort(distribute(mapped_PAoff, hash(offender_key))
							,offender_key, pty_nm,pty_typ,local)
							,offender_key, pty_nm,pty_typ, local):PERSIST('~thor_data400::persist::doc::map_PA_offender');
// ds_offender_sorted := sort(distribute(ds_offender_mapped,hash(offender_key)), offender_key,process_date,local);
// ds_offender_dedup  := dedup(ds_offender_sorted, left.offender_key = right.offender_key, right, local);

export map_doc_PA_offender := dedFile;





