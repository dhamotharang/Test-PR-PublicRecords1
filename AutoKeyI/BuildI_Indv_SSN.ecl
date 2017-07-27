
import autokey,doxie,RoxieKeyBuild;

export BuildI_Indv_SSN :=
MODULE


	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared ds(params in_mod) :=
		FUNCTION
			Autokey.Layout_SSN2  proj(in_mod.L_indata le) :=
			TRANSFORM
				self.s1		:= le.p.ssn1;
				self.s2		:= le.p.ssn2;
				self.s3		:= le.p.ssn3;
				self.s4		:= le.p.ssn4;
				self.s5		:= le.p.ssn5;
				self.s6		:= le.p.ssn6;
				self.s7		:= le.p.ssn7;
				self.s8		:= le.p.ssn8;
				self.s9		:= le.p.ssn9;
				self 			:= le.p;
			END;
			p := PROJECT(in_mod.L_indata((integer)p.ssn <> 0), proj(LEFT));
			return p;
		END;


	//***** DEFINE THE INDEX		
		shared key(params in_mod) :=
		FUNCTION
			p := project(ds(in_mod), Autokey.Layout_SSN);
			recs := dedup( sort (p, record), record );
			return INDEX(recs, {recs}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
		END;
		
		shared key2(params in_mod) :=
		FUNCTION
			p := ds(in_mod);
			Autokey.Mac_deduprecs(p,in_mod.L_by_lookup,in_mod.L_Indv_favor_lookup,recs)
			return INDEX(recs, {recs}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			// lkey := key(in_mod);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key2(in_mod), '',in_mod.L_inlogical+'SSN2', do_Key2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key(in_mod),  '',in_mod.L_inlogical+'SSN',  do_Key, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Indv_useAllLookups,
				do_Key2,
				do_Key
			);
		END;


	//***** INDEX MOVE CODE		
		export keymove(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'SSN2',in_mod.L_inlogical+'SSN2', mv_Key2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'SSN', in_mod.L_inlogical+'SSN',  mv_Key, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Indv_useAllLookups,
				mv_Key2,
				mv_Key
			);
		END;
		
		
	//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'SSN2', 'Q', mv_Key2, ,in_mod.L_diffing);
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'SSN', 'Q',  mv_Key, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Indv_useAllLookups,
				mv_Key2,
				mv_Key
			);
		END;
END;