import mdr,dnb_feinv2;
dlatest_iteration := files().base.built;
//filter for d&b and lnca recs
dfilt := dlatest_iteration(
      (
            (mdr.sourcetools.sourceisDunn_Bradstreet	(source) and deleted_key = '')
        // or  mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source)
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
dedupit := dedup(sort(distribute(dproj	,proxid),proxid,source,source_record_id,vl_id,local),proxid,source,source_record_id,vl_id,local);
// dedupit_notFein := dedupit(not mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source));
// dedupit_fein    := dedupit(    mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source));
// dnbfein := table(dnb_feinv2.file_dnb_fein_base_main_new,{source_rec_id,tmsid},source_rec_id,tmsid,merge);
// dVerifyFein := join(dedupit_fein,dnbfein,left.source_record_id = right.source_rec_id and left.vl_id = right.tmsid,transform(left),hash);
// EXPORT file_SrcRidVlid := dedupit_notFein + dVerifyFein;
EXPORT file_SrcRidVlid := dedupit;
