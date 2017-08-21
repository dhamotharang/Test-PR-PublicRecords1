import aid;

export Layout_BusReg_Company_AID := record
	Layout_BusReg_Company;
	AID.Common.xAID	Append_MailRawAID;
	AID.Common.xAID	Append_MailACEAID;
	
	AID.Common.xAID	Append_LocRawAID;
	AID.Common.xAID	Append_LocACEAID;

	AID.Common.xAID	Append_RARawAID;
	AID.Common.xAID	Append_RAACEAID;
	
	AID.Common.xAID	Append_Off1RawAID;
	AID.Common.xAID	Append_Off1ACEAID;
	string100				Clean_mailing_address1;
	string50				Clean_mailing_address2;
	string100				Clean_location_address1;
	string50				Clean_location_address2;
	string100				Clean_RA_address1;
	string50				Clean_RA_address2;		
	string100				Clean_officer1_address1;
	string50				Clean_officer1_address2	;
end;