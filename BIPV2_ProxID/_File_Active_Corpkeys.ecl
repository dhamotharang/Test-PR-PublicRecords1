import mdr;
dlatest_iteration := files().base.built;
//filter for only active corpkey proxid records
dfilt := dlatest_iteration(
      mdr.sourcetools.SourceIsCorpV2  (source)
  and active_corp_key                 != ''
  and company_inc_state               != ''
  and company_charter_number          != ''
);
dproj := project(dfilt	,transform(
	{dlatest_iteration.proxid	,typeof(dlatest_iteration.company_inc_state) inc_state,typeof(dlatest_iteration.company_charter_number) charter_number}
  ,self.inc_state       := left.company_inc_state
  ,self.charter_number  := left.company_charter_number
  ,self					        := left
));
EXPORT _File_Active_Corpkeys := dedup(sort(distribute(dproj	,proxid),proxid,inc_state,charter_number,local),proxid,inc_state,charter_number,local);
