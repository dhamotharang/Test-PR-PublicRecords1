Import tools,std;
EXPORT Build_Base_Pii(string pversion, boolean	UpdatePii   = _Flags.Update.Pii) := Module

shared Pii_Base						:= fSOAPAppend(UpdatePii).pii.All;

shared Crim_Base					:= fSOAPAppend(UpdatePii).Crim.All;

shared Death_Base					:= fSOAPAppend(UpdatePii).Death.All;

shared IPMetaData_Base		:= fSOAPAppend(UpdatePii).IPMetaData.All;

shared Advo_Base					:= fSOAPAppend(UpdatePii).Advo.All;

shared DLHistory_Base			:= fSOAPAppend(UpdatePii).DL_History.All;
shared BestInfo_Base			:= fSOAPAppend(UpdatePii).Best_Info( DLHistory_Base ).All;

shared PrepaidPhone_Base	:= fSOAPAppend(UpdatePii).PrepaidPhone.All;

shared BocaShell_Base			:= fSOAPAppend(UpdatePii).BocaShell.All;

shared Crim_Orig					:= fSOAPAppend(UpdatePii).Crim.Orig;

shared Death_Orig					:= fSOAPAppend(UpdatePii).Death.Orig;



tools.mac_WriteFile(Filenames(pversion).Base.Pii.New,Pii_Base,Build_pii_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Crim.New,Crim_Base,Build_crim_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Death.New,Death_Base,Build_death_Base);
tools.mac_WriteFile(Filenames(pversion).Base.IPMetaData.New,IPMetaData_Base,Build_IPMetaData_Base);
tools.mac_WriteFile(Filenames(pversion).Base.Advo.New,Advo_Base,Build_Advo_Base);
tools.mac_WriteFile(Filenames(pversion).Base.DLHistory.New,DLHistory_Base,Build_DLHistory_Base);
tools.mac_WriteFile(Filenames(pversion).Base.BestInfo.New,BestInfo_Base,Build_BestInfo_Base);
tools.mac_WriteFile(Filenames(pversion).Base.PrepaidPhone.New,PrepaidPhone_Base,Build_PrepaidPhone_Base);
tools.mac_WriteFile(Filenames(pversion).Base.BocaShell.New,BocaShell_Base,Build_BocaShell_Base);

//
tools.mac_WriteFile(Filenames(pversion).Base.Crim_Orig.New,Crim_Orig,Build_crim_Orig);
tools.mac_WriteFile(Filenames(pversion).Base.Death_Orig.New,Death_Orig,Build_death_Orig);
																			
Export All := 	Sequential
											(
											 Build_pii_Base
											,Promote(pversion).buildfiles.New2Built
											,Build_crim_Orig
											,Build_death_Orig
											,Promote(pversion).buildfiles.New2Built
											,Build_crim_Base
											,Build_death_Base
											,Build_IPMetaData_Base
											,Build_Advo_Base
											,Build_DLHistory_Base
											,Build_BestInfo_Base
											,Build_PrepaidPhone_Base
											,Build_BocaShell_Base
											,Promote(pversion).buildfiles.New2Built
											,Promote(pversion).buildfiles.Built2QA
											)
								;
END;
