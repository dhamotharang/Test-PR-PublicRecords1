/*--SOAP--
<message name="LGID3CompareService">
<part name="LGID3One" type="xsd:string"/>
<part name="LGID3Two" type="xsd:string"/>
<part name="rcidOne" type="xsd:string"/>
<part name="rcidTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT LGID3CompareService := MACRO
  IMPORT SALT311,BIPV2_LGID3;
STRING50 LGID3onestr := ''  : STORED('LGID3One');
STRING20 LGID3twostr := '*'  : STORED('LGID3two');
STRING50 rcidonestr := ''  : STORED('rcidOne');
STRING20 rcidtwostr := '*'  : STORED('rcidtwo');
UNSIGNED8 LGID3one0 := (UNSIGNED8)SALT311.utWord(LGID3onestr,1); // Allow for two token on a line input
UNSIGNED8 LGID3two0 := (UNSIGNED8)(IF(LGID3twostr='*',SALT311.utWord(LGID3onestr,2),LGID3twostr));
UNSIGNED8 rcidone0 := (UNSIGNED8)SALT311.utWord(rcidonestr,1); // Allow for two token on a line input
UNSIGNED8 rcidtwo0 := (UNSIGNED8)(IF(rcidtwostr='*',SALT311.utWord(rcidonestr,2),rcidtwostr));
UNSIGNED8 LGID3one := IF( LGID3one0>=LGID3two0, LGID3one0, LGID3two0 );
UNSIGNED8 LGID3two := IF( LGID3one0>=LGID3two0, LGID3two0, LGID3one0 );
UNSIGNED8 rcidone := IF( LGID3one0>=LGID3two0, rcidone0, rcidtwo0 );
UNSIGNED8 rcidtwo := IF( LGID3one0>=LGID3two0, rcidtwo0, rcidone0 );
BFile := BIPV2_LGID3.In_LGID3;
odl := PROJECT(CHOOSEN(BIPV2_LGID3.Keys(BFile).Candidates(LGID3=LGID3one),100000),BIPV2_LGID3.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_LGID3.Keys(BFile).Candidates(LGID3=LGID3Two),100000),BIPV2_LGID3.match_candidates(BFile).layout_candidates);
k := BIPV2_LGID3.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_LGID3.Layout_Specificities.R)[1]);
odlv := BIPV2_LGID3.Debug(BFile, s).RolledEntities(odl);
odrv := BIPV2_LGID3.Debug(BFile, s).RolledEntities(odr);
BIPV2_LGID3.match_candidates(BFile).layout_attribute_matches ainto(BIPV2_LGID3.Keys(BFile).Attribute_Matches le) := TRANSFORM
  SELF := le;
END;
am := PROJECT(LIMIT(BIPV2_LGID3.Keys(BFile).Attribute_Matches(LGID31=LGID3one,LGID32=LGID3two),BIPV2_LGID3.Config.JoinLimit)+LIMIT(BIPV2_LGID3.Keys(BFile).Attribute_Matches(LGID31=LGID3two,LGID32=LGID3one),BIPV2_LGID3.Config.JoinLimit),ainto(LEFT));
odl_match := IF(rcidone > 0, odl(rcid = rcidone), odl);
odr_match := IF(rcidtwo > 0, odr(rcid = rcidtwo), odr);
mtch0 := BIPV2_LGID3.Debug(BFile, s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,LGID3one,LGID3two,0,0}],BIPV2_LGID3.match_candidates(BFile).layout_matches),am);
mtch1 := IF(rcidone > 0, mtch0(rcid1 = rcidone OR rcid2 = rcidone), mtch0);
mtch2 := IF(rcidtwo > 0, mtch1(rcid1 = rcidtwo OR rcid2 = rcidtwo), mtch1);
mtch  := CHOOSEN(SORT(mtch2,-Conf),20);
score := TABLE(mtch, {LGID31, LGID32, rcid1, rcid2, conf, attribute_conf, sbfe_id_score, Lgid3IfHrchy_score,Lgid3IfHrchy_score_prop, company_name_score,company_name_score_prop, cnp_number_score,cnp_number_score_prop, active_duns_number_score,active_duns_number_score_prop, duns_number_score,duns_number_score_prop, duns_number_concept_score,duns_number_concept_score_prop, company_fein_score, company_inc_state_score,company_inc_state_score_prop, company_charter_number_score,company_charter_number_score_prop, cnp_btype_score});
// Put out easy to read versions of the LGID3 data
OUTPUT( odlv,NAMED('LGID3OneFieldValues'));
OUTPUT( odrv,NAMED('LGID3TwoFieldValues'));
// Put out the actually matching information, detailed and scores only
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
OUTPUT( SORT(score,-Conf),NAMED('RecordMatches_ScoresOnly'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('LGID3OneRecords'));
OUTPUT( odr,NAMED('LGID3TwoRecords'));
ENDMACRO;
 
