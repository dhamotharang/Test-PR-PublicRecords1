EXPORT DistCRSDS (boolean IsFCRA = false) := FUNCTION

doxie.MAC_Header_Field_Declare(IsFCRA);
doxie.MAC_Selection_Declare();
null := dataset([{true}], {boolean a});
Include_BlankDOD := false : stored('IncludeBlankDOD'); 
gm := AutoStandardI.GlobalModule(isFCRA);

d := table(null, {
string ssn := ssn_value,
string FirstName := fname_val,
boolean AllowNickNames := nicknames,
string RelativeFirstName1 := rel_fname_val1,
string RelativeFirstName2 := rel_fname_val2,
string LastName := lname_val,
string OtherLastName1 := olname1_val,
boolean PhoneticMatch := phonetics,
string MiddleName := mname_val,
string Addr := addr_value,
string City := city_val,
string OtherCity1 := other_city_val,
string State := state_val,
string OtherState1 := prev_state_val1l,
string OtherState2 := prev_state_val2l,
string Zip := zip_val,
string Phone := phone_value,
unsigned8 DOB := Dob_val,
unsigned1 AgeLow := AgeLow_val,
unsigned1 AgeHigh := AgeHigh_val,
string DID := did_value,
unsigned1 DPPAPurpose := DPPA_Purpose,
unsigned1 GLBPurpose := GLB_Purpose,
unsigned1 PhonesPerAddress := n_phones,
boolean LawEnforcement := Law_Enforcement,
boolean SelectIndividually := Select_Indiv,
boolean IncludeTimeline := Include_Timeline;
boolean IncludeAKAs := Include_AKAs,
boolean IncludeImposters := Include_Imposters,
boolean IncludeAssociates := Include_Associates,
boolean IncludeOldPhones := Include_OldPhones;
boolean IncludeProperties := Include_Properties,
boolean IncludePriorProperties := Include_PriorProperties,
boolean IncludeDriversLicenses := Include_DriversLicenses,
boolean IncludeMotorVehicles := Include_MotorVehicles,
boolean IncludeBankruptcies := Include_Bankruptcies,
boolean IncludeLiensJudgments := Include_LiensJudgments,
boolean IncludeCorporateAffiliations := Include_CorporateAffiliations,
boolean IncludeUCCFilings := Include_UCCFilings,
boolean IncludeDEARecords := Include_Dea,
boolean IncludeFAACertificates := Include_FAACertificates,
boolean IncludeCriminalRecords := Include_CriminalRecords,
boolean IncludeCensusData := Include_CensusData,
boolean IncludeAccidents := Include_Accidents,
boolean IncludeProfessionalLicenses := Include_ProfessionalLicenses,
boolean IncludeVoterRegistrations := Include_VoterRegistrations,
boolean IncludeHuntingFishingLicenses := Include_HuntingFishingLicenses,
boolean IncludeWeaponPermits := Include_WeaponPermits,
boolean IncludeSexualOffenses := Include_SexualOffenses,
boolean IncludeInternetDomains := Include_InternetDomains,
boolean IncludeFAAAircrafts := Include_FAAAircrafts,
boolean IncludeWatercrafts := Include_Watercrafts,
boolean IncludeHRI := Include_HRI,
unsigned8 MaxHriPer := maxHriPer_value,
boolean IncludeRelatives := Include_Relatives,
unsigned8 MaxRelatives := Max_Relatives,
unsigned1 RelativeDepth := Relative_Depth,
boolean IncludeRelativeAddresses := Include_RelativeAddresses,
unsigned8 MaxRelativeAddresses := Max_RelativeAddresses,
boolean IncludeNeighbors := Include_Neighbors,
unsigned8 MaxNeighborhoods := Max_Neighborhoods,
unsigned1 NeighborsPerAddress := Neighbors_PerAddress,
unsigned1 AddressesPerNeighbor := Addresses_PerNeighbor,
boolean IncludeBlankDOD := Include_BlankDOD,
boolean ProbationOverride := probation_override_value,
string DataRestrictionMask := gm.DataRestrictionMask
}
);

RETURN d;
END;