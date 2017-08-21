import aid,ln_propertyv2,ut;


EXPORT fnRecleanAndReapplyToSearch(dataset(recordof(ln_propertyv2_addressenhancements.PrepFile)) in_ds,
                                   dataset(recordof(ln_propertyv2.File_Search_DID))              in_search,
                                   dataset(recordof(ln_propertyv2.File_Assessment))              in_tax,
																	 dataset(recordof(ln_propertyv2.File_Deed))                    in_deed,					
// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta in parallel to full
																	 boolean isFast
					                        ) := module

//grab the unique set of improved fares_id's
//largely an export just to capture statistics
export recs_to_reclean := dedup(sort(distribute(in_ds(matched_by_name_street=constants.name_street or matched_by_street=constants.street or matched_by_name_primname=constants.name_primname or matched_any=''),hash(ln_fares_id)),ln_fares_id,local),ln_fares_id,local);
improved_recs0     := recs_to_reclean(matched_any='Y');

r0 := record
 //recs_to_reclean;
 improved_recs0;
 string50 addr1_to_send_to_cleaner;
 string50 addr2_to_send_to_cleaner;
end;

//pass address_line_1 if it was improved by adding the prim_range, if not pass the original prepaddr1 assigned earlier in the property build
r0 xform_choose_which_addr1(improved_recs0 le) := transform
 self.addr1_to_send_to_cleaner := if(le.matched_by_name_primname<>'',le.property_address_append_prepaddr1_from_hdr,ut.fn_KeepPrintableChars(le.property_address_append_prepaddr1));
 self.addr2_to_send_to_cleaner := le.property_address_append_prepaddr2_from_hdr;
 self := le;
end;

improved_recs := project(improved_recs0,xform_choose_which_addr1(left));

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(improved_recs,addr1_to_send_to_cleaner,addr2_to_send_to_cleaner,RawAID_property,reclean_after_hdr_appends,lFlags);

r1 := ln_propertyv2_addressenhancements.layouts.prep_rec;
																			
r1 xform_clean_the_enhanced_recs(reclean_after_hdr_appends le) := TRANSFORM
	self.RawAID_property       := le.aidwork_rawaid;
	self.prim_range_property   := le.aidwork_acecache.prim_range;
	self.predir_property       := le.aidwork_acecache.predir;
	self.prim_name_property    := le.aidwork_acecache.prim_name;
	self.addr_suffix_property  := le.aidwork_acecache.addr_suffix;
	self.postdir_property      := le.aidwork_acecache.postdir;
	self.unit_desig_property   := le.aidwork_acecache.unit_desig;
	self.sec_range_property    := le.aidwork_acecache.sec_range;
	self.p_city_name_property  := le.aidwork_acecache.p_city_name;
	self.v_city_name_property  := le.aidwork_acecache.v_city_name;
  self.st_property           := le.aidwork_acecache.st;
	self.zip_property          := le.aidwork_acecache.zip5;
	self.zip4_property         := le.aidwork_acecache.zip4;
	self.cart_property         := le.aidwork_acecache.cart;
	self.cr_sort_sz_property   := le.aidwork_acecache.cr_sort_sz;
	self.lot_property          := le.aidwork_acecache.lot;
	self.lot_order_property    := le.aidwork_acecache.lot_order;
	self.dbpc_property         := le.aidwork_acecache.dbpc;
	self.chk_digit_property    := le.aidwork_acecache.chk_digit;
	self.rec_type_property     := le.aidwork_acecache.rec_type;
	self.fips_county_property  := le.aidwork_acecache.county;
	self.geo_lat_property      := le.aidwork_acecache.geo_lat;
	self.geo_long_property     := le.aidwork_acecache.geo_long;
	self.msa_property          := if(le.aidwork_acecache.msa='','',le.aidwork_acecache.msa+'0');//pulled this from link2tek
	self.geo_blk_property      := le.aidwork_acecache.geo_blk;
	self.geo_match_property    := le.aidwork_acecache.geo_match;
	self.err_stat_property     := le.aidwork_acecache.err_stat;
	self                       := le;
END;

export clean_the_enhanced_recs := distribute(project(reclean_after_hdr_appends,xform_clean_the_enhanced_recs(left)),hash(ln_fares_id)) : persist('persist::epic_clean_enhanced_addresses'+if(isFast,'_d','f'));

ds_srch           := in_search;
ds_srch_mail      := ds_srch(source_code[2]<>'P');
ds_srch_prop      := ds_srch(source_code[2] ='P');
ds_srch_prop_dist := distribute(ds_srch_prop,hash(ln_fares_id));

//apply the address improvements back to the search file and flag them
recordof(in_search) xform_apply_property_address_improvements_back_to_search_file(ds_srch_prop_dist le, clean_the_enhanced_recs ri) := transform

 string1 add_them := (string)sum((integer)ri.matched_by_name_street,(integer)ri.matched_by_street,(integer)ri.matched_by_name_primname);
 
 self.prop_addr_propagated_ind := if(le.ln_fares_id=ri.ln_fares_id,add_them,le.prop_addr_propagated_ind); 
 self.append_prepaddr1         := if(le.ln_fares_id=ri.ln_fares_id and ri.matched_by_name_primname=constants.name_primname,ri.property_address_append_prepaddr1_from_hdr,le.append_prepaddr1); 
 self.append_prepaddr2         := if(le.ln_fares_id=ri.ln_fares_id,ri.property_address_append_prepaddr2_from_hdr,le.append_prepaddr2);
 self.append_RawAID            := if(le.ln_fares_id=ri.ln_fares_id,ri.rawaid_property,le.append_rawaid);
 self.prim_range               := if(le.ln_fares_id=ri.ln_fares_id,ri.prim_range_property,le.prim_range);
 self.predir                   := if(le.ln_fares_id=ri.ln_fares_id,ri.predir_property,le.predir);
 self.prim_name                := if(le.ln_fares_id=ri.ln_fares_id,ri.prim_name_property,le.prim_name);
 self.suffix                   := if(le.ln_fares_id=ri.ln_fares_id,ri.addr_suffix_property,le.suffix);
 self.postdir                  := if(le.ln_fares_id=ri.ln_fares_id,ri.postdir_property,le.postdir);
 self.unit_desig               := if(le.ln_fares_id=ri.ln_fares_id,ri.unit_desig_property,le.unit_desig);
 self.sec_range                := if(le.ln_fares_id=ri.ln_fares_id,ri.sec_range_property,le.sec_range);
 self.p_city_name              := if(le.ln_fares_id=ri.ln_fares_id,ri.p_city_name_property,le.p_city_name);
 self.v_city_name              := if(le.ln_fares_id=ri.ln_fares_id,ri.v_city_name_property,le.v_city_name);
 self.st                       := if(le.ln_fares_id=ri.ln_fares_id,ri.st_property,le.st);
 self.zip                      := if(le.ln_fares_id=ri.ln_fares_id,ri.zip_property,le.zip);
 self.zip4                     := if(le.ln_fares_id=ri.ln_fares_id,ri.zip4_property,le.zip4);
 self.cart                     := if(le.ln_fares_id=ri.ln_fares_id,ri.cart_property,le.cart);
 self.cr_sort_sz               := if(le.ln_fares_id=ri.ln_fares_id,ri.cr_sort_sz_property,le.cr_sort_sz);
 self.lot                      := if(le.ln_fares_id=ri.ln_fares_id,ri.lot_property,le.lot);
 self.lot_order                := if(le.ln_fares_id=ri.ln_fares_id,ri.lot_order_property,le.lot_order);
 self.dbpc                     := if(le.ln_fares_id=ri.ln_fares_id,ri.dbpc_property,le.dbpc);
 self.chk_digit                := if(le.ln_fares_id=ri.ln_fares_id,ri.chk_digit_property,le.chk_digit);
 self.rec_type                 := if(le.ln_fares_id=ri.ln_fares_id,ri.rec_type_property,le.rec_type);
 self.county                   := if(le.ln_fares_id=ri.ln_fares_id,ri.fips_county_property,le.county);
 self.geo_lat                  := if(le.ln_fares_id=ri.ln_fares_id,ri.geo_lat_property,le.geo_lat);
 self.geo_long                 := if(le.ln_fares_id=ri.ln_fares_id,ri.geo_long_property,le.geo_long);
 self.msa                      := if(le.ln_fares_id=ri.ln_fares_id,ri.msa_property,le.msa);
 self.geo_blk                  := if(le.ln_fares_id=ri.ln_fares_id,ri.geo_blk_property,le.geo_blk);
 self.geo_match                := if(le.ln_fares_id=ri.ln_fares_id,ri.geo_match_property,le.geo_match);
 self.err_stat                 := if(le.ln_fares_id=ri.ln_fares_id,ri.err_stat_property,le.err_stat);
 self                          := le;
end;

j_apply_property_address_improvements_back_to_search_file := join(ds_srch_prop_dist,clean_the_enhanced_recs,left.ln_fares_id=right.ln_fares_id,xform_apply_property_address_improvements_back_to_search_file(left,right),left outer,local);

export enhanced_search_recs := j_apply_property_address_improvements_back_to_search_file + ds_srch_mail;

//apply the address improvements back to the tax file and flag them
shared recordof(in_tax) xform_flag_and_patch_tax_records(in_tax le, clean_the_enhanced_recs ri) := transform

  string1 add_them := (string)sum((integer)ri.matched_by_name_street,(integer)ri.matched_by_street,(integer)ri.matched_by_name_primname);

  //matched_how=7 is when all we have is the street_name and we're appending the street_number... effectively creating a more complete street address
  self.property_full_street_address := if(le.ln_fares_id=ri.ln_fares_id and ri.matched_by_name_primname=constants.name_primname,ri.property_address_append_prepaddr1_from_hdr,le.property_full_street_address);
  self.property_city_state_zip      := if(le.ln_fares_id=ri.ln_fares_id and le.property_city_state_zip='',ri.property_address_append_prepaddr2_from_hdr,le.property_city_state_zip);
	self.prop_addr_propagated_ind     := if(le.ln_fares_id=ri.ln_fares_id,add_them,le.prop_addr_propagated_ind); 
	self := le;
end;

//apply the address improvements back to the deed file and flag them
shared recordof(in_deed) xform_flag_and_patch_deed_records(in_deed le, clean_the_enhanced_recs ri) := transform

  string1 add_them := (string)sum((integer)ri.matched_by_name_street,(integer)ri.matched_by_street,(integer)ri.matched_by_name_primname);
	
  self.property_full_street_address  := if(le.ln_fares_id=ri.ln_fares_id and ri.matched_by_name_primname=constants.name_primname,ri.property_address_append_prepaddr1,le.property_full_street_address);
  self.property_address_citystatezip := if(le.ln_fares_id=ri.ln_fares_id and le.property_address_citystatezip='',ri.property_address_append_prepaddr2_from_hdr,le.property_address_citystatezip);
	self.prop_addr_propagated_ind      := if(le.ln_fares_id=ri.ln_fares_id,add_them,le.prop_addr_propagated_ind); 
	self := le;
end;

export j_tax  := join(distribute(in_tax,hash(ln_fares_id)), distribute(clean_the_enhanced_recs,hash(ln_fares_id)),left.ln_fares_id=right.ln_fares_id,xform_flag_and_patch_tax_records(left,right),left outer,local);
export j_deed := join(distribute(in_deed,hash(ln_fares_id)),distribute(clean_the_enhanced_recs,hash(ln_fares_id)),left.ln_fares_id=right.ln_fares_id,xform_flag_and_patch_deed_records(left,right),left outer,local);

end;