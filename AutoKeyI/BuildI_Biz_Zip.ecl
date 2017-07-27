import autokey,doxie,AutokeyB2,AutokeyB,RoxieKeyBuild;

export BuildI_Biz_Zip :=
MODULE

	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared dsb2(params in_mod) :=
		FUNCTION
			AutokeyB2.Layout_Zip norm(in_mod.L_indata le, integer C) :=
			TRANSFORM
				SELF.cname_indic 	:= if(C=1,le.b.cname_indic,''); 
				SELF.cname_sec 		:= if(C=1,le.b.cname_sec,'');
				SELF 							:= le.b;
			END;
			
			p := Normalize(in_mod.L_indata,if('C' in in_mod.L_build_skip_set ,2,1), norm(LEFT,Counter));
			return p;
		END;
		
		shared dsb(params in_mod) :=
		FUNCTION
			AutokeyB.Layout_Zip proj(in_mod.L_indata le) :=
			TRANSFORM
				SELF 							:= le.b;
			END;
			
			p := project(in_mod.L_indata, proj(left));
			return p;
		END;		


	//***** DEFINE THE INDEX		
		shared keyb(params in_mod) :=
		FUNCTION
			p := dsb(in_mod);
			recs := dedup( sort (p(zip<>0), record), record );
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'ZipB' + '_' + doxie.Version_SuperKey);
		END;
		
		shared keyb2(params in_mod) :=
		FUNCTION
			p := dsb2(in_mod);
			Autokey.Mac_deduprecs(p(zip<>0),in_mod.L_by_lookup,in_mod.L_Biz_favor_lookup,recs)
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'ZipB2' + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			// lkey := key(in_mod);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb2(in_mod), '',in_mod.L_inlogical+'ZipB2', do_Keyb2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb(in_mod),  '',in_mod.L_inlogical+'ZipB',  do_Keyb, , in_mod.L_diffing);
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
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'ZipB2',in_mod.L_inlogical+'ZipB2', mv_Keyb2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'ZipB', in_mod.L_inlogical+'ZipB',  mv_Keyb, , in_mod.L_diffing);
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
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'ZipB2', 'Q', mv_Key2, ,in_mod.L_diffing);
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'ZipB', 'Q',  mv_Key, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Indv_useAllLookups,
				mv_Key2,
				mv_Key
			);
		END;
END;