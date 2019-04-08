import FraudGovPlatform,PromoteSupers;
EXPORT fn_Skip_Modules (
	boolean SkipInputBuild = false,
	boolean SkipBaseBuild = false,
	boolean SkipBaseRollback = false,
	boolean SkipKeysBuild = false,
	boolean SkipNACBuild = false,
	boolean SkipInquiryLogsBuild = false,
	boolean SkipPiiBuild = false,
	boolean SkipKelBuild = false,
	boolean SkipOrbitBuild = false,
	boolean SkipDashboardsBuild = false,
	boolean SkipMBS = false,
	boolean SkipDeltabase = false,
	boolean SkipContributory = false,
	boolean SkipScrubs = false,
	boolean SkipRefreshHeader = false,
	boolean SkipRefreshAddresses = false,
	boolean SkipGarbageCollector = false
) := FUNCTION 

	d:=dataset([{	SkipBaseBuild,
				SkipBaseRollback, 
				SkipKeysBuild, 
				SkipNACBuild,
				SkipInquiryLogsBuild, 
				SkipPiiBuild,
				SkipKelBuild, 
				SkipOrbitBuild,
				SkipDashboardsBuild,
				SkipMBS,
				SkipDeltabase,
				SkipContributory,
				SkipScrubs,
				SkipRefreshHeader,
				SkipRefreshAddresses,
				SkipGarbageCollector			
				}],
			FraudGovPlatform.Layouts.Flags.SkipModules);

	fn := fraudgovplatform.filenames().Flags.SkipModules;

	PromoteSupers.MAC_SF_BuildProcess(d,fn,WriteFile,2,,true);

	return WriteFile;
end;
