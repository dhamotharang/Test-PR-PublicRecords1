//----------------------------------------------------------------------
//VENDOR FILE: data updates will be from the vendor only in a fixed length file
//----------------------------------------------------------------------
IMPORT lib_stringlib, lib_fileservices, _control;

EXPORT  Spray_Transunion_Update_Fixed (STRING Update_filedate) := FUNCTION
srcIP := 'edata14-bld.br.seisint.com';
targetGrp := 'thor400_84';
superfile := Transunion_Ptrak.SuperFileList.SourceFileUpdateIn;
filenames := superfile + '_' + Update_filedate;
RemoteLoc := '/load01/transunion_ptrak/vendor/' + Update_filedate + '/' ;
RemoteFile:= 'vendor.d00' ;

//check if file exists in UNIX
checkfileexists(STRING FileName)
 := if(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <>0 )) = 1,
	 true,
	 false
	)
 ;
 
 //check if file exists in superfile
remove_existing_file := if(fileservices.FileExists(filenames) AND FileServices.GetSuperFileSubCount(superfile) <> 0, FileServices.RemoveSuperFile(superfile,filenames), output('Removing File that already exist in superfile'));

//check if file exists in UNIX and then spray

spray_to_update := if(checkfileexists(RemoteFile),
FileServices.sprayfixed(
  srcIP
 ,RemoteLoc + RemoteFile
 ,322
 ,targetGrp
 ,superfile + '_'+ Update_filedate
 ,,,,true,true,true
), output('no file to spray'));



add_to_superfile := if(fileservices.FileExists(filenames), fileservices.addsuperfile(superfile,filenames), output('Could not add file to superfile'));

spray_add_files := sequential(remove_existing_file, spray_to_update, add_to_superfile);

return spray_add_files;

end;


