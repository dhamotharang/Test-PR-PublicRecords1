import BIPV2, Doxie, dx_Gong, TopBusiness_Services;

export Fetch_Gong_History_By_BusinessIds(dataset(BIPV2.IDFunctions.rec_SearchInput) ds_inData,
  Doxie.IDataAccess mod_access) := function

	ds_businessIdsInfoOut	:= 	BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_inData).SELEBest(company_name <> '');

	ds_businessIdsInfoOutSorted := sort(ds_businessIdsInfoOut, -record_score);

	// extract the business ids
	BIPV2.IDlayouts.l_xlink_ids xform_businessIdsOnly(ds_businessIdsInfoOutSorted le) := transform
		self := le;
	end;

  ds_businessIds := project(ds_businessIdsInfoOutSorted, xform_businessIdsOnly(left));
  businessIdsWithHistory := dx_Gong.key_history_LinkIDs.kfetch(ds_businessIds, mod_access,
    TopBusiness_Services.Constants.sourceLinkIdLevel);

	businessIdsWithHistorySorted := sort(businessIdsWithHistory, -(current_record_flag ='Y'), -dt_last_seen);

  return businessIdsWithHistorySorted;

end;
