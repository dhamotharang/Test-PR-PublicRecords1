export MAC_AppendPatriot(infile, mod_access, did_field,fname_field,mname_field,lname_field,outfile,outids,create_layout='true') := macro
IMPORT dx_common, Suppress;

  #uniquename(new_rec);
  #if (create_layout)
  %new_rec% := record
    infile;
    patriot.layout_patriotappend;
  end;
  #else
    %new_rec% := infile;
  #end

  #uniquename(ap);
  %new_rec% %ap%(infile le,patriot.Key_Baddids ri) := transform
    self.number_with_same_name := ri.other_count;
    self.first_seen := ri.first_seen;
    self.relative_count := ri.rel_count;
    self.known := true;
    self.name_match := ri.did<>0;
    self := le;
  end;

  #uniquename(baddids_raw);
  %baddids_raw% := join(infile(did<>0), patriot.Key_Baddids, left.did_field = right.did, TRANSFORM(right));

  #uniquename(baddids_rolled);
  %baddids_rolled% := dx_common.Incrementals.mac_Rollup(%baddids_raw%);

  #uniquename(route_1);
  %route_1% := GROUP(join(infile(did<>0), %baddids_rolled%, left.did_field = right.did, %ap%(left,right), left outer), seq);

  #uniquename(nm);
  %new_rec% %nm%(infile le,patriot.key_badnames ri) := transform
    self.known := false;
    self.number_with_same_name := ri.cnt;
    self.name_match := false;
    self := le;
  end;

  #uniquename(badnames_raw);
  %badnames_raw% := join(infile(did=0), patriot.key_badnames,
    left.fname_field=right.fname and
    left.mname_field=right.mname and
    left.lname_field=right.lname,
    TRANSFORM(RIGHT));

  #uniquename(badnames_rolled);
  %badnames_rolled% := dx_common.Incrementals.mac_Rollup(%badnames_raw%);

  #uniquename(pre_route_2)
  %pre_route_2% := join(infile(did=0), %badnames_rolled%,
    left.fname_field=right.fname and
    left.mname_field=right.mname and
    left.lname_field=right.lname,
    %nm%(left,right),left outer);

  key_patriot_file := TABLE(patriot.key_patriot_file, {pty_key, fname, mname, lname, global_sid, record_sid, dt_effective_first, dt_effective_last});

  #uniquename(check_bads)
  #uniquename(newer_rec)
  %newer_rec% :=
  RECORD
    key_patriot_file.pty_key;
    key_patriot_file.global_sid;
    key_patriot_file.record_sid;
    key_patriot_file.dt_effective_first;
    key_patriot_file.dt_effective_last;
    %new_rec%
  END;

  %newer_rec% %check_bads%(%pre_route_2% L, key_patriot_file R) := transform
    self.name_match := patriot.namecheck(l.fname_field,l.mname_field,l.lname_field,r.fname,r.mname,r.lname) < 3;
    self.pty_key := R.pty_key;
    self.global_sid := R.global_sid;
    self.record_sid := R.record_sid;
    self.dt_effective_first := R.dt_effective_first;
    self.dt_effective_last := R.dt_effective_last;
    self := L;
  end;

  #uniquename(patriot_file_raw);
  %patriot_file_raw% := join(%pre_route_2%, key_patriot_file,
  patriot.namecheck(left.fname_field,left.mname_field,left.lname_field,right.fname,right.mname,right.lname) < 3,
  TRANSFORM(RIGHT), all);

  #uniquename(patriot_file_rolled);
  %patriot_file_rolled% := dx_common.Incrementals.mac_Rollup(%patriot_file_raw%);

  #uniquename(route_2_all)
  %route_2_all% := join(%pre_route_2%, %patriot_file_rolled%,
    patriot.namecheck(left.fname_field,left.mname_field,left.lname_field,right.fname,right.mname,right.lname) < 3,
    %check_bads%(LEFT,RIGHT), left outer, all);

  #uniquename(route_2_all_flagged)
  %route_2_all_flagged% := Suppress.MAC_FlagSuppressedSource(%route_2_all%, mod_access, did_field, global_sid);

  #uniquename(route_2)
  %route_2% := PROJECT(%route_2_all_flagged%, TRANSFORM( %newer_rec%, SELF.pty_key:= IF(~LEFT.is_suppressed, LEFT.pty_key,''),
    SELF.name_match:= IF(~LEFT.is_suppressed, LEFT.name_match, FALSE),
    SELF:= LEFT));

  #uniquename(route_2_fin) // workaround for bug in join (all)
  %route_2_fin% := dedup(group(sort(group(%route_2%),seq),seq),seq);

  #uniquename(nr)
  #uniquename(le)
  %new_rec% %nr%(%newer_rec% %le%) :=
  TRANSFORM
    SELF := %le%;
  END;

  outfile := %route_1%+IF(EXISTS(infile(did=0)),PROJECT(%route_2_fin%, %nr%(LEFT)));
  outids := DEDUP(%route_2_fin%, ALL);

  endmacro;
