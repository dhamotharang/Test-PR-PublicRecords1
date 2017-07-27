import iesp,doxie;
export Sanction_Records (IParams.reportParams inputData, dataset(layouts.deepDids) bestdid, dataset(layouts.deepBDids) bestbdid, dataset(doxie.ingenix_provider_module.layout_ingenix_provider_report) providers) := module
	shared userSanctions_ids := dataset(inputData.sanc_id_set, {unsigned6 sanc_id});
	shared userSancSet := project(userSanctions_ids,transform(layouts.layout_sancid,self.sanc_id:=(string)left.sanc_id));
	shared providerSancSet := project(providers.sanction_id, transform(layouts.layout_sancid, self.sanc_id := left.sanc_id));
	shared sanctionsNotVerified := Raw.SanctionsReportRecords(inputData, bestdid, bestbdid, userSancSet, providerSancSet);
	//Verify that the sanctions being displayed are for the Provider returned.
	shared sanctionsRaw := if(exists(providers),functions.SanctionMatchesProvider(providers,sanctionsNotVerified),sanctionsNotVerified);
	shared normSancDids := dedup(sort(project(sanctionsRaw,transform(layouts.layout_denormDid,self := left))(did<>'0',did<>''),did),did);
	shared sancCountByDid := count(normSancDids);
	shared normSancIds := dedup(sort(project(sanctionsRaw,transform(layouts.layout_sancid,self := left))(sanc_id<>'0',sanc_id<>''),sanc_id),sanc_id);
	shared sancCountIds := count(normSancIds);
	shared normSancBdids := dedup(sort(project(sanctionsRaw,transform(layouts.layout_denormBDid,self := left))(bdid<>'0',bdid<>''),bdid),bdid);
	shared sancCountByBdid := count(normSancBdids);
	export sanctions := sanctionsRaw(SANC_ID<>'');	
	shared fmtBestDid := project(normSancDids,transform(layouts.deepDids, self.did:=(integer)left.did));
	export bestSancDid := choosen(fmtBestDid(did>0),1);
	export sancDidFound := sancCountByDid>0;
	export sancidFound := sancCountIds>0;
	export tooManySancDidsFound := sancCountByDid > 1;
	shared fmtSancBDid := project(normSancBdids,transform(layouts.deepBDids, self.bdid:=(integer)left.bdid));
	export bestSancBDid := choosen(fmtSancBDid(bdid>0),1);
	export sancBdidFound := sancCountByBdid>0;
	export tooManySancBDidsFound := sancCountByBdid>1;

	export sancDids := dedup(project(normSancdids,transform(layouts.deepDids,self.did:=(integer)left.did)),record);
	export sancBDids := dedup(project(normSancbdids,transform(layouts.deepbDids,self.bdid:=(integer)left.bdid)),record);
	export noSancRecordsFound := sancCountByDid = 0 and sancCountByBdid = 0 and not exists(sanctionsRaw);
end;
