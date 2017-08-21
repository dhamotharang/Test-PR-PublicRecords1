import autokeyI;

export MAutokey := MODULE (AutoKeyI.BuildI_Indv.ibuild)

		export BuildI_Indv_Address_keybuild(AutoKeyI.BuildI_Indv_Address.params in_mod) 				:= CanadianPhones.MAutokeyBuild.Address.keybuild(in_mod);
		export BuildI_Indv_Zip_keybuild(AutoKeyI.BuildI_Indv_Zip.params in_mod) 								:= CanadianPhones.MAutokeyBuild.Zip.keybuild(in_mod);
		export BuildI_Indv_ZipPRLName_keybuild(AutoKeyI.BuildI_Indv_ZipPRLName.params in_mod) 	:= CanadianPhones.MAutokeyBuild.ZipPRLName.keybuild(in_mod);
		
END;
