/*--SOAP--
<message name="DOTidCompareService">
<part name="DOTidOne" type="xsd:string"/>
<part name="DOTidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT DOTidCompareService := MACRO
  IMPORT SALT32,BIPV2_DOTID_PLATFORM,ut;
STRING50 DOTidonestr := ''  : STORED('DOTidOne');
STRING20 DOTidtwostr := '*'  : STORED('DOTidtwo');
UNSIGNED8 DOTidone0 := (UNSIGNED8)ut.Word(DOTidonestr,1); // Allow for two token on a line input
UNSIGNED8 DOTidtwo0 := (UNSIGNED8)(IF(DOTidtwostr='*',ut.Word(DOTidonestr,2),DOTidtwostr));
UNSIGNED8 DOTidone := IF( DOTidone0>DOTidtwo0, DOTidone0, DOTidtwo0 );
UNSIGNED8 DOTidtwo := IF( DOTidone0>DOTidtwo0, DOTidtwo0, DOTidone0 );
BFile := BIPV2_DOTID_PLATFORM.In_DOT;
odl := PROJECT(CHOOSEN(BIPV2_DOTID_PLATFORM.Keys(BFile).Candidates(DOTid=DOTidone),100000),BIPV2_DOTID_PLATFORM.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_DOTID_PLATFORM.Keys(BFile).Candidates(DOTid=DOTidTwo),100000),BIPV2_DOTID_PLATFORM.match_candidates(BFile).layout_candidates);
k := BIPV2_DOTID_PLATFORM.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_DOTID_PLATFORM.Layout_Specificities.R)[1]);
odlv := BIPV2_DOTID_PLATFORM.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_DOTID_PLATFORM.Debug(BFile,s).RolledEntities(odr);
BIPV2_DOTID_PLATFORM.match_candidates(BFile).layout_attribute_matches ainto(BIPV2_DOTID_PLATFORM.Keys(BFile).Attribute_Matches le) := TRANSFORM
  SELF := le;
END;
am := PROJECT(BIPV2_DOTID_PLATFORM.Keys(BFile).Attribute_Matches(DOTid1=DOTidone,DOTid2=DOTidtwo)+BIPV2_DOTID_PLATFORM.Keys(BFile).Attribute_Matches(DOTid1=DOTidtwo,DOTid2=DOTidone),ainto(LEFT));
mtch := BIPV2_DOTID_PLATFORM.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,DOTidone,DOTidtwo,0,0}],BIPV2_DOTID_PLATFORM.match_candidates(BFile).layout_matches),am);
// Put out easy to read versions of the DOTid data
OUTPUT( odlv,NAMED('DOTidOneFieldValues'));
OUTPUT( odrv,NAMED('DOTidTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('DOTidOneRecords'));
OUTPUT( odr,NAMED('DOTidTwoRecords'));
ENDMACRO;
 
