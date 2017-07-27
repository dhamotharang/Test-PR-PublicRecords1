import versioncontrol;
export Extract_Files(
	 string																						pversion
	,dataset(layouts.Base.Organizations							)	pOrgFile				= files().base.Organizations.qa
	,dataset(layouts.Base.Affiliated_Individuals		)	pAffIndivFile		= files().base.Affiliated_Individuals.qa
	,dataset(layouts.Base.Unaffiliated_Individuals	)	pUnaffIndivFile = files().base.Unaffiliated_Individuals.qa
	,string																						pSeparator			= ','
	,boolean																					pOverwrite			= false
) :=
function

	dOrgslim 		:= dedup(project(pOrgFile					,transform(layouts.Temporary.Orgs				, self.bdid := (string)left.bdid	;self.ORG_AUDIT_FIRMNO	:= left.rawfields.ORG_AUDIT_FIRMNO										)),hash64(bdid,ORG_AUDIT_FIRMNO),all);
	dAffslim		:= dedup(project(pAffIndivFile		,transform(layouts.Temporary.AffIndiv		, self.did  := (string)left.did		;self.isln							:= left.rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN; 	)),hash64(did,isln),all);
	dUnaffslim	:= dedup(project(pUnaffIndivFile 	,transform(layouts.Temporary.UnaffIndiv	, self.did  := (string)left.did		;self.isln							:= left.rawfields.INDIV_AUDIT_ISLN										)),hash64(did,isln),all);

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).extracts.Organizations.new						,dOrgslim		,Build_Org_Extract_File		,pShouldExport := false,pCsvout := true,pSeparator := pSeparator,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).extracts.Affiliated_Individuals.new		,dAffslim		,Build_Aff_Extract_File		,pShouldExport := false,pCsvout := true,pSeparator := pSeparator,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).extracts.Unaffiliated_Individuals.new	,dUnaffslim	,Build_Unaff_Extract_File	,pShouldExport := false,pCsvout := true,pSeparator := pSeparator,pOverwrite := pOverwrite);

	return parallel(
		 Build_Org_Extract_File			
		,Build_Aff_Extract_File				
		,Build_Unaff_Extract_File			
	);

end;