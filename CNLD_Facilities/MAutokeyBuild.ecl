import autokey,doxie,RoxieKeyBuild,ut,autokeyi,CanadianPhones;

export MAutokeyBuild := MODULE


	export ZipSecRange :=
	MODULE


	//***** DEFINE THE INTERFACE
		export params := autokeyi.InterfaceForBuild;

		export layout := record
		  string6 zip;
			string8 sec_range;
			unsigned4 lookups;
			unsigned6 did;
		end;

	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
	
			recs := 
			project(
				in_mod.L_indata(p.zip>0), 
				transform(
					layout,
					self.zip := (string6)left.p.zip_string6,
					self := left.p
				)
			);
			key := INDEX(recs, {recs}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key,  '',in_mod.L_inlogical+'ZipSecRange',  do_Key, , in_mod.L_diffing);
			return do_Key;
		END;


	//***** INDEX MOVE CODE		
		export keymove(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'ZipSecRange', in_mod.L_inlogical+'ZipSecRange',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
	
	
	//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'ZipSecRange', 'Q',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
		
	END; //ZipSecRange
	
	
	
	export LatLong :=
	MODULE


	//***** DEFINE THE INTERFACE
		export params := autokeyi.InterfaceForBuild;

		export layout := record
		  integer3 lat;
			integer3 long;
			unsigned4 lookups;
			unsigned6 did;
		end;

	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
	
			recs := 
			project(
				in_mod.L_indata(lat <> 0 and long <> 0), 
				transform(
					layout,
					self.lat := (integer3)left.lat,  //cant have a keyed field of type REAL...who knew?!
					self.long := (integer3)left.long,
					self := left.p
				)
			);
			key := INDEX(recs, {recs}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key,  '',in_mod.L_inlogical+'LatLong',  do_Key, , in_mod.L_diffing);
			return do_Key;
		END;


	//***** INDEX MOVE CODE		
		export keymove(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'LatLong', in_mod.L_inlogical+'LatLong',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
	
	
	//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'LatLong', 'Q',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
		
	END; //LatLong	
	
	

END;	//MAutokeyBuild
	