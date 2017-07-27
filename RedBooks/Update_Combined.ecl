export Update_Combined( 
     dataset(Layouts.Pre_Standardize.Layout_Combined)	pUpdateFile 
	,dataset(Layouts.Base.Layout_Combined)	pBaseFile
	,string									pversion

) :=
function

	dStandardizedInputFile	:= Standardize_Combined.fAll(pUpdateFile, pversion);

	update_combined	:= map(_Flags.Update._All =>	dStandardizedInputFile + pBaseFile,
						    dStandardizedInputFile );
    
	//return  update_combined;
	
    return RedBooks.Rollup_Base(update_combined);
 
end;