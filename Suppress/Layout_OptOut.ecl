EXPORT Layout_OptOut := RECORD
  UNSIGNED8         lexid;
  UNSIGNED8         exemptions;
  STRING10          act_id;
  STRING8           date_added;
  SET OF UNSIGNED4  global_sids;
END;