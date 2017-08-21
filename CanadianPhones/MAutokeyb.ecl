import autokeyI;

export MAutokeyb := MODULE (AutoKeyI.BuildI_Biz.ibuild)

		export BuildI_Biz_Address_keybuild(AutoKeyI.BuildI_Biz_Address.params in_mod) 				:= CanadianPhones.MAutokeyBuild.Addressb.keybuild(in_mod);
		export BuildI_Biz_Zip_keybuild(AutoKeyI.BuildI_Biz_Zip.params in_mod) 								:= CanadianPhones.MAutokeyBuild.Zipb.keybuild(in_mod);
		
END;
