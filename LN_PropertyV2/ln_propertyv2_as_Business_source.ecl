import header,ln_property,ln_mortgage,ut,business_header,business_headerv2,mdr;

export ln_propertyv2_as_Business_source(

	 dataset(Layout_DID_Out													                  ) pLNPropertySearch  	= File_Search_DID
	,dataset(Layouts.layout_deed_mortgage_common_model_base_scrubs	  ) pLNPropertyDeed		  = Files.Base.DeedMortgage
	,dataset(Layouts.layout_property_common_model_base_scrubs			    ) pLNPropertyTax			= Files.Base.Assessment
	,dataset(layout_addl_fares_deed									                  ) pLNPropertyAddlDeed	= File_addl_fares_deed
	,dataset(layout_addl_fares_tax									                  ) pLNPropertyAddlTax	= File_addl_Fares_tax	
	,Boolean IsPRCT = false
) := module
						
//same filter used in v1						
shared dLNPropertySearch    := pLNPropertySearch  (source_code not in ['SO','OS']);
shared dLNPropertyDeed			:= pLNPropertyDeed		;
shared dLNPropertyTax				:= pLNPropertyTax			;
shared dLNPropertyAddlDeed	:= pLNPropertyAddlDeed;
shared dLNPropertyAddlTax		:= pLNPropertyAddlTax	;
						                 
//temporarily map to v1 layout - no substantial content gained in v2
ds1 := distribute(dLNPropertyTax,hash(ln_fares_id));
ds2 := distribute(dLNPropertyAddlTax,hash(ln_fares_id));

ln_property.Layout_Property_Common_Model_BASE t1(ds1 le, ds2 ri) := transform
 self.dummy_seg := le.prop_addr_propagated_ind;
 self           := le;
 self           := ri;
 self           := [];
end;

in_file_tax := join(ds1,ds2,
                    left.ln_fares_id=right.ln_fares_id,
				    t1(left,right),
				    left outer,
				    local
			       );

src_rec_tax := record 
 header.Layout_Source_ID;
 LN_Property.Layout_Property_Common_Model_BASE;
end;

header.Mac_Set_Header_Source(in_file_tax(ln_fares_id[1] ='R'),LN_Property.Layout_Property_Common_Model_BASE,src_rec_tax,mdr.sourceTools.src_LnPropV2_Fares_Asrs,withUID1)
header.Mac_Set_Header_Source(in_file_tax(ln_fares_id[1]!='R'),LN_Property.Layout_Property_Common_Model_BASE,src_rec_tax,mdr.sourceTools.src_LnPropV2_Lexis_Asrs,withUID2) 

shared merge_tax := withUID1 + withUID2 ; 

export ln_propertyv2_tax_as_business_source := distribute(merge_tax,hash(uid));

ds3 := distribute(dLNPropertyDeed,hash(ln_fares_id));
ds4 := distribute(dLNPropertyAddlDeed,hash(ln_fares_id));

//dummy_seg field was originally used to store the propagated indicator
//logic was only applied to deed data in v1, no tax

ln_mortgage.Layout_Deed_Mortgage_Common_Model_BASE t2(ds3 le, ds4 ri) := transform
 self.dummy_seg := le.prop_addr_propagated_ind;
 self           := le;
 self           := ri;
 self           := [];
end;

in_file_deed := join(ds3,ds4,
                     left.ln_fares_id=right.ln_fares_id,
				     t2(left,right),
				     left outer,
				     local
			        );

src_rec_deed := record 
 header.Layout_Source_ID;
 LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE;
end;

header.Mac_Set_Header_Source(in_file_deed(ln_fares_id[1] ='R'),LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE,src_rec_deed,mdr.sourceTools.src_LnPropV2_Fares_Deeds			,withUID3)
header.Mac_Set_Header_Source(in_file_deed(ln_fares_id[1]!='R'),LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE,src_rec_deed,mdr.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs,withUID4)
                                                                                                                 
shared merge_deed  := withUID3 + withUID4 ; 

export ln_propertyv2_deed_as_business_source	:= distribute(merge_deed,hash(uid));

r1 := record
 unsigned6 uid;
 string12  ln_fares_id;
 string2   src;
 string1   dummy_seg;
end;

r1 t1(ln_propertyv2_deed_as_business_source le) := transform
 self           := le;
end;

r1 t2(ln_propertyv2_tax_as_business_source le) := transform
 //self.dummy_seg := '';
 self           := le;
end;

p1 := project(ln_propertyv2_deed_as_business_source,t1(left));
p2 := project(ln_propertyv2_tax_as_business_source, t2(left));

concat      := p1+p2;
concat_dist := distribute(concat,hash(ln_fares_id));
concat_sort := sort      (concat_dist,ln_fares_id,uid,src,-dummy_seg,local);
concat_dupd := dedup     (concat_sort,ln_fares_id,uid,src,local);

search_dist := distribute(dLNPropertySearch,hash(ln_fares_id));

//*** Code addeded to use the mapping old cname file to retain the cnames for BIP Business header.		 
search_map_oldcname_file := if(IsPRCT
														,dataset([],{ln_propertyv2.Layout_DID_Out -[Addr_ind,Best_addr_ind,addr_tx_id,best_addr_tx_id,Location_id,best_locid]
																				, string80 old_cname := ''})
														,dataset('~thor_data400::mapping::ln_propertyv2::cname_changes', 
																		{ln_propertyV2.Layout_DID_Out -[Addr_ind,Best_addr_ind,addr_tx_id,best_addr_tx_id,Location_id,best_locid]
																		,string80 old_cname}, thor)(source_code not in ['SO','OS'])
														);
search_map_oldcname_file_dist := distribute(search_map_oldcname_file, hash(ln_fares_id));
search_map_oldcname_file_ded	:= dedup(sort(search_map_oldcname_file_dist, ln_fares_id, source_code, nameasis, local),
																			 ln_fares_id, source_code, nameasis, local);

layout_search_ext := record
 dLNPropertySearch;
 string80 old_cname := '';
end;
											
layout_search_ext get_oldcnames(search_dist l, search_map_oldcname_file_ded r) := transform
 self.old_cname	:= r.old_cname;
 self         	:= l; 
end;

// appending the old cnames since, the epic change affected the cnames because of the business name standardization.
search_w_oldcnames := join(search_dist, search_map_oldcname_file_ded,
														left.ln_fares_id=right.ln_fares_id and
														left.source_code = right.source_code and
														trim(left.nameasis) = trim(right.nameasis),
														get_oldcnames(left,right),
														left outer,
														local
													);
																 
search_w_oldcnames_dist := distribute(search_w_oldcnames, hash(ln_fares_id));

r2 := record
 boolean is_true;
 concat_dupd.uid;
 concat_dupd.src;
 concat_dupd.dummy_seg;
 layout_search_ext; 
end;

r2 t3(search_w_oldcnames_dist le, concat_dupd ri) := transform
 self.is_true := if(le.ln_fares_id=ri.ln_fares_id and le.source_code[2]='P' and ri.dummy_seg<>'',true,false);
 self         := le;
 self         := ri;
end;

export p3 := join(search_w_oldcnames_dist,concat_dupd,
									 left.ln_fares_id=right.ln_fares_id,
									 t3(left,right),
									 local
								 );

end;