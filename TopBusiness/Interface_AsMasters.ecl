export Interface_AsMasters := module

	export Unlinked := module
	
		export Base := interface
		
			export dataset(Layout_Linking.Unlinked) As_Linking_Master;
			export dataset(Layout_URLs.Unlinked) As_URL_Master;
			export dataset(Layout_TradeLines.Unlinked) As_TradeLine_Master;
			export dataset(Layout_Contacts.Unlinked) As_Contact_Master;
			export dataset(Layout_Finance.Unlinked) As_Finance_Master;
			export dataset(Layout_Industry.Unlinked) As_Industry_Master;
			export dataset(Layout_Incorporation.UnLinked) As_Incorporation_Master;
			export dataset(Layout_Relationship.Unlinked) As_Relationship_Master;
			export dataset(Layout_Mark.Unlinked) As_Mark_Master;
			export dataset(Layout_UCC.Main.Unlinked) As_UCC_Master;
			export dataset(Layout_UCC.Party) As_UCC_Master_Party;
			export dataset(Layout_UCC.Collateral) As_UCC_Master_Collateral;
			export dataset(Layout_Bankruptcy.Main.Unlinked) As_Bankruptcy_Master;
			export dataset(Layout_Bankruptcy.Party) As_Bankruptcy_Master_Party;
			export dataset(Layout_Liens.Main.Unlinked) As_Liens_Master;
			export dataset(Layout_Liens.Party) As_Liens_Master_Party;
			export dataset(Layout_Aircraft.Main.Unlinked) As_Aircraft_Master;
			export dataset(Layout_Aircraft.Party) As_Aircraft_Master_Party;
			export dataset(Layout_MotorVehicle.Main.Unlinked) As_MotorVehicle_Master;
			export dataset(Layout_MotorVehicle.Registration) As_MotorVehicle_Master_Registration;
			export dataset(Layout_MotorVehicle.Title) As_MotorVehicle_Master_Title;
			export dataset(Layout_MotorVehicle.Party.Unlinked) As_MotorVehicle_Master_Party;
			export dataset(Layout_Watercraft.Main.Unlinked) As_Watercraft_Master;
			export dataset(Layout_Watercraft.Party) As_Watercraft_Master_Party;
      export dataset(Layout_Property.Main.Unlinked) As_Property_Master;
			export dataset(Layout_Property.Party.Unlinked) As_Property_Master_Party;
			export dataset(Layout_Property.Assessment.Unlinked) As_Property_Master_Assessment;
			export dataset(Layout_Property.Deed.Unlinked) As_Property_Master_Deed;
			export dataset(Layout_Property.Foreclosure.Unlinked) As_Property_Master_Foreclosure;
			export dataset(Layout_Abstract.Unlinked) As_Abstract_Master;
			export dataset(Layout_License.Unlinked) As_License_Master;
		end;
		
		export Default := interface(Base)
		
			export dataset(Layout_URLs.Unlinked) As_URL_Master := dataset([],Layout_URLs.Unlinked);
			export dataset(Layout_TradeLines.Unlinked) As_TradeLine_Master := dataset([],Layout_TradeLines.Unlinked);
			export dataset(Layout_Contacts.Unlinked) As_Contact_Master := dataset([],Layout_Contacts.Unlinked);
			export dataset(Layout_Finance.Unlinked) As_Finance_Master := dataset([],Layout_Finance.Unlinked);
			export dataset(Layout_Industry.Unlinked) As_Industry_Master := dataset([],Layout_Industry.Unlinked);
			export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := dataset([],Layout_Incorporation.Unlinked);
			export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := dataset([],Layout_Relationship.Unlinked);
			export dataset(Layout_Mark.Unlinked) As_Mark_Master := dataset([],Layout_Mark.Unlinked);
			export dataset(Layout_UCC.Main.Unlinked) As_UCC_Master := dataset([],Layout_UCC.Main.Unlinked);
			export dataset(Layout_UCC.Party) As_UCC_Master_Party := dataset([],Layout_UCC.Party);
			export dataset(Layout_UCC.Collateral) As_UCC_Master_Collateral := dataset([],Layout_UCC.Collateral);
			export dataset(Layout_Bankruptcy.Main.Unlinked) As_Bankruptcy_Master := dataset([],Layout_Bankruptcy.Main.Unlinked);
			export dataset(Layout_Bankruptcy.Party) As_Bankruptcy_Master_Party := dataset([],Layout_Bankruptcy.Party);
			export dataset(Layout_Liens.Main.Unlinked) As_Liens_Master := dataset([],Layout_Liens.Main.Unlinked);
			export dataset(Layout_Liens.Party) As_Liens_Master_Party := dataset([],Layout_Liens.Party);
			export dataset(Layout_Aircraft.Main.Unlinked) As_Aircraft_Master := dataset([],Layout_Aircraft.Main.Unlinked);
			export dataset(Layout_Aircraft.Party) As_Aircraft_Master_Party := dataset([],Layout_Aircraft.Party);
			export dataset(Layout_MotorVehicle.Main.Unlinked) As_MotorVehicle_Master := dataset([],Layout_MotorVehicle.Main.Unlinked);
			export dataset(Layout_MotorVehicle.Registration) As_MotorVehicle_Master_Registration := dataset([],Layout_MotorVehicle.Registration);
			export dataset(Layout_MotorVehicle.Title) As_MotorVehicle_Master_Title := dataset([],Layout_MotorVehicle.Title);
			export dataset(Layout_MotorVehicle.Party.Unlinked) As_MotorVehicle_Master_Party := dataset([],Layout_MotorVehicle.Party.Unlinked);
			export dataset(Layout_Watercraft.Main.Unlinked) As_Watercraft_Master := dataset([],Layout_Watercraft.Main.Unlinked);
			export dataset(Layout_Watercraft.Party) As_Watercraft_Master_Party := dataset([],Layout_Watercraft.Party);
			export dataset(Layout_Property.Main.Unlinked) As_Property_Master := dataset([],Layout_Property.Main.Unlinked);
			export dataset(Layout_Property.Party.Unlinked) As_Property_Master_Party := dataset([],Layout_Property.Party.Unlinked);
			export dataset(Layout_Property.Assessment.Unlinked) As_Property_Master_Assessment := dataset([],Layout_Property.Assessment.Unlinked);
			export dataset(Layout_Property.Deed.Unlinked) As_Property_Master_Deed := dataset([],Layout_Property.Deed.Unlinked);
			export dataset(Layout_Property.Foreclosure.Unlinked) As_Property_Master_Foreclosure := dataset([],Layout_Property.Foreclosure.Unlinked);
			export dataset(Layout_Abstract.Unlinked) As_Abstract_Master := dataset([],Layout_Abstract.Unlinked);
			export dataset(Layout_License.Unlinked) As_License_Master := dataset([],Layout_License.Unlinked);
		end;
	
	end;
	
	export Linkage := module
	
		export Base := interface
		
			export dataset(Layout_Linking.Match) As_Match_Master;
			export dataset(Layout_Linking.Linked) As_Linking_Master;
		
		end;
	
	end;
	
	export Linked := module
	
		export Base := interface
		
			export dataset(Layout_LLID.LLID12.Linked) As_LLID12_Master;
			export dataset(Layout_LLID.LLID9.Linked) As_LLID9_Master;
			export dataset(Layout_Contacts.Linked) As_Contact_Master;
			export dataset(Layout_TradeLines.Linked) As_TradeLine_Master;
			export dataset(Layout_URLs.Linked) As_URL_Master;
			export dataset(Layout_Finance.Linked) As_Finance_Master;
			export dataset(Layout_Industry.Linked) As_Industry_Master;
			export dataset(Layout_Incorporation.Linked) As_Incorporation_Master;
			export dataset(Layout_Mark.Linked) As_Mark_Master;
			export dataset(Layout_UCC.Main.Linked) As_UCC_Master;
			export dataset(Layout_UCC.Party) As_UCC_Master_Party;
			export dataset(Layout_UCC.Collateral) As_UCC_Master_Collateral;
			export dataset(Layout_Bankruptcy.Main.Linked) As_Bankruptcy_Master;
			export dataset(Layout_Bankruptcy.Party) As_Bankruptcy_Master_Party;
			export dataset(Layout_Liens.Main.Linked) As_Liens_Master;
			export dataset(Layout_Liens.Party) As_Liens_Master_Party;
			export dataset(Layout_Aircraft.Main.Linked) As_Aircraft_Master;
			export dataset(Layout_Aircraft.Party) As_Aircraft_Master_Party;
			export dataset(Layout_MotorVehicle.Main.Linked) As_MotorVehicle_Master;
			export dataset(Layout_MotorVehicle.Registration) As_MotorVehicle_Master_Registration;
			export dataset(Layout_MotorVehicle.Title) As_MotorVehicle_Master_Title;
			export dataset(Layout_MotorVehicle.Party.Linked) As_MotorVehicle_Master_Party;
			export dataset(Layout_Watercraft.Main.Linked) As_Watercraft_Master;
			export dataset(Layout_Watercraft.Party) As_Watercraft_Master_Party;
			export dataset(Layout_Relationship.Linked) As_Relationship_Master;
			export dataset(Layout_Property.Main.Linked) As_Property_Master;
			export dataset(Layout_Property.Party.Linked) As_Property_Master_Party;
			export dataset(Layout_Property.Assessment.Linked) As_Property_Master_Assessment;
			export dataset(Layout_Property.Deed.Linked) As_Property_Master_Deed;
			export dataset(Layout_Property.Foreclosure.Linked) As_Property_Master_Foreclosure;
			export dataset(Layout_Abstract.Linked) As_Abstract_Master;
			export dataset(Layout_License.Linked) As_License_Master;
		end;
	
	end;

end;
