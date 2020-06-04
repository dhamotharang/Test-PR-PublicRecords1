import _control, Mdr, STD;
		
				
EXPORT ProcessDailyFile(dataset(layout_gongMaster) mstr,	dataset(layout_Neustar) daily, string rundate) := FUNCTION

		mstr_base := DISTRIBUTE(mstr,hash(record_id));
																								
		dels := DISTRIBUTE(PreprocessDeletes(daily(action_code = 'D')),hash(record_id));
		adds := DISTRIBUTE(PreprocessAdds(daily(action_code in ['A','I']),rundate),hash(record_id));
		
		m1 := ApplyDelsToMaster(dels, mstr_base);
		m2 := ApplyAddsToMaster(adds, m1);

		m3 := IF(RelinkGong, proc_LinkUp(m2), m2);

		addGlobalSID := mdr.macGetGlobalSID(m3,'Gong','bell_id','global_sid');// DF-26340: Populate Global_SID
		
		return addGlobalSID;
END;