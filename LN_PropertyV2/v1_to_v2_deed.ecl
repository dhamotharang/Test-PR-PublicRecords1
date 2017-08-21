
import LN_PropertyV2, LN_Mortgage, ln_property;

//deed_in := dataset('~thor_data400::base::ln_property::20070705::deed', LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, flat);

//inDeedsRepl := dataset(ln_propertyV2.filenames.inDeedsRepl, LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE, thor); 
inDeedsV1     := dataset(ln_property.filenames.inDeeds, LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, thor)(fips_code[1..2] in ['12', '39']); 

LN_PropertyV2.layout_deed_mortgage_common_model_base tnorm(LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE L, integer cnt) := transform

self.vendor_source_flag := map( l.vendor_source_flag = 'FAR_F' => 'F', 
                                l.vendor_source_flag = 'FAR_S' => 'S',
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


outdeedsV2 := normalize(inDeedsV1, 2, tnorm(left, counter))(name1 <> '' or name2 <> '');

//outdeedsreplV2 :=  

outV2 := output(outdeedsV2,, '~thor_data400::in::ln_propertyv2::fl_oh::v1_to_V2_deed', __compressed__, overwrite);
//outdeedsreplV2 := output(

add_deedsV2_super := FileServices.AddSuperFile(ln_propertyV2.filenames.inDeeds, '~thor_data400::in::ln_propertyv2::fl_oh::v1_to_V2_deed');

//add_deedsreplV2_super := FileServices.AddSuperFile
export v1_to_v2_deed := sequential(outV2, add_deedsV2_super);