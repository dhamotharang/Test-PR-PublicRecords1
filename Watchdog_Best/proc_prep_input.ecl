import header,data_services,mdr,nid,address;


EXPORT proc_prep_input(DATASET(header.Layout_Header_v2) base) := FUNCTION

	cleaned := $.fn_CleanNames(base);

	h2 := $.Fn_Reset_Tnt(cleaned);
	h3 := $.fn_GetGongPhone(h2);

	h4 := PROJECT(h3, TRANSFORM($.Layout_Hdr,
				self.dt_first_seen := left.dt_first_seen;
				self.dt_last_seen := left.dt_last_seen;
				self.dt_vendor_first_reported := left.dt_vendor_first_reported;
				self.dt_vendor_last_reported := left.dt_vendor_last_reported;
				self.dt_nonglb_last_seen := left.dt_nonglb_last_seen;
				self := left));
	h := $.fn_get_best_address(h4);

	return h;
END;