/*--SOAP--
<message name="SeleidCompareService">
<part name="SeleidOne" type="xsd:string"/>
<part name="SeleidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT SeleidCompareService := MACRO
  IMPORT SALT31,BIPV2_Seleid_Relative,ut;
STRING50 Seleidonestr := ''  : STORED('SeleidOne');
STRING20 Seleidtwostr := '*'  : STORED('Seleidtwo');
UNSIGNED8 Seleidone0 := (UNSIGNED8)ut.Word(Seleidonestr,1); // Allow for two token on a line input
UNSIGNED8 Seleidtwo0 := (UNSIGNED8)(IF(Seleidtwostr='*',ut.Word(Seleidonestr,2),Seleidtwostr));
UNSIGNED8 Seleidone := IF( Seleidone0>Seleidtwo0, Seleidone0, Seleidtwo0 );
UNSIGNED8 Seleidtwo := IF( Seleidone0>Seleidtwo0, Seleidtwo0, Seleidone0 );
BFile := BIPV2_Seleid_Relative.In_Base;
odl := PROJECT(CHOOSEN(BIPV2_Seleid_Relative.Keys(BFile).Candidates(Seleid=Seleidone),100000),BIPV2_Seleid_Relative.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_Seleid_Relative.Keys(BFile).Candidates(Seleid=SeleidTwo),100000),BIPV2_Seleid_Relative.match_candidates(BFile).layout_candidates);
k := BIPV2_Seleid_Relative.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_Seleid_Relative.Layout_Specificities.R)[1]);
odlv := BIPV2_Seleid_Relative.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_Seleid_Relative.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_Seleid_Relative.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Seleidone,Seleidtwo,0,0}],BIPV2_Seleid_Relative.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the Seleid data
OUTPUT( odlv,NAMED('SeleidOneFieldValues'));
OUTPUT( odrv,NAMED('SeleidTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// Now put out the relationship information
rel := BIPV2_Seleid_Relative.Relationships(BFile,odl+odr,s);
OUTPUT(Rel.NAMEST_Links_np,NAMED('NAMESTLinks'));
OUTPUT(Rel.CHARTER_Links_np,NAMED('CHARTERLinks'));
OUTPUT(Rel.FEIN_Links_np,NAMED('FEINLinks'));
OUTPUT(Rel.CONTACT_Links_np,NAMED('CONTACTLinks'));
OUTPUT(Rel.ADDRESS_Links_np,NAMED('ADDRESSLinks'));
OUTPUT(Rel.DUNS_NUMBER_Links_np,NAMED('DUNS_NUMBERLinks'));
OUTPUT(Rel.ENTERPRISE_NUMBER_Links_np,NAMED('ENTERPRISE_NUMBERLinks'));
OUTPUT(Rel.SOURCE_Links_np,NAMED('SOURCELinks'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('SeleidOneRecords'));
OUTPUT( odr,NAMED('SeleidTwoRecords'));
ENDMACRO;
