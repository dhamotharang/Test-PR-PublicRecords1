/* ************************************************************************
Put in an address and it will go into the address key to find the RIDs
then it will pull the records from the RID key using those RIDs found.
NOTE:  This pulls from production thor PRCT data keys
************************************************************************
====>>> NOTE The PRCT PropertyInfo Build doesn't create SF - need TODO!
Till then - have to set up the fileVersion to make it work
************************************************************************ */

IMPORT PRTE2_Common,PRTE2_PropertyInfo_Ins,PropertyCharacteristics, ut;

// ---------- Stuff we need to fill in for each test -------------
fileVersion := '20180518';
foreignProd := PRTE2_Common.Constants.foreign_prod;
CTAddrKeyName := '~'+foreignProd+'prte::key::propertyinfo::'+fileVersion+'::address';
CTRidKeyName := '~'+foreignProd+'prte::key::propertyinfo::'+fileVersion+'::rid';

// --------------------------------------------------------------- AN ADDRESS TO LOOKUP --------------------
q_prange	:= '12180';
q_pname		:= 'LANSDOWNE';
q_zip		:= '97223';
// ----------------------------------------------------------------------------------------------------------


// ----------------------------------------------------------------------------------------------------------
AddrKeyDef := PropertyCharacteristics.Key_PropChar_Address;
RidKeyDef 	:= PropertyCharacteristics.Key_PropChar_RID;
// ---------------------------------------------------------------
CTAddrKey := Index(AddrKeyDef, CTAddrKeyName);	// The above key definitions point to production names but we'll override the name here.
CTRidKey := Index(RidKeyDef, CTRidKeyName);			// The above key definitions point to production names but we'll override the name here.
// ----------------------------------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------
JoinVersion := JOIN(CTAddrKey(prim_range=q_prange AND prim_name=q_pname AND zip=q_zip), CTRidKey,
															LEFT.property_rid = RIGHT.property_rid,
															TRANSFORM({CTRidKey},
															SELF := RIGHT
															));
OUTPUT(JoinVersion,NAMED('Payload_Data'));															

