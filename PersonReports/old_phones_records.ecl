import doxie, doxie_crs, iesp, progressive_phone, ut;

export old_phones_records () := MODULE

  shared phor_old := doxie.comp_phones().old;           // doxie_crs.layout_phones_old

  iesp.bpsreport.t_BpsReportOldPhone SetOldPhones (doxie_crs.layout_phones_old L) := transform
    Self.Phone10 := L.phone;
    Self.TimeZone := L.timezone;
    Self.DateFirstSeen  := iesp.ECL2ESP.toDatestring8 ((string)L.dt_first_seen);
    Self.DateLastSeen   := iesp.ECL2ESP.toDatestring8 ((string)L.dt_last_seen);
  end;

  old_phones := project(phor_old, SetOldPhones(left));
  EXPORT oldphones := old_phones;


  // a little wider output for the phones 2 (a separate transform is more efficient)
  // first look up the phone type code
  rec_for_phonetype := {doxie_crs.layout_phones_old, string10 subj_phone10, string1 switch_type := ''};
  phor_old_for_phonetype := project(phor_old, transform(rec_for_phonetype, self.subj_phone10 := left.phone, self := left));
  progressive_phone.mac_get_switchtype(phor_old_for_phonetype, phor_old_w_phonetype)

  iesp.peoplereport.t_PeopleReportOldPhone SetOldPhones_2 (phor_old_w_phonetype L) := transform
    Self.Phone10 := L.phone;
    Self.TimeZone := L.timezone;
    Self.DateFirstSeen  := iesp.ECL2ESP.toDatestring8 ((string)L.dt_first_seen);
    Self.DateLastSeen   := iesp.ECL2ESP.toDatestring8 ((string)L.dt_last_seen);
    Self._Type := 
    //this map stmt is inspired by comparing the results of progressive_phone.mac_get_switchtype to moxie returns
    //there are additional decodes in the comments of progressive_phone.mac_get_switchtype, but i have only 
    //ever seen moxie return landline, mobile, or unknown (and qi mentioned pager)
    //no decode resulting in 'landline' exists anywhere in a central location.  cem.
    map(  
      L.switch_type = 'P'    => 'LANDLINE',
      L.switch_type = 'C'    => 'MOBILE', 
      L.switch_type = 'G'    => 'PAGER',
      'UNKNOWN'
    );
    Self.State := L.st;
    Self.City := L.city_name;
  end;

  old_phones2 := project(phor_old_w_phonetype, SetOldPhones_2(left));
  EXPORT oldphones_2 := old_phones2;

END;