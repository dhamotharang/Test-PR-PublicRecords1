IMPORT AutokeyB2;

// fakepf := DATASET([], CLIA.Layouts.Base);
fakepf := DATASET([], CLIA.Layouts.Keybuild); // Points to old layout until we do a RR or something

ak_qa_keyname := CLIA._Constants().ak_qa_keyname;

AutokeyB2.MAC_FID_Payload(fakepf, '', '', '', '', '', '', '', '', '',
                             0, bdid, ak_qa_keyname + 'Payload', plk, ''); // No DID info. to get

EXPORT Key_Autokey_Payload := plk;