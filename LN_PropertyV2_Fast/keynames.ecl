IMPORT VersionControl, LN_PropertyV2, LN_PropertyV2_Fast, STD, tools;

EXPORT keynames(STRING sFileDate):= MODULE

  //logical file names for key build
  // Autokeys
  EXPORT i_auto_addressb2         := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::addressb2',sFileDate);
  EXPORT i_auto_address           := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::address',sFileDate);
  EXPORT i_auto_citystnameb2      := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::citystnameb2',sFileDate);
  EXPORT i_auto_citystname        := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::citystname',sFileDate);
  EXPORT i_auto_fein2             := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::fein2',sFileDate);
  EXPORT i_auto_nameb2            := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::nameb2',sFileDate);
  EXPORT i_auto_namewords2        := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::namewords2',sFileDate);
  EXPORT i_auto_name              := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::name',sFileDate);
  EXPORT i_auto_payload           := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::payload',sFileDate);
  EXPORT i_auto_phone2            := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::phone2',sFileDate);
  EXPORT i_auto_phoneb2           := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::phoneb2',sFileDate);
  EXPORT i_auto_ssn2              := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::ssn2',sFileDate);
  EXPORT i_auto_stnameb2          := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::stnameb2',sFileDate);
  EXPORT i_auto_stname            := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::stname',sFileDate);
  EXPORT i_auto_zipb2             := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::zipb2',sFileDate);
  EXPORT i_auto_zip               := LN_PropertyV2_Fast.fn_getSubKeyName('autokey::zip',sFileDate);
  // Non-fcra keys
  EXPORT i_addlfaresdeed_fid      := LN_PropertyV2_Fast.fn_getSubKeyName('addlfaresdeed.fid',sFileDate);
  EXPORT i_addlfarestax_fid       := LN_PropertyV2_Fast.fn_getSubKeyName('addlfarestax.fid',sFileDate);
  EXPORT i_addllegal_fid          := LN_PropertyV2_Fast.fn_getSubKeyName('addllegal.fid',sFileDate);
  EXPORT i_addlnames_fid          := LN_PropertyV2_Fast.fn_getSubKeyName('addlnames.fid',sFileDate);
  EXPORT i_assessor_fid           := LN_PropertyV2_Fast.fn_getSubKeyName('assessor.fid',sFileDate);
  EXPORT i_assessor_parcelNum     := LN_PropertyV2_Fast.fn_getSubKeyName('assessor.parcelNum',sFileDate);
  EXPORT i_deed_fid               := LN_PropertyV2_Fast.fn_getSubKeyName('deed.fid',sFileDate);
  EXPORT i_deed_parcelNum         := LN_PropertyV2_Fast.fn_getSubKeyName('deed.parcelNum',sFileDate);
  EXPORT i_deed_zip_loanamt       := LN_PropertyV2_Fast.fn_getSubKeyName('deed.zip_loanamt',sFileDate);
  EXPORT i_search_did             := LN_PropertyV2_Fast.fn_getSubKeyName('search.did',sFileDate);
  EXPORT i_search_bdid            := LN_PropertyV2_Fast.fn_getSubKeyName('search.bdid',sFileDate);
  EXPORT i_search_fid             := LN_PropertyV2_Fast.fn_getSubKeyName('search.fid',sFileDate);
  EXPORT i_search_fid_county      := LN_PropertyV2_Fast.fn_getSubKeyName('search.fid_county',sFileDate);
  EXPORT i_addr_search_fid        := LN_PropertyV2_Fast.fn_getSubKeyName('addr_search.fid',sFileDate);
  EXPORT i_search_linkids         := LN_PropertyV2_Fast.fn_getSubKeyName('search.linkids',sFileDate);
  // Fcra keys
  EXPORT i_fcra_addr_search_fid   := LN_PropertyV2_Fast.fn_getSubKeyName('addr_search.fid',sFileDate,'fcra::');
  EXPORT i_fcra_addllegal_fid     := LN_PropertyV2_Fast.fn_getSubKeyName('addllegal.fid',sFileDate,'fcra::');
  EXPORT i_fcra_addlnames_fid     := LN_PropertyV2_Fast.fn_getSubKeyName('addlnames.fid',sFileDate,'fcra::');
  EXPORT i_fcra_assessor_fid      := LN_PropertyV2_Fast.fn_getSubKeyName('assessor.fid',sFileDate,'fcra::');
  EXPORT i_fcra_search_fid_county := LN_PropertyV2_Fast.fn_getSubKeyName('search.fid_county',sFileDate,'fcra::');
  EXPORT i_fcra_deed_fid          := LN_PropertyV2_Fast.fn_getSubKeyName('deed.fid',sFileDate,'fcra::');
  EXPORT i_fcra_search_did        := LN_PropertyV2_Fast.fn_getSubKeyName('search.did',sFileDate,'fcra::');
  EXPORT i_fcra_search_fid        := LN_PropertyV2_Fast.fn_getSubKeyName('search.fid',sFileDate,'fcra::');

  //all key filename versions
  EXPORT auto_addressb2           := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_addressb2,sFileDate,i_auto_addressb2,2);
  EXPORT auto_address             := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_address,sFileDate,i_auto_address,2);
  EXPORT auto_citystnameb2        := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_citystnameb2,sFileDate,i_auto_citystnameb2,2);
  EXPORT auto_citystname          := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_citystname,sFileDate,i_auto_citystname,2);
  EXPORT auto_fein2               := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_fein2,sFileDate,i_auto_fein2,2);
  EXPORT auto_nameb2              := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_nameb2,sFileDate,i_auto_nameb2,2);
  EXPORT auto_namewords2          := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_namewords2,sFileDate,i_auto_namewords2,2);
  EXPORT auto_name                := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_name,sFileDate,i_auto_name,2);
  EXPORT auto_payload             := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_payload,sFileDate,i_auto_payload,2);
  EXPORT auto_phone2              := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_phone2,sFileDate,i_auto_phone2,2);
  EXPORT auto_phoneb2             := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_phoneb2,sFileDate,i_auto_phoneb2,2);
  EXPORT auto_ssn2                := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_ssn2,sFileDate,i_auto_ssn2,2);
  EXPORT auto_stnameb2            := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_stnameb2,sFileDate,i_auto_stnameb2,2);
  EXPORT auto_stname              := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_stname,sFileDate,i_auto_stname,2);
  EXPORT auto_zipb2               := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_zipb2,sFileDate,i_auto_zipb2,2);
  EXPORT auto_zip                 := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('').i_auto_zip,sFileDate,i_auto_zip,2);
  // Non-fcra keys
  EXPORT addlfaresdeed_fid        := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_addlfaresdeed_fid,sFileDate,i_addlfaresdeed_fid,2);
  EXPORT addlfarestax_fid         := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_addlfarestax_fid,sFileDate,i_addlfarestax_fid,2);
  EXPORT addllegal_fid            := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_addllegal_fid,sFileDate,i_addllegal_fid,2);
  EXPORT addlnames_fid            := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_addlnames_fid,sFileDate,i_addlnames_fid,2);
  EXPORT assessor_fid             := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_assessor_fid,sFileDate,i_assessor_fid,2);
  EXPORT assessor_parcelNum       := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_assessor_parcelNum,sFileDate,i_assessor_parcelNum,2);
  EXPORT deed_fid                 := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_deed_fid,sFileDate,i_deed_fid,2);
  EXPORT deed_parcelNum           := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_deed_parcelNum,sFileDate,i_deed_parcelNum,2);
  EXPORT deed_zip_loanamt         := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_deed_zip_loanamt,sFileDate,i_deed_zip_loanamt,2);
  EXPORT search_did               := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_search_did,sFileDate,i_search_did,2);
  EXPORT search_bdid              := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_search_bdid,sFileDate,i_search_bdid,2);
  EXPORT search_fid               := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_search_fid,sFileDate,i_search_fid,2);
  EXPORT search_fid_county        := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_search_fid_county,sFileDate,i_search_fid_county,2);
  EXPORT addr_search_fid          := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_addr_search_fid,sFileDate,i_addr_search_fid,2);
  EXPORT search_linkids           := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_search_linkids,sFileDate,i_search_linkids,2);
  // Fcra keys
  EXPORT fcra_addr_search_fid     := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_fcra_addr_search_fid,sFileDate,i_fcra_addr_search_fid,2);
  EXPORT fcra_addllegal_fid       := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_fcra_addllegal_fid,sFileDate,i_fcra_addllegal_fid,2);
  EXPORT fcra_addlnames_fid       := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_fcra_addlnames_fid,sFileDate,i_fcra_addlnames_fid,2);
  EXPORT fcra_assessor_fid        := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_fcra_assessor_fid,sFileDate,i_fcra_assessor_fid,2);
  EXPORT fcra_search_fid_county   := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_fcra_search_fid_county,sFileDate,i_fcra_search_fid_county,2);
  EXPORT fcra_deed_fid            := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_fcra_deed_fid,sFileDate,i_fcra_deed_fid,2);
  EXPORT fcra_search_did          := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_fcra_search_did,sFileDate,i_fcra_search_did,2);
  EXPORT fcra_search_fid          := VersionControl.mBuildFilenameVersions(LN_PropertyV2_Fast.names('@version@').i_fcra_search_fid,sFileDate,i_fcra_search_fid,2);

  EXPORT  dAll_filenames          :=
  auto_addressb2.dAll_filenames +
  auto_address.dAll_filenames +
  auto_citystnameb2.dAll_filenames +
  auto_citystname.dAll_filenames +
  auto_fein2.dAll_filenames +
  auto_nameb2.dAll_filenames +
  auto_namewords2.dAll_filenames +
  auto_name.dAll_filenames +
  auto_payload.dAll_filenames +
  auto_phone2.dAll_filenames +
  auto_phoneb2.dAll_filenames +
  auto_ssn2.dAll_filenames +
  auto_stnameb2.dAll_filenames +
  auto_stname.dAll_filenames +
  auto_zipb2.dAll_filenames +
  auto_zip.dAll_filenames +
  addlfaresdeed_fid.dAll_filenames +
  addlfarestax_fid.dAll_filenames +
  addllegal_fid.dAll_filenames +
  addlnames_fid.dAll_filenames +
  assessor_fid.dAll_filenames +
  assessor_parcelNum.dAll_filenames +
  deed_fid.dAll_filenames +
  deed_parcelNum.dAll_filenames +
  deed_zip_loanamt.dAll_filenames +
  search_did.dAll_filenames +
  search_bdid.dAll_filenames +
  search_fid.dAll_filenames +
  search_fid_county.dAll_filenames +
  addr_search_fid.dAll_filenames +
  search_linkids.dAll_filenames +
  fcra_addr_search_fid.dAll_filenames +
  fcra_addllegal_fid.dAll_filenames +
  fcra_addlnames_fid.dAll_filenames +
  fcra_assessor_fid.dAll_filenames +
  fcra_search_fid_county.dAll_filenames +
  fcra_deed_fid.dAll_filenames +
  fcra_search_did.dAll_filenames +
  fcra_search_fid.dAll_filenames;

END;  
