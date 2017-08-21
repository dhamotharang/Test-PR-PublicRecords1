/*--SOAP--
<message name="LNPIDCompareService">
<part name="LNPIDOne" type="xsd:string"/>
<part name="LNPIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT LNPIDCompareService := MACRO
  IMPORT SALT30,HealthCareFacilityHeader,ut;
STRING50 LNPIDonestr := ''  : STORED('LNPIDOne');
STRING20 LNPIDtwostr := '*'  : STORED('LNPIDtwo');
UNSIGNED8 LNPIDone0 := (UNSIGNED8)ut.Word(LNPIDonestr,1); // Allow for two token on a line input
UNSIGNED8 LNPIDtwo0 := (UNSIGNED8)(IF(LNPIDtwostr='*',ut.Word(LNPIDonestr,2),LNPIDtwostr));
UNSIGNED8 LNPIDone := IF( LNPIDone0>LNPIDtwo0, LNPIDone0, LNPIDtwo0 );
UNSIGNED8 LNPIDtwo := IF( LNPIDone0>LNPIDtwo0, LNPIDtwo0, LNPIDone0 );
BFile := HealthCareFacilityHeader.In_HealthFacility;
odl := PROJECT(CHOOSEN(HealthCareFacilityHeader.Keys(BFile).Candidates(LNPID=LNPIDone),100000),HealthCareFacilityHeader.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(HealthCareFacilityHeader.Keys(BFile).Candidates(LNPID=LNPIDTwo),100000),HealthCareFacilityHeader.match_candidates(BFile).layout_candidates);
k := HealthCareFacilityHeader.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,HealthCareFacilityHeader.Layout_Specificities.R)[1]);
odlv := HealthCareFacilityHeader.Debug(BFile,s).RolledEntities(odl);
odrv := HealthCareFacilityHeader.Debug(BFile,s).RolledEntities(odr);
mtch := HealthCareFacilityHeader.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,LNPIDone,LNPIDtwo,0,0}],HealthCareFacilityHeader.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 5195232 data
OUTPUT( odlv,NAMED('LNPIDOneFieldValues'));
OUTPUT( odrv,NAMED('LNPIDTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('LNPIDOneRecords'));
OUTPUT( odr,NAMED('LNPIDTwoRecords'));
ENDMACRO;
