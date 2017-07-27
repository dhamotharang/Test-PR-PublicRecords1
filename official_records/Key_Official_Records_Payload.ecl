import autokeyb2,doxie;

fakepf := official_records.File_Autokey_Party;

fname  := '~thor_200::key::official_records::autokey::payload';

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zeroDID,zeroBDID,fname,plk,'');

export Key_Official_Records_Payload := plk;
