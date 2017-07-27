import fcra, ut; 

base_file := dataset('~thor_data400::base::override::fcra::qa::ssn_table',FCRA.Layout_Override_SSN_Table,flat);

kf := dedup(sort(base_file,-flag_file_id),except flag_file_id,keep(1));

export Key_Override_SSN_Table_FFID := index(kf,{flag_file_id}, {kf},
  '~thor_data400::key::override::fcra::ssn_table::qa::ffid');