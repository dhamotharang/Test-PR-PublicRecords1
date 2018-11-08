IMPORT data_services, wk_ut, header, ut, zz_gmarcan;

EXPORT Header_Ingest_Stats_Report(string forceNewVersion = '',unsigned1 percent_nbm_change_threshold = 30) := FUNCTION

header_get_wuid_results(filedate,res_name,out_rec,step) := FUNCTIONMACRO

				esp     := wk_ut._constants.ProdEsp;
				w_s	    :='W'+ut.date_math(workunit[2..9],-200)+'-000000';
				w_e		:='W'+ut.date_math(workunit[2..9], 1)+'-000000';

				job_name := CASE(step,
												// 'ingest' => 'Yogurt:'+filedate+' Header*Ingest*',
												'ingest' => '*' + filedate+' Header*Ingest*',
												// 'sync'   => 'Yogurt:'+filedate+' Header Sync;Rollup & Stats',
												'sync'   => '*' + filedate+' Header Sync;Rollup & Stats',
												'');
				
				raw_wuids := wk_ut.get_WorkunitList(w_s,w_e,pJobname:=trim(job_name) ,pesp :=  esp);
				
				
				rec_fls := record
						raw_wuids.wuid;
						dataset(out_rec) listout;
				end;
				
				rec_fls getFiles (raw_wuids L) := transform

						self.wuid := L.wuid;
						self.listout := if( count(wk_ut.get_WUInfo(L.wuid,pesp :=  esp).WUInfo.results(name=res_name))>0,
																wk_ut.get_DS_Result(trim(L.wuid),res_name,out_rec,pesp :=  esp),
																dataset([],out_rec));
				end;
		
				nbm  := project(raw_wuids, getFiles(LEFT));
				return dedup(normalize(nbm,LEFT.listout,transform(out_rec,SELF:=RIGHT)),record,all);
								
endmacro;
// ************************************************************************************************************************
// GET VERSIONS
getVersion (string s) := regexfind('([_:])(2[0-9]{7})[^0-9]?[:^]?',s,2);

incremental_father_superfile_name := data_services.foreign_prod+'thor_data400::base::header_raw_incremental_father';
incremental_currnt_superfile_name := data_services.foreign_prod+'thor_data400::base::header_raw_incremental';

incremental_father_filename := if(count(fileservices.SuperFileContents(incremental_father_superfile_name))>0,
																	fileservices.SuperFileContents(incremental_father_superfile_name)[1].name,':20010101');

incremental_father_version := getVersion(incremental_father_filename);
incremental_latest_version := getVersion(fileservices.SuperFileContents(incremental_currnt_superfile_name)[1].name);

monthly_latest_raw_version := getVersion(fileservices.SuperFileContents('~thor_data400::base::header_raw')[1].name);
monthly_prevs__raw_version := getVersion(fileservices.SuperFileContents('~thor_data400::base::header_raw_syncd_built')[1].name);

latest_current_raw_version := if(forceNewVersion='',max(incremental_latest_version , monthly_latest_raw_version),forceNewVersion);
cmp_latest_monthly_version := if( latest_current_raw_version = monthly_latest_raw_version,
                                  monthly_prevs__raw_version,
                                  monthly_latest_raw_version   );
ra:=
output(dataset([
				{'incremental_father_version',incremental_father_version},
				{'incremental_latest_version',incremental_latest_version},
				{'monthly_latest_raw_version',monthly_latest_raw_version},
				{'monthly_prevs__raw_version',monthly_prevs__raw_version},
				{'latest_current_raw_version',latest_current_raw_version},
				{'cmp_latest_monthly_version',cmp_latest_monthly_version}],{string file,string version}),named('versions_info'));
// ************************************************************************************************************************
get_ver_raw_header_count(string ver) := FUNCTION

            esp     := wk_ut._constants.ProdEsp;
            nm      := 'thor_data400::base::header_raw_'+ver;
            vwuid   := wk_ut.get_DFUInfo(nm).DFUInfo[1].wuid;
            raw_cnt := wk_ut.get_WUInfo(vwuid,pesp :=  esp).WUInfo.results(FileName=nm)[1].Total;

            return raw_cnt;
END;
// ************************************************************************************************************************
// Header raw report

rec_rep1 := {Header.Stats._rec - variable, decimal5_2 pct_change:=0};
rep1 := sort(iterate(sort(project(Header.Stats.get('Header_raw_count'),rec_rep1),version),
                    transform(rec_rep1,SELF.pct_change := (RIGHT.value/LEFT.value-1)*100,SELF:=RIGHT)
             ),-version);
rb:=
sequential(
            // header.stats.remove(latest_current_raw_version,'Header_raw_count',19279146090),
            if(get_ver_raw_header_count(latest_current_raw_version)>0,
            header.stats.add(dataset([
                                      {     latest_current_raw_version,'Header_raw_count',
                                            get_ver_raw_header_count(latest_current_raw_version);   }
                                            
                                      ],header.stats._rec))),
            output(rep1,named('header_raw_count_stats'))
           );

// ************************************************************************************************************************
// pull in wuid results
rWthSprFlNm := record 
    ,maxlength(10000) FsLogicalFileNameRecord;
    dataset(FsLogicalFileNameRecord) SubFileName;
end;
pi := header_get_wuid_results(cmp_latest_monthly_version,'Header_Inputs' ,rWthSprFlNm,'ingest');
ci := header_get_wuid_results(latest_current_raw_version,'Header_Inputs' ,rWthSprFlNm,'ingest');

r_nbm := {string2  src, string30 src_desc, unsigned count_};
prev_nbm := header_get_wuid_results(cmp_latest_monthly_version,'no_basic_match_monthly',r_nbm,'ingest');
            //header_get_wuid_results(cmp_latest_monthly_version,'no_basic_match_incremental',r_nbm,'ingest');
curr_nbm := //header_get_wuid_results(latest_current_raw_version,'no_basic_match_monthly',r_nbm,'ingest')+
            header_get_wuid_results(latest_current_raw_version,'no_basic_match_incremental',r_nbm,'ingest');
rc:=output(prev_nbm,named('prev_nbm'));
rd:=output(curr_nbm,named('curr_nbm'));

r_newHr := {string2 src, unsigned cnt};
curr_newHr := header_get_wuid_results(latest_current_raw_version,'NhrAfter_src_cnt',r_newHr,'ingest');
re:=output(curr_newHr,named('curr_newHr'));

r_src := {string2 src, string2 extra, unsigned cnt, real8 pct};
prod_src := header_get_wuid_results(monthly_prevs__raw_version,'src',r_src,'sync');
rf:=output(prod_src,named('prod_src'));

// ************************************************************************************************************************
// Header_Input Report
compRec := record
		rWthSprFlNm.name;
		dataset(FsLogicalFileNameRecord) prev_SubFileName;
		dataset(FsLogicalFileNameRecord) curr_SubFileName;
end;
compRec compThem(pi L, ci R) := transform
		SELF.name := L.name;
		SELF.prev_SubFileName := L.SubFileName;
		SELF.curr_SubFileName := R.SubFileName;
end;
rg:=output( join(pi,ci, LEFT.name=RIGHT.name, compThem(LEFT,RIGHT), FULL OUTER), named('comparison'));

prev_inputs_norm := normalize(pi,LEFT.SubFileName,
										transform({string name,string subfilename},SELF.name:=LEFT.name,SELF.subfilename:=right.name));
prevm_inpts_norm := normalize(pi,LEFT.SubFileName,
										transform({string name,string subfilename},SELF.name:=LEFT.name,SELF.subfilename:=right.name));
curr_inputs_norm := normalize(ci,LEFT.SubFileName,
										transform({string name,string subfilename},SELF.name:=LEFT.name,SELF.subfilename:=right.name));

new_only  := join (prev_inputs_norm,curr_inputs_norm,LEFT.name=RIGHT.name AND LEFT.subfilename=RIGHT.subfilename, RIGHT ONLY);
no_change := join (prevm_inpts_norm,curr_inputs_norm,LEFT.name=RIGHT.name AND LEFT.subfilename=RIGHT.subfilename);

{string name, dataset(FsLogicalFileNameRecord) subfilename} denorm({new_only} L, dataset({new_only}) R) := transform
		SELF.name := L.name;
		SELF.subfilename := project(R,transform(FsLogicalFileNameRecord,SELF.name:=LEFT.subfilename));
end;
new_only_dn := denormalize( dedup(new_only,name,all),new_only,LEFT.name=RIGHT.name,GROUP,denorm(LEFT,ROWS(RIGHT)));
													 
rh:=output(new_only_dn,named('new_inputs'));

no_change_unexpected := no_change(subfilename not in 
[
'thor_200::base::lss_gong20150715a',
'thor_data400::base::alloymedia_student_list_w20160129-122737',
'thor_data400::base::equifax_history_w20110122-200507::copy',
'thor_data400::base::experianirsg_buildw20100421-143920::copyfrom92',
'thor_data400::base::liens::main',
'thor_data400::base::liens::party',
'thor_data400::base::sex_offender_mainpublic_w20100719-230812::copyfrom200',
'thor_data400::base::sex_offender_mainpublic_w20100903-110346::copyfrom200',
'thor_data400::in::ak_permanent_fund_clean_20030829_ff::copyfrom92',
'thor_data400::in::ak_permanent_fund_clean_20040409::copyfrom92',
'thor_data400::in::ak_permanent_fund_clean_20040714_update::copyfrom92',
'thor_data400::in::ak_permanent_fund_clean_20041014_update::copyfrom92',
'thor_data400::in::ak_permanent_fund_pe_clean_20030829_ff::copyfrom92',
'thor_data400::in::ak_permanent_fund_pe_clean_20031020_ff::copyfrom92',
'thor_data400::in::ak_permanent_fund_pe_clean_20040108::copyfrom92',
'thor_data400::in::emerges_boats_20050225::copyfrom92',
'thor_data400::in::liens_full_20070120_do_not_delete',
'thor_data400::in::ms::20090518::workcomp::copyfrom92'

]
);
// Header_get_inputs(true)._debug;
no_change_unexpected_dn := denormalize( dedup(no_change_unexpected,name,all),no_change_unexpected,LEFT.name=RIGHT.name,GROUP,denorm(LEFT,ROWS(RIGHT)));
ri:= output(no_change_unexpected_dn,named('unexpected_monthly_no_change'));
// ************************************************************************************************************************
// nbm Report
r_report := record
	string2     src:='';
	string30    src_desc:='';
	integer     newHr_cnt:=0;
	integer     prev_nbm_cnt:=0;
	integer     nbm_cnt:=0;
	decimal7_4  nbm_pct_of_newHr:=0;
    decimal7_4  pct_nbm_change :=0;
	integer     nbm_change:=0;
	decimal7_4  nbm_change_pct_of_newHr:=0;
	decimal7_4  abs_nbm_change_pct_of_newHr:=0;
	integer     prod_cnt:=0;
	decimal7_4  nbm_pct_prod_cnt:=0;
end;

report_init := project(curr_nbm,transform(r_report,
                     self.src:=left.src,
                     self.src_desc:=left.src_desc,
                     self.nbm_cnt:=left.count_,
                     self:=left											));

report_with_prevNbm := join(report_init,prev_nbm,LEFT.src=RIGHT.src
															,transform(r_report,
                     self.prev_nbm_cnt:=RIGHT.count_,
                     self:=left											), LEFT OUTER);

report_with_newHr := join(report_with_prevNbm,curr_newHr,LEFT.src=RIGHT.src
															,transform(r_report,
                     self.newHr_cnt:=RIGHT.cnt,
                     self:=left											),keep(1), LEFT OUTER);

report_final0			:= join(report_with_newHr, prod_src,LEFT.src=RIGHT.src
															,transform(r_report,
                    self.prod_cnt					 := RIGHT.cnt;
                    temp_nbm_change 				 := LEFT.nbm_cnt-LEFT.prev_nbm_cnt;
                    self.pct_nbm_change              := LEFT.nbm_cnt/LEFT.prev_nbm_cnt*100;
                    self.nbm_change					 := temp_nbm_change;
                    self.nbm_pct_of_newHr 			 := LEFT.nbm_cnt/LEFT.newHr_cnt*100;
                    self.nbm_change_pct_of_newHr     := temp_nbm_change/LEFT.newHr_cnt*100;
                    self.abs_nbm_change_pct_of_newHr := abs(temp_nbm_change/LEFT.newHr_cnt*100);
                    self.nbm_pct_prod_cnt			 := LEFT.nbm_cnt/RIGHT.cnt*100;
                    self:=left											), LEFT OUTER);

report_final:=dedup(sort(report_final0,-abs_nbm_change_pct_of_newHr,-prod_cnt), except abs_nbm_change_pct_of_newHr, nbm_pct_prod_cnt,prod_cnt);

rj:= output(sort(report_final,-abs_nbm_change_pct_of_newHr),named('significant_change_report'));

s_c_rpt := wk_ut.get_DS_Result(workunit,'significant_change_report',r_report);

html := header.MAC_ConvertDS_to_HTML(s_c_rpt,src,src_desc,newHr_cnt,prev_nbm_cnt,nbm_cnt,nbm_pct_of_newHr,pct_nbm_change,nbm_change,nbm_change_pct_of_newHr,abs_nbm_change_pct_of_newHr,prod_cnt,nbm_pct_prod_cnt);
                                            
body       := regexreplace('<BODY>',html,'<BODY><P><u>Significant Change Report:</u></P>');
attachment := regexreplace('</BODY></HTML>',body,'</BR>');

wLink := 'http://prod_esp.br.seisint.com:8010/?Wuid='+workunit+'&Widget=WUDetailsWidget#/stub/Summary';

send_report := STD.System.Email.SendEmailAttachText(
				Header.email_list.BocaDevelopersEx,			            // recipientAddress
				'Header Ingest Stats Report',  	                        // subjectText
				'Please find report attached.'+
                '\n\nThis report was generated by:\n'+wLink,			// bodyText
				attachment, 				                            // attachment
				'text/html',				                            // fileMimeType
				'Header_Ingest_Stats_Report.html'
                );

return sequential(ra,rb,rc,rd,re,rf,rg,rh,ri,rj,send_report);

end;