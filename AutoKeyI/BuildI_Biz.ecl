//designed to replace AutokeyB2.Keys
//follows structure of Autokey.IFetch
export BuildI_Biz := 
MODULE

	//this defines the default build code
	export IBuild := 
	INTERFACE
	
		export BuildI_Biz_Address_keybuild(AutoKeyI.BuildI_Biz_Address.params in_mod) 				:= AutoKeyI.BuildI_Biz_Address.keybuild(in_mod);
		export BuildI_Biz_Address_keymove(AutoKeyI.BuildI_Biz_Address.params in_mod) 					:= AutoKeyI.BuildI_Biz_Address.keymove(in_mod);
		export BuildI_Biz_Address_keymoveQA(AutoKeyI.BuildI_Biz_Address.params in_mod) 				:= AutoKeyI.BuildI_Biz_Address.keymoveQA(in_mod);

		export BuildI_Biz_CityStName_keybuild(AutoKeyI.BuildI_Biz_CityStName.params in_mod) 	:= AutoKeyI.BuildI_Biz_CityStName.keybuild(in_mod);
		export BuildI_Biz_CityStName_keymove(AutoKeyI.BuildI_Biz_CityStName.params in_mod) 		:= AutoKeyI.BuildI_Biz_CityStName.keymove(in_mod);
		export BuildI_Biz_CityStName_keymoveQA(AutoKeyI.BuildI_Biz_CityStName.params in_mod) 	:= AutoKeyI.BuildI_Biz_CityStName.keymoveQA(in_mod);

		export BuildI_Biz_Name_keybuild(AutoKeyI.BuildI_Biz_Name.params in_mod) 							:= AutoKeyI.BuildI_Biz_Name.keybuild(in_mod);
		export BuildI_Biz_Name_keymove(AutoKeyI.BuildI_Biz_Name.params in_mod) 								:= AutoKeyI.BuildI_Biz_Name.keymove(in_mod);
		export BuildI_Biz_Name_keymoveQA(AutoKeyI.BuildI_Biz_Name.params in_mod) 							:= AutoKeyI.BuildI_Biz_Name.keymoveQA(in_mod);

		export BuildI_Biz_NameWords_keybuild(AutoKeyI.BuildI_Biz_NameWords.params in_mod) 		:= AutoKeyI.BuildI_Biz_NameWords.keybuild(in_mod);
		export BuildI_Biz_NameWords_keymove(AutoKeyI.BuildI_Biz_NameWords.params in_mod) 			:= AutoKeyI.BuildI_Biz_NameWords.keymove(in_mod);
		export BuildI_Biz_NameWords_keymoveQA(AutoKeyI.BuildI_Biz_NameWords.params in_mod) 		:= AutoKeyI.BuildI_Biz_NameWords.keymoveQA(in_mod);

		export BuildI_Biz_Phone_keybuild(AutoKeyI.BuildI_Biz_Phone.params in_mod) 						:= AutoKeyI.BuildI_Biz_Phone.keybuild(in_mod);
		export BuildI_Biz_Phone_keymove(AutoKeyI.BuildI_Biz_Phone.params in_mod) 							:= AutoKeyI.BuildI_Biz_Phone.keymove(in_mod);
		export BuildI_Biz_Phone_keymoveQA(AutoKeyI.BuildI_Biz_Phone.params in_mod) 						:= AutoKeyI.BuildI_Biz_Phone.keymoveQA(in_mod);

		export BuildI_Biz_FEIN_keybuild(AutoKeyI.BuildI_Biz_FEIN.params in_mod) 							:= AutoKeyI.BuildI_Biz_FEIN.keybuild(in_mod);
		export BuildI_Biz_FEIN_keymove(AutoKeyI.BuildI_Biz_FEIN.params in_mod) 								:= AutoKeyI.BuildI_Biz_FEIN.keymove(in_mod);
		export BuildI_Biz_FEIN_keymoveQA(AutoKeyI.BuildI_Biz_FEIN.params in_mod) 							:= AutoKeyI.BuildI_Biz_FEIN.keymoveQA(in_mod);

		export BuildI_Biz_StName_keybuild(AutoKeyI.BuildI_Biz_StName.params in_mod) 					:= AutoKeyI.BuildI_Biz_StName.keybuild(in_mod);
		export BuildI_Biz_StName_keymove(AutoKeyI.BuildI_Biz_StName.params in_mod) 						:= AutoKeyI.BuildI_Biz_StName.keymove(in_mod);
		export BuildI_Biz_StName_keymoveQA(AutoKeyI.BuildI_Biz_StName.params in_mod) 					:= AutoKeyI.BuildI_Biz_StName.keymoveQA(in_mod);

		export BuildI_Biz_Zip_keybuild(AutoKeyI.BuildI_Biz_Zip.params in_mod) 								:= AutoKeyI.BuildI_Biz_Zip.keybuild(in_mod);
		export BuildI_Biz_Zip_keymove(AutoKeyI.BuildI_Biz_Zip.params in_mod) 									:= AutoKeyI.BuildI_Biz_Zip.keymove(in_mod);
		export BuildI_Biz_Zip_keymoveQA(AutoKeyI.BuildI_Biz_Zip.params in_mod) 								:= AutoKeyI.BuildI_Biz_Zip.keymoveQA(in_mod);


		//this is where you can add in custom keys
		export BuildI_Biz_Custom1_keybuild(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom1 Keybuild not used');
		export BuildI_Biz_Custom1_keymove(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom1 Keymove not used');
		export BuildI_Biz_Custom1_keymoveQA(AutoKeyI.InterfaceForBuild in_mod)							:= output('Biz Custom1 KeymoveQA not used');

		export BuildI_Biz_Custom2_keybuild(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom2 Keybuild not used');
		export BuildI_Biz_Custom2_keymove(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom2 Keymove not used');
		export BuildI_Biz_Custom2_KeymoveQA(AutoKeyI.InterfaceForBuild in_mod)							:= output('Biz Custom2 KeymoveQA not used');

		export BuildI_Biz_Custom3_keybuild(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom3 Keybuild not used');
		export BuildI_Biz_Custom3_keymove(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom3 Keymove not used');
		export BuildI_Biz_Custom3_KeymoveQA(AutoKeyI.InterfaceForBuild in_mod)							:= output('Biz Custom3 KeymoveQA not used');
		
		export BuildI_Biz_Custom4_keybuild(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom4 Keybuild not used');
		export BuildI_Biz_Custom4_keymove(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom4 Keymove not used');
		export BuildI_Biz_Custom4_KeymoveQA(AutoKeyI.InterfaceForBuild in_mod)							:= output('Biz Custom4 KeymoveQA not used');
		
		export BuildI_Biz_Custom5_keybuild(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom5 Keybuild not used');
		export BuildI_Biz_Custom5_keymove(AutoKeyI.InterfaceForBuild in_mod)								:= output('Biz Custom5 Keymove not used');		
		export BuildI_Biz_Custom5_KeymoveQA(AutoKeyI.InterfaceForBuild in_mod)							:= output('Biz Custom5 KeymoveQA not used');		
	
	END;
	
	

	export DoBuild := MODULE(IBuild)END; //instantiate

END;