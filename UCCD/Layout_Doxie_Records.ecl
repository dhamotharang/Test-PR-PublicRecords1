export Layout_Doxie_Records := record, maxlength(32000)
	//uccd.Key_Party_DID;
	string50  ucc_key;
	unsigned6 did;
	unsigned6	bdid;
	
	//from party
	uccd.layout_jfk_debtor;
	uccd.layout_jfk_secured;
	
	//from collateral
	DATASET(uccd.Layout_Collateral_ChildDS) collateral_children;
	
	//from summary
	uccd.layout_jfk_summary;
	
	//from event
	uccd.layout_jfk_event;

end;
