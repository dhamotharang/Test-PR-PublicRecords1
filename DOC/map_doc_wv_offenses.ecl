
/*
DRAFT IMPORTED FROM AL_DISTRIX  as template 

BUILD common offenses from file_al_doc_in_inmate
Author: Jayant Sardeshmukh 
Code Started on: Oct 1, 2007
Code Finished on: OCt 1, 2007
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1. Looks like a strightforward  mapping of FILE_AL_DOC_IN_SENTENCE to Common Offense Format
   with code translations(That are still pending clarification from customer)
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
String Weight;
String BirthDate;
String Gender;
String BookingDate;
String Facility;
String ImprisonmentStatus;
String CourtInfoNumber;
String IssuingAgencyLocation;
String PhotoName;
END;

//

//Transforms
*/
import crim_common;
//Smart Strings



offenses_combo := file_doc_wv;
//
crim_common.Layout_Moxie_DOC_Offenses.previous transform_WV_offenses(RECORDOF(offenses_combo) L) := 
TRANSFORM
    blnk := ['0','','00','000'];
		self.process_date 		:= L.received_date;
		self.offender_key 		:= 'WVDOC' + trim(L.ID,left, right);
		self.vendor 			:= 'WV';
		self.source_file 		:= 'WV-courtventures-DOC';
		self.offense_key 		:= '';// No Code Supplied.. but description is.. see below
		self.stc_comp 			:= '';
		self.inc_adm_dt 		:= commonFn.DateToStandard(L.BookingDate);// 
		self.stc_dt 			:= '';
		self.off_date 			:= '';
		self.arr_date			:= '';
		self.case_num			:= '';
		self.num_of_counts		:= '';
		self.off_code			:= '';
		self.chg				:= '';	//L.CourtInfoNumber; 
		self.chg_typ_flg		:= '';		
		self.off_desc_1 		:= L.courtInfoNumber; 
		self.off_desc_2			:= ''; 
		self.add_off_cd 		:= ''; 
		self.add_off_desc		:= ''; 
		self.off_typ			:= '';
		self.off_lev			:= '';
		self.arr_disp_date		:= '';
		self.arr_disp_cd		:= '';
		self.arr_disp_desc_1	:= '';
		self.arr_disp_desc_2	:= '';
		self.arr_disp_desc_3	:= '';
		self.court_cd			:= '';
		self.court_desc			:= ''; 
		self.ct_dist			:= '';
		self.ct_fnl_plea_cd		:= '';   
		self.ct_fnl_plea		:= '';      
		self.ct_off_code		:= '';       
		self.ct_chg				:= ''; //L.CourtInfoNumber;
		self.ct_chg_typ_flg		:= '';
		self.ct_off_desc_1		:= '';
		self.ct_off_desc_2		:= '';
		self.ct_addl_desc_cd	:= '';
		self.ct_off_lev			:= case(stringlib.stringtouppercase(L.ImprisonmentStatus),
										'MISDEMEANOR SENTENCED' => 'M',
										'DIV. OF CORRECTIONS OFFENDER' => 'O',
										'CONVICTED FELON' => 'F',
										'X');

		self.ct_disp_dt			:= ''; 
		self.ct_disp_cd			:= '';
		self.ct_disp_desc_1	    := '';
		self.ct_disp_desc_2	    := '';
		self.cty_conv_cd		:= ''; 
		self.cty_conv 			:= if(regexfind('COUNTY', L.IssuingAgencyLocation), L.IssuingAgencyLocation, ''); 
		self.adj_wthd			:= '';
		self.stc_cd			    := '';
		self.stc_desc_1			:= '';
		self.stc_desc_2			:= '';
		self.stc_desc_3			:= '';
		self.stc_desc_4			:= '';
		
		self.stc_lgth			:= '';		
		//
		self.stc_lgth_desc	:= '';
		self.min_term		:= '';
		self.min_term_desc	:= '';
		self.max_term		:= '';
		self.max_term_desc	:= '';
end;

ds_offense_mapped := project(offenses_combo,transform_WV_offenses(left));
ds_offense_sorted := sort(distribute(ds_offense_mapped,hash(offender_key)), offender_key,inc_adm_dt, ct_chg, ct_off_lev, cty_conv, process_date,local) ;
ds_offense_dedup  := dedup(ds_offense_sorted,offender_key,inc_adm_dt, ct_chg, ct_Off_lev, cty_conv,right, local);


//Mapped Output 
export map_doc_WV_offenses := ds_offense_dedup:PERSIST('~thor_data400::persist::doc::map_WV_offenses');