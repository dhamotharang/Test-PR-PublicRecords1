IMPORT AutokeyB2;

fakepf := DATASET([], Death_MI.Layouts.Base);

ak_qa_keyname := Death_MI._Constants().ak_qa_keyname;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                             did, 0, ak_qa_keyname + 'Payload', plk, ''); // No BDID.

EXPORT Key_Autokey_Payload := plk;