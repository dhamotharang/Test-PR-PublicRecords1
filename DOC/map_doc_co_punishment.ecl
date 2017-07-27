/*

DRAFT IMPORTED from AL_DISTRIX to be used as a template


BUILD common offenses from file_al_doc_in_inmate
Author: Jayant Sardeshmukh 
Code Started on: Oct 1, 2007
Code Finished on: Oct 1, 2007
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1. Looks like a strightforward  mapping of FILE_doc_co_offender(fulldata) to Common Punishment Format
export layout_doc_co_offender := RECORD , MAXLENGTH(500)
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
String Weight; 
String DOCNumber; 
String EstParoleEligibilityDate; 
String NextParoleHearingDate; 
String EstMandatoryReleaseDate; 
String EstSentenceDischargeDate; 
String CurrentFacilityAssignment; 
String SentenceDate; 
String Sentence; 
String County; 
String CaseNumber; 
String Offense; 
String PhotoName; 
END;


*/
//Transforms
import crim_common;

blnk:=['0','00','000',' ',''];

//
punishment := file_doc_co;
Crim_Common.Layout_Moxie_DOC_Punishment.previous transform_co_Punishment(RECORDOF(punishment) L) := 
TRANSFORM
	self.process_date 		:= L.received_date;
	self.offender_key 		:= 'CO' + 'DOC'+ trim(L.ID,left, right);
	self.vendor 			:= 'CO';
	self.source_file 		:= 'CO-courtventures-DOC';
	self.offense_key 		:= '';
    self.event_dt 			:= CommonFn.DateToStandard(L.SentenceDate); // 
    self.punishment_type 	:= 'I'; // changed to constant  if(stringLib.StringFind(L.CurrentFacilityAssignment,'PAROLE',1) <> 0,'P','I');
    // Note we are inferring that the person is on parole based on the word parole appearing in 
	// Current Facility Assignment
	self.sent_length 		:= ''; // 
    self.sent_length_desc   := ''; // this is not valid in this context and was commented. commonFn.sentence_descr(L.Sentence);// Long Description
    self.cur_stat_inm 		:= '';
    self.cur_stat_inm_desc  := if(stringLib.StringFind(L.CurrentFacilityAssignment,'PAROLE',1) <> 0,'ON PAROLE',''); // parole prob etc;
    self.cur_loc_inm_cd 	:= '';
    self.cur_loc_inm 		:= L.CurrentFacilityAssignment;
    self.inm_com_cty_cd 	:= '';
    self.inm_com_cty 		:= ''; // left this out, the county can't be both the offense and commitment county, it was L.County;
    self.cur_sec_class_dt   := '';
    self.cur_loc_sec 		:= '';
    self.gain_time 			:= '';     self.gain_time_eff_dt   := '';
    self.latest_adm_dt 		:= ''; 
    self.sch_rel_dt 		:= CommonFn.DateToStandard(L.EstSentenceDischargeDate);
    self.act_rel_dt 		:= '';//actual release date
    self.ctl_rel_dt 		:= CommonFn.DateToStandard(L.estMandatoryReleaseDate);
    self.presump_par_rel_dt := CommonFn.DateToStandard(L.estParoleEligibilityDate);//parole release date
    self.mutl_part_pgm_dt   := ''; 
    self.par_cur_stat 		:= '';						 
    self.par_cur_stat_desc  := '';
    self.par_st_dt 			:= '';
    self.par_sch_end_dt		:= '';
    self.par_act_end_dt 	:= '';
    self.par_cty_cd 		:= '';
    self.par_cty 		    := '';
END;
activity_ds :=  project(punishment,transform_co_Punishment(left));
activity_ds_sorted := sort(distribute(activity_ds,hash(offender_key)),offender_key,event_dt,process_date,local);
punishment_dedup := dedup(activity_ds_sorted,offender_key,right,local);

export map_doc_co_Punishment := punishment_dedup :PERSIST('~thor_data400::persist::doc::map_co_punishment');


