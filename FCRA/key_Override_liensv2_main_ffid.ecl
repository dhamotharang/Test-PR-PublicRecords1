IMPORT ut, LiensV2;

kf := fcra.Convert_Liens_Main_Func;

// DF-22458 Deprecate specified fields in thor_data400::key::override::fcra::liensv2_main::qa::ffid
ut.MAC_CLEAR_FIELDS(kf, kf_cleared, LiensV2.Constants.fields_to_clear_main_id_fcra);

EXPORT key_Override_liensv2_main_ffid := index (kf_cleared, {flag_file_id}, {kf_cleared},
  '~thor_data400::key::override::fcra::liensV2_main::qa::ffid', OPT);
