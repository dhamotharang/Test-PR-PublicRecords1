EXPORT Clear_Superfiles (STRING full_filedate, STRING update_filedate) := FUNCTION

Remove_full   := IF(FileServices.GetSuperFileSubCount(SuperFileList.SourceFileFullIn) <> 0,
					FileServices.RemoveSuperFile(SuperFileList.SourceFileFullIn, SuperFileList.SourceFileFullIn + '_' + full_filedate),
					OUTPUT('Full Superfile was empty'));
					
Remove_update  := IF(FileServices.GetSuperFileSubCount(SuperFileList.SourceFileUpdateIn) <> 0,
					FileServices.RemoveSuperFile(SuperFileList.SourceFileUpdateIn, SuperFileList.SourceFileUpdateIn +'_' + update_filedate),
					OUTPUT('Update Superfile was empty'));
					
Remove_Clean  	:= IF(FileServices.GetSuperFileSubCount(SuperFileList.CleanAddress) <> 0,
					FileServices.RemoveSuperFile(SuperFileList.CleanAddress, SuperFileList.CleanAddress + '_' + update_filedate),
					OUTPUT('Clean Superfile was empty'));

clean_superfile := SEQUENTIAL(
					FileServices.StartSuperFileTransaction(),
					Remove_full,
					Remove_update,
					Remove_Clean,
					FileServices.FinishSuperFileTransaction()
);					

RETURN clean_superfile;
END;