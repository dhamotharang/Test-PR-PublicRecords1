import FraudGovPlatform,PromoteSupers;
EXPORT fn_Skip_Modules (
	boolean SkipBaseBuild = true,
	boolean SkipBaseRollback = true,
	boolean SkipKeysBuild = true,
	boolean SkipNACBuild = true,
	boolean SkipInquiryLogsBuild = true,
	boolean SkipPiiBuild = true,
	boolean SkipKelBuild = true,
	boolean SkipOrbitBuild = true,
	boolean SkipDashboardsBuild = true
) := FUNCTION 

	d:=dataset([{	SkipBaseBuild,
				SkipBaseRollback, 
				SkipKeysBuild, 
				SkipNACBuild,
				SkipInquiryLogsBuild, 
				SkipPiiBuild,
				SkipKelBuild, 
				SkipOrbitBuild,
				SkipDashboardsBuild}],
			FraudGovPlatform.Layouts.OutputF.SkipModules);

	fn := fraudgovplatform.filenames().OutputF.SkipModules;

	PromoteSupers.MAC_SF_BuildProcess(d,fn,WriteFile,2,,true);

	return WriteFile;
end;
