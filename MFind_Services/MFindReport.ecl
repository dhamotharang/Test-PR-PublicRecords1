import doxie;

export MFindReport := FUNCTION

	string32 	Vd := '' 		: stored('VID');
	Unsigned6 	Did:= 0  		: stored('DID');
	string22 MilBranch :=''  : stored('MilitaryBranch');

	uMilBranch := stringlib.stringtouppercase(MilBranch);
	
	uVd :=stringlib.stringtouppercase(trim(Vd,all));
	Vid :=dataset([{uVd}],MFind_services.layout_Search_ids);
	
	by_did :=MFind_Services.MFind_raw.get_vids_from_dids(dataset([{did}],doxie.layout_references));
	
	Vids := 
		dedup(sort(if(vd <> '', dataset([{uvd}],MFind_services.layout_Search_ids)) +
							 if(did > 0, by_did),vid),all);


	prepr := MFind_services.MFind_raw.report_view.by_Vid(Vids);


	r :=prepr(trim(trim_vid,all)= uVd or uVd='',
						Mil_Branch =uMilBranch or uMilBranch ='');
	RETURN r;

END;