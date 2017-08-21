import lib_fileservices;
OutputFile := '~thor_200::in::official_records_party_'+official_records.Version_Development ;
RenameFile := '~thor_200::in::official_records_party_tmp'+official_records.Version_Development ;

RemLogFile := lib_fileservices.FileServices.DeleteLogicalFile(OutputFile);
DestFile := lib_fileservices.FileServices.RenameLogicalFile(RenameFile,OutputFile);
export Name_Moxie_Party_temp_Dev := if(lib_fileservices.FileServices.FileExists( RenameFile) = true,sequential(RemLogFile,DestFile),output('do nothing'));