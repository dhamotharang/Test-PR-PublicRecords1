/*

DRAFT IMPORTED from AL_DISTRIX to be used as a template


BUILD common offenses from file_doc_ri 
Author: Jayant Sardeshmukh 
Code Started on: Dec 4, 2007
Code Finished on: Dec 4, 2007
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1. Looks like a strightforward  mapping of FILE_doc_ri to Common Punishment Format

//-------------------------------------------------------------------
DOCUMENTING USED/UNUSED FIELDS from supplied input
xString received_date;
xString ID;
xString LastName;
xString FirstName;
xString MiddleInitial;
xString NameType;
xString Race;
xString Sex;
xString Age;
xString LastResidence;
xString Security;
xString Sentence_CaseNo;
xString Sentence_Count;
String Sentence_DateImposed;
xString Sentence_RetroDate;
String Sentence_SenStatus;
String Sentence_Term_YR_MO_DAY;
xString Sentence_Desc;
xString Sentence_GoodTimeReleaseDate;
String Charges_CommitDate;
xString Charges_CaseNumber;
xString Charges_BailType;
xString Charges_BailAmount;
xString Charges_Disposition;
xString Charges_Description;
xString Charges_DispositionDate;
END;

*/
//Transforms
import crim_common;

blnk:=['0','00','000',' ',''];
//Smart Strings
VARSTRING sentence_descr(string stc) := FUNCTION
stcpattern:='([0-9]*)-([0-9]*)-([0-9]*)';//'39y-LIFE' or '15y-25y'
years:=REGEXFIND(stcpattern,stc,1);
months:=REGEXFIND(stcpattern,stc,2);
days:=REGEXFIND(stcpattern,stc,3);
return if(years > '0' ,years+' Years ','') + if(months > '0' , months+ ' Months ','') +if(days > '0' ,days + ' Days ','') ;

END;


//
punishment := file_doc_RI(sentence_caseno<>'');
Crim_Common.Layout_Moxie_DOC_Punishment.previous transform_RI_Punishment(RECORDOF(punishment) L) := 
TRANSFORM
	self.process_date 		:= L.received_date;
	self.offender_key 		:= 'RIDOC' + trim(L.ID,left, right);
	self.vendor 			:= 'RI';
	self.source_file 		:= 'RI-courtventures-DOC';
	self.offense_key 		:= '';
    self.event_dt 			:= commonFn.DateToStandard(L.Sentence_DateImposed); //
    self.punishment_type 	:= 'I';// Imprisonment . Ignoring parole
    self.sent_length 		:= L.Sentence_Term_YR_MO_DAY;  
    self.sent_length_desc   := sentence_descr(L.Sentence_Term_YR_MO_DAY);
    self.cur_stat_inm 		:= '';
    self.cur_stat_inm_desc  := 'Case: '+trim(L.Sentence_caseno)+ '-' +L.Sentence_SenStatus;// ?? Is the field correct?
    self.cur_loc_inm_cd 	:= '';
    self.cur_loc_inm 		:= ''; //No Facility Supplied;
    self.inm_com_cty_cd 	:= '';
    self.inm_com_cty 		:= ''; // 
    self.cur_sec_class_dt   := '';
    self.cur_loc_sec 		:= '';
    self.gain_time 			:= ''; //
    self.gain_time_eff_dt   := ''; 
    self.latest_adm_dt 		:= commonFn.DateToStandard(L.Sentence_DateImposed); // commonFn.DateToStandard(L.bookingDate);
    self.sch_rel_dt 		:= commonFn.DateToStandard(L.Sentence_GoodTimeReleaseDate);
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
activity_ds :=  project(punishment,transform_RI_Punishment(left));

activity_ds_sorted := sort(distribute(activity_ds,hash(offender_key)),offender_key,event_dt,sent_length,cur_stat_inm_desc,process_date,local);
punishment_dedup := dedup(activity_ds_sorted,offender_key,event_dt,sent_length,cur_stat_inm_desc,right,local);

export map_doc_RI_Punishment := punishment_dedup :PERSIST('~thor_data400::persist::doc::map_RI_punishment');



