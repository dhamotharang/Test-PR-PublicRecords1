import ln_property, ln_mortgage;

in_ln_tax       := dataset('~thor_data400::in::ln_property::assessor',     ln_property.Layout_Property_Common_Model_BASE,flat);
in_ln_tax_repl  := dataset('~thor_data400::in::ln_property::assessor_repl',ln_property.Layout_Property_Common_Model_BASE,flat);
in_ln_deed      := dataset('~thor_data400::in::ln_property::deed',         ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base,flat);
in_ln_srch      := dataset('~thor_data400::in::ln_property::search',       ln_property.Layout_Deed_Mortgage_Property_Search,flat);
in_ln_srch_repl := dataset('~thor_data400::in::ln_property::search_repl',  ln_property.Layout_Deed_Mortgage_Property_Search,flat);

ln_propertyv2.layout_property_common_model_base t_tax_v1_in_to_v2_in(ln_property.Layout_Property_Common_Model_BASE le) := transform

 self.vendor_source_flag := map( le.vendor_source_flag = 'FAR_F' => 'F', 
                                 le.vendor_source_flag = 'FAR_S' => 'S',
								 le.vendor_source_flag = 'OKCTY' => 'O', 
				                 le.vendor_source_flag = 'DAYTN' => 'D',
								 '');
 self.tape_cut_date      := le.filler2[1..6];
 self.certification_date := le.filler2[9..16];
 
 self.current_record := '';
 self.edition_number := '';
 self.prop_addr_propagated_ind := '';
 self := le;

end;

convert_in_tax      := project(in_ln_tax,     t_tax_v1_in_to_v2_in(left));
convert_in_tax_repl := project(in_ln_tax_repl,t_tax_v1_in_to_v2_in(left));

true_deed_records := in_ln_deed(from_file='D');
true_mort_records := in_ln_deed(from_file='M');

ln_propertyv2.layout_deed_mortgage_common_model_base t_deed_v1_in_to_v2_in(true_deed_records le) := transform

 self.vendor_source_flag := map( le.vendor_source_flag = 'FAR_F' => 'F', 
                                 le.vendor_source_flag = 'FAR_S' => 'S',
								 le.vendor_source_flag = 'OKCTY' => 'O', 
				                 le.vendor_source_flag = 'DAYTN' => 'D',
								 '');

 self.buyer_or_borrower_ind := 'O';
 self.name1                 := le.buyer1;
 self.name1_id_code         := le.buyer1_id_code;
 self.name2                 := le.buyer2;
 self.name2_id_code         := le.buyer2_id_code;
 self.vesting_code          := le.buyer_vesting_code;
 self.addendum_flag         := le.buyer_addendum_flag;
 //self.phone_number          := '';
 self.mailing_care_of       := le.buyer_mailing_address_care_of_name;
 self.mailing_street        := le.buyer_mailing_full_street_address;
 self.mailing_unit_number   := if(le.state!='HI',Le.buyer_mailing_address_unit_number, 
                               if(length(trim(Le.hawaii_property_address_unit_number, left, right)) >6 and regexfind('-', Le.hawaii_property_address_unit_number), Le.hawaii_property_address_unit_number[stringlib.stringfind(Le.hawaii_property_address_unit_number, '-', 1) + 1 .. length(trim(Le.hawaii_property_address_unit_number, left,right))],
                                Le.buyer_mailing_address_unit_number));
 self.mailing_csz           := le.buyer_mailing_address_citystatezip;
 self.mailing_address_cd    := ''; //looks like borrowers only
 
 self.legal_brief_description := trim(stringlib.stringcleanspaces(le.legal_brief_description+' '+le.hawaii_legal));
 
 self := le;
 self := [];

end;

ln_propertyv2.layout_deed_mortgage_common_model_base t_mort_v1_in_to_v2_in(true_mort_records le) := transform

 self.vendor_source_flag := map( le.vendor_source_flag = 'FAR_F' => 'F', 
                                 le.vendor_source_flag = 'FAR_S' => 'S',
								 le.vendor_source_flag = 'OKCTY' => 'O', 
				                 le.vendor_source_flag = 'DAYTN' => 'D',
								 '');

 self.buyer_or_borrower_ind := 'B';
 self.name1                 := le.borrower1;
 self.name1_id_code         := le.borrower1_id_code;
 self.name2                 := le.borrower2;
 self.name2_id_code         := le.borrower2_id_code;
 self.vesting_code          := le.borrower_vesting_code;
 self.addendum_flag         := ''; //looks like owners only
 //self.phone_number          := '';
 self.mailing_care_of       := ''; //looks like owners only
 self.mailing_street        := le.borrower_mailing_full_street_address;
 self.mailing_unit_number   := if(le.state!='HI',le.borrower_mailing_unit_number, 
                               if(length(trim(Le.hawaii_property_address_unit_number, left, right)) >6 and regexfind('-', Le.hawaii_property_address_unit_number), Le.hawaii_property_address_unit_number[stringlib.stringfind(Le.hawaii_property_address_unit_number, '-', 1) + 1 .. length(trim(Le.hawaii_property_address_unit_number, left,right))],
                                le.borrower_mailing_unit_number));
 self.mailing_csz           := le.borrower_mailing_citystatezip;
 self.mailing_address_cd    := le.borrower_address_code;
 
 self.legal_brief_description := trim(stringlib.stringcleanspaces(le.legal_brief_description+' '+le.hawaii_legal));
 
 self := le;
 self := [];

end;

convert_in_true_deed_records := project(true_deed_records,t_deed_v1_in_to_v2_in(left));
convert_in_true_mort_records := project(true_mort_records,t_mort_v1_in_to_v2_in(left));

bring_back_together_deed := convert_in_true_deed_records+convert_in_true_mort_records;

in_ln_tax_has_phone      := distribute(in_ln_tax(assessee_phone_number<>''),hash(ln_fares_id));
in_ln_tax_repl_has_phone := distribute(in_ln_tax_repl(assessee_phone_number<>''),hash(ln_fares_id));

in_ln_deed_has_phone     := distribute(in_ln_deed(phone_number<>''),hash(ln_fares_id));

in_ln_srch_tax       := in_ln_srch(ln_fares_id[2] ='A');
in_ln_srch_repl_tax  := in_ln_srch_repl(ln_fares_id[2] ='A');

in_ln_srch_deed      := in_ln_srch(ln_fares_id[2]!='A');

ln_propertyv2.layout_deed_mortgage_property_search t_search_v1_in_to_v2_in_tax(ln_property.Layout_Deed_Mortgage_Property_Search le, ln_property.Layout_Property_Common_Model_BASE ri) := transform

//this code was taken from ln_property.prop_joined

 	//same for seller and buyer
 self.dt_first_seen := map(le.source_code[2]='O'                 => (integer)(ri.tax_year + '00'),
		                   (integer)ri.recording_date > 19000000 => (integer)(ri.recording_date[1..6]), 
		                   (integer)ri.sale_date      > 19000000 => (integer)(ri.sale_date[1..6]),
		                   (integer)(ri.tax_year + '00')
						   );
										 
	//tax year for buyer
 self.dt_last_seen := if(le.source_code[1] = 'O',   
						 // when buyer
						 (integer)(ri.tax_year + '00'),
						 // when seller
						 if((integer)ri.recording_date > 19000000, (integer)(ri.recording_date[1..6]), (integer)(ri.sale_date[1..6]))
						);
							 
 self.dt_vendor_last_reported  := (unsigned3)(ri.process_date[1..6]);
 self.dt_vendor_first_reported := (unsigned3)(ri.process_date[1..6]);
	
 self.conjunctive_name_seq := '';
 self.phone_number         := ri.assessee_phone_number;
 self                      := le;
end;

ln_propertyv2.layout_deed_mortgage_property_search t_search_v1_in_to_v2_in_deed(ln_property.Layout_Deed_Mortgage_Property_Search le, ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base ri) := transform

//this code was taken from ln_property.prop_joined

 self.dt_first_seen            := (integer)(ri.recording_date[1..6]);
 self.dt_last_seen             := (integer)(ri.recording_date[1..6]);
 self.dt_vendor_last_reported  := (unsigned3)(ri.process_date[1..6]);
 self.dt_vendor_first_reported := (unsigned3)(ri.process_date[1..6]);
	
 self.conjunctive_name_seq := '';
 self.phone_number         := ri.phone_number;
 self                      := le;
 
end;

j_srch_tax := join(in_ln_srch_tax,in_ln_tax_has_phone,
                   left.ln_fares_id=right.ln_fares_id,
			       t_search_v1_in_to_v2_in_tax(left,right),
			       left outer,
			       local
			      );

j_srch_deed := join(in_ln_srch_deed,in_ln_deed_has_phone,
                   left.ln_fares_id=right.ln_fares_id,
			       t_search_v1_in_to_v2_in_deed(left,right),
			       left outer,
			       local
			      );
				  
j_srch_repl_tax := join(in_ln_srch_repl_tax,in_ln_tax_repl_has_phone,
                        left.ln_fares_id=right.ln_fares_id,
			            t_search_v1_in_to_v2_in_tax(left,right),
			            left outer,
			            local
			           );

bring_back_together_search := j_srch_tax + j_srch_deed;
/*
output(count(in_ln_tax),named('tax_before'));
output(count(in_ln_tax_repl),named('tax_repl_before'));
output(count(in_ln_deed),named('deed_before'));
output(count(in_ln_srch),named('search_before'));
output(count(in_ln_srch_repl),named('search_repl_before'));

output(count(convert_in_tax),named('tax_after'));
output(count(convert_in_tax_repl),named('tax_repl_after'));
output(count(bring_back_together_deed),named('deed_after'));
output(count(bring_back_together_search),named('search_after'));
output(count(j_srch_repl_tax),named('search_repl_after'));

*/
//intended to cover tax in superfile	

output(convert_in_tax,,'~thor_data400::in::ln_propertyv2::v1_v2_assessor_thru_20071010',__compressed__);
//intended to cover tax replacement in superfile
output(convert_in_tax_repl,,'~thor_data400::in::ln_propertyv2::v1_v2_repl_assessor_thru_20070814',__compressed__);
//intended to cover deed in superfile
output(bring_back_together_deed,,'~thor_data400::in::ln_propertyv2::v1_v2_deed_thru_20071010',__compressed__);
//intended to cover search in superfile
output(bring_back_together_search,,'~thor_data400::in::ln_propertyv2::v1_v2_search_thru_20071010',__compressed__);
//intended to cover search replacement in superfile
//i have confirmed that only tax records are in here
output(j_srch_repl_tax,,'~thor_data400::in::ln_propertyv2::v1_v2_repl_search_thru_20070814',__compressed__);
