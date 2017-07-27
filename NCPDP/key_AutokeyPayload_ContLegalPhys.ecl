IMPORT AutokeyB2;

fakepf := PROJECT(NCPDP.Files().Keybuild_base.Built,
                  TRANSFORM(Layouts.Slim_Autokey_All, SELF := LEFT, SELF := []));

ak_qa_keyname := NCPDP.Constants().ak_qa_keyname_ContLegalPhys;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                          did, bdid, ak_qa_keyname + 'Payload', plk, '');

EXPORT key_AutokeyPayload_ContLegalPhys := plk;