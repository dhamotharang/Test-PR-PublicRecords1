/* ************************************************************************
PRTE2_PropertyInfo_Ins_Dev.U__BWR_Find_CT_Key_Data_ABCD
Put in an address and it will go into the address key to find the RIDs
then it will pull the records from the RID key using those RIDs found.
************************************************************************ 
NOTE:  This pulls from PRCT data SF keys on the production thor
************************************************************************ */

IMPORT PRTE2_Common,PRTE2_PropertyInfo_Ins;

Add_Foreign_prod := PRTE2_Common.Constants.Add_Foreign_prod;

// TRUE says to use the foreignProd name.
AddrKey := PRTE2_PropertyInfo_Ins.key_PropertyInfo_address('20170907',TRUE);
RidKey 	:= PRTE2_PropertyInfo_Ins.key_PropertyInfo_rid('20170907',TRUE);

q_prange	:= '10';
q_pname		:= '1ST';
q_zip		:= '63123';

// ----------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------

// I just went to the WsECL web page for prte::key::propertyinfo::20151113::address, did a filter/lookup on 
// an address, then copies the property_rid values into here - just quick check to ensure we have A,B,C,and D records.

rid_recs := AddrKey(prim_range=q_prange AND prim_name=q_pname AND zip=q_zip);
rid_list := SET(rid_recs,property_rid);
OUTPUT(rid_recs);
// OUTPUT(rid_list);
recs := RidKey(property_rid IN rid_list);
OUTPUT(recs,all);


