IMPORT DCA;

EXPORT Layouts := MODULE

  EXPORT contact_layout := RECORD
    string46 Name;
    string63 Title;
    string3 code;
    string5 exec_title;
    string20 exec_fname;
    string20 exec_mname;
    string20 exec_lname;
    string5 exec_name_suffix;
    string3 exec_score;
  END;

  EXPORT dca_bdid_rollup_layout := RECORD
    DCA.Layout_DCA_Base_slim;
    dataset(contact_layout) contacts := DATASET([], contact_layout);
  END;

END;
