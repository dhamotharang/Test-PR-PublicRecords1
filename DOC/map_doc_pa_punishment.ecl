/*

DRAFT IMPORTED from AL_DISTRIX to be used as a template


BUILD common offenses from file_al_doc_in_inmate
Author: Jayant Sardeshmukh 
Code Started on: Dec 7, 2007
Code Finished on: Dec 7, 2007
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1. Looks like a strightforward  mapping of FILE_doc_PA to Common Punishment Format

//-------------------------------------------------------------------
DOCUMENTING USED/UNUSED FIELDS from supplied input
export layout_doc_pa := RECORD , MAXLENGTH(1000)
String receive_date;
String ID;
x String Name;
x String Name_type;
x String Age;
x String Dob;
x String Race;
x String Height;
String Current_location;
x String Permanent_Location;
String Committing_County;
x String Sex;
x String Citizenship;
x String Complexion;
x String Update;
END;

*/
//Transforms
import crim_common;

blnk:=['0','00','000',' ',''];


//
punishment := file_doc_PA;
Crim_Common.Layout_Moxie_DOC_Punishment.previous transform_PA_Punishment(RECORDOF(punishment) L) := 
TRANSFORM
	self.process_date 		:= Crim_Common.Version_In_DOC_Offender;
	self.offender_key 		:= 'PADOC' + trim(L.ID,left, right);
	self.vendor 			:= 'PA';
	self.source_file 		:= 'PA-courtventures-DOC';
	self.offense_key 		:= '';
    self.event_dt 			:= '';
    self.punishment_type 	:= 'I';// Imprisonment . Ignoring parole
    self.sent_length 		:= '';  
    self.sent_length_desc   := '';
    self.cur_stat_inm 		:= '';
    self.cur_stat_inm_desc  := '';// 
    self.cur_loc_inm_cd 	:= '';
    self.cur_loc_inm 		:= L.Current_Location;
    self.inm_com_cty_cd 	:= '';
    self.inm_com_cty 		:= L.Committing_County; // location from PA appears to be related to the court/offense
    self.cur_sec_class_dt   := '';
    self.cur_loc_sec 		:= '';
    self.gain_time 			:= ''; //
    self.gain_time_eff_dt   := '';
    self.latest_adm_dt 		:= '';
    self.sch_rel_dt 		:= '';
    self.act_rel_dt 		:= '';
    self.ctl_rel_dt 		:= '';
    self.presump_par_rel_dt := '';
    self.mutl_part_pgm_dt   := ''; 
    self.par_cur_stat 		:= '';						 
    self.par_cur_stat_desc  := '';
    self.par_st_dt 			:= '';
    self.par_sch_end_dt		:= '';
    self.par_act_end_dt 	:= '';
    self.par_cty_cd 		:= '';
    self.par_cty 		    := '';
END;
activity_ds :=  project(punishment,transform_PA_Punishment(left));

activity_ds_sorted := sort(distribute(activity_ds,hash(offender_key)),offender_key,cur_loc_inm,local);
punishment_dedup := dedup(activity_ds_sorted,offender_key,cur_loc_inm,right,local);

export map_doc_PA_Punishment := punishment_dedup :PERSIST('~thor_data400::persist::doc::map_PA_punishment');



