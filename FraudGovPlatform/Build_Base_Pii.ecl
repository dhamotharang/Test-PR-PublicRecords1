Import tools;
EXPORT Build_Base_Pii(string pversion) := Module

shared Pii_Base		:= fSOAPAppend.pii.All;

shared Ciid_Base		:= fSOAPAppend.Ciid.All;

shared Crim_Base		:= fSOAPAppend.Crim.All;

shared Death_Base		:= fSOAPAppend.Death.All;

tools.mac_WriteFile(Filenames(pversion).Base.Pii.New,Pii_Base,Build_pii_Base);
tools.mac_WriteFile(Filenames(pversion).Base.CIID.New,Ciid_Base,Build_ciid_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Crim.New,Crim_Base,Build_crim_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Death.New,Death_Base,Build_death_Base);
												
Export All := 	if(tools.fun_IsValidVersion(pversion)
									,Sequential
											(Build_pii_Base
											,Build_ciid_Base
											,Build_crim_Base
											,Build_death_Base
											,Promote(pversion).buildfiles.New2Built
											,Promote(pversion).buildfiles.Built2QA
											)
									,output('No Valid version parameter passed, skipping Build_Base_KnownFraud atribute')
									);
END;