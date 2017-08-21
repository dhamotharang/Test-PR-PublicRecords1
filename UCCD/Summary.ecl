//******
//Pull what I need from filing
fil_in := uccd.Updated_Filing;

fslim_rec := record
	fil_in.ucc_state_origin;
	fil_in.ucc_filing_num;
	fil_in.ucc_vendor;
	fil_in.ucc_process_date;
	fil_in.processing_rule;
	fil_in.ucc_key;
	fil_in.ucc_filing_type_cd;
	fil_in.ucc_filing_type_desc;
	fil_in.ucc_exp_date;
	fil_in.ucc_term_date;
	fil_in.ucc_life;
	fil_in.ucc_life_units_desc;
	fil_in.ucc_status_desc;
end;
fslim := table(fil_in, fslim_rec);
fslim_dist := distribute(fslim, hash(ucc_key));

key_state_num := dedup(fslim_dist, ucc_key, local, all);  //use this as base at the very end

//Pull what I need from events
event_in := uccd.updated_event;//uccd.BDID_Event;

eslim_rec := record
	event_in.ucc_key;
	event_in.ucc_state_origin;
	event_in.ucc_filing_num;
	event_in.event_key;
	event_in.event_document_num;
	event_in.record_type;
end;

eslim := table(event_in, eslim_rec);
eslim_dist := distribute(eslim, hash(ucc_key));

//****** Use event_key to count filings
eslim_fc_ddpd := eslim_dist(record_type = 'C');
filing_count_rec := record
	eslim_fc_ddpd.ucc_key;
	filing_count := count(group);
end;

filing_count_ds := table(eslim_fc_ddpd, filing_count_rec, ucc_key, local);


//****** Use event_document_num to count docs
eslim_dc_ddpd := dedup(eslim_dist, ucc_key, event_document_num, local, all);
document_count_rec := record
	eslim_dc_ddpd.ucc_key;
	document_count := count(group);
end;

document_count_ds := table(eslim_dc_ddpd, document_count_rec, ucc_key, local);



//*****
//Pull What I need from Party
party_in := uccd.DID_Party;
party_dist := distribute(party_in, hash(ucc_key));

deb := party_dist(std_type in uccd.set_Debtor_std_type, record_type = 'C');
sec := party_dist(std_type in uccd.set_Secured_std_type, record_type = 'C');

//***** Get the debtor count
deb_ddpd := 	deb(record_type = 'C');

deb_count_rec := record
	deb_ddpd.ucc_key;
	debtor_count := count(group);
end;

debtor_count_ds := table(deb_ddpd, deb_count_rec, ucc_key, local);

//***** Get the secured count
sec_ddpd := 	sec(record_type = 'C');

sec_count_rec := record
	sec_ddpd.ucc_key;
	secured_count := count(group);
end;

secured_count_ds := table(sec_ddpd, sec_count_rec, ucc_key, local);


//*****
//Pull What I need from Collateral

//DONT KNOW HOW YET

//*****
//Put it all together

mac_addfield(lfile, rfile, field, ofile) := macro
	#uniquename(tra)
	uccd.Layout_Summary %tra%(lfile l, rfile r) := transform
		self.field := (string)r.field;
		self := l;
	end;
	
	ofile := join(lfile, rfile, left.ucc_key = right.ucc_key,
					 %tra%(left, right), left outer, local);
endmacro;

mac_addfield(key_state_num, filing_count_ds, filing_count, fc)
mac_addfield(fc, document_count_ds, document_count, dc)
mac_addfield(dc, debtor_count_ds, debtor_count, dc2)
mac_addfield(dc2, secured_count_ds, secured_count, sc)

export Summary := dedup(sc, all);