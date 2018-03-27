//-----------------------------------------------------------------------------
// Double check keys looking for Alpharetta data (did is in our range)
// Alter to do the Foreign_Prod files if you need to
//-----------------------------------------------------------------------------
IMPORT Phonesplus_v2, PRTE2_Phonesplus_Ins;

key_phonesplus_did := index(DATASET([],Phonesplus_v2.Layout_Phonesplus_Base),
														{unsigned6 l_did := did},{Phonesplus_v2.Layout_Phonesplus_Base},
														'~prte::key::phonesplusv2::20150526::did');
PhoneLayoutI := RECORD
	STRING7 p7;
	STRING3 p3;
	STRING6 dph_lname;
	STRING20 pfname;
	STRING2 st;
END;
PhoneLayout := RECORD
	PhoneLayoutI;
	UNSIGNED6 did;
END;
fdidLay := RECORD
	unsigned6 fdid;
END;	
xl_phonesplus := Phonesplus_v2.layout_in_phonesplus.layout_in_common;

key_phonesplus_phones	:= index(DATASET([],PhoneLayout),
														{PhoneLayoutI},{PhoneLayout},
														'~prte::key::phonesplusv2::20150526::phone');

key_phonesplus_fdid := index(DATASET([],xl_phonesplus),
														{fdidLay},{xl_phonesplus},
														'~prte::key::phonesplusv2::20150526::fdids');

Base := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_Prod;

DIDTest := 888809001890;
p_did_key := PULL(key_phonesplus_did);
PdidkeyCmpB := SORT(p_did_key(did < 888809000000 OR did > 888908999999),did );
PdidkeyCmp := SORT(p_did_key(did > 888809000000 AND did < 888908999999),did );
PdidKeyNew := PdidkeyCmp(cellphone[1] <> '1');
OUTPUT(COUNT(PdidkeyCmpB),NAMED('PP_did_BocaRecsCNT'));
OUTPUT(COUNT(PdidkeyCmp),NAMED('PP_did_AlphaRecsCNT'));
OUTPUT(COUNT(PdidKeyNew),NAMED('PP_did_New_CNT'));
OUTPUT(PdidKeyNew,NAMED('PP_did_New'));

//---------------------------------------------------------------------------------------
PHTest := '5551212';

OUTPUT(key_phonesplus_did(l_did=DidTest),NAMED('PP_DID_Sample'));

Tmp1 := key_phonesplus_phones(p7=PHTest);
OUTPUT(Tmp1,NAMED('PP_AP_555_S'));
Pkey := PULL(key_phonesplus_phones);
PkeyTmp := JOIN(Pkey,key_phonesplus_fdid,
									LEFT.did = RIGHT.fdid,
									TRANSFORM( {key_phonesplus_fdid}
									,SELF := RIGHT
									,SELF := []
									)
							);
PkeyCmpB := SORT(PkeyTmp(did < 888809000000 OR did > 888908999999),did );
PkeyCmp := SORT(PkeyTmp(did > 888809000000 AND did < 888908999999),did );

OUTPUT(COUNT(Pkey),NAMED('PP_AutoPhonesCNT'));
OUTPUT(COUNT(PkeyCmpB),NAMED('PP_AP_BocaRecs'));
OUTPUT(PkeyCmpB,NAMED('PP_AP_BocaRecsCNT'));
							
OUTPUT(PkeyTmp,NAMED('PP_AP_Payload'));
OUTPUT(COUNT(PkeyTmp),NAMED('PP_AP_PayloadCNT'));
OUTPUT(COUNT(PkeyCmp),NAMED('PP_AP_AlphaPayloadCNT'));
OUTPUT(PkeyCmp);
PkeyCmp2 := PkeyCmp(cellphone[1] <> '1');
OUTPUT(PkeyCmp2,NAMED('PP_AP_NewRecs'));
