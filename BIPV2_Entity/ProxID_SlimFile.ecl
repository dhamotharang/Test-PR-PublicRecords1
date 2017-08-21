import BIPV2_Files, BIPV2_PROX_SALT_int_fullfile, business_dot;

EXPORT ProxID_SlimFile := module

	// export ProxIDFile	:= BIPV2_Files.files_proxid().DS_PROXID_BASE; // micro dataset
	
	export full19 		:= BIPV2_PROX_SALT_int_fullfile.Files().base.qa;	// full file
	export ProxIDFile := full19;
	
	
	Layouts.slimRec_layout xform(ProxIDFile L) := transform
		self.contact_name 		:= trim(l.fname) + ' ' + trim(l.mname) + ' ' + trim(l.lname);
		self.company_address 	:= trim(l.prim_range) + ' ' + trim(l.prim_name) + ' ' + trim(l.addr_suffix) + ', ' + trim(l.sec_range) + ', ' +
															 trim(l.v_city_name) + ' ' + trim(l.st) + ' ' + trim(l.zip);
		self := l;
		self := [];
	end;
	
	export result := project(ProxIDFile, xform(left));
	
end;