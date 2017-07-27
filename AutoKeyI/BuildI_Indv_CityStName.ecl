import autokey,doxie,RoxieKeyBuild;

export BuildI_Indv_CityStName :=
MODULE

	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION	
			Autokey.Layout_CityStName proj(in_mod.L_indata le) :=
			TRANSFORM
				SELF 							:= le.p;
			END;
			
			p := distribute(PROJECT(in_mod.L_indata(p.city_name<>''), proj(LEFT)),hash(did));
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
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key(in_mod), '',in_mod.L_inlogical+'CityStName', do_Key, ,in_mod.L_diffing);
			return do_Key;
		END;


	//***** INDEX MOVE CODE		
		export keymove(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'CityStName',in_mod.L_inlogical+'CityStName', mv_Key, ,in_mod.L_diffing);
			return mv_Key;
		END;
		
		
	//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'CityStName', 'Q',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
END;