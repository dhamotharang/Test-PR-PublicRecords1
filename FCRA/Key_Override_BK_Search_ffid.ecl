IMPORT fcra, Bankrupt, ut;

kf := dataset('~thor_data400::base::override::fcra::qa::bankrupt_search', fcra.Layout_Override_bk_search,flat);

// to keep flag_file_id as a first field.
layout_output := RECORD
  kf.flag_file_id;
  Bankrupt.Layout_BK_Search_v8;
END;

kf_output := PROJECT (kf, transform (layout_output, SELF := Left));

EXPORT Key_Override_BK_Search_ffid := index (kf_output, {flag_file_id}, {kf_output}, 
                       '~thor_data400::key::override::fcra::bankrupt_search::qa::ffid');

