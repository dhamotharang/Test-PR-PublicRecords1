/*--SOAP--
<message name="EmpIDCompareService">
<part name="EmpIDOne" type="xsd:string"/>
<part name="EmpIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT EmpIDCompareService := MACRO
  IMPORT SALT30,BIPV2_EMPID_Platform,ut;
STRING50 EmpIDonestr := ''  : STORED('EmpIDOne');
STRING20 EmpIDtwostr := '*'  : STORED('EmpIDtwo');
UNSIGNED8 EmpIDone0 := (UNSIGNED8)ut.Word(EmpIDonestr,1); // Allow for two token on a line input
UNSIGNED8 EmpIDtwo0 := (UNSIGNED8)(IF(EmpIDtwostr='*',ut.Word(EmpIDonestr,2),EmpIDtwostr));
UNSIGNED8 EmpIDone := IF( EmpIDone0>EmpIDtwo0, EmpIDone0, EmpIDtwo0 );
UNSIGNED8 EmpIDtwo := IF( EmpIDone0>EmpIDtwo0, EmpIDtwo0, EmpIDone0 );
BFile := BIPV2_EMPID_Platform.In_EmpID;
odl := PROJECT(CHOOSEN(BIPV2_EMPID_Platform.Keys(BFile).Candidates(EmpID=EmpIDone),100000),BIPV2_EMPID_Platform.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_EMPID_Platform.Keys(BFile).Candidates(EmpID=EmpIDTwo),100000),BIPV2_EMPID_Platform.match_candidates(BFile).layout_candidates);
k := BIPV2_EMPID_Platform.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_EMPID_Platform.Layout_Specificities.R)[1]);
odlv := BIPV2_EMPID_Platform.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_EMPID_Platform.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_EMPID_Platform.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,EmpIDone,EmpIDtwo,0,0}],BIPV2_EMPID_Platform.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 5195232 data
OUTPUT( odlv,NAMED('EmpIDOneFieldValues'));
OUTPUT( odrv,NAMED('EmpIDTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('EmpIDOneRecords'));
OUTPUT( odr,NAMED('EmpIDTwoRecords'));
ENDMACRO;
 
