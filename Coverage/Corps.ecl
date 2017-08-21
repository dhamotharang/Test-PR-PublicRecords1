/* W20080108-171540
Corps
*/

corpy := corp2.files().base.corp.qa;

corptable1 := 
record

	corpy.corp_state_origin;
	string corp_type := regexfind('LLC|LP', corpy.corp_key, 0, nocase);
	corpy.corp_status_date;
	corpy.corp_filing_date;
	corpy.dt_last_seen;

end;

corpytable1 := table(corpy, corptable1);

corptable2 := 
record

	corpytable1.corp_state_origin;
	corpytable1.corp_type;
	unsigned6 dt_first_seen;
	corpy.dt_last_seen;

end;


corptable2 tgetdtfirst(corpytable1 l) :=
transform

//	self.dt_first_seen := (unsigned6)trim(stringlib.stringfilter(l.corp_status_date,'0123456789'));
	self.dt_first_seen := if(trim(l.corp_status_date) != '', (unsigned6)trim(l.corp_status_date), (unsigned6)trim(l.corp_filing_date));
	self := l;


end;

corpytable2 := project(corpytable1, tgetdtfirst(left));

corptable3 := 
record

	corpytable2.corp_state_origin;
	corpytable2.corp_type;
	unsigned4 cov_st_type		:= min(group	,corpytable2.dt_first_seen	);
	unsigned4 cov_end_type	:= max(group	,corpytable2.dt_last_seen		);

end;

corpytable3 := table(corpytable2(dt_first_seen > 18000101), corptable3, corp_state_origin, corp_type,few);

output(corpytable3, all);