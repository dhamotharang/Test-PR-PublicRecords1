//Defines full build process
import _control, versioncontrol, std;

export Build_Base(string pVersion, boolean isFCRA = false, boolean pDaily	= false) := module
	
	shared FS := fileservices;
	
	shared lfn 	:= INQL_v2.Filenames(pVersion, isFCRA, pDaily).INQL_base.new;
	baseFile 			:= INQL_v2.Update_Base(pVersion, isFCRA, pDaily).INQL_ALL;	
	VersionControl.macBuildNewLogicalFile(lfn, baseFile, BuildINQL);

	bld := sequential(				
										 if(STD.File.FileExists(lfn), output(lfn + ' already exist;'), BuildINQL)
										,INQL_v2.Promote(pVersion, isFCRA, pDaily, true, '', false).INQL.buildfiles.New2Built
										,INQL_v2.Promote(pVersion, isFCRA, pDaily, true, '', false).INQL.buildfiles.Built2QA
										);
	
	export inql_all := bld;
	
	shared lfn_SBA 	:= INQL_v2.Filenames(pVersion, isFCRA, pDaily).SBA_Base.new;
	baseFile 							:= INQL_v2.Update_Base(pVersion, isFCRA, pDaily).SBA_ALL;	
	VersionControl.macBuildNewLogicalFile(lfn_SBA, baseFile, BuildSBA);

	bld := sequential(				
										 if(STD.File.FileExists(lfn_SBA), output(lfn_SBA + ' already exist;'), BuildSBA)
										,INQL_v2.Promote(pVersion, isFCRA, pDaily, true, '', false).SBA.buildfiles.New2Built
										,INQL_v2.Promote(pVersion, isFCRA, pDaily, true, '', false).SBA.buildfiles.Built2QA
										);
	
	export SBA_all := bld;
	
	shared lfn_Batch_PIIs				:= INQL_v2.Filenames(pVersion, isFCRA, pDaily).Batch_PIIs_Base.new;
	baseFile 										:= INQL_v2.Update_Base(pVersion, isFCRA, pDaily).Batch_PIIs_ALL;	
	VersionControl.macBuildNewLogicalFile(lfn_Batch_PIIs, baseFile, BuildBatch_PIIs);

	bld := sequential(				
										 if(STD.File.FileExists(lfn_Batch_PIIs), output(lfn_Batch_PIIs + ' already exist;'), BuildBatch_PIIs)
										,INQL_v2.Promote(pVersion, isFCRA, pDaily, true, '', false).Batch_PIIs.buildfiles.New2Built
										,INQL_v2.Promote(pVersion, isFCRA, pDaily, true, '', false).Batch_PIIs.buildfiles.Built2QA
										);
	
	export Batch_PIIs_all := bld;
		
end;

