/* *********************************************************************************************************************************
PRTE2_PropertyInfo_Ins_MLS.V_BWR_View_Address_in_PRTE_Keys

Put in an address and it will go into the address key to find the RIDs
then it will pull the payload records from the RID key using those RIDs found.
will have to run these in PROD Thor ... Or below create a Key definition with the Add_Foreign_Prod for the name 
************************************************************************ 
NOTE:  This pulls from **FAKE PRCT*** data SF keys when run on the production thor
************************************************************************************************************************************* */

IMPORT PRTE2_PropertyInfo_Ins_MLS;

q_prange	:= '12180';
q_pname		:= 'LANSDOWNE';
q_zip		:= '97223';

CT_Addr_Key := PRTE2_PropertyInfo_Ins_MLS.Files.CT_Addr_Key;
CT_Rid_Key 	:= PRTE2_PropertyInfo_Ins_MLS.Files.CT_Rid_Key;
// ---------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------
JoinVersion := JOIN(CT_Addr_Key(prim_range=q_prange AND prim_name=q_pname AND zip=q_zip), CT_Rid_Key,
															LEFT.property_rid = RIGHT.property_rid,
															TRANSFORM({CT_Rid_Key},
															SELF := RIGHT
															));
OUTPUT(JoinVersion,NAMED('Payload_Data'));			