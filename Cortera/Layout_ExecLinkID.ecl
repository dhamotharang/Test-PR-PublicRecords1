EXPORT Layout_ExecLinkID := RECORD
  INTEGER4 link_id;
  UNSIGNED8 persistent_record_id;
  UNSIGNED6 did;
  INTEGER3 did_score;
  INTEGER1 name_sequence;
  STRING5 title;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  STRING5 name_suffix;
  STRING1 ln_entity_type;
  UNSIGNED8 record_sid;
  UNSIGNED4 global_sid;
  STRING executive_name;
  STRING executive_title;
END;