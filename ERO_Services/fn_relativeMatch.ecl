import doxie,doxie_Raw,ut;

EXPORT fn_relativeMatch(ERO_Services.Layouts.layout_extra_penalty input_rec, doxie.IDataAccess modAccess) :=
	function

  // Note: functions in this code are now use permissions from the query's input;
  // before, default values were mostly used (glb=dppa=0, industry='UTIL', etc.).
  // There are no reasons why we cannot use values provided in the input.

	// lookup first degree relatives and if last first match input relfirst and rellast then return true.
	dids := dataset([input_rec.did], doxie.layout_references);
	relsFound := doxie_Raw.relative_raw(dids,modAccess,
																				/*include_relatives_val*/,/*include_associates_val*/,	
																				/*Relative_Depth*/1,/*max_relatives*/,/*isCRS*/,/*max_associates*/);

   relDids := project(relsFound(same_lname=true),transform(doxie.layout_references, self.did := left.person2));

   relNames := doxie.Comp_Subject_Addresses(RelDids,,,,modAccess).names;
   
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
