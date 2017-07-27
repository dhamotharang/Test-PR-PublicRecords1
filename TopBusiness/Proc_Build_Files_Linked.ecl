import tools;

export Proc_Build_Files_Linked(Interface_AsMasters.Linked.Base in_masters,string version) := function
	
	tools.mac_WriteFile(Filenames(version).LLID.Linked.New,in_masters.As_LLID_Master,Build_Base_LLID_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).URLs.Linked.New,in_masters.As_URL_Master,Build_Base_URL_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).TradeLines.Linked.New,in_masters.As_TradeLine_Master,Build_Base_TradeLines_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Contacts.Linked.New,in_masters.As_Contact_Master,Build_Base_Contacts_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Finance.Linked.New,in_masters.As_Finance_Master,Build_Base_Finance_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Industry.Linked.New,in_masters.As_Industry_Master,Build_Base_Industry_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Incorporation.Linked.New,in_masters.As_Incorporation_Master,Build_Base_Incorporation_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Relationship.Linked.New,in_masters.As_Relationship_Master,Build_Base_Relationship_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Abstract.Linked.New,in_masters.As_Abstract_Master,Build_Base_Abstract_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).License.Linked.New,in_masters.As_License_Master,Build_Base_License_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Mark.Linked.New,in_masters.As_Mark_Master,Build_Base_Mark_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).UCC.Main.Linked.New,in_masters.As_UCC_Master,Build_Base_UCC_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Bankruptcy.Main.Linked.New,in_masters.As_Bankruptcy_Master,Build_Base_Bankruptcy_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Liens.Main.Linked.New,in_masters.As_Liens_Master,Build_Base_Liens_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Aircraft.Main.Linked.New,in_masters.As_Aircraft_Master,Build_Base_Aircraft_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Watercraft.Main.Linked.New,in_masters.As_Watercraft_Master,Build_Base_Watercraft_Main_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).MotorVehicle.Main.Linked.New,in_masters.As_MotorVehicle_Master,Build_Base_MotorVehicle_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Main.Linked.New,in_masters.As_Property_Master,Build_Base_Property_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Party.Linked.New,in_masters.As_Property_Master_Party,Build_Base_Property_Party_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Assessment.Linked.New,in_masters.As_Property_Master_Assessment,Build_Base_Property_Assessment_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Deed.Linked.New,in_masters.As_Property_Master_Deed,Build_Base_Property_Deed_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Property.Foreclosure.Linked.New,in_masters.As_Property_Master_Foreclosure,Build_Base_Property_Foreclosure_File,pShouldExport := false);

	tools.mac_WriteFile(Filenames(version).UCC.Party.New,in_masters.As_UCC_Master_Party,Build_Base_UCC_Party_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).UCC.Collateral.New,in_masters.As_UCC_Master_Collateral,Build_Base_UCC_Collateral_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Bankruptcy.Party.New,in_masters.As_Bankruptcy_Master_Party,Build_Base_Bankruptcy_Party_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Liens.Party.New,in_masters.As_Liens_Master_Party,Build_Base_Liens_Party_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Aircraft.Party.New,in_masters.As_Aircraft_Master_Party,Build_Base_Aircraft_Party_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Watercraft.Party.New,in_masters.As_Watercraft_Master_Party,Build_Base_Watercraft_Party_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).MotorVehicle.Registration.New,in_masters.As_MotorVehicle_Master_Registration,Build_Base_MotorVehicle_Registration_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).MotorVehicle.Title.New,in_masters.As_MotorVehicle_Master_Title,Build_Base_MotorVehicle_Title_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).MotorVehicle.Party.New,in_masters.As_MotorVehicle_Master_Party,Build_Base_MotorVehicle_Party_File,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(version)
			,sequential(
				parallel(
					Build_Base_UCC_Party_File,
					Build_Base_UCC_Collateral_File,
					Build_Base_Bankruptcy_Party_File,
					Build_Base_Liens_Party_File,
					Build_Base_Aircraft_Party_File,
					Build_Base_Watercraft_Party_File,
					Build_Base_MotorVehicle_Registration_File,
					Build_Base_MotorVehicle_Title_File,
					Build_Base_MotorVehicle_Party_File,

					Build_Base_LLID_File,
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
			,output('No Valid version parameter passed, skipping BRM.Proc_Build_Files_Linked atribute')
		);

end;
