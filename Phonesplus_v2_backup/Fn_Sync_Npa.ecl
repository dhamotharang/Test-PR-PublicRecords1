//****************Function to assign the same area to multiple recs with the same phoneL7 and phone7_did_key********************

import ut,yellowpages;
export Fn_Sync_Npa(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function;

ut.mac_phone_areacode_corrections(phplus_in,phplus_in_areacode, orig_phone);

pplus_fix_area_code := project(phplus_in_areacode, transform(recordof(phplus_in), 
											 self.npa := if(left.orig_phone[..3] <> left.npa, left.orig_phone[..3], left.npa),
											 self := left));

pplus_all_s := sort(distribute(phplus_in, hash(phone7_did_key)), phone7_did_key, local);
pplus_all_g := sort(group(pplus_all_s, phone7_did_key),-append_total_source_conf, -dt_last_seen,-append_npa_effective_dt,npa);

recordof(phplus_in) i_sync_npa(pplus_all_g le, pplus_all_g ri) := transform
  is_npa_change						:= if(le.npa <> ri.npa and  le.npa <> '' and le.append_phone_type[..3] <> 'INV', true, false);
  self.npa 					  		:= if (is_npa_change, le.npa, ri.npa);
  self.append_prior_area_code 		:= if (is_npa_change, ri.npa, '');
  self.append_npa_effective_dt		:= if (is_npa_change, le.append_npa_effective_dt, ri.append_npa_effective_dt);
  self.append_npa_last_change_dt	:= if (is_npa_change, le.append_npa_last_change_dt, ri.append_npa_last_change_dt);
  self.append_dialable_ind			:= if (is_npa_change, le.append_dialable_ind, ri.append_dialable_ind);
  self.append_place_name			:= if (is_npa_change, le.append_place_name, ri.append_place_name);
  self.append_portability_indicator	:= if (is_npa_change, le.append_portability_indicator, ri.append_portability_indicator);
  self.append_phone_type			:= if (is_npa_change, le.append_phone_type, ri.append_phone_type);
  self := ri;
  end;

pplus_all_i := iterate(pplus_all_g,i_sync_npa(left,right));

pplus_eliminate_invalid := pplus_all_i(append_phone_type[..3] <> 'INV' and append_dialable_ind = '1');

pplus_all := ungroup(pplus_eliminate_invalid);
return pplus_all;
end;