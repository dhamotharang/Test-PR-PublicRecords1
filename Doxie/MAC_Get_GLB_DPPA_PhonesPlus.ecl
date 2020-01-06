
//this function should be called after doxie.MAC_Header_Field_Declare 
export MAC_Get_GLB_DPPA_PhonesPlus(dids_in,
                                   mod_access,
                                   is_roxie=false, 
                                   skipAutokeys = false,
                                   min_confidencescore = 11,
                                   company_name_value = '\'\'',
                                   autokey_skipset = '[]',
                                   autokey_fetch_nofail = true,
                                   is_CompReport=false,
                                   checkRNA=false ) := functionmacro

import doxie, ut, autokey, Phones, header, Phonesplus_v2, Data_Services;

cell_did_key := Phonesplus_v2.Key_Phonesplus_Did;
cell_fdid_key := Phonesplus_v2.key_phonesplus_fdid;

prec := record
  Phonesplus_v2.layoutCommonOut;
  string120 listed_name;
  boolean isDeepDive := false;
end;

makelistedname(string cn, string on) := if(on = '', cn, on);

prec get_by_did(cell_did_key l) := transform
  self.vendor := if(~is_roxie and ~Phonesplus_v2.IsCell(l.append_phone_type), skip, l.vendor);
  self.glb_dppa_flag := IF (Phones.Functions.IsPhoneRestricted(l.origstate, 
                                                               mod_access.glb,
                                                               mod_access.dppa,
                                                               mod_access.industry_class,
                                                               , //checkRNA
                                                               l.datefirstseen,
                                                               l.dt_nonglb_last_seen,
                                                               l.rules,
                                                               l.src_all,
                                                               mod_access.DataRestrictionMask
                                                               ), SKIP, l.glb_dppa_flag);
  self.listed_name := makelistedname(l.company, l.origname);
  self.isDeepDive := true;
  self := l;
end;

cell_by_did := join(dids_in, cell_did_key, 
                      keyed(left.did=right.l_did),
             get_by_did(right), LIMIT(ut.limits.PHONE_PER_PERSON,SKIP));

fake_dids := autokey.get_dids(Data_Services.Data_location.Prefix() + 'thor_data400::key::phonesplusv2_',autokey_skipset,,autokey_fetch_nofail);

fake_dids_ext := project(choosen(Phonesplus_v2.Key_Phonesplus_Companyname(
                                   company = trim(company_name_value) or 
                                   company[1..length(trim(company_name_value))+1]= trim(company_name_value)+' '),
                                   ut.limits.PHONE_PER_ADDRESS), 
                           transform(doxie.layout_references, self.did:=left.fdid));
                   
prec get_by_fdid(cell_fdid_key  l) := transform
  self.vendor := if(~is_roxie and ~Phonesplus_v2.IsCell(l.append_phone_type), skip, l.vendor);
  self.glb_dppa_flag := IF (Phones.Functions.IsPhoneRestricted(l.origstate, 
                                                               mod_access.glb,
                                                               mod_access.dppa,
                                                               mod_access.industry_class,
                                                               , //checkRNA
                                                               l.datefirstseen,
                                                               l.dt_nonglb_last_seen,
                                                               l.rules,
                                                               l.src_all,
                                                               mod_access.DataRestrictionMask
                                                              ), SKIP, l.glb_dppa_flag);
  self.listed_name := makelistedname(l.company, l.origname);
  self := l;
end;

cell_by_fdid := join(fake_dids + if(company_name_value<>'', fake_dids_ext), cell_fdid_key,
                       keyed(left.did=right.fdid),
           get_by_fdid(right), LIMIT(ut.limits.PHONE_PER_PERSON,SKIP)); 
       
choice := if(skipAutokeys, cell_by_did, cell_by_did + cell_by_fdid);  

Header.MAC_Filter_Sources(choice,choice_post_filter,src,mod_access.DataRestrictionMask);  

cell_recs := dedup(sort((choice_post_filter), record), record, except isDeepDive)(confidencescore >= min_confidencescore);

doxie.layout_pp_raw_common get_cell_slim(cell_recs l) := transform
     
  dls_value := if(l.datelastseen=0, l.datevendorlastreported, l.datelastseen);
  
  self.vendor_id := l.vendor;
  self.src := if(l.vendor='GH', 'PH', l.src);
  self.tnt := if(l.vendor='GH', 'H', '');
  self.phone := l.cellphone;
  self.listing_type_res := if(trim(l.ListingType, left, right) in ['R','BR','RS'],'R','');  
  self.listing_type_bus := if(trim(l.ListingType, left, right) in ['B','BG','BR'],'B','');
  self.listing_type_gov := if(trim(l.ListingType, left, right) in ['G','BG'],'G','');
  self.dt_last_seen := ut.date6_to_date8(dls_value);
  self.dt_first_seen := ut.date6_to_date8(if(l.datefirstseen<=dls_value, l.datefirstseen, 0));
  self.dob := (integer4)l.dob;
  self.suffix := l.addr_suffix;
  self.city_name := l.p_city_name;
  self.st := l.state;
  self.zip := l.zip5;
  self.vendor_dt_last_seen_used := if(l.datelastseen=0 and l.datevendorlastreported <>0,
                                      true, false);
  self.county_code := if(l.ace_fips_st='','00',l.ace_fips_st)+l.ace_fips_county;
  self := l;
  self := [];
end;

cell_slim_recs := project(cell_recs, get_cell_slim(left));

doxie.layout_pp_raw_common get_penalt(cell_slim_recs le) := transform
 self.penalt := doxie.FN_Tra_Penalty_addr( le.predir,le.prim_range,le.prim_name,le.suffix,
                                          le.postdir,le.sec_range,le.city_name,le.st,le.zip, false ) + 
                 doxie.FN_Tra_Penalty_name(le.fname,le.mname,le.lname, 
                           false ,false ) +
                 doxie.FN_Tra_Penalty_phone(le.phone) +
                 doxie.FN_Tra_Penalty_DID((string)le.did) +
                 doxie.FN_Tra_Penalty_DOB((string)le.dob) +
                 doxie.FN_Tra_Penalty_County(le.county_name) +
          if(company_name_value<>'', ut.CompanySimilar(company_name_value, le.listed_name)+3, 0);
  self := le;
end;

cell_roxie_pen := project(cell_slim_recs, get_penalt(left))(penalt<score_threshold_value);

cell_roxie := if(is_CompReport, cell_slim_recs, cell_roxie_pen);

cell_out := if(is_roxie, cell_roxie, cell_slim_recs);  

RETURN cell_out;
endmacro;
