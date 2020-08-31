import Location_Services, doxie_ln, doxie_raw, LN_PropertyV2, LN_PropertyV2_Services;

export deed_records(DATASET(Doxie_Raw.Layout_address_input) addrs, 
                    DATASET(Location_Services.layout_fid) bfids) := FUNCTION

k		:= LN_PropertyV2.key_deed_fid();
kf	:= LN_PropertyV2.key_addl_fares_deed_fid;

rec := doxie_ln.layout_deed_records;

string stripz(string s) := (string)((integer8)s);

rec take_right2(layout_fid l, k r) := transform
	self.current := 0;   //l.current;
	self.source_code := l.source_code;
	self.sales_price := stripz(r.sales_price);
	self.first_td_loan_amount := stripz(r.first_td_loan_amount);
	
	self.vendor_source_flag := LN_PropertyV2_Services.fn_vendor_source(r.vendor_source_flag);
	
	buyer := r.buyer_or_borrower_ind='O';
	self.buyer1																:= if(buyer, r.name1,								'');
	self.buyer1_id_code												:= if(buyer, r.name1_id_code,				'');
	self.buyer2																:= if(buyer, r.name2,								'');
	self.buyer2_id_code												:= if(buyer, r.name2_id_code,				'');
	self.buyer_vesting_code										:= if(buyer, r.vesting_code,				'');
	self.buyer_addendum_flag									:= if(buyer, r.addendum_flag,				'');
	self.buyer_mailing_address_care_of_name		:= if(buyer, r.mailing_care_of,			'');
	self.buyer_mailing_full_street_address		:= if(buyer, r.mailing_street,			'');
	self.buyer_mailing_address_unit_number		:= if(buyer, r.mailing_unit_number,	'');
	self.buyer_mailing_address_citystatezip		:= if(buyer, r.mailing_csz,					'');
	
	borrower := r.buyer_or_borrower_ind='B';
	self.borrower1														:= if(borrower, r.name1,								'');
	self.borrower1_id_code										:= if(borrower, r.name1_id_code,				'');
	self.borrower2														:= if(borrower, r.name2,								'');
	self.borrower2_id_code										:= if(borrower, r.name2_id_code,				'');
	self.borrower_vesting_code								:= if(borrower, r.vesting_code,					'');
	self.borrower_mailing_full_street_address	:= if(borrower, r.mailing_street,				'');
	self.borrower_mailing_unit_number					:= if(borrower, r.mailing_unit_number,	'');
	self.borrower_mailing_citystatezip				:= if(borrower, r.mailing_csz,					'');
	self.borrower_address_code								:= if(borrower, r.mailing_address_cd,		'');
	
  self := r;
	self := [];
 end;
 
addrFids := Location_Services.property_ids(addrs);
fids := dedup(sort(addrFids + bfids, fid),fid);

d := JOIN(fids(fid[2]<>'A'),k,left.fid=right.ln_fares_id
											AND not LN_PropertyV2.fn_isAssignmentAndReleaseRecord(right.record_type,right.state,right.document_type_code), //Assignments and Releases codes excluded
          take_right2(left, right), limit(0), keep(1));

rec addlFares(rec L, kf R) := transform
	self.fares_corporate_indicator	:= R.fares_corporate_indicator; 
	self.fares_transaction_type			:= R.fares_transaction_type; 
	self.fares_lender_address				:= R.fares_lender_address; 
	self.fares_mortgage_date				:= R.fares_mortgage_date; 
	self.fares_mortgage_deed_type		:= R.fares_mortgage_deed_type; 
	self.fares_mortgage_term_code		:= R.fares_mortgage_term_code; 
	self.fares_mortgage_term				:= stripz(R.fares_mortgage_term); 
	self.fares_building_square_feet	:= R.fares_building_square_feet; 
	self.fares_foreclosure					:= R.fares_foreclosure; 
	self.fares_refi_flag						:= R.fares_refi_flag; 
	self.fares_equity_flag					:= R.fares_equity_flag;
	self.fares_iris_apn							:= R.fares_iris_apn;
	self := L;
end;

df := join(
	d, kf,
	keyed(left.ln_fares_id=right.ln_fares_id),
	addlFares(left,right),
	left outer, limit(0), keep (1)
);

return df;

end;