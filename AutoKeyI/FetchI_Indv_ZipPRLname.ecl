import AutoStandardI,ut,doxie,autokey;
export FetchI_Indv_ZipPRLname := module
	export old := module
		export params := module
			export base := interface
				export string lname_value;
				export string fname_value;
				export string prange_value;
				export string pname_value;
				export set of integer4 zip_value;
				export unsigned4 lookup_value;
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean noFail := true;
			end;
		end;
		export do(params.full in_mod) := function
			i := autokey.Key_ZipPRLName(in_mod.autokey_keyname_root);
			
			AutoKey.layout_fetch xt(i r) := TRANSFORM
				SELF := r;
			END;
			
			lname_len := LENGTH(TRIM(in_mod.lname_value));
			
			boolean HasZip					:= in_mod.zip_value<>[]; 			//first keyed value
			boolean HasPR						:= in_mod.prange_Value <> ''; //second keyed value
			boolean HasNoPN 				:= in_mod.pname_value=''; 		//without a pname, you really need this search
			
			boolean HasEnoughLname 	:= lname_len >= 2;						//third keyed condition
			boolean HasNoFname			:= in_mod.fname_value = '';		//if you do have fname, another search will find you

			//previous version behavior was "HasZip AND HasPR AND HasNoPN"
			// - so, the idea was that you need this search when you dont have any street info
			// - now, we realize that we often get partial street info and partial last name.  so, in that case you need this search too.
			// - if fname is present, we'll asssume for now that another search will be able to find you.  and partial lname usually comes in with no fname.
			f_raw := i(HasZip AND HasPR AND (HasNoPN or (HasEnoughLname and HasNoFname)), 
						keyed(zip IN in_mod.zip_value), 
						keyed(prim_Range = in_mod.prange_Value), 
						keyed(lname[1..lname_len] = in_mod.lname_value),
						ut.bit_test(lookups, in_mod.lookup_value));

			f := project(f_raw, xt(LEFT));
			
			noFail := in_mod.noFail;
					
			AutoKey.mac_Limits(f,f_ret)	
			
			RETURN f_ret;
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.lname_value.params,
				AutoStandardI.InterfaceTranslator.fname_value.params,
				AutoStandardI.InterfaceTranslator.prange_value.params,
				AutoStandardI.InterfaceTranslator.pname_value.params,
				AutoStandardI.InterfaceTranslator.zip_value.params,
				AutoStandardI.InterfaceTranslator.lookup_value.params)
			end;
			export full := interface(base)
				export string autokey_keyname_root;
				export boolean noFail := true;
			end;
		end;
		export do(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean noFail := in_mod.noFail;
				export string lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
				export string fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
				export string prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
				export string pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
			end;
			return old.do(tempmod);
		end;
	end;
end;
