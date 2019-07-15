import std;

dlatest_iteration := files().base.built;
dfilt := dlatest_iteration(
      prim_name_derived != ''
);
dproj := project(dfilt	,transform(
	{dlatest_iteration.proxid	,string28 pname_digits},

  fixit1 := std.str.filterout(left.prim_name_derived,'-/');
  fixit2 := regexreplace('\\<[^[:digit:]]*\\>'        ,fixit1,'',nocase);
  fixit3 := regexreplace('(st|nd|rd|th|[^[:alnum:]])' ,fixit2,'',nocase);

	self					      := left;
  self.pname_digits   := trim(fixit3,all);

));
EXPORT file_filter_Prim_names := table(dproj(pname_digits != ''),{proxid,pname_digits},proxid,pname_digits,merge);

/*
  if it has numbers in it
  have to look at words....
  regexreplace('[]',left.prim_name,'',nocase);
*/