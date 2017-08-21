/*--SOAP--
<message name="DPROPTXIDCompareService">
<part name="DPROPTXIDOne" type="xsd:string"/>
<part name="DPROPTXIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT DPROPTXIDCompareService := MACRO
  IMPORT SALT34,InsuranceHeader_Property_Transactions_DeedsMortgages,ut;
STRING50 DPROPTXIDonestr := ''  : STORED('DPROPTXIDOne');
STRING20 DPROPTXIDtwostr := '*'  : STORED('DPROPTXIDtwo');
UNSIGNED8 DPROPTXIDone0 := (UNSIGNED8)ut.Word(DPROPTXIDonestr,1); // Allow for two token on a line input
UNSIGNED8 DPROPTXIDtwo0 := (UNSIGNED8)(IF(DPROPTXIDtwostr='*',ut.Word(DPROPTXIDonestr,2),DPROPTXIDtwostr));
UNSIGNED8 DPROPTXIDone := IF( DPROPTXIDone0>DPROPTXIDtwo0, DPROPTXIDone0, DPROPTXIDtwo0 );
UNSIGNED8 DPROPTXIDtwo := IF( DPROPTXIDone0>DPROPTXIDtwo0, DPROPTXIDtwo0, DPROPTXIDone0 );
BFile := InsuranceHeader_Property_Transactions_DeedsMortgages.In_PROPERTY_TRANSACTION;
odl := PROJECT(CHOOSEN(InsuranceHeader_Property_Transactions_DeedsMortgages.Keys(BFile).Candidates(DPROPTXID=DPROPTXIDone),100000),InsuranceHeader_Property_Transactions_DeedsMortgages.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(InsuranceHeader_Property_Transactions_DeedsMortgages.Keys(BFile).Candidates(DPROPTXID=DPROPTXIDTwo),100000),InsuranceHeader_Property_Transactions_DeedsMortgages.match_candidates(BFile).layout_candidates);
k := InsuranceHeader_Property_Transactions_DeedsMortgages.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,InsuranceHeader_Property_Transactions_DeedsMortgages.Layout_Specificities.R)[1]);
odlv := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).RolledEntities(odl);
odrv := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).RolledEntities(odr);
mtch := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,DPROPTXIDone,DPROPTXIDtwo,0,0}],InsuranceHeader_Property_Transactions_DeedsMortgages.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the DPROPTXID data
OUTPUT( odlv,NAMED('DPROPTXIDOneFieldValues'));
OUTPUT( odrv,NAMED('DPROPTXIDTwoFieldValues'));
// Put out the actually matching information
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('DPROPTXIDOneRecords'));
OUTPUT( odr,NAMED('DPROPTXIDTwoRecords'));
ENDMACRO;
