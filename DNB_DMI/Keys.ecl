import doxie, tools,dnb, BIPV2;

export Keys(
	 string												pversion							= ''
	,boolean											pUseOtherEnvironment	= false
	,dataset({DNB.Layout_DNB_Base, BIPV2.IDlayouts.l_xlink_ids})	pDnbCompaniesBase			= File_Companies_Keybuild()
	,string												pDatasetName					= 'DNB'
) :=
module

	shared dBase				:= pDnbCompaniesBase;
	shared FilterBdids	:= dBase(bdid					!=  0);
	shared FilterDuns		:= dBase(duns_number	!= '');

	shared ddedupbdids := dedup(project(FilterBdids, {FilterBdids.bdid,FilterBdids.duns_number}), all)(bdid != 0);

	tools.mac_FilesIndex('ddedupbdids	,{unsigned6 bd := ddedupbdids.bdid			},{ddedupbdids.duns_number}'	,keynames(pversion,pUseOtherEnvironment,pDatasetName).bdid			,bdid 	);
	tools.mac_FilesIndex('FilterDuns	,{string9 duns := FilterDuns.duns_number},{FilterDuns							}'	,keynames(pversion,pUseOtherEnvironment,pDatasetName).Duns			,Duns		);
	
end;
