
export File_Autokey(

	//dataset(Layouts.keybuild )	pFileKeybuild = FraudDefenseNetwork.File_KeyBuild()
	 dataset(Layouts.Base.Main)		      pBaseMainBuilt		  =	Files().Base.Main.Built	

) :=
function

   pFileKeybuild := FraudDefenseNetwork.File_KeyBuild(pBaseMainBuilt);
   dAutokey      := project(pFileKeybuild,Layouts_Key.Autokey);

	return dAutokey;

end;