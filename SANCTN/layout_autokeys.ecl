IMPORT Standard;

export layout_autokeys := record
	STRING8   BATCH_NUMBER;
	STRING8   INCIDENT_NUMBER;
	STRING8   PARTY_NUMBER;
	STRING8   AG_CODE;
	STRING8   INCIDENT_DATE;
  Standard.Name;
	string45  cname;
	Standard.L_Address.detailed;
	unsigned6 did := 0;
	unsigned3 did_score := '';
	unsigned6 bdid;
  unsigned3 bdid_score;
	string11 	ssnumber;
	string9   ssn_appended;
end;
