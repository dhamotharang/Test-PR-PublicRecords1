IMPORT ut, LiensV2;

//DF-28168 - filter out records with blank flag_file_id
kf := dedup(sort(distribute(dataset('~thor_data400::base::override::fcra::qa::liensv2_main',FCRA.Layout_Override_Liensv2_main,xml('lien_main/row'),opt),hash(tmsid)),tmsid,rmsid,-flag_file_id,local),except flag_file_id,keep(1),local)
      (flag_file_id<>'');

// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::liensv2_main::qa::ffid
ut.MAC_CLEAR_FIELDS(kf, kf_cleared, LiensV2.Constants.fields_to_clear_main_id_fcra);

EXPORT key_Override_liensv2_main_ffid := index (kf_cleared, {flag_file_id}, {kf_cleared},
  '~thor_data400::key::override::fcra::liensV2_main::qa::ffid', OPT);
