EXPORT Map_Disconnect_Batch(string version1, string version2) := function

	sDate				:= (unsigned8)version1;
	eDate				:= (unsigned8)version2;

	dsiCon 			:= PhonesInfo.Key_Phones.Ported_Metadata(is_ported=TRUE and source='PK');
	dsRef				:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);
	dsDisc			:= PhonesInfo.Key_Phones.Ported_Metadata((is_deact='Y' and deact_code='DE') or (swap_start_dt<>0 and swap_end_dt=0));

	dsAll				:= dsDisc + dsiCon;
	
	concatAll 	:= if(eDate<>0,
										dsAll((source in ['PK'] and vendor_first_reported_dt between eDate and sDate) or (source in ['PX'] and vendor_first_reported_dt between eDate and sDate)),
										dsAll((source in ['PK'] and vendor_first_reported_dt = sDate) or (source in ['PX'] and vendor_first_reported_dt = sDate)));	

//Add Matching LIDB Info
	ds_lidb 		:= PhonesInfo.File_LIDB.Response_Processed;

	srt_lidb 		:= sort(distribute(ds_lidb, hash(phone)), phone, local); 
	srt_sample	:= sort(distribute(concatAll, hash(phone)), phone, local);

	PhonesInfo.Layout_Common.lidbRespProcess findLIDB(srt_lidb l, srt_sample r):= transform
		self := l;
	end;

	findLIDBRec := join(srt_lidb, srt_sample,
											left.phone = right.phone,
											findLIDB(left, right), local);

	ddLIDB			:= dedup(sort(distribute(findLIDBRec, hash(phone)), phone, -dt_last_reported, local), phone, local);

	keyLayout := record
		string10 phone;
		PhonesInfo.Layout_Common.portedMetadata_Main-phone;
		unsigned8 __internal_fpos__ := 0;
	end;

	keyLayout trLidb(ddLIDB l):= transform
		self.source 									:= 'PB';
		self.vendor_first_reported_dt	:= l.dt_first_reported;
		self.vendor_last_reported_dt	:= l.dt_last_reported;
		self.point_code								:= trim(l.point_code, left, right);
		self 													:= l;
	end;
	
	cmnLidb 		:= project(ddLIDB, trLidb(left));
	cAll 				:= concatAll + cmnLidb;

	return cAll;

end;