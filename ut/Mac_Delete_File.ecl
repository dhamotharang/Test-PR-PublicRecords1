export Mac_Delete_File(keyfilename,filedelete) := MACRO


filedelete := if (lib_fileservices.fileservices.FileExists(KeyFileName),
				lib_fileservices.FileServices.DeleteLogicalFile(KeyFileName),
				output(KeyFileName + ' does not exist'));

ENDMACRO;
