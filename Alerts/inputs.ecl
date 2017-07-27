export inputs := MODULE
	// shorter name
	shared layout_srch_hashes := layouts.layout_srch_hashes;
	shared layout_report_hashes := layouts.layout_report_hashes;
	shared layout_locreport_hashes := layouts.layout_locreport_hashes;
	
  // input options
	export boolean return_hashes := false : stored('ReturnHashes');
	export input_hashes := dataset([], layout_report_hashes) : stored('hashvals');
	export input_srch_hashes := dataset([], layout_srch_hashes) : stored('srch_hashvals');
	export input_loc_hashes := dataset([], layout_locreport_hashes) : stored('loc_hashvals');

	export boolean trackName := false : stored('TrackNameChanges');
	export boolean trackSSN := false : stored('TrackSSNChanges');
	export boolean trackStatus := false : stored('TrackStatusChanges');
	export boolean trackAddress := false : stored('TrackAddressChanges');
	export boolean trackPhone := false : stored('TrackPhoneChanges');
	export boolean trackListedPhone := false : stored('TrackListedPhoneChanges');
	export boolean trackAsset := false : stored('TrackAssetChanges');
	export boolean trackProperty := false : stored('TrackPropertyChanges');
	export boolean trackBankruptcy := false : stored('TrackBankruptcyChanges');
	export boolean trackUCC := false : stored('TrackUCCChanges');
	export boolean trackLiens := false : stored('TrackLiensChanges');
	export boolean trackLicense := false : stored('TrackLicenseChanges');
	export boolean trackCriminal := false : stored('TrackCriminalChanges');
	export boolean trackSexOffender := false : stored('TrackSexOffenderChanges');
	export boolean trackCorp := false : stored('TrackCorpChanges');
	export boolean trackAssociate := false : stored('TrackAssociateChanges');
END;