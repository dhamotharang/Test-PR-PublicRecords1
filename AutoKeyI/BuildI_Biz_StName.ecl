
import autokey,doxie,AutokeyB2,AutokeyB,RoxieKeyBuild;

export BuildI_Biz_StName :=
MODULE

	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION
			AutokeyB2.Layout_StName  proj(in_mod.L_indata le) :=
			TRANSFORM
				self 			:= le.b;
			END;
			p := PROJECT(in_mod.L_indata(b.st<>'',b.bname<>''), proj(LEFT));
			return p;
		END;


	//***** DEFINE THE INDEX		
		shared keyb(params in_mod) :=
		FUNCTION
			p := project(ds(in_mod), AutokeyB.Layout_StName);
			recs := dedup( sort (p, record), record );
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'StNameB' + '_' + doxie.Version_SuperKey);
		END;
		
		shared keyb2(params in_mod) :=
		FUNCTION
			p := ds(in_mod);
			Autokey.Mac_deduprecs(p,in_mod.L_by_lookup,in_mod.L_Biz_favor_lookup,recs)
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'StNameB2' + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			// lkey := key(in_mod);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb2(in_mod), '',in_mod.L_inlogical+'StNameB2', do_Keyb2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb(in_mod),  '',in_mod.L_inlogical+'StNameB',  do_Keyb, , in_mod.L_diffing);
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
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'StNameB2',in_mod.L_inlogical+'StNameB2', mv_Keyb2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'StNameB', in_mod.L_inlogical+'StNameB',  mv_Keyb, , in_mod.L_diffing);
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
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'StNameB2', 'Q', mv_Key2, ,in_mod.L_diffing);
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'StNameB', 'Q',  mv_Key, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Indv_useAllLookups,
				mv_Key2,
				mv_Key
			);
		END;
END;