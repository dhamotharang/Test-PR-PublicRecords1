

//this function should be called after doxie.MAC_Header_Field_Declare 
export MAC_Get_GLB_DPPA_Qsent(dids_in, 
                              mod_access,
                              is_roxie=false, 
                              skipAutokeys = false, 
                              company_name_value='\'\'') := functionmacro

import doxie, phonesplus, ut, autokey, Suppress;

qsent_did_key := Phonesplus.key_qsent_did;
qsent_fdid_key := Phonesplus.key_qsent_fdid;

prec := record
  Phonesplus.layoutCommonOut;
  string120 listed_name;
end;

makelistedname(string cn, string on) := if(on = '', cn, on);

prec get_by_did(qsent_did_key l) := transform
  self.glb_dppa_flag := map(l.glb_dppa_flag in ['G','B'] and ~mod_access.isValidGLB() => skip,
                            l.glb_dppa_flag in ['D','B'] and ~(mod_access.isValidDPPA() and 
             mod_access.isValidDPPAState(l.origstate)) => skip,
             l.glb_dppa_flag='U' and mod_access.isUtility() => skip,
             l.glb_dppa_flag);
  self.listed_name := makelistedname(l.company, l.origname);
  self.global_sid     := l.global_sid;
  self.record_sid     := l.record_sid;
  self := l;
end;

qsent_by_did := join(dids_in, qsent_did_key, 
                       keyed(left.did=right.l_did),
              get_by_did(right), limit(10000,skip));


fake_dids := autokey.get_dids('~thor_data400::key::qsent_');

fake_dids_ext := project(choosen(phonesplus.key_qsent_companyname(
                                   company = trim(company_name_value) or
                                   company[1..length(trim(company_name_value))+1]=trim(company_name_value)+' '),
                                   ut.limits.PHONE_PER_ADDRESS), 
                           transform(doxie.layout_references, self.did:=left.fdid));
              
prec get_by_fdid(qsent_fdid_key l) := transform
  self.glb_dppa_flag := map(l.glb_dppa_flag in ['G','B'] and ~mod_access.isValidGLB() => skip,
                            l.glb_dppa_flag in ['D','B'] and ~(mod_access.isValidDPPA() and 
             mod_access.isValidDPPAState(l.origstate)) => skip,
             l.glb_dppa_flag='U' and mod_access.isUtility() => skip,
             l.glb_dppa_flag);
  self.listed_name := makelistedname(l.company, l.origname);
  self.global_sid     := l.global_sid;
  self.record_sid     := l.record_sid;
  self := l;
end;

qsent_by_fdid := join(fake_dids + if(company_name_value<>'',fake_dids_ext),qsent_fdid_key,
                       keyed(left.did=right.fdid),
                       get_by_fdid(right), limit(10000,skip)); 
                        
qsent_pre_suppressed := if(skipAutokeys, qsent_by_did, qsent_by_did + qsent_by_fdid);    

choice := Suppress.MAC_SuppressSource(qsent_pre_suppressed, mod_access); 
    
qsent_recs := dedup(sort((choice), record), record)((confidencescore>10));

doxie.layout_pp_raw_common get_qsent_roxie(qsent_recs l) := transform

  dls_value := if(l.datelastseen=0, l.datevendorlastreported, l.datelastseen);

  self.vendor_id := 'QT';
  self.src := 'QT';
  self.tnt := if(l.activeflag='Y','V','H');
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
  self.county_code := if(l.ace_fips_st='','00',l.ace_fips_st)+l.ace_fips_county;
  self.vendor_dt_last_seen_used := if(l.datelastseen=0 and l.datevendorlastreported <>0,
                                      true, false);
  self := l;
  self := [];
end;

qsent_roxie_recs := project(qsent_recs, get_qsent_roxie(left));

doxie.layout_pp_raw_common get_penalt(qsent_roxie_recs le) := transform
  self.penalt := doxie.FN_Tra_Penalty(le.fname,le.mname,le.lname,
                             le.ssn,(string)le.dob,(string)le.did,
                             le.predir,le.prim_range,le.prim_name,le.suffix,le.postdir,le.sec_range,
                             le.city_name,le.county_name,le.st,le.zip,
                             le.phone) + if(company_name_value<>'', ut.CompanySimilar(company_name_value, le.listed_name)+3, 0);
  self := le;
end;

qsent_roxie_fltd := project(qsent_roxie_recs, get_penalt(left))(penalt<score_threshold_value);
//return qsent_roxie_fltd;

qsent_out := 
  #if(is_roxie)
     qsent_roxie_fltd;
  #else
     qsent_recs;
  #end

return qsent_out;

endmacro;
