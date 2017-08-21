import promotesupers, roxiekeybuild;

export Proc_Accept_SK_to_QA_LinkIDS := function

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Move Superkeys to QA
//////////////////////////////////////////////////////////////////////////////////////////////
promotesupers.Mac_SK_Move_v2(KeyName_0010_Header_linkids,							'Q', do1)
promotesupers.Mac_SK_Move_v2(KeyName_1000_Executive_Summary_linkids,	'Q', do2)
promotesupers.Mac_SK_Move_v2(KeyName_4510_UCC_Filings_linkids,				'Q', do3)
promotesupers.Mac_SK_Move_v2(KeyName_5600_Demographic_Data_linkids,		'Q', do4)
promotesupers.Mac_SK_Move_v2(KeyName_5610_Demographic_Data_linkids,		'Q', do5)


retval := sequential(
	 do1
	,do2
	,do3
	,do4
	,do5
);

return retval;

end;
