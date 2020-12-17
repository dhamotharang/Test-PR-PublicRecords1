IMPORT doxie_cbrs, ut, STD;

EXPORT industry_information_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

iirs := doxie_cbrs.industry_information_records(bdids)(Include_IndustryInfo_val);
e5600iirs := IF(NOT doxie.DataRestriction.EBR,doxie_cbrs.industry_information_EBR_5600_records(bdids)(Include_IndustryInfo_val));
e0010iirs := IF(NOT doxie.DataRestriction.EBR,doxie_cbrs.industry_information_EBR_0010_records(bdids)(Include_IndustryInfo_val));

// Uncomment below as needed for debugging
//output(Include_IndustryInfo_val, named('iirt_include_ii_val'));
//output(doxie.DataRestriction.EBR, named('iirt_ddr_ebr'));

ii_rec := RECORD(doxie_cbrs.layouts.industry_info_slim_record)
  UNSIGNED6 bdid;
END;

ii_rec ii_transform(iirs L,UNSIGNED1 cnt) := TRANSFORM
  SELF.bdid := L.bdid;
  SELF.sic_code := MAP(
    cnt = 1 => L.sic1,
    cnt = 2 => L.sic2,
    cnt = 3 => L.sic3,
    cnt = 4 => L.sic4,
    cnt = 5 => L.sic5,
    cnt = 6 => L.sic6,
    cnt = 7 => L.sic7,
    cnt = 8 => L.sic8,
    cnt = 9 => L.sic9,
    cnt = 10 => L.sic10,
    '');
  SELF.sic_descriptions := MAP(
    cnt = 1 => L.text1,
    cnt = 2 => L.text2,
    cnt = 3 => L.text3,
    cnt = 4 => L.text4,
    cnt = 5 => L.text5,
    cnt = 6 => L.text6,
    cnt = 7 => L.text7,
    cnt = 8 => L.text8,
    cnt = 9 => L.text9,
    cnt = 10 => L.text10,
    '');
END;

ii_rec e5600ii_transform(e5600iirs L,UNSIGNED1 cnt) := TRANSFORM
  SELF.bdid := L.bdid;
  SELF.sic_code := MAP(
    cnt = 1 => L.sic_1_code,
    cnt = 2 => L.sic_2_code,
    cnt = 3 => L.sic_3_code,
    cnt = 4 => L.sic_4_code,
    '');
  SELF.sic_descriptions := MAP(
    cnt = 1 => L.sic_1_desc,
    cnt = 2 => L.sic_2_desc,
    cnt = 3 => L.sic_3_desc,
    cnt = 4 => L.sic_4_desc,
    '');
END;

ii_rec e0010ii_transform(e0010iirs L,UNSIGNED1 cnt) := TRANSFORM
  SELF.bdid := L.bdid;
  SELF.sic_code := MAP(cnt = 1 => L.sic_code,'');
  SELF.sic_descriptions := MAP(cnt = 1 => L.business_desc,'');
END;

// this transform/rollup will remove any duplicate sic code descriptions that have same sic code but are
// all uppercase in the description.
//
lowercaseAlphabet := STRINGlib.STRINGtolowercase('ABCDEFGHIJKLMNOPQRSTUVWXYZ');

ii_rec xform_transform(ii_rec l, ii_rec r) := TRANSFORM
  stringOfLittleCharsLeft := STD.STR.Filter(l.sic_descriptions,lowercaseAlphabet);
  BOOLEAN useLeft := LENGTH(TRIM(stringOfLittleCharsLeft, LEFT, RIGHT)) > 0;
  SELF.bdid := IF (useLeft, l.bdid, r.bdid);
  SELF.sic_descriptions := IF (useleft, l.sic_descriptions, r.sic_descriptions);
  SELF.sic_code := l.sic_code; // will always be same as right
END;
// important to sort on sic_code before the rollup

SHARED norm_results := ROLLUP(SORT(
                       NORMALIZE(iirs,10,ii_transform(LEFT,COUNTER)) +
                       NORMALIZE(e5600iirs,4,e5600ii_transform(LEFT,COUNTER)) +
                       NORMALIZE(e0010iirs,1,e0010ii_transform(LEFT,COUNTER)), sic_code),
                        LEFT.sic_code = RIGHT.sic_code
                        ,xform_transform(LEFT,RIGHT));
                        
// Do a project to get rid of the bdid, then dedup it.
SHARED norm_results_nobdid := PROJECT(norm_results,TRANSFORM(doxie_cbrs.layouts.industry_info_slim_record,SELF := LEFT));
SHARED dedup_norm_results_nobdid := DEDUP(norm_results_nobdid(sic_code <> ''),sic_code,sic_descriptions,ALL);

// Dedup the temp ds that has bdids
SHARED dedup_norm_results := DEDUP(norm_results(bdid <> 0 AND sic_code <>''),bdid,sic_code,sic_descriptions,ALL);


doxie_cbrs.mac_Selection_Declare()

SHARED UNSIGNED3 saved_max_IndustryInfo_val := Max_IndustryInfo_Val;

EXPORT records := CHOOSEN(dedup_norm_results_nobdid,saved_Max_IndustryInfo_val);
EXPORT records_count := COUNT(dedup_norm_results_nobdid);
EXPORT records_with_bdids := CHOOSEN(dedup_norm_results,saved_Max_IndustryInfo_val);

END;
