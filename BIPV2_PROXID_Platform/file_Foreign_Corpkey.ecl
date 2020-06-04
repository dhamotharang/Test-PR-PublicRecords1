import mdr;
dlatest_iteration := files().base.built;
//filter for only foreign corpkey proxid records
dfilt := dlatest_iteration(
      mdr.sourcetools.SourceIsCorpV2		      (source)
  and (     foreign_corp_key          != ''
        or  active_domestic_corp_key  != ''
      )
  and company_inc_state       != ''
  and company_charter_number  != ''
);
dproj := project(dfilt	,transform(
	{dlatest_iteration.proxid	,dlatest_iteration.company_inc_state,dlatest_iteration.company_charter_number}
	,self					:= left
));
EXPORT file_Foreign_Corpkey := dedup(sort(distribute(dproj	,proxid),proxid,company_inc_state,company_charter_number,local),proxid,company_inc_state,company_charter_number,local);
