﻿import STD;
d:=
dataset([
 {'~thor_data400::key::header::built::relatives_v3'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::base::insuranceheader::built::relatives_v3'}
,{'~thor_data400::key::insuranceheader::built::allpossiblessns'}
,{'~thor_data400::key::insuranceheader::built::did'}
,{'~thor_data400::key::insuranceheader::built::dln'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::base::insuranceheader::qa::relatives_v3'}
,{'~thor_data400::key::insuranceheader::qa::allpossiblessns'}
,{'~thor_data400::key::insuranceheader::qa::did'}
,{'~thor_data400::key::insuranceheader::qa::dln'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_44::key::insuranceheader_segmentation::built::did_ind'}
,{'~thor400_44::key::insuranceheader_xlink::built::did'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::address'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::dln'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::dob'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::dobf'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::lfz'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::name'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::ph'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::relative'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::ssn'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::ssn4'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::refs::zip_pr'}
,{'~thor400_44::key::insuranceheader_xlink::built::did::sup::rid'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::key::insuranceheader_segmentation::did_ind_qa'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::address'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::dobf'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::name'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::relative'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::sup::rid'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_44::key::insuranceheader_segmentation::did_ind_qa'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::address'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::dln'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::dob'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::dobf'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::lfz'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::name'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::ph'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::relative'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::ssn'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::ssn4'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::refs::zip_pr'}
,{'~thor400_44::key::insuranceheader_xlink::qa::did::sup::rid'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_36::key::insuranceheader_segmentation::did_ind_qa'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::address'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::dln'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::dob'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::dobf'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::lfz'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::name'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::ph'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::relative'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::ssn'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::ssn4'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::refs::zip_pr'}
,{'~thor400_36::key::insuranceheader_xlink::qa::did::sup::rid'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_44::key::insuranceheader_segmentation::father::did_ind'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::did'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::address'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::dln'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::dob'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::dobf'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::lfz'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::name'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::ph'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::relative'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::ssn'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::ssn4'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::refs::zip_pr'}
,{'~thor400_44::key::insuranceheader_xlink::father::did::sup::rid'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_44::BASE::HSS_Name_Dayob'}
,{'~thor400_44::BASE::HSS_Name_SSN'}
,{'~thor400_44::BASE::HSS_Name_Address'}
,{'~thor400_44::BASE::HSS_Name_phone'}
,{'~thor400_44::BASE::HSS_Name_Zip_Age_Ssn4'}
,{'~thor400_44::BASE::HSS_household'}
,{'~thor400_44::BASE::HSS_name_source'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_44::BASE::HSS_Name_Dayob_prod'}
,{'~thor400_44::BASE::HSS_Name_SSN_prod'}
,{'~thor400_44::BASE::HSS_Name_Address_prod'}
,{'~thor400_44::BASE::HSS_Name_phone_prod'}
,{'~thor400_44::BASE::HSS_Name_Zip_Age_Ssn4_prod'}
,{'~thor400_44::BASE::HSS_household_prod'}
,{'~thor400_44::BASE::HSS_name_source_prod'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_36::BASE::HSS_Name_Dayob'}
,{'~thor400_36::BASE::HSS_Name_SSN'}
,{'~thor400_36::BASE::HSS_Name_Address'}
,{'~thor400_36::BASE::HSS_Name_phone'}
,{'~thor400_36::BASE::HSS_Name_Zip_Age_Ssn4'}
,{'~thor400_36::BASE::HSS_household'}
,{'~thor400_36::BASE::HSS_name_source'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_36::BASE::HSS_Name_Dayob_prod'}
,{'~thor400_36::BASE::HSS_Name_SSN_prod'}
,{'~thor400_36::BASE::HSS_Name_Address_prod'}
,{'~thor400_36::BASE::HSS_Name_phone_prod'}
,{'~thor400_44::BASE::HSS_Name_Zip_Age_Ssn4_prod'}
,{'~thor400_44::BASE::HSS_household_prod'}
,{'~thor400_44::BASE::HSS_name_source_prod'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::base::header_raw_prod'}
,{'~thor_data400::base::header_raw'}
,{'~thor_data400::base::header_raw_built'}
,{'~thor_data400::base::header_raw_built1'}
,{'~thor_data400::base::header_raw_built2'}
,{'~thor_data400::base::header_raw_built3'}
,{'~thor_data400::base::header_raw_built4'}
,{'~thor_data400::base::header_raw_father'}
,{'~thor_data400::base::header_raw_grandfather'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::base::header_raw_syncd'}
,{'~thor_data400::base::header_raw_syncd_prod'}
,{'~thor_data400::base::header_raw_syncd_father'}
,{'~thor_data400::base::header_raw_syncd_grandfather'}
,{'~thor_data400::base::header_raw_syncd_built'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::base::header'}
,{'~thor_data400::base::header_prod'}
,{'~thor_data400::base::header_father'}
,{'~thor_data400::base::header_grandfather'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::base::did_ssn_glb'}
,{'~thor_data400::base::did_ssn_nonglb'}
,{'~thor_data400::base::did_ssn_nonUtil'}
,{'~thor_data400::base::did_ssn_nonglb_nonUtil'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::base::did_ssn_glb_prod'}
,{'~thor_data400::base::did_ssn_nonglb_prod'}
,{'~thor_data400::base::did_ssn_nonUtil_prod'}
,{'~thor_data400::base::did_ssn_nonglb_nonUtil_prod'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor_data400::key::insuranceheader_segmentation::did_ind_temp'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::address'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::dln'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::dob'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::dobf'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::lfz'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::name'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::ph'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::relative'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::ssn'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::ssn4'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::refs::zip_pr'}
,{'~thor_data400::key::insuranceheader_xlink::temp::did::sup::rid'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_44::key::insuranceheader_segmentation::did_ind_temp'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::address'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::dln'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::dob'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::dobf'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::lfz'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::name'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::ph'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::relative'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::ssn'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::ssn4'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::refs::zip_pr'}
,{'~thor400_44::key::insuranceheader_xlink::temp::did::sup::rid'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
,{'~thor400_36::key::insuranceheader_segmentation::did_ind_temp'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::address'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::dln'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::dob'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::dobf'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::lfz'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::name'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::ph'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::relative'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::ssn'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::ssn4'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::refs::zip_pr'}
,{'~thor400_36::key::insuranceheader_xlink::temp::did::sup::rid'}
,{'WWWWWWWWWWWWWWWWWWWWWWWWWWWW'}
],{string200 fn});


t:=table(d,{sfn:=trim(fn),lfn:=if(STD.File.fileexists(fn),STD.File.SuperFileContents(fn))});

EXPORT Verify_XADL1_base_files := nothor(t);