//export moxie_ucc_pre_key_steps := 'todo';

#workunit('name','UCC_PRE_KEY');
import uccd,ut;

//pre-process summary
ds_ucc_summary := uccd.File_WithExpSummary;
count(ds_ucc_summary);

rec_WithExpFilingSummary := record
	string1	isDirect;
	string2	ucc_vendor;
	string8	ucc_process_date;
	string1	processing_rule;
	string50	ucc_key;
	string8	ucc_filing_type_cd;
	string60	ucc_filing_type_desc;
	string8	ucc_exp_date;
	string8	ucc_term_date;
	string8	ucc_life;
	string8	ucc_life_units_desc;
	string8	ucc_status_desc;
	string2	file_state;
	string32	orig_filing_num;
	string4	filing_count;
	string4	document_count;
	string3	debtor_count;
	string3	secured_count;
	
end;
rec_WithExpFilingSummary   fix_ucc_summary(uccd.layout_WithExpFilingSummary l) := transform
	self.ucc_vendor 		:= ut.st2FipsCode(l.file_state);
	self.isdirect           := if(l.isdirect = true, 'Y', 'N');
	self :=l;
end;
ds_ucc_summary_fixed := project(ds_ucc_summary, fix_ucc_summary(left));
ds_ucc_summary_deduped := dedup(sort(distribute(ds_ucc_summary_fixed,hash(ucc_key)),record,local),record,local);
count(ds_ucc_summary_deduped);
output(ds_ucc_summary_deduped,,'base::ucc_summary_wexp_deduped_'+ UCCD.version_development);

//pre-process events
ds_ucc_events :=uccd.File_WithExpEvent;
count(ds_ucc_events);

rec_WithExpEvent := record

	string1 	record_type;  //current/historical
	string2	ucc_vendor;
	string8	ucc_process_date;		
	string1	processing_rule;		
	string50	ucc_key;
	string20	event_key;		
	string8	event_action_cd;
	string60	event_action_desc;		
	string2	file_state;
	string8	contrib_num1;
	string32	orig_filing_num;
	string8	filing_type;
	string60	filing_type_desc;
	string32	document_num;
	string8	filing_date;
	string8	orig_filing_date;
	string25	filed_place;
	string60	filed_place_desc;
	string1 isDirect;
end;

rec_WithExpEvent   fix_ucc_events(uccd.layout_WithExpEvent l) := transform

	self.isdirect           := if(l.isdirect = true, 'Y', 'N');
	self :=l;
end;

ds_ucc_events_fixed := project(ds_ucc_events, fix_ucc_events(left));

ds_ucc_events_deduped := dedup(sort(distribute(ds_ucc_events_fixed,hash(ucc_key)),record,local),record,local);
count(ds_ucc_events_deduped);

output(ds_ucc_events_deduped,,'base::ucc_event_wexp_deduped_' + UCCD.version_development);

//pre-processparty
ds_ucc_party :=uccd.File_WithExpParty;
count(ds_ucc_party);

rec_WithExpParty :=  record
	string1   	record_type; 		 // current/historical
	string1   	isDirect;
	string2   	ucc_vendor;
	string8   	ucc_process_date;			
	string50  	ucc_key;
	string20  	event_key;
	string20  	party_key;
	string20  	collateral_key;			
	string8   	party_status_cd;
	string60  	party_status_desc;
	string8   	party_address1_type_cd;
	string60  	party_address1_type_desc;			
	string12  	bdid;
	string12	did;
	string2   	file_state;
	string8   	contrib_num;
	string32  	orig_filing_num;
	string1   	party_type;
	string350 	orig_name;
	string200 	street_address;
	string60  	city;
	string50  	orig_state;
	string15  	zip_code;
	string8   	insert_date;
	string10  	ssn;
	string182 	clean_address;
	string70  	p_name;
	string200 	name;
	
end;
rec_WithExpParty  fix_ucc_party(uccd.layout_WithExpParty l) := transform
    self.isdirect  := if(l.isdirect = true, 'Y', 'N');
	self.bdid 	   := IF(l.bdid<>'000000000000',l.bdid,'');
	self.did 	   := IF(l.did<>'000000000000',l.did,'');
 	self :=l;
end;
ds_ucc_party_fixed := project(ds_ucc_party, fix_ucc_party(left));
count(ds_ucc_party_fixed);
ds_ucc_party_deduped := dedup(sort(distribute(ds_ucc_party_fixed,hash(ucc_key)),record,local),record,local);
count(ds_ucc_party_deduped);
output(ds_ucc_party_deduped,,'base::ucc_party_wexp_deduped_'+ UCCD.version_development);
output(ds_ucc_party_deduped(party_type='S' or party_type='A'),,'base::ucc_secured_wexp_deduped_'+ UCCD.version_development);
output(ds_ucc_party_deduped(party_type='D'),,'base::ucc_debtor_wexp_deduped_'+ UCCD.version_development);

//pre-process collateral
ds_ucc_collateral :=uccd.File_WithExpCollateral;
count(ds_ucc_collateral);

rec_WithExpCollateral := record
	string1		record_type; // current/historical
	string1		isDirect;
	string2 		ucc_vendor;
	string8 		ucc_process_date;		
	string50 		ucc_key;
	string20 		event_key;		
	string2 		file_state;
	string32 		orig_filing_num;
	string25 		collateral_type_cd;
	string60 		collateral_type_desc;
	string8 		collateral_status_cd;
	string60		collateral_status_desc;
	string8 		collateral_eff_date;
	string8 		collateral_exp_date;
	string15 		collateral_value_assessed_amt;
	string15 		collateral_qty;
	string8 		collateral_units_cd;
	string60 		collateral_units_desc;
	string8 		collateral_place_cd;
	string60 		collateral_place_desc;
	string512 	collateral_desc;
end;

rec_WithExpCollateral   fix_ucc_collateral(uccd.layout_WithExpCollateral l) := transform

	self.isdirect           := if(l.isdirect = true, 'Y', 'N');
	self :=l;
end;

ds_ucc_collateral_fixed := project(ds_ucc_collateral, fix_ucc_collateral(left));
ds_ucc_collateral_deduped := dedup(sort(distribute(ds_ucc_collateral_fixed,hash(ucc_key)),record,local),record,local);
count(ds_ucc_collateral_deduped);
output(ds_ucc_collateral_deduped,,'base::ucc_collateral_wexp_deduped_'+ UCCD.version_development);



