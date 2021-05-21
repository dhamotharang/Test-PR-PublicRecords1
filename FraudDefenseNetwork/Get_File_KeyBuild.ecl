import STD;
EXPORT Get_File_KeyBuild(dataset(Layouts.Base.Main)		      pBaseMainBuilt		  =	Files().Base.Main.Built) := MODULE
 
	EXPORT File_KeyBuild:= FraudDefenseNetwork.File_KeyBuild(pBaseMainBuilt);
 
 End;