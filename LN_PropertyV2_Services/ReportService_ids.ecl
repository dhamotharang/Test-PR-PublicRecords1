import LN_PropertyV2_Services;

export ReportService_ids(

	// singular
	unsigned6	did				= 0,
	unsigned6	bdid			= 0,
	string45	parcelID	= '',
	string12	faresID		= '',
	
	// plural
	dataset(LN_PropertyV2_Services.layouts.search_did)		in_dids		= dataset([], LN_PropertyV2_Services.layouts.search_did),
	dataset(LN_PropertyV2_Services.layouts.search_bdid)	in_bdids	= dataset([], LN_PropertyV2_Services.layouts.search_bdid),
	boolean isFCRA = false
) := function

	// lookup by DID
	dids := dataset([{did}], LN_PropertyV2_Services.layouts.search_did) + in_dids;

	by_did := Raw.get_fids_from_dids(dids,isFCRA);

	// lookup by BDID
	bdids := dataset([{bdid}], LN_PropertyV2_Services.layouts.search_bdid) + in_bdids;

	by_bdid := Raw.get_fids_from_bdids(bdids);

	// lookup by ParcelId
	pnum := dataset([{parcelID}], LN_PropertyV2_Services.layouts.search_pnum);
	by_pnum := Raw.get_fids_from_pnum(pnum);

	// lookup by FaresId
	fid				:= dataset([{faresId}], LN_PropertyV2_Services.layouts.fid);
	exp_pnum	:= if( input.allParcel, Raw.exp_fids_by_pnum(fid) );
	exp_addr	:= if( input.allProp, Raw.exp_fids_by_addr(fid) );
	by_fid		:= Raw.cleanFids(fid+exp_pnum+exp_addr);

	// assimilate all seqs
	fids := dedup( map(
		faresId<>''									=> by_fid,
		parcelID<>''								=> by_pnum,
		did<>0	or exists(in_dids)	=> by_did,
		bdid<>0	or exists(in_bdids)	=> by_bdid
	), all);

  final_fids := if (isFCRA,by_did,fids);
	return final_fids;
end;