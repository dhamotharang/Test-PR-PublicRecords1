import AutokeyI;

export MAutokey := MODULE (AutoKeyI.BuildI_Indv.ibuild)

	export BuildI_Indv_Custom1_keybuild(autokeyi.InterfaceForBuild in_mod)	:= SexOffender.MAutokeyBuild.LatLong.keybuild(in_mod);
	export BuildI_Indv_Custom1_keymove(autokeyi.InterfaceForBuild in_mod)		:= SexOffender.MAutokeyBuild.LatLong.keymove(in_mod);
	export BuildI_Indv_Custom1_keymoveQA(autokeyi.InterfaceForBuild in_mod)	:= SexOffender.MAutokeyBuild.LatLong.keymoveQA(in_mod);
		
END;
