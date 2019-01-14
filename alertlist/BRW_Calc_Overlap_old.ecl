alert_layout := record
	String	Cred_Unit_Alert_Id;
	String	Entity_Id;
	String	Reason_Full;
	String	Std_Addr_Primary;
	String	Std_Addr_Secondary;
	String	Std_Addr_City;
	String	Std_Addr_State;
	String	Std_Addr_Postal_Cd;
	String	Std_Addr_Zip4;
	String	Name_Business;
	String	Acctno;
	unsigned8	Bdid;
	unsigned8	bScore;
	unsigned8	DID;
	unsigned8	dScore;
end;

input_alert		:= dataset('~thor40_241::fbo::alert_datacompany', alert_layout, csv);
input_active	:= dataset('~thor40_241::fbo::accurint_active', alert_layout, csv);

alertlist.Alert_Network.mac_calculate_overlap(input_alert(did > 0), entity_id, did, dscore, bdid, bscore,
																						  input_active(did > 0), entity_id, did, dscore, bdid, bscore,
																						  75, 60, false,
																						  results, '');