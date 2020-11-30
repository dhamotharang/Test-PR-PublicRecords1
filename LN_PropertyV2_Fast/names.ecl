IMPORT data_services, doxie;

EXPORT names(STRING sFileVersion = doxie.Version_SuperKey):= MODULE
  SHARED STRING sPrefix           := Data_Services.Data_Location.Prefix('ln_propertyv2') + 'thor_data400::key::property_fast::';
  SHARED STRING sPrefix2          := IF (sFileVersion != '', sFileVersion + '::', '');
  SHARED string sPostfix          := IF (sFileVersion != '', '_' + sFileVersion, '');

  // Autokey
  EXPORT i_auto_addressb2         := sPrefix + 'autokey::addressb2' + sPostfix;
  EXPORT i_auto_address           := sPrefix + 'autokey::address' + sPostfix;
  EXPORT i_auto_citystnameb2      := sPrefix + 'autokey::citystnameb2' + sPostfix;
  EXPORT i_auto_citystname        := sPrefix + 'autokey::citystname' + sPostfix;
  EXPORT i_auto_fein2             := sPrefix + 'autokey::fein2' + sPostfix;
  EXPORT i_auto_nameb2            := sPrefix + 'autokey::nameb2' + sPostfix;
  EXPORT i_auto_namewords2        := sPrefix + 'autokey::namewords2' + sPostfix;
  EXPORT i_auto_name              := sPrefix + 'autokey::name' + sPostfix;
  EXPORT i_auto_payload           := sPrefix + 'autokey::payload' + sPostfix;
  EXPORT i_auto_phone2            := sPrefix + 'autokey::phone2' + sPostfix;
  EXPORT i_auto_phoneb2           := sPrefix + 'autokey::phoneb2' + sPostfix;
  EXPORT i_auto_ssn2              := sPrefix + 'autokey::ssn2' + sPostfix;
  EXPORT i_auto_stnameb2          := sPrefix + 'autokey::stnameb2' + sPostfix;
  EXPORT i_auto_stname            := sPrefix + 'autokey::stname' + sPostfix;
  EXPORT i_auto_zipb2             := sPrefix + 'autokey::zipb2' + sPostfix;
  EXPORT i_auto_zip               := sPrefix + 'autokey::zip' + sPostfix;
  // Non-fcra keys
  EXPORT i_addlfaresdeed_fid      := sPrefix + sPrefix2 + 'addlfaresdeed.fid';
  EXPORT i_addlfarestax_fid       := sPrefix + sPrefix2 + 'addlfarestax.fid';
  EXPORT i_addllegal_fid          := sPrefix + sPrefix2 + 'addllegal.fid';
  EXPORT i_addlnames_fid          := sPrefix + sPrefix2 + 'addlnames.fid';
  EXPORT i_assessor_fid           := sPrefix + sPrefix2 + 'assessor.fid';
  EXPORT i_assessor_parcelNum     := sPrefix + sPrefix2 + 'assessor.parcelNum';
  EXPORT i_deed_fid               := sPrefix + sPrefix2 + 'deed.fid';
  EXPORT i_deed_parcelNum         := sPrefix + sPrefix2 + 'deed.parcelNum';
  EXPORT i_deed_zip_loanamt       := sPrefix + sPrefix2 + 'deed.zip_loanamt';
  EXPORT i_search_did             := sPrefix + sPrefix2 + 'search.did';
  EXPORT i_search_bdid            := sPrefix + sPrefix2 + 'search.bdid';
  EXPORT i_search_fid             := sPrefix + sPrefix2 + 'search.fid';
  EXPORT i_search_fid_county      := sPrefix + sPrefix2 + 'search.fid_county';
  EXPORT i_addr_search_fid        := sPrefix + sPrefix2 + 'addr_search.fid';
  EXPORT i_search_linkids         := sPrefix + sPrefix2 + 'search.linkids';
  // Fcra keys
  EXPORT i_fcra_addr_full_v4      := sPrefix + 'fcra::' + sPrefix2 + 'addr.full_v4';
  EXPORT i_fcra_addr_search_fid   := sPrefix + 'fcra::' + sPrefix2 + 'addr_search.fid';
  EXPORT i_fcra_addllegal_fid     := sPrefix + 'fcra::' + sPrefix2 + 'addllegal.fid';
  EXPORT i_fcra_addlnames_fid     := sPrefix + 'fcra::' + sPrefix2 + 'addlnames.fid';
  EXPORT i_fcra_assessor_fid      := sPrefix + 'fcra::' + sPrefix2 + 'assessor.fid';
  EXPORT i_fcra_search_fid_county := sPrefix + 'fcra::' + sPrefix2 + 'search.fid_county';
  EXPORT i_fcra_deed_fid          := sPrefix + 'fcra::' + sPrefix2 + 'deed.fid';
  EXPORT i_fcra_search_did        := sPrefix + 'fcra::' + sPrefix2 + 'search.did';
  EXPORT i_fcra_search_fid        := sPrefix + 'fcra::' + sPrefix2 + 'search.fid';

END;
