import ut,data_services, did_add;

export File_Inquiry_BaseSourced := module

 shared Blank_IDs(infile, outfile) := macro 

	outfile := project(infile,
        transform(INQL_v2.layouts.Common_ThorAdditions_non_fcra, 
         fixTime := INQL_v2.fncleanfunctions.tTimeAdded(left.search_info.datetime);
         self.search_info.datetime             := fixTime;
         self.search_info.function_description := INQL_v2.fncleanfunctions.fnCleanUp(left.search_info.function_description);
         self.mbs.company_id                   := '';
         self.mbs.global_company_id            := '';
         self.bus_intel.sub_market             := if (left.bus_intel.sub_market='CARD','CARDS',left.bus_intel.sub_market);
         self := left));
 endmacro;

 BaseFile := INQL_v2.Files(false, true).INQL_base.built; //Daily NonFcra Base File

 Updates_Only :=	BaseFile
								(~INQL_v2.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
								 ~INQL_v2.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
								 ~INQL_v2.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
								 ~INQL_v2.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
								 ~INQL_v2.fnTranslations.is_Internal(allow_flags.allowflags) and
								 ~INQL_v2.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags) and
                  country = 'UNITED STATES');

 Blank_IDs(Updates_Only, Updates_Only_Blank);
 export updates := Updates_Only_Blank;

 sc 			:= nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
 findex 	:= stringlib.stringfind(sc, '::', 6)+2;
 lindex 	:= stringlib.stringfind(sc, '_', 3)-1;

 Vk:=sc[findex..lindex];	
 VP:=did_add.get_EnvVariable('inquiry_build_version','http://roxiestaging.br.seisint.com:9876')[1..8];
 
 FileHistory:=if(vk=vp
         ,dataset('~thor_data400::out::inquiry_tracking::weekly_historical',INQL_V2.Layouts.Common_ThorAdditions_non_FCRA,thor)
         ,dataset('~thor_data400::out::inquiry_tracking::weekly_historical_father',INQL_V2.Layouts.Common_ThorAdditions_non_FCRA,thor)
         );
 
 export fileFull:=FileHistory + updates; 

end;
																