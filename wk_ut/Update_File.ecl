/*
  add the dataset to the existing file
*/
import tools,std;
EXPORT Update_File(

   pUpdateFilename
  ,pUpdateDataset
	,pCompress				= 'true'
	,pOverwrite				= 'false'
  ,pDedupFields     = '\'\''

) := 
functionmacro

  #uniquename(wk_ut_update_file)
  #uniquename(DedupField)

  // temp_filename := pUpdateFilename + %'wk_ut_update_file'%;
  temp_filename := pUpdateFilename + 'temp.wk_ut.update_file';
  
  //assume they are the same layout
  existing_File := dataset(pUpdateFilename  ,recordof(pUpdateDataset),thor,opt);
  new_file      := dataset(temp_filename    ,recordof(pUpdateDataset),thor,opt);

  #SET(DedupField ,pDedupFields)


  #if(pDedupFields = '') 
    concat        := existing_File + pUpdateDataset + new_file;
    concat2       := existing_File + pUpdateDataset;
  #ELSE
    // concat        := sort(dedup(existing_File + pUpdateDataset + new_file,pDedupField,all),pDedupField);
    // concat2       := sort(dedup(existing_File + pUpdateDataset           ,pDedupField,all),pDedupField);
    concat        := sort(dedup(existing_File + pUpdateDataset + new_file,%DedupField%,all),%DedupField%);
    concat2       := sort(dedup(existing_File + pUpdateDataset           ,%DedupField%,all),%DedupField%);
  #END

  return if(pUpdateFilename != ''
    ,sequential(
       iff(not std.file.fileexists(temp_filename) ,tools.macf_writefile(temp_filename,concat2,pCompress,,pOverwrite))
      ,if(std.file.fileexists(pUpdateFilename)   ,sequential(nothor(Tools.fun_ClearfilesFromSupers(dataset([{pUpdateFilename}], Tools.Layout_Names), false)),std.file.deletelogicalfile(pUpdateFilename) ))
      ,tools.macf_writefile(pUpdateFilename,new_file,pCompress,,pOverwrite)
      ,std.file.deletelogicalfile(temp_filename)
      // ,std.file.RenameLogicalFile(temp_filename,pUpdateFilename)
    )
  );

endmacro;
