import ut;
a := property.File_Fares_Assessor;

slim_a := distribute(a,hash((integer)fips_code,(integer)own_zipcode[1..5]));

srt := sort(slim_a,
(integer)fips_code,
(integer)own_zipcode[1..5],
prop_house_number_prefix,
(integer)prop_house_number,
prop_house_number_suffix,
prop_direction,
trim(trim(prop_street_name[(datalib.leadmatch(prop_street_name, '00000000000000000000000000000') + 1)..],left),right),
prop_mode,
prop_quadrant,
trim(trim(prop_apt_unit_num[(datalib.leadmatch(prop_apt_unit_num, '00000') + 1)..],left),right);
prop_city,
prop_state,
(integer)prop_zipcode[1..5],
owner_name,
owner_name_2,
owner_name1,
owner_name2,
own_house_number_prefix,
(integer)own_house_number,
own_house_number_suffix,
own_direction,
trim(trim(own_street_name[(datalib.leadmatch(own_street_name, '00000000000000000000000000000') + 1)..],left),right),
own_mode,
own_quadrant,
trim(trim(own_apt_unit_num[(datalib.leadmatch(own_apt_unit_num, '00000') + 1)..],left),right),
own_city,
own_state,
(integer)appr_improvement_val,
(integer)tax_amount,
(integer)tax_year,
(integer)document_year,
(integer)recording_date,
seller_name,
trim(a.unformatted_apn,all),
fares_id,local);

property.Layout_Fares_Assessor dupFares(property.Layout_Fares_Assessor L, property.Layout_Fares_Assessor R) := transform
 self.fares_id := l.fares_id;
 self := r;
end;

dup := rollup(srt,(integer)left.fips_code = (integer)right.fips_code and
left.own_zipcode = right.own_zipcode and
ut.nneq(trim(left.unformatted_apn,all),trim(right.unformatted_apn,all)) and
left.prop_house_number_prefix = right.prop_house_number_prefix and
(integer)left.prop_house_number = (integer)right.prop_house_number and
left.prop_house_number_suffix = right.prop_house_number_suffix and
left.prop_direction = right.prop_direction and
trim(trim(left.prop_street_name[(datalib.leadmatch(left.prop_street_name, '00000000000000000000000000000') + 1)..],left),right) = 
  trim(trim(right.prop_street_name[(datalib.leadmatch(right.prop_street_name, '00000000000000000000000000000') + 1)..],left),right) and
left.prop_mode = right.prop_mode and
left.prop_quadrant = right.prop_quadrant and
trim(trim(left.prop_apt_unit_num[(datalib.leadmatch(left.prop_apt_unit_num, '00000') + 1)..],left),right) = 
  trim(trim(right.prop_apt_unit_num[(datalib.leadmatch(right.prop_apt_unit_num, '00000') + 1)..],left),right) and
left.prop_city = right.prop_city and
left.prop_state = right.prop_state and
(integer)left.prop_zipcode[1..5] = (integer)right.prop_zipcode[1..5] and
left.owner_name = right.owner_name and
left.owner_name_2 = right.owner_name_2 and
left.owner_name1 = right.owner_name1 and
left.owner_name2 = right.owner_name2 and
left.own_house_number_prefix = right.own_house_number_prefix and
(integer)left.own_house_number = (integer)right.own_house_number and
left.own_house_number_suffix = right.own_house_number_suffix and
left.own_direction = right.own_direction and
trim(trim(left.own_street_name[(datalib.leadmatch(left.own_street_name, '00000000000000000000000000000') + 1)..],left),right) = 
  trim(trim(right.own_street_name[(datalib.leadmatch(right.own_street_name, '00000000000000000000000000000') + 1)..],left),right) and
left.own_mode = right.own_mode and
left.own_quadrant = right.own_quadrant and
trim(trim(left.own_apt_unit_num[(datalib.leadmatch(left.own_apt_unit_num, '00000') + 1)..],left),right) = 
  trim(trim(right.own_apt_unit_num[(datalib.leadmatch(right.own_apt_unit_num, '00000') + 1)..],left),right) and
left.own_city = right.own_city and
left.own_state = right.own_state and
(integer)left.appr_improvement_val = (integer)right.appr_improvement_val and
(integer)left.tax_amount = (integer)right.tax_amount and
(integer)left.tax_year = (integer)right.tax_year and
(integer)left.document_year = (integer)right.document_year and
(integer)left.recording_date = (integer)right.recording_date and
left.seller_name = right.seller_name, dupFares(left,right),local);

ut.MAC_SF_BuildProcess(dup,'~thor_data400::base::fares_2580',run_dup,2);
export Fares_assessor_dedup := run_dup;