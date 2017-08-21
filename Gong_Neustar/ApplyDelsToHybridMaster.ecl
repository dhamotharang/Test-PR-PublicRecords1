
// delete nonresidential records if no phone number available
DelBizByName(dataset(layout_gongMaster) dels, dataset(layout_gongMaster) mstr_base) := FUNCTION

	d := DEDUP(SORT(DISTRIBUTE(dels, hash(company_name, st, v_city_name, prim_name, prim_range)),
							company_name, st, v_city_name, prim_name, prim_range, LOCAL),
							company_name, st, v_city_name, prim_name, prim_range, LOCAL);
	h := DISTRIBUTE(mstr_base, hash(company_name, st, v_city_name, prim_name));
	
	deleted := JOIN(h, d, LEFT.company_name=RIGHT.company_name
										AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,
								TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.current_record_flag := 'N';
									self.deletion_date := RIGHT.deletion_date;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.company_name=RIGHT.company_name
										AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,
								TRANSFORM(Gong_Neustar.layout_gongMaster, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

// delete residential records if no phone number available
DelResByName(dataset(layout_gongMaster) dels, dataset(layout_gongMaster) mstr_base) := FUNCTION

	d := DEDUP(SORT(DISTRIBUTE(dels, hash(name_last, name_first, name_middle, st, v_city_name, prim_name)),
							name_last, name_first, name_middle, st, v_city_name, prim_name, prim_range, LOCAL),
							name_last, name_first, name_middle, st, v_city_name, prim_name, prim_range, LOCAL);
	h := DISTRIBUTE(mstr_base, hash(name_last, name_first, name_middle, st, v_city_name, prim_name));
	
	deleted := JOIN(h, d, LEFT.name_last=RIGHT.name_last AND LEFT.name_first=RIGHT.name_first AND LEFT.name_middle=RIGHT.name_middle
										AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.prim_name = RIGHT.prim_name,
								TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.current_record_flag := 'N';
									self.deletion_date := RIGHT.deletion_date;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.name_last=RIGHT.name_last AND LEFT.name_first=RIGHT.name_first AND LEFT.name_middle=RIGHT.name_middle
										AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.prim_name = RIGHT.prim_name,
								TRANSFORM(Gong_Neustar.layout_gongMaster, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

DelByPhone(dataset(layout_gongMaster) dels, dataset(layout_gongMaster) mstr_base) := FUNCTION

	d := DEDUP(SORT(DISTRIBUTE(dels, hash(phone10)), phone10, LOCAL), phone10, LOCAL);
	h := DISTRIBUTE(mstr_base, hash(phone10));
	
	deleted := JOIN(h, d, LEFT.phone10=RIGHT.phone10,
								TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.current_record_flag := 'N';
									self.deletion_date := RIGHT.deletion_date;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.phone10=RIGHT.phone10,
								TRANSFORM(Gong_Neustar.layout_gongMaster, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

DelByRecordId(dataset(layout_gongMaster) dels, dataset(layout_gongMaster) mstr_base) := FUNCTION

	d := DISTRIBUTE(dels, hash(record_id));
	h := DISTRIBUTE(mstr_base, hash(record_id));
	
	deleted := JOIN(h, d, LEFT.record_id=RIGHT.record_id,
								TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.current_record_flag := 'N';
									self.deletion_date := RIGHT.deletion_date;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.record_id=RIGHT.record_id,
								TRANSFORM(Gong_Neustar.layout_gongMaster, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

EXPORT ApplyDelsToHybridMaster(dataset(layout_gongMaster) dels, dataset(layout_gongMaster)mstr_base) := FUNCTION

	mstr_notcurr := mstr_base(current_record_flag<>'Y');
	mstr_curr := mstr_base(current_record_flag = 'Y');

	mstr_neustar := mstr_curr(bell_id = 'NEU');
	mstr_lssi := mstr_curr(bell_id != 'NEU');

	dmstr_byrecordid := DelByRecordId(dels, mstr_neustar);
	dmstr_byphone := DelByPhone(dels(phone10 <> ''), mstr_lssi(phone10 <> ''));
  dmstr_ResNoPhone := DelResByName(dels(record_type='R',telephone=''), mstr_lssi(listing_type_res='R',phone10=''));
  dmstr_BizNoPhone := DelBizByName(dels(record_type <> 'R',telephone=''), mstr_lssi(listing_type_res='',phone10=''));

	return mstr_notcurr & dmstr_byrecordid & dmstr_byphone & dmstr_ResNoPhone & dmstr_BizNoPhone;

END;
