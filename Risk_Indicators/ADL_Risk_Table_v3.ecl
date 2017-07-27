import doxie, fcra, header, gong, ut, header, doxie_build;

export ADL_Risk_Table_v3(boolean isFCRA) := function

hf1 := doxie_build.file_headerprod_building(did!=0 and ~iid_constants.filtered_source(src));

hf := project(hf1(dt_last_seen<>0),transform(header.Layout_Header, self := left));

base_hf := if(isFCRA, hf(~fcra.Restricted_Header_Src(src, vendor_id[1])), hf);

hf_minus_experian := base_hf(src<>'EN');
hf_minus_equifax := base_hf(src<>'EQ');

// neither header source filtered
both_bureaus := adl_risk_table(base_hf);

// experian removed from header
equifax_recs := adl_risk_table(hf_minus_experian);

// equifax removed from header
experian_recs := adl_risk_table(hf_minus_equifax);

common_adl_risk := record
	recordof(both_bureaus) - did;  // don't need a redundant DID field
end;


layout_adl_risk_v3 := record
	unsigned did;
	string15 adl_category := '';
	unsigned1 phone_ct;
	unsigned1 phone_ct_c6;
	common_adl_risk combo;  // combination of both bureaus, no bureau data restricted
	common_adl_risk eq;  		// experian restricted table
	common_adl_risk en;			// equifax restricted table
end;

j := join(both_bureaus, equifax_recs, left.did=right.did, 
				transform(layout_adl_risk_v3,
									self.did := left.did,
									self.combo := left,
									self.eq := right,
									self := []), left outer, local);

j2 := join(j, experian_recs, left.did=right.did,
				transform(layout_adl_risk_v3,
									self.en := right,
									self := left), left outer, local);


// now append the phones per DID 
sysdate := ut.GetDate[1..6] + '31';
gh1 := Gong.File_Gong_History_full(did<>0 and (current_record_flag='Y' or ut.DaysApart(sysdate, deletion_date[1..6]+'31') < 365) );
// gh1 := dataset([], recordof(Gong.File_Gong_History_full) );  // for testing the rest of this stuff if you don't care about the phone counts
gh := distribute(gh1, hash(did));

phone_slim := RECORD
	gh.did;
	phone := gh.phone10;
	dt_first_seen := MIN(GROUP,IF((unsigned)gh.dt_first_seen=0,999999,(unsigned)gh.dt_first_seen));
	dt_last_seen := MAX(GROUP,(unsigned)gh.dt_last_seen);
END;
d_phone := TABLE(gh((integer)phone10<>0), phone_slim, did, phone10, LOCAL);

phone_stats := record
	did := d_phone.did;
	phone_ct := count(group);
	phone_ct_c6 := count(group, ut.DaysApart(sysdate, d_phone.dt_first_seen[1..6]+'31') < 183);
end;
phone_counts := table(d_phone, phone_stats, did, local);


// append the phone counts
with_phone_counts := join(j2, phone_counts, left.did=right.did, 
				transform(layout_adl_risk_v3, 
					self.phone_ct := right.phone_ct,
					self.phone_ct_c6 := right.phone_ct_c6;
					self := left), 
				left outer, local);
			

// GET ADL CATEGORY
ADL_Category := Header.fn_ADLSegmentation(header.File_Headers).core_check;		

layout_adl_risk_v3 addCategory(with_phone_counts le, adl_category ri) := transform
	self.adl_category := ri.ind;
	self := le;
end;

persist_name := IF (IsFCRA, 'persist::adl_risk_v3_filtered', 'persist::adl_risk_v3'); 
	
full_adl_risk_wCat := join(with_phone_counts, 
													 adl_category, 
													 left.did=right.did, 
													 addCategory(left,right), left outer, keep(1)) : persist (persist_name);									
								
return full_adl_risk_wCat;

end;
