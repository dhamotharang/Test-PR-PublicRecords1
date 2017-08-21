import ut, STD;
export specificities(dataset(layout_file_business_header) h) := MODULE
export input_layout := record // project out required fields
  unsigned6 BDID := h.BDID; // using existing id field
  h.RCID;//RIDfield 
  h.fein;
  h.phone;
  h.vendor_id;
  typeof(h.company_name) company_name := Fields.Make_company_name((string)h.company_name ); // Cleans before using
  h.prim_range;
  h.zip;
  h.sec_range;
  h.zip4;
  typeof(h.CITY) CITY := if ( Fields.Invalid_CITY(h.CITY)=0,h.CITY,(typeof(h.CITY))'' ); // Blanks if invalid
  h.unit_desig;
  h.county;
  h.prim_name;
  h.state;
  h.msa;
  h.SOURCE;
  h.addr_suffix;
  unsigned4 locale := 0; // Place holder filled in by project
  unsigned4 address := 0; // Place holder filled in by project
END;
r := input_layout;
h01 := distribute(table(h,r),BDID); // group for the specificity_local function
input_layout do_computes(h01 le) := transform
  self.locale := hash32(le.zip,le.state,le.CITY,le.msa); // Combine child fields into 1 for specificity counting
  self.address := hash32(le.prim_range,le.sec_range,le.prim_name,le.zip4,le.unit_desig,le.addr_suffix); // Combine child fields into 1 for specificity counting
  self := le;
end;
shared h0 := project(h01,do_computes(left));
export input_file := h0  : persist(_dataset().thor_cluster_persists + 'persist::BDID::Business_Header_Bdid_lift::Specificities_Cache');
  MAC_Specificity_Local(input_file,fein,BDID,fein_nulls,Layout_Specificities.fein_ChildRec,fein_specificity,fein_switch,fein_values,false);
  o := fein_values; // place holder for fuzzy logic
export fein_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_fein');
  MAC_Specificity_Local(input_file,phone,BDID,phone_nulls,Layout_Specificities.phone_ChildRec,phone_specificity,phone_switch,phone_values,false);
  o := phone_values; // place holder for fuzzy logic
export phone_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_phone');
  MAC_Specificity_Local(input_file,vendor_id,BDID,vendor_id_nulls,Layout_Specificities.vendor_id_ChildRec,vendor_id_specificity,vendor_id_switch,vendor_id_values,false);
  o := vendor_id_values; // place holder for fuzzy logic
export vendor_id_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_vendor_id');
  MAC_Specificity_Local(input_file,company_name,BDID,company_name_nulls,Layout_Specificities.company_name_ChildRec,company_name_specificity,company_name_switch,company_name_values,false);
  o := company_name_values; // place holder for fuzzy logic
// This field is a word bag; so create specifcities for the words too
  MAC_Specificity_Local(input_file,company_name,BDID,company_name_words_nulls,Layout_Specificities.company_name_ChildRec,company_name_words_specificity,company_name_words_switch,company_name_words_values,false,true);
export company_name_values_key := index(company_name_words_values,{company_name},{company_name_words_values},'~thor_data400::key::values::Business_Header_Bdid_lift_BDID_company_name');
  mac_wordbag_addweights(company_name_values,company_name,company_name_words_values,p);
export company_name_values_persisted := p : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_company_name');
  MAC_Specificity_Local(input_file,prim_range,BDID,prim_range_nulls,Layout_Specificities.prim_range_ChildRec,prim_range_specificity,prim_range_switch,prim_range_values,false);
  mac_edit_distance_pairs(prim_range_values,prim_range,cnt,1,false,o);//Computes specificities of fuzzy matches
export prim_range_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_prim_range');
  MAC_Specificity_Local(input_file,zip,BDID,zip_nulls,Layout_Specificities.zip_ChildRec,zip_specificity,zip_switch,zip_values,false);
  o := zip_values; // place holder for fuzzy logic
export zip_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_zip');
  MAC_Specificity_Local(input_file,sec_range,BDID,sec_range_nulls,Layout_Specificities.sec_range_ChildRec,sec_range_specificity,sec_range_switch,sec_range_values,false);
  o := sec_range_values; // place holder for fuzzy logic
export sec_range_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_sec_range');
  MAC_Specificity_Local(input_file,zip4,BDID,zip4_nulls,Layout_Specificities.zip4_ChildRec,zip4_specificity,zip4_switch,zip4_values,false);
  o := zip4_values; // place holder for fuzzy logic
export zip4_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_zip4');
  MAC_Specificity_Local(input_file,CITY,BDID,CITY_nulls,Layout_Specificities.CITY_ChildRec,CITY_specificity,CITY_switch,CITY_values,false);
  o := CITY_values; // place holder for fuzzy logic
export CITY_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_CITY');
  MAC_Specificity_Local(input_file,unit_desig,BDID,unit_desig_nulls,Layout_Specificities.unit_desig_ChildRec,unit_desig_specificity,unit_desig_switch,unit_desig_values,false);
  o := unit_desig_values; // place holder for fuzzy logic
export unit_desig_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_unit_desig');
  MAC_Specificity_Local(input_file,county,BDID,county_nulls,Layout_Specificities.county_ChildRec,county_specificity,county_switch,county_values,false);
  o := county_values; // place holder for fuzzy logic
export county_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_county');
  MAC_Specificity_Local(input_file,prim_name,BDID,prim_name_nulls,Layout_Specificities.prim_name_ChildRec,prim_name_specificity,prim_name_switch,prim_name_values,false);
  o := prim_name_values; // place holder for fuzzy logic
export prim_name_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_prim_name');
  MAC_Specificity_Local(input_file,state,BDID,state_nulls,Layout_Specificities.state_ChildRec,state_specificity,state_switch,state_values,false);
  o := state_values; // place holder for fuzzy logic
export state_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_state');
  MAC_Specificity_Local(input_file,msa,BDID,msa_nulls,Layout_Specificities.msa_ChildRec,msa_specificity,msa_switch,msa_values,false);
  o := msa_values; // place holder for fuzzy logic
export msa_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_msa');
  MAC_Specificity_Local(input_file,SOURCE,BDID,SOURCE_nulls,Layout_Specificities.SOURCE_ChildRec,SOURCE_specificity,SOURCE_switch,SOURCE_values,false);
  o := SOURCE_values; // place holder for fuzzy logic
export SOURCE_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_SOURCE');
  MAC_Specificity_Local(input_file,addr_suffix,BDID,addr_suffix_nulls,Layout_Specificities.addr_suffix_ChildRec,addr_suffix_specificity,addr_suffix_switch,addr_suffix_values,false);
  o := addr_suffix_values; // place holder for fuzzy logic
export addr_suffix_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_addr_suffix');
  MAC_Specificity_Local(input_file,locale,BDID,locale_nulls,Layout_Specificities.locale_ChildRec,locale_specificity,locale_switch,locale_values,false);
  o := locale_values; // place holder for fuzzy logic
export locale_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_locale');
  MAC_Specificity_Local(input_file,address,BDID,address_nulls,Layout_Specificities.address_ChildRec,address_specificity,address_switch,address_values,false);
  o := address_values; // place holder for fuzzy logic
export address_values_persisted := o : persist(_dataset().thor_cluster_persists + 'persist::values::Business_Header_Bdid_lift_BDID_address');
export Specificities := dataset([{0,fein_specificity,fein_switch,fein_nulls,phone_specificity,phone_switch,phone_nulls,vendor_id_specificity,vendor_id_switch,vendor_id_nulls,company_name_specificity,company_name_switch,company_name_nulls,prim_range_specificity,prim_range_switch,prim_range_nulls,zip_specificity,zip_switch,zip_nulls,sec_range_specificity,sec_range_switch,sec_range_nulls,zip4_specificity,zip4_switch,zip4_nulls,CITY_specificity,CITY_switch,CITY_nulls,unit_desig_specificity,unit_desig_switch,unit_desig_nulls,county_specificity,county_switch,county_nulls,prim_name_specificity,prim_name_switch,prim_name_nulls,state_specificity,state_switch,state_nulls,msa_specificity,msa_switch,msa_nulls,SOURCE_specificity,SOURCE_switch,SOURCE_nulls,addr_suffix_specificity,addr_suffix_switch,addr_suffix_nulls,locale_specificity,locale_switch,locale_nulls,address_specificity,address_switch,address_nulls}],Layout_Specificities.R)
 : persist(_dataset().thor_cluster_persists + 'persist::Business_Header_Bdid_lift::BDID::Specificities');
  end;
