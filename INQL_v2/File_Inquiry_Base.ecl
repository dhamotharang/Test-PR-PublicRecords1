import ut, did_add, data_services;


export File_Inquiry_Base := module


export update  := project(INQL_V2.File_Inquiry_BaseSourced.updates, INQL_V2.Layouts.common_indexes);

historyDS :=  dataset(data_services.foreign_prod+'thor_data400::out::inquiry_tracking::weekly_historical',INQL_v2.layouts.Common_ThorAdditions_non_FCRA,thor);
export history := project(historyDS, INQL_V2.Layouts.common_indexes);

 sc 			:= nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
 findex 	:= stringlib.stringfind(sc, '::', 6)+2;
 lindex 	:= stringlib.stringfind(sc, '_', 3)-1;

 Vk:=sc[findex..lindex];
	
 VP:=did_add.get_EnvVariable('inquiry_build_version','http://roxiestaging.br.seisint.com:9876')[1..8];
 FileHistory:=if(vk=vp
         ,dataset('~thor_data400::out::inquiry_tracking::weekly_historical',INQL_V2.Layouts.Common_ThorAdditions_non_FCRA,thor)
         ,dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',INQL_V2.Layouts.Common_ThorAdditions_non_FCRA,thor)
         );
                        
export fileFull:=FileHistory+INQL_V2.File_Inquiry_BaseSourced.updates; 

end; 
 