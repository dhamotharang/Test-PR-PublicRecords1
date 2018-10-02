import STD, VersionControl;

EXPORT Flush_DeployedData(boolean isFCRA = false) := MODULE

 shared pDaily := true;
 shared ver := 'flush_' + WORKUNIT;
 lfn := INQL_v2.Filenames(ver, isFCRA, true).INQL_base.new;
 
 CurrBase := INQL_v2.files(isFCRA, true).INQL_base.built;	
 DeployedDelta := INQL_v2.files(isFCRA, true).LastDeployedDelta;
 NewBase := CurrBase(version > DeployedDelta[1].version);
 VersionControl.macBuildNewLogicalFile(lfn, NewBase, BuildINQL);

 export bld := sequential(				
										 BuildINQL
										,INQL_v2.Promote(ver, isFCRA, pDaily, true, '', false).INQL.buildfiles.New2Built
										,INQL_v2.Promote(ver, isFCRA, pDaily, true, '', false).INQL.buildfiles.Built2QA
										);

END;