import autokey,doxie,RoxieKeyBuild,ut,autokeyi,CanadianPhones;

export MAutokeyBuild := MODULE


	export Address :=
	MODULE


	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION
			CanadianPhones.layouts.address  proj(in_mod.L_indata le) :=
			TRANSFORM
				self.zip  := (string6)le.p.zip_string6;
				self 			:= le.p;
			END;
			pre_p := distribute(PROJECT(in_mod.L_indata, proj(LEFT)),hash(did));
			
			CanadianPhones.layouts.address  proj2(pre_p l, pre_p r) := 
			TRANSFORM
				self.lookups:= if(~(l.did=r.did and l.prim_name=r.prim_name and
				l.prim_range= r.prim_range and
				l.st=r.st and 
				l.city_code = r.city_code and
				l.zip =r.zip),r.lookups + ut.bit_set(0,in_mod.L_Rep_Addr),r.lookups);
				self := r;
			END;

			// set the representative address bit on the first record of a set of records with the same
			// address, making sure that this first record has the highest lookup value before the rep 
			// addr bit is set, so that when address only is searched the representative address record
			// is the one for which there are no other causes for exclusion

			p := iterate(sort(pre_p,did,
				-prim_name,-prim_range,
				-st,-city_code,-zip,-sec_range,-lname,-fname,
				-lookups,local),proj2(left,right),local);
							 

			Autokey.Mac_deduprecs(p(prim_name <> ''),in_mod.L_by_lookup,in_mod.L_Rep_Addr,deduped_p)

			// Within each did dedup records where there exists another record with all the same populated fields
			// but that has more fields populated. Prefer the favored lookup and from there the lookup bits in descending
			// order when deduping across different lookup values within a did

			recs := ungroup(dedup(
			sort(group(sort(deduped_p,did,if(ut.bit_test(lookups,in_mod.L_rep_addr),0,1),-lookups,local),did,
			if(in_mod.L_by_lookup=TRUE,lookups,did), local),
			-prim_name,-prim_range,-st,-sec_range,-dph_lname,-lname,-pfname,-fname),
			left.prim_name=right.prim_name and left.prim_range=right.prim_range and 
			(left.st=right.st or right.st='') and
			(left.city_code=right.city_code or right.city_code=0) and
			(left.sec_range=right.sec_range or right.sec_range='' ) and
			(left.dph_lname=right.dph_lname or right.dph_lname='') and
			(left.lname=right.lname or right.lname='' ) and
			(left.pfname=right.pfname  or right.pfname='') and
			(left.fname=right.fname or right.fname=''))); 
			
			return recs;
		END;


	//***** DEFINE THE INDEX		
		shared key(params in_mod) :=
		FUNCTION
			recs := ds(in_mod);
			return INDEX(recs, {recs}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key(in_mod),  '',in_mod.L_inlogical+'Address',  do_Key, , in_mod.L_diffing);
			return do_Key;
		END;


	//***** INDEX MOVE CODE		
		// export keymove(params in_mod) :=
		// FUNCTION
			// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'Address', in_mod.L_inlogical+'Address',  mv_Key, , in_mod.L_diffing);
			// return mv_Key;
		// END;
	END;
	
	
	
	
	Export Zip :=
	MODULE

	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION	
			CanadianPhones.layouts.zip proj(in_mod.L_indata le) :=
			TRANSFORM
				self.zip  				:= (string6)le.p.zip_string6;
				SELF 							:= le.p;
			END;
			
			p := distribute(PROJECT(in_mod.L_indata(p.zip_string6<>''), proj(LEFT)),hash(did));
			return p;
		END;
		
		
	//***** DEFINE THE INDEX				
		shared key(params in_mod) :=
		FUNCTION
			p := ds(in_mod);
			Autokey.Mac_deduprecs(p,in_mod.L_by_lookup,in_mod.L_Indv_favor_lookup,recs)
			return INDEX(recs, {recs}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key(in_mod), '',in_mod.L_inlogical+'Zip', do_Key, ,in_mod.L_diffing);
			return do_Key;
		END;


	//***** INDEX MOVE CODE		
		// export keymove(params in_mod) :=
		// FUNCTION
			// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'Zip',in_mod.L_inlogical+'Zip', mv_Key, ,in_mod.L_diffing);
			// return mv_Key;
		// END;
	END;
	
	
	
	Export ZipPRLName :=
	MODULE

	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION	
			// canadianphones.layouts.ZipPRLName proj(in_mod.L_indata le) :=
			// TRANSFORM
				// SELF 							:= le.p;
			// END;
			
			// p := distribute(PROJECT(in_mod.L_indata(p.zip > 0), proj(LEFT)),hash(did));
			canadianphones.layouts.ZipPRLName proj(in_mod.L_indata le, string thelname) :=
			TRANSFORM
				self.zip  				:= (string6)le.p.zip_string6;
				SELF.prim_range 	:= TRIM(ut.CleanPrimRange(le.p.prim_range),LEFT);
				SELF.lname 				:= trim(thelname,LEFT);
				SELF 							:= le.p;
			END;
			set_nulls := ['','0'];
			p := 
				distribute(
					PROJECT(in_mod.L_indata(inp.zip != '' and p.prim_range <> '' and (string)p.lname not in set_nulls), proj(LEFT,(string)LEFT.p.lname)) + 
					PROJECT(in_mod.L_indata(inp.zip != '' and p.prim_range <> '' and (string)b.bname not in set_nulls), proj(LEFT,(string)LEFT.b.bname)),
					hash(did)
				);
			return p;
		END;
		
		
	//***** DEFINE THE INDEX				
		shared key(params in_mod) :=
		FUNCTION
			p := ds(in_mod);
			Autokey.Mac_deduprecs(p,in_mod.L_by_lookup,in_mod.L_Indv_favor_lookup,recs)
			return INDEX(recs, {recs}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key(in_mod), '',in_mod.L_inlogical+'ZipPRLName', do_Key, ,in_mod.L_diffing);
			return do_Key;
		END;


	//***** INDEX MOVE CODE		
		// export keymove(params in_mod) :=
		// FUNCTION
			// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'ZipPRLName',in_mod.L_inlogical+'ZipPRLName', mv_Key, ,in_mod.L_diffing);
			// return mv_Key;
		// END;
	END;
	
	
	
	
	
	Export AddressB :=
	MODULE


	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION
			canadianPhones.layouts.addressb  proj(in_mod.L_indata le) :=
			TRANSFORM
				self.zip	:= le.b.zip_string6;
				self 			:= le.b;
			END;
			p := PROJECT(in_mod.L_indata(b.bname<>''), proj(LEFT));
			return p;
		END;


	//***** DEFINE THE INDEX		
		shared keyb2(params in_mod) :=
		FUNCTION
			p := ds(in_mod);
			Autokey.Mac_deduprecs(p(prim_name <> ''),in_mod.L_by_lookup,in_mod.L_Biz_favor_lookup,recs)
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'AddressB2' + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			// lkey := key(in_mod);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb2(in_mod), '',in_mod.L_inlogical+'AddressB2', do_Keyb2, ,in_mod.L_diffing);
			return do_Keyb2;
		END;


	//***** INDEX MOVE CODE		
		// export keymove(params in_mod) :=
		// FUNCTION
			// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'AddressB2',in_mod.L_inlogical+'AddressB2', mv_Keyb2, ,in_mod.L_diffing);
			// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'AddressB', in_mod.L_inlogical+'AddressB',  mv_Keyb, , in_mod.L_diffing);
			// return 
			// if(
				// in_mod.L_Biz_useAllLookups,
				// mv_Keyb2,
				// mv_Keyb
			// );
		// END;
	END;
	
	
	
	
	
	Export Zipb :=
	MODULE

	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared dsb2(params in_mod) :=
		FUNCTION
			canadianphones.layouts.zipb norm(in_mod.L_indata le, integer C) :=
			TRANSFORM
				self.zip					:= le.b.zip_string6;
				SELF.cname_indic 	:= if(C=1,le.b.cname_indic,''); 
				SELF.cname_sec 		:= if(C=1,le.b.cname_sec,'');
				SELF 							:= le.b;
			END;
			
			p := Normalize(in_mod.L_indata,if('C' in in_mod.L_build_skip_set ,2,1), norm(LEFT,Counter));
			return p;
		END;
		

	//***** DEFINE THE INDEX		
		shared keyb2(params in_mod) :=
		FUNCTION
			p := dsb2(in_mod);
			Autokey.Mac_deduprecs(p(zip <> ''),in_mod.L_by_lookup,in_mod.L_Biz_favor_lookup,recs)
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'ZipB2' + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			// lkey := key(in_mod);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb2(in_mod), '',in_mod.L_inlogical+'ZipB2', do_Keyb2, ,in_mod.L_diffing);
			return do_Keyb2;
		END;


	//***** INDEX MOVE CODE		
		// export keymove(params in_mod) :=
		// FUNCTION
			// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'ZipB2',in_mod.L_inlogical+'ZipB2', mv_Keyb2, ,in_mod.L_diffing);
			// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'ZipB', in_mod.L_inlogical+'ZipB',  mv_Keyb, , in_mod.L_diffing);
			// return 
			// if(
				// in_mod.L_Biz_useAllLookups,
				// mv_Keyb2,
				// mv_Keyb
			// );
		// END;
	END;
	
	
END;
