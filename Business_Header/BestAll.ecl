//split out business header file into two files, one with dppa= true, one with dppa=false
//join the two files on bdid, left only, so you get all dppa records that do not have a
//cooresponding non-dppa record(dppa only records)
//take those dppa only records, and sort them on bdid and source state, and dedup
//them on bdid.
//then join that deduped file back to the non-deduped file on bdid and source state, 
//right outer , so you get all dppa records for that bdid and state
//Add that resulting file back to the dppa = true records, and pass that into the 
//BestJoined function

export BestAll(

	 dataset(Layout_Business_Header_Base	)	pInput							  = Files().Base.Business_Headers.Built
	,string																	pMakePersistUnique	  = 'EB_AE'
	,dataset(Layout_Business_Header_Temp	)	pBH_Basic_Match_Clean	= persists().BHBasicMatchClean
	,boolean                                best_poss_non_DandB   = FALSE
	,boolean																pShouldFilter				  = true

) :=
function


	persisttempname		:= _dataset().thor_cluster_Persists + 'persist::Business_header::BestAll';
	persistname 		:= if(pMakePersistUnique != '', persisttempname + '::FilteredOut_' + trim(pMakePersistUnique)
														, persisttempname
							);
	
	////////////////////////////////////////////////////////////////////////
	// Get best address from the BH_Basic_match_clean for keys
	////////////////////////////////////////////////////////////////////////
	bh_filtered1 		    := distribute(Business_Header.filters.bases.business_header_best(pInput), rcid);
	bh_notfiltered 		  := distribute(pInput, rcid);
	bh_filtered 		    := if(pShouldFilter	,bh_filtered1	,bh_notfiltered);
		
	bh_basic_matchClean := distribute(pBH_Basic_Match_Clean, rcid);
	
	//*** Getting the best addresses got from the AID process and replacing the Orig addresses for
	//*** key build.
	Layout_Business_Header_Base getBestAddr(bh_filtered l, bh_basic_matchClean r) :=  transform
		 	self.prim_range		:=  r.prim_range;
			self.predir				:= 	r.predir;
			self.prim_name		:=	r.prim_name;
			self.addr_suffix	:=	r.addr_suffix;
			self.postdir			:=	r.postdir;
			self.unit_desig		:=	r.unit_desig;
			self.sec_range		:=	r.sec_range;
			self.city					:=	r.city;
			self.state				:=	r.state;
			self.zip					:=	r.zip;
			self.zip4					:=	r.zip4;		
		 self := l;
	end;
		
	bh_with_bestAddr := join(bh_filtered, bh_basic_matchClean,
													 left.rcid = right.rcid,
													 getBestAddr(left,right), left outer, local
													);

	////////////////////////////////////////////////////////////////////////
	// Split out DPPA records from Non-DPPA records
	////////////////////////////////////////////////////////////////////////	
	bh_with_dppa 		:= bh_with_bestAddr(dppa = true);
	bh_without_dppa := bh_with_bestAddr(dppa = false);

	////////////////////////////////////////////////////////////////////////
	// Join DPPA records to NON-DPPA records to get DPPA only Bdids
	////////////////////////////////////////////////////////////////////////
	bh_with_dppa_dist := distribute(bh_with_dppa, hash(bdid));
	bh_with_dppa_sort := sort(bh_with_dppa_dist, bdid,local);

	bh_without_dppa_dist := distribute(bh_without_dppa, hash(bdid));
	bh_without_dppa_sort := sort(bh_without_dppa_dist, bdid,local);

	Layout_Business_Header_Base joindppa2nondppa(bh_without_dppa_sort l, bh_with_dppa_sort r) := transform
	self := r;
	end;

	bh_dppa_only_bdids_join := join(bh_without_dppa_sort, bh_with_dppa_sort, left.bdid = right.bdid, 
								 joindppa2nondppa(left,right),right only,local);

	////////////////////////////////////////////////////////////////////////
	// Dedup DPPA only Bdids to get first Alphabetical DPPA state record
	////////////////////////////////////////////////////////////////////////
	bh_dppa_only_bdids_sort := sort(bh_dppa_only_bdids_join, bdid, vendor_id[1..2], local);
	bh_dppa_only_bdids_dedup := dedup(bh_dppa_only_bdids_sort, bdid, local);

	Layout_Business_Header_Base joindppa2state(bh_dppa_only_bdids_dedup l, bh_dppa_only_bdids_sort r) := transform
	self := r;
	end;

	bh_dppa_only_bdids_all_join := join(bh_dppa_only_bdids_dedup, bh_dppa_only_bdids_sort, left.bdid = right.bdid and
									left.vendor_id[1..2] = right.vendor_id[1..2], 
								 joindppa2state(left,right),local);
								 
	bh_all_in := bh_without_dppa + bh_dppa_only_bdids_all_join;
	
	nametopass := if(pMakePersistUnique != ''	, '::BestAll::FilteredOut_' + trim(pMakePersistUnique)
									, '::BestAll'
					);
	lbestjoined := BestJoined(bh_all_in, nametopass, best_poss_non_DandB) : persist(persistname);
	
	return lBestJoined;

end;