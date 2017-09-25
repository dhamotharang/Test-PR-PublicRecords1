﻿import ut, std;
EXPORT proc_processHeader(dataset(cortera.Layout_Header) hdr, string8 version) := FUNCTION



		ds := PROJECT(hdr, TRANSFORM(Cortera.Layout_Header_Out,
									self.processdate := STD.Date.Today( );
									self.version := version;
									self.current := true;
									self.dt_first_seen := (unsigned4)left.LOC_DATE_LAST_SEEN;
									self.dt_last_seen := (unsigned4)left.LOC_DATE_LAST_SEEN;
									self.dt_vendor_first_reported := (unsigned4)version;
									self.dt_vendor_last_reported := (unsigned4)version;
									self.clean_phone := ut.CleanPhone(left.PHONE);
									self.clean_fax := ut.CleanPhone(left.FAX);
									self := left;
									self := [];
									)
								);
								
		us := ds(country='US');
									
		clean := Cortera.proc_cleanAddresses(us);
		
		linked := Cortera.proc_linkBiz(clean);
		
		restored := linked + ds(country<>'US');		// get all records
		
		dated := cortera.proc_merge_hdr(restored, cortera.Files.Hdr_Out);	// set dt_first_seen
		
		return dated;
END;
