import business_regression,ut, roxiekeybuild,VersionControl,Business_Header_Bdid_lift,mdr;

export proc_build_business_header_base_files(

	 string																		pversion
	,dataset(Layout_Business_Header_Temp		)	pBH_Orig_Addr_With_AID		= BH_Orig_Addr_With_AID			()
	,dataset(Layout_Business_Relative				)	pBH_Relative_Match_Rollup	= BH_Relative_Match_Rollup	()
	,dataset(Layout_Business_Relative_Group	)	pBH_Relative_Group_Rollup	= BH_Relative_Group_Rollup	()
	,dataset(Layout_Business_Header_Stat		)	pBH_Stat									= BH_Stat										()

) := 
module

	shared names := filenames(pversion).base;

	Layout_Business_Header_Base FormatBase(Layout_Business_Header_Temp L) :=
	transform
		//patch for vendor id blanking problem
		self.vendor_id := if((MDR.sourceTools.SourceIsVehicle(l.source) or MDR.sourceTools.sourceIsWC(l.source)) and
				l.vendor_id = '' and l.state != '', l.state + hash(l.company_name), l.vendor_id);
		
		self := L;
	end;

	shared BH_Base := filters.BasesOut.Business_headers(project(pBH_Orig_Addr_With_AID, FormatBase(left)));

	/////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add Dummy data to corp base file
	/////////////////////////////////////////////////////////////////////////////////////////////////
	shared dummy_dataset := dataset(
	[
		 {999999001001,999999001001,'DU','','',0,'26-RVH9999999001001',20060627,20060627,20021124,(unsigned4)pversion,'MARSUPIAL MANOR III','12345','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,'163','440','42.23264','-83.385796',0,0,0,TRUE,FALSE,'','MARSUPIAL MANOR III', '', ''}
		,{999999001002,999999001001,'DU','','',0,'26-RVH9999999001001',20021124,20040902,20021124,20040902,'MARSUPIAL MANOR III','999','','WAYNE','RD','','','','ROMULUS','MI',48174,1551,'163','440','42.23264','-83.385796',0,0,0,FALSE,FALSE,'','MARSUPIAL MANOR III', '', ''}

	], Layout_Business_Header_Base);	

	shared dBH_Relative_Match_Rollup := filters.basesout.Business_Relatives				(pBH_Relative_Match_Rollup);
	shared dBH_Relative_Group_Rollup := filters.basesout.Business_Relative_Group	(pBH_Relative_Group_Rollup);
	
	VersionControl.macBuildNewLogicalFile( names.Search.new					,BH_Base	+ dummy_dataset		,BuildSearch					);
	VersionControl.macBuildNewLogicalFile( names.Relatives.new			,dBH_Relative_Match_Rollup	,BuildRelatives				);
	VersionControl.macBuildNewLogicalFile( names.RelativesGroup.new	,dBH_Relative_Group_Rollup	,BuildRelativesGroup	);
	VersionControl.macBuildNewLogicalFile( names.Stat.new						,pBH_Stat										,BuildStat						);

	BuildBases :=
	sequential(

		 BuildSearch
		,Business_Header_Bdid_lift.Proc_Iterate('1',BH_Basic_Match_FEIN(),pversion).DoAll
		,BuildRelatives		
		,BuildRelativesGroup
		,promote(pversion,'^.*?base::business_header.*?(search|relatives).*$').new2built
		,BuildStat

	);
		
	runregs := parallel(
		business_regression.Proc_Regression_Test,
		business_regression.Proc_Rel_Regression_Test,
		business_regression.Proc_RelGroup_Regression_Test);
		
	export all := 
	sequential(

		 BuildBases
		,promote(pversion,'^.*?base::business_header.*?(stat)$').new2built

	);

end;

//please runregs after write files is complete
//runregs);
	
