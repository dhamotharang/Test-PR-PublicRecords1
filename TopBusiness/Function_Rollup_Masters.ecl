export Function_Rollup_Masters(
	Interface_AsMasters.Unlinked.Base mod1,
	Interface_AsMasters.Unlinked.Base mod2) := module(Interface_AsMasters.Unlinked.Base)

	export dataset(Layout_Linking.Unlinked) As_Linking_Master := mod1.As_Linking_Master + mod2.As_Linking_Master;
	export dataset(Layout_URLs.Unlinked) As_URL_Master := mod1.As_URL_Master + mod2.As_URL_Master;
	export dataset(Layout_TradeLines.Unlinked) As_TradeLine_Master := mod1.As_TradeLine_Master + mod2.As_TradeLine_Master;
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := mod1.As_Contact_Master + mod2.As_Contact_Master;
	export dataset(Layout_Finance.Unlinked) As_Finance_Master := mod1.As_Finance_Master + mod2.As_Finance_Master;
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := mod1.As_Industry_Master + mod2.As_Industry_Master;
  export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := mod1.As_Incorporation_Master + mod2.As_Incorporation_Master;
	export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := mod1.As_Relationship_Master + mod2.As_Relationship_Master;
	export dataset(Layout_Mark.Unlinked) As_Mark_Master := mod1.As_Mark_Master + mod2.As_Mark_Master;
	export dataset(Layout_UCC.Main.Unlinked) As_Ucc_Master := mod1.As_UCC_Master + mod2.As_UCC_Master;	
	export dataset(Layout_UCC.Party) As_Ucc_Master_Party := mod1.As_UCC_Master_Party + mod2.As_UCC_Master_Party;	
	export dataset(Layout_UCC.Collateral) As_Ucc_Master_Collateral := mod1.As_UCC_Master_Collateral + mod2.As_UCC_Master_Collateral;	
	export dataset(Layout_Bankruptcy.Main.Unlinked) As_Bankruptcy_Master := mod1.As_Bankruptcy_Master + mod2.As_Bankruptcy_Master;
	export dataset(Layout_Bankruptcy.Party) As_Bankruptcy_Master_Party := mod1.As_Bankruptcy_Master_Party + mod2.As_Bankruptcy_Master_Party;
	export dataset(Layout_Liens.Main.Unlinked) As_Liens_Master := mod1.As_Liens_Master + mod2.As_Liens_Master;	
	export dataset(Layout_Liens.Party) As_Liens_Master_Party := mod1.As_Liens_Master_Party + mod2.As_Liens_Master_Party;	
	export dataset(Layout_Aircraft.Main.Unlinked) As_Aircraft_Master := mod1.As_Aircraft_Master + mod2.As_Aircraft_Master;
	export dataset(Layout_Aircraft.Party) As_Aircraft_Master_Party := mod1.As_Aircraft_Master_Party + mod2.As_Aircraft_Master_Party;
	export dataset(Layout_MotorVehicle.Main.Unlinked) As_MotorVehicle_Master := mod1.As_MotorVehicle_Master + mod2.As_MotorVehicle_Master;
	export dataset(Layout_MotorVehicle.Registration) As_MotorVehicle_Master_Registration := mod1.As_MotorVehicle_Master_Registration + mod2.As_MotorVehicle_Master_Registration;
	export dataset(Layout_MotorVehicle.Title) As_MotorVehicle_Master_Title := mod1.As_MotorVehicle_Master_Title + mod2.As_MotorVehicle_Master_Title;
	export dataset(Layout_MotorVehicle.Party.Unlinked) As_MotorVehicle_Master_Party := mod1.As_MotorVehicle_Master_Party + mod2.As_MotorVehicle_Master_Party;
	export dataset(Layout_Watercraft.main.Unlinked) As_Watercraft_Master := mod1.As_Watercraft_Master + mod2.As_Watercraft_Master;
	export dataset(Layout_Watercraft.Party) As_Watercraft_Master_Party := mod1.As_Watercraft_Master_Party + mod2.As_Watercraft_Master_Party;
  export dataset(Layout_Property.Main.Unlinked) As_Property_Master := mod1.As_Property_Master + mod2.As_Property_Master;
	export dataset(Layout_Property.Party.Unlinked) As_Property_Master_Party := mod1.As_Property_Master_Party + mod2.As_Property_Master_Party;
	export dataset(Layout_Property.Assessment.Unlinked) As_Property_Master_Assessment := mod1.As_Property_Master_Assessment + mod2.As_Property_Master_Assessment;
	export dataset(Layout_Property.Deed.Unlinked) As_Property_Master_Deed := mod1.As_Property_Master_Deed + mod2.As_Property_Master_Deed;
	export dataset(Layout_Property.Foreclosure.Unlinked) As_Property_Master_Foreclosure := mod1.As_Property_Master_Foreclosure + mod2.As_Property_Master_Foreclosure;
	export dataset(Layout_Abstract.Unlinked) As_Abstract_Master := mod1.As_Abstract_Master + mod2.As_Abstract_Master;
	export dataset(Layout_License.Unlinked) As_License_Master := mod1.As_License_Master + mod2.As_License_Master;
end;
