/*
Development cycle should include unit testing
a. Verify input records
	i. Fields are populated correctly
b. Keys are populated
c. Check for duplication
d. Verify production logic
e. Verify lexid(s) are populated correctly
f. Verify linkid(s) are populated correctly
g. Verify name/address are cleaned properly
h. Verify standardized code(if applicable)
i. Verify global_sid field is populated correctly
j. Verify source field is populated correctly
*/

/*
a.	Verify input records
    i.	Fields are populated correctly
*/
FDIC_Base 		:=	PRTE2_GovData.Files.FDIC_Base;
IRS_Base 			:=	PRTE2_GovData.Files.IRS_Base;
Salestax_CA_Base 	:=	PRTE2_GovData.Files.Salestax_CA_Base;
Salestax_IA_Base 	:=	PRTE2_GovData.Files.Salestax_IA_Base;
Sec_Broker_Base 	:=	PRTE2_GovData.Files.Sec_Broker_Base;

OUTPUT(COUNT(FDIC_Base),NAMED('FDIC_Base_Count'));
OUTPUT(FDIC_Base,NAMED('FDIC_Base_Results'));
OUTPUT(COUNT(IRS_Base),NAMED('IRS_Base_Count'));
OUTPUT(IRS_Base,NAMED('IRS_Base_Results'));
OUTPUT(COUNT(Salestax_CA_Base),NAMED('Salestax_CA_Base_Count'));
OUTPUT(Salestax_CA_Base,NAMED('Salestax_CA_Base_Results'));
OUTPUT(COUNT(Salestax_IA_Base),NAMED('Salestax_IA_Base_Count'));
OUTPUT(Salestax_IA_Base,NAMED('Salestax_IA_Base_Results'));
OUTPUT(COUNT(Sec_Broker_Base),NAMED('Sec_Broker_Base_Count'));
OUTPUT(Sec_Broker_Base,NAMED('Sec_Broker_Base_Results'));

/* b.	Keys are populated */
Key_Salestax_CA_Bdid_Key := PULL(Keys.Key_Salestax_CA_Bdid_Key);
Key_Salestax_CA_Linkids_Key := PULL(Keys.Key_Salestax_CA_Linkids_Key);
Key_FDIC_Bdid_Key := PULL(Keys.Key_FDIC_Bdid_Key);
Key_FDIC_Linkids_Key := PULL(Keys.Key_FDIC_Linkids_Key);
Key_Salestax_IA_Bdid_Key := PULL(Keys.Key_Salestax_IA_Bdid_Key);
Key_Salestax_IA_Linkids_Key := PULL(Keys.Key_Salestax_IA_Linkids_Key);
Key_Irsnonprofit_Bdid_Key := PULL(Keys.Key_Irsnonprofit_Bdid_Key);
Key_Irsnonprofit_Linkids_Key := PULL(Keys.Key_Irsnonprofit_Linkids_Key);
Key_ms_workers_comp_Bdid_Key := PULL(Keys.Key_ms_workers_comp_Bdid_Key);
Key_ms_workers_comp_Linkids_Key := PULL(Keys.Key_ms_workers_comp_Linkids_Key);
Key_or_workers_comp_Bdid_Key := PULL(Keys.Key_or_workers_comp_Bdid_Key);
Key_or_workers_comp_Linkids_Key := PULL(Keys.Key_or_workers_comp_Linkids_Key);
Key_sec_broker_dealer_Linkids_Key := PULL(Keys.Key_sec_broker_dealer_Linkids_Key);

OUTPUT(COUNT(Key_Salestax_CA_Bdid_Key),NAMED('Salestax_CA_Bdid_Key_Count'));
OUTPUT(Key_Salestax_CA_Bdid_Key,NAMED('Salestax_CA_Bdid_Key_Results'));
OUTPUT(COUNT(Key_Salestax_CA_Linkids_Key),NAMED('Salestax_CA_Linkids_Key_Count'));
OUTPUT(Key_Salestax_CA_Linkids_Key,NAMED('Salestax_CA_Linkids_Key_Results'));

OUTPUT(COUNT(Key_FDIC_Bdid_Key),NAMED('FDIC_Bdid_Key_Count'));
OUTPUT(Key_FDIC_Bdid_Key,NAMED('FDIC_Bdid_Key_Results'));
OUTPUT(COUNT(Key_FDIC_Linkids_Key),NAMED('FDIC_Linkids_Key_Count'));
OUTPUT(Key_FDIC_Linkids_Key,NAMED('FDIC_Linkids_Key_Results'));

OUTPUT(COUNT(Key_Salestax_IA_Bdid_Key),NAMED('Salestax_IA_Bdid_Bdid_Key_Count'));
OUTPUT(Key_Salestax_IA_Bdid_Key,NAMED('Salestax_IA_Bdid_Key_Results'));
OUTPUT(COUNT(Key_Salestax_IA_Linkids_Key),NAMED('Salestax_IA_Linkids_Key_Count'));
OUTPUT(Key_Salestax_IA_Linkids_Key,NAMED('Salestax_IA_Linkids_Key_Results'));

OUTPUT(COUNT(Key_Irsnonprofit_Bdid_Key),NAMED('Irsnonprofit_Bdid_Key_Count'));
OUTPUT(Key_Irsnonprofit_Bdid_Key,NAMED('Irsnonprofit_Bdid_Key_Results'));
OUTPUT(COUNT(Key_Irsnonprofit_Linkids_Key),NAMED('Irsnonprofit_Linkids_Key_Count'));
OUTPUT(Key_Irsnonprofit_Linkids_Key,NAMED('Irsnonprofit_Linkids_Key_Results'));

OUTPUT(COUNT(Key_ms_workers_comp_Bdid_Key),NAMED('ms_workers_comp_Bdid_Key_Count'));
OUTPUT(Key_ms_workers_comp_Bdid_Key,NAMED('ms_workers_comp_Bdid_Key_Results'));
OUTPUT(COUNT(Key_ms_workers_comp_Linkids_Key),NAMED('ms_workers_comp_Linkids_Key_Count'));
OUTPUT(Key_ms_workers_comp_Linkids_Key,NAMED('ms_workers_comp_Linkids_Key_Results'));

OUTPUT(COUNT(Key_or_workers_comp_Bdid_Key),NAMED('or_workers_comp_Bdid_Key_Count'));
OUTPUT(Key_or_workers_comp_Bdid_Key,NAMED('or_workers_comp_Bdid_Key_Results'));
OUTPUT(COUNT(Key_or_workers_comp_Linkids_Key),NAMED('or_workers_comp_Linkids_Key_Count'));
OUTPUT(Key_or_workers_comp_Linkids_Key,NAMED('or_workers_comp_Linkids_Key_Results'));

OUTPUT(COUNT(Key_sec_broker_dealer_Linkids_Key),NAMED('sec_broker_dealer_Linkids_Key_Count'));
OUTPUT(Key_sec_broker_dealer_Linkids_Key,NAMED('sec_broker_dealer_Linkids_Key_Results'));

//g. Verify name/address are cleaned properly
OUTPUT(FDIC_Base,{prim_range,predir,prim_name}, NAMED('FDIC_address_population'));
OUTPUT(IRS_Base,{prim_range,predir,prim_name}, NAMED('IRS_address_population'));
OUTPUT(Salestax_CA_Base,{prim_range,predir,prim_name}, NAMED('Salestax_CA_address_population'));
OUTPUT(Salestax_IA_Base,{mailingaddress.prim_range,mailingaddress.predir,mailingaddress.prim_name}, NAMED('Salestax_IA_address_population'));
OUTPUT(Sec_Broker_Base,{prim_range,predir,prim_name}, NAMED('Sec_Broker_Base_address_population'));