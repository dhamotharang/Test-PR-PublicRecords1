import tools,Data_Services,Inquiry_AccLogs, hygenics_search;

export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.SuspectIP           ,Layouts.Input.SuspectIP          ,SuspectIP, 'CSV',,'\n');
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.GLB5                ,Layouts.Input.Glb5               ,Glb5);
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Tiger               ,Layouts.Input.Tiger              ,Tiger, 'CSV');
    tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.CFNA                ,Layouts.Input.CFNA               ,CFNA, 'CSV');
		tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.AInspection         ,Layouts.Input.AInspection        ,AInspection);
    tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.TextMinedCrim       ,Layouts.Input.TextMinedCrim      ,TextMinedCrim);
    tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.OIG                 ,Layouts.Input.OIG                ,OIG);
    tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Erie                ,Layouts.Input.Erie               ,Erie, 'CSV','',['\n','\r\n','\n\r'],'|',,,);
    tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.ErieWatchList       ,Layouts.Input.ErieWatchList      ,ErieWatchList, 'CSV','',['\n','\r\n','\n\r'],'|',,,);

		end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.SuspectIP          ,Layouts.Base.SuspectIP              ,SuspectIP);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Glb5               ,Layouts.Base.Glb5                   ,Glb5);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Tiger              ,Layouts.Base.Tiger                  ,Tiger);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.CFNA               ,Layouts.Base.CFNA                   ,CFNA);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.AInspection        ,Layouts.Base.AInspection            ,AInspection);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.TextMinedCrim      ,Layouts.Base.TextMinedCrim          ,TextMinedCrim);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.OIG                ,Layouts.Base.OIG                    ,OIG);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Erie               ,Layouts.Base.Erie                   ,Erie,,,,,,true,);
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.ErieWatchList      ,Layouts.Base.ErieWatchList          ,ErieWatchList,,,,,,true,);

			end;
//3 years of glb5 data
	export temp := module
	
	 glb5_1        := dataset(Data_Services.foreign_logs +'input::crossrisk', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])))(orig_glb_purpose in ['05','5'] );
   glb5_2        := dataset(Data_Services.foreign_logs +'thor100_21::in::accurint_acclogs_processed', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])))(orig_glb_purpose in ['05','5'] );
   glb5_3        := dataset(Data_Services.foreign_logs +'thor100_21::in::accurint_acclog_3months', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])))(orig_glb_purpose in ['05','5'] );
   glb5_4        := dataset(Data_Services.foreign_logs +'thor100_21::in::accurint_acclog_jan2015', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])))(orig_glb_purpose in ['05','5'] );
   glb5_5        := dataset(Data_Services.foreign_logs +'thor100_21::in::20150301::accurint_acclog', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])))(orig_glb_purpose in ['05','5'] );
   glb5_6        := dataset(Data_Services.foreign_logs +'thor100_21::in::20150302::accurint_acclog', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])))(orig_glb_purpose in ['05','5'] );
   glb5_7        := dataset(Data_Services.foreign_logs +'thor100_21::in::20150303::accurint_acclog_1', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])))(orig_glb_purpose in ['05','5'] );

  // Files().Input.Glb5.Sprayed 
  //comb               := dedup(glb5_1 + glb5_2 + glb5_3 +glb5_4 +glb5_5 +glb5_6 +glb5_7,all)((unsigned6)ut.ConvertDate(orig_dateadded[1..11],'%b %d %Y') >= 20120625 and orig_unique_id<>'' ); // one time load 
  comb                 := dataset(Data_Services.foreign_logs +'thor_data400::in::fdn::sprayed::glb5', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])))(orig_glb_purpose in ['05','5'] );
	rgx                  := '([A-Z]+)([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?';
  Glb5clean            := comb(~Regexfind(rgx,orig_unique_id,nocase));
                                                                                                                                                                                                                                
  export Glb5          := Glb5clean(StringLib.StringToUppercase(orig_function_name )in ['COMPREPORT',
                           'XCOMPREPORT',
                           'XCOMPPLUSREPORT',
                           'CBPSREPORT',
                           'PRUREPORT',
                           'MBPSREPORTWSS']);
													 
  export File_Conviction_Lookup    := hygenics_search.File_Conviction_Lookup;
									
	end; 
	
 export fdn_Lexid_header_build_version  := dataset(FileNames().LexID_Header_Build_Version,  layouts.base.hdr_build_version, thor, opt);
 export fdn_BIP_header_build_version    := dataset(FileNames().BIP_Header_Build_Version,  layouts.base.hdr_build_version, thor, opt);
 
end;