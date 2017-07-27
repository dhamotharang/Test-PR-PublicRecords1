import execathomev2, doxie;

main_rec := execathomev2.layout_eah_person_best;

export get_eah_bestinfo (grouped dataset(main_rec) file_best_ready, 
                         boolean glb, boolean dppa, boolean market_rstr) := function


	best_ready := ungroup (file_best_ready);

	dids := project(best_ready, doxie.layout_references);
	doxie.mac_best_records(dids, did, best_recs, dppa, glb, , doxie.DataRestriction.fixed_DRM, market_rstr);	

	main_rec get_bestinfo(main_rec l, best_recs r) := transform
	   boolean takephone := l.person_best_phone='' and r.phone != '';
		self.person_best_phone := if(takephone, r.phone, l.person_best_phone);
		
		//self.person_best_title := r.title;
		self.person_best_fname := r.fname;
		self.person_best_mname := r.mname;
		self.person_best_lname := r.lname;
		self.person_best_name_suffix := r.name_suffix;
		
		self.person_prim_range := r.prim_range;
		self.person_predir := r.predir;
		self.person_prim_name := r.prim_name;
		self.person_suffix := r.suffix;
		self.person_postdir := r.postdir;
		self.person_unit_desig := r.unit_desig;
		self.person_sec_range := r.sec_range;
		self.person_best_city := r.city_name;
		self.person_best_state := r.st;
		self.person_best_zip := r.zip;
		self.person_best_zip4 := r.zip4;
		self.person_addr_dt_last_seen := (string6)r.addr_dt_last_seen;
		self := l;
	end;
	file_with_personbest := join(best_ready, best_recs,
															 left.did = right.did,
															 get_bestinfo(left, right), KEEP(1));
														 					
  return group(sort(file_with_personbest,seq), seq);
  
END;

