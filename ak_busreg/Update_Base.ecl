export Update_Base(
    dataset(layouts.Input.Sprayed   )  pUpdateFile
   ,dataset(Layouts.Base                  )  pBaseFile
   ,string                                         pversion
) :=
function
   dStandardizedInputFile  := Standardize_Input.fAll  (pUpdateFile                  , pversion);
   update_combined               := if(_Flags.Update
                                                ,dStandardizedInputFile + pBaseFile
                                                ,dStandardizedInputFile
                                             );
   dAppendIds                    := Append_Ids.fAll            (update_combined                 );
   dRollupBase                    := Rollup_Base            (dAppendIds                 );
   
	 return dRollupBase;
end;

