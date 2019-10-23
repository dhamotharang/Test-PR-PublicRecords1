﻿import ut, did_add, dops;


export File_Inquiry_Base := module


export update := project(inquiry_acclogs.File_Inquiry_BaseSourced.updates, inquiry_acclogs.Layout.common_indexes);

export history := project(inquiry_acclogs.File_Inquiry_BaseSourced.history, inquiry_acclogs.Layout.common_indexes);

//export full := inquiry_acclogs.File_Inquiry_BaseSourced.full; //riskindicators key inquiry table did needs the source field for filtering

    sc 			:= nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
		findex 	:= stringlib.stringfind(sc, '::', 6)+2;
		lindex 	:= stringlib.stringfind(sc, '_', 3)-1;

  Vk:=sc[findex..lindex];
	
	VP:=dops.Getbuildversion('InquiryTableKeys','B','N','P','prod');//did_add.get_EnvVariable('inquiry_build_version','http://roxiestaging.br.seisint.com:9876')[1..8];
	
  father_sf_empty := count(dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor, opt)) = 0;

  FileHistory:=if(vk=vp or father_sf_empty ,dataset('~thor_data400::out::inquiry_tracking::weekly_historical',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor),
                        dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor,opt));

  // FileHistory:=dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor,opt);

export fileFull:=FileHistory (~(bus_intel.industry = 'DIRECT TO CONSUMER' and 
																search_info.function_description in [
																'ADDRBEST.BESTADDRESSBATCHSERVICE'
																,'BATCHSERVICES.AKABATCHSERVICE'
																,'BATCHSERVICES.DEATHBATCHSERVICE'
																,'BATCHSERVICES.EMAILBATCHSERVICE'
																,'BATCHSERVICES.PROPERTYBATCHSERVICE'
																,'DIDVILLE.DIDBATCHSERVICERAW'
																,'DIDVILLE.RANBESTINFOBATCHSERVICE'
																,'PROGRESSIVEPHONE.PROGRESSIVEPHONEWITHFEEDBACKBATCHSERVICE']
																)
															)	
															+ inquiry_acclogs.File_Inquiry_BaseSourcedToRisk.updates
															; 
end; 
 