Import tools;
EXPORT Build_Base_Pii(string pversion) := Module

shared Pii_Base						:= fSOAPAppend().pii.All;

shared Ciid_Base					:= fSOAPAppend().Ciid.All;

shared Crim_Base					:= fSOAPAppend().Crim.All;

shared Death_Base					:= fSOAPAppend().Death.All;

shared FraudPoint_Base		:= fSOAPAppend().FraudPoint.All;

tools.mac_WriteFile(Filenames(pversion).Base.Pii.New,Pii_Base,Build_pii_Base);
tools.mac_WriteFile(Filenames(pversion).Base.CIID.New,Ciid_Base,Build_ciid_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Crim.New,Crim_Base,Build_crim_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Death.New,Death_Base,Build_death_Base);
tools.mac_WriteFile(Filenames(pversion).Base.FraudPoint.New,FraudPoint_Base,Build_fraudpoint_Base);
												
Export All := 	Sequential
											(Build_pii_Base
											,Promote(pversion).buildfiles.New2Built
											,Build_ciid_Base
											,Build_crim_Base
											,Build_death_Base
											,Build_fraudpoint_Base
											,Promote(pversion).buildfiles.New2Built
											,Promote(pversion).buildfiles.Built2QA
											)
								;
END;
