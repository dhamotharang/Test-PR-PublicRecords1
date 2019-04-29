#option('MultiplePersistInstances', false);
root := '~thor::cortera::in::ar_full_20181108';
fr := dataset(root, cortera_tradeline.Layout_Tradeline, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							));

Cortera_Tradeline.Layout_Tradeline_Base xBase(Cortera_Tradeline.Layout_Tradeline tradelines, unsigned4 version, unsigned8 n) := TRANSFORM
		self.filedate := (unsigned4)version;
		self.process_date := (unsigned4)workunit[2..9];
		self.dt_first_seen := (unsigned4)tradelines.ar_date;
		self.dt_last_seen := (unsigned4)tradelines.ar_date;
		self.dt_vendor_first_reported := version;
		self.dt_vendor_last_reported := version;
		self.deletion_date := 0;
		self.source := MDR.sourceTools.src_Cortera_Tradeline;
		self.rid := n;
		self := tradelines;
END;

proc_create_initial(DATASET(Cortera_Tradeline.Layout_Tradeline) tradelines, 
												string8 dt) := FUNCTION
	
	adds := PROJECT(tradelines, xBase(LEFT, (unsigned4)dt, COUNTER));
	
	return adds;
END;
version := '20181108';
init := proc_create_initial(fr, version);
lfn := Cortera_Tradeline.Promote().sfBase+'::ar_full';
SEQUENTIAL(
	OUTPUT(init,,lfn, COMPRESSED, OVERWRITE),
	Cortera_Tradeline.Promote().PromoteBase(lfn)
);

