import doxie,doxie_Raw,ut;
EXPORT fn_relativeMatch(ERO_Services.Layouts.layout_extra_penalty   input_rec, unsigned1 inGLBPurpose =0,unsigned1 inDPPAPurpose=0) :=
	function

  // Note: currently,  is called with a lot of defaults
  mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
    EXPORT unsigned1 glb := 0; // not from the input?
    EXPORT unsigned1 dppa := 0; // not from the input?
    EXPORT boolean ln_branded := FALSE;
    EXPORT boolean probation_override := TRUE; // most likely, a typo
    EXPORT string5 industry_class := 'UTILI'; //different from how it is done in fn_add2Addrs. Probably, a typo. 
    EXPORT boolean no_scrub := FALSE;
    EXPORT unsigned3 date_threshold := 0;
  END;

	// lookup first degree relatives and if last first match input relfirst and rellast then return true.
	dids := dataset([input_rec.did], doxie.layout_references);
	relsFound := doxie_Raw.relative_raw(dids,,inDPPAPurpose,inGLBPurpose,/*ssn_mask_value*/,/*ln_branded_value*/,	/*probation_override_value*/,
																				/*include_relatives_val*/,/*include_associates_val*/,	
																				/*Relative_Depth*/1,/*max_relatives*/,/*isCRS*/,/*max_associates*/);
   relDids := project(relsFound(same_lname=true),transform(doxie.layout_references, self.did := left.person2));

   relNames := doxie.Comp_Subject_Addresses(RelDids,,,,mod_access).names;
   
	 inputLast := trim(input_rec.Relative_Last_Name,all) <>'';
   inputFirst := trim(input_rec.Relative_First_Name,all) <>'';
	 //relative match 0=no matches, 1=either last or first, 2=both last and first match	
	 relative_match1 := exists(relNames((inputLast and ut.NBEQ(lname,input_rec.Relative_Last_Name)) OR 
		                                 (inputFirst and ut.NBEQ(fname,input_rec.Relative_First_Name)))) ;
   relative_match2 := exists(relNames((inputLast and ut.NBEQ(lname,input_rec.Relative_Last_Name)) AND 
		                                 (inputFirst and ut.NBEQ(fname,input_rec.Relative_First_Name)))) ;																		 
   relative_match := map(relative_match2 => 2,
	                       relative_match1 => 1,
	                       0);																		 
	 return relative_match;
	end;	
