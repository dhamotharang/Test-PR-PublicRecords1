import	Header,Header_Slimsort,DID_Add;

export	Death_DID(dataset(Death_Master.Layouts.Expanded)	dDeath)	:=
function	
	// Append source code
	DID_Add.Mac_Set_Source_Code(dDeath,Death_Master.Layouts.DeathHeaderSource,'DE',dAppendSourceCode);
	
	matchSet	:=	['D','S','Z','A'];

	DID_Add.Mac_Match_Flex(	dAppendSourceCode,
													matchSet,
													ssn,dob8,
													clean_fname,clean_mname,clean_lname,clean_name_suffix,
													prim_range,prim_name,sec_range,zip5,state,foo,
													did,
													Death_Master.Layouts.DeathHeaderSource,
													true,	//has score field
													did_score,90,
													dDeathDID,
													true,	//has source field
													src		//source field
												);
	
	return	dDeathDID;
end;


