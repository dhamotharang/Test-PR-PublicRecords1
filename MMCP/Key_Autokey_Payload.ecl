IMPORT AutokeyB2;

fakepf := DATASET([], MMCP.Layouts.Base);

ak_qa_keyname := MMCP._Constants().ak_qa_keyname;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                             did, bdid, ak_qa_keyname + 'Payload', plk, '');

EXPORT Key_Autokey_Payload := plk;