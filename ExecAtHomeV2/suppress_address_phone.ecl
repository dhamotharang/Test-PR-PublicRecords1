import DMA, Doxie, dx_DMA;

export suppress_address_phone(grouped dataset(execathomev2.layout_eah_person_best) file_supp_ready
  ) := function

//suppress address
execathomev2.layout_eah_person_best suppress_addr(execathomev2.layout_eah_person_best l, DMA.key_DNM_Name_Address r) := transform
  self.do_not_mail_flag  := if(r.l_prim_name = '', '', 'Y');
  self := l;
end;

file_supp_addr := join(file_supp_ready, DMA.key_DNM_Name_Address,
  keyed(left.person_prim_name = right.l_prim_name) and
  keyed(left.person_prim_range = right.l_prim_range) and
  keyed(left.person_best_state = right.l_st) and
  keyed(right.l_city_code in Doxie.Make_CityCodes(left.person_best_city).rox) and
  keyed(left.person_best_zip = right.l_zip) and
  keyed(left.person_sec_range = right.l_sec_range) and
  keyed(left.person_best_lname = right.l_lname) and
  keyed(left.person_best_fname = right.l_fname),
  suppress_addr(left, right), left outer, keep(1));

//suppress phone
file_supp_phone := dx_DMA.AppendDoNotCallFlag(file_supp_addr, person_best_phone);
return file_supp_phone;

end;
