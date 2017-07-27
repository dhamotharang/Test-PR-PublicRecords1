IMPORT AutoStandardI, ADDRESS, DIDVILLE, iesp;
EXPORT Log_Functions := MODULE

  EXPORT fn_getDidVille(dataset(Inquiry_Services.Log_layouts.in_layout_w_cleanAddr) ds_in, 
												unsigned1 glb_purpose_value,
												unsigned1 dppa_purpose_value,
												string120 append_l,
												string32 appType,
												string5 IndustryClass,
												string120 verify_l = '') := function
			p := module(AutoStandardI.PermissionI_Tools.params)
				export boolean AllowAll := false;
				export boolean AllowGLB := false;
				export boolean AllowDPPA := false;
				export unsigned1 DPPAPurpose := dppa_purpose_value;
				export unsigned1 GLBPurpose := glb_purpose_value;
				export boolean IncludeMinors := false;
			END;
			GLB := AutoStandardI.PermissionI_Tools.val(p).glb.ok(glb_purpose_value);
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
																														 glb_purpose_value := glb_purpose_value, 
																														 appType := appType,
																														 IndustryClass_val := IndustryClass);

			return out_recs;
	end;
END; //module	