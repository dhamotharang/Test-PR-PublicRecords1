export Daily_AsMasters := function

	combine_00 := Bankruptcy_AsMasters;
	// combine_01 := Function_Rollup_Masters(combine_00,DCA_AsMasters);	
	
	selected_combine := combine_00;
	
	final_combine := module(Interface_AsMasters.Unlinked.Base)
		export dataset(Layout_Linking.Unlinked) As_Linking_Master := selected_combine.As_Linking_Master;
		export dataset(Layout_URLs.Unlinked) As_URL_Master := selected_combine.As_URL_Master;
		export dataset(Layout_TradeLines.Unlinked) As_TradeLine_Master := selected_combine.As_TradeLine_Master;
		export dataset(Layout_Contacts.Unlinked) As_Contact_Master := selected_combine.As_Contact_Master;
	  export dataset(Layout_Finance.Unlinked) As_Finance_Master := selected_combine.As_Finance_Master;
		export dataset(Layout_Industry.Unlinked) As_Industry_Master := selected_combine.As_Industry_Master;
		export dataset(Layout_Incorporation.UnLinked) As_Incorporation_Master := selected_combine.As_Incorporation_Master;
		export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := selected_combine.As_Relationship_Master;
		export dataset(Layout_Mark.Unlinked) As_Mark_Master := selected_combine.As_Mark_Master;		
    export dataset(Layout_UCC.Main.Unlinked) As_UCC_Master := selected_combine.As_UCC_Master;
		export dataset(Layout_UCC.Party) As_UCC_Master_Party := selected_combine.As_UCC_Master_Party;
		export dataset(Layout_UCC.Collateral) As_UCC_Master_Collateral := selected_combine.As_UCC_Master_Collateral;
    export dataset(Layout_Bankruptcy.Main.Unlinked) As_Bankruptcy_Master := selected_combine.As_Bankruptcy_Master;
    export dataset(Layout_Bankruptcy.Party) As_Bankruptcy_Master_Party := selected_combine.As_Bankruptcy_Master_Party;
		export dataset(Layout_Liens.Main.Unlinked) As_Liens_Master := selected_combine.As_Liens_Master;
		export dataset(Layout_Liens.Party) As_Liens_Master_Party := selected_combine.As_Liens_Master_Party;
    export dataset(Layout_Aircraft.Main.Unlinked) As_Aircraft_Master := selected_combine.As_Aircraft_Master;
    export dataset(Layout_Aircraft.Party) As_Aircraft_Master_Party := selected_combine.As_Aircraft_Master_Party;
    export dataset(Layout_MotorVehicle.Main.Unlinked) As_MotorVehicle_Master := selected_combine.As_MotorVehicle_Master;
    export dataset(Layout_MotorVehicle.Registration) As_MotorVehicle_Master_Registration := selected_combine.As_MotorVehicle_Master_Registration;
    export dataset(Layout_MotorVehicle.Title) As_MotorVehicle_Master_Title := selected_combine.As_MotorVehicle_Master_Title;
    export dataset(Layout_MotorVehicle.Party) As_MotorVehicle_Master_Party := selected_combine.As_MotorVehicle_Master_Party;
    export dataset(Layout_Watercraft.Main.Unlinked) As_Watercraft_Master := selected_combine.As_Watercraft_Master;
		export dataset(Layout_Watercraft.Party) As_Watercraft_Master_Party := selected_combine.As_Watercraft_Master_Party;
		export dataset(Layout_Property.Main.Unlinked) As_Property_Master := selected_combine.As_Property_Master;
		export dataset(Layout_Property.Party.Unlinked) As_Property_Master_Party := selected_combine.As_Property_Master_Party;
		export dataset(Layout_Property.Assessment.Unlinked) As_Property_Master_Assessment := selected_combine.As_Property_Master_Assessment;
		export dataset(Layout_Property.Deed.Unlinked) As_Property_Master_Deed := selected_combine.As_Property_Master_Deed;
		export dataset(Layout_Property.Foreclosure.Unlinked) As_Property_Master_Foreclosure := selected_combine.As_Property_Master_Foreclosure;
		export dataset(Layout_Abstract.Unlinked) As_Abstract_Master := selected_combine.As_Abstract_Master;
		export dataset(Layout_License.Unlinked) As_License_Master := selected_combine.As_License_Master;
	end;
	
	return final_combine;

end;
