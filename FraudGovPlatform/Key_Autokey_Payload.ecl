IMPORT AutokeyB2;

fakepf := DATASET([], FraudGovPlatform.Layouts_key.Autokey);

ak_qa_keyname := Constants().ak_qa_keyname;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                             did, bdid, ak_qa_keyname + 'Payload', plk, '');

EXPORT Key_Autokey_Payload := plk;