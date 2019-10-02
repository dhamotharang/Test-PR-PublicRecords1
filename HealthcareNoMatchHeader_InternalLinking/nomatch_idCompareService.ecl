/*--SOAP--
<message name="nomatch_idCompareService">
<part name="nomatch_idOne" type="xsd:string"/>
<part name="nomatch_idTwo" type="xsd:string"/>
<part name="RIDOne" type="xsd:string"/>
<part name="RIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT nomatch_idCompareService := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader_InternalLinking;
/*HACK-O-MATIC*/pSrc :=  '16935732';
// pVersion  := (STRING)STD.Date.Today();
pVersion  := '20190925';
STRING50 nomatch_idonestr := ''  : STORED('nomatch_idOne');
STRING20 nomatch_idtwostr := '*'  : STORED('nomatch_idtwo');
STRING50 RIDonestr := ''  : STORED('RIDOne');
STRING20 RIDtwostr := '*'  : STORED('RIDtwo');
UNSIGNED8 nomatch_idone0 := (UNSIGNED8)SALT311.utWord(nomatch_idonestr,1); // Allow for two token on a line input
UNSIGNED8 nomatch_idtwo0 := (UNSIGNED8)(IF(nomatch_idtwostr='*',SALT311.utWord(nomatch_idonestr,2),nomatch_idtwostr));
UNSIGNED8 RIDone0 := (UNSIGNED8)SALT311.utWord(RIDonestr,1); // Allow for two token on a line input
UNSIGNED8 RIDtwo0 := (UNSIGNED8)(IF(RIDtwostr='*',SALT311.utWord(RIDonestr,2),RIDtwostr));
UNSIGNED8 nomatch_idone := IF( nomatch_idone0>=nomatch_idtwo0, nomatch_idone0, nomatch_idtwo0 );
UNSIGNED8 nomatch_idtwo := IF( nomatch_idone0>=nomatch_idtwo0, nomatch_idtwo0, nomatch_idone0 );
UNSIGNED8 RIDone := IF( nomatch_idone0>=nomatch_idtwo0, RIDone0, RIDtwo0 );
UNSIGNED8 RIDtwo := IF( nomatch_idone0>=nomatch_idtwo0, RIDtwo0, RIDone0 );
/*HACK-O-MATIC*/BFile := HealthcareNoMatchHeader_Ingest.Files(pSrc,pVersion).AllRecords;
odl := PROJECT(CHOOSEN(/*HACK-O-MATIC*/HealthcareNoMatchHeader_InternalLinking.Keys(pSrc,pVersion,BFile).Candidates(nomatch_id=nomatch_idone),100000),HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/match_candidates(pSrc,pVersion,BFile).layout_candidates);
odr := PROJECT(CHOOSEN(/*HACK-O-MATIC*/HealthcareNoMatchHeader_InternalLinking.Keys(pSrc,pVersion,BFile).Candidates(nomatch_id=nomatch_idTwo),100000),HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/match_candidates(pSrc,pVersion,BFile).layout_candidates);
k := /*HACK-O-MATIC*/HealthcareNoMatchHeader_InternalLinking.Keys(pSrc,pVersion,BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,HealthcareNoMatchHeader_InternalLinking.Layout_Specificities.R)[1]);
odlv := HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/Debug(pSrc, pVersion, BFile, s).RolledEntities(odl);
odrv := HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/Debug(pSrc, pVersion, BFile, s).RolledEntities(odr);
odl_match := IF(RIDone > 0, odl(RID = RIDone), odl);
odr_match := IF(RIDtwo > 0, odr(RID = RIDtwo), odr);
mtch0 := HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/Debug(pSrc, pVersion, BFile, s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,nomatch_idone,nomatch_idtwo,0,0}],HealthcareNoMatchHeader_InternalLinking./*HACK-O-MATIC*/match_candidates(pSrc,pVersion,BFile).layout_matches));
mtch1 := IF(RIDone > 0, mtch0(RID1 = RIDone OR RID2 = RIDone), mtch0);
mtch2 := IF(RIDtwo > 0, mtch1(RID1 = RIDtwo OR RID2 = RIDtwo), mtch1);
mtch  := CHOOSEN(SORT(mtch2,-Conf),20);
score := TABLE(mtch, {nomatch_id1, nomatch_id2, RID1, RID2, conf, SSN_score, DOB_score,DOB_score_prop, LEXID_score,LEXID_score_prop, SUFFIX_score,SUFFIX_score_prop, FNAME_score,FNAME_score_prop, MNAME_score,MNAME_score_prop, LNAME_score,LNAME_score_prop, GENDER_score, PRIM_NAME_score, PRIM_RANGE_score, SEC_RANGE_score, CITY_NAME_score, ST_score, ZIP_score, MAINNAME_score,MAINNAME_score_prop, ADDR1_score, LOCALE_score, ADDRESS_score, FULLNAME_score,FULLNAME_score_prop});
// Put out easy to read versions of the nomatch_id data
OUTPUT( odlv,NAMED('nomatch_idOneFieldValues'));
OUTPUT( odrv,NAMED('nomatch_idTwoFieldValues'));
// Put out the actually matching information, detailed and scores only
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
OUTPUT( SORT(score,-Conf),NAMED('RecordMatches_ScoresOnly'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('nomatch_idOneRecords'));
OUTPUT( odr,NAMED('nomatch_idTwoRecords'));
ENDMACRO;
 
