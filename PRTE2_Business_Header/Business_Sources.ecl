import
	PRTE2_ATF,
	PRTE2_Bankruptcy,
	PRTE2_BusReg,
	PRTE2_CORP,
	PRTE2_DEA,
	PRTE2_DNB,
	PRTE2_DNB_FEIN,
	PRTE2_Domains,
	PRTE2_EBR,
	PRTE2_FAA,
	PRTE2_FBN,
	PRTE2_Gong,
	PRTE2_Liens,
	PRTE2_LNProperty,
	PRTE2_Prof_LicenseV2,
	PRTE2_UCC,
	PRTE2_Utility,
	PRTE2_Vehicle	
	;
export Business_Sources := 
module
		
		export business_headers  := PRTE2_ATF.as_headers.business_header_ATF +
																PRTE2_Bankruptcy.as_headers.business_header_Bankruptcy + 
																PRTE2_BusReg.as_header.new_business_header +
																PRTE2_CORP.as_headers.new_fAs_Business_Header +
																PRTE2_DEA.as_headers.map_to_old_business_header +
																PRTE2_DNB.as_headers.as_business_header +
																PRTE2_DNB_FEIN.as_headers.business_header_dnbfein +
																PRTE2_Domains.as_headers.new_business_header +
																PRTE2_EBR.as_headers.old_business_header_ebr +
																PRTE2_FAA.as_header_aircraft.old_business_header_aircraft_recs +
																PRTE2_FBN.as_headers.new_business_header +
																PRTE2_Gong.as_headers.fGong_As_Business_Header +
																PRTE2_Liens.as_headers.business_header_liens +
																PRTE2_LNProperty.as_headers.As_Business_Header +
																//PRTE2_Prof_LicenseV2.as_header.new_business_header +
																PRTE2_UCC.as_headers.business_header_ucc +
																PRTE2_Utility.as_headers.old_business_header_utility +
																PRTE2_Vehicle.as_headers.old_business_header_vehicle_recs
																: persist('~prte::persist::PRTE2_Business_header.Business_Sources::Business_Headers');
		
		export business_contacts := PRTE2_ATF.as_headers.business_contacts_ATF +
																PRTE2_Bankruptcy.as_headers.business_contacts_bankruptcy +
																PRTE2_BusReg.as_header.new_business_contact +
																PRTE2_CORP.as_headers.new_fAs_Business_Contact +
																PRTE2_DEA.as_headers.map_to_old_business_contacts +
																PRTE2_DNB.as_headers.as_business_contact +
																//PRTE2_DNB_FEIN.as_headers
																PRTE2_Domains.as_headers.old_business_contacts_domain_recs +
																PRTE2_EBR.as_headers.old_business_contacts_ebr +
																PRTE2_FAA.as_header_aircraft.old_business_contacts_aircraft_recs +
																PRTE2_FBN.as_headers.new_business_contact +
																PRTE2_Gong.as_headers.fGong_As_Business_Contact +
																PRTE2_LNProperty.as_headers.As_Business_Contact +
																//PRTE2_Prof_LicenseV2.as_header.new_business_contact +
																PRTE2_UCC.as_headers.business_contacts_ucc
																: persist('~prte::persist::PRTE2_Business_header.Business_Sources::Business_Contacts');
		

end;
		