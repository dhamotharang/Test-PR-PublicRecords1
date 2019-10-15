//Defines full build process
import _control, versioncontrol, std;

export Build_Base(string pVersion, boolean isFCRA = false, boolean pDaily	= true) := module
	
	shared FS := fileservices;
	
	shared lfn 	:= INQL_v2.Filenames(pVersion, isFCRA, pDaily).INQL_base.new;
	baseFile 			:= if(pDaily, INQL_v2.Update_Base(pVersion, isFCRA, pDaily).INQL_ALL,
	                            INQL_v2.Update_Base(pVersion, isFCRA, pDaily).INQL_HIST);	
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
	
	shared lfn_BillGroups_DID				:= INQL_v2.Filenames(pVersion, isFCRA, pDaily).BillGroups_DID_Base.new;
	baseFile 										    := INQL_v2.Update_Base(pVersion, isFCRA, pDaily).BillGroups_DID_ALL;	
	VersionControl.macBuildNewLogicalFile(lfn_BillGroups_DID, baseFile, BuildBillGroups_DID);

	bld := sequential(				
										 if(STD.File.FileExists(lfn_BillGroups_DID), output(lfn_BillGroups_DID + ' already exist;'), BuildBillGroups_DID)
										,INQL_v2.Promote(pVersion, isFCRA, pDaily, true, '', false).BillGroups_DID.buildfiles.New2Built
										,INQL_v2.Promote(pVersion, isFCRA, pDaily, true, '', false).BillGroups_DID.buildfiles.Built2QA
										);
	
	export BillGroups_DID_all := bld;
		
end;

