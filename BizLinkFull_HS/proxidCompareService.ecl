/*--SOAP--
<message name="proxidCompareService">
<part name="proxidOne" type="xsd:string"/>
<part name="proxidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT proxidCompareService := MACRO
  IMPORT SALT33,BizLinkFull_HS,ut;
STRING50 proxidonestr := ''  : STORED('proxidOne');
STRING20 proxidtwostr := '*'  : STORED('proxidtwo');
UNSIGNED8 proxidone0 := (UNSIGNED8)ut.Word(proxidonestr,1); // Allow for two token on a line input
UNSIGNED8 proxidtwo0 := (UNSIGNED8)(IF(proxidtwostr='*',ut.Word(proxidonestr,2),proxidtwostr));
UNSIGNED8 proxidone := IF( proxidone0>proxidtwo0, proxidone0, proxidtwo0 );
UNSIGNED8 proxidtwo := IF( proxidone0>proxidtwo0, proxidtwo0, proxidone0 );
BFile := BizLinkFull_HS.In_BizHead;
odl := PROJECT(CHOOSEN(BizLinkFull_HS.Keys(BFile).Candidates(proxid=proxidone),100000),BizLinkFull_HS.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BizLinkFull_HS.Keys(BFile).Candidates(proxid=proxidTwo),100000),BizLinkFull_HS.match_candidates(BFile).layout_candidates);
k := BizLinkFull_HS.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BizLinkFull_HS.Layout_Specificities.R)[1]);
odlv := BizLinkFull_HS.Debug(BFile,s).RolledEntities(odl);
odrv := BizLinkFull_HS.Debug(BFile,s).RolledEntities(odr);
mtch := BizLinkFull_HS.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,proxidone,proxidtwo,0,0}],BizLinkFull_HS.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the proxid data
OUTPUT( odlv,NAMED('proxidOneFieldValues'));
OUTPUT( odrv,NAMED('proxidTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('proxidOneRecords'));
OUTPUT( odr,NAMED('proxidTwoRecords'));
ENDMACRO;
 
