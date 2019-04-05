/*--SOAP--
<message name="didSliceOutService">
<part name="Basedid" type="xsd:string"/>
<part name="Baserid" type="xsd:string"/>
<part name="Preferreddid" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Baserid should be plucked out of Basedid. If a preferred did is provided it will be compared to the rid too.*/
EXPORT didSliceOutService := MACRO
  IMPORT SALT311,Watchdog_best;
STRING20 ridstr := ''  : STORED('Baserid');
STRING20 didstr := ''  : STORED('Basedid');
STRING20 Pref_didstr := ''  : STORED('Preferreddid');
BFile := Watchdog_best.In_Hdr;
Watchdog_best.match_candidates(BFile).layout_candidates into(Watchdog_best.Keys(BFile).CandidatesForSlice le) := TRANSFORM
  SELF := le;
END;
odl := PROJECT(CHOOSEN(Watchdog_best.Keys(BFile).CandidatesForSlice(did=(UNSIGNED)didstr),10000),into(LEFT));
odr := PROJECT(CHOOSEN(Watchdog_best.Keys(BFile).CandidatesForSlice(did=(UNSIGNED)Pref_didstr),10000),into(LEFT));
k := Watchdog_best.Keys(BFile).Specificities_Key;
Watchdog_best.Layout_Specificities.R s_into(k le) := TRANSFORM
  SELF := le;
END;
s := GLOBAL(PROJECT(k,s_into(LEFT))[1]);
odl_noprop := Watchdog_best.Debug(BFile, s).RemoveProps(odl); // Remove propogated values
odr_noprop := Watchdog_best.Debug(BFile, s).RemoveProps(odr); // Remove propogated values
mtchnp := Watchdog_best.Debug(BFile, s).AnnotateClusterMatches(odl_noprop,(UNSIGNED)ridstr);
mtchrnp := Watchdog_best.Debug(BFile, s).AnnotateClusterMatches(odr_noprop+odl_noprop(rid=(UNSIGNED)ridstr),(UNSIGNED)ridstr);
odl_noprop_roll_ridonly := Watchdog_best.Debug(BFile, s).RolledEntities(odl_noprop(rid = (UNSIGNED)ridstr));
OUTPUT(odl_noprop_roll_ridonly, NAMED('TargetSlicedrid'));
odr_noprop_roll := Watchdog_best.Debug(BFile, s).RolledEntities(odr_noprop);
OUTPUT(odr_noprop_roll, NAMED('PrefdidRollup'));
odl_noprop_roll := Watchdog_best.Debug(BFile, s).RolledEntities(odl_noprop(rid <> (UNSIGNED)ridstr));
OUTPUT(odl_noprop_roll, NAMED('CurrentdidRollupMinusToSlicerid'));
mtch := Watchdog_best.Debug(BFile, s).AnnotateClusterMatches(odl,(UNSIGNED)ridstr);
mtchr := Watchdog_best.Debug(BFile, s).AnnotateClusterMatches(odr+odl(rid=(UNSIGNED)ridstr),(UNSIGNED)ridstr);
OUTPUT( CHOOSEN(SORT(mtch,-(conf-conf_prop)),3),NAMED('RecordMatches_WithProps'));
OUTPUT( CHOOSEN(SORT(mtchr,-(conf-conf_prop)),3),NAMED('PreferredRecordMatches_WithProps'));
OUTPUT( odl,NAMED('didValues'));
OUTPUT( odr,NAMED('PreferreddidValues'));
OUTPUT( odl_noprop,NAMED('didValues_NoProp'));
OUTPUT( odr_noprop,NAMED('PreferreddidValues_NoProp'));
ENDMACRO;

