import FraudShared;
export File_Autokey(

	//dataset(Layouts.keybuild )	pFileKeybuild = FraudDefenseNetwork.File_KeyBuild()
	 dataset(FraudShared.Layouts.Base.Main)		      pBaseMainBuilt		  =	Files().Base.Main.Built	

) :=
function

   pFileKeybuild := Get_File_KeyBuild(pBaseMainBuilt).File_KeyBuild;
   dAutokey      := project(pFileKeybuild,FraudShared.Layouts_Key.Autokey);

	return dAutokey;

end;