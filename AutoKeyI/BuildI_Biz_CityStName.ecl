import autokey,doxie,AutokeyB2,AutokeyB,RoxieKeyBuild;

export BuildI_Biz_CityStName :=
MODULE

	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared dsb2(params in_mod) :=
		FUNCTION	
			AutokeyB2.Layout_CityStName norm(in_mod.L_indata le, integer C) :=
			TRANSFORM
				SELF.cname_indic 	:= if(C=1,le.b.cname_indic,''); 
				SELF.cname_sec 		:= if(C=1,le.b.cname_sec,'');
				SELF 							:= le.b;
			END;
			
			p := Normalize(in_mod.L_indata(b.city_name <> ''),if('C' in in_mod.L_build_skip_set ,2,1), norm(LEFT,Counter));
			return p;
		END;
			
		shared dsb(params in_mod) :=
		FUNCTION	
			AutokeyB.Layout_CityStName proj(in_mod.L_indata le) :=
			TRANSFORM
				SELF 							:= le.b;
			END;
			
			p := PROJECT(in_mod.L_indata(b.city_name<>''), proj(LEFT));
			return p;
		END;
		
		
	//***** DEFINE THE INDEX		
		shared keyb(params in_mod) :=
		FUNCTION
			p := dsb(in_mod);
			recs := dedup( sort (p , record), record );
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'CityStNameB' + '_' + doxie.Version_SuperKey);
		END;
		
		shared keyb2(params in_mod) :=
		FUNCTION
			p := dsb2(in_mod);
			Autokey.Mac_deduprecs(p,in_mod.L_by_lookup,in_mod.L_Biz_favor_lookup,recs)
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'CityStNameB2' + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb2(in_mod), '',in_mod.L_inlogical+'CityStNameB2', do_Keyb2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb(in_mod),  '',in_mod.L_inlogical+'CityStNameB',  do_Keyb, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Biz_useAllLookups,
				do_Keyb2,
				do_Keyb
			);
		END;


	//***** INDEX MOVE CODE		
		export keymove(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'CityStNameB2',in_mod.L_inlogical+'CityStNameB2', mv_Keyb2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'CityStNameB', in_mod.L_inlogical+'CityStNameB',  mv_Keyb, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Biz_useAllLookups,
				mv_Keyb2,
				mv_Keyb
			);
		END;
		
		
	//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'CityStNameB2', 'Q', mv_Key2, ,in_mod.L_diffing);
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'CityStNameB', 'Q',  mv_Key, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Indv_useAllLookups,
				mv_Key2,
				mv_Key
			);
		END;
END;