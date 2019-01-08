/* ************************************************************************
Put in an address and it will go into the address key to find the RIDs
then it will pull the payload records from the RID key using those RIDs found.
************************************************************************ 
NOTE:  This pulls from **TRUE PRODUCTION*** data SF keys when run on the production thor
************************************************************************ */

IMPORT PRTE2_Common,PropertyCharacteristics;

q_prange	:= '12180';
q_pname		:= 'LANSDOWNE';
q_zip		:= '97223';

ProdAddrKey := PropertyCharacteristics.Key_PropChar_Address;
ProdRidKey 	:= PropertyCharacteristics.Key_PropChar_RID;
// ---------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------
JoinVersion := JOIN(ProdAddrKey(prim_range=q_prange AND prim_name=q_pname AND zip=q_zip), ProdRidKey,
															LEFT.property_rid = RIGHT.property_rid,
															TRANSFORM({ProdRidKey},
															SELF := RIGHT
															));
OUTPUT(JoinVersion,NAMED('Payload_Data'));															


