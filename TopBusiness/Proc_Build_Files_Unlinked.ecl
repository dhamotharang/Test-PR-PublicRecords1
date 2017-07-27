import tools;

export Proc_Build_Files_Unlinked(Interface_AsMasters.Unlinked.Base in_masters,string version) := function
	
	tools.mac_WriteFile(Filenames(version).Linking.Unlinked.New,in_masters.As_Linking_Master,Build_Base_Linking_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).URLs.Unlinked.New,in_masters.As_URL_Master,Build_Base_URL_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).TradeLines.Unlinked.New,in_masters.As_TradeLine_Master,Build_Base_TradeLines_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Contacts.Unlinked.New,in_masters.As_Contact_Master,Build_Base_Contacts_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Finance.Unlinked.New,in_masters.As_Finance_Master,Build_Base_Finance_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Industry.Unlinked.New,in_masters.As_Industry_Master,Build_Base_Industry_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Incorporation.Unlinked.New,in_masters.As_Incorporation_Master,Build_Base_Incorporation_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Relationship.Unlinked.New,in_masters.As_Relationship_Master,Build_Base_Relationship_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Abstract.Unlinked.New,in_masters.As_Abstract_Master,Build_Base_Abstract_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).License.Unlinked.New,in_masters.As_License_Master,Build_Base_License_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Mark.Unlinked.New,in_masters.As_Mark_Master,Build_Base_Mark_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).UCC.Main.Unlinked.New,in_masters.As_UCC_Master,Build_Base_UCC_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Bankruptcy.Main.Unlinked.New,in_masters.As_Bankruptcy_Master,Build_Base_Bankruptcy_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Liens.Main.Unlinked.New,in_masters.As_Liens_Master,Build_Base_Liens_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Aircraft.Main.Unlinked.New,in_masters.As_Aircraft_Master,Build_Base_Aircraft_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Watercraft.Main.Unlinked.New,in_masters.As_Watercraft_Master,Build_Base_Watercraft_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).MotorVehicle.Main.Unlinked.New,in_masters.As_MotorVehicle_Master,Build_Base_MotorVehicle_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Main.Unlinked.New,in_masters.As_Property_Master,Build_Base_Property_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Party.Unlinked.New,in_masters.As_Property_Master_Party,Build_Base_Property_Party_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Assessment.Unlinked.New,in_masters.As_Property_Master_Assessment,Build_Base_Property_Assessment_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Deed.Unlinked.New,in_masters.As_Property_Master_Deed,Build_Base_Property_Deed_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Foreclosure.Unlinked.New,in_masters.As_Property_Master_Foreclosure,Build_Base_Property_Foreclosure_File,pShouldExport := false);


	return
		if(tools.fun_IsValidVersion(version)
			,sequential(
				parallel(
					Build_Base_Linking_File,
					Build_Base_URL_File,
					Build_Base_TradeLines_File,
					Build_Base_Contacts_File,
					Build_Base_Finance_File,
					Build_Base_Industry_File,
					Build_Base_Incorporation_File,
					Build_Base_Relationship_File,
					Build_Base_Abstract_File,
					Build_Base_License_File,
					Build_Base_Mark_File,
					Build_Base_UCC_Main_File,
					Build_Base_Bankruptcy_Main_File,
					Build_Base_Liens_Main_File,
					Build_Base_Aircraft_Main_File,
					Build_Base_Watercraft_Main_File,
					Build_Base_MotorVehicle_File,
					Build_Base_Property_File,
					Build_Base_Property_Party_File,
					Build_Base_Property_Assessment_File,
					Build_Base_Property_Deed_File,
					Build_Base_Property_Foreclosure_File),
				Promote(version).buildfiles.New2Built
			)		
			,output('No Valid version parameter passed, skipping BRM.Proc_Build_Files_Unlinked atribute')
		);

end;
