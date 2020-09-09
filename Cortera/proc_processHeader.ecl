import ut, std;
EXPORT proc_processHeader(dataset(cortera.Layout_Header) hdr, string8 version) := FUNCTION

		Earlier(unsigned4 date1, unsigned4 date2) := 
			MAP(
				date1=0 => date2,
				date2=0 => date1,
				min(date1, date2)
			);

		ds := PROJECT(hdr, TRANSFORM(Cortera.Layout_Header_Out,
									self.processdate := STD.Date.Today( );
									self.version := version;
									self.current := true;
									//self.dt_first_seen := (unsigned4)left.LOC_DATE_LAST_SEEN;
									//self.dt_last_seen := (unsigned4)left.LOC_DATE_LAST_SEEN;
									self.dt_first_seen := Earlier((unsigned4)left.LOC_DATE_LAST_SEEN, left.FIRST_SEEN);
									self.dt_last_seen := (unsigned4)left.LOC_DATE_LAST_SEEN;
									self.dt_vendor_first_reported := (unsigned4)version;
									self.dt_vendor_last_reported := (unsigned4)version;
									self.persistent_record_id := (left.link_id << 32) + self.dt_vendor_first_reported;
									self.clean_phone := ut.CleanPhone(left.PHONE);
									self.clean_fax := ut.CleanPhone(left.FAX);
									//Commented out until Vern Bentley has completed using function
									// self.primary_sic := If(ut.fn_SicCode_functions.fn_validate_SicCode(left.primary_sic) = 1,ut.CleanSpacesAndUpper(left.primary_sic),'');
			            // self.primary_naics := If(ut.fn_NAICSCode_functions.fn_validate_NAICSCode(left.primary_naics) = 1,ut.CleanSpacesAndUpper(left.primary_naics),'');
									self := left;
									self := [];
									)
								);
		
		//This is being done in the above transform itself.
		//ds := Cortera.FixFirstSeen(ds1);
								
		//us := ds(country='US');
									
		clean := Cortera.proc_cleanAddresses(ds);
		
		linked := Cortera.proc_linkBiz(clean(country='US'));
		
		restored := linked + clean(country<>'US');		// get all records
		
		dated := cortera.proc_merge_hdr(restored, cortera.Files().Base.Header.qa, version);	// set dt_first_seen
		
		return dated;
END;
