EXPORT Clear_Superfiles (STRING full_filedate, STRING update_filedate) := FUNCTION
fdate := if(full_filedate <> '', full_filedate, update_filedate);
Remove_full   := IF(FileServices.GetSuperFileSubCount(SuperFileList.SourceFileFullIn) <> 0,
					FileServices.RemoveSuperFile(SuperFileList.SourceFileFullIn, SuperFileList.SourceFileFullIn + '_' + full_filedate),
					OUTPUT('Full Superfile was empty'));
					
Remove_update  := IF(FileServices.GetSuperFileSubCount(SuperFileList.SourceFileUpdateIn) <> 0,
					FileServices.RemoveSuperFile(SuperFileList.SourceFileUpdateIn, SuperFileList.SourceFileUpdateIn +'_' + fdate),
					OUTPUT('Update Superfile was empty'));
					
Remove_Clean  	:= IF(FileServices.GetSuperFileSubCount(SuperFileList.CleanAddress) <> 0,
					FileServices.ClearSuperFile(SuperFileList.CleanAddress),
					OUTPUT('Clean Superfile was empty'));

clean_superfile := SEQUENTIAL(
					FileServices.StartSuperFileTransaction(),
				  //Remove_full, //full file from ptrak no longer provided.  Instead a full file is received directly from the vendor
					Remove_update,
					Remove_Clean,
					FileServices.FinishSuperFileTransaction()
);					

RETURN clean_superfile;
END;