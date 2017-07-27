import doxie, ut, DeathV2_Services;

export contact_records_prs_trimmed(dataset(doxie_cbrs.layout_references) bdids) := 
MODULE

doxie_cbrs.mac_Selection_Declare()
deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());

cr := doxie_cbrs.contact_records_standardized(bdids)(Include_AssociatedPeople_val);
dk := doxie.key_death_masterV2_ssa_DID;

outrec := record
	cr;
	boolean has_death_record;
end;

outrec addd(cr l, dk r) := transform
	self.has_death_record := r.l_did > 0;
	self := l;
end;
	
		
contact_recs := dedup(
		join(cr, dk, LEFT.did<>0 AND keyed(left.did = right.l_did)
		and not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams), 
         addd(left, right), left outer, KEEP (1)),
		all);

company_title_rec := RECORD
	contact_recs.company_title;
	contact_recs.bdid;
	contact_recs.company_name;
END;

contact_record_base := RECORD
	contact_recs.bdid;
	contact_recs.did;
	contact_recs.dt_last_seen;
	string9 ssn;
	contact_recs.fname;
	contact_recs.mname;
	contact_recs.lname;
	contact_recs.name_suffix;
	contact_recs.prim_range;
	contact_recs.predir;
	contact_recs.prim_name;
	contact_recs.addr_suffix;
	contact_recs.postdir;
	contact_recs.unit_desig;
	contact_recs.sec_range;
	contact_recs.city;
	contact_recs.state;
	string5 zip;
	string4 zip4;	
END;

contact_record := record
	contact_record_base or company_title_rec;
end;

contact_rolled_rec := record
	contact_record_base;
	dataset(company_title_rec) company_titles {maxcount(25)};
end;

contacts_w_did_rolled := rollup(group(sort(contact_recs(did != 0),did),did),group,transform(contact_rolled_rec,
	self.company_titles := project(choosen(dedup(sort(rows(left)(company_title != ''),company_title,bdid),company_title,bdid),25),company_title_rec),
	self.dt_last_seen := max(rows(left),dt_last_seen),
	self.ssn := max(rows(left)((unsigned)ssn != 0),ssn),
	self := left));

contacts_wo_did_rolled := rollup(group(sort(contact_recs(did = 0),lname,fname,mname),lname,fname,mname),group,transform(contact_rolled_rec,
	self.company_titles := project(choosen(dedup(sort(rows(left)(company_title != ''),company_title,bdid),company_title,bdid),25),company_title_rec),
	self.dt_last_seen := max(rows(left),dt_last_seen),
	self.ssn := max(rows(left)((unsigned)ssn != 0),ssn),
	self := left));

contacts_slimmed := contacts_w_did_rolled + contacts_wo_did_rolled;

// Suppress.MAC_Mask(contacts_all_rolled,contacts_slimmed,ssn,null,true,false);

shared sorted_contacts := sort(contacts_slimmed,lname,fname,mname,if(did != 0,0,1),-dt_last_seen);

doxie_cbrs.mac_Selection_Declare()
								
export records := choosen(sorted_contacts,Max_AssociatedPeople_val);
export records_count := count(sorted_contacts);

END;
