export Update_Contact(

	 dataset(Layouts.Base.AID			)	pBaseFile

) :=
function

	dSplitit			:= Split_Base(pBaseFile).Contacts;
	
	dAppendIds		:= Append_Ids.fAppendDid	(dSplitit			);

	return dAppendIds;

end;