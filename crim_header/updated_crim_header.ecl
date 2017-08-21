//
spick_old_new (boolean inlatest, string new_value, string old_value) := function
return if(inlatest, new_value, old_value);
end;

ipick_old_new (boolean inlatest, unsigned6 new_value, unsigned6 old_value) := function
return if(inlatest, new_value, old_value);
end;

both_as_header_with_did := co_as_header+sp_as_header;

layout_crim_header t_clean(both_as_header_with_did l) := transform
	self.case_number		:= if(l.case_number not in junk_data, l.case_number,'');
	self.orig_ssn			:= if(l.orig_ssn 	not in junk_data, l.orig_ssn,'');
	self.dle_num			:= if(l.dle_num     not in junk_data, l.dle_num,'');
	self.fbi_num			:= if(l.fbi_num     not in junk_data, l.fbi_num,'');
	self.doc_num			:= if(l.doc_num     not in junk_data, l.doc_num,'');
	self.ins_num			:= if(l.ins_num     not in junk_data, l.ins_num,'');
	self.id_num				:= if(l.id_num      not in junk_data, l.id_num,'');
	self.ncic_number		:= if(l.ncic_number not in junk_data, l.ncic_number,'');
	self.sor_number			:= if(l.sor_number  not in junk_data, l.sor_number,'');
	self.dl_num				:= if(l.dl_num      not in junk_data, l.dl_num,'');
	self.dl_state			:= if(l.dl_state    not in junk_data, l.dl_state,'');
	self.veh_tag			:= if(l.veh_tag     not in junk_data, l.veh_tag,'');
	self.veh_state			:= if(l.veh_state   not in junk_data, l.veh_state,'');
  self.dob := if(((length(trim(l.dob,left,right))=4) and (l.dob[1..2] in ['19','20'])),trim(l.dob,left,right)+'0000', l.dob); 
	self.dob_alias			:= if(l.dob_alias   not in junk_data, l.dob_alias,'');
	self := l;
end;
both_as_header_with_didc := project(both_as_header_with_did,t_clean(left));

new := distribute(both_as_header_with_didc,hash(offender_key));

old := distribute(file_crim_header,hash(offender_key));

layout_crim_header tjoin_for_update(old l, new r) := transform
	self.cdl :=l.cdl;
	self.rid :=l.rid; 
	self.in_latest :=r.in_latest;
	self.earliest_process_date	:= if (l.earliest_process_date='' or r.earliest_process_date<>'' and r.earliest_process_date<l.earliest_process_date, r.earliest_process_date, l.earliest_process_date);
	self.latest_process_date	:= if (l.latest_process_date  > r.latest_process_date,    l.latest_process_date,   r.latest_process_date);
	self.offender_key 	:= spick_old_new(r.in_latest,r.offender_key,l.offender_key);
	self.vendor			:= spick_old_new(r.in_latest,r.vendor,l.vendor);
	self.state_origin	:= spick_old_new(r.in_latest,r.state_origin,l.state_origin);
	self.data_type		:= spick_old_new(r.in_latest,r.data_type,l.data_type);
	self.source_file	:= spick_old_new(r.in_latest,r.source_file,l.source_file);
	self.case_number	:= spick_old_new(r.in_latest,r.case_number,l.case_number);
	self.name_type		:= spick_old_new(r.in_latest,r.name_type,l.name_type);
	self.orig_ssn		:= spick_old_new(r.in_latest,r.orig_ssn,l.orig_ssn);
	self.dle_num		:= spick_old_new(r.in_latest,r.dle_num,l.dle_num);
	self.fbi_num		:= spick_old_new(r.in_latest,r.fbi_num,l.fbi_num);
	self.doc_num		:= spick_old_new(r.in_latest,r.doc_num,l.doc_num);
	self.ins_num		:= spick_old_new(r.in_latest,r.ins_num,l.ins_num);
	self.id_num			:= spick_old_new(r.in_latest,r.id_num,l.id_num);
	self.ncic_number	:= spick_old_new(r.in_latest,r.ncic_number,l.ncic_number);
	self.sor_number		:= spick_old_new(r.in_latest,r.sor_number,l.sor_number);
	self.dl_num			:= spick_old_new(r.in_latest,r.dl_num,l.dl_num);
	self.dl_state		:= spick_old_new(r.in_latest,r.dl_state,l.dl_state);
	self.veh_tag		:= spick_old_new(r.in_latest,r.veh_tag,l.veh_tag);
	self.veh_state		:= spick_old_new(r.in_latest,r.veh_state,l.veh_state);
	self.dob			:= spick_old_new(r.in_latest,r.dob,l.dob);
	self.dob_alias		:= spick_old_new(r.in_latest,r.dob_alias,l.dob_alias);
	self.prim_range		:= spick_old_new(r.in_latest,r.prim_range,l.prim_range);
	self.predir			:= spick_old_new(r.in_latest,r.predir,l.predir);
	self.prim_name		:= spick_old_new(r.in_latest,r.prim_name,l.prim_name);
	self.addr_suffix	:= spick_old_new(r.in_latest,r.addr_suffix,l.addr_suffix);
	self.postdir		:= spick_old_new(r.in_latest,r.postdir,l.postdir);
	self.unit_desig		:= spick_old_new(r.in_latest,r.unit_desig,l.unit_desig);
	self.sec_range		:= spick_old_new(r.in_latest,r.sec_range,l.sec_range);
	self.p_city_name	:= spick_old_new(r.in_latest,r.p_city_name,l.p_city_name);
	self.v_city_name	:= spick_old_new(r.in_latest,r.v_city_name,l.v_city_name);
	self.state			:= spick_old_new(r.in_latest,r.state,l.state);
	self.zip5			:= spick_old_new(r.in_latest,r.zip5,l.zip5);
	self.zip4			:= spick_old_new(r.in_latest,r.zip4,l.zip4);
	self.title			:= spick_old_new(r.in_latest,r.title,l.title);
	self.fname			:= spick_old_new(r.in_latest,r.fname,l.fname);
	self.mname 			:= spick_old_new(r.in_latest,r.mname,l.mname);
	self.lname			:= spick_old_new(r.in_latest,r.lname,l.lname);
	self.name_suffix	:= spick_old_new(r.in_latest,r.name_suffix,l.name_suffix);
	self.did			:= ipick_old_new(r.in_latest,r.did,l.did);
	self.did_score		:= ipick_old_new(r.in_latest,r.did_score,l.did_score);
	self.county_fips_code_origin := '';
	self.gender := '';
//
end;

blendedj := join(old,new, 
	left.offender_key		=right.offender_key and
	left.vendor				=right.vendor and
	left.state_origin		=right.state_origin and
	left.data_type			=right.data_type and
	left.source_file		=right.source_file and
	left.case_number		=right.case_number and
	left.name_type			=right.name_type and
	left.orig_ssn			=right.orig_ssn and
	left.dle_num			=right.dle_num and
	left.fbi_num			=right.fbi_num and
	left.doc_num			=right.doc_num and
	left.ins_num			=right.ins_num and
	left.id_num				=right.id_num and
	left.ncic_number		=right.ncic_number and
	left.sor_number			=right.sor_number and
	left.dl_num				=right.dl_num and
	left.dl_state			=right.dl_state and
	left.veh_tag			=right.veh_tag and
	left.veh_state			=right.veh_state and
	left.dob				=right.dob and
	left.dob_alias			=right.dob_alias and
	left.prim_range			=right.prim_range and
	left.predir				=right.predir and
	left.prim_name			=right.prim_name and
	left.addr_suffix		=right.addr_suffix and
	left.postdir			=right.postdir and
	left.unit_desig			=right.unit_desig and
	left.sec_range			=right.sec_range and
	left.p_city_name		=right.p_city_name and
	left.v_city_name		=right.v_city_name and
	left.state				=right.state and
	left.zip5				=right.zip5 and
	left.zip4				=right.zip4 and
	left.title				=right.title and
	left.fname				=right.fname and
	left.mname 				=right.mname and
	left.lname				=right.lname and
	left.name_suffix		=right.name_suffix and
	left.did				=right.did and
	left.did_score			=right.did_score,
	tjoin_for_update(left,right),
	local, full outer);

blended := dedup(sort(distribute(blendedj,hash(offender_key)),record,local),record,local);

layout_crim_header tnew_rids(blended l, unsigned6 c) := transform
self.rid := max(blended, rid)+c;
self.cdl := self.rid;
self := l;
end;

combined_crim_header := blended(rid<>0) + project(blended(rid=0),tnew_rids(left,counter));

dist_on_ofk :=distribute(combined_crim_header,hash(offender_key));
//
crim_header.layout_crim_header trollup(dist_on_ofk l,dist_on_ofk r) := transform
self.earliest_process_date	:= if (l.earliest_process_date < r.earliest_process_date, l.earliest_process_date, r.earliest_process_date);
self.latest_process_date	:=   if (l.latest_process_date   > r.latest_process_date,   l.latest_process_date,   r.latest_process_date);
self.cdl := if (l.cdl< r.cdl, l.cdl, r.cdl);
self.rid := if (l.rid< r.rid, l.rid, r.rid);
self.in_latest := if(l.in_latest or r.in_latest, true,false);
self := l;
end;
rollup_on_all := rollup(sort(dist_on_ofk,except cdl,rid,in_latest,earliest_process_date,latest_process_date,local),trollup(left,right),except cdl,rid,in_latest,earliest_process_date,latest_process_date,local);

export updated_crim_header := rollup_on_all;  // :  persist ('~thor_data400::persist::crim_header::updated_crim_header');



