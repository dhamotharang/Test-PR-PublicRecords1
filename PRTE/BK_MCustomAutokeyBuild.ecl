import autokeyi, doxie, RoxieKeyBuild, autokey, PRTE, PRTE_CSV;

export BK_MCustomAutokeyBuild := module

	export RedactedSSNName := module
		
		export params := autokeyi.InterfaceForBuild;

	//***** INDEX BUILD CODE		
		export keybuild(params in_mod) := function
	
			recs_pre := in_mod.L_indata(length(trim(p.ssn)) >= 4);
			recs := 
			project(
				recs_pre, 
				transform(
					autokey.Layout_SSN_redacted,
					unsigned1 ssn_len :=	length(trim(left.p.ssn));
					
					/* assure that we get the last four of the ssn */
					self.s6 := left.p.ssn[ssn_len-3];
					self.s7 := left.p.ssn[ssn_len-2];
					self.s8 := left.p.ssn[ssn_len-1];
					self.s9 := left.p.ssn[ssn_len];

					self := left.p));
				
			//recs_ddp := dedup(sort(recs, record), except did);
			recs_ddp := dedup(sort(recs, record));
			
			key := INDEX(recs_ddp, {s6,s7,s8,s9,dph_lname,lname,fname,pfname,minit}, {recs}, in_mod.L_inlogical + 'ssnlast4name');
	
			return build(key, update);
		end;


	//***** INDEX MOVE CODE		
		export keymove(params in_mod) :=
		function
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(	in_mod.L_inkeyname + '@version@::' + 'SSNLast4Name', 
																							in_mod.L_inlogical + 'SSNLast4Name',  
																							mv_Key);
			return mv_Key;
		end;
	
	
	//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		function
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname + '@version@::' + 'SSNLast4Name', 'Q',  mv_Key);
			return mv_Key;
		end;
		
	end;

end;