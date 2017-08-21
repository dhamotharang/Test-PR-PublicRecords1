import aid;

export Layout_BusReg_Contact_AID := record
	Layout_BusReg_Contact;
	string100				Prep_addr_line1;
	string50				prep_addr_line_last;			
	AID.Common.xAID	Append_RawAID		:=	0;
	AID.Common.xAID	Append_ACEAID		:=	0;
end;