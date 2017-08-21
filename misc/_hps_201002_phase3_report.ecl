import doxie_files,sexoffender;

ds_phase2 :=  dedup(sort(distribute(misc._hps_201002_phase2_details,hash(did)),record,local),all,local);

layout_slim_offense := record	
	unsigned6 did;
	string offenses;
	string offender_keys:='';
	string seisint_primary_keys:='';
	end;
layout_slim_offense to_slim_sor_offense(ds_phase2 l) := transform	
	self.offenses := if(l.sor_offense_description<>'','{SOR:','') +trim(l.sor_offense_description) +if(l.sor_offense_description<>'','}','');
	self.seisint_primary_keys := if(l.sor_offense_description<>'','{SOR:','') +trim(l.seisint_primary_key) +if(l.sor_offense_description<>'','}','');
	self := l;
	end;
layout_slim_offense to_slim_crim_offense(ds_phase2 l) := transform
	self.offenses := if(l.crim_offense_description<>'','{DOC:','') +trim(l.crim_offense_description) +if(l.crim_offense_description<>'','}','');
	self.offender_keys := if(l.crim_offense_description<>'','{DOC:','') +trim(l.offender_key) +if(l.crim_offense_description<>'','}','');
	self := l;
	end;
layout_slim_offense to_slim_court_offense(ds_phase2 l) := transform
	self.offenses := if(l.court_offense_description<>'','{COURT:','') +trim(l.court_offense_description) +if(l.court_offense_description<>'','}','');
	self.offender_keys := if(l.court_offense_description<>'','{COURT:','') +trim(l.offender_key) +if(l.court_offense_description<>'','}','');
	self := l;
	end;
normalized_offense := 
	dedup(
		sort(
		distribute(	project(ds_phase2(sor_offense_description<>''),to_slim_sor_offense(left)) +
					project(ds_phase2(crim_offense_description<>''),to_slim_crim_offense(left)) +
					project(ds_phase2(court_offense_description<>''),to_slim_court_offense(left)),hash(did))
		,record,local)
	,all,local);
layout_slim_offense to_roll_offenses(normalized_offense l,normalized_offense r) := transform
	self.offenses := trim(l.offenses)+ trim(r.offenses);
	self.offender_keys := trim(l.offender_keys)+ trim(r.offender_keys);
	self.seisint_primary_keys := trim(l.seisint_primary_keys)+ trim(r.seisint_primary_keys);
	self := l;
	end;
rolled_offenses := rollup(normalized_offense,to_roll_offenses(left,right),did,local);

recordof(ds_phase2) to_finish(ds_phase2 l,rolled_offenses r) := transform
	self.offenses := r.offenses;
	self.offender_keys := r.offender_keys;
	self.seisint_primary_keys := r.seisint_primary_keys;
	self.crim_offense_description := '';
	self.offender_key := '';
	self.sor_offense_description := '';
	self.seisint_primary_key := '';
	self := l;
	end;
res_with_offensex := join(ds_phase2, rolled_offenses, left.did= (unsigned6) right.did, to_finish(left,right),local,left outer);

layout_final := record
	string last_NAME;
	string first_NAME;
	string JOBCODE_DESCR;
	string BIRTH_DATE;
	//
	unsigned6 did:=0;
	//
	string1 has_doc:= '';
	string1 has_court := '';
	string1 has_sor:='';
	//
	string offenses;
	end;
res_final := dedup(sort(project(res_with_offensex,{layout_final}),record,local),all,local);

export _hps_201002_phase3_report := res_final  : persist('~thor::temp::misc._hps_201002_phase3_report');

