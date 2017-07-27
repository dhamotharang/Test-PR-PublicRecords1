export MAC_DID_Stats(h_new, h_old, did_field, outstats) := macro

ut.Mac_Duplicate_Count(h_new,did_field, dups);

#uniquename(rold)
%rold% := record
  h_old.did_field;
  h_old.fname;
  h_old.lname;
  end;

#uniquename(rnew)
%rnew% := record
  h_new.did_field;
  h_new.fname;
  h_new.lname;
  end;

#uniquename(s_old)
%s_old% := distribute(table(h_old,%rold%),hash(did_field));

#uniquename(s_new)
%s_new% := distribute(table(h_new,%rnew%),hash(did_field));

#uniquename(s_old_ud)
%s_old_ud% := dedup(sort(%s_old%,did_field,local),did_field,local);

outputa := output(count(%s_old_ud%), NAMED('unique_old_DIDs'));
outputb := output(Count(h_old(did_field=rid)), NAMED('old_DID_equals_RID'));

#uniquename(s_new_ud)
%s_new_ud% := dedup(sort(%s_new%,did_field,local),did_field,local);

outputc := output(count(%s_new_ud%), NAMED('unique_new_DIDs'));
outputd := output(Count(h_new(did_field=rid)), NAMED('new_DID_equals_RID'));
if ( count(%s_new_ud%)<>Count(h_new(did_field=rid)), output('Not all dids have rid'));

#uniquename(tra)
%rold% %tra%(%rold% l) := transform
  self := l;
  end;

#uniquename(disappearing_dids)
%disappearing_dids% := join(%s_new_ud%,%s_old_ud%,left.did_field=right.did_field,%tra%(right),right only,local);

outpute := output(count(%disappearing_dids%), NAMED('disappearing_DIDs'));

#uniquename(new_dids)
%new_dids% := join(%s_new_ud%,%s_old_ud%,left.did_field=right.did_field,%tra%(right),left only,local);

outputf := output(count(%new_dids%), NAMED('new_DIDs'));

#uniquename(ddmatch)
%ddmatch% := record
  integer6 did_field;
  end;

#uniquename(did_match)
%ddmatch% %did_match%(%rold% l, %rnew% r) := transform
  self.did_field := l.did_field;
  end;

#uniquename(matching)
%matching% := join(%s_new%,%s_old%,left.did_field=right.did_field and
                             left.lname=right.lname and
                             left.fname=right.fname,%did_match%(right,left),local);
// maybe able to avoid sort 
//good_match := dedup(sort(%matching%,did_field,local),did_field,local);
#uniquename(good_match)
%good_match% := dedup(%matching%,did_field,local);

outputg := output(count(%good_match%), NAMED('good_matches'));

outstats := parallel(
dups,
outputa,
outputb,
outputc,
outputd,
outpute,
outputf,
outputg);

endmacro;