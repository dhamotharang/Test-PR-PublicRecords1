/*--SOAP--
<message name="DIDCompareService">
<part name="DIDOne" type="xsd:string"/>
<part name="DIDTwo" type="xsd:string"/>
<part name="RIDOne" type="xsd:string"/>
<part name="RIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT DIDCompareService := MACRO
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
STRING50 DIDonestr := ''  : STORED('DIDOne');
STRING20 DIDtwostr := '*'  : STORED('DIDtwo');
STRING50 RIDonestr := ''  : STORED('RIDOne');
STRING20 RIDtwostr := '*'  : STORED('RIDtwo');
UNSIGNED8 DIDone0 := (UNSIGNED8)SALT37.utWord(DIDonestr,1); // Allow for two token on a line input
UNSIGNED8 DIDtwo0 := (UNSIGNED8)(IF(DIDtwostr='*',SALT37.utWord(DIDonestr,2),DIDtwostr));
UNSIGNED8 RIDone0 := (UNSIGNED8)SALT37.utWord(RIDonestr,1); // Allow for two token on a line input
UNSIGNED8 RIDtwo0 := (UNSIGNED8)(IF(RIDtwostr='*',SALT37.utWord(RIDonestr,2),RIDtwostr));
UNSIGNED8 DIDone := IF( DIDone0>=DIDtwo0, DIDone0, DIDtwo0 );
UNSIGNED8 DIDtwo := IF( DIDone0>=DIDtwo0, DIDtwo0, DIDone0 );
UNSIGNED8 RIDone := IF( DIDone0>=DIDtwo0, RIDone0, RIDtwo0 );
UNSIGNED8 RIDtwo := IF( DIDone0>=DIDtwo0, RIDtwo0, RIDone0 );
BFile := InsuranceHeader_RemoteLinking.In_HEADER;
odl := PROJECT(CHOOSEN(InsuranceHeader_RemoteLinking.Keys(BFile).Candidates(DID=DIDone),100000),InsuranceHeader_RemoteLinking.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(InsuranceHeader_RemoteLinking.Keys(BFile).Candidates(DID=DIDTwo),100000),InsuranceHeader_RemoteLinking.match_candidates(BFile).layout_candidates);
k := InsuranceHeader_RemoteLinking.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,InsuranceHeader_RemoteLinking.Layout_Specificities.R)[1]);
odlv := InsuranceHeader_RemoteLinking.Debug(BFile,s).RolledEntities(odl);
odrv := InsuranceHeader_RemoteLinking.Debug(BFile,s).RolledEntities(odr);
odl_match := IF(RIDone > 0, odl(RID = RIDone), odl);
odr_match := IF(RIDtwo > 0, odr(RID = RIDtwo), odr);
mtch0 := InsuranceHeader_RemoteLinking.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,DIDone,DIDtwo,0,0}],InsuranceHeader_RemoteLinking.match_candidates(BFile).layout_matches));
mtch1 := IF(RIDone > 0, mtch0(RID1 = RIDone OR RID2 = RIDone), mtch0);
mtch2 := IF(RIDtwo > 0, mtch1(RID1 = RIDtwo OR RID2 = RIDtwo), mtch1);
mtch  := CHOOSEN(SORT(mtch2,-Conf),20);
score := TABLE(mtch, {DID1, DID2, RID1, RID2, conf, SSN_score,SSN_score_prop, DOB_score,DOB_score_prop, DL_NBR_score, SNAME_score,SNAME_score_prop, FNAME_score,FNAME_score_prop, MNAME_score,MNAME_score_prop, LNAME_score,LNAME_score_prop, GENDER_score, DERIVED_GENDER_score,DERIVED_GENDER_score_prop, PRIM_NAME_score, PRIM_RANGE_score, SEC_RANGE_score, CITY_score, ST_score, ZIP_score, POLICY_NUMBER_score, CLAIM_NUMBER_score, MAINNAME_score,MAINNAME_score_prop, ADDR1_score, LOCALE_score, ADDRESS_score, FULLNAME_score,FULLNAME_score_prop});
// Put out easy to read versions of the DID data
OUTPUT( odlv,NAMED('DIDOneFieldValues'));
OUTPUT( odrv,NAMED('DIDTwoFieldValues'));
// Put out the actually matching information, detailed and scores only
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
OUTPUT( SORT(score,-Conf),NAMED('RecordMatches_ScoresOnly'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('DIDOneRecords'));
OUTPUT( odr,NAMED('DIDTwoRecords'));
ENDMACRO;
 
