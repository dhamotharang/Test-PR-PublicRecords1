IMPORT AutokeyB2;

fakepf := PROJECT(NCPDP.Files().Keybuild_base.Built,
                  TRANSFORM(Layouts.Slim_Autokey_Business, SELF := LEFT, SELF := []));

ak_qa_keyname := NCPDP.Constants().ak_qa_keyname_DBAPhys;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                          did, bdid, ak_qa_keyname + 'Payload', plk, '');

EXPORT key_AutokeyPayload_DBAPhys := plk;