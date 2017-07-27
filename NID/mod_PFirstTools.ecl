import ut,_Control,NID;
export mod_PFirstTools := MODULE

	//** Library Call
#if(not _Control.LibraryUse.ForceOff_NID__lib_PFirst)
	export PFM(NID.Interfaces.LIBIN_PFirst args) := library('NID.lib_PFirst',NID.Interfaces.LIBOUT_PFirst(args));
#else
	export PFM(NID.Interfaces.LIBIN_PFirst args) := NID.lib_PFirst(args);
#end
	
	//** Preferred First - takes in a name and returns a set of names
	export NID.Interfaces.type_PFirstX PF(NID.Interfaces.type_name name) := FUNCTION
	
		args := MODULE(NID.Interfaces.LIBIN_PFirst)
			export name := ^.name;
		END;
	
		// this is what i would like to do but i am not allowed to return a set from a library
		// return PFM(args).names;
		
		// so i will do this instead
		return set(PFM(args).names, name);
	END;
	
	//** Right name in set of PreferredFirst(Left)
	// Standard for when the RHS (e.g. the keyed field) is already mapped and the LHS is not
	export boolean RinPFL(NID.Interfaces.type_name L, NID.Interfaces.type_name R) := R in PF(L);
	
	//** Right name[1] in set of initials for PreferredFirst(Left)
	// Implemented especially for DidVille.PickScore3
	export boolean RinPFL_Initial(NID.Interfaces.type_name L, NID.Interfaces.type_name R) := 
	FUNCTION
		set of string1 set_initials := PF(L); //assigning a set of string20 to a set of string1 automatically takes the first character
		return R[1] in set_initials;
	END;

	//** Right initial in set of initials for PreferredFirst(Left)
	// Implemented especially for DidVille.MAC_DidAppend
	export boolean R1inPFL_Initial(NID.Interfaces.type_name L, string1 R1) := 
	FUNCTION
		set of string1 set_initials := PF(L);
		return R1 in set_initials;
	END;
	
	export boolean R2inPFL_FirstTwo(NID.Interfaces.type_name L, string2 R2) := 
	FUNCTION
		set of string2 set_firsttwos := PF(L);
		return R2 in set_firsttwos;
	END;

	//** Right alphainit in set of alphainit for PreferredFirst(Left) - only compatible with up to two PFs for L
	// Implemented especially for DidVille.MAC_DidAppend
	export boolean RinPFL_alphainit(NID.Interfaces.type_name L, string1 mi, string2 RAI) := 
	FUNCTION
		f1_1 := (PF(L))[1];
		f1_2 := (PF(L))[2];
		return RAI in [ut.alphinit2(f1_1[1], mi),ut.alphinit2(f1_2[1], mi)] ;
	END;
	
	//** Lowest NameMatch given that L may have multiple translations.  this supports up to 2.
	export NameMatchPFL(NID.Interfaces.type_name L, string m1, string l1, string f2, string m2, string l2) := 
	FUNCTION
		
		f1_1 := (PF(L))[1];
		f1_2 := (PF(L))[2];
		
		NM1 := ut.NameMatch(f1_1,m1,l1, f2,m2,l2);
		NM2 := ut.NameMatch(f1_2,m1,l1, f2,m2,l2);		
		
		themin := if(f1_2 <> '' and NM2 < NM1, NM2, NM1); //if f1_2 is blank, then there was only one preferred first name in the set 
		
		//This fw bit is for bw compat. as we see some inputs with the mname also in the fname field
		//the new pf seems to map names more often, so i still want 'GLEN E' to be a close match to the pf of glen, which is now GLENDON
		boolean isMoreThanOneWord(string s) := length(trim(s, left, right)) >  length(trim(s, all));
		firstword := ut.Word(L,1,' '); 
		f1_1fw := (PF(firstword))[1];
		f1_2fw := (PF(firstword))[2];

		NM1fw := ut.NameMatch(f1_1fw,m1,l1, f2,m2,l2);
		NM2fw := ut.NameMatch(f1_2fw,m1,l1, f2,m2,l2);		
		
		theminfw := if(f1_2fw <> '' and NM2fw < NM1fw, NM2fw, NM1fw);
				
		return if(isMoreThanOneWord(L) and theminfw < themin, theminfw, themin);
	END;	
	
	//** Lowest length given that L (aka f1) may have multiple translations.  this supports up to 2.
	export LowLengthPFL(NID.Interfaces.type_name L) := 
	FUNCTION
		f1_1 := (PF(L))[1];
		f1_2 := (PF(L))[2];
		L1 := length(trim(f1_1));
		L2 := length(trim(f1_2));
		return if(f1_2 <> '' and L2 < L1, L2, L1);
	END;		
	
	//** Lowest StringSimilar given that L (aka f1) may have multiple translations.  this supports up to 2.
	export StringSimilarPFL(NID.Interfaces.type_name L, NID.Interfaces.type_name R) := 
	FUNCTION
		f1_1 := (PF(L))[1];
		f1_2 := (PF(L))[2];
		SS1 := ut.stringsimilar(f1_1,r);
		SS2 := ut.stringsimilar(f1_2,r);
		return if(f1_2 <> '' and SS2 < SS1, SS2, SS1);
	END;		

  //copy of the pfe function from gong history search, check if L leading matches preferred first R  
  export SubLinPFR(NID.Interfaces.type_name L, NID.Interfaces.type_name R) := 
	FUNCTION
		f1_1 := (PF(R))[1];
		f1_2 := (PF(R))[2];	
	  checkPF1 := L[1..length(trim(f1_1))]=(STRING20)f1_1;
	  checkPF2 :=	L[1..length(trim(f1_2))]=(STRING20)f1_2;
		return if(f1_2 <> '', checkPF1 or checkPF2, checkPF1);							
	END;	

  //for gong history search, check if preferred first of L and perfered first R has intersaction
  export PFLeqPFR(NID.Interfaces.type_name L, NID.Interfaces.type_name R) := 
	FUNCTION
	
		f1_1 := (PF(L))[1];
		f1_2 := (PF(L))[2];
		f2_1 := (PF(R))[1];
		f2_2 := (PF(R))[2];
		
		checkPF1 := (f1_1 = f2_1);
		checkPF2 := (f1_2 = f2_2);
		
  	return if(f1_2<>'' and f2_2<>'', checkPF1 or checkPF2, checkPF1);
		
	END;		
  
	//similar to the function above, just preferred first L leading matches preferred R
  export SUBPFLeqPFR(NID.Interfaces.type_name L, NID.Interfaces.type_name R) := 
	FUNCTION
		
		f1_1 := (PF(L))[1];
		f1_2 := (PF(L))[2];
		f2_1 := (PF(R))[1];
		f2_2 := (PF(R))[2];
		
		checkPF1 := f1_1[1..length(trim(f2_1))] = f2_1;
		checkPF2 := f1_2[1..length(trim(f2_2))] = f2_2;
		
  	return if(f1_2<>'' and f2_2<>'', checkPF1 or checkPF2, checkPF1);
		
	END;
	
	export SUBPFLeqR(NID.Interfaces.type_name L, NID.Interfaces.type_name R) := 
	FUNCTION
		
		f1_1 := (PF(L))[1];
		f1_2 := (PF(L))[2];
		
		checkPF1 := f1_1[1..length(trim(R))] = R;
		checkPF2 := f1_2[1..length(trim(R))] = R;
		
  	return if(f1_2<>'', checkPF1 or checkPF2, checkPF1);
		
	END;

  //slightly diffrent from above functions, R will be just one character
	export boolean WholeRinPFL_Initial(NID.Interfaces.type_name L, NID.Interfaces.type_name R) := 
	FUNCTION
		set of string1 set_initials := PF(L);
		return R in set_initials;
	END;

END;