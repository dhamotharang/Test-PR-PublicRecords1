//designed to replace Autokey.Keys
//follows structure of Autokey.IFetch
export BuildI_Indv := 
MODULE

	//this defines the default build code
	export IBuild := 
	INTERFACE
	
		export BuildI_Indv_Address_keybuild(AutoKeyI.BuildI_Indv_Address.params in_mod) 				:= AutoKeyI.BuildI_Indv_Address.keybuild(in_mod);
		export BuildI_Indv_Address_keymove(AutoKeyI.BuildI_Indv_Address.params in_mod) 					:= AutoKeyI.BuildI_Indv_Address.keymove(in_mod);
		export BuildI_Indv_Address_keymoveQA(AutoKeyI.BuildI_Indv_Address.params in_mod) 				:= AutoKeyI.BuildI_Indv_Address.keymoveQA(in_mod);

		export BuildI_Indv_CityStName_keybuild(AutoKeyI.BuildI_Indv_CityStName.params in_mod) 	:= AutoKeyI.BuildI_Indv_CityStName.keybuild(in_mod);
		export BuildI_Indv_CityStName_keymove(AutoKeyI.BuildI_Indv_CityStName.params in_mod) 		:= AutoKeyI.BuildI_Indv_CityStName.keymove(in_mod);
		export BuildI_Indv_CityStName_keymoveQA(AutoKeyI.BuildI_Indv_CityStName.params in_mod)	:= AutoKeyI.BuildI_Indv_CityStName.keymoveQA(in_mod);

		export BuildI_Indv_Name_keybuild(AutoKeyI.BuildI_Indv_Name.params in_mod) 							:= AutoKeyI.BuildI_Indv_Name.keybuild(in_mod);
		export BuildI_Indv_Name_keymove(AutoKeyI.BuildI_Indv_Name.params in_mod) 								:= AutoKeyI.BuildI_Indv_Name.keymove(in_mod);
		export BuildI_Indv_Name_keymoveQA(AutoKeyI.BuildI_Indv_Name.params in_mod) 							:= AutoKeyI.BuildI_Indv_Name.keymoveQA(in_mod);
		
		export BuildI_Indv_Phone_keybuild(AutoKeyI.BuildI_Indv_Phone.params in_mod) 						:= AutoKeyI.BuildI_Indv_Phone.keybuild(in_mod);
		export BuildI_Indv_Phone_keymove(AutoKeyI.BuildI_Indv_Phone.params in_mod) 							:= AutoKeyI.BuildI_Indv_Phone.keymove(in_mod);
		export BuildI_Indv_Phone_keymoveQA(AutoKeyI.BuildI_Indv_Phone.params in_mod) 						:= AutoKeyI.BuildI_Indv_Phone.keymoveQA(in_mod);
		
		export BuildI_Indv_SSN_keybuild(AutoKeyI.BuildI_Indv_SSN.params in_mod) 								:= AutoKeyI.BuildI_Indv_SSN.keybuild(in_mod);
		export BuildI_Indv_SSN_keymove(AutoKeyI.BuildI_Indv_SSN.params in_mod) 									:= AutoKeyI.BuildI_Indv_SSN.keymove(in_mod);
		export BuildI_Indv_SSN_keymoveQA(AutoKeyI.BuildI_Indv_SSN.params in_mod) 								:= AutoKeyI.BuildI_Indv_SSN.keymoveQA(in_mod);
		
		export BuildI_Indv_StName_keybuild(AutoKeyI.BuildI_Indv_StName.params in_mod) 					:= AutoKeyI.BuildI_Indv_StName.keybuild(in_mod);
		export BuildI_Indv_StName_keymove(AutoKeyI.BuildI_Indv_StName.params in_mod) 						:= AutoKeyI.BuildI_Indv_StName.keymove(in_mod);
		export BuildI_Indv_StName_keymoveQA(AutoKeyI.BuildI_Indv_StName.params in_mod) 					:= AutoKeyI.BuildI_Indv_StName.keymoveQA(in_mod);

		export BuildI_Indv_Zip_keybuild(AutoKeyI.BuildI_Indv_Zip.params in_mod) 								:= AutoKeyI.BuildI_Indv_Zip.keybuild(in_mod);
		export BuildI_Indv_Zip_keymove(AutoKeyI.BuildI_Indv_Zip.params in_mod) 									:= AutoKeyI.BuildI_Indv_Zip.keymove(in_mod);
		export BuildI_Indv_Zip_keymoveQA(AutoKeyI.BuildI_Indv_Zip.params in_mod) 								:= AutoKeyI.BuildI_Indv_Zip.keymoveQA(in_mod);

		export BuildI_Indv_ZipPRLName_keybuild(AutoKeyI.BuildI_Indv_ZipPRLName.params in_mod) 	:= AutoKeyI.BuildI_Indv_ZipPRLName.keybuild(in_mod);
		export BuildI_Indv_ZipPRLName_keymove(AutoKeyI.BuildI_Indv_ZipPRLName.params in_mod) 		:= AutoKeyI.BuildI_Indv_ZipPRLName.keymove(in_mod);
		export BuildI_Indv_ZipPRLName_keymoveQA(AutoKeyI.BuildI_Indv_ZipPRLName.params in_mod)	:= AutoKeyI.BuildI_Indv_ZipPRLName.keymoveQA(in_mod);

		//this is where you can add in custom keys
		export BuildI_Indv_Custom1_keybuild(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom1 Keybuild not used');
		export BuildI_Indv_Custom1_keymove(AutoKeyI.InterfaceForBuild in_mod)										:= output('Indv Custom1 Keymove not used');
		export BuildI_Indv_Custom1_keymoveQA(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom1 KeymoveQA not used');

		export BuildI_Indv_Custom2_keybuild(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom2 Keybuild not used');
		export BuildI_Indv_Custom2_keymove(AutoKeyI.InterfaceForBuild in_mod)										:= output('Indv Custom2 Keymove not used');
		export BuildI_Indv_Custom2_keymoveQA(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom2 KeymoveQA not used');

		export BuildI_Indv_Custom3_keybuild(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom3 Keybuild not used');
		export BuildI_Indv_Custom3_keymove(AutoKeyI.InterfaceForBuild in_mod)										:= output('Indv Custom3 Keymove not used');
		export BuildI_Indv_Custom3_keymoveQA(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom3 KeymoveQA not used');
		
		export BuildI_Indv_Custom4_keybuild(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom4 Keybuild not used');
		export BuildI_Indv_Custom4_keymove(AutoKeyI.InterfaceForBuild in_mod)										:= output('Indv Custom4 Keymove not used');
		export BuildI_Indv_Custom4_keymoveQA(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom4 KeymoveQA not used');
		
		export BuildI_Indv_Custom5_keybuild(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom5 Keybuild not used');
		export BuildI_Indv_Custom5_keymove(AutoKeyI.InterfaceForBuild in_mod)										:= output('Indv Custom5 Keymove not used');		
		export BuildI_Indv_Custom5_keymoveQA(AutoKeyI.InterfaceForBuild in_mod)									:= output('Indv Custom5 KeymoveQA not used');		
	
	END;
	
	

	export DoBuild := MODULE(IBuild)END; //instantiate

END;