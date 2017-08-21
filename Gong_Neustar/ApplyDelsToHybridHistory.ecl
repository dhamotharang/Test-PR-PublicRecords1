
// delete nonresidential records if no phone number available
DelBizByName(dataset(layout_gongMaster) dels, dataset(layout_history) history_base) := FUNCTION

	d := DEDUP(SORT(DISTRIBUTE(dels, hash(company_name, st, v_city_name, prim_name, prim_range)),
							company_name, st, v_city_name, prim_name, prim_range, LOCAL),
							company_name, st, v_city_name, prim_name, prim_range, LOCAL);
	h := DISTRIBUTE(history_base, hash(listed_name, st, v_city_name, prim_name));
	
	deleted := JOIN(h, d, LEFT.listed_name=RIGHT.company_name
										AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,
								TRANSFORM(Gong_Neustar.Layout_History,
									self.current_record_flag := 'N';
									self.deletion_date := RIGHT.deletion_date;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.listed_name=RIGHT.company_name
										AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,
								TRANSFORM(Gong_Neustar.Layout_History, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

// delete residential records if no phone number available
DelResByName(dataset(layout_gongMaster) dels, dataset(layout_history) history_base) := FUNCTION

	d := DEDUP(SORT(DISTRIBUTE(dels, hash(name_last, name_first, name_middle, st, v_city_name, prim_name)),
							name_last, name_first, name_middle, st, v_city_name, prim_name, prim_range, LOCAL),
							name_last, name_first, name_middle, st, v_city_name, prim_name, prim_range, LOCAL);
	h := DISTRIBUTE(history_base, hash(name_last, name_first, name_middle, st, v_city_name, prim_name));
	
	deleted := JOIN(h, d, LEFT.name_last=RIGHT.name_last AND LEFT.name_first=RIGHT.name_first AND LEFT.name_middle=RIGHT.name_middle
										AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.prim_name = RIGHT.prim_name,
								TRANSFORM(Gong_Neustar.Layout_History,
									self.current_record_flag := 'N';
									self.deletion_date := RIGHT.deletion_date;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.name_last=RIGHT.name_last AND LEFT.name_first=RIGHT.name_first AND LEFT.name_middle=RIGHT.name_middle
										AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.prim_name = RIGHT.prim_name,
								TRANSFORM(Gong_Neustar.Layout_History, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

DelByPhone(dataset(layout_gongMaster) dels, dataset(layout_history) history_base) := FUNCTION

	d := DEDUP(SORT(DISTRIBUTE(dels, hash(phone10)), phone10, LOCAL), phone10, LOCAL);
	h := DISTRIBUTE(history_base, hash(phone10));
	
	deleted := JOIN(h, d, LEFT.phone10=RIGHT.phone10,
								TRANSFORM(Gong_Neustar.Layout_History,
									self.current_record_flag := 'N';
									self.deletion_date := RIGHT.deletion_date;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.phone10=RIGHT.phone10,
								TRANSFORM(Gong_Neustar.Layout_History, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

DelByRecordId(dataset(layout_gongMaster) dels, dataset(layout_history) history_base) := FUNCTION

	d := DISTRIBUTE(dels, hash(record_id));
	h := DISTRIBUTE(history_base, hash(pclean));
	
	deleted := JOIN(h, d, LEFT.pclean=RIGHT.record_id,
								TRANSFORM(Gong_Neustar.Layout_History,
									self.current_record_flag := 'N';
									self.deletion_date := RIGHT.deletion_date;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.pclean=RIGHT.record_id,
								TRANSFORM(Gong_Neustar.Layout_History, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

EXPORT ApplyDelsToHybridHistory(dataset(layout_gongMaster) dels, dataset(layout_history) history_base) := FUNCTION

	history_notcurr := history_base(current_record_flag<>'Y');
	history_curr := history_base(current_record_flag = 'Y');

	history_neustar := history_curr(bell_id = 'NEU');
	history_lssi := history_curr(bell_id != 'NEU');

	dhistory_byrecordid := DelByRecordId(dels, history_neustar);
	dhistory_byphone := DelByPhone(dels(phone10 <> ''), history_lssi(phone10 <> ''));
  dhistory_ResNoPhone := DelResByName(dels(record_type='R',telephone=''), history_lssi(listing_type_res='R',phone10=''));
  dhistory_BizNoPhone := DelBizByName(dels(record_type <> 'R',telephone=''), history_lssi(listing_type_res='',phone10=''));

	return history_notcurr & dhistory_byrecordid & dhistory_byphone & dhistory_ResNoPhone & dhistory_BizNoPhone;

END;