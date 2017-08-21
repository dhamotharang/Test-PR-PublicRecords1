IMPORT AutokeyB2;

fakepf := DATASET([], CLIA.Layouts.Keybuild);

ak_qa_keyname := CLIA._Constants().ak_qa_keyname;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                             0, bdid, ak_qa_keyname + 'Payload', plk, ''); // No DID info. to get

EXPORT Key_Autokey_Payload := plk;