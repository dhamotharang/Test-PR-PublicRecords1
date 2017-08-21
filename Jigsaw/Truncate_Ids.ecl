import  _Control, ut;



	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fTruncid
	// -- Remove Id's in locked remove file from Base file
	//////////////////////////////////////////////////////////////////////////////////////
	export Truncate_Ids(dataset(Layouts.Input.Sprayed	)	pLockedSprayedFile,dataset(Layouts.Base) pDataset) :=
	function
	
	File_Locked_remove := pLockedSprayedFile(STATUS = 'DELETE');
	
	Layout_delete_remove := record
	File_Locked_remove.Contactid;
	File_Locked_remove.UpdateTimestamp;
	end;
	
	File_delete_remove := sort(table(File_Locked_remove,Layout_delete_remove,Contactid,UpdateTimestamp,few),Contactid);
	
	File_prebase       := sort(distribute(pDataset,HASH(rawfields.ContactID)),rawfields.ContactID,local);
	
	Layouts.Base t_Update_Base(File_prebase l, File_delete_remove r) := transform
	self := l;
	end;
	
	Update_base := join(File_prebase,File_delete_remove,LEFT.rawfields.ContactID=RIGHT.ContactID,t_Update_Base(LEFT,RIGHT),left only,lookup);
	
	return Update_base;
	end;
	