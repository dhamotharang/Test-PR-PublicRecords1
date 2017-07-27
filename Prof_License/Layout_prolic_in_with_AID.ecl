export Layout_prolic_in_with_AID := record
	Prof_License.Layout_proLic_in;
	string100	prep_addr_line1;
	string50	prep_addr_last_line;
	unsigned8	RawAid	:= 0;
	unsigned8	ACEAID	:= 0;
end;