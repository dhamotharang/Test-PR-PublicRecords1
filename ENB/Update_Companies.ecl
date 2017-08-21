export Update_Companies(
    dataset(layouts.Input.Sprayed   )  pUpdateFile
   ,dataset(Layouts.Base.Companies   )  pBaseFile
   ,string                             pversion
) :=
function
	 dSplitInputfile					:= Split_Input.Companies(pUpdateFile);
   dStandardizedInputFile  	:= Standardize_Companies.fAll  (dSplitInputfile                  , pversion);
   update_combined          := if(_Flags.UpdateCompanies
                                                ,dStandardizedInputFile + pBaseFile
                                                ,dStandardizedInputFile
                                             );
   dAppendIds               := Append_ids.fAppendBdid(update_combined      ) : persist(Persistnames.AppendIdsBdid  );
   return dAppendIds;
end;

