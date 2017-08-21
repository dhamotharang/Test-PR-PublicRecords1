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
            and source_record_id  != 0
            and source            != ''
			)
);

dproj := project(dfilt	,transform(
	{dlatest_iteration.proxid	,dlatest_iteration.source,dlatest_iteration.source_record_id,dlatest_iteration.vl_id}
	,self					:= left

));

EXPORT file_SrcRidVlid := dedup(sort(distribute(dproj	,proxid),proxid,source,source_record_id,vl_id,local),proxid,source,source_record_id,vl_id,local);
