export Layout_Redefine_HHID := record
  unsigned4 first_current := 0;
  unsigned4 last_current  := 0;
  unsigned6 did;
  unsigned6 rid;
  data10    addr_id;
  //qstring20 lname; => Has to do w/ not being able to join a string to a qstring on distributed datasets
  string20  lname;
  unsigned4 oc_size       := 0;
  unsigned4 lname_weight  := 0;
  unsigned6 hhid          := 0;
  unsigned6 hhid_indiv    := 0;
  unsigned6 hhid_relat    := 0;
end;