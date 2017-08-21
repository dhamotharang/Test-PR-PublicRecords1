export Update_Base(
										dataset(Layouts.Input)	pUpdateFile,
										dataset(Layouts.Base)		pBaseFile,
										string pversion
									) := function

	dStandardizedInputFile  := 	LaborActions_EBSA.StandardizeInputFile.fAll(pUpdateFile, pversion);

	update_combined					:=	if(LaborActions_EBSA._Flags.Update
																			,dStandardizedInputFile + pBaseFile
																			,dStandardizedInputFile
																) : persist('persist::LaborActions_EBSA::Combined');
	
	dRollupBase				:= 	Rollup_Base	(update_combined);
   
	return dRollupBase;
end;