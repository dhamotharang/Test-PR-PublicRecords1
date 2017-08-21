export Update_Contacts(
    dataset(layouts.Input.Sprayed   )  pUpdateFile
   ,dataset(Layouts.Base.Contacts   )  pBaseFile
   ,string                             pversion
) :=
function
	 dSplitInputfile					:= Split_Input.Contacts(pUpdateFile);
   dStandardizedInputFile  	:= Standardize_Contacts.fAll  (dSplitInputfile                  , pversion);
   update_combined          := if(_Flags.UpdateContacts
                                                ,dStandardizedInputFile + pBaseFile
                                                ,dStandardizedInputFile
                                             );
   dAppendIds               := Append_ids.fAppendDid(update_combined      ) : persist(Persistnames.AppendIdsDid  );
   return dAppendIds;
end;

