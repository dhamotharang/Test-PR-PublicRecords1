IMPORT ut;

kf := FCRA.Convert_Liens_Party_Func;

EXPORT key_Override_liensv2_party_ffid := index (kf, {flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::liensV2_party::qa::ffid', OPT);
