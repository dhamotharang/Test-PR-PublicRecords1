export Inputs_Clear(boolean incremental=FALSE) := sequential(
fileservices.RemoveOwnedSubFiles('~thor_data400::BASE::dl2::DLHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::emergesHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::AKHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::AKPEHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::BASE::atfHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::ProfLicHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::MSHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::LiensHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::LiensV2_mainHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::LiensV2_partyHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::UtilityHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::BKSrcHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::BkMnHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::BASE::LN_PropV2DeedHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::BASE::LN_PropV2AssessHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::BASE::LN_PropV2SrchHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::DeathHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::gongheader_building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::ForeclosureHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::AirmenHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::AircraftHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::BoatHeader_Building') // not being built anymore but data still being used
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::WatercraftSrchHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::WatercraftMainHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::WatercraftCGHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::DeaHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::Base::ASLHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::BASE::LN_PropV2AddlDeedHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::BASE::LN_PropV2AddlAssessHeader_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::BASE::Voters_Header_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::vehicles_v2_main_header_building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::vehicles_v2_party_header_building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::certegyheader_building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::tucsheader_building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::Experianheader_building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::Exprnphheader_building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::sex_offender_mainpublic_building',true)
,if(~incremental
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::transunioncredheader_building',true)            )
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::eq_histHeader_building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::alloymedia_student_list_Header_Building',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::consumer_targusHeader_Building',true)

,fileservices.clearsuperfile('~thor_data400::BASE::dl2::DLHeader_Building')
,fileservices.clearsuperfile('~thor_data400::base::emergesHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::AKHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::AKPEHeader_Building')
,fileservices.clearsuperfile('~thor_data400::BASE::atfHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::ProfLicHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::MSHeader_Building')
,fileservices.clearsuperfile('~thor_data400::base::LiensHeader_Building')
,fileservices.clearsuperfile('~thor_data400::base::LiensV2_mainHeader_Building')
,fileservices.clearsuperfile('~thor_data400::base::LiensV2_partyHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::UtilityHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::BKSrcHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::BkMnHeader_Building')
,fileservices.clearsuperfile('~thor_data400::BASE::LN_PropV2DeedHeader_Building')
,fileservices.clearsuperfile('~thor_data400::BASE::LN_PropV2AssessHeader_Building')
,fileservices.clearsuperfile('~thor_data400::BASE::LN_PropV2SrchHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::DeathHeader_Building')
,fileservices.clearsuperfile('~thor_data400::base::gongheader_building')
,fileservices.clearsuperfile('~thor_data400::Base::ForeclosureHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::AirmenHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::AircraftHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::BoatHeader_Building') // not being built anymore but data still being used
,fileservices.clearsuperfile('~thor_data400::Base::WatercraftSrchHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::WatercraftMainHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::WatercraftCGHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::DeaHeader_Building')
,fileservices.clearsuperfile('~thor_data400::Base::ASLHeader_Building')
,fileservices.clearsuperfile('~thor_data400::BASE::LN_PropV2AddlDeedHeader_Building')
,fileservices.clearsuperfile('~thor_data400::BASE::LN_PropV2AddlAssessHeader_Building')
,fileservices.clearsuperfile('~thor_data400::BASE::Voters_Header_Building')
,fileservices.clearsuperfile('~thor_data400::base::vehicles_v2_main_header_building')
,fileservices.clearsuperfile('~thor_data400::base::vehicles_v2_party_header_building')
,fileservices.clearsuperfile('~thor_data400::base::certegyheader_building')
,fileservices.clearsuperfile('~thor_data400::base::tucsheader_building')
,fileservices.clearsuperfile('~thor_data400::base::Experianheader_building')
,fileservices.clearsuperfile('~thor_data400::base::Exprnphheader_building')
,fileservices.clearsuperfile('~thor_data400::base::sex_offender_mainpublic_building')
,if(~incremental
,fileservices.clearsuperfile('~thor_data400::base::transunioncredheader_building')            )
,fileservices.clearsuperfile('~thor_data400::base::eq_histHeader_building')
,fileservices.clearsuperfile('~thor_data400::base::alloymedia_student_list_Header_Building')
,fileservices.clearsuperfile('~thor_data400::base::consumer_targusHeader_Building')
);