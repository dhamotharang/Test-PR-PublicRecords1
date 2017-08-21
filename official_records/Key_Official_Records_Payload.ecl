import autokeyb2,doxie;

fakepf := official_records.File_Autokey_Party;

fname  := '~thor_200::key::official_records::autokey::payload';
// For testing on dataland, comment out the line above and uncomment the line below.
// Make the same change to: Constants, Key_Document_ORID and Key_Party_ORID.
//fname  := '~thor_data400::key::official_records::autokey::payload';

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',zeroDID,zeroBDID,fname,plk,'');

export Key_Official_Records_Payload := plk;
