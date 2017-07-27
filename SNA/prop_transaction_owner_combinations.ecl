import ut, LN_PropertyV2;

src_ds := SNA.prop_transaction_base;

deed_file := distribute(LN_PropertyV2.file_deed_building, hash(ln_fares_id)); 

src_plus_deed := dedup(sort(join(src_ds, deed_file, left.ln_fares_id=right.ln_fares_id, 
						transform({ recordof(src_ds), 
												deed_file.contract_date, deed_file.recording_date, deed_file.fares_unformatted_apn, 
												deed_file.title_company_name, deed_file.document_type_code, deed_file.sales_price, deed_file.first_td_loan_type_code}, 
												self.recording_date := map(right.contract_date != '' => right.contract_date, right.recording_date), 
												self := left, self := right),
												local), ln_fares_id, source_code[1], did, bdid, local), 
												ln_fares_id, source_code[1], did, bdid, local);

// rollup ln_fares_id to an append buyer combination.

deeds_rollup_rec := record
  recordof(src_plus_deed);
	varstring seller_id_combination;
	varstring seller_name_combination;
	varstring buyer_id_combination;
	varstring buyer_name_combination;
	string12 geolink;
	boolean person_transaction;
	boolean business_transaction;
end;

deeds_rollup_rec to_deeds_prep_rec(src_plus_deed l) := transform
   self.seller_id_combination := map(l.source_code[1] = 'S' => map(l.did != 0 => 'P:' + trim((string)l.did), map(l.bdid != 0 => 'B:' + trim((string)l.bdid), '')), '');
	 self.seller_name_combination :=  map(l.source_code[1] = 'S' => map(l.did != 0 => 'P:' + trim(l.fname) + ' ' + trim(l.lname), map(l.bdid != 0 => 'B:' + trim(l.nameasis),'')), '');
   self.buyer_id_combination := map(l.source_code[1] = 'O' => map(l.did != 0 => 'P:' + trim((string)l.did), map(l.bdid != 0 => 'B:' + trim((string)l.bdid), '')), '');
	 self.buyer_name_combination :=  map(l.source_code[1] = 'O' => map(l.did != 0 => 'P:' + trim(l.fname) + ' ' + trim(l.lname), map(l.bdid != 0 => 'B:' + trim(l.nameasis),'')), '');
	 self.person_transaction := map(l.did != 0 => true, false);
	 self.business_transaction := map(l.bdid != 0 => true, false);
	 self.geolink := l.st + l.county + l.geo_blk;
	 self := l;
end;

deeds_fares_pre_rollup := project(src_plus_deed, to_deeds_prep_rec(left));

deeds_rollup_rec to_deeds_rollup_rec(deeds_rollup_rec l, deeds_rollup_rec r) := transform
  self.seller_id_combination := map(r.source_code[1] = 'S' => trim(l.seller_id_combination) + map(length(trim(l.seller_id_combination)) > 0 => ',', trim('')) + trim(r.seller_id_combination), l.seller_id_combination);
  self.seller_name_combination := map(r.source_code[1] = 'S' => trim(l.seller_name_combination) + map(length(trim(l.seller_name_combination)) > 0 => ',', trim('')) + trim(r.seller_name_combination), l.seller_name_combination);
  self.buyer_id_combination := map(r.source_code[1] = 'O' => trim(l.buyer_id_combination) + map(length(trim(l.buyer_id_combination)) > 0 => ',', trim('')) + trim(r.buyer_id_combination), l.buyer_id_combination);
  self.buyer_name_combination := map(r.source_code[1] = 'O' => trim(l.buyer_name_combination) + map(length(trim(l.buyer_name_combination)) > 0 => ',', trim('')) + trim(r.buyer_name_combination), l.buyer_name_combination);
	self.person_transaction := map(r.person_transaction => true, l.person_transaction);
	self.business_transaction := map(r.business_transaction => true, l.business_transaction);
  self := l;
end;

// sort by address, buyer_combination, recording_date so it keeps the very first change of ownership ln_fares_id
// dedup by buyer_id_combination so if it's re-owned by the same combination it views it as a new distinct buyer.

deeds_fares_rollup := dedup(sort(rollup(sort(deeds_fares_pre_rollup, ln_fares_id, source_code[1]) , 
			left.ln_fares_id=right.ln_fares_id, to_deeds_rollup_rec(left, right), local), 
			prim_range, zip, fares_unformatted_apn, buyer_id_combination, recording_date), 
			prim_range, zip, fares_unformatted_apn, buyer_id_combination, recording_date)
			: persist('~thor_data400::persist::fbo::property_owner_combinations');

export prop_transaction_owner_combinations := deeds_fares_rollup;