// #workunit('name','HeaderIngestSetup');
IMPORT wk_ut,STD,dops,ut,_control,Header;

EXPORT BWR_IngestSetup(string emailList, boolean skip_action=true) := FUNCTION

ingest_action := if(skip_action, 'After Ingest - ', 'Before Ingest - ');

// Converts the date from 'M?/D?/YYYY H?:M?:S? AM/PM' to ISO8601
toIso8601(string tf1) := function

            rPattern := '^([0-9]{1,2})\\/([0-9]{1,2})\\/([0-9]{4}) ([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2}) (AM|PM)$';
            
            yyyy := regexfind(rPattern,tf1,3);
            _m   := regexfind(rPattern,tf1,1);
            mm   := if(length(_m)=1,'0','')+_m;
            _d   := regexfind(rPattern,tf1,2);
            dd   := if(length(_d)=1,'0','')+_d;

            ap   := regexfind(rPattern,tf1,7);
            _h   := regexfind(rPattern,tf1,4);
            H_   := (string)(if(ap='PM',12,0)+((unsigned)_h));
            HH   := if(length(H_)=1,'0','')+H_;
            M_   := regexfind(rPattern,tf1,5);
            MN   := if(length(M_)=1,'0','')+M_;
            S_   := regexfind(rPattern,tf1,6);
            SS   := if(length(S_)=1,'0','')+S_;

            return yyyy+'-'+mm+'-'+dd+'T'+HH+':'+MN+':'+SS+'Z';

end;
recReport := record
        
            string superfilename;
            string logical_file_name;
            string pre_reset_header_building;
            string roxie_package_name;
            string current_prod_roxie_version;
            string current_prod_roxie_cert_deployment_datetime;
            string _wuid;
            string base_file_time_stamp;
         
 end;
// Checks if the deployment to CERT datetime of pck in PROD is before the modified timestamp of the logical file in the superfile
isNewerOrProdCertDeployAFTERfileWuidBuildEnd(string roxie_package_name, string superfilename,
                                             string buildingSuperfilename, string clstr) := function 
        pn0 := regexreplace('_F',roxie_package_name,'');
        pn1 := regexreplace('_G',pn0,'');
        pn := regexreplace('_D',pn1,'');
        current_prod_roxie_version := dops.GetBuildVersion(pn,'B',clstr,'P');
        current_prod_roxie_cert_deployment_datetime0 := 
            dops.GetReleaseHistory('B',clstr,pn)(certversion=current_prod_roxie_version)[1].certwhenupdated;

        current_prod_roxie_cert_deployment_datetime := toIso8601(current_prod_roxie_cert_deployment_datetime0);

        logical_file_name := '~'+nothor(fileservices.SuperFileContents(superfilename)[1].name);
        hdr_ingst_building_content := '~'+nothor(fileservices.SuperFileContents(buildingSuperfilename)[1].name);
        
        _wuid := nothor(when(STD.File.GetLogicalFileAttribute(logical_file_name,'workunit'),
                      output(dataset([{superfilename,logical_file_name}],{string sf, string f1}),named(ingest_action + 'f1'),extend),before));
        wuidTimeStamp := STD.System.Workunit.WorkunitTimeStamps(_wuid);
        
        // This is too much. For example, if the wuid gets stuck for a long time after the keys are built.
        // Example: W20170418-141152
        file_wuid_complete_datetime := max(wuidTimeStamp,time);

        // So we use this instead:
        base_file_time_stamp := nothor(if(logical_file_name='~','0',
                                    when(STD.File.GetLogicalFileAttribute(logical_file_name,'modified'),
                                     output(dataset([{superfilename,logical_file_name}],{string sf, string f2}),named(ingest_action + 'f2'),extend),before)
                                   ));

        ds := dataset([{superfilename,logical_file_name,hdr_ingst_building_content,roxie_package_name,current_prod_roxie_version+'<<',
                                  current_prod_roxie_cert_deployment_datetime,_wuid, base_file_time_stamp}],
                        recReport);
        repNotInProd := if(logical_file_name<>'~',output(ds,named(ingest_action + 'input_did_NOT_make_prod_yet'),extend));
        repYesInProd := if(logical_file_name<>'~',output(ds,named(ingest_action + 'inputs_made_it_to_prod'),extend));
        LikelyInProd :=(base_file_time_stamp<current_prod_roxie_cert_deployment_datetime);
        currentFileTm:=nothor(STD.File.GetLogicalFileAttribute(hdr_ingst_building_content,'modified'));
        possbleFileTm:=nothor(STD.File.GetLogicalFileAttribute(logical_file_name,'modified'));
        Newer        := possbleFileTm>currentFileTm;
        return  when(Newer and LikelyInProd,
                      if(LikelyInProd,repYesInProd,repNotInProd)
                     );

end;

// Restores the wuid that created the logical file in the given base file
lgn(string sp_name) := '~'+nothor(fileservices.SuperFileContents(sp_name)[1].name);
_wuid(string sp_name) := nothor(STD.File.GetLogicalFileAttribute(lgn(sp_name),'workunit'));
restoreWuid(string sp_name) := output(wk_ut.Restore_Workunit(_wuid(sp_name)),named(ingest_action + 'wuids_restore'),extend);

// Reusable call to check packages vs. base file dates
ck(string pk, string buildingSuperfilename, string sp_name, string clstr='N') := dataset([{pk,sp_name,
                            if(isNewerOrProdCertDeployAFTERfileWuidBuildEnd(pk,sp_name,buildingSuperfilename,clstr),true,false)}],
                                        {string pk, string sp_name, boolean input_will_update});

restore := 
sequential(

restoreWuid('~thor_200::base::dl2::drvlic_aid'),
restoreWuid('~thor_data400::base::emerges_hunt_vote_ccw'),
restoreWuid('~thor_data400::base::atf_firearms_explosives'),
restoreWuid('~thor_data400::base::prof_licenses_AID'),
restoreWuid( '~thor_data400::base::did_death_masterV2_SSA'),
restoreWuid('~thor_data400::BASE::foreclosure'),
restoreWuid('~thor_data400::base::faa_airmen_BUILT'),
restoreWuid('~thor_data400::base::watercraft_search'),
restoreWuid('~thor_data400::base::dea'),
restoreWuid('~thor_data400::base::ln_propertyv2::search'),
restoreWuid('~thor_data400::base::american_student_list'),
restoreWuid('~thor_data400::Base::Voters_Reg'),
restoreWuid('~thor_data400::base::vehiclev2::party'),
restoreWuid('~thor_data400::base::certegy'),
restoreWuid('~thor_data400::base::sex_offender_mainpublic'),
restoreWuid('~thor_data400::base::consumer_targus')
);

report := 
ck('DLV2Keys'           ,'~thor_data400::BASE::dl2::DLHeader_Building'           ,'~thor_200::base::dl2::drvlic_aid')+
ck('DLV2Keys_F'          ,'~thor_data400::BASE::dl2::DLHeader_Building'           ,'~thor_200::base::dl2::drvlic_aid_father')+
// ck('DLV2Keys_D'          ,'~thor_data400::BASE::dl2::DLHeader_Building'           ,'~thor_200::base::dl2::drvlic_aid_delete')+
ck('EmergesKeys'        ,'~thor_data400::base::emergesHeader_Building'           ,'~thor_data400::base::emerges_hunt_vote_ccw')+
ck('ATFKeys'            ,'~thor_data400::BASE::atfHeader_Building'               ,'~thor_data400::base::atf_firearms_explosives')+
ck('ProfLicKeys'        ,'~thor_data400::Base::ProfLicHeader_Building'           ,'~thor_data400::base::prof_licenses_AID')+
ck('FCRA_ProfLicKeys'   ,'~thor_data400::Base::ProfLicHeader_Building'           ,'~thor_data400::base::prof_licenses_AID','F')+
ck('DeathMasterKeys'    ,'~thor_data400::Base::DeathHeader_Building'             ,'~thor_data400::base::did_death_masterV2_SSA')+
ck('DeathMasterKeys_F'  ,'~thor_data400::Base::DeathHeader_Building'             ,'~thor_data400::base::did_death_masterv2_ssa_father')+
ck('DeathMasterKeys_G'  ,'~thor_data400::Base::DeathHeader_Building'             ,'~thor_data400::base::did_death_masterv2_ssa_grandfather')+
// ck('DeathMasterKeys_D'  ,'~thor_data400::Base::DeathHeader_Building'             ,'~thor_data400::base::did_death_masterv2_ssa_delete')+
ck('ForeclosureKeys'    ,'~thor_data400::Base::ForeclosureHeader_Building'       ,'~thor_data400::BASE::foreclosure')+
ck('FAAKeys'            ,'~thor_data400::Base::AirmenHeader_Building'            ,'~thor_data400::base::faa_airmen_BUILT')+
ck('WatercraftKeys'     ,'~thor_data400::Base::WatercraftSrchHeader_Building'    ,'~thor_data400::base::watercraft_search')+
ck('DEAKeys'            ,'~thor_data400::Base::DeaHeader_Building'               ,'~thor_data400::base::dea')+
ck('DEAKeys_F'          ,'~thor_data400::Base::DeaHeader_Building'               ,'~thor_data400::base::dea_father')+
// ck('DEAKeys_D'          ,'~thor_data400::Base::DeaHeader_Building'               ,'~thor_data400::base::dea_delete')+
ck('LNPropertyV2Keys'   ,'~thor_data400::BASE::LN_PropV2SrchHeader_Building'     ,'~thor_data400::base::ln_propertyv2::search','B')+
ck('AmericanstudentKeys','~thor_data400::Base::ASLHeader_Building'               ,'~thor_data400::base::american_student_list')+
ck('OKC_SL_dumy_use_asl','~thor_data400::Base::OKC_SLHeader_Building'            ,'~thor_data400::base::okc_student_list')+
ck('VotersV2Keys'       ,'~thor_data400::BASE::Voters_Header_Building'           ,'~thor_data400::Base::Voters_Reg')+
ck('VehicleV2Keys'      ,'~thor_data400::base::vehicles_v2_party_header_building','~thor_data400::base::vehiclev2::party')+
ck('VehicleV2Keys_F'    ,'~thor_data400::base::vehicles_v2_party_header_building','~thor_data400::base::vehiclev2::party_father')+
// ck('VehicleV2Keys_D'    ,'~thor_data400::base::vehicles_v2_party_header_building','~thor_data400::base::vehiclev2::party_delete')+
ck('CertegyKeys'        ,'~thor_data400::base::certegyheader_building'           ,'~thor_data400::base::certegy')+
// ck('SexOffenderKeys'    ,'~thor_data400::base::sex_offender_mainpublic_building' ,'~thor_data400::base::sex_offender_mainpublic')+
ck('TargusKeys'         ,'~thor_data400::base::consumer_targusHeader_Building'   ,'~thor_data400::base::consumer_targus') +
ck('TargusKeys_F'       ,'~thor_data400::base::consumer_targusHeader_Building'   ,'~thor_data400::base::consumer_targus_father') :independent;

// Add inputs we never should skip
report2 := project(report,transform({string pk, boolean update},SELF.pk:=LEFT.pk,SELF.update:=LEFT.input_will_update))
           +dataset([
                     
                     // {'FCRA_ProfLicKeys',true}, // 
																					// {'DLV2Keys',true}, // override (comment out chk above if using)
                     {'permanent_fund',true}, // Stale (always on)
                     {'liens'         ,true}, // Always on
                     {'bankruptcy'    ,true}, // Always on
                     {'experian'      ,true}, // Always on
                     {'MS'            ,true}, // Stale (always on)
                     {'utility'       ,true}, // Always on
                     {'gong'          ,true}, // Stale (always on)
                     {'Boat'          ,true}, // Stale (always on)
                     {'tucs'          ,true}, // Always on
                     {'transunion'    ,true}, // Always on
                     {'eq_hist'       ,true}, // Stale (always on)
                     {'alloymedia'    ,true}  // Stale (always on)
                     
                    ],{string pk, boolean update});

// *********************************************************************************************************
// Get wuid data for assessing build status

w_s	:='W'+ut.date_math(workunit[2..9],-40)+'-000000';
w_e		:='W'+ut.date_math(workunit[2..9], 2)+'-000000';
in_progress_states := ['unknown','submitted','compiling','compiled','blocked','running','wait','paused'];

QHwuidList  := nothor(wk_ut.get_WorkunitList(w_s,w_e,pJobname:='*Quick*'));
IngwuidList := nothor(wk_ut.get_WorkunitList(w_s,w_e,pJobname:='*HeaderIngestSetup*'));
RawWuidList := nothor(wk_ut.get_WorkunitList(w_s,w_e,pJobname:='*Header Ingest*'));
ExlWuidList := nothor(wk_ut.get_WorkunitList(w_s,w_e,pJobname:='*XADL keys and externals base files*'));

ActiveQHwuidList := QHwuidList(state in in_progress_states);
ActiveIngWidList := IngwuidList(state in in_progress_states);
ActiveRawWidList := RawWuidList(state in in_progress_states);
RecentPlWidListA := sort(ExlWuidList, -wuid);
RecentPlWidListC := sort(ExlWuidList(state = 'completed'), -wuid);

more_ingest_is_not_running := ( count (ActiveIngWidList) = 1);
quick_header_is_not_running := ( count(ActiveQHwuidList)=0) ;
raw_is_not_running := (count(ActiveRawWidList) = 0 );

wuidStart := RecentPlWidListA[1].wuid;
wuidCmplt := RecentPlWidListC[1].wuid;

most_recent_external_base_started := if( count(RecentPlWidListA) <1, '0', wuidStart );
most_recent_external_base_compltd := if( count(RecentPlWidListC) <1, '0', wuidCmplt );

// *********************************************************************************************************

report_condition_status := ORDERED(

output(QHwuidList,named(ingest_action + 'QHwuidList')),
output(IngwuidList,named(ingest_action + 'IngwuidList')),
output(RawWuidList,named(ingest_action + 'RawWuidList')),
output(ExlWuidList,named(ingest_action + 'ExlWuidList')),
output(RecentPlWidListA,named(ingest_action + 'RecentPlWidListA')),
output(RecentPlWidListC,named(ingest_action + 'RecentPlWidListC')),
output(quick_header_is_not_running,named(ingest_action + 'quick_header_is_not_running')),
// output(more_ingest_is_not_running,named(ingest_action + 'more_ingest_is_not_running')),
// output(raw_is_not_running,named(ingest_action + 'raw_is_not_running')),
output(most_recent_external_base_started,named(ingest_action + 'most_recent_external_base_started')),
output(most_recent_external_base_compltd,named(ingest_action + 'most_recent_external_base_compltd'))

);


// *********************************************************************************************************

most_recent_external_base_is_done := most_recent_external_base_started <= most_recent_external_base_compltd;

ok_to_run_update := (//quick_header_is_not_running AND 
                     more_ingest_is_not_running AND
                     raw_is_not_running //AND  most_recent_external_base_is_done
                    );

run_inputs_set := std.system.Email.sendemail(emailList,'PLEASE RUN',
                                                '#workunit(\'name\',\'Header_Input_Set\');\n'
                                               +'Header.Inputs_Set();');

no_update := project(wk_ut.get_DS_Result(workunit,ingest_action + 'input_did_NOT_make_prod_yet',recReport),
                     {LEFT.roxie_package_name,LEFT.current_prod_roxie_version,
                                              LEFT.pre_reset_header_building,LEFT.logical_file_name});

yes_update := project(wk_ut.get_DS_Result(workunit,ingest_action + 'inputs_made_it_to_prod',recReport),
                     {recordof(LEFT) AND NOT {LEFT.superfilename, LEFT._wuid}});

part1 := header.mac_convertDs.toHTML(no_update,roxie_package_name,current_prod_roxie_version,
                                              pre_reset_header_building,logical_file_name);

part2 := header.mac_convertDs.toHTML(yes_update,logical_file_name,pre_reset_header_building,
                                            roxie_package_name,current_prod_roxie_version,
                                            current_prod_roxie_cert_deployment_datetime,base_file_time_stamp);

part1a :=     regexreplace('<BODY>',part1,'<BODY><P><u>The following will NOT be updated:</u></P>');

attachment := 
              regexreplace('</BODY></HTML>',part1a,'</BR>')+'<P><u>The following WILL be updated:</u></P>'+
              regexreplace('<HTML>.*<BODY>',part2,'</BR>');

wLink := 'http://prod_esp.br.seisint.com:8010/?Wuid='+workunit+'&Widget=WUDetailsWidget#/stub/Summary';

send_report := STD.System.Email.SendEmailAttachText(
				emailList,			            // recipientAddress

				ingest_action + 'HeaderIngestSetup No Update Report',  	                // subjectText
				'Please find report attached.'+
                '\n\nRESET WILL RUN: YES'+
                '\n\nThis report was generated by:\n'+wLink,			// bodyText
				attachment, 				                            // attachment
				'text/html',				                            // fileMimeType
				'no_updates_status.html'  	                            // defaultFileName
);
action_setup := sequential(
                     Header.Inputs_Clear(report2)
                    ,run_inputs_set
                    ,output(ingest_action + 'Inputs have been cleared. Running Inputs_set')
                );
return
sequential(
             restore
            ,report_condition_status
            ,STD.System.Debug.Sleep (10000)
            ,output(report,named(ingest_action + 'auto_report'))
            ,output(report2,named(ingest_action + 'package_decision_report')) 
            ,if(~skip_action,action_setup)
            ,send_report
           );
           
// run on hthor (kicks input set on 44)
// See "build incremental header raw.ecl"

end;
