IMPORT VersionControl, mdr;

Layout_Tradeline_Base xBase($.Layout_Tradeline tradelines, unsigned4 version) := TRANSFORM
		self.filedate := version;
		self.process_date := (unsigned4)workunit[2..9];
		self.dt_first_seen := (unsigned4)tradelines.ar_date;
		self.dt_last_seen := (unsigned4)tradelines.ar_date;
		self.dt_vendor_first_reported := version;
		self.dt_vendor_last_reported := version;
		self.deletion_date := 0;
		self.source := MDR.sourceTools.src_Cortera_Tradeline;
		self := tradelines;
		self := [];
END;

EXPORT prep_ingest := FUNCTION

	file_in := $.In_Tradeline;
	version := VersionControl.fGetFilenameVersion($.Promote().sfAdds);
	prepped := PROJECT(file_in, xBase(left, version));
	
	return prepped;

END;