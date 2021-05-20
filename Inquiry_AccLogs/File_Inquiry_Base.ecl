import ut, did_add, dops, std;


export File_Inquiry_Base := module


export update := project(inquiry_acclogs.File_Inquiry_BaseSourced.updates, inquiry_acclogs.Layout.common_indexes);

export history := project(inquiry_acclogs.File_Inquiry_BaseSourced.history, inquiry_acclogs.Layout.common_indexes);

//export full := inquiry_acclogs.File_Inquiry_BaseSourced.full; //riskindicators key inquiry table did needs the source field for filtering

    sc 			:= nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
		findex 	:= stringlib.stringfind(sc, '::', 6)+2;
		lindex 	:= stringlib.stringfind(sc, '_', 3)-1;

  Vk:=sc[findex..lindex];
	
	VP:=dops.Getbuildversion('InquiryTableKeys','B','N','P','prod');//did_add.get_EnvVariable('inquiry_build_version','http://certstagingvip.hpcc.risk.regn.net:9876')[1..8];
	
  father_sf_empty := count(dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor, opt)) = 0;
  sf_complete := count(nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical'))) =2;
	
  FileHistory:=if((vk=vp and sf_complete) or father_sf_empty ,dataset('~thor_data400::out::inquiry_tracking::weekly_historical',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor),
                        dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor,opt));

  // FileHistory:=dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',inquiry_acclogs.Layout.Common_ThorAdditions_non_FCRA,thor,opt);

 shared  historyFiltered := FileHistory (~(bus_intel.industry = 'DIRECT TO CONSUMER' and 
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
															);

export historyAll := project ( historyFiltered, inquiry_acclogs.Layout.common_indexes );

export fileFull		:= historyFiltered + inquiry_acclogs.File_Inquiry_BaseSourced.updates ; 

end; 
 