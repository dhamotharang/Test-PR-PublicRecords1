/**
	process the Cortera tradeline incremental file
**/
import Std, mdr;
Layout_Tradeline_Base xBase($.Layout_Tradeline tradelines, unsigned4 version, unsigned8 n) := TRANSFORM
		self.feed_date := (unsigned4)REGEXFIND('(\\d{8})', tradelines.lfn, 1);
		self.process_date := version;
		self.dt_first_seen := (unsigned4)tradelines.ar_date;
		self.dt_last_seen := (unsigned4)tradelines.ar_date;
		self.dt_vendor_first_reported := version;
		self.dt_vendor_last_reported := version;
		self.deletion_date := 0;
		self.source := MDR.sourceTools.src_Cortera_Tradeline;
		self.rid := n;
		self := tradelines;
END;

EXPORT proc_add_records(DATASET($.Layout_Tradeline) tradelines = $.In_Tradeline, 
												DATASET($.Layout_Tradeline_Base) base = $.Files.Base,
												integer4 version = Std.Date.Today()) := FUNCTION
	
	unsigned8 seed := MAX(base, rid) + 1;
	adds := PROJECT(tradelines, xBase(LEFT, version, seed + COUNTER));
	
	return base + adds;
END;