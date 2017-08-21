/*2013-10-11T18:39:18Z (Jennifer Stewart)
bug 132502 - fixed misspelling and added person id to output layout
*/
export csvHeading := module

shared base :=
'parcel-number_1,name-owner-1_1,name-owner-2_1,prop-address_1,prop-city_1,prop-state_1,prop-zipcode_1,total-value_1,sale-date_1,recording-date_1, sale-price_1,name-seller_1,mortgage-amount_1,assessed-value_1,total-market-value_1,'+
'tax_year_1,assessed_value_year_1,legal-description_1,transaction_type_code,transaction_type,county_code,county,'+
'parcel-number_2,name-owner-1_2,name-owner-2_2,prop-address_2,prop-city_2,prop-state_2,prop-zipcode_2,total-value_2,sale-date_2,recording-date_2,sale-price_2,name-seller_2,mortgage-amount_2,assessed-value_2,total-market-value_2,tax_year_2,assessed_value_year_2,legal-description_2,parcel-number_3,name-owner-1_3,name-owner-2_3,prop-address_3,prop-city_3,prop-state_3,prop-zipcode_3,total-value_3,sale-date_3,recording-date_3,sale-price_3,name-seller_3,mortgage-amount_3,assessed-value_3,total-market-value_3,tax_year_3,assessed_value_year_3,legal-description_3,parcel-number_4,name-owner-1_4,name-owner-2_4,prop-address_4,prop-city_4,prop-state_4,prop-zipcode_4,total-value_4,sale-date_4,recording-date_4,sale-price_4,name-seller_4,mortgage-amount_4,assessed-value_4,total-market-value_4,tax_year_4,assessed_value_year_4,legal-description_4,subj_first_1,subj_middle_1,subj_last_1,subj_suffix_1,subj_phone10_1,subj_name-dual_1,subj_phone_type_1,subj_date_first_1,subj_date_last_1'
;

shared base_dob :=
base
+',owner_1_did,owner_1_dob_voter,owner_1_dob_proflic,owner_1_dob_ccw,owner_1_dob_hunt'
+',owner_2_did,owner_2_dob_voter,owner_2_dob_proflic,owner_2_dob_ccw,owner_2_dob_hunt'
+',seller_1_did,seller_1_dob_voter,seller_1_dob_proflic,seller_1_dob_ccw,seller_1_dob_hunt'
;

shared base_dob_crim :=
base
+',owner_1_dob_crim,owner_2_dob_crim'
+',owner_1_personid,owner_2_personid,seller_1_personid'
+',seller_1_dob_crim,name__seller_2_1,seller_2_dob_crim,seller_2_did'
;
export out := base+'\n';
export out_dob := base_dob+'\n';
export out_dob_crim := base_dob_crim+'\n';

end;