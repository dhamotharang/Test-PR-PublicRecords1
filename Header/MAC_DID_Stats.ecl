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
  h_new.jflag2;
	h_new.tnt;
  end;

#uniquename(s_old)
%s_old% := distribute(table(h_old,%rold%),hash(did_field));

#uniquename(s_new)
%s_new% := distribute(table(h_new,%rnew%),hash(did_field));

#uniquename(s_old_ud)
%s_old_ud% := dedup(sort(%s_old%,did_field,local),did_field,local);

outputa := ut.fn_AddStat(count(%s_old_ud%), 'DID Stats: unique_old_DIDs');
outputb := ut.fn_AddStat(count(h_old(did_field=rid)), 'DID Stats: old_DID_equals_RID');

#uniquename(s_new_ud)
%s_new_ud% := dedup(sort(%s_new%,did_field,local),did_field,local);

#uniquename(s_new_ud_nojf)
%s_new_ud_nojf% := dedup(sort(%s_new%(jflag2 = ''),did_field,local),did_field,local);

#uniquename(s_new_ud_nojf_living)
%s_new_ud_nojf_living% := dedup(sort(%s_new%(jflag2 = '', tnt <> 'D'),did_field,local),did_field,local);

#uniquename(singletons)
%singletons% := join(%s_new%(jflag2 = '', tnt <> 'D'), %s_new%(jflag2 = '', tnt <> 'D'), left.did = right.did, atmost(1), local);

uniquenewdids := count(%s_new_ud%);
outputc := ut.fn_AddStat(uniquenewdids, 'DID Stats: unique_new_DIDs');
outputc2 := ut.fn_AddStat(count(%s_new_ud_nojf%), 'DID Stats: unique_new_DIDs_nojflag2');
outputc3 := ut.fn_AddStat(count(%s_new_ud_nojf_living%), 'DID Stats: unique_new_DIDs_nojflag2_living');
outputc4 := ut.fn_AddStat(count(%s_new_ud_nojf_living%)-count(%singletons%), 'DID Stats: unique_new_DIDs_nojflag2_living_multrecs');
outputd := ut.fn_AddStat(count(h_new(did_field=rid)), 'DID Stats: new_DID_equals_RID');
outputif := if ( count(%s_new_ud%)<>Count(h_new(did_field=rid)), output('Not all dids have rid'));

#uniquename(tra)
%rold% %tra%(%rold% l) := transform
  self := l;
  end;

#uniquename(disappearing_dids)
%disappearing_dids% := join(%s_new_ud%,%s_old_ud%,left.did_field=right.did_field,%tra%(right),right only,local);

outpute := ut.fn_AddStat(count(%disappearing_dids%), 'DID Stats: Disappearing DIDs');

#uniquename(new_dids)
%new_dids% := join(%s_new_ud%,%s_old_ud%,left.did_field=right.did_field,%tra%(right),left only,local);

outputf := ut.fn_AddStat(count(%new_dids%), 'DID Stats: Appearing DIDs');

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

outputg := ut.fn_AddStat(count(%good_match%), 'DID Stats: Good matches');

#uniquename(no_change)
%no_change% := uniquenewdids - count(%new_dids%);

outstats := parallel(
ut.fn_AddStat(count(%new_dids%)/uniquenewdids, 'DID Stats: Appear Rate'),
ut.fn_AddStat(count(%disappearing_dids%)/count(%s_old_ud%), 'DID Stats: Disappear Rate'),
ut.fn_AddStat(%no_change%, 'DID Stats: No Change'),
ut.fn_AddStat(count(%good_match%)/%no_change%, 'DID Stats: Good Rate'),
dups,
outputa,
outputb,
outputc,
outputc2,
outputc3,
outputc4,
outputd,
outpute,
outputf,
outputg,
outputif);

endmacro;