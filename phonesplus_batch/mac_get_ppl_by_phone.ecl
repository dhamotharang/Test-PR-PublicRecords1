export mac_get_ppl_by_phone(f_in,
                            f_out,
					                  glb_purpose = 0,
													  dppa_purpose = 0,
													  industry_class_value='\'\'',
														min_confidencescore = 11,
														data_restriction_mask='') := macro

import Data_Services, doxie, ut, doxie_files, autokey, header, cellphone, drivers, Phones, phonesplus, phonesplus_batch,Phonesplus_v2, MDR;

#uniquename(key_fdid)
#uniquename(key_auto_phone)
%key_fdid% := Phonesplus_v2.key_phonesplus_fdid;
%key_auto_phone% := autokey.Key_Phone(Data_Services.Data_location.Prefix('PhonesPlus')+
                                      'thor_data400::key::phonesplusV2_');

#uniquename(prec)
%prec% := record
  unsigned6 seq;
	string20 acctno;
	Phonesplus.layoutCommonOut;
	string120 listed_name;
end;

#uniquename(makelistedname)
%makelistedname%(string cn, string on) := if(on = '', cn, on);

#uniquename(get_ppl_fdids)
phonesplus_batch.layout_phonesplus_reverse_fdid %get_ppl_fdids%(f_in l, %key_auto_phone% r) := transform
		self.fdid := r.did;
		self := l;
end;

#uniquename(f_ppl_fdids)
%f_ppl_fdids% := join(f_in((unsigned)phoneno>0), %key_auto_phone%,
	                    keyed(left.phoneno[4..10] = right.p7) and
							 			  keyed(left.phoneno[1..3] = right.p3),
										  %get_ppl_fdids%(left, right), LIMIT(ut.limits.PHONE_PER_PERSON,SKIP));

#uniquename(get_by_fdid)
%prec% %get_by_fdid%(%f_ppl_fdids% l, %key_fdid% r) := transform
  self.seq := l.seq;
	self.acctno := l.acctno;
	self.glb_dppa_flag := IF (Phones.Functions.IsPhoneRestricted(r.origstate,
																															 glb_purpose,
																															 dppa_purpose,
																															 industry_class_value,
																															 ,
																															 r.datefirstseen,
																															 r.dt_nonglb_last_seen,
																															 r.rules,
																															 r.src_all,
																															 data_restriction_mask
																															), SKIP, r.glb_dppa_flag);
	self.listed_name := %makelistedname%(r.company, r.origname);
	self := r;
end;

#uniquename(f_by_fdid)
%f_by_fdid% := join(%f_ppl_fdids%, %key_fdid%,
                    keyed(left.fdid=right.fdid),
				            %get_by_fdid%(left, right), LIMIT(ut.limits.PHONE_PER_PERSON,SKIP));

#uniquename(f_by_fdid_post_filter)
Header.MAC_Filter_Sources(%f_by_fdid%,%f_by_fdid_post_filter%,src,data_restriction_mask);

#uniquename(cell_recs)
%cell_recs% := dedup(sort((%f_by_fdid_post_filter%), record), record)(confidencescore >= min_confidencescore);

#uniquename(get_cell_slim)
phonesplus_batch.layout_phonesplus_reverse_common %get_cell_slim%(%cell_recs% l) := transform

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
	self := l;
	self := [];
end;

#uniquename(cell_slim_recs)
%cell_slim_recs% := project(%cell_recs%, %get_cell_slim%(left));

f_out := %cell_slim_recs%;
endmacro;