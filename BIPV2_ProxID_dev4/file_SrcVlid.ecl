import mdr;

dlatest_iteration := files().outfile.qa;

//filter for d&b and lnca recs
dfilt := dlatest_iteration(
			(
						(mdr.sourcetools.sourceisDunn_Bradstreet	(source) 	and hist_duns_number        != '')
				or	(mdr.sourcetools.sourceisDCA							(source)  and hist_enterprise_number  != '')
				or	(			mdr.sourcetools.SourceIsCorpV2		(source)
							and (     hist_domestic_corp_key 					!= ''										//only include foreign filings because we want to get credit if it matches, but not be penalized when it doesn't
                    or  foreign_corp_key                != ''
                    or  unk_corp_key                    != ''
                  )
            )
			)
	and vl_id != ''
);

dproj := project(dfilt	,transform(
	{dlatest_iteration.proxid	,dlatest_iteration.source,dlatest_iteration.vl_id}
	,self.vl_id 	:= trim(left.source) + '|' + trim(left.vl_id)
	,self					:= left

));

EXPORT file_SrcVlid := dedup(sort(distribute(dproj	,proxid),proxid,source,vl_id,local),proxid,source,vl_id,local);
