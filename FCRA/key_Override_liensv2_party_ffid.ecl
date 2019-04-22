IMPORT ut, LiensV2;

kf := FCRA.Convert_Liens_Party_Func;

//DF-22458 - Deprecate speicified in thor_data400::key::override::fcra::liensv2_party::qa::ffid
ut.MAC_CLEAR_FIELDS(kf, kf_cleared, LiensV2.Constants.fields_to_clear_party_id_fcra);

EXPORT key_Override_liensv2_party_ffid := index (kf_cleared, {flag_file_id}, {kf_cleared},
  '~thor_data400::key::override::fcra::liensV2_party::qa::ffid', OPT);
