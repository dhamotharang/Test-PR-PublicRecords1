IMPORT doxie, doxie_cbrs, ut;

EXPORT reverse_lookup_records_prs(DATASET(doxie_cbrs.layout_references) bdids, 
                                  doxie.IDataAccess mod_access,
                                  BOOLEAN Include_ReversePhone,
                                  UNSIGNED3 Max_ReverseLookup
                                  ) := FUNCTION
                                  
rlr := doxie_cbrs.reverse_lookup_records(bdids,mod_access,Include_ReversePhone);

baserec := record
	string10          phone10; 
	string10          prim_range;
	string2           predir;
	string28          prim_name;
	string4           suffix;
	string2           postdir;
	string10          unit_desig;
	string8           sec_range;
	string25          p_city_name;
	string2           v_predir;
	string28          v_prim_name;
	string4           v_suffix;
	string2           v_postdir;
	string25          v_city_name;
	string2           st;
	string5           z5;
	string4           z4;
end;
integer ml := 40000;
lnrec := record, maxlength(ml)
	rlr.level;
	string120         listed_name;
end;


rec := record, maxlength(ml)
	baserec;
	dataset(lnrec) listed_name_children;
	unsigned3 cumulative_count := 0;
	boolean past_max := false;
end;

cdrec := record, maxlength(ml)
	rec;
	lnrec;
end;

//**** initial slimming
cdrec slim(rlr l) := transform
	self.listed_name_children := dataset([{l.level,l.listed_name}], lnrec);
	self := l;
end;

slm := project(rlr, slim(left));

//**** limit our numbers
lmt := choosen(sort(slm, level, phone10, listed_name), Max_ReverseLookup * 2);

//***** rollup the names
srt := sort(lmt, phone10, prim_range, prim_name, sec_range, z5, listed_name);

cdrec rollem(cdrec l, cdrec r) := transform
	self.listed_name_children := l.listed_name_children + r.listed_name_children;
	self.level := if(r.phone10 <> '' and r.level < l.level, r.level, l.level);
	self:= l;
end;

rld := rollup(srt, rollem(left, right), phone10, prim_range, prim_name, sec_range, z5);

//***** sort for display
srt2 := sort(rld, level, -count(listed_name_children), phone10, prim_range, prim_name, sec_range, phone10);

//***** get rid of dups by clean name and slim a tiny bit
rec dedupit(cdrec l) := transform
	self.listed_name_children := dedup(l.listed_name_children, (ut.CleanCompany(listed_name))[1..40]);
	self := l;
end;

ddp := project(srt2, dedupit(left));

//***** try out a cum. count
rec iter(rec l, rec r) := transform
	self.cumulative_count := l.cumulative_count + count(r.listed_name_children);
	self.past_max := l.cumulative_count >= Max_ReverseLookup;
	self := r;
end;

itr := iterate(ddp, iter(left,  right));
return itr;
end;