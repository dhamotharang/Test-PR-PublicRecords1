//Defines full build process
import _control, versioncontrol, std;

export Build_Base(
	 string		pVersion
	,boolean	pDelta		= false
	,boolean	pUseProd	= false						
) := module
	
	shared promote_base_modname := INQL_v2.Promote(pVersion, pUseProd, true); //promote base
	
	Accurint_mod := module	
					
		shared lf 	:= INQL_v2.Filenames(pVersion, pUseProd).Accurint_Base.new;
		dsAccurint 	:= INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnAccurint;		
		VersionControl.macBuildNewLogicalFile(lf, dsAccurint, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_Accurint.buildfiles.New2Built
											);
	end;
	
	Custom_mod := module	
					
		shared lf := INQL_v2.Filenames(pVersion, pUseProd).Custom_Base.new;
		dsCustom 	:= INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnCustom;		
		VersionControl.macBuildNewLogicalFile(lf, dsCustom, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_Custom.buildfiles.New2Built
											);
	end;
	
	Banko_mod := module	
					
		shared lf := INQL_v2.Filenames(pVersion, pUseProd).Banko_Base.new;
		dsBanko 	:= INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnBanko;		
		VersionControl.macBuildNewLogicalFile(lf, dsBanko, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_Banko.buildfiles.New2Built
											);
	end;
	
	Batch_mod := module	
					
		shared lf := INQL_v2.Filenames(pVersion, pUseProd).Batch_Base.new;
		dsBatch 	:= INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnBatch;		
		VersionControl.macBuildNewLogicalFile(lf, dsBatch, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_Batch.buildfiles.New2Built
											);
	end;
	
	BatchR3_mod := module	
					
		shared lf := INQL_v2.Filenames(pVersion, pUseProd).BatchR3_Base.new;
		dsBatchR3	:= INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnBatchR3;		
		VersionControl.macBuildNewLogicalFile(lf, dsBatchR3, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_BatchR3.buildfiles.New2Built
											);
	end;
	
	Bridger_mod := module	
					
		shared lf := INQL_v2.Filenames(pVersion, pUseProd).Bridger_Base.new;
		dsBridger := INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnBridger;		
		VersionControl.macBuildNewLogicalFile(lf, dsBridger, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_Bridger.buildfiles.New2Built
											);
	end;
	
	Riskwise_mod := module	
					
		shared lf 	:= INQL_v2.Filenames(pVersion, pUseProd).Riskwise_Base.new;
		dsRiskwise 	:= INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnRiskwise;		
		VersionControl.macBuildNewLogicalFile(lf, dsRiskwise, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_Riskwise.buildfiles.New2Built
											);
	end;
	
	IDM_mod := module	
					
		shared lf := INQL_v2.Filenames(pVersion, pUseProd).IDM_Base.new;
		dsIDM 		:= INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnIDM;		
		VersionControl.macBuildNewLogicalFile(lf, dsIDM, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_IDM.buildfiles.New2Built
											);
	end;
	
	SBA_mod := module	
					
		shared lf := INQL_v2.Filenames(pVersion, pUseProd).SBA_Base.new;
		dsSBA 		:= INQL_v2.Update_Base(pVersion, pDelta, pUseProd).fnSBA;		
		VersionControl.macBuildNewLogicalFile(lf, dsSBA, BuildFile);
		
		export all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.Promote_SBA.buildfiles.New2Built
											);
	end;
   
	export All :=
		if(VersionControl.IsValidVersion(pVersion)
			,parallel(
				Accurint_mod.all
			 ,Custom_mod.all
			 ,Banko_mod.all
			 ,Batch_mod.all
			 ,BatchR3_mod.all
			 ,Bridger_mod.all
			 ,Riskwise_mod.all
			 ,IDM_mod.all
			 ,SBA_mod.all
			)
			,output('No Valid version parameter passed, skipping build')
		);

end;
