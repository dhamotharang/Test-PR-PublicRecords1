import _control;

shared sprayIP     := _control.IPAddress.bctlpedata12;
shared sourcePath  := '/data/prct/infiles/dev_16/';
shared Groupname   := 'thor400_44';
// shared Groupname   := 'thor400_sta01';
shared bname:='~prte::in::header::prct_personrecs';

shared getFile(string wlcd) := FileServices.remotedirectory(sprayIP,sourcePath,wlcd,false)(size != 0 )[1].name;

doSprayFile(string wildcard):= function

    filename:=getFile(wildcard);
    new_sprayed_file:= '~prte::in::header::'+filename[1..length(fileName)-4];

    return sequential( if(fileservices.fileExists(new_sprayed_file),output('SKIPPING EXISTING FILE:'+new_sprayed_file),
                          output(FileServices.fSprayVariable(sprayIP,
														sourcePath+fileName,,',','\\n,\\r\\n','"',
														groupname,
														new_sprayed_file,
														-1,,,true,true,true))),
                        fileservices.addsuperfile(bname+'_build',new_sprayed_file)
                      );  // if it is already there, we just re-add it to the build super
                                                        
end;


first_spray_new_files := sequential(
                                    doSprayFile('prte__personrecs__lnpr_*.txt'),
                                    doSprayFile('prte__personrecs__synchrony_*.txt'),
                                    doSprayFile('prte__personrecs__santander_*.txt'),
                                    doSprayFile('prte__personrecs__rbs_*.txt'),
                                    doSprayFile('prte__personrecs__ge_*.txt'),
                                    doSprayFile('prte__personrecs__excelon_*.txt'),
                                    doSprayFile('prte__personrecs__cvs_*.txt'),
                                    doSprayFile('prte__personrecs__citi_*.txt'),
                                    doSprayFile('prte__personrecs__captone_*.txt'),
                                    doSprayFile('prte__personrecs__axcessfin_*.txt'),
                                    doSprayFile('prte__personrecs__amex_*.txt'),
                                    doSprayFile('prte__personrecs__ecr_*.txt'),
																		doSprayFile('prte__personrecs__transunion_*.txt'),
																		doSprayFile('prte__personrecs__scientificgaming_*.txt')
	);

then_move_previous_to_father_before_adding_the_new_sprayed_files := sequential(
            
            // father --> delete , delete --> try to expunge
			FileServices.StartSuperFileTransaction(),
			fileservices.addsuperfile(bname + '_delete',bname + '_father',,true),
			fileservices.clearsuperfile(bname + '_father'),
			fileservices.addsuperfile(bname + '_father',bname,,true),
			FileServices.FinishSuperFileTransaction(),
            // try to expunge delete
			fileservices.RemoveOwnedSubFiles(bname + '_delete',true),
			fileservices.ClearSuperFile(bname + '_delete')
);

now_add_the_new_sprayed_files_after_moving_previous_to_father := sequential(
            
            fileservices.clearsuperfile(bname),
            fileservices.addsuperfile(bname,bname + '_build',,true),
            fileservices.clearsuperfile(bname+'_build')
);

update_file:=
sequential( 
            first_spray_new_files,
            then_move_previous_to_father_before_adding_the_new_sprayed_files,
            now_add_the_new_sprayed_files_after_moving_previous_to_father
);
           
// It will skip if file exists. double check sprayed source
update_file;
