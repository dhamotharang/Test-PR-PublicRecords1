import doxie, tools,autokeyb2;

export Keys(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) := module

	export Abstract := KeyPrep_Abstract_ID(Files(pversion,pUseOtherEnvironment).Abstract.Linked.Built,pversion,pUseOtherEnvironment);
	export AddressesPhones := KeyPrep_AddressesPhones_ID(Files(pversion,pUseOtherEnvironment).Linking.Linked.Built,pversion,pUseOtherEnvironment);
  export Aircraft := module
		export Main := KeyPrep_Aircraft_ID(Files(pversion,pUseOtherEnvironment).Aircraft.Main.Linked.Built,pversion,pUseOtherEnvironment);
		export Party := KeyPrep_Aircraft_Party(Files(pversion,pUseOtherEnvironment).Aircraft.Party.Built,pversion,pUseOtherEnvironment);
	end;
	export Bankruptcy := module
		export Main := KeyPrep_Bankruptcy_ID(Files(pversion,pUseOtherEnvironment).Bankruptcy.Main.Linked.Built,pversion,pUseOtherEnvironment);
		export Party := KeyPrep_Bankruptcy_Party(Files(pversion,pUseOtherEnvironment).Bankruptcy.Party.Built,pversion,pUseOtherEnvironment);
	end;
	export Contacts := KeyPrep_Contacts_ID(Files(pversion,pUseOtherEnvironment).Contacts.Linked.Built,pversion,pUseOtherEnvironment);
	export ContactsDID := KeyPrep_Contacts_DID(Files(pversion,pUseOtherEnvironment).Contacts.Linked.Built,pversion,pUseOtherEnvironment);
	export Finance := KeyPrep_Finance_ID(Files(pversion,pUseOtherEnvironment).Finance.Linked.Built,pversion,pUseOtherEnvironment);
	export Incorporation := KeyPrep_Incorporation_ID(Files(pversion,pUseOtherEnvironment).Incorporation.Linked.Built,pversion,pUseOtherEnvironment);
	export Industry := KeyPrep_Industry_ID(Files(pversion,pUseOtherEnvironment).Industry.Linked.Built,pversion,pUseOtherEnvironment);
	export License := KeyPrep_License_ID(Files(pversion,pUseOtherEnvironment).License.Linked.Built,pversion,pUseOtherEnvironment);
	export Liens := module
		export Main := KeyPrep_Liens_ID(Files(pversion,pUseOtherEnvironment).Liens.Main.Linked.Built,pversion,pUseOtherEnvironment);
		export Party := KeyPrep_Liens_Party(Files(pversion,pUseOtherEnvironment).Liens.Party.Built,pversion,pUseOtherEnvironment);
	end;
	export LinkDiagnostic := KeyPrep_LinkDiagnostic_BEID(Files(pversion,pUseOtherEnvironment).Linking.Linked.Built,pversion,pUseOtherEnvironment);
	export LLID12 := KeyPrep_LLID12_ID(Files(pversion,pUseOtherEnvironment).LLID12.Linked.Built,pversion,pUseOtherEnvironment);
	export LLID9 := KeyPrep_LLID9_ID(Files(pversion,pUseOtherEnvironment).LLID9.Linked.Built,pversion,pUseOtherEnvironment);
	export MatchDiagnostic := KeyPrep_MatchDiagnostic_BEID(Files(pversion,pUseOtherEnvironment).Match.Linked.Built,pversion,pUseOtherEnvironment);
  export MotorVehicle := module
	  export Main := KeyPrep_MotorVehicle_ID(Files(pversion,pUseOtherEnvironment).MotorVehicle.Main.Linked.Built,pversion,pUseOtherEnvironment);
	  export Title := KeyPrep_MotorVehicle_Title(Files(pversion,pUseOtherEnvironment).MotorVehicle.Title.Built,pversion,pUseOtherEnvironment);
	  export Registration := KeyPrep_MotorVehicle_Registration(Files(pversion,pUseOtherEnvironment).MotorVehicle.Registration.Built,pversion,pUseOtherEnvironment);
		export Party := KeyPrep_MotorVehicle_Party(Files(pversion,pUseOtherEnvironment).MotorVehicle.Party.Linked.Built,pversion,pUseOtherEnvironment);
	end;
	export NamesFEINs := KeyPrep_NamesFEINs_ID(Files(pversion,pUseOtherEnvironment).Linking.Linked.Built,pversion,pUseOtherEnvironment);
	export Property := module
		export Main := KeyPrep_Property_ID(Files(pversion,pUseOtherEnvironment).Property.Main.Linked.Built,pversion,pUseOtherEnvironment);
		export Party := KeyPrep_Property_Party(Files(pversion,pUseOtherEnvironment).Property.Party.Linked.Built,pversion,pUseOtherEnvironment);
    export Assessment := KeyPrep_Property_Assessment(Files(pversion,pUseOtherEnvironment).Property.Assessment.Linked.Built,pversion,pUseOtherEnvironment);
    export Deed := KeyPrep_Property_Deed(Files(pversion,pUseOtherEnvironment).Property.Deed.Linked.Built,pversion,pUseOtherEnvironment);
    export Foreclosure := KeyPrep_Property_Foreclosure(Files(pversion,pUseOtherEnvironment).Property.Foreclosure.Linked.Built,pversion,pUseOtherEnvironment);
	end;
	export Relationship := KeyPrep_Relationship_ID(Files(pversion,pUseOtherEnvironment).Relationship.Linked.Built,pversion,pUseOtherEnvironment);
	export Source := KeyPrep_Source_ID(
		Files(pversion,pUseOtherEnvironment).Linking.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Industry.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Abstract.Linked.Built,
		Files(pversion,pUseOtherEnvironment).UCC.Main.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Liens.Main.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Aircraft.Main.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Watercraft.Main.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Incorporation.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Mark.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Bankruptcy.Main.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Finance.Linked.Built,
		Files(pversion,pUseOtherEnvironment).Property.Main.Linked.Built,
		pversion,
		pUseOtherEnvironment);

	export TradeLines := KeyPrep_TradeLines_ID(Files(pversion,pUseOtherEnvironment).TradeLines.Linked.Built,pversion,pUseOtherEnvironment);
	export UCC := module
    export Main := KeyPrep_UCC_ID(Files(pversion,pUseOtherEnvironment).UCC.Main.Linked.Built,pversion,pUseOtherEnvironment);
		export Party := KeyPrep_UCC_Party(Files(pversion,pUseOtherEnvironment).UCC.Party.Built,pversion,pUseOtherEnvironment);
		export Collateral := KeyPrep_UCC_Collateral(Files(pversion,pUseOtherEnvironment).UCC.Collateral.Built,pversion,pUseOtherEnvironment);
	end;
	export URLs := KeyPrep_URLs_ID(Files(pversion,pUseOtherEnvironment).URLs.Linked.Built,pversion,pUseOtherEnvironment);
  export Watercraft := module
	  export Main := KeyPrep_Watercraft_ID(Files(pversion,pUseOtherEnvironment).Watercraft.Main.Linked.Built,pversion,pUseOtherEnvironment);
		export Party := KeyPrep_Watercraft_Party(Files(pversion,pUseOtherEnvironment).Watercraft.Party.Built,pversion,pUseOtherEnvironment);
  end;

end;
