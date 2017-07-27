IMPORT AutokeyB2;

fakepf := DATASET([], AMS.Layouts.Base.Main_Without_Rid);

ak_qa_keyname := AMS._Constants().ak_qa_keyname;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                             did, bdid, ak_qa_keyname + 'Payload', plk, '');

EXPORT Key_Autokey_Payload := plk;