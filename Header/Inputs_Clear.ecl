import std;
cleanSuper(string super_file_name) := sequential(

     // output(dataset([{super_file_name}],{string name}),named('will_clear'),extend)
     fileservices.RemoveOwnedSubFiles(super_file_name,true)
         ,fileservices.clearsuperfile(super_file_name)

);
good_to_update(dataset({string pk, boolean update}) b_stts):= if (count(b_stts)>0,b_stts[1].update,false);
updt_in(dataset({string pk, boolean update}) b_stts, string _pk, string sfh, string sfi):= map(

       good_to_update(b_stts(pk=_pk     )) => sequential(cleanSuper(sfh), std.file.addsuperfile  (sfh,sfi               ,,true)),
       good_to_update(b_stts(pk=_pk+'_F')) => sequential(cleanSuper(sfh), std.file.addsuperfile  (sfh,sfi+'_father'     ,,true)),
       good_to_update(b_stts(pk=_pk+'_G')) => sequential(cleanSuper(sfh), std.file.addsuperfile  (sfh,sfi+'_grandfather',,true)),
       good_to_update(b_stts(pk=_pk+'_D')) => sequential(cleanSuper(sfh), std.file.addsuperfile  (sfh,sfi+'_delete'     ,,true))
       );

export Inputs_Clear(dataset({string pk, boolean update}) base_status

) := sequential(

updt_in(base_status,'DLV2Keys','~thor_data400::BASE::dl2::DLHeader_Building','~thor_200::base::dl2::drvlic_aid')
,if(base_status(pk='EmergesKeys')[1].update,cleanSuper('~thor_data400::base::emergesHeader_Building'))
,if(base_status(pk='permanent_fund')[1].update,cleanSuper('~thor_data400::Base::AKHeader_Building'))
,if(base_status(pk='permanent_fund')[1].update,cleanSuper('~thor_data400::Base::AKPEHeader_Building'))
,if(base_status(pk='ATFKeys')[1].update,cleanSuper('~thor_data400::BASE::atfHeader_Building'))
,if(base_status(pk='ProfLicKeys')[1].update,cleanSuper('~thor_data400::Base::ProfLicHeader_Building'))
,if(base_status(pk='MS')[1].update,cleanSuper('~thor_data400::Base::MSHeader_Building'))                              // STALE
,if(base_status(pk='liens')[1].update,cleanSuper('~thor_data400::base::LiensHeader_Building'))
,if(base_status(pk='liens')[1].update,cleanSuper('~thor_data400::base::LiensV2_mainHeader_Building'))
,if(base_status(pk='liens')[1].update,cleanSuper('~thor_data400::base::LiensV2_partyHeader_Building'))
,if(base_status(pk='utility')[1].update,cleanSuper('~thor_data400::Base::UtilityHeader_Building'))
,if(base_status(pk='bankruptcy')[1].update,cleanSuper('~thor_data400::Base::BKSrcHeader_Building'))
,if(base_status(pk='bankruptcy')[1].update,cleanSuper('~thor_data400::Base::BkMnHeader_Building'))
,if(base_status(pk='LNPropertyV2Keys')[1].update,cleanSuper('~thor_data400::BASE::LN_PropV2DeedHeader_Building'))
,if(base_status(pk='LNPropertyV2Keys')[1].update,cleanSuper('~thor_data400::BASE::LN_PropV2AssessHeader_Building'))
,if(base_status(pk='LNPropertyV2Keys')[1].update,cleanSuper('~thor_data400::BASE::LN_PropV2SrchHeader_Building'))
,if(base_status(pk='LNPropertyV2Keys')[1].update,cleanSuper('~thor_data400::BASE::LN_PropV2AddlDeedHeader_Building'))
,if(base_status(pk='LNPropertyV2Keys')[1].update,cleanSuper('~thor_data400::BASE::LN_PropV2AddlAssessHeader_Building'))
,updt_in(base_status,'DeathMasterKeys','~thor_data400::Base::DeathHeader_Building','~thor_data400::base::did_death_masterv2_ssa')
,if(base_status(pk='gong')[1].update,cleanSuper('~thor_data400::base::gongheader_building'))                            // STALE
,if(base_status(pk='ForeclosureKeys')[1].update,cleanSuper('~thor_data400::Base::ForeclosureHeader_Building'))
,if(base_status(pk='FAAKeys')[1].update,cleanSuper('~thor_data400::Base::AirmenHeader_Building'))
,if(base_status(pk='FAAKeys')[1].update,cleanSuper('~thor_data400::Base::AircraftHeader_Building'))
,if(base_status(pk='Boat')[1].update,cleanSuper('~thor_data400::Base::BoatHeader_Building'))                            // STALE
,if(base_status(pk='WatercraftKeys')[1].update,cleanSuper('~thor_data400::Base::WatercraftSrchHeader_Building'))
,if(base_status(pk='WatercraftKeys')[1].update,cleanSuper('~thor_data400::Base::WatercraftMainHeader_Building'))
,if(base_status(pk='WatercraftKeys')[1].update,cleanSuper('~thor_data400::Base::WatercraftCGHeader_Building'))
,updt_in(base_status,'DEAKeys','~thor_data400::Base::DeaHeader_Building'  ,'~thor_data400::base::dea')
,if(base_status(pk='AmericanstudentKeys')[1].update,cleanSuper('~thor_data400::Base::ASLHeader_Building'))
,if(base_status(pk='AmericanstudentKeys')[1].update,cleanSuper('~thor_data400::Base::OKC_SLHeader_Building'))
,if(base_status(pk='VotersV2Keys')[1].update,cleanSuper('~thor_data400::BASE::Voters_Header_Building'))
,updt_in(base_status,'VehicleV2Keys'  ,'~thor_data400::base::vehicles_v2_main_header_building','~thor_data400::base::vehiclev2::main')
,updt_in(base_status,'VehicleV2Keys'  ,'~thor_data400::base::vehicles_v2_party_header_building','~thor_data400::base::vehiclev2::party')
,if(base_status(pk='CertegyKeys')[1].update,cleanSuper('~thor_data400::base::certegyheader_building'))
,if(base_status(pk='tucs')[1].update,cleanSuper('~thor_data400::base::tucsheader_building'))                            // ALWAYS ON
,if(base_status(pk='experian')[1].update,cleanSuper('~thor_data400::base::Experianheader_building'))
,if(base_status(pk='experian')[1].update,cleanSuper('~thor_data400::base::Exprnphheader_building'))
,if(base_status(pk='SexOffenderKeys')[1].update,cleanSuper('~thor_data400::base::sex_offender_mainpublic_building'))
,if(base_status(pk='transunion')[1].update,cleanSuper('~thor_data400::base::transunioncredheader_building'),output('SKIPPING transunioncredheader_building'))
,if(base_status(pk='eq_hist')[1].update,cleanSuper('~thor_data400::base::eq_histHeader_building'))                         // STALE
,if(base_status(pk='alloymedia')[1].update,cleanSuper('~thor_data400::base::alloymedia_student_list_Header_Building'))        // STALE
,if(base_status(pk='cd_seed')[1].update, cleanSuper('~thor_data::base::cd_seed_building'))        // always clear cd_seed building sf
,updt_in(base_status,'TargusKeys'  ,'~thor_data400::base::consumer_targusHeader_Building','~thor_data400::base::consumer_targus')
              
);