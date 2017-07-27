import business_regression;
// Generate New Business Header File
#workunit ('name', 'Build Business_Header');

Business_Header.Layout_Business_Header_Base FormatBase(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;

BH_Base := project(Business_Header.BH_Basic_Match_Clean, FormatBase(left));

// Create the Business Header Base file
ut.MAC_SF_BuildProcess(BH_Base, 'BASE::Business_Header', outputbase)

// Create the Business Relatives file
ut.MAC_SF_BuildProcess(Business_Header.BH_Relative_Match_Rollup,'BASE::Business_Relatives',outputrel, 2)

// Create the Business Relatives Group file
ut.MAC_SF_BuildProcess(Business_Header.BH_Relative_Group_Rollup,'BASE::Business_Relatives_Group',outputrelgroup, 2)

// Create the Business Header Stats file
ut.MAC_SF_BuildProcess(Business_Header.BH_Stat,'BASE::Business_Header_Stat',outputstat)

writefiles := parallel(
	outputbase,
	outputrel,
	outputrelgroup,
	outputstat);
	
runregs := parallel(
	business_regression.Proc_Regression_Test,
	business_regression.Proc_Rel_Regression_Test,
	business_regression.Proc_RelGroup_Regression_Test);
	
//sequential(
	writefiles//,
	//please runregs after write files is complete
	//runregs);