EXPORT mac_append_contacts(ds_in, ds_out, mod_access, append_contact) := MACRO
  IMPORT dx_cortera, Suppress, STD;

  #uniquename(contact_recs_all)
  %contact_recs_all% := JOIN(ds_in, dx_Cortera.Key_Executive_Link_Id, // Executive key should only have new records (adds) , as names are normalized from the same base record. Deletes are only applicable to base record.
    KEYED(LEFT.link_id = RIGHT.link_id AND LEFT.Persistent_record_id = RIGHT.Persistent_record_id),
    TRANSFORM(RIGHT),
    ATMOST(100));
  
  #uniquename(contact_recs_supp)  
  %contact_recs_supp% := Suppress.MAC_SuppressSource(%contact_recs_all%, mod_access);

  #uniquename(contact_recs)
  %contact_recs% := IF(append_contact, 
    PROJECT(SORT(%contact_recs_supp%, link_id, Persistent_record_id),dx_Cortera.Layouts.Layout_ExecLinkID), // to remove the _internal_fpos_ field from the layout
    DATASET([], dx_Cortera.Layouts.Layout_ExecLinkID));

  #uniquename(get_exec_name)
  %get_exec_name%(dx_Cortera.Layouts.Layout_ExecLinkID r) := 
    STD.STR.CleanSpaces(r.title + ' ' + r.fname + ' ' + r.mname + ' ' + r.lname + ' ' + r.name_suffix);

  ds_in xfm_add_contacts(ds_in l, DATASET(dx_Cortera.Layouts.Layout_ExecLinkID) r) := TRANSFORM
    SELF.executive_name1 :=  %get_exec_name%(r[1]);
    SELF.title1 := r[1].executive_title;
    SELF.executive_name2 :=  %get_exec_name%(r[2]);
    SELF.title2 := r[2].executive_title;
    SELF.executive_name3 :=  %get_exec_name%(r[3]);
    SELF.title3 := r[3].executive_title;
    SELF.executive_name4 :=  %get_exec_name%(r[4]);
    SELF.title4 := r[4].executive_title;
    SELF.executive_name5 :=  %get_exec_name%(r[5]);
    SELF.title5 := r[5].executive_title;
    SELF.executive_name6 :=  %get_exec_name%(r[6]);
    SELF.title6 := r[6].executive_title;
    SELF.executive_name7 :=  %get_exec_name%(r[7]);
    SELF.title7 := r[7].executive_title;
    SELF.executive_name8 :=  %get_exec_name%(r[8]);
    SELF.title8 := r[8].executive_title;
    SELF.executive_name9 :=  %get_exec_name%(r[9]);
    SELF.title9 := r[9].executive_title;
    SELF.executive_name10 := %get_exec_name%(r[10]);
    SELF.title10 := r[10].executive_title;
    SELF := l;
  END;
  
  #uniquename(ds_in_sort);
  %ds_in_sort% := SORT(ds_in, link_id, persistent_record_id);
  
  ds_out := DENORMALIZE(%ds_in_sort%, %contact_recs%,
    LEFT.link_id = RIGHT.link_id AND
    LEFT.persistent_record_id = RIGHT.persistent_record_id,
    GROUP,
    xfm_add_contacts(LEFT, ROWS(RIGHT)), NOSORT);
ENDMACRO;
