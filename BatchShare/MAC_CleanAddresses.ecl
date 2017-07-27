// **************************************************
// Min input layout required:
// 	 BatchShare.Layouts.ShareAddress
// 	 BatchShare.Layouts.ShareErrors
// **************************************************

EXPORT MAC_CleanAddresses(inf, outf) := MACRO

	import Address;

	#uniquename(xfm_clean_address)
	recordof(inf) %xfm_clean_address%(recordof(inf) l) := transform
		// so far it seems that this is a necessary condition for cleaning address
		// (otherwise cleaner would just blank all the components)
		boolean is_cleanable := ((l.p_city_name !='') and (l.st != '')) or (l.z5 != '');
    
		addr_1			 			:= Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
                                                     l.addr_suffix, l.postdir, 
																									   '', l.sec_range);
		addr_2 				:= Address.Addr2FromComponents(l.p_city_name, l.st, l.z5);
		addr_line_1 	:= if (addr_1 = '', l.addr, addr_1);
		clean_addr 		:= address.GetCleanAddress(addr_line_1,addr_2,address.Components.country.US);
		ca						:= clean_addr.results;
		
		self.prim_range 	:= if (is_cleanable, ca.prim_range, l.prim_range);
		self.prim_name 		:= if (is_cleanable, ca.prim_name, l.prim_name);
		self.sec_range 		:= if (is_cleanable, ca.sec_range, l.sec_range);
		self.addr_suffix 	:= if (is_cleanable, ca.suffix, l.addr_suffix);
		self.predir 			:= if (is_cleanable, ca.predir, l.predir);
		self.postdir 			:= if (is_cleanable, ca.postdir, l.postdir);
		self.unit_desig 	:= if (is_cleanable, ca.unit_desig, l.unit_desig);
		self.p_city_name 	:= if (is_cleanable, ca.p_city, l.p_city_name);
		self.z5						:= if (is_cleanable, ca.zip, l.z5);
		self.st						:= if (is_cleanable, ca.state, l.st);
    self.err_addr     := if (is_cleanable, ca.error_msg, '');
		self							:= l
		
	end;
	
	outf :=  project(inf, %xfm_clean_address%(left));				

endmacro;	