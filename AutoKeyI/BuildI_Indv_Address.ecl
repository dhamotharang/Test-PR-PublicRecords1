import autokey,doxie,RoxieKeyBuild,ut;

export BuildI_Indv_Address :=
MODULE


	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION
			Autokey.Layout_Address  proj(in_mod.L_indata le) :=
			TRANSFORM
				self.zip 	:= le.p.zip_string6;
				self 			:= le.p;
			END;
			pre_p := distribute(PROJECT(in_mod.L_indata, proj(LEFT)),hash(did));
			
			Autokey.Layout_Address  proj2(pre_p l, pre_p r) := 
			TRANSFORM
				self.lookups:= 
				if(
					~(
						l.did=r.did 
						and l.prim_name=r.prim_name 
						and l.prim_range= r.prim_range 
						and l.st=r.st 
						and l.city_code = r.city_code 
						and l.zip =r.zip
					) 
					and not in_mod.L_useLiteralLookupsValue
					,r.lookups + ut.bit_set(0,in_mod.L_Rep_Addr)
					,r.lookups
				);
				self := r;
			END;

			// set the representative address bit on the first record of a set of records with the same
			// address, making sure that this first record has the highest lookup value before the rep 
			// addr bit is set, so that when address only is searched the representative address record
			// is the one for which there are no other causes for exclusion

			p := iterate(sort(pre_p,did,
				-prim_name,-prim_range,
				-st,-city_code,-zip,-sec_range,-lname,-fname,-states,-lname1,-lname1,-lname3,
				-lookups,local),proj2(left,right),local);
							 

			Autokey.Mac_deduprecs(p(prim_name <> ''),in_mod.L_by_lookup,in_mod.L_Rep_Addr,deduped_p)

			// Within each did dedup records where there exists another record with all the same populated fields
			// but that has more fields populated. Prefer the favored lookup and from there the lookup bits in descending
			// order when deduping across different lookup values within a did

			recs := ungroup(dedup(
			sort(group(sort(deduped_p,did,if(ut.bit_test(lookups,in_mod.L_rep_addr),0,1),-lookups,local),did,
			if(in_mod.L_by_lookup=TRUE,lookups,did), local),
			-prim_name,-prim_range,-st,-sec_range,-dph_lname,-lname,-pfname,-fname,-states,-lname1,-lname2,-lname3),
			left.prim_name=right.prim_name and left.prim_range=right.prim_range and 
			(left.st=right.st or right.st='') and
			(left.city_code=right.city_code or right.city_code=0) and
			(left.sec_range=right.sec_range or right.sec_range='' ) and
			(left.dph_lname=right.dph_lname or right.dph_lname='') and
			(left.lname=right.lname or right.lname='' ) and
			(left.pfname=right.pfname  or right.pfname='') and
			(left.fname=right.fname or right.fname='') and
			(left.states=right.states or right.states=0) and
			(left.lname1 =right.lname1 or right.lname1=0) and
			(left.lname2 =right.lname2 or right.lname2=0) and
			(left.lname3 =right.lname3 or right.lname3=0))); 
			
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
		export keymove(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'Address', in_mod.L_inlogical+'Address',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
		
		
	//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'Address', 'Q',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
END;