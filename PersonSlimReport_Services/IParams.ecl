IMPORT PersonSlimReport_Services, BatchShare, ut, iesp;
EXPORT IParams := MODULE

	EXPORT PersonSlimReportOptions := INTERFACE
		EXPORT UNSIGNED1 GLBPurpose              := BatchShare.Constants.Defaults.GLBPurpose;  
		EXPORT UNSIGNED1 DPPAPurpose             := BatchShare.Constants.Defaults.DPPAPurpose;   
		EXPORT STRING    DataRestrictionMask     := BatchShare.Constants.Defaults.DataRestrictionMask;           
		EXPORT STRING32  ApplicationType         := BatchShare.Constants.Defaults.ApplicationType;       
		EXPORT STRING5   industry_class          := ut.IndustryClass.UTILI_IC; //we restrict it by default 'UTILI'      
		EXPORT STRING6   ssn_mask                := BatchShare.Constants.Defaults.SSNMask; //'NONE'
		EXPORT BOOLEAN   IncludeMinors           := FALSE;
		EXPORT BOOLEAN   mask_dl                 := FALSE; //for accidents
		EXPORT STRING    RealTimePermissibleUse  := '';
		EXPORT BOOLEAN   IncludeNonRegulatedVehicleSources    := FALSE;
		EXPORT BOOLEAN   IncludeNonRegulatedWatercraftSources := FALSE;
		EXPORT BOOLEAN   IncludePriorProperties  := FALSE;
		EXPORT BOOLEAN   EnableNationalAccidents := FALSE;
		EXPORT BOOLEAN   EnableExtraAccidents    := FALSE;
		EXPORT BOOLEAN   IncludeBlankDOD         := FALSE;
		EXPORT STRING1 ucc_party_type            := 'D'; //return only debtors
		EXPORT STRING14 did                      := ''; //for firearms

		EXPORT BOOLEAN IncludeAddresses            := FALSE;
		EXPORT BOOLEAN IncludePhones               := FALSE;
		EXPORT BOOLEAN IncludeProfessionalLicenses := FALSE;
		EXPORT BOOLEAN IncludePeopleAtWork         := FALSE;
		EXPORT BOOLEAN IncludeAircrafts            := FALSE;
		EXPORT BOOLEAN IncludePilotCerts           := FALSE;
		EXPORT BOOLEAN IncludeWatercrafts          := FALSE;
		EXPORT BOOLEAN IncludeUccs                 := FALSE;
		EXPORT BOOLEAN IncludeSexualOffences       := FALSE;
		EXPORT BOOLEAN IncludeCrimRecords          := FALSE;
		EXPORT BOOLEAN IncludeConcealedWeapons     := FALSE;
		EXPORT BOOLEAN IncludeHuntingFishingPermits:= FALSE;
		EXPORT BOOLEAN IncludeFederalFirearms      := FALSE;
		EXPORT BOOLEAN IncludeControlledSubstances := FALSE;
		EXPORT BOOLEAN IncludeVoters               := FALSE;
		EXPORT BOOLEAN IncludeDriversLicenses      := FALSE;
		EXPORT BOOLEAN IncludeMotorVehicles        := FALSE;
		EXPORT BOOLEAN IncludeRealTimeVehicles     := FALSE;
		EXPORT BOOLEAN IncludeAccidents            := FALSE;
		EXPORT BOOLEAN IncludeBankruptcies         := FALSE;
		EXPORT BOOLEAN IncludeLiens                := FALSE;
		EXPORT BOOLEAN IncludeProperties           := FALSE;
		EXPORT BOOLEAN IncludeMarriageDivorces     := FALSE;
		EXPORT BOOLEAN IncludeEducation            := FALSE;
		EXPORT BOOLEAN IncludeAKAs                 := FALSE;
		EXPORT BOOLEAN IncludeImposters            := FALSE;
		EXPORT BOOLEAN IncludeDeaths               := FALSE;
		EXPORT BOOLEAN IncludeUtility              := FALSE;
	END;

	EXPORT getOptions(iesp.personslimreport.t_PersonSlimReportRequest inIesp) := FUNCTION
		in_mod := MODULE(PersonSlimReportOptions)
			EXPORT UNSIGNED1 GLBPurpose                := (unsigned1)inIesp.user.glbpurpose;
			EXPORT UNSIGNED1 DPPAPurpose               := (unsigned1)inIesp.user.dlpurpose;
			EXPORT STRING    DataRestrictionMask       := inIesp.user.datarestrictionmask;
			EXPORT STRING32  ApplicationType           := inIesp.user.applicationtype;
			EXPORT STRING5   industry_class            := inIesp.user.industryclass;
			EXPORT STRING6   ssn_mask                  := inIesp.user.ssnmask;
			EXPORT BOOLEAN   mask_dl                   := inIesp.user.dlmask;
			EXPORT STRING14  did                       := inIesp.reportby.uniqueid;

			EXPORT BOOLEAN IncludeAddresses            := inIesp.Options.IncludeAddresses;
			EXPORT BOOLEAN IncludePhones               := inIesp.Options.IncludePhones;
			EXPORT BOOLEAN IncludeProfessionalLicenses := inIesp.Options.IncludeProfessionalLicenses;
			EXPORT BOOLEAN IncludePeopleAtWork         := inIesp.Options.IncludePeopleAtWork;
			EXPORT BOOLEAN IncludeAircrafts            := inIesp.Options.IncludeAircrafts;
			EXPORT BOOLEAN IncludePilotCerts           := inIesp.Options.IncludePilotCerts;
			EXPORT BOOLEAN IncludeWatercrafts          := inIesp.Options.IncludeWatercrafts;
			EXPORT BOOLEAN IncludeUccs                 := inIesp.Options.IncludeUccs;
			EXPORT BOOLEAN IncludeSexualOffences       := inIesp.Options.IncludeSexualOffences;
			EXPORT BOOLEAN IncludeCrimRecords          := inIesp.Options.IncludeCrimRecords;
			EXPORT BOOLEAN IncludeConcealedWeapons     := inIesp.Options.IncludeConcealedWeapons;
			EXPORT BOOLEAN IncludeHuntingFishingPermits:= inIesp.Options.IncludeHuntingFishingPermits;
			EXPORT BOOLEAN IncludeFederalFirearms      := inIesp.Options.IncludeFederalFirearms;
			EXPORT BOOLEAN IncludeControlledSubstances := inIesp.Options.IncludeControlledSubstances;
			EXPORT BOOLEAN IncludeVoters               := inIesp.Options.IncludeVoters;
			EXPORT BOOLEAN IncludeDriversLicenses      := inIesp.Options.IncludeDriversLicenses;
			EXPORT BOOLEAN IncludeMotorVehicles        := inIesp.Options.IncludeMotorVehicles;
			EXPORT BOOLEAN IncludeRealTimeVehicles     := inIesp.Options.IncludeRealTimeVehicles;
			EXPORT STRING  RealTimePermissibleUse      := inIesp.Options.RealTimePermissibleUse;
			EXPORT BOOLEAN IncludePriorProperties      := inIesp.Options.IncludePriorProperties;
			EXPORT BOOLEAN EnableNationalAccidents     := inIesp.Options.EnableNationalAccidents;
			EXPORT BOOLEAN EnableExtraAccidents        := inIesp.Options.EnableExtraAccidents;
			EXPORT BOOLEAN IncludeBlankDOD             := inIesp.Options.IncludeBlankDOD;
			EXPORT BOOLEAN IncludeNonRegulatedWatercraftSources := inIesp.Options.IncludeNonRegulatedWatercraftSources;
			EXPORT BOOLEAN IncludeNonRegulatedVehicleSources    := inIesp.Options.IncludeNonRegulatedVehicleSources;
			EXPORT BOOLEAN IncludeAccidents            := inIesp.Options.IncludeAccidents;
			EXPORT BOOLEAN IncludeBankruptcies         := inIesp.Options.IncludeBankruptcies;
			EXPORT BOOLEAN IncludeLiens                := inIesp.Options.IncludeLiens;
			EXPORT BOOLEAN IncludeProperties           := inIesp.Options.IncludeProperties;
			EXPORT BOOLEAN IncludeMarriageDivorces     := inIesp.Options.IncludeMarriageDivorces;
			EXPORT BOOLEAN IncludeEducation            := inIesp.Options.IncludeEducation;
			EXPORT BOOLEAN IncludeAKAs                 := inIesp.Options.IncludeAKAs;
			EXPORT BOOLEAN IncludeImposters            := inIesp.Options.IncludeImposters;
			EXPORT BOOLEAN IncludeDeaths               := inIesp.Options.IncludeDeaths;
			EXPORT BOOLEAN IncludeUtility              := inIesp.Options.IncludeUtility;
		END;
		RETURN in_mod;
	END;
	
	EXPORT StoreIesp (iesp.personslimreport.t_PersonSlimReportRequest inIesp) := FUNCTION
	// this will #store some standard input parameters (generally, for search purpose ex - get_dids depends on #stored(did) being set)
	// also #store the fields so that restrictions get applied in doxie.header_records_byDID
	iesp.ECL2ESP.SetInputBaseRequest(inIesp);
	iesp.ECL2ESP.SetInputReportBy(ROW(inIesp.ReportBy,
		TRANSFORM(iesp.bpsreport.t_BpsReportBy,
				 SELF:= LEFT,
				 SELF:=[])));
		STRING RealTimePermissibleUse := trim(global(inIesp.Options).RealTimePermissibleUse);
		#STORED('RealTimePermissibleUse', RealTimePermissibleUse);
		BOOLEAN IncludePriorProperties:= global(inIesp.Options).IncludePriorProperties;
		#STORED('IncludePriorProperties', IncludePriorProperties);
		BOOLEAN IncludeNonRegulatedVehicleSources := global(inIesp.Options).IncludeNonRegulatedVehicleSources;
		#STORED('IncludeNonRegulatedVehicleSources', IncludeNonRegulatedVehicleSources);
		BOOLEAN IncludeNonRegulatedWatercraftSources := global(inIesp.Options).IncludeNonRegulatedWatercraftSources;
		#STORED('IncludeNonRegulatedWatercraftSources', IncludeNonRegulatedWatercraftSources);
		BOOLEAN EnableNationalAccidents := global(inIesp.Options).EnableNationalAccidents;
		#STORED('EnableNationalAccidents', EnableNationalAccidents);
		BOOLEAN EnableExtraAccidents := global(inIesp.Options).EnableExtraAccidents;
		#STORED('EnableExtraAccidents', EnableExtraAccidents);
		BOOLEAN IncludeBlankDOD := global(inIesp.Options).IncludeBlankDOD;
		#STORED('IncludeBlankDOD', IncludeBlankDOD);
		//return bogus output to avoid any errors - this is done in iesp.ECL2ESP
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
	END;

END;