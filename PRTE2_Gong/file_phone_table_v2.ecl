import std,ut;

////////////phone_table_v2//////////////////////////////////////////////////////
	EXPORT file_phone_table_v2(Boolean isFCRA = false,boolean gongFilter = false) := FUNCTION
		goodphone(string10 s) := (INTEGER)s<>0 AND LENGTH(Stringlib.stringfilter(s,'0123456789'))=10;
		Layouts.phone_table_rec slimg(Files.File_History_Full_Prepped_for_Keys le) := TRANSFORM
			SELF.dt_first_seen := (unsigned3)(le.dt_first_seen[1..6]);
			SELF.isCurrent := le.current_record_flag='Y';
			SELF.potDisconnect := ~SELF.isCurrent;
			SELF.zip5 := le.z5;
			SELF.zip4 := le.z4;
			SELF.lname := le.name_last;
			SELF.city := le.v_city_name;
			self.state := le.st;
			self.isacompany := if(le.bdid = 0, false, true);
			SELF := le;
			self := [];
		END;

		sysdate := ((STRING8)Std.Date.Today())[1..6] + '31';
		good_phns := IF(gongFilter,
						Files.File_History_Full_Prepped_for_Keys(goodphone(phone10),bell_id in Constants.allowedBellIdForFCRA),
						Files.File_History_Full_Prepped_for_Keys(goodphone(phone10)));
		gg := project(good_phns, slimg(LEFT));
		all_phones := DEDUP(SORT(gg,RECORD),RECORD);
		did_slim := RECORD
			good_phns.phone10;	
			good_phns.did;
			dt_first_seen := MIN(GROUP,IF(good_phns.dt_first_seen='0',999999,(unsigned3)good_phns.dt_first_seen[1..6]));
			dt_last_seen := MAX(GROUP,(unsigned3)good_phns.dt_last_seen[1..6]);
		END;
		good_phns_distr := good_phns(current_record_flag='Y' or ut.DaysApart(sysdate, dt_first_seen[1..6]+'31') < 365);
		d_did := TABLE(good_phns_distr(did<>0), did_slim, phone10, did);
		did_stats := record
			d_did.phone10;
			did_ct := count(group);
			did_ct_c6 := count(group, ut.DaysApart(sysdate, ((string)d_did.dt_first_seen)[1..6]+'31') < 183);
		end;
		did_counts := table(d_did, did_stats, phone10);
		with_did_counts := join(all_phones, did_counts, left.phone10 = right.phone10,
						transform(Layouts.phone_table_rec, self.did_ct := right.did_ct, self.did_ct_c6 := right.did_ct_c6, self := left), 
						left outer, keep(1));
		Layouts.phone_table_rec roller(Layouts.phone_table_rec le, Layouts.phone_table_rec ri) := TRANSFORM
			SELF.isaCompany := le.isaCompany OR ri.isaCompany;
			SELF.company_type := IF(le.company_type_A, ri.company_type, le.company_type);
			SELF.company_type_A := le.company_type_A AND ri.company_type_A;
			SELF.isCurrent := le.isCurrent OR ri.isCurrent;
			SELF.nxx_type := IF(le.company_type_A, ri.nxx_type, le.nxx_type);
			SELF := IF(le.isCurrent, le, ri);
		END;
		s_phone_table := GROUP(SORT(with_did_counts,phone10,lname,zip5,prim_name,prim_range,city,state,sic_code,-isCurrent),phone10);
		phone_table_outf := ROLLUP(s_phone_table,roller(LEFT,RIGHT),phone10,lname,zip5,prim_name,prim_range,city,state,sic_code);
		Layouts.phone_table_rec iterator2(Layouts.phone_table_rec le, Layouts.phone_table_rec ri) := TRANSFORM
			SELF.potDisconnect := ~(le.isCurrent OR ri.isCurrent);
			SELF := ri;
		END;
		DS_phone_table_v2 := ITERATE (phone_table_outf, iterator2(LEFT,RIGHT));
	 
	  return  DS_phone_table_v2;
	end;