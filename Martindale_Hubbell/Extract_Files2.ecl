import strata,tools;
export Extract_Files2(
	 string																						pversion
	,dataset(layouts.Base.Organizations							)	pOrgFile				= files().base.Organizations.qa
	,dataset(layouts.Base.Affiliated_Individuals		)	pAffIndivFile		= files().base.Affiliated_Individuals.qa
	,dataset(layouts.Base.Unaffiliated_Individuals	)	pUnaffIndivFile = files().base.Unaffiliated_Individuals.qa
	,string																						pSeparator			= '|'
	,boolean																					pOverwrite			= false
) :=
function

	dOrgBdid 	:= Martindale_Hubbell.fGetOrgBdids			(pOrgFile				)	: global;
	dAffDid		:= Martindale_Hubbell.Improve_AffDids		(pAffIndivFile	) : global;
	dUnaffDid	:= Martindale_Hubbell.Improve_UnaffDids	(pUnaffIndivFile) : global;
	
	daffprop		:= Propagate_AffDids	(dAffDid		,dUnaffDid	);
	dunaffprop	:= Propagate_UnaffDids(dUnaffDid	,dAffDid		);

	tools.mac_ConvertToCsv(dOrgBdid		,dorgbdidcsv	,'|',pShouldExport := false,pDatasetRecLength := 1000000);
	tools.mac_ConvertToCsv(daffprop		,daffpropcsv	,'|',pShouldExport := false,pDatasetRecLength := 1000000);
	tools.mac_ConvertToCsv(dunaffprop	,dunaffpropcsv,'|',pShouldExport := false,pDatasetRecLength := 1000000);
	
	tools.mac_WriteFile(Filenames(pversion).extracts.Organizations.new						,dorgbdidcsv	,Build_Org_Extract_File		,pShouldExport := false,pOverwrite := pOverwrite,pCsvout := true,pSeparator := '|',pQuote := '',pHeading := false);
	tools.mac_WriteFile(Filenames(pversion).extracts.Affiliated_Individuals.new		,daffpropcsv	,Build_Aff_Extract_File		,pShouldExport := false,pOverwrite := pOverwrite,pCsvout := true,pSeparator := '|',pQuote := '',pHeading := false);
	tools.mac_WriteFile(Filenames(pversion).extracts.Unaffiliated_Individuals.new	,dunaffpropcsv,Build_Unaff_Extract_File	,pShouldExport := false,pOverwrite := pOverwrite,pCsvout := true,pSeparator := '|',pQuote := '',pHeading := false);

	tools.mac_WriteFile(Filenames(pversion).extracts.Orgs.new					,dOrgBdid		,Build_Org_Extract2_File		,pShouldExport := false,pOverwrite := pOverwrite);
	tools.mac_WriteFile(Filenames(pversion).extracts.Aff_Indivs.new		,daffprop		,Build_Aff_Extract2_File		,pShouldExport := false,pOverwrite := pOverwrite);
	tools.mac_WriteFile(Filenames(pversion).extracts.Unaff_Indivs.new	,dunaffprop	,Build_Unaff_Extract2_File	,pShouldExport := false,pOverwrite := pOverwrite);

	strata.mac_pops(pOrgFile				,OrgBdid		,,,,,,false,false,['bdid']);
	strata.mac_pops(dOrgBdid				,orgimpBdid	,,,,,,false,false,['bdid']);
	strata.mac_pops(pAffIndivFile		,AffDid			,,,,,,false,false,['Did']);
	strata.mac_pops(daffprop				,AffimpDid	,,,,,,false,false,['Did']);
	strata.mac_pops(pUnaffIndivFile	,UnaffDid		,,,,,,false,false,['Did']);
	strata.mac_pops(dunaffprop			,UnaffimpDid,,,,,,false,false,['Did']);
	
	return parallel(
		 Build_Org_Extract_File			
		,Build_Aff_Extract_File				
		,Build_Unaff_Extract_File
		,Build_Org_Extract2_File	
		,Build_Aff_Extract2_File	
		,Build_Unaff_Extract2_File
		,output(OrgBdid				,named('OrgBdid'		))
		,output(orgimpBdid		,named('orgimpBdid'	))
		,output(AffDid				,named('AffDid'			))
		,output(AffimpDid			,named('AffimpDid'	))
		,output(UnaffDid			,named('UnaffDid'		))
		,output(UnaffimpDid		,named('UnaffimpDid'))
	);

end;