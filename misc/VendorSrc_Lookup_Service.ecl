/*--SOAP--
<message name="VendorSrc_Lookup_Service">
  <part name="source" type="xsd:string"/>
  <part name="file_id" type="xsd:string"/>
  <part name="display_name_wild" type="xsd:string"/>
 </message>
*/
IMPORT STD, dx_vendor_src;

EXPORT VendorSrc_Lookup_Service := MACRO

  INTEGER MAX_RESULTS_DEFAULT := 1;
  INTEGER MAX_RESULTS_WILD := 25;

  STRING _in_source := '' : STORED('Source');
  in_source := STD.STR.ToUpperCase(TRIM(_in_source));
  STRING _in_file_id := '' : STORED('file_id');
  in_file_id := STD.STR.ToUpperCase(TRIM(_in_file_id));

  string _in_display_name_wild := '' : STORED('display_name_wild');
  // will accept both '%' and '*' as wildcard
  string in_display_name_wild := REGEXREPLACE('%', TRIM(STD.STR.ToUpperCase(TRIM(_in_display_name_wild))), '\\*');
  is_wild_search := in_display_name_wild <> '' and in_source='';

  // wrap expression with ^ and $ (if applicable); replace all '*' with (.*)   
  regexp_wild_wrap :=  IF(STD.STR.StartsWith(in_display_name_wild, '*'), '', '^') +
    in_display_name_wild + IF(STD.STR.EndsWith(in_display_name_wild, '*'), '', '$');    
  regexp_wild := REGEXREPLACE('\\*', regexp_wild_wrap, '(.*)');

  key_vendor_src := dx_vendor_src.Key_Vendor_Src();

  recs := CHOOSEN(key_vendor_src(KEYED(source_code=in_source)), 10);
  recs_srch := CHOOSEN(recs(
    in_file_id='' OR input_file_id=in_file_id,
    in_display_name_wild='' OR REGEXFIND(regexp_wild, display_name, NOCASE)
  ), MAX_RESULTS_DEFAULT);
  
  recs_wild := CHOOSEN(key_vendor_src(
    REGEXFIND(regexp_wild, display_name, NOCASE),
    in_file_id='' OR input_file_id=in_file_id
    ), MAX_RESULTS_WILD);

  results := IF(is_wild_search, recs_wild, recs_srch);

  OUTPUT(results, NAMED('Results'));

ENDMACRO;

/*

File Layout:
                                // Bank/Lien Court Match  // Riskview/FFD
  STRING item_source;           // court_code (col A)     // item_source_code (col H)
  STRING75 source_code;         // court_code (col A)     // item_source_code (col H)
  STRING display_name;          // court_name (col B)     // item_name (col C)
  STRING description;           // court_name (col B)     // item_description (col F)
  STRING status;                // court_name (col B)     // status_name (col G)
  STRING data_notes;            // <no match>             // <no match>
  STRING coverage_1;            // <no match>             // <no match>
  STRING coverage_2;            // <no match>             // <no match>
  STRING orbit_item_name;       // <no match>             // item_name (col C)
  STRING orbit_source;          // <no match>             // item_source_id (col I)
  STRING orbit_number;          // <no match>             // item_id (col A)
  STRING website;               // <no match>             // source_website (col R)
  STRING notes;                 // <no match>             // <no match>
  STRING date_added;            // <from build_all date>  // <from build_all date>
  STRING input_file_id;         // BANKRUPTCY - or- LIEN  // RISKVIEW_FFD (based on input file name) (literal)
  STRING market_restrict_flag;  // <no match>             // market_restrict_flag (col S)
  STRING10 clean_phone;         // phone (col H)          // source_phone (col Q)
  STRING10 clean_fax;           // <no match>             //
  STRING65 Prepped_addr1;       // address cleaner fields // (based on source address fields)
  STRING35 Prepped_addr2;
  STRING28 v_prim_name;
  STRING5 v_zip;
  STRING4 v_zip4;
  STRING prim_range;
  STRING predir;
  STRING prim_name;
  STRING addr_suffix;
  STRING postdir;
  STRING unit_desig;
  STRING sec_range;
  STRING p_city_name;
  STRING v_city_name;
  STRING st;
  STRING zip;
  STRING zip4;
  STRING cart;
  STRING cr_sort_sz;
  STRING lot;
  STRING lot_order;
  STRING dbpc;
  STRING chk_digit;
  STRING rec_type;
  STRING county;
  STRING geo_lat;
  STRING geo_long;
  STRING msa;
  STRING geo_blk;
  STRING geo_match;
  STRING err_stat;
  STRING nschenrollverify;      // (new) college indicator
  STRING nschdegreeverify;      // (new) college indicator
  STRING phoneverify;           // (new) college indicator
  STRING contacname;            // (new) college indicator
  STRING contactphone;          // (new) college indicator
*/

