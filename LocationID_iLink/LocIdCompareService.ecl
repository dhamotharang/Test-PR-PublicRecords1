/*--SOAP--
<message name="LocIdCompareService">
<part name="LocIdOne" type="xsd:string"/>
<part name="LocIdTwo" type="xsd:string"/>
<part name="ridOne" type="xsd:string"/>
<part name="ridTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT LocIdCompareService := MACRO
  IMPORT SALT37,LocationId_iLink;
STRING50 LocIdonestr := ''  : STORED('LocIdOne');
STRING20 LocIdtwostr := '*'  : STORED('LocIdtwo');
STRING50 ridonestr := ''  : STORED('ridOne');
STRING20 ridtwostr := '*'  : STORED('ridtwo');
UNSIGNED8 LocIdone0 := (UNSIGNED8)SALT37.utWord(LocIdonestr,1); // Allow for two token on a line input
UNSIGNED8 LocIdtwo0 := (UNSIGNED8)(IF(LocIdtwostr='*',SALT37.utWord(LocIdonestr,2),LocIdtwostr));
UNSIGNED8 ridone0 := (UNSIGNED8)SALT37.utWord(ridonestr,1); // Allow for two token on a line input
UNSIGNED8 ridtwo0 := (UNSIGNED8)(IF(ridtwostr='*',SALT37.utWord(ridonestr,2),ridtwostr));
UNSIGNED8 LocIdone := IF( LocIdone0>=LocIdtwo0, LocIdone0, LocIdtwo0 );
UNSIGNED8 LocIdtwo := IF( LocIdone0>=LocIdtwo0, LocIdtwo0, LocIdone0 );
UNSIGNED8 ridone := IF( LocIdone0>=LocIdtwo0, ridone0, ridtwo0 );
UNSIGNED8 ridtwo := IF( LocIdone0>=LocIdtwo0, ridtwo0, ridone0 );
BFile := LocationId_iLink.In_LocationId;
odl := PROJECT(CHOOSEN(LocationId_iLink.Keys(BFile).Candidates(LocId=LocIdone),100000),LocationId_iLink.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(LocationId_iLink.Keys(BFile).Candidates(LocId=LocIdTwo),100000),LocationId_iLink.match_candidates(BFile).layout_candidates);
k := LocationId_iLink.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,LocationId_iLink.Layout_Specificities.R)[1]);
odlv := LocationId_iLink.Debug(BFile,s).RolledEntities(odl);
odrv := LocationId_iLink.Debug(BFile,s).RolledEntities(odr);
odl_match := IF(ridone > 0, odl(rid = ridone), odl);
odr_match := IF(ridtwo > 0, odr(rid = ridtwo), odr);
mtch0 := LocationId_iLink.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,LocIdone,LocIdtwo,0,0}],LocationId_iLink.match_candidates(BFile).layout_matches));
mtch1 := IF(ridone > 0, mtch0(rid1 = ridone OR rid2 = ridone), mtch0);
mtch2 := IF(ridtwo > 0, mtch1(rid1 = ridtwo OR rid2 = ridtwo), mtch1);
mtch  := CHOOSEN(SORT(mtch2,-Conf),20);
score := TABLE(mtch, {LocId1, LocId2, rid1, rid2, conf, prim_range_score, predir_score, prim_name_score, addr_suffix_score, postdir_score, sec_range_score, v_city_name_score, st_score, zip5_score, err_stat_score, cntprimname_score});
// Put out easy to read versions of the LocId data
OUTPUT( odlv,NAMED('LocIdOneFieldValues'));
OUTPUT( odrv,NAMED('LocIdTwoFieldValues'));
// Put out the actually matching information, detailed and scores only
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
OUTPUT( SORT(score,-Conf),NAMED('RecordMatches_ScoresOnly'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('LocIdOneRecords'));
OUTPUT( odr,NAMED('LocIdTwoRecords'));
ENDMACRO;
 
