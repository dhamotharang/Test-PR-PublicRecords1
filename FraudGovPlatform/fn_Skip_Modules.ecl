import FraudGovPlatform,PromoteSupers;
EXPORT fn_Skip_Modules (
	boolean SkipBaseBuild = false,
	boolean SkipBaseRollback = true,
	boolean SkipKeysBuild = true,
	boolean SkipNACBuild = false,
	boolean SkipInquiryLogsBuild = true,
	boolean SkipPiiBuild = true,
	boolean SkipKelBuild = true,
	boolean SkipOrbitBuild = true,
	boolean SkipDashboardsBuild = true,
	boolean SkipMBS = false,
	boolean SkipDeltabase = false,
	boolean SkipContributory = true,
	boolean SkipScrubs = true,
	boolean SkipRefreshHeader = true,
	boolean SkipRefreshAddresses = true,
	boolean SkipGarbageCollector = true
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
