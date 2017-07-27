import ut, roxiekeybuild;

export Proc_Accept_SK_to_QA_LinkIDS := function

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Move Superkeys to QA
//////////////////////////////////////////////////////////////////////////////////////////////
ut.mac_sk_move_v2(KeyName_0010_Header_linkids,													'Q', do1)
ut.mac_sk_move_v2(KeyName_1000_Executive_Summary_linkids,								'Q', do2)
ut.mac_sk_move_v2(KeyName_4510_UCC_Filings_linkids,											'Q', do3)
ut.mac_sk_move_v2(KeyName_5600_Demographic_Data_linkids,								'Q', do4)
ut.mac_sk_move_v2(KeyName_5610_Demographic_Data_linkids,								'Q', do5)


retval := sequential(
	 do1
	,do2
	,do3
	,do4
	,do5
);

return retval;

end;
