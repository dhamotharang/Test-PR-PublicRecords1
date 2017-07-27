export MAC_AppendPatriot(infile,did_field,fname_field,mname_field,lname_field,outfile,outids,create_layout='true') := macro
  #uniquename(route_1)
  #uniquename(ap)
  #uniquename(new_rec)
  #if (create_layout)
  %new_rec% := record
  infile;
  patriot.layout_patriotappend;
  end;
  #else
  %new_rec% := infile;
  #end
  %new_rec% %ap%(infile le,patriot.Key_Baddids ri) := transform
  self.number_with_same_name := ri.other_count;
  self.first_seen := ri.first_seen;
  self.relative_count := ri.rel_count;
  self.known := true;
  self.name_match := ri.did<>0;
  self := le;
  end;
  %route_1% := join(infile(did<>0),patriot.Key_Baddids,left.did_field=right.did,%ap%(left,right),left outer);
  
  #uniquename(pre_route_2)
  #uniquename(nm)
  %new_rec% %nm%(infile le,patriot.key_badnames ri) := transform
  self.known := false;
  self.number_with_same_name := ri.cnt;
  self.name_match := false;
  self := le;
  end;       
  
  %pre_route_2% := join(infile(did=0),patriot.key_badnames,left.fname_field=right.fname and
                    left.mname_field=right.mname and left.lname_field=right.lname,
                    %nm%(left,right),left outer);
  
	key_patriot_file := TABLE(patriot.key_patriot_file, {pty_key, fname, mname, lname});

  #uniquename(check_bads)
	#uniquename(newer_rec)
	%newer_rec% :=
	RECORD
		key_patriot_file.pty_key;
		%new_rec%
	END;
	
  %newer_rec% %check_bads%(%pre_route_2% L, key_patriot_file R) := transform
		self.name_match := patriot.namecheck(l.fname_field,l.mname_field,l.lname_field,r.fname,r.mname,r.lname) < 3;
		self.pty_key := R.pty_key;
		self := L;
  end;


  #uniquename(route_2)
	%route_2% := join(%pre_route_2%,key_patriot_file,
						patriot.namecheck(left.fname_field,left.mname_field,left.lname_field,right.fname,right.mname,right.lname) < 3,
						%check_bads%(LEFT,RIGHT),left outer,all);

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