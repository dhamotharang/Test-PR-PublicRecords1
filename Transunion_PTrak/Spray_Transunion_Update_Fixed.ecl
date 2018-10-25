//----------------------------------------------------------------------
//VENDOR FILE: data updates will be from the vendor only in a fixed length file
//----------------------------------------------------------------------
IMPORT lib_stringlib, lib_fileservices, _control, lib_thorlib;

EXPORT  Spray_Transunion_Update_Fixed (STRING full_filedate = '', STRING Update_filedate = '') := FUNCTION
f_Date := if(full_filedate <> '', full_filedate, Update_filedate);
//srcIP := 'edata11-bld.br.seisint.com';
srcIP := _Control.IPAddress.bctlpedata11;
targetGrp := thorlib.group();
superfile := Transunion_Ptrak.SuperFileList.SourceFileUpdateIn;
superfileDel := '~thor_data400::in::transunionptrak_delete';
filenames := superfile + '_' + f_Date;
filenameDel := superfileDel+ '_' + f_Date;
RemoteLoc := '/data/data_lib_2_hus2/TUCS/data/' + f_Date + '/' ;
RemoteFile:= 'vendor.d00' ;
RemoteFileDel := 'delete.del00';

//check if file exists in UNIX
checkfileexists(STRING FileName)
 := if(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <>0 )) = 1,
	 true,
	 false
	)
 ;
 
 //check if file exists in superfile
remove_existing_file := if(fileservices.FileExists(filenames) AND FileServices.GetSuperFileSubCount(superfile) <> 0, FileServices.RemoveSuperFile(superfile,filenames), output('Removing Main File that already exist in superfile'));
remove_existing_fileDel := if(fileservices.FileExists(filenameDel) AND FileServices.GetSuperFileSubCount(superfileDel) <> 0, FileServices.RemoveSuperFile(superfileDel,filenameDel), output('Removing Delete File that already exist in superfile'));

//check if file exists in UNIX and then spray

spray_to_update := if(checkfileexists(RemoteFile),
FileServices.sprayfixed(
  srcIP
 ,RemoteLoc + RemoteFile
 ,332
 ,targetGrp
 ,superfile + '_'+ f_Date
 ,,,,true,true,true
), output('no main file to spray'));

spray_to_delete := if(checkfileexists(RemoteFileDel),
FileServices.sprayfixed(
  srcIP
 ,RemoteLoc + RemoteFileDel
 ,11
 ,targetGrp
 ,superfileDel + '_'+ f_Date
 ,,,,true,true,true
), output('no delete file to spray'));



add_to_superfile := if(fileservices.FileExists(filenames), fileservices.addsuperfile(superfile,filenames), output('Could not add file to superfile'));
add_to_superfileDel := if(fileservices.FileExists(filenameDel), fileservices.addsuperfile(superfileDel,filenameDel), output('Could not add file to superfile no delete file'));


spray_add_files := sequential(remove_existing_file, remove_existing_fileDel,
															spray_to_update, spray_to_delete,
														  add_to_superfile,add_to_superfileDel);

return spray_add_files;

end;


