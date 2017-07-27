
import autokey,doxie,AutokeyB2,AutokeyB,RoxieKeyBuild,ut,Business_Header_SS;

export BuildI_Biz_NameWords :=
MODULE

	//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;


	//***** CREATE THE DATASET
		shared dsb2(params in_mod) :=
		FUNCTION
			Business_Header_SS.layout_MakeCNameWords  proj(in_mod.L_indata le) :=
			TRANSFORM
				self.company_name := le.b.bname;
				self.state := le.b.st;
				self.__filepos := 0;
				self 			:= le.b;
			END;
			p := PROJECT(in_mod.L_indata(b.bname<>''), proj(LEFT));
	
			q := 
			if(
				in_mod.L_by_lookup,
				p,
				dedup(
					sort(p,company_name,state,bdid,if(ut.bit_test(lookups,in_mod.L_Biz_favor_lookup),0,1),-lookups),
					company_name,state,bdid
				)
			);
			
			f := business_header_ss.Fn_MakeCNameWords(q);
			return f;
		END;

		shared dsb(params in_mod) :=
		FUNCTION
			Business_Header_SS.layout_MakeCNameWords  proj(in_mod.L_indata le) :=
			TRANSFORM
				self.company_name := le.b.bname;
				self.state := le.b.st;
				self.__filepos := 0;
				self 			:= le.b;
			END;
			p := PROJECT(in_mod.L_indata(b.bname<>''), proj(LEFT));
			f := business_header_ss.Fn_MakeCNameWords(p);
			return f;
		END;


	//***** DEFINE THE INDEX		
		shared keyb(params in_mod) :=
		FUNCTION
			p := dsb(in_mod);;
			recs := dedup( sort (project(p, autokeyb.Layout_NameWords)(word<>'') , record,except seq), record,except seq );
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'NameWords' + '_' + doxie.Version_SuperKey);
		END;
		
		shared keyb2(params in_mod) :=
		FUNCTION
			p := dsb2(in_mod);
			recs := dedup( sort (project(p, AutokeyB2.Layout_NameWords)(word<>'') , record,except seq,local), record,except seq,local );
			return INDEX(recs, {recs}, in_mod.L_inkeyname+'NameWords2' + '_' + doxie.Version_SuperKey);
		END;


	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) :=
		FUNCTION
			// lkey := key(in_mod);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb2(in_mod), '',in_mod.L_inlogical+'NameWords2', do_Keyb2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keyb(in_mod),  '',in_mod.L_inlogical+'NameWords',  do_Keyb, , in_mod.L_diffing);
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
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'NameWords2',in_mod.L_inlogical+'NameWords2', mv_Keyb2, ,in_mod.L_diffing);
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+'NameWords', in_mod.L_inlogical+'NameWords',  mv_Keyb, , in_mod.L_diffing);
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
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'NameWords2', 'Q', mv_Key2, ,in_mod.L_diffing);
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+'NameWords', 'Q',  mv_Key, , in_mod.L_diffing);
			return 
			if(
				in_mod.L_Indv_useAllLookups,
				mv_Key2,
				mv_Key
			);
		END;
END;