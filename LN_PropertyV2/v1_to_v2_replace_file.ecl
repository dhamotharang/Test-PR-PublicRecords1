
import ln_property, ln_propertyV2, LN_Mortgage; 

//convert repl_assessor v1 to V2
inAssessorReplv1 := dataset('~thor_data400_2::in::ln_property::20070705::repl_assessor', LN_Property.Layout_Property_Common_Model_BASE, flat);

LN_PropertyV2.layout_property_common_model_base  tassessformat(inAssessorReplv1 L) := transform

self.vendor_source_flag := map( l.vendor_source_flag = 'FAR_F' => 'F', 
                                l.vendor_source_flag = 'FAR_s' => 'S',
								l.vendor_source_flag = 'OKCTY' => 'O', 
				                l.vendor_source_flag = 'DAYTN' => 'D', '');


self.current_record := '';
self.tape_cut_date  := '';
self.certification_date := '';
self.edition_number := '';
self.prop_addr_propagated_ind := '';

self := L;

end;


inAssessorReplv2 := project(inAssessorReplv1, tassessformat(left));

r1 := output(inAssessorReplv2,, '~thor_data400_2::in::ln_propertyv2::20070705::v1_to_V2_repl_assessor', __compressed__, overwrite);

//convert repl_deed v1 to V2

Indeedreplv1 := dataset('~thor_data400::in::ln_property::20070705::repl_deed', LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, flat);

LN_PropertyV2.layout_deed_mortgage_common_model_base tnorm(Indeedreplv1 L, integer cnt) := transform

self.vendor_source_flag := map( l.vendor_source_flag = 'FAR_F' => 'F', 
                                l.vendor_source_flag = 'FAR_s' => 'S',
								l.vendor_source_flag = 'OKCTY' => 'O', 
				                l.vendor_source_flag = 'DAYTN' => 'D', '');


self.current_record := '';
self.buyer_or_borrower_ind := choose(cnt, 'O', 'B');
self.name1 := choose(cnt, L.buyer1,L.borrower1);
self.name1_id_code := choose(cnt, L.buyer1_id_code, L.borrower1_id_code);
self.name2 := choose(cnt, L.buyer2, L.borrower2);
self.name2_id_code := choose(cnt, L.buyer2_id_code, L.borrower2_id_code);
self.vesting_code := choose(cnt, L.buyer_vesting_code, L.borrower_vesting_code);
self.addendum_flag := choose(cnt, L.buyer_addendum_flag, '');
self.phone_number := choose(cnt, L.phone_number, '');
self.mailing_care_of := choose(cnt, L.buyer_mailing_address_care_of_name, '');
self.mailing_street := choose(cnt, L.buyer_mailing_full_street_address, L.borrower_mailing_full_street_address);
self.mailing_unit_number := choose(cnt, L.buyer_mailing_address_unit_number, L.borrower_mailing_unit_number);
self.mailing_csz := choose(cnt, L.buyer_mailing_address_citystatezip, L.borrower_mailing_citystatezip);
self.mailing_address_cd := choose(cnt, '', L.borrower_address_code);
self.main_record_id_code := '';
self.prop_addr_propagated_ind := '';

self := L;

end;


Indeedreplv2 := normalize(Indeedreplv1, 2, tnorm(left, counter))(name1 <> '' or name2 <> '');

r2 := output(Indeedreplv2,, '~thor_data400::in::ln_propertyv2::20070705::v1_to_V2_repl_deed', __compressed__, overwrite);



//convert repl_search v1 to V2


InsearchReplV1 := dataset('~thor_dell400_2::in::ln_property::20070705::repl_search', LN_Property.Layout_Deed_Mortgage_Property_Search, flat);

LN_PropertyV2.layout_deed_mortgage_property_search tsearchformat(InsearchReplV1 l ) := transform 

  self.dt_first_seen            := 0; 
  self.dt_last_seen             := 0; 
  self.dt_vendor_first_reported := 0; 
  self.dt_vendor_last_reported  := 0; 
  self.conjunctive_name_seq     := '' ; 
  self.phone_number             := '';
self:= l ; 
end ; 

InsearchReplV2 := project(InsearchReplV1 , tsearchformat(left)); 

r3 := output(InsearchReplV2,,'~thor_data400_2::in::ln_propertyv2::20070705::v1_to_V2_repl_search',__compressed__, overwrite); 


export v1_to_v2_replace_file := sequential(r1,r3);