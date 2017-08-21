import Ln_property, ln_propertyv2, LN_Mortgage;

export V2_V1_LN_infiles(string filedate) := function

BasefileNameV1 		:= '~thor_data400::in::ln_property::'+ filedate;
BasefileNameV2 		:= '~thor_data400::in::ln_propertyV2::'+ filedate;


 //**********************************************************************************************
 //**********************************************************************************************
//convert assessor V2 to V1 And use only logical file of update process

inAssessorV2 := dataset(BasefileNameV2+'::assessor', LN_Propertyv2.Layout_Property_Common_Model_BASE, thor);
inAssessorReplV2 := dataset(BasefileNameV2+'::assessor_repl', LN_Propertyv2.Layout_Property_Common_Model_BASE, thor); 

//inAssessorV2 := dataset(ln_propertyV2.filenames.inupdateAssessor, LN_Propertyv2.Layout_Property_Common_Model_BASE, thor);
//inAssessorReplV2 := dataset(ln_propertyV2.filenames.inupdateAssessorRepl, LN_Propertyv2.Layout_Property_Common_Model_BASE, thor); 


LN_Property.layout_property_common_model_base  tassessorV2toV1(LN_Propertyv2.Layout_Property_Common_Model_BASE L) := transform



self.vendor_source_flag := map( l.vendor_source_flag = 'F' => 'FAR_F', 
                                l.vendor_source_flag = 'S' => 'FAR_S',
								l.vendor_source_flag = 'O' => 'OKCTY', 
				                l.vendor_source_flag = 'D' => 'DAYTN', '');

self.visf_mailing_address := '';
self.visf_prop_address := '';
self.fares_iris_apn := '';
self.fares_non_parsed_assessee_name := '';
self.fares_non_parsed_second_assessee_name := '';	
self.fares_legal2 := '';
self.fares_legal3 := '';	
self.fares_land_use := '';	
self.fares_seller_name := '';
self.fares_calculated_land_value := '';
self.fares_calculated_improvement_value:= '';
self.fares_calculated_total_value:= ''; 
self.fares_living_square_feet:= '';
self.fares_adjusted_gross_square_feet:= ''; 
self.fares_no_of_full_baths:= '';
self.fares_no_of_half_baths:= '';
self.fares_pool_indicator:= '';
self.fares_frame:= '';
self.fares_electric_energy:= '';
self.fares_sewer:= '';
self.fares_water:= '';
self.fares_condition:= '';
self.dummy_seg:= '';
self.lexis_no:= '';
self.page_no:= '';
self.owner_2:= '';
self.message_1:= '';
self.message_2:= '';
self.vdi:= '';
self.audit_trail:= '';
self.audit_1:= '';
self.audit_2:= '';
self.audit_3:= '';
self.file_code:= '';
self.on_lexis:= '';
self.source:= '';
self.content:= '';
self.copy_2:= '';
self.lxdseg:= '';
self.filler2 := L.tape_cut_date + '00' + L.certification_date;
self := L;

end;


outAssessorV1 := project(inAssessorV2, tassessorV2toV1(left));
outAssessorReplV1 := project(inAssessorReplV2, tassessorV2toV1(left));

Aoutv1:= output(outAssessorV1,, BasefileNameV1 + '::assessor', __compressed__, overwrite);
AoutreplV1 := if(fileservices.FileExists(BasefileNameV2+'::assessor_repl'), output(outAssessorReplV1,, BasefileNameV1 + '::assessor_repl', __compressed__, overwrite), output('No New files for repl assessor'));

add_AoutV1_superfile := FileServices.AddSuperFile(ln_property.filenames.inAssessor, BasefileNameV1 + '::assessor');
add_AoutreplV1_superfile := if(fileservices.FileExists(BasefileNameV2+'::assessor_repl'), FileServices.AddSuperFile(ln_property.filenames.inAssessorRepl, BasefileNamev1 + '::assessor_repl'), output('No New files for repl assessor to add superfile'));;

//**********************************************************************************************
//**********************************************************************************************
//inDeedsRepl := dataset(ln_propertyV2.filenames.inDeedsRepl, LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE, thor); 

//inDeedsV2     := dataset(ln_propertyv2.filenames.inupdateDeeds, LN_PropertyV2.layout_deed_mortgage_common_model_base, thor); 
//inaddllegalV2 := dataset(ln_propertyv2.filenames.inupdateAddllegal, LN_PropertyV2.layout_addl_legal, flat);

inDeedsV2     := dataset(BasefileNameV2+'::deed', LN_PropertyV2.layout_deed_mortgage_common_model_base, thor); 
inaddllegalV2 := dataset(BasefileNameV2+'::addl_legal', LN_PropertyV2.layout_addl_legal, flat);

//convert deedsV2 to v1 layout
LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE tdeedsV2toV1(LN_PropertyV2.layout_deed_mortgage_common_model_base L) := transform

self.vendor_source_flag := map( l.vendor_source_flag = 'F' => 'FAR_F', 
                                l.vendor_source_flag = 'S' => 'FAR_S',
								l.vendor_source_flag = 'O' => 'OKCTY', 
				                l.vendor_source_flag = 'D' => 'DAYTN', '');

self.buyer1 := '';
self.borrower1 := '';
self.buyer1_id_code := '';
self.borrower1_id_code := '';
self.buyer2 := '';
self.borrower2 := '';
self.buyer2_id_code := '';
self.borrower2_id_code := '';
self.buyer_vesting_code := '';
self.borrower_vesting_code := '';
self.buyer_addendum_flag := '';
self.phone_number := '';
self.buyer_mailing_address_care_of_name := '';
self.buyer_mailing_full_street_address := '';
self.borrower_mailing_full_street_address := '';
self.buyer_mailing_address_unit_number :='';
self.borrower_mailing_unit_number := '';
self.buyer_mailing_address_citystatezip := '';
self.borrower_mailing_citystatezip := '';
self.borrower_address_code := '';
self.visf_seller_address := '';
self.visf_buyer_address := '';
self.visf_property_address := '';
self.hawaii_property_address_unit_number := if(L.state = 'HI', L.property_address_unit_number, '');
self.hawaii_legal := '';
self.dummy_seg:= '';
self.lexis_number:= '';
self.page_number:= '';
self.township:= '';
self.land_use_code:= '';
self.audit_trail:= '';
self.audit1:= '';
self.audit2:= '';
self.audit3:= '';
self.file_code:= '';
self.fs_profile:= '';
self.on_lexis:= '';
self.report_number:= '';
self.source:= '';
self.content:= '';
self.lxdseg:= '';
self.OKCTY_DEED_filler:= '';
self.OKCTY_DEED_reserved:= '';
self.OKCTY_DEED_reserved2:= '';
self.OKCTY_MORT_filler:= '';
self.OKCTY_MORT_filler2:= '';
self.fares_corporate_indicator:= '';
self.fares_transaction_type:= '';
self.fares_lender_address:= '';
self.fares_mortgage_date:= '';
self.fares_mortgage_deed_type:= '';
self.fares_mortgage_term_code:= '';
self.fares_mortgage_term:= '';
self.fares_building_square_feet:= '';
self.fares_foreclosure:= '';
self.fares_refi_flag:= '';
self.fares_equity_flag:= '';
self.fares_iris_apn:= '';

self := L;

end;

outdeedsV1_temp1 := project(inDeedsV2, tdeedsV2toV1(LEFT));

//grab hawaii_legal from new addl_legal files

outdeedsV1_temp1 tjoin(outdeedsV1_temp1 L, inaddllegalV2 R) := transform

self.hawaii_legal := R.addl_legal;

self := L;

end;

outdeedsV1_temp := join(distribute(outdeedsV1_temp1,hash(ln_fares_id)), distribute(inaddllegalV2, hash(ln_fares_id)), 
left.ln_fares_id = right.ln_fares_id, tjoin(left, right), left outer,local);


//denormalize deedsV2 to V1

LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE tdeedsdenorm(LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE L, LN_PropertyV2.layout_deed_mortgage_common_model_base R) := transform

self.buyer1 := if(r.buyer_or_borrower_ind = 'O', r.name1, '');
self.borrower1 := if(r.buyer_or_borrower_ind = 'B', r.name1, '');
self.buyer1_id_code := if(r.buyer_or_borrower_ind = 'O', r.name1_id_code, '');
self.borrower1_id_code := if(r.buyer_or_borrower_ind = 'B', r.name1_id_code, '');
self.buyer2 := if(r.buyer_or_borrower_ind = 'O', r.name2, '');
self.borrower2 := if(r.buyer_or_borrower_ind = 'B', r.name2,'');
self.buyer2_id_code := if(r.buyer_or_borrower_ind = 'O', r.name2_id_code, '');
self.borrower2_id_code := if(r.buyer_or_borrower_ind = 'B', r.name2_id_code, '');
self.buyer_vesting_code := if(r.buyer_or_borrower_ind = 'O',r.vesting_code, '');
self.borrower_vesting_code := if(r.buyer_or_borrower_ind = 'B', r.vesting_code,'');
self.buyer_addendum_flag := if(r.buyer_or_borrower_ind = 'O',r.addendum_flag, '');
self.phone_number := if(r.buyer_or_borrower_ind = 'O', r.phone_number, '');
self.buyer_mailing_address_care_of_name := if(r.buyer_or_borrower_ind = 'O', r.mailing_care_of, '');
self.buyer_mailing_full_street_address := if(r.buyer_or_borrower_ind = 'O', r.mailing_street,'');
self.borrower_mailing_full_street_address := if(r.buyer_or_borrower_ind = 'B', r.mailing_street, '');
self.buyer_mailing_address_unit_number := if(r.buyer_or_borrower_ind = 'O', r.mailing_unit_number, '');
self.borrower_mailing_unit_number := if(r.buyer_or_borrower_ind = 'B', r.mailing_unit_number, '');
self.buyer_mailing_address_citystatezip := if(r.buyer_or_borrower_ind = 'O' , r.mailing_csz, '');
self.borrower_mailing_citystatezip := if(r.buyer_or_borrower_ind = 'B' , r.mailing_csz, '');
self.borrower_address_code := if(r.buyer_or_borrower_ind = 'B', r.mailing_address_cd, '');

self := L;

end;


outdeedsV1 := join(distribute(outdeedsV1_temp1, hash(ln_fares_id)),
                          distribute(inDeedsV2, hash(ln_fares_id)),
						  left.ln_fares_id = right.ln_fares_id, tdeedsdenorm(left, right), local);

outdeedsV1_addllegal := join(outdeedsV1_temp,
                          distribute(inDeedsV2, hash(ln_fares_id)),
						  left.ln_fares_id = right.ln_fares_id, tdeedsdenorm(left, right), local);

DoutV1 := if(fileservices.FileExists(BasefileNameV2+'::addl_legal'), output(dedup(outdeedsV1_addllegal, all, local),, BasefileNameV1 + '::deed', __compressed__, overwrite), output(dedup(outdeedsV1, all, local),, BasefileNameV1 + '::deed', __compressed__, overwrite));

add_DoutV1_superfile := FileServices.AddSuperFile(ln_property.filenames.inDeeds, BasefileNameV1 + '::deed');

//**********************************************************************************************
//**********************************************************************************************
//convert search V2 to V1

insearchV2 := dataset(BasefileNameV2+'::search', LN_PropertyV2.layout_deed_mortgage_property_search, thor);
insearchReplV2 := dataset(BasefileNameV2+'::search_repl', LN_PropertyV2.layout_deed_mortgage_property_search, thor); 

//insearchV2 := dataset(ln_propertyV2.filenames.inupdateSearch, LN_PropertyV2.layout_deed_mortgage_property_search, thor);
//insearchReplV2 := dataset(ln_propertyV2.filenames.inupdateSearchRepl, LN_PropertyV2.layout_deed_mortgage_property_search, thor); 

LN_Property.Layout_Deed_Mortgage_Property_Search  tsearchV2toV1(LN_PropertyV2.layout_deed_mortgage_property_search L) := transform

self.vendor_source_flag := map( l.vendor_source_flag = 'F' => 'FAR_F', 
                                l.vendor_source_flag = 'S' => 'FAR_S',
								l.vendor_source_flag = 'O' => 'OKCTY', 
				                l.vendor_source_flag = 'D' => 'DAYTN', '');
self := L;
end;

outsearchV1 := project(insearchV2, tsearchV2toV1(left));
outsearchReplV1 := project(insearchReplV2, tsearchV2toV1(left));

Soutv1:= output(outsearchV1,, BasefileNameV1 + '::search', __compressed__, overwrite);
SoutreplV1 := if(fileservices.FileExists(BasefileNameV2+'::search_repl'), output(outsearchReplV1,, BasefileNamev1 + '::search_repl', __compressed__, overwrite), output('No New files for repl search'));

add_soutV1_superfile := FileServices.AddSuperFile(ln_property.filenames.insearch, BasefileNameV1 + '::search');
add_soutreplV1_superfile := if(fileservices.FileExists(BasefileNameV2+'::search_repl'), FileServices.AddSuperFile(ln_property.filenames.insearchRepl, BasefileNameV1 + '::search_repl'), output('No New files for repl search to add superfile'));


//**********************************************************************************************
//**********************************************************************************************
//convert addlnames V2 to V1

inaddlnamesV2 := dataset(BasefileNameV2+'::addl_names', LN_PropertyV2.layout_addl_names, thor);
inaddlnamesreplV2 := dataset(BasefileNameV2+'::addl_names_repl', LN_PropertyV2.layout_addl_names, thor); 

//inaddlnamesV2 := dataset(ln_propertyV2.filenames.inupdateAddlNames, LN_PropertyV2.layout_addl_names, thor);
//inaddlnamesreplV2 := dataset(ln_propertyV2.filenames.inupdateAddlNamesrepl, LN_PropertyV2.layout_addl_names, thor); 


LN_Mortgage.Layout_Addl_Names taddlnamesV2toV1(LN_PropertyV2.layout_addl_names L) := transform


self.buyer3 := '';
self.buyer3_id_code := '';
self.buyer4 := '';
self.buyer4_id_code:= '';
self.buyer5:= '';
self.buyer5_id_code:= '';
self.buyer6:= '';
self.buyer6_id_code:= '';
self.buyer7:= '';
self.buyer7_id_code:= '';
self.buyer8:= '';
self.buyer8_id_code:= '';
self.buyer9:= '';
self.buyer9_id_code:= '';
self.buyer10:= '';
self.buyer10_id_code:= '';
self.buyer11:= '';
self.buyer11_id_code:= '';
self.buyer12 := '';
self.buyer12_id_code:= '';
self.buyer13:= '';
self.buyer13_id_code:= '';
self.buyer14:= '';
self.buyer14_id_code:= '';
self.buyer15:= '';
self.buyer15_id_code:= '';
self.buyer16:= '';
self.buyer16_id_code:= '';
self.seller3:= '';
self.seller3_id_code:= '';
self.seller4:= '';
self.seller4_id_code:= '';
self.seller5:= '';
self.seller5_id_code:= '';
self.seller6:= '';
self.seller6_id_code:= '';
self.seller7:= '';
self.seller7_id_code:= '';
self.seller8:= '';
self.seller8_id_code:= '';
self.seller9:= '';
self.seller9_id_code:= '';
self.seller10:= '';
self.seller10_id_code:= '';
self.seller11:= '';
self.seller11_id_code:= '';
self.seller12:= '';
self.seller12_id_code:= '';
self.seller13:= '';
self.seller13_id_code:= '';
self.seller14:= '';
self.seller14_id_code:= '';
self.seller15:= '';
self.seller15_id_code:= '';
self.seller16:= '';
self.seller16_id_code:= '';
self := L;

end;

outaddlnamesV1_temp := project(inaddlnamesV2, taddlnamesV2toV1(left));
outaddlnamesreplV1_temp := project(inaddlnamesreplV2, taddlnamesV2toV1(left));

LN_Mortgage.Layout_Addl_Names taddlnamesdenorm(LN_Mortgage.Layout_Addl_Names L, LN_PropertyV2.layout_addl_names R) := transform

self.buyer3 := if(r.buyer_or_seller = 'O' and r.name_seq = '3', r.name, '');
self.buyer3_id_code := if(r.buyer_or_seller = 'O' and r.name_seq = '3', r.id_code, '');
self.buyer4 := if(r.buyer_or_seller = 'O' and r.name_seq = '4', r.name, '');
self.buyer4_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '4', r.id_code, '');
self.buyer5:= if(r.buyer_or_seller = 'O' and r.name_seq = '5', r.name, '');
self.buyer5_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '5', r.id_code, '');
self.buyer6:= if(r.buyer_or_seller = 'O' and r.name_seq = '6', r.name, '');
self.buyer6_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '6', r.id_code, '');
self.buyer7:= if(r.buyer_or_seller = 'O' and r.name_seq = '7', r.name, '');
self.buyer7_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '7', r.id_code, '');
self.buyer8:= if(r.buyer_or_seller = 'O' and r.name_seq = '8', r.name, '');
self.buyer8_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '8', r.id_code, '');
self.buyer9:= if(r.buyer_or_seller = 'O' and r.name_seq = '9', r.name, '');
self.buyer9_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '9', r.id_code, '');
self.buyer10:= if(r.buyer_or_seller = 'O' and r.name_seq = '10', r.name, '');
self.buyer10_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '10', r.id_code, '');
self.buyer11:= if(r.buyer_or_seller = 'O' and r.name_seq = '11', r.name, '');
self.buyer11_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '11', r.id_code, '');
self.buyer12 := if(r.buyer_or_seller = 'O' and r.name_seq = '12', r.name, '');
self.buyer12_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '12', r.id_code, '');
self.buyer13:= if(r.buyer_or_seller = 'O' and r.name_seq = '13', r.name, '');
self.buyer13_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '13', r.id_code, '');
self.buyer14:= if(r.buyer_or_seller = 'O' and r.name_seq = '14', r.name, '');
self.buyer14_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '14', r.id_code, '');
self.buyer15:= if(r.buyer_or_seller = 'O' and r.name_seq = '15', r.name, '');
self.buyer15_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '15', r.id_code, '');
self.buyer16:= if(r.buyer_or_seller = 'O' and r.name_seq = '16', r.name, '');
self.buyer16_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '16', r.id_code, '');
self.seller3:= if(r.buyer_or_seller = 'S' and r.name_seq = '3', r.name, '');
self.seller3_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '3', r.id_code, '');
self.seller4:= if(r.buyer_or_seller = 'S' and r.name_seq = '4', r.name, '');
self.seller4_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '4', r.id_code, '');
self.seller5:= if(r.buyer_or_seller = 'S' and r.name_seq = '5', r.name, '');
self.seller5_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '5', r.id_code, '');
self.seller6:= if(r.buyer_or_seller = 'S' and r.name_seq = '6', r.name, '');
self.seller6_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '6', r.id_code, '');
self.seller7:= if(r.buyer_or_seller = 'S' and r.name_seq = '7', r.name, '');
self.seller7_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '7', r.id_code, '');
self.seller8:= if(r.buyer_or_seller = 'S' and r.name_seq = '8', r.name, '');
self.seller8_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '8', r.id_code, '');
self.seller9:= if(r.buyer_or_seller = 'S' and r.name_seq = '9', r.name, '');
self.seller9_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '9', r.id_code, '');
self.seller10:= if(r.buyer_or_seller = 'S' and r.name_seq = '10', r.name, '');
self.seller10_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '10', r.id_code, '');
self.seller11:= if(r.buyer_or_seller = 'S' and r.name_seq = '11', r.name, '');
self.seller11_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '11', r.id_code, '');
self.seller12:= if(r.buyer_or_seller = 'S' and r.name_seq = '12', r.name, '');
self.seller12_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '12', r.id_code, '');
self.seller13:= if(r.buyer_or_seller = 'S' and r.name_seq = '13', r.name, '');
self.seller13_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '13', r.id_code, '');
self.seller14:= if(r.buyer_or_seller = 'S' and r.name_seq = '14', r.name, '');
self.seller14_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '14', r.id_code, '');
self.seller15:= if(r.buyer_or_seller = 'S' and r.name_seq = '15', r.name, '');
self.seller15_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '15', r.id_code, '');
self.seller16:= if(r.buyer_or_seller = 'S' and r.name_seq = '16', r.name, '');
self.seller16_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '16', r.id_code, '');
self := L;
end;


outaddlnamesV1     := join(distribute(outaddlnamesV1_temp,hash(ln_fares_id)),
                          distribute(inaddlnamesV2, hash(ln_fares_id)),
						  left.ln_fares_id = right.ln_fares_id, taddlnamesdenorm(left, right), local);

outaddlnamesreplV1 := join(distribute(outaddlnamesreplV1_temp,hash(ln_fares_id)),
                          distribute(inaddlnamesreplV2, hash(ln_fares_id)),
						  left.ln_fares_id = right.ln_fares_id, taddlnamesdenorm(left, right), local);


Noutv1:= if(fileservices.FileExists(BasefileNameV2+'::addl_names'), output(dedup(outaddlnamesV1, all, local),, BasefileNameV1 + '::addl_names', __compressed__, overwrite), output('No New files for addl names'));
NoutreplV1 := if(fileservices.FileExists(BasefileNameV2+'::addl_names_repl'),output(dedup(outaddlnamesreplV1, all, local),, BasefileNameV1 + '::addl_names_repl', __compressed__, overwrite), output('No New files for repl addl names'));

add_noutV1_superfile := if(fileservices.FileExists(BasefileNameV2+'::addl_names'), FileServices.AddSuperFile(ln_property.filenames.inaddlnames, BasefileNameV1 + '::addl_names'),  output('No New files for addl names'));
add_noutreplV1_superfile := if(fileservices.FileExists(BasefileNameV2+'::addl_names_repl'), FileServices.AddSuperFile(ln_property.filenames.inaddlnamesRepl, BasefileNameV1 + '::addl_names_repl'),  output('No New files for repl addl names to add superfile'));


build_V2_V1 := sequential(parallel(Aoutv1, AoutreplV1, Doutv1, soutv1, soutreplV1, Noutv1, NoutreplV1), 
                           parallel(add_aoutV1_superfile, add_aoutreplV1_superfile, add_doutV1_superfile, add_soutV1_superfile, add_soutreplV1_superfile, add_noutV1_superfile, add_noutreplV1_superfile)
						   );


return build_V2_V1;

end;
