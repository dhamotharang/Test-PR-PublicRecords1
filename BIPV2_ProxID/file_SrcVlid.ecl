import mdr;
dlatest_iteration := files().base.built;
//filter for d&b and lnca recs
dfilt := dlatest_iteration(
      (
            mdr.sourcetools.sourceisDunn_Bradstreet	(source)
        or  mdr.sourcetools.sourceisDCA							(source)
        or  mdr.sourcetools.SourceIsCorpV2		      (source)
      )
  and
      (
                vl_id             != ''
            and source            != ''
			)
);
dproj := project(dfilt	,transform(
	{dlatest_iteration.proxid	,dlatest_iteration.source,dlatest_iteration.vl_id}
	,self					:= left
));
EXPORT file_SrcVlid := dedup(sort(distribute(dproj	,proxid),proxid,source,vl_id,local),proxid,source,vl_id,local);
