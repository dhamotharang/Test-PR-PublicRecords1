import FraudGovPlatform,PromoteSupers;
EXPORT fn_Skip_Modules (
	boolean SkipBuild = false,
	boolean SkipContributions = false,
	boolean SkipNAC = false,
	boolean SkipInquiryLogs = false,
	boolean SkipMBS = false,
	boolean SkipDeltabase = false,
	boolean SkipRDP = false,
	boolean SkipDashboards = false,
	boolean SkipDashboardVersion =false,
	boolean SkipDedi =false
) := FUNCTION 

	d:=dataset([{
				SkipBuild,
				SkipContributions,
				SkipNAC,
				SkipInquiryLogs, 
				SkipMBS, 
				SkipDeltabase,
				SkipRDP,
				SkipDashboards,
				SkipDashboardVersion,
				SkipDEDI
				}],
			FraudGovPlatform.Layouts.Flags.SkipModules);

	fn := fraudgovplatform.filenames().Flags.SkipModules;

	PromoteSupers.MAC_SF_BuildProcess(d,fn,WriteFile,2,,true);

	return WriteFile;
end;
