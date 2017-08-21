
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

EXPORT ApplyDelsToHistory(dataset(layout_gongMaster) dels, dataset(layout_history) history_base) := FUNCTION

	history_notcurr := history_base(current_record_flag<>'Y');
	history_curr := history_base(current_record_flag = 'Y');

	history_neustar := history_curr(bell_id = 'NEU');

	dhistory_byrecordid := DelByRecordId(dels, history_neustar);

	return history_notcurr & dhistory_byrecordid;

END;
