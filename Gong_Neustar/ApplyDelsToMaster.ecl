
DelByRecordId(dataset(layout_gongMaster) dels, dataset(layout_gongMaster) mstr_base) := FUNCTION

	d := DISTRIBUTE(dels, hash(record_id));
	h := DISTRIBUTE(mstr_base, hash(record_id));
	
	deleted := JOIN(h, d, LEFT.record_id=RIGHT.record_id,
								TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.current_record_flag := '';
									self.deletion_date := RIGHT.deletion_date;
									self.filedate := RIGHT.filedate;
									self := LEFT;
								),
								INNER, LOCAL);
	notdeleted := JOIN(h, d, LEFT.record_id=RIGHT.record_id,
								TRANSFORM(Gong_Neustar.layout_gongMaster, self := LEFT;), LEFT ONLY, LOCAL);

	return deleted & notdeleted;

END;

EXPORT ApplyDelsToMaster(dataset(layout_gongMaster) dels, dataset(layout_gongMaster)mstr_base) := FUNCTION

	mstr_notcurr := mstr_base(current_record_flag<>'Y');
	mstr_curr := mstr_base(current_record_flag = 'Y');

	dmstr_byrecordid := DelByRecordId(dels, mstr_curr);

	return mstr_notcurr & dmstr_byrecordid;
END;
