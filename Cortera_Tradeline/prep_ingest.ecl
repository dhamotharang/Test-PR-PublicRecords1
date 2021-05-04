IMPORT VersionControl, mdr;

Layout_Tradeline_Base xBase($.Layout_Tradeline tradelines, string8 version, boolean IsDelata) := TRANSFORM
		self.filedate := (unsigned4)version;
		self.process_date := (unsigned4)workunit[2..9];
		self.dt_first_seen := (unsigned4)tradelines.ar_date;
		self.dt_last_seen := (unsigned4)tradelines.ar_date;
		self.dt_vendor_first_reported := (unsigned4)version;
		self.dt_vendor_last_reported := (unsigned4)version;
		self.deletion_date := 0;
		self.source := MDR.sourceTools.src_Cortera_Tradeline;
		self.dt_effective_first := (unsigned4)version;
		self.delta_ind := if(IsDelata, 1, 0);
		self := tradelines;
		self := [];
END;

EXPORT prep_ingest(string8 																		 pversion, 
									 dataset(Cortera_Tradeline.Layout_Tradeline) AddsSprayedFile = $.Files().Input.Tradeline_Adds.Using,
									 boolean																		 pDeltaRun
	) := FUNCTION

	file_in := AddsSprayedFile;
	prepped := PROJECT(file_in, xBase(left, pversion, pDeltaRun));
	
	return prepped;

END;