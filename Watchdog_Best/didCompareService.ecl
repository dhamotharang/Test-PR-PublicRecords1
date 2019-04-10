/*--SOAP--
<message name="didCompareService">
<part name="didOne" type="xsd:string"/>
<part name="didTwo" type="xsd:string"/>
<part name="ridOne" type="xsd:string"/>
<part name="ridTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT didCompareService := MACRO
  IMPORT SALT311,Watchdog_best;
STRING50 didonestr := ''  : STORED('didOne');
STRING20 didtwostr := '*'  : STORED('didtwo');
STRING50 ridonestr := ''  : STORED('ridOne');
STRING20 ridtwostr := '*'  : STORED('ridtwo');
UNSIGNED8 didone0 := (UNSIGNED8)SALT311.utWord(didonestr,1); // Allow for two token on a line input
UNSIGNED8 didtwo0 := (UNSIGNED8)(IF(didtwostr='*',SALT311.utWord(didonestr,2),didtwostr));
UNSIGNED8 ridone0 := (UNSIGNED8)SALT311.utWord(ridonestr,1); // Allow for two token on a line input
UNSIGNED8 ridtwo0 := (UNSIGNED8)(IF(ridtwostr='*',SALT311.utWord(ridonestr,2),ridtwostr));
UNSIGNED8 didone := IF( didone0>=didtwo0, didone0, didtwo0 );
UNSIGNED8 didtwo := IF( didone0>=didtwo0, didtwo0, didone0 );
UNSIGNED8 ridone := IF( didone0>=didtwo0, ridone0, ridtwo0 );
UNSIGNED8 ridtwo := IF( didone0>=didtwo0, ridtwo0, ridone0 );
BFile := Watchdog_best.In_Hdr;
odl := PROJECT(CHOOSEN(Watchdog_best.Keys(BFile).Candidates(did=didone),100000),Watchdog_best.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(Watchdog_best.Keys(BFile).Candidates(did=didTwo),100000),Watchdog_best.match_candidates(BFile).layout_candidates);
k := Watchdog_best.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,Watchdog_best.Layout_Specificities.R)[1]);
odlv := Watchdog_best.Debug(BFile, s).RolledEntities(odl);
odrv := Watchdog_best.Debug(BFile, s).RolledEntities(odr);
odl_match := IF(ridone > 0, odl(rid = ridone), odl);
odr_match := IF(ridtwo > 0, odr(rid = ridtwo), odr);
mtch0 := Watchdog_best.Debug(BFile, s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,didone,didtwo,0,0}],Watchdog_best.match_candidates(BFile).layout_matches));
mtch1 := IF(ridone > 0, mtch0(rid1 = ridone OR rid2 = ridone), mtch0);
mtch2 := IF(ridtwo > 0, mtch1(rid1 = ridtwo OR rid2 = ridtwo), mtch1);
mtch  := CHOOSEN(SORT(mtch2,-Conf),20);
score := TABLE(mtch, {did1, did2, rid1, rid2, conf, pflag1_score, pflag2_score, pflag3_score, src_score, dt_first_seen_score, dt_last_seen_score, dt_vendor_last_reported_score, dt_vendor_first_reported_score, dt_nonglb_last_seen_score, rec_type_score, phone_score, ssn_score, dob_score, title_score, fname_score,fname_score_prop, mname_score,mname_score_prop, lname_score, name_suffix_score, prim_range_score, predir_score, prim_name_score, suffix_score, postdir_score, unit_desig_score, sec_range_score, city_name_score, st_score, zip_score, zip4_score, tnt_score, valid_ssn_score, jflag1_score, jflag2_score, jflag3_score, rawaid_score, dodgy_tracking_score, address_ind_score, name_ind_score, persistent_record_id_score, ssnum_score, address_score});
// Put out easy to read versions of the did data
OUTPUT( odlv,NAMED('didOneFieldValues'));
OUTPUT( odrv,NAMED('didTwoFieldValues'));
// Put out the actually matching information, detailed and scores only
OUTPUT( SORT(mtch,-Conf),NAMED('RecordMatches'));
OUTPUT( SORT(score,-Conf),NAMED('RecordMatches_ScoresOnly'));
// The raw data - for the truly psycho!
OUTPUT( odl,NAMED('didOneRecords'));
OUTPUT( odr,NAMED('didTwoRecords'));
ENDMACRO;

