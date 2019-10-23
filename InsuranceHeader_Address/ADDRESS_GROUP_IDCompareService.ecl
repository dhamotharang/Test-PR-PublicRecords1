/*--SOAP--
<message name="ADDRESS_GROUP_IDCompareService">
<part name="ADDRESS_GROUP_IDOne" type="xsd:string"/>
<part name="ADDRESS_GROUP_IDTwo" type="xsd:string"/>
<part name="RIDOne" type="xsd:string"/>
<part name="RIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT ADDRESS_GROUP_IDCompareService := MACRO
  IMPORT SALT311,InsuranceHeader_Address;
STRING50 ADDRESS_GROUP_IDonestr := ''  : STORED('ADDRESS_GROUP_IDOne');
STRING20 ADDRESS_GROUP_IDtwostr := '*'  : STORED('ADDRESS_GROUP_IDtwo');
STRING50 RIDonestr := ''  : STORED('RIDOne');
STRING20 RIDtwostr := '*'  : STORED('RIDtwo');
UNSIGNED8 ADDRESS_GROUP_IDone0 := (UNSIGNED8)SALT311.utWord(ADDRESS_GROUP_IDonestr,1); // Allow for two token on a line input
UNSIGNED8 ADDRESS_GROUP_IDtwo0 := (UNSIGNED8)(IF(ADDRESS_GROUP_IDtwostr='*',SALT311.utWord(ADDRESS_GROUP_IDonestr,2),ADDRESS_GROUP_IDtwostr));
UNSIGNED8 RIDone0 := (UNSIGNED8)SALT311.utWord(RIDonestr,1); // Allow for two token on a line input
UNSIGNED8 RIDtwo0 := (UNSIGNED8)(IF(RIDtwostr='*',SALT311.utWord(RIDonestr,2),RIDtwostr));
UNSIGNED8 ADDRESS_GROUP_IDone := IF( ADDRESS_GROUP_IDone0>=ADDRESS_GROUP_IDtwo0, ADDRESS_GROUP_IDone0, ADDRESS_GROUP_IDtwo0 );
UNSIGNED8 ADDRESS_GROUP_IDtwo := IF( ADDRESS_GROUP_IDone0>=ADDRESS_GROUP_IDtwo0, ADDRESS_GROUP_IDtwo0, ADDRESS_GROUP_IDone0 );
UNSIGNED8 RIDone := IF( ADDRESS_GROUP_IDone0>=ADDRESS_GROUP_IDtwo0, RIDone0, RIDtwo0 );
UNSIGNED8 RIDtwo := IF( ADDRESS_GROUP_IDone0>=ADDRESS_GROUP_IDtwo0, RIDtwo0, RIDone0 );
BFile := InsuranceHeader_Address.In_Address_Link;
odl := PROJECT(CHOOSEN(InsuranceHeader_Address.Keys(BFile).Candidates(ADDRESS_GROUP_ID=ADDRESS_GROUP_IDone),100000),InsuranceHeader_Address.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(InsuranceHeader_Address.Keys(BFile).Candidates(ADDRESS_GROUP_ID=ADDRESS_GROUP_IDTwo),100000),InsuranceHeader_Address.match_candidates(BFile).layout_candidates);
k := InsuranceHeader_Address.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,InsuranceHeader_Address.Layout_Specificities.R)[1]);
odlv := InsuranceHeader_Address.Debug(BFile, s).RolledEntities(odl);
odrv := InsuranceHeader_Address.Debug(BFile, s).RolledEntities(odr);
odl_match := IF(RIDone > 0, odl(RID = RIDone), odl);
odr_match := IF(RIDtwo > 0, odr(RID = RIDtwo), odr);
mtch0 := InsuranceHeader_Address.Debug(BFile, s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,ADDRESS_GROUP_IDone,ADDRESS_GROUP_IDtwo,0,0}],InsuranceHeader_Address.match_candidates(BFile).layout_matches));
mtch1 := IF(RIDone > 0, mtch0(RID1 = RIDone OR RID2 = RIDone), mtch0);
mtch2 := IF(RIDtwo > 0, mtch1(RID1 = RIDtwo OR RID2 = RIDtwo), mtch1);
mtch  := CHOOSEN(SORT(mtch2,-Conf),20);
score := TABLE(mtch, {ADDRESS_GROUP_ID1, ADDRESS_GROUP_ID2, RID1, RID2, conf, DID_score, prim_range_alpha_score,prim_range_alpha_score_prop, prim_range_num_score,prim_range_num_score_prop, prim_range_fract_score,prim_range_fract_score_prop, prim_name_num_score, prim_name_alpha_score, sec_range_alpha_score,sec_range_alpha_score_prop, sec_range_num_score,sec_range_num_score_prop, city_score, st_score, zip_score, addr_score,addr_score_prop, locale_score});
// Put out easy to read versions of the ADDRESS_GROUP_ID data
OUTPUT( odlv,NAMED('ADDRESS_GROUP_IDOneFieldValues'));
OUTPUT( odrv,NAMED('ADDRESS_GROUP_IDTwoFieldValues'));
// Put out the actually matching information, detailed and scores only
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
OUTPUT( SORT(score,-Conf),NAMED('RecordMatches_ScoresOnly'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('ADDRESS_GROUP_IDOneRecords'));
OUTPUT( odr,NAMED('ADDRESS_GROUP_IDTwoRecords'));
ENDMACRO;
 
