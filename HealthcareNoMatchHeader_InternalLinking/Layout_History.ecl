EXPORT  Layout_History  :=  RECORD
  UNSIGNED8 rid;
  UNSIGNED8 nomatchId_before;
  UNSIGNED8 nomatchId_after;
  UNSIGNED8 lexid_before;
  UNSIGNED8 lexid_after;
  STRING50  crk_before;
  STRING50  crk_after;
  UNSIGNED8 change_timestamp;
  STRING    event_id;         //  (for tie in to the separate file keyed by this and the reported date)
END;
