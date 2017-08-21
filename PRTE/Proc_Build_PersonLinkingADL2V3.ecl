import	_control, PRTE_CSV, ut, PRTE_PersonLinkingADL2V3;

export	Proc_Build_PersonLinkingADL2V3(string pIndexVersion, string pIndexOldVersion)	:=
function

prefix  := '~prte::key::';

keyname_LFZ 			:= '::PersonLinkingADL2V3PersonHeaderLFZRefs';
keyname_address3 	:= '::PersonLinkingADL2V3PersonHeaderADDRESS3Refs';
keyname_SSN 			:= '::PersonLinkingADL2V3PersonHeaderSRefs';
keyname_SSN4 			:= '::PersonLinkingADL2V3PersonHeaderSSN4Refs';
keyname_DOB 			:= '::PersonLinkingADL2V3PersonHeaderDORefs';
keyname_PHONE 		:= '::PersonLinkingADL2V3personheaderphrefs';
keyname_ZPRF 			:= '::PersonLinkingADL2V3personheaderzprfrefs';
keyname_FLST 			:= '::PersonLinkingADL2V3personheaderflstrefs';

key_logical_LFZ 			:= prefix + pIndexVersion + keyname_LFZ;
key_logical_address3 	:= prefix + pIndexVersion + keyname_address3;
key_logical_SSN 			:= prefix + pIndexVersion + keyname_SSN;
key_logical_SSN4 			:= prefix + pIndexVersion + keyname_SSN4;
key_logical_DOB 			:= prefix + pIndexVersion + keyname_DOB;
key_logical_PHONE 		:= prefix + pIndexVersion + keyname_PHONE;
key_logical_ZPRF 			:= prefix + pIndexVersion + keyname_ZPRF;
key_logical_FLST 			:= prefix + pIndexVersion + keyname_FLST;


																					
BK1 := buildindex(PRTE_PersonLinkingADL2V3.Key_PersonHeader_LFZ.Key, 			key_logical_LFZ,				overwrite);
BK2 := buildindex(PRTE_PersonLinkingADL2V3.Key_PersonHeader_ADDRESS3.Key, key_logical_address3,		overwrite);
BK3 := buildindex(PRTE_PersonLinkingADL2V3.Key_PersonHeader_S.Key,				key_logical_SSN,				overwrite);
BK4 := buildindex(PRTE_PersonLinkingADL2V3.Key_PersonHeader_SSN4.Key,			key_logical_SSN4,				overwrite);
BK5 := buildindex(PRTE_PersonLinkingADL2V3.Key_PersonHeader_DO.Key,				key_logical_DOB,				overwrite);
BK6 := buildindex(PRTE_PersonLinkingADL2V3.Key_PersonHeader_PH.Key,				key_logical_PHONE,			overwrite);
BK7 := buildindex(PRTE_PersonLinkingADL2V3.Key_PersonHeader_ZPRF.Key,			key_logical_ZPRF,				overwrite);
BK8 := buildindex(PRTE_PersonLinkingADL2V3.Key_PersonHeader_FLST.Key, 		key_logical_FLST,				overwrite);

return	sequential(
	parallel(
		BK1
		,BK2
		,BK3
		,BK4
		,BK5
		,BK6
		,BK7
		,BK8
	),
	PRTE.CopyMissingkeys('PersonSlimsortKeys', pIndexVersion, pIndexOldVersion),
	PRTE.UpdateVersion('PersonSlimsortKeys',	pIndexVersion,	_control.MyInfo.EmailAddressNormal,	'B', 'N', 'N')
	);

end;		