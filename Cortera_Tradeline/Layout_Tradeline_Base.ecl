﻿IMPORT BIPV2, dx_common, MDR;
EXPORT Layout_Tradeline_Base := RECORD
	$.Layout_Tradeline;
	string2		source := MDR.sourceTools.src_Cortera_Tradeline;
	string1		status := '';		// blank=current, D=Deleted by vendor, R=Replaced by newer version
	unsigned4	filedate;				// file date from vendor
	unsigned4	process_date;		// build date	
	unsigned4	dt_first_seen;
	unsigned4	dt_last_seen;
	unsigned4	dt_vendor_first_reported;
	unsigned4	dt_vendor_last_reported;
	unsigned4	deletion_date;	// date the record was deleted

	unsigned6		bdid := 0;
	unsigned1		bdid_score := 0;
	BIPV2.IDlayouts.l_xlink_ids;	
	dx_common.layout_metadata; // Added for Delta build process. CCPA fields are also part of this.
END;

