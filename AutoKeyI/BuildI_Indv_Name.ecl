
import autokey,doxie,AutokeyB2,AutokeyB,RoxieKeyBuild;

export BuildI_Indv_Name :=
MODULE


	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION
			// Autokey.Layout_Name2  proj(in_mod.L_indata le) :=
			Autokey.Layout_Name  proj(in_mod.L_indata le) :=
			TRANSFORM
				self 			:= le.p;
			END;
			p := PROJECT(in_mod.L_indata(p.lname <> ''), proj(LEFT));
			return p;
		END;
		

	//***** DEFINE THE INDEX		
		shared key(params in_mod) :=
		FUNCTION
			p := ds(in_mod);
			recs := dedup( sort (p(p.lname<>'') , record), record );
			return INDEX(recs, {recs}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key(in_mod),  '',in_mod.L_inlogical+'Name', do_Key,  ,in_mod.L_diffing);
			return do_Key;
		END;


	//***** INDEX MOVE CODE		
		export keymove(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'Name',in_mod.L_inlogical+'Name', mv_Key, ,in_mod.L_diffing);
			return mv_Key;
		END;
		
		
	//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'Name', 'Q',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
END;



