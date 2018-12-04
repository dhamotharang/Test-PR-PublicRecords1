Import tools;
EXPORT Build_Base_Pii(string pversion, boolean	UpdatePii   = _Flags.Update.Pii) := Module

shared Pii_Base						:= fSOAPAppend(UpdatePii).pii.All;

shared Ciid_Base					:= fSOAPAppend(UpdatePii).Ciid.All;

shared Crim_Base					:= fSOAPAppend(UpdatePii).Crim.All;

shared Death_Base					:= fSOAPAppend(UpdatePii).Death.All;

shared FraudPoint_Base		:= fSOAPAppend(UpdatePii).FraudPoint.All;

shared Ciid_Orig					:= fSOAPAppend(UpdatePii).Ciid.Orig;

shared Crim_Orig					:= fSOAPAppend(UpdatePii).Crim.Orig;

shared Death_Orig					:= fSOAPAppend(UpdatePii).Death.Orig;

shared FraudPoint_Orig		:= fSOAPAppend(UpdatePii).FraudPoint.Orig;

shared Ciid_Anon					:= fSOAPAppend(UpdatePii).Ciid.Anon;

shared Crim_Anon					:= fSOAPAppend().Crim.Anon;

shared Death_Anon					:= fSOAPAppend(UpdatePii).Death.Anon;


tools.mac_WriteFile(Filenames(pversion).Base.Pii.New,Pii_Base,Build_pii_Base);
tools.mac_WriteFile(Filenames(pversion).Base.CIID.New,Ciid_Base,Build_ciid_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Crim.New,Crim_Base,Build_crim_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Death.New,Death_Base,Build_death_Base);
tools.mac_WriteFile(Filenames(pversion).Base.FraudPoint.New,FraudPoint_Base,Build_fraudpoint_Base);

//
tools.mac_WriteFile(Filenames(pversion).Base.CIID_Orig.New,Ciid_Orig,Build_ciid_Orig);
tools.mac_WriteFile(Filenames(pversion).Base.Crim_Orig.New,Crim_Orig,Build_crim_Orig);
tools.mac_WriteFile(Filenames(pversion).Base.Death_Orig.New,Death_Orig,Build_death_Orig);
tools.mac_WriteFile(Filenames(pversion).Base.FraudPoint_Orig.New,FraudPoint_Orig,Build_fraudpoint_Orig);

//
tools.mac_WriteFile(Filenames(pversion).Base.CIID_Anon.New,Ciid_Anon,Build_ciid_Anon);
tools.mac_WriteFile(Filenames(pversion).Base.Crim_Anon.New,Crim_Anon,Build_crim_Anon);
tools.mac_WriteFile(Filenames(pversion).Base.Death_Anon.New,Death_Anon,Build_death_Anon);
												
Export All := 	Sequential
											(Build_pii_Base
											,Promote(pversion).buildfiles.New2Built
 											,Build_ciid_Orig
   											,Build_crim_Orig
   											,Build_death_Orig
   											,Build_fraudpoint_Orig
   											,Build_ciid_Anon
   											,Build_crim_Anon
   											,Build_death_Anon
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
