import STD,FraudGovPlatform,FraudDefenseNetwork;
EXPORT Get_File_KeyBuild(dataset(FraudShared.Layouts.Base.Main)		      pBaseMainBuilt		  =	Files().Base.Main.Built) := MODULE

	SHARED Source  			:= 'N':STORED('Platform');
 
	EXPORT File_KeyBuild:= MAP(Source = 'FraudGov'  =>FraudGovPlatform.File_KeyBuild(pBaseMainBuilt)
										,Source = 'FDN' 	=>FraudDefenseNetwork.File_KeyBuild(pBaseMainBuilt)
										,Dataset([],recordof(pBaseMainBuilt)) //Default(Error will be handled with the file template)						
										);
 
 End;