IMPORT data_services, doxie;

STRING k_prefix := data_services.data_location.prefix('foreclosure') + 'thor_Data400::key';

EXPORT names(string file_version = doxie.Version_SuperKey) := MODULE
  EXPORT i_foreclosure_delta_rid := k_prefix + '::foreclosure::' + file_version + '::delta_rid';
  EXPORT i_normalized_delta_rid := k_prefix + '::foreclosure_normalized::' + file_version + '::delta_rid';
  EXPORT i_foreclosure_did := k_prefix + '::foreclosures_did_' + file_version;
  EXPORT i_foreclosure_linkids := k_prefix+'::foreclosure::'+file_version+'::linkids';
  EXPORT i_foreclosure_parcelnum := k_prefix + '::foreclosure_parcelNum_' + file_version;
  EXPORT i_foreclosure_addr := k_prefix + '::foreclosure_address_' + file_version;
  EXPORT i_foreclosure_bdid := k_prefix + '::foreclosure_bdid_' + file_version;
  EXPORT i_foreclosure_fid_linkid := k_prefix + '::foreclosure_fid::Linkids_' + file_version;
  EXPORT i_foreclosure_fid := k_prefix + '::foreclosure_fid_' + file_version;
  EXPORT i_nod_did := k_prefix + '::nod::' + file_version + '::did';
  EXPORT i_nod_bdid := k_prefix + '::nod::' + file_version + '::bdid';
  EXPORT i_nod_linkids := k_prefix + '::nod::' + file_version + '::linkids';
  EXPORT i_nod_fid := k_prefix + '::nod::' + file_version + '::fid';
  EXPORT i_nod_fid_linkids := k_prefix + '::nod::' + file_version + '::fid::linkids';
END;
