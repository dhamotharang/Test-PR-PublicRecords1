
//export moxie_ucc_pre_key_steps := 'todo';

#workunit('name','UCC_PRE_KEY');
import uccd,ut;

//pre-process summary
ds_ucc_summary := uccd.File_WithExpSummary;
count(ds_ucc_summary);

uccd.layout_Moxie_WithExpFilingSummary   fix_ucc_summary(uccd.layout_WithExpFilingSummary l) := transform
	self.ucc_vendor 		:= ut.st2FipsCode(l.file_state);
	self.isdirect           := if(l.isdirect = true, 'Y', 'N');
	self :=l;
end;
ds_ucc_summary_fixed := project(ds_ucc_summary, fix_ucc_summary(left));
ds_ucc_summary_deduped := dedup(sort(distribute(ds_ucc_summary_fixed,hash(ucc_key)),record,local),record,local);
count(ds_ucc_summary_deduped);

ucc_summary := output(ds_ucc_summary_deduped,,'~thor_data400::base::ucc_summary_wexp_deduped_'+ UCCD.version_development);

//pre-process events
ds_ucc_events :=uccd.File_WithExpEvent;
count(ds_ucc_events);



uccd.Layout_Moxie_WithExpEvent   fix_ucc_events(uccd.layout_WithExpEvent l) := transform

	self.isdirect           := if(l.isdirect = true, 'Y', 'N');
	self :=l;
end;

ds_ucc_events_fixed := project(ds_ucc_events, fix_ucc_events(left));

ds_ucc_events_deduped := dedup(sort(distribute(ds_ucc_events_fixed,hash(ucc_key)),record_type,ucc_vendor,processing_rule,ucc_key,event_key,event_action_cd,event_action_desc,
	    file_state,contrib_num1,orig_filing_num,filing_type,filing_type_desc,document_num,filing_date,orig_filing_date,
		filed_place,filed_place_desc,isDirect,-ucc_process_date,local),record,except record_type, ucc_process_date,local);
count(ds_ucc_events_deduped);

ucc_events := output(ds_ucc_events_deduped,,'~thor_data400::base::ucc_event_wexp_deduped_' + UCCD.version_development);

//pre-processparty
ds_ucc_party :=uccd.File_WithExpParty;
count(ds_ucc_party);


uccd.layout_Moxie_WithExpParty  fix_ucc_party(uccd.layout_WithExpParty l) := transform
    self.isdirect  := if(l.isdirect = true, 'Y', 'N');
	self.bdid 	   := IF(l.bdid<>'000000000000',l.bdid,'');
	self.did 	   := IF(l.did<>'000000000000',l.did,'');
 	self :=l;
end;
ds_ucc_party_fixed := project(ds_ucc_party, fix_ucc_party(left));
count(ds_ucc_party_fixed);
ds_ucc_party_deduped := dedup(sort(distribute(ds_ucc_party_fixed,hash(ucc_key)),isDirect,ucc_vendor,ucc_key,event_key,party_key,collateral_key,party_status_cd,
        party_status_desc,party_address1_type_cd,party_address1_type_desc,bdid,did,file_state,contrib_num,orig_filing_num,
        party_type,orig_name,street_address,city,orig_state,zip_code,ssn,-p_name,name,-ucc_process_date,local),record, except record_type,ucc_process_date,insert_date,clean_address,local);
count(ds_ucc_party_deduped);

uccd.layout_Moxie_WithExpParty tskip(uccd.layout_Moxie_WithExpParty L, uccd.layout_Moxie_WithExpParty R) := transform

self.p_name := if(L.isdirect = R.isdirect and L.ucc_vendor = R.ucc_vendor and L.ucc_key = R.ucc_key 
and L.event_key = R.event_key and L.party_key = R.party_key and L.collateral_key = R.collateral_key and L.party_status_cd = R.party_status_cd and L.party_status_desc = R.party_status_desc
and L.party_address1_type_cd = R.party_address1_type_cd and L.party_address1_type_desc = R.party_address1_type_desc and L.bdid = R.bdid and L.did = R.did and L.file_state = R.file_state and
L.contrib_num = R.contrib_num and L.orig_filing_num = R.orig_filing_num and L.party_type = R.party_type and L.orig_name = R.orig_name and L.street_address = R.street_address and L.city = R.city 
and L.orig_state = R.orig_state and L.zip_code = R.zip_code and L.ssn = R.ssn and L.name = R.name and L.ucc_process_date = R.ucc_process_date and L.record_type = R.record_type and L.insert_date = R.insert_date
and L.clean_address = R.clean_address and L.p_name <> '' and R.p_name = '', skip, R.p_name);

self       := R;

end;

ds_ucc_party_rededuped := iterate(ds_ucc_party_deduped, tskip(left,right), local);

count(ds_ucc_party_rededuped);


ucc_party   := output(ds_ucc_party_rededuped,,'~thor_data400::base::ucc_party_wexp_deduped_'+ UCCD.version_development);
ucc_secured := output(ds_ucc_party_rededuped(party_type='S' or party_type='A'),,'~thor_data400::base::ucc_secured_wexp_deduped_'+ UCCD.version_development);
ucc_debtor  := output(ds_ucc_party_rededuped(party_type='D'),,'~thor_data400::base::ucc_debtor_wexp_deduped_'+ UCCD.version_development);


//pre-process collateral
ds_ucc_collateral :=uccd.File_WithExpCollateral;
count(ds_ucc_collateral);


uccd.Layout_Moxie_WithExpCollateral   fix_ucc_collateral(uccd.layout_WithExpCollateral l) := transform

	self.isdirect           := if(l.isdirect = true, 'Y', 'N');
	self :=l;
end;

ds_ucc_collateral_fixed := project(ds_ucc_collateral, fix_ucc_collateral(left));
ds_ucc_collateral_deduped := dedup(sort(distribute(ds_ucc_collateral_fixed,hash(ucc_key)),record_type,isDirect,ucc_vendor,ucc_key,event_key,file_state,orig_filing_num,collateral_type_cd,
collateral_type_desc,collateral_status_cd,collateral_status_desc,collateral_eff_date,collateral_exp_date,collateral_value_assessed_amt,
collateral_qty,collateral_units_cd,collateral_units_desc,collateral_place_cd,collateral_place_desc,collateral_desc,-ucc_process_date,local),record,except record_type, ucc_process_date,local);
count(ds_ucc_collateral_deduped);

ucc_collateral := output(ds_ucc_collateral_deduped,,'~thor_data400::base::ucc_collateral_wexp_deduped_'+ UCCD.version_development);

export moxie_ucc_pre_key_steps := parallel(ucc_summary,ucc_events, ucc_party, ucc_secured, ucc_debtor, ucc_collateral);
