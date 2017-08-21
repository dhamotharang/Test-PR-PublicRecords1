import doxie;

export MFindSearch := FUNCTION

	doxie.MAC_Header_Field_Declare()

	unsigned2 pt := 20 : stored('PenaltThreshold');

	ids := MFind_services.MFindSearchService_ids;

	Vids :=dedup(sort(ids,Vid,if(isDeepDive,1,0)),Vid);

	vid_r   := MFind_services.MFind_raw .search_view.by_Vid(Vids);
										
	rsrt := sort(vid_r(penalt <= pt),if(isDeepDive,1,0), penalt,lname,fname,mname, record);
	doxie.MAC_Marshall_Results(rsrt,rmar);
	
	RETURN rmar;

END;