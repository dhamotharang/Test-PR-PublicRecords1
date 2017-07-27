
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
1. Looks like a strightforward  mapping of FILE_DOC_CO_offender(fulldata) to Common Offense Format
   
export layout_doc_co_offender := RECORD , MAXLENGTH(500)
String ID; 
x String Name; 
x String FirstName; 
x String MiddleName; 
x String LastName; 
x String Suffix; 
x String DOB; 
x String Ethnicity; 
x String Gender; 
x String HairColor; 
x String EyeColor; 
x String Height; 
x String Weight; 
x String DOCNumber; 
x String EstParoleEligibilityDate; 
x String NextParoleHearingDate; 
x String EstMandatoryReleaseDate; 
x String EstSentenceDischargeDate; 
x String CurrentFacilityAssignment; 
String SentenceDate; 
String Sentence; 
String County; 
String CaseNumber; 
String Offense; 
x String PhotoName; 
END;

//

//Transforms
*/
import crim_common;
//Smart Strings


offenses_combo := file_doc_CO;
//
crim_common.Layout_Moxie_DOC_Offenses.previous transform_CO_offenses(RECORDOF(offenses_combo) L) := 
TRANSFORM
    blnk := ['0','','00','000'];
		self.process_date 		:= L.received_date;
		self.offender_key 		:= 'CO' + 'DOC'+  trim(L.ID,left, right);
		self.vendor 			:= 'CO';
		self.source_file 		:= 'CO-courtventures-DOC';
		
		self.inc_adm_dt 		:= ''; //Only sentencing date supplied 	
		self.arr_date			:= '';
		self.case_num			:= L.CaseNumber;
		self.num_of_counts		:= '';
		self.off_code			:= '';
		self.chg				:= ''; 
		self.chg_typ_flg		:= '';	
		self.offense_key 		:= '';// No Code Supplied.. but description is.. see below
		self.off_date 			:= '';
		self.off_desc_1 		:= L.Offense; // Already decoded
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
		self.ct_chg				:= '';
		self.ct_chg_typ_flg		:= '';
		self.ct_off_desc_1		:= ''; 
		self.ct_off_desc_2		:= '';
		self.ct_addl_desc_cd	:= '';
		self.ct_off_lev			:= '';
		self.ct_disp_dt			:= ''; 
		self.ct_disp_cd			:= '';
		self.ct_disp_desc_1	    := '';
		self.ct_disp_desc_2	    := '';
		self.cty_conv_cd		:= '' ; // L.county;
		self.cty_conv 			:= L.County; 
		self.adj_wthd			:= '';
		self.stc_comp 			:= '';
		self.stc_cd			    := '';
		self.stc_dt 			:= commonFn.DateToStandard(L.SentenceDate);
		self.stc_desc_1			:= '';
		self.stc_desc_2			:= '';
		self.stc_desc_3			:= '';
		self.stc_desc_4			:= '';
		
		self.stc_lgth			:= L.sentence;		
		self.stc_lgth_desc	    := commonFn.sentence_descr(L.sentence);//;
		self.min_term		    := '';
		self.min_term_desc	    := ''; //
		self.max_term		    := '';
		self.max_term_desc	    := '';
end;

ds_offense_mapped := project(offenses_combo,transform_CO_offenses(left));
ds_offense_sorted := sort(distribute(ds_offense_mapped,hash(offender_key)), offender_key,case_num, cty_conv, stc_lgth, stc_dt, off_desc_1, local) ;
ds_offense_dedup  := dedup(ds_offense_sorted,offender_key,case_num, cty_conv, stc_lgth, right, local);
//ds_offense_sorted := sort(distribute(ds_offense_mapped,hash(offender_key)), offender_key,case_num,off_desc_1, cty_conv,stc_dt, stc_lgth, process_date,local) ;
//ds_offense_dedup  := dedup(ds_offense_sorted,offender_key,case_num,off_desc_1, cty_conv,stc_dt, stc_lgth,right, local);


//Mapped Output 
export map_doc_CO_offenses := ds_offense_dedup:PERSIST('~thor_data400::persist::doc::map_CO_offenses')
;