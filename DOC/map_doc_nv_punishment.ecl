import Crim_common, Address, Ut, lib_stringlib;

input := DOC.file_doc_nv.cmbndFiles;

Crim_Common.Layout_Moxie_DOC_Punishment.previous tNV(input L) := TRANSFORM

	self.process_date := Crim_Common.Version_In_DOC_Offender;
	self.offender_key := 'NV' +  l.offender_id; 
	self.vendor := 'NV';
	self.source_file := 'NV-DOC';
	self.offense_key 		:= 'NV' +  l.offender_id; 
    self.event_dt 			:= stringlib.stringfilter(l.sent_start_date,'0123456789');

    self.sent_length 		:= '';  
    self.sent_length_desc   := trim(l.sent_type + ' ' + if(l.sent_min_yrs = '', '', l.sent_min_yrs+' YEARS') 
							 + if(l.sent_min_mths = '', '', l.sent_min_mths+' MONTHS') 
							 + if(l.sent_min_days = '', '', l.sent_min_days+' DAYS'),left,right);
    self.cur_stat_inm 		:= '';
    self.cur_stat_inm_desc  := if(l.sent_status = '',l.sent_status,l.agy_loc_id);
    self.cur_loc_inm_cd 	:= '';
    self.cur_loc_inm 		:= l.agy_loc_id;
    self.inm_com_cty_cd 	:= '';
    self.inm_com_cty 		:= ''; 
    self.cur_sec_class_dt   := '';
    self.cur_loc_sec 		:= '';
    self.gain_time 			:= ''; 
    self.gain_time_eff_dt   := '';
    self.latest_adm_dt 		:= stringlib.stringfilter(l.sent_start_date,'0123456789');
    self.sch_rel_dt 		:= '';
    self.act_rel_dt 		:= stringlib.stringfilter(l.release_date,'0123456789');
    self.ctl_rel_dt 		:= '';
    self.presump_par_rel_dt := '';
    self.mutl_part_pgm_dt   := ''; 
    self.par_cur_stat 		:= '';						 
    self.par_cur_stat_desc  := if(regexfind('PAROLE',stringlib.stringtouppercase(l.agy_loc_id)),l.release_desc,'');
    self.par_st_dt 			:= '';
    self.par_sch_end_dt		:= '';
    self.par_act_end_dt 	:= '';
    self.par_cty_cd 		:= '';
    self.par_cty 		    := '';
	self.punishment_type    := if(regexfind('PAROLE',stringlib.stringtouppercase(self.cur_stat_inm_desc)),'P','I');
								   

END;

precs := project(input, tNV(left));  

outfile := dedup(
				sort(
					distribute(precs, hash(offender_key))
				,offender_key, event_dt,latest_adm_dt,local)
		  ,offender_key,event_dt,right,local):PERSIST('~thor_data400::persist::doc::map_nv_punishment');
						
export map_doc_nv_punishment := outfile;