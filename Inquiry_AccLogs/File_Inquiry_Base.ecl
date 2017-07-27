import ut, did_add;


export File_Inquiry_Base := module


export update := project(inquiry_acclogs.File_Inquiry_BaseSourced.updates, inquiry_acclogs.Layout.common_indexes);

export history := project(inquiry_acclogs.File_Inquiry_BaseSourced.history, inquiry_acclogs.Layout.common_indexes);

//export full := inquiry_acclogs.File_Inquiry_BaseSourced.full; //riskindicators key inquiry table did needs the source field for filtering

    sc 			:= nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
		findex 	:= stringlib.stringfind(sc, '::', 6)+2;
		lindex 	:= stringlib.stringfind(sc, '_', 3)-1;

  Vk := sc[findex..lindex];
	
	VP := did_add.get_EnvVariable('inquiry_build_version','http://roxiestaging.br.seisint.com:9876');
  FileHistory := if(vk=vp,dataset('~thor_data400::out::inquiry_tracking::weekly_historical',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor),
                        dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor));
export fileFull := FileHistory + inquiry_acclogs.File_Inquiry_BaseSourced.updates; 
end; 
 