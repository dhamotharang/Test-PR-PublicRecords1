export File_Autokey(

 dataset(FraudGovPlatform.Layouts.Base.Main)		      pBaseMainBuilt		  =	Files().Base.Main.Built	

) :=
function

   pFileKeybuild := File_KeyBuild(pBaseMainBuilt);
   dAutokey      := project(pFileKeybuild,FraudGovPlatform.Layouts_Key.Autokey);

	return dAutokey;

end;