import doxie;

doxie.MAC_Header_Field_Declare()

export MFindSearch(MFindV2_Services.InterFaces.VID param) := FUNCTION

	unsigned2 pt := 10 : stored('PenaltThreshold');
	
	ReportRecords := MFindReport;

	ids := MFindV2_Services.MFindSearchService_ids(Param);

	Vids :=dedup(sort(ids,Vid,if(isDeepDive,1,0)),Vid);

	vid_r   := if(param.Vd <>'' or did_value <>'', MFindV2_Services.MFind_raw .Report_view.by_Vid(Vids),
			MFindV2_Services.MFind_raw .Search_view.by_Vid(Vids));
										
	rsrt := if(exists(ReportRecords),
			ReportRecords,
			sort(vid_r(penalt <= pt),if(isDeepDive,1,0), penalt,lname,fname,mname, record));
	
	doxie.MAC_Marshall_Results(rsrt,rmar);
	
	
	RETURN rmar;

END;