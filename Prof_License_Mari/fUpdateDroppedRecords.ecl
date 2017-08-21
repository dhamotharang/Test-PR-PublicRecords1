EXPORT fUpdateDroppedRecords(int0) := functionmacro

// Update Status for Dropped Records
rLatestUpdate := record
STRING5		STD_SOURCE_UPD;
STRING		LAST_UPD_DTE;
end;

dsLatestUpdate := sort(distribute(dedup(project(int0, TRANSFORM(rLatestUpdate,self := left)),record,all), hash(std_source_upd)), std_source_upd, last_upd_dte,local);

rLatestUpdate  Xform(rLatestUpdate  L, rLatestUpdate  R) := TRANSFORM
SELF.LAST_UPD_DTE :=  if(l.last_upd_dte  > r.last_upd_dte, l.last_upd_dte, r.last_upd_dte);;
SELF := L; 
END;


file_rollup := ROLLUP(dsLatestUpdate,
													trim(LEFT.std_source_upd)= trim(RIGHT.std_source_upd),
													 Xform(LEFT, RIGHT));

dsLatestLookup := output(file_rollup,,'~thor_data400::out::proflic_mari::latest_upd_date',overwrite);

srt_file := sort(distribute(int0, hash(last_upd_dte)),last_upd_dte,local);

Prof_License_Mari.layouts.final JoinLatestUpdate(srt_file le, file_rollup ri) := transform
  SELF.STD_LICENSE_STATUS	:= if(le.last_upd_dte = ri.last_upd_dte,le.std_license_status,'999');
	self.STD_STATUS_DESC := if(le.last_upd_dte = ri.last_upd_dte, le.std_status_desc,'LICENSE WAS NOT REPORTED TO LEXISNEXIS BY A LICENSING AUTHORITY');
	self  := le;
END;
						
dsUpdateStatus		:=	join(srt_file, file_rollup,	
													LEFT.STD_SOURCE_UPD = RIGHT.STD_SOURCE_UPD,
													JoinLatestUpdate(LEFT,RIGHT), LEFT OUTER, LOOKUP);		


return dsUpdateStatus;

endmacro;	