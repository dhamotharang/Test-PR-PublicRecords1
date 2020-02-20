export mac_get_qsent_by_phone(f_in, 
                              f_out,
														  min_confidencescore = 11,
															use_qsent_flag=false,
                              mod_access) := macro

import Data_Services, doxie, ut, doxie_files, autokey, cellphone, drivers, phonesplus, phonesplus_batch, Phones, MDR, Suppress;

#uniquename(key_fdid)
#uniquename(key_auto_phone)
%key_fdid% := Phonesplus.key_qsent_fdid;
%key_auto_phone% := autokey.Key_Phone(Data_Services.Data_location.Prefix('PhonesPlus')+
                                      'thor_data400::key::qsent_');

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
	self.glb_dppa_flag := r.glb_dppa_flag;
	self.listed_name := %makelistedname%(r.company, r.origname);
  self.global_sid     := r.global_sid;
  self.record_sid     := r.record_sid;
	self := r;
end;

#uniquename(f_by_fdid)
%f_by_fdid% := join(%f_ppl_fdids%, %key_fdid%,
                    keyed(left.fdid=right.fdid),
				            %get_by_fdid%(left, right), LIMIT(ut.limits.PHONE_PER_PERSON,SKIP)); 


#uniquename(f_by_fdid_suppressed)	
%f_by_fdid_suppressed% := Suppress.MAC_SuppressSource(%f_by_fdid%, mod_access); 
	       
#uniquename(cell_recs)				 				 
%cell_recs% := dedup(sort((%f_by_fdid_suppressed%), record), record)(confidencescore >= min_confidencescore);

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
	   self.vendor_dt_last_seen_used := l.datelastseen=0 and l.datevendorlastreported <>0;
	   self := l;
	   self := [];
end;

#uniquename(cell_slim_recs)
%cell_slim_recs% := project(%cell_recs%, %get_cell_slim%(left));

doxie.compliance.logSoldToSources(%f_by_fdid_suppressed%, mod_access);

f_out := if(~use_qsent_flag, dataset([], phonesplus_batch.layout_phonesplus_reverse_common),%cell_slim_recs%);

endmacro;