IMPORT _Control, DriversV2;

EXPORT Proc_DL2_Restricted_QA_Samples := FUNCTION

	e_mail_success := FileServices.sendemail(_Control.MyInfo.EmailAddressNotify + ';qualityassurance@seisint.com', 'QA Drivers License Sample Ready ', 'at ' + thorlib.WUID());
	e_mail_failure := FileServices.sendemail(_Control.MyInfo.EmailAddressNotify,'QA Restricted Sample generation failure', failmessage + 'at ' + thorlib.WUID());

	dPrev := IF(COUNT(NOTHOR(FileServices.SuperFileContents(DriversV2.Constants.Cluster + 'base::DL2::RESTRICTED_drvlic_AID_father'))) = 0,
							DATASET([], DriversV2.Layout_Base_withAID),
	            DATASET(DriversV2.Constants.Cluster + 'base::DL2::RESTRICTED_drvlic_AID_father', DriversV2.Layout_Base_withAID, THOR));
	dNew  := DriversV2.File_DL_Restricted;

	rSlim := RECORD
		TYPEOF(dPrev.orig_state) orig_state;
		TYPEOF(dPrev.dl_number) dl_number;
		TYPEOF(dPrev.did) did;
		TYPEOF(dPrev.name) name;
		TYPEOF(dPrev.addr1) addr1;
		TYPEOF(dPrev.city) city;
		TYPEOF(dPrev.state) state;
		TYPEOF(dPrev.zip) zip;
		TYPEOF(dPrev.province) province;
		TYPEOF(dPrev.country) country;
		TYPEOF(dPrev.postal_code) postal_code;
	END;

	dPrevSlim  := PROJECT(dPrev, rSlim);
	dNewSlim   := PROJECT(dNew, rSlim);
	dPrevDist  := DISTRIBUTE(dPrevSlim, HASH(dl_number));
	dPrevSort  := SORT(dPrevDist, dl_number, LOCAL);
	dPrevDedup := DEDUP(dPrevSort, dl_number, LOCAL);
	dNewDist   := DISTRIBUTE(dNewSlim, HASH(dl_number));
	dNewSort   := SORT(dNewDist, dl_number, LOCAL);
	dNewDedup  := DEDUP(dNewSort, dl_number, LOCAL);

	rSlim tNewOnly(dPrevDedup pPrev, dNewDedup pNew):= TRANSFORM
	  SELF := pNew;
	END;

	dNewOnly := JOIN(dPrevDedup, dNewDedup,
	                 LEFT.dl_number = RIGHT.dl_number,
	                 tNewOnly(LEFT, RIGHT),
	                 RIGHT ONLY,
									 LOCAL);

	dNewOnlySort := SORT(dNewOnly, orig_state);

	dNewOnlyDedup := DEDUP(dNewOnlySort, orig_state, KEEP(10));

	a := OUTPUT(CHOOSEN(dNewOnlyDedup, 300), NAMED('Restricted_Samples')) : SUCCESS(e_mail_success), FAILURE(e_mail_failure);

	RETURN a;

END;
