/* *********************************************************************************************************************************
Put in an address and it will go into the address key to find the RIDs
then it will pull the payload records from the RID key using those RIDs found.
will have to run these in PROD Thor ... Or below create a Key definition with the Add_Foreign_Prod for the name 
************************************************************************ 
NOTE:  This pulls from **TRUE PRODUCTION*** data SF keys when run on the production thor
************************************************************************************************************************************* */

IMPORT PRTE2_Common,PRTE2_PropertyInfo_Ins_Dev;

q_prange	:= '12180';
q_pname		:= 'LANSDOWNE';
q_zip		:= '97223';

RealProdAddrKey := PRTE2_PropertyInfo_Ins_Dev.Files.RealProdAddrKey;
RealProdRidKey 	:= PRTE2_PropertyInfo_Ins_Dev.Files.RealProdRidKey;
// ---------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------
JoinVersion := JOIN(RealProdAddrKey(prim_range=q_prange AND prim_name=q_pname AND zip=q_zip), RealProdRidKey,
															LEFT.property_rid = RIGHT.property_rid,
															TRANSFORM({RealProdRidKey},
															SELF := RIGHT
															));
OUTPUT(JoinVersion,NAMED('Payload_Data'));			