IMPORT lib_stringlib, lib_fileservices, _control;

EXPORT  Spray (STRING jobid = '') := FUNCTION
srcIP := _Control.IPAddress.bctlpedata11;
targetGrp := 'thor400_44';
superfileReq := filenames().in_request	;
superfileRes := filenames().in_response	;
filenameReq := superfileReq + '::' + jobid;
filenameRes := superfileRes+ '::' + jobid;
RemoteLoc := '/data/hds_180/phone_status_service/in_prod/';
RemoteFileReq := 'PhoneStatus_Request_'+jobid+'.csv' ;
RemoteFileRes := 'PhoneStatus_Response_'+jobid+'.csv' ;

//check if file exists in UNIX
checkfileexists(STRING FileName)
 := if(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <>0 )) = 1,
	 true,
	 false
	)
 ;
 
 //check if file exists in superfile
remove_existing_fileReq := if(fileservices.FileExists(filenameReq) AND FileServices.GetSuperFileSubCount(superfileReq) <> 0, FileServices.RemoveSuperFile(superfileReq,filenameReq), output('Removing Request File that already exist in superfile'));
remove_existing_fileRes := if(fileservices.FileExists(filenameRes) AND FileServices.GetSuperFileSubCount(superfileRes) <> 0, FileServices.RemoveSuperFile(superfileRes,filenameRes), output('Removing Response File that already exist in superfile'));
remove_existing_fileFixedReq := if(fileservices.FileExists(filenameReq + '_fixed') AND FileServices.GetSuperFileSubCount(superfileReq + '_fixed') <> 0, FileServices.RemoveSuperFile(superfileReq + '_fixed',filenameReq + '_fixed'), output('Removing Request File Fixed that already exist in superfile'));
remove_existing_fileFixedRes := if(fileservices.FileExists(filenameRes + '_fixed') AND FileServices.GetSuperFileSubCount(superfileRes + '_fixed') <> 0, FileServices.RemoveSuperFile(superfileRes + '_fixed',filenameRes + '_fixed'), output('Removing Response File Fixed that already exist in superfile'));

//check if file exists in UNIX and then spray

spray_to_request := if(checkfileexists(RemoteFileReq),
FileServices.SprayVariable(srcIP,RemoteLoc + RemoteFileReq,,',',,'\"',targetGrp,filenameReq,-1,,,true,true,true)
, output('no request file to spray'));

spray_to_response := if(checkfileexists(RemoteFileRes),
FileServices.SprayVariable(srcIP,RemoteLoc + RemoteFileRes,,',',,'\"',targetGrp,filenameRes,-1,,,true,true,true)
, output('no response file to spray'));

to_fixedReq := project(dataset(filenameReq,layouts.request_input,csv(separator(','), heading(1),quote('"'), terminator('\n')))((unsigned)acctno > 0),
														transform(layouts.request_input_fixed,
																			self.jobid := jobid,
																			self.filename := filenameReq,
																			self :=left));
																			
to_fixedRes := project(dataset(filenameRes,layouts.response_input,csv(separator(','), heading(1),quote('"'), terminator('\n')))((unsigned)acctno > 0),
														transform(layouts.response_input_fixed,
																			self.ssn	:= StringLib.StringFilter(left.ssn,'0123456789'),
																			self.jobid := jobid,
																			self.filename := filenameRes,
																			self :=left));
																			
write_to_fixed_Req := if(checkfileexists(RemoteFileReq),
												output(to_fixedReq,, filenameReq + '_fixed', overwrite, compressed),
												output('no request file to write to fixed'));

write_to_fixed_Res := if(checkfileexists(RemoteFileRes),
												output(to_fixedRes,, filenameRes + '_fixed', overwrite, compressed),
												output('no response file to write to fixed'));
												
add_to_superfileReq := if(fileservices.FileExists(filenameReq), fileservices.addsuperfile(superfileReq,filenameReq), output('Could not add request file to superfile'));
add_to_superfileRes := if(fileservices.FileExists(filenameRes), fileservices.addsuperfile(superfileRes,filenameRes), output('Could not add response file to superfile'));
add_to_superfileReqFixed := if(fileservices.FileExists(filenameReq + '_fixed'), fileservices.addsuperfile(superfileReq+ '_fixed',filenameReq+ '_fixed'), output('Could not add request file to superfile fixed'));
add_to_superfileResFixed := if(fileservices.FileExists(filenameRes + '_fixed'), fileservices.addsuperfile(superfileRes+ '_fixed',filenameRes+ '_fixed'), output('Could not add response file to superfile fixed'));




spray_add_files := sequential(remove_existing_fileReq, remove_existing_fileRes,
															remove_existing_fileFixedReq, remove_existing_fileFixedRes,
															spray_to_request, spray_to_response,
															write_to_fixed_Req, write_to_fixed_Res,
														  add_to_superfileReq, add_to_superfileRes,
															add_to_superfileReqFixed, add_to_superfileResFixed
															);

return spray_add_files;

end;