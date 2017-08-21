import PromoteSupers;
EXPORT Post_FilesSnap := module
	
	PromoteSupers.MAC_SF_BuildProcess(Bair.FilesSnap.all, bair.Superfile_List().FilesSnap, PostFilesSnap ,2,,true);
	EXPORT all := PostFilesSnap;

End;