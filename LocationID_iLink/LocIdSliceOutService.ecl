/*--SOAP--
<message name="LocIdSliceOutService">
<part name="BaseLocId" type="xsd:string"/>
<part name="Baserid" type="xsd:string"/>
<part name="PreferredLocId" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Baserid should be plucked out of BaseLocId. If a preferred LocId is provided it will be compared to the rid too.*/
EXPORT LocIdSliceOutService := MACRO
  IMPORT SALT37,LocationId_iLink;
STRING20 ridstr := ''  : STORED('Baserid');
STRING20 LocIdstr := ''  : STORED('BaseLocId');
STRING20 Pref_LocIdstr := ''  : STORED('PreferredLocId');
BFile := LocationId_iLink.In_LocationId;
LocationId_iLink.match_candidates(BFile).layout_candidates into(LocationId_iLink.Keys(BFile).Candidates le) := TRANSFORM
  SELF := le;
END;
odl := PROJECT(CHOOSEN(LocationId_iLink.Keys(BFile).Candidates(LocId=(UNSIGNED)LocIdstr),10000),into(LEFT));
odr := PROJECT(CHOOSEN(LocationId_iLink.Keys(BFile).Candidates(LocId=(UNSIGNED)Pref_LocIdstr),10000),into(LEFT));
k := LocationId_iLink.Keys(BFile).Specificities_Key;
LocationId_iLink.Layout_Specificities.R s_into(k le) := TRANSFORM
  SELF := le;
END;
s := GLOBAL(PROJECT(k,s_into(LEFT))[1]);
odl_noprop := LocationId_iLink.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := LocationId_iLink.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := LocationId_iLink.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(UNSIGNED)ridstr);
mtchrnp := LocationId_iLink.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rid=(UNSIGNED)ridstr),(UNSIGNED)ridstr);
odl_noprop_roll_ridonly := LocationId_iLink.Debug(BFile,s).RolledEntities(odl_noprop(rid = (UNSIGNED)ridstr));
OUTPUT(odl_noprop_roll_ridonly, NAMED('TargetSlicedrid'));
odr_noprop_roll := LocationId_iLink.Debug(BFile,s).RolledEntities(odr_noprop);
OUTPUT(odr_noprop_roll, NAMED('PrefLocIdRollup'));
odl_noprop_roll := LocationId_iLink.Debug(BFile,s).RolledEntities(odl_noprop(rid <> (UNSIGNED)ridstr));
OUTPUT(odl_noprop_roll, NAMED('CurrentLocIdRollupMinusToSlicerid'));
mtch := LocationId_iLink.Debug(BFile,s).AnnotateClusterMatches(odl,(UNSIGNED)ridstr);
mtchr := LocationId_iLink.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rid=(UNSIGNED)ridstr),(UNSIGNED)ridstr);
OUTPUT( CHOOSEN(SORT(mtch,-(conf-conf_prop)),3),NAMED('RecordMatches_WithProps'));
OUTPUT( CHOOSEN(SORT(mtchr,-(conf-conf_prop)),3),NAMED('PreferredRecordMatches_WithProps'));
OUTPUT( odl,NAMED('LocIdValues'));
OUTPUT( odr,NAMED('PreferredLocIdValues'));
OUTPUT( odl_noprop,NAMED('LocIdValues_NoProp'));
OUTPUT( odr_noprop,NAMED('PreferredLocIdValues_NoProp'));
ENDMACRO;
 
