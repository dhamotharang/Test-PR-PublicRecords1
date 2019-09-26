IMPORT ut, LiensV2;

//kf := FCRA.Convert_Liens_Party_Func;
kf := dedup(sort(distribute(dataset('~thor_data400::base::override::fcra::qa::liensv2_party',FCRA.Layout_Override_Liensv2_party,xml('lien_party/row'),opt),hash(tmsid)),tmsid,rmsid,-flag_file_id,local),except flag_file_id,keep(1),local);

//DF-22458 - Deprecate speicified in thor_data400::key::override::fcra::liensv2_party::qa::ffid
ut.MAC_CLEAR_FIELDS(kf, kf_cleared, LiensV2.Constants.fields_to_clear_party_id_fcra);

EXPORT key_Override_liensv2_party_ffid := index (kf_cleared, {flag_file_id}, {kf_cleared},
  '~thor_data400::key::override::fcra::liensV2_party::qa::ffid', OPT);
