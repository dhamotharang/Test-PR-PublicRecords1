IMPORT doxie, DIDVILLE;

EXPORT Log_Functions := MODULE

  EXPORT fn_getDidVille(dataset(Inquiry_Services.Log_layouts.in_layout_w_cleanAddr) ds_in,
											  doxie.IDataAccess mod_access, 
												string120 append_l,
												string120 verify_l = '') := function
			GLB := mod_access.isValidGlb();
			hhidplus := stringlib.stringfind(append_l,'HHID_PLUS',1)<>0;
      edabest := stringlib.stringfind(append_l,'BEST_EDA',1)<>0;

			DidVille.Layout_Did_OutBatch into(inquiry_services.Log_layouts.in_layout_w_cleanAddr l) := transform
				 self.seq := l.seq;
				 self.did := 0;
				 self.ssn := stringlib.stringfilter(l.input.ssn,'0123456789');
				 self.dob := l.input.dob;
				 self.phone10 := l.input.phone;
				 self.email := l.input.email;
				 self.title := '';
				 self.fname := l.input.firstname;
				 self.mname := '';
				 self.lname := l.input.lastname;
				 self.prim_range := l.cleanAddr.prim_range;
				 self.predir := l.cleanAddr.predir;
	       self.prim_name := l.cleanAddr.prim_name;
	       self.addr_suffix := l.cleanAddr.addr_suffix;
	       self.postdir := l.cleanAddr.postdir;
	       self.unit_desig := l.cleanAddr.unit_desig;
	       self.sec_range := l.cleanAddr.sec_range;
	       self.p_city_name := l.cleanAddr.p_city_name;
	       self.st := l.cleanAddr.st;
	       self.z5 := l.cleanAddr.zip;
	       self.zip4 := l.cleanAddr.zip4;
				 self := [];
			end;

			recs := project(ds_in,into(left));
			out_recs := didville.did_service_common_function(recs, hhidplus_value := hhidplus, 
			                                                       edabest_value := edabest, 
			                                                       verify_value := verify_l,
																														 appends_value := append_l, 
																														 glb_flag := GLB, 
																														 glb_purpose_value := mod_access.glb, 
																														 appType := mod_access.application_type,
																														 IndustryClass_val := mod_access.industry_class);

			return out_recs;
	end;
END; //module	
