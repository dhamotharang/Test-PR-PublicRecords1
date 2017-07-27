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
1. Looks like a strightforward  mapping of FILE_doc_wv_offender to Common Punishment Format

//-------------------------------------------------------------------
DOCUMENTING USED/UNUSED FIELDS from supplied input
export layout_doc_wv_offender := RECORD, MAXLENGTH(400)
string ID;
x String Name;
x String FirstName;
x String MiddleName;
x String LastName;
x String Suffix;
x String Height;
x String Weight;
x String BirthDate;
x String Gender;
String BookingDate;
String Facility;
String ImprisonmentStatus;
x String CourtInfoNumber;
String IssuingAgencyLocation;
x String PhotoName;
END;



*/
//Transforms
import crim_common;

blnk:=['0','00','000',' ',''];


//
punishment := file_doc_wv;
Crim_Common.Layout_Moxie_DOC_Punishment.previous transform_wv_Punishment(RECORDOF(punishment) L) := 
TRANSFORM
	self.process_date 		:= L.received_date;
	self.offender_key 		:= 'WVDOC' + trim(L.ID,left, right);
	self.vendor 			:= 'WV';
	self.source_file 		:= 'WV-courtventures-DOC';
	self.offense_key 		:= '';
    self.event_dt 			:= commonFn.DateToStandard(L.bookingDate); //
    self.punishment_type 	:= 'I';// Imprisonment . Ignoring parole
    self.sent_length 		:= '';  
    self.sent_length_desc   := '';
    self.cur_stat_inm 		:= '';
    self.cur_stat_inm_desc  := L.ImprisonmentStatus;
    self.cur_loc_inm_cd 	:= '';
    self.cur_loc_inm 		:= L.Facility;
    self.inm_com_cty_cd 	:= '';
    self.inm_com_cty 		:= ''; // location from WV appears to be related to the court/offense
    self.cur_sec_class_dt   := '';
    self.cur_loc_sec 		:= '';
    self.gain_time 			:= ''; //
    self.gain_time_eff_dt   := '';
    self.latest_adm_dt 		:= commonFn.DateToStandard(L.bookingDate);
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
activity_ds :=  project(punishment,transform_wv_Punishment(left));

activity_ds_sorted := sort(distribute(activity_ds,hash(offender_key)),offender_key,process_date,local);
punishment_dedup := dedup(activity_ds_sorted,offender_key,right,local);

export map_doc_wv_Punishment := punishment_dedup :PERSIST('~thor_data400::persist::doc::map_wv_punishment');



