//get additional names.  no fares records
import LN_Mortgage, ln_property, census_data, ut;

#workunit ('name', 'Build LNProp MOXIE output files');

an1 := LN_PropertyV2.File_ln_deed_addlnames;
LN_Mortgage.Layout_Moxie_Addl_Names getnames(an1 L) := transform
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

an2 := project(an1, getnames(left));

LN_Mortgage.Layout_Moxie_Addl_Names taddlnamesdenorm(LN_Mortgage.Layout_Moxie_Addl_Names	 L, LN_PropertyV2.layout_addl_names R) := transform

self.buyer3 := if(r.buyer_or_seller = 'O' and r.name_seq = '3', r.name, l.buyer3);
self.buyer3_id_code := if(r.buyer_or_seller = 'O' and r.name_seq = '3', r.id_code, l.buyer3_id_code);
self.buyer4 := if(r.buyer_or_seller = 'O' and r.name_seq = '4', r.name, l.buyer4);
self.buyer4_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '4', r.id_code, l.buyer4_id_code);
self.buyer5:= if(r.buyer_or_seller = 'O' and r.name_seq = '5', r.name, l.buyer5);
self.buyer5_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '5', r.id_code, l.buyer5_id_code);
self.buyer6:= if(r.buyer_or_seller = 'O' and r.name_seq = '6', r.name, l.buyer6);
self.buyer6_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '6', r.id_code, l.buyer6_id_code);
self.buyer7:= if(r.buyer_or_seller = 'O' and r.name_seq = '7', r.name, l.buyer7);
self.buyer7_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '7', r.id_code, l.buyer7_id_code);
self.buyer8:= if(r.buyer_or_seller = 'O' and r.name_seq = '8', r.name, l.buyer8);
self.buyer8_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '8', r.id_code, l.buyer8_id_code);
self.buyer9:= if(r.buyer_or_seller = 'O' and r.name_seq = '9', r.name, l.buyer9);
self.buyer9_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '9', r.id_code, l.buyer9_id_code);
self.buyer10:= if(r.buyer_or_seller = 'O' and r.name_seq = '10', r.name, l.buyer10);
self.buyer10_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '10', r.id_code, l.buyer10_id_code);
self.buyer11:= if(r.buyer_or_seller = 'O' and r.name_seq = '11', r.name, l.buyer11);
self.buyer11_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '11', r.id_code, l.buyer11_id_code);
self.buyer12 := if(r.buyer_or_seller = 'O' and r.name_seq = '12', r.name, l.buyer12);
self.buyer12_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '12', r.id_code, l.buyer12_id_code);
self.buyer13:= if(r.buyer_or_seller = 'O' and r.name_seq = '13', r.name, l.buyer13);
self.buyer13_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '13', r.id_code, l.buyer13_id_code);
self.buyer14:= if(r.buyer_or_seller = 'O' and r.name_seq = '14', r.name, l.buyer14);
self.buyer14_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '14', r.id_code, l.buyer14_id_code);
self.buyer15:= if(r.buyer_or_seller = 'O' and r.name_seq = '15', r.name, l.buyer15);
self.buyer15_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '15', r.id_code, l.buyer15_id_code);
self.buyer16:= if(r.buyer_or_seller = 'O' and r.name_seq = '16', r.name, l.buyer16);
self.buyer16_id_code:= if(r.buyer_or_seller = 'O' and r.name_seq = '16', r.id_code, l.buyer16_id_code);
self.seller3:= if(r.buyer_or_seller = 'S' and r.name_seq = '3', r.name, l.seller3);
self.seller3_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '3', r.id_code, l.seller3_id_code);
self.seller4:= if(r.buyer_or_seller = 'S' and r.name_seq = '4', r.name, l.seller4);
self.seller4_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '4', r.id_code, l.seller4_id_code);
self.seller5:= if(r.buyer_or_seller = 'S' and r.name_seq = '5', r.name, l.seller5);
self.seller5_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '5', r.id_code, l.seller5_id_code);
self.seller6:= if(r.buyer_or_seller = 'S' and r.name_seq = '6', r.name, l.seller6);
self.seller6_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '6', r.id_code, l.seller6_id_code);
self.seller7:= if(r.buyer_or_seller = 'S' and r.name_seq = '7', r.name, l.seller7);
self.seller7_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '7', r.id_code, l.seller7_id_code);
self.seller8:= if(r.buyer_or_seller = 'S' and r.name_seq = '8', r.name, l.seller8);
self.seller8_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '8', r.id_code, l.seller8_id_code);
self.seller9:= if(r.buyer_or_seller = 'S' and r.name_seq = '9', r.name, l.seller9);
self.seller9_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '9', r.id_code, l.seller9_id_code);
self.seller10:= if(r.buyer_or_seller = 'S' and r.name_seq = '10', r.name, l.seller10);
self.seller10_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '10', r.id_code, l.seller10_id_code);
self.seller11:= if(r.buyer_or_seller = 'S' and r.name_seq = '11', r.name, l.seller11);
self.seller11_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '11', r.id_code, l.seller11_id_code);
self.seller12:= if(r.buyer_or_seller = 'S' and r.name_seq = '12', r.name, l.seller12);
self.seller12_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '12', r.id_code, l.seller12_id_code);
self.seller13:= if(r.buyer_or_seller = 'S' and r.name_seq = '13', r.name, l.seller13);
self.seller13_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '13', r.id_code, l.seller13_id_code);
self.seller14:= if(r.buyer_or_seller = 'S' and r.name_seq = '14', r.name, l.seller14);
self.seller14_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '14', r.id_code, l.seller14_id_code);
self.seller15:= if(r.buyer_or_seller = 'S' and r.name_seq = '15', r.name, l.seller15);
self.seller15_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '15', r.id_code, l.seller15_id_code);
self.seller16:= if(r.buyer_or_seller = 'S' and r.name_seq = '16', r.name, l.seller16);
self.seller16_id_code:= if(r.buyer_or_seller = 'S' and r.name_seq = '16', r.id_code, l.seller16_id_code);
self := L;
end;


denormaddlnames     := dedup(denormalize(distribute(an2,hash(ln_fares_id)),
                          distribute(an1, hash(ln_fares_id)),
						  left.ln_fares_id = right.ln_fares_id, taddlnamesdenorm(left, right), local),all);

denormaddlnames addfidext(denormaddlnames L) := transform
self.ln_fares_id := 'RD' + l.ln_fares_id;
self := l ; 
end; 

outaddlnames := project(denormaddlnames , addfidext(left)) ; 

//get assessors

Assessor := distribute(LN_PropertyV2.File_Assessment,hash(ln_fares_id));
addltax := distribute(LN_PropertyV2.File_addl_Fares_tax,hash(ln_fares_id)); 
addllegal :=  distribute(LN_PropertyV2.File_addl_legal ,hash(ln_fares_id)); 

temp_rec := record 
 LN_PropertyV2.layout_property_common_model_base; 
 string60  fares_iris_apn;
 string60  fares_non_parsed_assessee_name;
 string60  fares_non_parsed_second_assessee_name;
 string10  fares_land_use;
 string60  fares_seller_name;
 string11  fares_calculated_land_value;
 string11  fares_calculated_improvement_value;
 string11  fares_calculated_total_value;
 string7   fares_living_square_feet;
 string7   fares_adjusted_gross_square_feet;
 string5   fares_no_of_full_baths;
 string5   fares_no_of_half_baths;
 string1   fares_pool_indicator;
 string3   fares_frame;
 string3   fares_electric_energy;
 string3   fares_sewer;
 string3   fares_water;
 string3   fares_condition;
end; 

temp_rec tjoin( Assessor l ,addltax r ) := transform 

//this removes the decimal point inserted for roxie
self.tax_amount := stringlib.stringfilterout(l.tax_amount,'.');

//in fn_patch_tax we remove the 2 implied decimals - need to add them back here
self.market_land_value := if(l.market_land_value<>'',trim(l.market_land_value,left,right)+'00','');

self.fares_iris_apn                            := r.fares_iris_apn ; 
self.fares_non_parsed_assessee_name            := r.fares_non_parsed_assessee_name ; 
self.fares_non_parsed_second_assessee_name     := r.fares_non_parsed_second_assessee_name ; 
self.fares_land_use                            := r.fares_land_use ; 
self.fares_seller_name                         := r.fares_seller_name ; 
self.fares_calculated_land_value               := r.fares_calculated_land_value ; 
self.fares_calculated_improvement_value        := r.fares_calculated_improvement_value ; 
self.fares_calculated_total_value              := r.fares_calculated_total_value ;
self.fares_living_square_feet                  := r.fares_living_square_feet ; 
self.fares_adjusted_gross_square_feet          := r.fares_adjusted_gross_square_feet ; 
self.fares_no_of_full_baths                    := r.fares_no_of_full_baths ; 
self.fares_no_of_half_baths                    := r.fares_no_of_half_baths ;
self.fares_pool_indicator                      := r.fares_pool_indicator ; 
self.fares_frame                               := r.fares_frame ; 
self.fares_electric_energy                     := r.fares_electric_energy ; 
self.fares_sewer                               := r.fares_sewer ; 
self.fares_water                               := r.fares_water ; 
self.fares_condition                          := r.fares_condition; 

self:= l ;
end; 

get_fares := join(Assessor , addltax , left.ln_fares_id = right.ln_fares_id , tjoin(left,right),left outer,local) ;

temp_rec1 := record 
  temp_rec ;
  string250	fares_legal2;
  string250	fares_legal3;	
end ; 

temp_rec1 tjoinlegal( get_fares l , addllegal r) := transform 
 self := l ;
 self.fares_legal2 := trim(r.addl_legal[1..250],left,right) ;
 self.fares_legal3 := trim(r.addl_legal[250 ..500],left,right); 
 end; 
 
get_fares_legal := join(get_fares , addllegal , left.ln_fares_id = right.ln_fares_id , tjoinlegal(left,right),left outer ,local);  

LN_Property.Layout_Moxie_Property_Common_Model_BASE getAssess(get_fares_legal L) := transform
 
 self.vendor_source_flag := map( l.vendor_source_flag = 'F' => 'FAR_F', 
                                l.vendor_source_flag = 'S' => 'FAR_S',
								l.vendor_source_flag = 'O' => 'OKCTY','DAYTN'); 
				                
 self.ln_fares_id := 'RA' + l.ln_fares_id;
// self.fares_unformatted_apn := if(l.ln_fares_id[1]!='R',stripFormat(l.apna_or_pin_number),l.fares_unformatted_apn);
 self.prior_recording_date := if(length(l.prior_recording_date) = length(stringlib.stringfilter(l.prior_recording_date,'0123456789')),
							l.prior_recording_date,'');
 self.fares_land_use           := if(l.vendor_source_flag in ['O','D'],l.standardized_land_use_code,  l.fares_land_use);
 self.fares_living_square_feet := if(l.vendor_source_flag in ['O','D'],(string)(integer)l.building_area,      l.fares_living_square_feet);
 self.fares_no_of_full_baths   := if(l.vendor_source_flag in ['O','D'],(string)(integer)l.no_of_baths,        l.fares_no_of_full_baths);
 self.fares_no_of_half_baths   := if(l.vendor_source_flag in ['O','D'],(string)(integer)l.no_of_partial_baths,l.fares_no_of_half_baths);
 self.condo_project_name			 := l.condo_project_or_building_name;
 self.building_name			 			 := l.condo_project_or_building_name;
 self.filler2 := L.tape_cut_date + '00' + L.certification_date;
 self.visf_mailing_address := '';
 self.visf_prop_address := '';
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
 self             := l;
end;

outassess := project(get_fares_legal, getAssess(left));

//get deeds

deeds     := distribute(LN_PropertyV2.File_Deed,hash(ln_fares_id));
addldeeds := distribute(LN_PropertyV2.File_addl_fares_deed,hash(ln_fares_id)); 
//addllegal := distribute(LN_PropertyV2.File_addl_legal , hash(ln_fares_id)); 

deed_temp := record 
 LN_PropertyV2.layout_deed_mortgage_common_model_base ; 
 string1  fares_corporate_indicator;
 string3  fares_transaction_type;
 string60 fares_lender_address;
 string8  fares_mortgage_date;
 string6  fares_mortgage_deed_type;
 string4  fares_mortgage_term_code;
 string5  fares_mortgage_term;
 string9  fares_building_square_feet;
 string1  fares_foreclosure;
 string1  fares_refi_flag;
 string1  fares_equity_flag;
 string60 fares_iris_apn;
 string51 hawaii_legal := '';
 end;
 
deed_temp refjoin( deeds l ,addldeeds r ) := transform 

//this removes the decimal point inserted for roxie
self.city_transfer_tax   := stringlib.stringfilterout(l.city_transfer_tax,'.');
self.county_transfer_tax := stringlib.stringfilterout(l.county_transfer_tax,'.');
self.total_transfer_tax  := stringlib.stringfilterout(l.total_transfer_tax,'.'); 

self.fares_corporate_indicator := r.fares_corporate_indicator ; 
self.fares_transaction_type    := r.fares_transaction_type   ;
self.fares_lender_address      := r.fares_lender_address     ; 
self.fares_mortgage_date       := r.fares_mortgage_date      ;
self.fares_mortgage_deed_type  := r.fares_mortgage_deed_type ; 
self.fares_mortgage_term_code  := r.fares_mortgage_term_code ; 
self.fares_mortgage_term       := r.fares_mortgage_term      ; 
self.fares_building_square_feet := r.fares_building_square_feet ; 
self.fares_foreclosure          := r.fares_foreclosure ; 
self.fares_refi_flag            := r.fares_refi_flag ; 
self.fares_equity_flag          := r.fares_equity_flag ; 
self.fares_iris_apn             := r.fares_iris_apn ; 

self:= l ;

end ; 
get_deeds_fares := join(deeds , addldeeds , left.ln_fares_id = right.ln_fares_id , refjoin(left,right),left outer,local) ;

//check the below hawaii_legal mapping is this necessary? 

deed_temp reformatjoin( get_deeds_fares l ,addllegal r ) := transform 
self.hawaii_legal := trim(r.addl_legal,left,right)  ;
self:= l ;  
end ; 

get_deeds_fares_legal := join(get_deeds_fares , addllegal , left.ln_fares_id = right.ln_fares_id , reformatjoin(left,right),left outer,local) ;

LN_Mortgage.Layout_Moxie_Deed_Mortgage_Common_Model_Base getdeeds(get_deeds_fares_legal L) := transform
 self.ln_fares_id := 'RD' + l.ln_fares_id;
 //self.fares_unformatted_apn := if(l.ln_fares_id[1]!='R',stripFormat(l.apnt_or_pin_number),l.fares_unformatted_apn);
 self.vendor_source_flag := map( l.vendor_source_flag = 'F' => 'FAR_F', 
                                l.vendor_source_flag = 'S' => 'FAR_S',
								l.vendor_source_flag = 'O' => 'OKCTY','DAYTN'); 
				                
self.buyer1 := if(l.buyer_or_borrower_ind = 'O', l.name1, '');
self.borrower1 := if(l.buyer_or_borrower_ind = 'B', l.name1, '');
self.buyer1_id_code := if(l.buyer_or_borrower_ind = 'O', l.name1_id_code, '');
self.borrower1_id_code := if(l.buyer_or_borrower_ind = 'B', l.name1_id_code, '');
self.buyer2 := if(l.buyer_or_borrower_ind = 'O', l.name2, '');
self.borrower2 := if(l.buyer_or_borrower_ind = 'B', l.name2,'');
self.buyer2_id_code := if(l.buyer_or_borrower_ind = 'O', l.name2_id_code, '');
self.borrower2_id_code := if(l.buyer_or_borrower_ind = 'B', l.name2_id_code, '');
self.buyer_vesting_code := if(l.buyer_or_borrower_ind = 'O',l.vesting_code, '');
self.borrower_vesting_code := if(l.buyer_or_borrower_ind = 'B', l.vesting_code,'');
self.buyer_addendum_flag := if(l.buyer_or_borrower_ind = 'O',l.addendum_flag, '');
self.phone_number := if(l.buyer_or_borrower_ind = 'O', l.phone_number, '');
self.buyer_mailing_address_care_of_name := if(l.buyer_or_borrower_ind = 'O', l.mailing_care_of, '');
self.buyer_mailing_full_street_address := if(l.buyer_or_borrower_ind = 'O', l.mailing_street,'');
self.borrower_mailing_full_street_address := if(l.buyer_or_borrower_ind = 'B', l.mailing_street, '');
self.buyer_mailing_address_unit_number := if(l.buyer_or_borrower_ind = 'O', l.mailing_unit_number, '');
self.borrower_mailing_unit_number := if(l.buyer_or_borrower_ind = 'B', l.mailing_unit_number, '');
self.buyer_mailing_address_citystatezip := if(l.buyer_or_borrower_ind = 'O' , l.mailing_csz, '');
self.borrower_mailing_citystatezip := if(l.buyer_or_borrower_ind = 'B' , l.mailing_csz, '');
self.borrower_address_code := if(l.buyer_or_borrower_ind = 'B', l.mailing_address_cd, '');

self.hawaii_property_address_unit_number := if(L.state = 'HI', L.property_address_unit_number, '');

self.visf_seller_address := '';
self.visf_buyer_address := '';
self.visf_property_address := '';
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
self             := l;
end;

outdeeds := project(get_deeds_fares_legal, getdeeds(left));

//get search records

s1 := LN_PropertyV2.file_search_building;

LN_Property.Layout_Moxie_Deed_Mortgage_Property_Search getsearch(s1 L) := transform

 self.vendor_source_flag := map( l.vendor_source_flag = 'F' => 'FAR_F', 
                                l.vendor_source_flag = 'S' => 'FAR_S',
								l.vendor_source_flag = 'O' => 'OKCTY','DAYTN'); 
 self.ln_fares_id := if(l.ln_fares_id[2] = 'A', 'RA', 'RD') + l.ln_fares_id;
 self.did         := intformat(l.did,12,1);
 self.bdid        := intformat(l.bdid,12,1);
 self             := l;
end;

s2   := project(s1, getsearch(left));
s2d  := distribute(s2, hash(ln_fares_id));
s2fa := s2d(ln_fares_id[2]  = 'A'); 
s2fd := s2d(ln_fares_id[2] != 'A');

// check below distributes needed

outassess_dist     := distribute(outassess, hash(ln_fares_id)); 
outdeeds_dist      := distribute(outdeeds,  hash(ln_fares_id));
outaddlnames_dist  := distribute(outaddlnames, hash(ln_fares_id));

//  Only use search records that are present in assess and deeds
//  Add source state when needed

LN_Property.Layout_Moxie_Deed_Mortgage_Property_Search keepFormat1(outassess l, s2 r) := transform
 self.st := if(r.st='' and r.source_code[2]='P',l.state_code,r.st);
 self := r;
end;

LN_Property.Layout_Moxie_Deed_Mortgage_Property_Search keepFormat2(outdeeds l, s2 r) := transform
 self.st := if(r.st='' and r.source_code[2]='P',l.state,r.st);
 self := r;
end;

LN_Property.Layout_Moxie_Deed_Mortgage_Property_Search keepFormat3(s2 l) := transform
 self := l;
end;

s3 := join(outassess_dist, s2fa, left.ln_fares_id = right.ln_fares_id, keepFormat1(left, right), local); 
s4 := join(outdeeds_dist,  s2fd, left.ln_fares_id = right.ln_fares_id, keepFormat2(left, right), local); 
s5 := join(outaddlnames_dist,  s2d,  left.ln_fares_id = right.ln_fares_id, keepFormat3(right), local); 

outsearch := s3 + s4 + s5;

//Build Moxie Base 

/*
ut.MAC_SF_BuildProcess(outassess,'~thor_data400::base::ln_propertyv2::moxie.Assessor',bld_Mpropertyv2_Assesor,2,,true);
ut.MAC_SF_BuildProcess(outdeeds,'~thor_data400::base::ln_propertyv2::moxie.Deeds',bld_Mpropertyv2_Deeds,2,,true);
ut.MAC_SF_BuildProcess(outaddlnames,'~thor_data400::base::ln_propertyv2::moxie.addlnames',bld_Mpropertyv2_addlnames,2,,true);
ut.MAC_SF_BuildProcess(outsearch,'~thor_data400::base::ln_propertyv2::moxie.search',bld_Mpropertyv2_search,2,,true);
*/

ut.MAC_SF_Build_standard(outaddlnames_dist,ln_property.filenames.versionedOutAddlNames, one,   ln_property.version_build)
ut.MAC_SF_Build_standard(outassess_dist, ln_property.filenames.versionedOutAssessor,  two,   ln_property.version_build)
ut.MAC_SF_Build_standard(outdeeds_dist,  ln_property.filenames.versionedOutDeed,      three, ln_property.version_build)
ut.MAC_SF_Build_standard(outsearch, ln_property.filenames.versionedOutSearch,    four,  ln_property.version_build)

export Proc_MapAndBuild_Moxie_Base := parallel(one, two, three, four);