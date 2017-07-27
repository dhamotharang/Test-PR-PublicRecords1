import doxie, Tools, VersionControl, TopBusiness_External, TopBusiness_Search;

export Proc_Build_Keys(
	string version) := function

	tools.mac_WriteIndex('Keys(version).Abstract.New',BuildAbstractKey);
	tools.mac_WriteIndex('Keys(version).AddressesPhones.New',BuildAddressesPhonesKey);
  tools.mac_WriteIndex('Keys(version).Aircraft.Main.New',BuildAircraftMainKey);
	tools.mac_WriteIndex('Keys(version).Aircraft.Party.New',BuildAircraftPartyKey);
	tools.mac_WriteIndex('Keys(version).Bankruptcy.Main.New',BuildBankruptcyMainKey);
	tools.mac_WriteIndex('Keys(version).Bankruptcy.Party.New',BuildBankruptcyPartyKey);
	tools.mac_WriteIndex('Keys(version).Contacts.New',BuildContactsKey);
	tools.mac_WriteIndex('Keys(version).Finance.New',BuildFinanceKey);
	tools.mac_WriteIndex('Keys(version).Incorporation.New',BuildIncorporationKey);
	tools.mac_WriteIndex('Keys(version).Industry.New',BuildIndustryKey);
	tools.mac_WriteIndex('Keys(version).License.New',BuildLicenseKey);
	tools.mac_WriteIndex('Keys(version).Liens.Main.New',BuildLiensMainKey);
	tools.mac_WriteIndex('Keys(version).Liens.Party.New',BuildLiensPartyKey);
	tools.mac_WriteIndex('Keys(version).LinkDiagnostic.New',BuildLinkDiagnosticKey);
	tools.mac_WriteIndex('Keys(version).LLID.New',BuildLLIDKey);
	tools.mac_WriteIndex('Keys(version).MatchDiagnostic.New',BuildMatchDiagnosticKey);
  tools.mac_WriteIndex('Keys(version).MotorVehicle.Main.New',BuildMotorVehicleMainKey);
	tools.mac_WriteIndex('Keys(version).MotorVehicle.Title.New',BuildMotorVehicleTitleKey);
	tools.mac_WriteIndex('Keys(version).MotorVehicle.Registration.New',BuildMotorVehicleRegistrationKey);
	tools.mac_WriteIndex('Keys(version).MotorVehicle.Party.New',BuildMotorVehiclePartyKey);
	tools.mac_WriteIndex('Keys(version).NamesFEINs.New',BuildNamesFEINsKey);
	tools.mac_WriteIndex('Keys(version).Property.Main.New',BuildPropertyMainKey);
	tools.mac_WriteIndex('Keys(version).Property.Party.New',BuildPropertyPartyKey);
	tools.mac_WriteIndex('Keys(version).Property.Assessment.New',BuildPropertyAssessmentKey);
	tools.mac_WriteIndex('Keys(version).Property.Deed.New',BuildPropertyDeedKey);
	tools.mac_WriteIndex('Keys(version).Property.Foreclosure.New',BuildPropertyForeclosureKey);
	tools.mac_WriteIndex('Keys(version).Relationship.New',BuildRelationshipKey);
	tools.mac_WriteIndex('Keys(version).Source.New',BuildSourceKey);
	tools.mac_WriteIndex('Keys(version).TradeLines.New',BuildTradeLinesKey);
	tools.mac_WriteIndex('Keys(version).UCC.Main.New',BuildUCCMainKey);
	tools.mac_WriteIndex('Keys(version).UCC.Party.New',BuildUCCPartyKey);
	tools.mac_WriteIndex('Keys(version).UCC.Collateral.New',BuildUCCCollateralKey);
	tools.mac_WriteIndex('Keys(version).URLs.New',BuildURLsKey);
  tools.mac_WriteIndex('Keys(version).Watercraft.Main.New',BuildWatercraftMainKey);
	tools.mac_WriteIndex('Keys(version).Watercraft.Party.New',BuildWatercraftPartyKey);
	
	return
		if(tools.fun_IsValidVersion(version),
			sequential(
				 TopBusiness_External.Proc_Build_Keys_External(version)
				,TopBusiness_Search.Build_Keys(version)
				,parallel(
					 BuildAbstractKey
					,BuildAddressesPhonesKey
					,BuildAircraftMainKey
					,BuildAircraftPartyKey
					,BuildBankruptcyMainKey
					,BuildBankruptcyPartyKey
					,BuildContactsKey
					,BuildFinanceKey
					,BuildIncorporationKey
					,BuildIndustryKey
					,BuildLicenseKey
					,BuildLiensMainKey
					,BuildLiensPartyKey
					,BuildLinkDiagnosticKey
					,BuildLLIDKey
					,BuildMatchDiagnosticKey
					,BuildMotorVehicleMainKey
					,BuildMotorVehicleTitleKey
					,BuildMotorVehicleRegistrationKey
					,BuildMotorVehiclePartyKey
					,BuildNamesFEINsKey
					,BuildPropertyMainKey
					,BuildPropertyPartyKey
					,BuildPropertyAssessmentKey
					,BuildPropertyDeedKey
					,BuildPropertyForeclosureKey
					,BuildRelationshipKey
					,BuildSourceKey
					,BuildTradeLinesKey
					,BuildUCCMainKey
					,BuildUCCPartyKey
					,BuildUCCCollateralKey
					,BuildURLsKey
					,BuildWatercraftMainKey
					,BuildWatercraftPartyKey
							 )
				,Promote(version).KeyFiles.New2Built)
			,output('No Valid version parameter passed, skipping TopBusiness.Proc_Build_Keys atribute'));

end;
