export MAC_AppendPatriot(infile, mod_access, did_field,fname_field,mname_field,lname_field,outfile,outids) := macro
IMPORT dx_common, Suppress;  
  
  #uniquename(outrec)
  %outrec% := RECORDOF(infile) OR patriot.layout_patriotappend;
  
  #uniquename(new_rec)
  %new_rec% := %outrec% OR dx_common.layout_metadata;

  #uniquename(route_1_pre_a)
  #uniquename(route_1_pre_b)
  #uniquename(route_1)
  #uniquename(ap)

  %new_rec% %ap%(infile le,patriot.Key_Baddids ri) := transform
  self.number_with_same_name := ri.other_count;
  self.first_seen := ri.first_seen;
  self.relative_count := ri.rel_count;
  self.known := true;
  self.name_match := ri.did<>0;
  dx_common.Incrementals.mac_CopyMetadata(self, ri);
  self := le;
  end;
  %route_1_pre_a% := join(infile(did<>0),patriot.Key_Baddids,left.did_field=right.did,%ap%(left,right),left outer,limit(10000));
  %route_1_pre_b% := dx_common.Incrementals.mac_Rollupv2(%route_1_pre_a%, flag_deletes := TRUE);
  %route_1% := project(%route_1_pre_b%, transform(%outrec%,
    self.number_with_same_name := if(~left.is_delta_delete, left.number_with_same_name, 0);
    self.first_seen := if(~left.is_delta_delete, left.first_seen, 0);
    self.relative_count := if(~left.is_delta_delete, left.relative_count, 0);
    self.known := if(~left.is_delta_delete, left.known, false);
    self.name_match := if(~left.is_delta_delete, left.name_match, false);
    self := left;
    ));
    
  #uniquename(pre_route_2a)
  #uniquename(pre_route_2b)
  #uniquename(pre_route_2)
  #uniquename(nm)
  %new_rec% %nm%(infile le,patriot.key_badnames ri) := transform
  self.known := false;
  self.number_with_same_name := ri.cnt;
  self.name_match := false;
  dx_common.Incrementals.mac_CopyMetadata(self, ri);
  self := le;
  end;       
  
  %pre_route_2a% := join(infile(did=0),patriot.key_badnames,left.fname_field=right.fname and
                    left.mname_field=right.mname and left.lname_field=right.lname,
                    %nm%(left,right),left outer, limit(10000));
  %pre_route_2b% := dx_common.Incrementals.mac_Rollupv2(ungroup(%pre_route_2a%), flag_deletes := TRUE);
  %pre_route_2% := project(%pre_route_2b%, transform(%new_rec%,
    self.number_with_same_name := if(~left.is_delta_delete, left.number_with_same_name, 0);
    self := left;
    ));

  key_patriot_file := TABLE(patriot.key_patriot_file, {pty_key, fname, mname, lname, global_sid, record_sid, dt_effective_first, dt_effective_last, delta_ind});

  #uniquename(newer_rec)
  %newer_rec% :=
  RECORD
    key_patriot_file.pty_key;
    %new_rec%
  END;

  #uniquename(check_bads)
  %newer_rec% %check_bads%(%pre_route_2% L, key_patriot_file R) := transform
    self.name_match := patriot.namecheck(l.fname_field,l.mname_field,l.lname_field,r.fname,r.mname,r.lname) < 3;
    self.pty_key := R.pty_key;
    dx_common.Incrementals.mac_CopyMetadata(self, R);
    self := L;
  end;

  #uniquename(route_2a)
  #uniquename(route_2b)
  #uniquename(route_2c)
  #uniquename(route_2)

  %route_2a% := join(%pre_route_2%,key_patriot_file,
    patriot.namecheck(left.fname_field,left.mname_field,left.lname_field,right.fname,right.mname,right.lname) < 3,
    %check_bads%(LEFT,RIGHT),left outer,all);
  
  %route_2b% := dx_common.Incrementals.mac_Rollupv2(%route_2a%, flag_deletes := TRUE);
  %route_2c% := Suppress.MAC_FlagSuppressedSource(%route_2b%, mod_access, did_field, global_sid);  

  %route_2% := PROJECT(%route_2c%, TRANSFORM(%newer_rec%, 
    SELF.pty_key:= IF(~LEFT.is_suppressed AND ~LEFT.is_delta_delete, LEFT.pty_key,''), 
    SELF.name_match:= IF(~LEFT.is_suppressed AND ~LEFT.is_delta_delete, LEFT.name_match, FALSE), 
    SELF:= LEFT));

  #uniquename(route_2_fin) // workaround for bug in join (all)
  %route_2_fin% := dedup(group(sort(%route_2%,seq),seq),seq); 

  outfile := %route_1%+IF(EXISTS(infile(did=0)),PROJECT(%route_2_fin%, %outrec%));

  outids := DEDUP(%route_2_fin%, ALL);
  
  endmacro;
