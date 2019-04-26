import codes, MDR;

export PermissionI_Tools := module
	export RNA_GLB_Set := [0, 1, 3, 12];  
	export RNA_DPPA_Set := [0, 2, 3, 5, 7];
	export params := interface
		export boolean AllowAll;
		export boolean AllowGLB;
		export boolean AllowDPPA;
		export unsigned1 DPPAPurpose;
		export unsigned1 GLBPurpose;
		export boolean IncludeMinors;
		export boolean restrictPreGLB := false;
	end;
	export val(params in_mod) := module
		//***************
		//	COMMON USE
		//***************
		shared minVal   			:= 1;
		shared maxVal 				:= 7;
		shared allow 					:= 255;
		
		export Boolean AllowAll_value := in_mod.AllowAll;		
		shared Boolean AllowGLB := in_mod.AllowGLB;
		shared Boolean AllowGLB_value := AllowGLB or AllowAll_value;
		shared Boolean AllowDPPA := in_mod.AllowDPPA;
		shared Boolean AllowDPPA_value := AllowDPPA or AllowAll_value;
	  shared boolean restrictPreGLB := in_mod.restrictPreGLB;
			
		//***************
		//	DPPA
		//***************
		export DPPA := module
			export default 				:= 0;
			
			shared unsigned1 stored_pre 			  := in_mod.DPPAPurpose;
			export unsigned1 stored_value 			:= if(AllowDPPA_value, allow, stored_pre);
			
			shared setOtherValids := [allow];
			export ok(unsigned1 purpose) := (purpose >= minVal and purpose <= maxVal) or 
																			purpose in setOtherValids;
			export restrictRNA(unsigned1 purpose=stored_pre) := purpose in RNA_DPPA_Set;
			export state_ok(string2 st, unsigned1 d, string2 header_source='', string2 source_code='') := function
				isExperian	:= (MDR.sourceTools.SourceIsExperianVehicle(header_source) OR // old *E, but not DE or FE
				                MDR.sourceTools.SourceIsExperianVehicle(source_code) OR // old AE
												MDR.sourceTools.SourceIsExperianDL(source_code));  // old AX
				
				strfn				:= IF(isExperian,'EXPERIAN-DL-PURPOSE','DL-PURPOSE');

				valid_state_dppa := ~EXISTS(codes.Key_Codes_V3(keyed(file_name='GENERAL'),keyed(field_name=strfn),keyed(field_name2=st),keyed(code=(STRING1)d)));

				//((userPermission = constantAllowValue) OR (restrictionNotFound and userPermissionIsValid))
				return d = allow or (valid_state_dppa and ok(d));
			end;
		
		end;

		//***************
		//	GLB
		//***************
		export GLB := module
			export default 				:= 8;
			
			shared unsigned1 stored_pre 				:= in_mod.GLBPurpose;
			export unsigned1 stored_value 			:= if(AllowGLB_value, allow, stored_pre); 
			
			shared setOtherValids := [11,12,allow];
			export ok(unsigned1 purpose) := (purpose >= minVal and purpose <= maxVal) or purpose in setOtherValids;
			export restrictRNA( unsigned1 purpose=stored_pre ) := purpose in RNA_GLB_Set;		
			shared dateEffective := 200106;					
			shared dateOK(unsigned3 nonglb_last_seen, unsigned3 first_seen) :=(nonglb_last_seen <> 0 or (first_seen <= dateEffective and first_seen > 0)) and ~restrictPreGLB; 
			export SrcNeverRestricted(string2 src) := src not in mdr.sourcetools.set_GLB;
			shared SrcAlwaysRestricted(string2 src) := src in mdr.sourcetools.set_AlwaysGLB;
			export HeaderIsPreGLB(unsigned3 nonglb_last_seen, unsigned3 first_seen, string2 src) := 
			map(
				SrcAlwaysRestricted(src)
					=> false,
				SrcNeverRestricted(src)
					=> true,				
				dateOK(nonglb_last_seen, first_seen)
			);
						
			shared boolean IncludeMinors_value  := in_mod.IncludeMinors;
			export boolean OKtoShowMinors := stored_pre=2 or IncludeMinors_value;
			
			export boolean SrcOk(unsigned1 purpose, string2 src, unsigned3 first_seen = 0, unsigned3 nonglb_last_seen = 0) := 
				ok(purpose) or HeaderIsPreGLB(nonglb_last_seen, first_seen, src);
			
			export boolean minorOK(unsigned1 age) := 
				(age=0 or age>=18 or OKtoShowMinors); // Some minor data is LE-only
			
			export mac_FilterOutMinors(inrec, outrec, didfield = 'did', the_macro_module = 'AutoStandardI.GlobalModule()',
																 dobfield = '?') :=
			MACRO //because i want to use on datasets of various layouts
			import dx_Header,AutoStandardI,ut;
			
				#uniquename(j0)
				// need to check for minors on zero DIDs that have a valid DOB.
				// if input layout to the macro doesn't contain a DOB field, just let the 
				// zero DIDs pass through
				#IF (#TEXT(dobfield) <> '?')
				%j0% := inrec((unsigned6)didfield = 0 and ((unsigned8)dobfield = 0 or ut.age((unsigned4) dobfield) >= 18));
				#ELSE
				%j0% := inrec((unsigned6)didfield = 0);
				#END
				
				#uniquename(j)
				%j% := 
					join(
						inrec((unsigned6)didfield > 0),
						dx_Header.key_minors_hash(),
						keyed(hash32((unsigned6)left.didfield)=right.hash32_did) and
						keyed((unsigned6)left.didfield = right.did) and	//at build time, key contains only minors
						ut.age(right.dob) < 18,						//check age since a few will turn 18 between builds
						transform(
							recordof(inrec),
							self := left
						),
						left only
					);
				
				outrec := 
					if(
						AutoStandardI.PermissionI_Tools.val(project(the_macro_module,AutoStandardI.PermissionI_Tools.params)).GLB.OKtoShowMinors,
						inrec,
						%j% + %j0%
					);
			
			ENDMACRO;
		end;
	end;
end;