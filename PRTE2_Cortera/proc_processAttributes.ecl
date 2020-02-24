import	std, ut;

EXPORT proc_processAttributes(dataset(Cortera.Layout_Header_Out) hdr, dataset(Cortera.Layout_Attributes) attr, string8 version) := FUNCTION

	Cortera.Layout_Attributes_Out xAttr(Cortera.Layout_Attributes attr, Cortera.Layout_Header_Out hdr) := TRANSFORM
			self.processDate := Std.Date.Today();
			self.dt_first_seen := hdr.dt_first_seen;
			self.dt_last_seen := hdr.dt_last_seen;
			self.dt_vendor_first_reported := (unsigned4)version;
			self.dt_vendor_last_reported := (unsigned4)version;
			self.current_rec := true;
			self := attr;
			self := hdr;
	END;

	j := JOIN(DISTRIBUTE(attr, ULTIMATE_LINKID), DISTRIBUTE(hdr(current), LINK_ID),
								left.ULTIMATE_LINKID=right.LINK_ID, xAttr(left,right), LEFT OUTER, LOCAL);
	
	// 
	result := Cortera.proc_merge_attr(j, Cortera.Files.Attributes, version);
								
	return result;

END;