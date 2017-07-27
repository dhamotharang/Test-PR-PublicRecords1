import doxie;

doxie.MAC_Header_Field_Declare()

export MFindReport := FUNCTION

	string84 	Vd := '' 		: stored('VID');
	string22 MilBranch :=''  : stored('MilitaryBranch');

	did := (unsigned6) did_value;
	
	uMilBranch := stringlib.stringtouppercase(MilBranch);
	
	uVd :=stringlib.stringtouppercase(trim(Vd,all));
	Vid :=dataset([{uVd}],MFindV2_Services.layout_Search_ids);
	
	by_did :=MFindV2_Services.MFind_raw.get_vids_from_dids(dataset([{did}],doxie.layout_references));
	
	Vids := 
		dedup(sort(if(vd <> '', dataset([{uvd}],MFindV2_Services.layout_Search_ids)) +
							 if(did > 0, by_did),vid),all);


	prepr := MFindV2_Services.MFind_raw.report_view.by_Vid(Vids);


	r :=prepr(trim(trim_vid,all)= uVd or uVd='',
						Mil_Branch =uMilBranch or uMilBranch ='');
	RETURN r;

END;