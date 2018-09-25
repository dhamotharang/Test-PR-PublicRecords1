#OPTION('multiplePersistInstances',FALSE);
IMPORT header,wk_ut,ut;
// ****************************************************************************************** //

EXPORT header_get_wuid_results(filedate,res_name,out_rec,step) := FUNCTIONMACRO

				esp     := wk_ut._constants.ProdEsp;
				w_s	    :='W'+ut.date_math(workunit[2..9],-200)+'-000000';
				w_e		:='W'+ut.date_math(workunit[2..9], 1)+'-000000';

				job_name := CASE(step,
												'ingest' => 'Yogurt:'+filedate+' Header*Ingest*',
												'sync'   => 'Yogurt:'+filedate+' Header Sync;Rollup & Stats',
												'');
				
                // get wuid which should contain the results
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
		
				nbm  := project(raw_wuids(wuid not in ['W20171114-151039']), getFiles(LEFT));
				return normalize(nbm,LEFT.listout,transform(out_rec,SELF:=RIGHT));
								
endmacro;

// ****************************************************************************************** //
generateStats(string hVersion) := module

            shared r_d := dataset('~thor_data400::base::header_'+hVersion,header.Layout_Header_v2,flat);

            // ****************************************************************************************** //


            //sCount := dataset('~thor400_60::header_source_counts_new',{Header.Source_Counts_new},thor);

            src_rec := {string2 src, string2 extra, unsigned8 cnt, real8 pct};
            r_src := header_get_wuid_results(hVersion,'src',src_rec,'sync');

            header.stats._rec formatStats({r_src} L) := TRANSFORM

                SELF.version     := hVersion;
                SELF.variable    := 'Base.All.Source.Count.'+L.src;
                SELF.value       := L.cnt;

            END;

            shared src_stats := project(r_src,formatStats(LEFT));

            // ****************************************************************************************** //

            // should be sloted in Header.Header_Joined based on:
            // ta1 := sort(table(oNMNHR, r_nbm, src, few), -count_);
            r_nbm := {string2  src, string30 src_desc, unsigned count_};
            ta1 := header_get_wuid_results(hVersion,'no_basic_match_monthly',r_nbm,'ingest');

            header.stats._rec formatStats2({ta1} L) := TRANSFORM

                SELF.version     := hVersion;
                SELF.variable    := 'Ingest.No_Basic_Match.Source.Count.'+L.src;
                SELF.value       := L.count_;

            END;

            shared No_Basic_Match := project(ta1,formatStats2(LEFT));
            // No_Basic_Match:=ta1;
            // output(No_Basic_Match,named('No_Basic_Match'));
            // header.stats.add(No_Basic_match);

            // ****************************************************************************************** //


            statsRaw := header_get_wuid_results(hVersion,'STATS',ut.layout_stats_extend,'sync');

            header.stats._rec formatStats3({statsRaw} L) := TRANSFORM

                SELF.version     := hVersion;
                SELF.variable    := L.name;
                SELF.value       := L.value;

            END;
            shared base_stats := project(statsRaw,formatStats3(LEFT));

            // ****************************************************************************************** //
            rid_per_did_count := table(r_d,{did,cnt:=count(group)},did,merge);
            singletons := count(rid_per_did_count(cnt=1));
            non_singletons := count(rid_per_did_count(cnt>1));
            // output(singletons,named('singletons')):persist('~persist::stats::header::singletons');
            // output(non_singletons,named('non_singletons')):persist('~persist::stats::header::non_singletons');

            shared n_singletons := dataset([
                                     {hVersion,'Base.singletons.Count',singletons},
                                     {hVersion,'Base.non_singletons.Count',non_singletons}],header.stats._rec);


            // ****************************************************************************************** //
            ndbs_rec := {string2 src, unsigned8 cnt_};
            r_new_dids_by_source := header_get_wuid_results(hVersion,'new_dids_by_source',ndbs_rec,'sync');
            header.stats._rec formatStats4({r_new_dids_by_source} L) := TRANSFORM

                SELF.version     := hVersion;
                SELF.variable    := 'Base.new_dids_by_source.Source.Count.'+L.src;
                SELF.value       := L.cnt_;

            END;
            new_dids_by_source := project(r_new_dids_by_source,formatStats4(LEFT));
            // r_new_dids_by_source;
            // ****************************************************************************************** //

            // output(src,named('src'));
            // output(n_singletons,named('n_singletons'));
            // output(new_dids_by_source,named('new_dids_by_source'));
            shared hd_stats :=   src_stats             // (sync)
                        + base_stats            // (sync)
                        + new_dids_by_source;   // (sync)

            export onbm := output(dedup(No_Basic_Match,record,all),named('no_basic_match'), all);
            export onts := output(dedup(sort(hd_stats,-value),except value,all)      ,named('hd_stats'      ), all);
            export otsg := output(n_singletons  ,named('n_singletons'  ), all);

            export add_ingest_stats := sequential( onbm, header.stats.add( No_Basic_Match,'1' ));
            export add_nothor       := sequential( onts, header.stats.add( hd_stats      ,'2' ));
            export add_thor         := sequential( otsg, header.stats.add( n_singletons  ,'3' ));

end;

// ****************************************************************************************** //
// RUNS: (on p_svc_person_header or gmarcan_prod because header.stats is sandboxed)

hVersion := '20180821' ;//regexfind('[1-2][0-9]{3}[0-1][0-9][0-3][0-9][a-z]?'
                                    //,fileservices.SuperFileContents('~thor_data400::base::header')[1].name,0);

// output(hVersion,named('hVersion'));
// CHECK hVersion (above) < -- !!! *** READ THIS BEFORE RUNNING !!!
// NB: DO NOT UPDATE STATS FILE IF PREVIOUS VERSION NOT FULLY UPDATED (IE ALL 3 RUNS DONE)

// generateStats(hVersion).onbm; // NOTHOR (ingest)     // TEST add_ingest_stats
// generateStats(hVersion).onts; // NOTHOR (synced)     // TEST sync stats
// generateStats(hVersion).otsg; // YES THOR (syned)    // TEST singeleton

// generateStats(hVersion).add_ingest_stats; // (run on hthor / NOTHOR)
// generateStats(hVersion).add_nothor;      // (run on hthor / NOTHOR)
// generateStats(hVersion).add_thor;        // (run on thor)

// ****************************************************************************************** //
// W:\Projects\Header\15-05a_BuildAssistScripts\header_stat_export.ecl
//
// Previous Runs (Only include actual file update, NOT TEST/Export to stats run):
// -------------------------------------------------------------------------------
/*

YYYYMMDD
Singlerons
Sync stats
Ingest
20180423

20180724(run at the end of cycle post linking)
W20180823-101813 //add_ingest_stats
W20180823-101847 //add_nothor
W20180823-101920 //add_thor

20180626
W20180717-133420
W20180717-133454
W20180717-133558

20180522
W20180625-110653
W20180625-110745
W20180625-112254

http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180426-082232#/stub/Summary

20180320
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180420-084041#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180420-083949#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180406-083642#/stub/Summary


// ****************************************************************************************** //
version |Ingest           |Sync stats      |Singletons
20180221|W20180320-154906 |W20180320-155236|W20180320-155311
20180130|20180307-121910_3|
20171227|W20180205-112714|W20180205-112732|W20180205-112923
20171121|W20180104-110524|W20180104-110608|W20180104-110627

// */ 
// OLD STATS FORMAT
// +------------------+----------------+----------------+--------+
// |INGEST STATS      | hd_stats       |      otsg      |YYYYMMDD|
// +------------------+----------------+----------------+--------+
// |W20171129-132128  |W20171129-132141|W20171129-132154|20171025|
// +------------------+----------------+----------------+--------+
// |W20171019-123646  |W20171019-123732|W20171019-123845|20170925|
// +------------------+----------------+----------------+--------+
// +------------------+----------------+----------------+--------+
// |W20170727-131129  |W20170906-091618|W20170906-091712|20170725|
// +------------------+----------------+----------------+--------+
// |W20170727-131315  |W20170727-131416|W20170727-131535|20170628|
// +------------------+----------------+----------------+--------+
// |W20170718-113515  |W20170718-113539|W20170718-113610|20170522|
// +------------------+----------------+----------------+--------+
// |W20170508-110024  |20170430|
// +------------------+----------------+----------------+--------+
// |W20170323-143122  |W20170501-155507|W20170501-155541|20170321|
// +------------------+----------------+----------------+--------+
// |W20170309-125535  |W20170322-123412|W20170322-123613|20170223|
// +------------------+----------------+----------------+--------+
// |W20170126-122154  |W20170222-102321|W20170222-114922|20170123|
// +------------------+----------------+----------------+--------+
// |W20170103-140649  |W20170110-110628|W20170110-111032|20161220|
// +------------------+----------------+----------------+--------+
// |W20161128-141515-4|W20161212-134123|W20161212-142905|20161122|
// +------------------+----------------+----------------+--------+

