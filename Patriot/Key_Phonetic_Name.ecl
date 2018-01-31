import doxie, Text, Data_Services;

df := patriot.File_Patriot;

slimrec := record	
	df.pty_key;
	df.source;
	df.fname;
	df.mname;
	df.lname;
	df.cname;
	df.orig_pty_name;
	string350 full_name_orig_or_company := '';
end;

slimrec into_slim(df L) := transform
	self := L;
end;

df2 := dedup(sort(distribute(project(df(lname != ''), into_slim(LEFT)), hash(orig_pty_name)), orig_pty_name, lname, fname, mname, pty_key, source, local), orig_pty_name, lname, fname, mname, pty_key, source, local)
	  + dedup(sort(distribute(project(df(cname != ''), into_slim(LEFT)), hash(cname)), cname, pty_key, source, local), cname, pty_key, source, local);

slimrec norm_names(df2 L, integer C) := transform
	self.full_name_orig_or_company := if (C = 1, L.orig_pty_name, L.cname);
	self := l;
end;

df3 := normalize(df2, 2, norm_names(LEFT,COUNTER))(full_name_orig_or_company != '');

normrec := record
	slimrec.pty_key;
	slimrec.source;
	slimrec.fname;
	slimrec.mname;
	slimrec.lname;
	slimrec.cname;
	string50	pnamecomponent;
end;

Pattern ws := (ANY NOT IN Text.Alpha)+;
Token   name := Pattern ('[a-zA-Z]+');
Rule   is_a_name := name;

emptywords := ['THE','AN','TO','OF','FOR','A','AND'];

normrec into_norm(df3 L) := transform
	self.pnamecomponent := if (stringlib.stringtouppercase(matchtext(is_a_name)) not in emptywords, metaphonelib.dmetaphone1(matchtext(is_a_name)), '');
	self := L;
end;

outf := Parse(df3,full_name_orig_or_company,is_a_name,into_norm(LEFT), maxlength(50));

export key_phonetic_name := index(outf(pnamecomponent != ''),{pnamecomponent, source},{lname, fname, mname, cname, pty_key},Data_Services.Data_location.Prefix()+'thor_data400::key::patriot_phoneticnames_'+ doxie.Version_SuperKey);
