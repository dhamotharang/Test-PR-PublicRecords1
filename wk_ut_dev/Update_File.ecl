/*
  add the dataset to the existing file
*/
import tools,std;
EXPORT Update_File(

   pUpdateFilename
  ,pUpdateDataset
	,pCompress				= 'true'
	,pOverwrite				= 'false'

) := 
functionmacro

  #uniquename(wk_ut_dev_update_file)

  temp_filename := pUpdateFilename + %'wk_ut_dev_update_file'%;
  
  //assume they are the same layout
  existing_File := dataset(pUpdateFilename  ,recordof(pUpdateDataset),thor,opt);
  concat        := existing_File + pUpdateDataset;
  
  return if(pUpdateFilename != ''
    ,sequential(
       tools.macf_writefile(temp_filename,concat,pCompress,,pOverwrite)
      ,if(std.file.fileexists(pUpdateFilename)   ,std.file.deletelogicalfile(pUpdateFilename) )
      ,std.file.RenameLogicalFile(temp_filename,pUpdateFilename)
    )
  );

endmacro;
