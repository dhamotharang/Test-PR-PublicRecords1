import official_records,iesp;
	
export Layouts := MODULE

	export search := record
		string60 official_record_key;
	end;

	export raw_rec := record
	  recordof(official_records.Key_Party_ORID);
	end;

	export t_OfficialRecRecordWithPenalty := record
		iesp.officialrecord.t_OfficialRecRecord;
	end;

end;
