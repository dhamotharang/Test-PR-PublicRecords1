/* ************************************************************************
Put in an address and it will go into the address key to find the RIDs
then it will pull the records from the RID key using those RIDs found.
************************************************************************ 
NOTE:  This pulls from **TRUE PRODUCTION*** data SF keys on the production thor
************************************************************************ */

IMPORT PRTE2_Common;

Add_Foreign_prod := PRTE2_Common.Constants.Add_Foreign_prod;
AddrKey := PropertyCharacteristics.Key_PropChar_Address;
RidKey 	:= PropertyCharacteristics.Key_PropChar_RID;
// salt311.MAC_Profile(RidKey);

q_prange	:= '10';
q_pname		:= '1st';
q_zip		:= '63123';

// I just went to the WsECL web page for prte::key::propertyinfo::20151113::address, did a filter/lookup on 
// an address, then copies the property_rid values into here - just quick check to ensure we have A,B,C,and D records.

rid_recs := AddrKey(prim_range=q_prange AND prim_name=q_pname AND zip=q_zip);
rid_list := SET(rid_recs,property_rid);
OUTPUT(rid_recs);
OUTPUT(rid_list);
recs := RidKey(property_rid IN rid_list);
OUTPUT(recs,all);


