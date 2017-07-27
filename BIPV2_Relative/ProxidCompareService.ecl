/*--SOAP--
<message name="ProxidCompareService">
<part name="ProxidOne" type="xsd:string"/>
<part name="ProxidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT ProxidCompareService := MACRO
  IMPORT SALT25,BIPV2_Relative,ut;
STRING50 Proxidonestr := ''  : STORED('ProxidOne');
STRING20 Proxidtwostr := '*'  : STORED('Proxidtwo');
UNSIGNED8 Proxidone0 := (UNSIGNED8)ut.Word(Proxidonestr,1); // Allow for two token on a line input
UNSIGNED8 Proxidtwo0 := (UNSIGNED8)(IF(Proxidtwostr='*',ut.Word(Proxidonestr,2),Proxidtwostr));
UNSIGNED8 Proxidone := IF( Proxidone0>Proxidtwo0, Proxidone0, Proxidtwo0 );
UNSIGNED8 Proxidtwo := IF( Proxidone0>Proxidtwo0, Proxidtwo0, Proxidone0 );
BFile := BIPV2_Relative.In_DOT_Base;
odl := PROJECT(CHOOSEN(BIPV2_Relative.Keys(BFile).Candidates(Proxid=Proxidone),100000),BIPV2_Relative.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_Relative.Keys(BFile).Candidates(Proxid=ProxidTwo),100000),BIPV2_Relative.match_candidates(BFile).layout_candidates);
k := BIPV2_Relative.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_Relative.Layout_Specificities.R)[1]);
odlv := BIPV2_Relative.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_Relative.Debug(BFile,s).RolledEntities(odr);
mtch := BIPV2_Relative.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],BIPV2_Relative.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 5010304 data
OUTPUT( odlv,NAMED('ProxidOneFieldValues'));
OUTPUT( odrv,NAMED('ProxidTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// Now put out the relationship information
rel := BIPV2_Relative.Relationships(BFile,odl+odr,s);
OUTPUT(Rel.NAMEST_Links_np,NAMED('NAMESTLinks'));
OUTPUT(Rel.CHARTER_Links_np,NAMED('CHARTERLinks'));
OUTPUT(Rel.FEIN_Links_np,NAMED('FEINLinks'));
OUTPUT(Rel.CONTACT_Links_np,NAMED('CONTACTLinks'));
OUTPUT(Rel.ADDRESS_Links_np,NAMED('ADDRESSLinks'));
OUTPUT(Rel.DUNS_NUMBER_Links_np,NAMED('DUNS_NUMBERLinks'));
OUTPUT(Rel.ENTERPRISE_NUMBER_Links_np,NAMED('ENTERPRISE_NUMBERLinks'));
OUTPUT(Rel.SOURCE_Links_np,NAMED('SOURCELinks'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('ProxidOneRecords'));
OUTPUT( odr,NAMED('ProxidTwoRecords'));
ENDMACRO;
