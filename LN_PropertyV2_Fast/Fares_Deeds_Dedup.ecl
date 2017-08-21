import property , ln_propertyv2 ,ut, ln_property;

export Fares_deeds_dedup(dataset(recordof(LN_PropertyV2_Fast.Layout_Fares_Deeds)) in_deeds) :=
function

//this part is to clean the sale_date_yyyymmdd and recording_date_yyyymmdd fields 
NumSet := ['0','1','2','3','4','5','6','7','8','9'];

recordof(in_deeds) new_file_date_tran(in_deeds L1) := Transform
   
   Self.sale_date_yyyymmdd := IF((L1.sale_date_yyyymmdd[1] In NumSet And
                                  L1.sale_date_yyyymmdd[2] In NumSet And
				              L1.sale_date_yyyymmdd[3] In NumSet And
				              L1.sale_date_yyyymmdd[4] In NumSet And
				              L1.sale_date_yyyymmdd[5] In NumSet And
				              L1.sale_date_yyyymmdd[6] In NumSet And
				              L1.sale_date_yyyymmdd[7] In NumSet And
				              L1.sale_date_yyyymmdd[8] In NumSet And
                                  ((Integer)(L1.sale_date_yyyymmdd[1..4]) >= 1900) And
                                  ((Integer)(L1.sale_date_yyyymmdd[5..6]) Between 1 And 12) And            
                                  ((Integer)(L1.sale_date_yyyymmdd[7..8]) Between 1 And 31)),
				              L1.sale_date_yyyymmdd, '');

   Self.recording_date_yyyymmdd := IF((L1.recording_date_yyyymmdd[1] In NumSet And
                                       L1.recording_date_yyyymmdd[2] In NumSet And
				                   L1.recording_date_yyyymmdd[3] In NumSet And
				                   L1.recording_date_yyyymmdd[4] In NumSet And
				                   L1.recording_date_yyyymmdd[5] In NumSet And
				                   L1.recording_date_yyyymmdd[6] In NumSet And
				                   L1.recording_date_yyyymmdd[7] In NumSet And
				                   L1.recording_date_yyyymmdd[8] In NumSet And
                                       ((Integer)(L1.recording_date_yyyymmdd[1..4]) >= 1900) And
                                       ((Integer)(L1.recording_date_yyyymmdd[5..6]) Between 1 And 12) And            
                                       ((Integer)(L1.recording_date_yyyymmdd[7..8]) Between 1 And 31)),
				                   L1.recording_date_yyyymmdd, '');
								   
   self.apn_parcel_number_unformatted := stringlib.stringfilter(L1.apn_parcel_number_unformatted,
										'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');

   Self := L1;
END;

valid_date_new_file := Project(in_deeds, new_file_date_tran(LEFT));

slim_a := distribute(valid_date_new_file ,hash((integer)fips,(integer)prop_property_address_zip_code_[1..5]));

srt := sort(slim_a,(integer)fips,
(integer)prop_property_address_zip_code_[1..5],
owner_buyer_last_name,
owner_buyer_first_name,
c_o_name,
owner_house_number_prefix,
(integer)owner_house_number,
owner_house_number_suffix,
owner_street_direction,
trim(trim(owner_street_name[(datalib.leadmatch(owner_street_name, '00000000000000000000000000000') + 1)..],left),right),
owner_mode,
owner_quadrant,
trim(trim(owner_apartment_unit[(datalib.leadmatch(owner_apartment_unit, '00000') + 1)..],left),right),
owner_city,
owner_state,
(integer)owner_zip_code[1..5],
prop_house_number_prefix,
(integer)prop_house_number,
prop_house_number_suffix,
trim(trim(prop_street_name[(datalib.leadmatch(prop_street_name, '00000000000000000000000000000') + 1)..],left),right),
prop_mode,
prop_direction,
prop_quadrant,
trim(trim(prop_apartment_unit[(datalib.leadmatch(prop_apartment_unit, '00000') + 1)..],left),right),
prop_city,
prop_state,
(integer)document_year,
seller_name,
(integer)sale_amount,
(integer)mortgage_amount,
(integer)sale_date_yyyymmdd,
(integer)recording_date_yyyymmdd,
document_type,
transaction_type,
(integer)book_page_6x6,
lender_last_name,
lender_first_name,
lender_address,
trim(apn_parcel_number_unformatted,all),
fares_id,local);

recordof(in_deeds) rollFares(recordof(in_deeds) L, recordof(in_deeds) R) := transform
 self.fares_id := l.fares_id;
 self := r;
end;

dup := rollup(srt,
(integer)left.fips = (integer)right.fips and 
(integer)left.prop_property_address_zip_code_[1..5] = (integer)right.prop_property_address_zip_code_[1..5] and 
left.owner_buyer_last_name = right.owner_buyer_last_name and 
left.owner_buyer_first_name = right.owner_buyer_first_name and 
left.c_o_name = right.c_o_name and 
left.owner_house_number_prefix = right.owner_house_number_prefix and 
(integer)left.owner_house_number = (integer)right.owner_house_number and 
left.owner_house_number_suffix = right.owner_house_number_suffix and 
left.owner_street_direction = right.owner_street_direction and 
trim(trim(left.owner_street_name[(datalib.leadmatch(left.owner_street_name, '00000000000000000000000000000') + 1)..],left),right) = 
  trim(trim(right.owner_street_name[(datalib.leadmatch(right.owner_street_name, '00000000000000000000000000000') + 1)..],left),right) and 
left.owner_mode = right.owner_mode and 
left.owner_quadrant = right.owner_quadrant and 
trim(trim(left.owner_apartment_unit[(datalib.leadmatch(left.owner_apartment_unit, '00000') + 1)..],left),right) =
  trim(trim(right.owner_apartment_unit[(datalib.leadmatch(right.owner_apartment_unit, '00000') + 1)..],left),right) and
left.owner_city = right.owner_city and 
left.owner_state = right.owner_state and 
(integer)left.owner_zip_code[1..5] = (integer)right.owner_zip_code[1..5] and 
left.prop_house_number_prefix = right.prop_house_number_prefix and 
(integer)left.prop_house_number = (integer)right.prop_house_number and 
left.prop_house_number_suffix = right.prop_house_number_suffix and 
trim(trim(left.prop_street_name[(datalib.leadmatch(left.prop_street_name, '00000000000000000000000000000') + 1)..],left),right) = 
  trim(trim(right.prop_street_name[(datalib.leadmatch(right.prop_street_name, '00000000000000000000000000000') + 1)..],left),right) and 
left.prop_mode = right.prop_mode and 
left.prop_direction = right.prop_direction and 
left.prop_quadrant = right.prop_quadrant and 
trim(trim(left.prop_apartment_unit[(datalib.leadmatch(left.prop_apartment_unit, '00000') + 1)..],left),right) = 
  trim(trim(right.prop_apartment_unit[(datalib.leadmatch(right.prop_apartment_unit, '00000') + 1)..],left),right) and 
left.prop_city = right.prop_city and 
left.prop_state = right.prop_state and 
(integer)left.document_year = (integer)right.document_year and 
left.seller_name = right.seller_name and 
(integer)left.sale_amount = (integer)right.sale_amount and 
(integer)left.mortgage_amount = (integer)right.mortgage_amount and 
(integer)left.sale_date_yyyymmdd = (integer)right.sale_date_yyyymmdd and 
(integer)left.recording_date_yyyymmdd = (integer)right.recording_date_yyyymmdd and 
left.document_type = right.document_type and 
left.transaction_type = right.transaction_type and 
(integer)left.book_page_6x6 = (integer)right.book_page_6x6 and 
left.lender_last_name = right.lender_last_name and 
left.lender_first_name = right.lender_first_name and 
left.lender_address = right.lender_address and 
ut.nneq(trim(left.apn_parcel_number_unformatted,all),trim(right.apn_parcel_number_unformatted,all)), 
rollFares(left,right),local);

dupwgood := LN_PropertyV2_Fast.fn_junk_deed.fares_deeds(dup) ;
return dupwgood;

end;