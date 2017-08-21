
/*
DRAFT IMPORTED FROM AL_DISTRIX  as template 

BUILD common offenses from file_doc_pa
Author: Jayant Sardeshmukh 
Code Started on: Dec 5, 2007
Code Finished on: Dec 5, 2007
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1. Looks like a strightforward  mapping of FILE_DOC_PA to Common Offense Format
   with code translations(That are still pending clarification from customer)
//-------------------------------------------------------------------
DOCUMENTING USED/UNUSED FIELDS from supplied input
export layout_doc_pa := RECORD , MAXLENGTH(1000)
String receive_date;
String ID;
x  String Name;
x  String Name_type;
x  String Age;
x  String Dob;
x  String Race;
x  String Height;
String Current_location;
x  String Permanent_Location;
String Committing_County;
x  String Sex;
x  String Citizenship;
x  String Complexion;
x  String Update;
END;

//

//Transforms
*/
import crim_common;
//Smart Strings



offenses_combo := file_doc_PA;
//
crim_common.Layout_Moxie_DOC_Offenses.previous transform_PA_offenses(RECORDOF(offenses_combo) L) := 
TRANSFORM
    blnk := ['0','','00','000'];
		self.process_date 		:= Crim_Common.Version_In_DOC_Offender;
		self.offender_key 		:= 'PADOC' + trim(L.ID,left, right);
		self.vendor 			:= 'PA';
		self.source_file 		:= 'PA-courtventures-DOC';
		self.offense_key 		:= '';//
		self.stc_comp 			:= '';
		self.inc_adm_dt 		:= '';
		self.stc_dt 			:= '';
		self.off_date 			:= '';
		self.arr_date			:= '';
		self.case_num			:= '';
		self.num_of_counts		:= '';
		self.off_code			:= '';
		self.chg				:= '';	//L.CourtInfoNumber; 
		self.chg_typ_flg		:= '';		
		self.off_desc_1 		:= '';
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
		self.ct_off_lev			:= '';//

		self.ct_disp_dt			:= ''; 
		self.ct_disp_cd			:= '';
		self.ct_disp_desc_1	    := '';
		self.ct_disp_desc_2	    := '';
		self.cty_conv_cd		:= ''; 
		self.cty_conv 			:= L.committing_County; 
		self.adj_wthd			:= '';
		self.stc_cd			    := '';
		self.stc_desc_1			:= '';
		self.stc_desc_2			:= 'Location:'+L.current_location;
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

ds_offense_mapped := project(offenses_combo,transform_PA_offenses(left));
ds_offense_sorted := sort(distribute(ds_offense_mapped,hash(offender_key)), offender_key,inc_adm_dt, ct_chg, ct_off_lev, cty_conv,stc_desc_2	 ,local) ;
ds_offense_dedup  := dedup(ds_offense_sorted,offender_key,inc_adm_dt, ct_chg, ct_Off_lev, cty_conv,stc_desc_2, right, local);


//Mapped Output 
export map_doc_PA_offenses := ds_offense_dedup:PERSIST('~thor_data400::persist::doc::map_PA_offenses');