cAll := PhonesInfo.File_Deact_Batch;

	cAll fixDt(cAll l):= transform
		self.vendor_first_reported_dt := if(l.source='PB', 0, l.vendor_first_reported_dt);
		self := l;
	end;

	ccAll := project(cAll, fixDt(left));

	rec := record
		ccAll.source;
		ccAll.vendor_first_reported_dt;
		count_ := count(group);
	end;

out	:= table(ccAll,
						 rec,
						 ccAll.source,
						 ccAll.vendor_first_reported_dt);
	
EXPORT runSourceBreakdown := output(out, all, named('sample_breakdown'));