IMPORT ut;

EXPORT lien_records_prs(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

lr := doxie_cbrs.lien_records(bdids);

rec := RECORD
  STRING1 sourcecode;
  STRING1 indivbusun;
  STRING1 aka_yn;
  STRING1 assoccode;
  STRING7 courtid;
  STRING50 court_desc;
  STRING3 filetypeid;
  STRING50 filingtype_desc;
  STRING17 casenumber;
  STRING6 book;
  STRING6 page;
  STRING8 filing_date;
  STRING8 release_date;
  STRING12 amount;
  STRING9 assets;
  STRING32 plaintiff;
  STRING13 othercase;
  STRING9 orig_ssn;
  STRING100 defname;//string300 defname;
  STRING10 generation;
  /*string120 address;
  string50 orig_city;
  string2 orig_state;
  string5 orig_zip;*/
  STRING8 uploaddate;
  STRING1 unlawdetyn;
  STRING17 origcase;
  STRING6 origbook;
  STRING6 origpage;
  STRING2 actiontype;
  STRING2 stl_type;
  STRING10 rmsid;
  STRING5 def_title;
  STRING20 def_fname;
  STRING20 def_mname;
  STRING20 def_lname;
  STRING5 def_name_suffix;
  STRING3 def_name_score;
  STRING200 def_company;//STRING300 def_company;
  STRING5 plain_title;
  STRING20 plain_fname;
  STRING20 plain_mname;
  STRING20 plain_lname;
  STRING5 plain_name_suffix;
  STRING3 plain_name_score;
  STRING34 plain_company;/*
  STRING10 prim_range;
  STRING2 predir;
  STRING28 prim_name;
  STRING4 suffix;
  STRING2 postdir;
  STRING10 unit_desig;
  STRING8 sec_range;
  STRING25 p_city_name;
  STRING25 v_city_name;
  STRING2 state;
  STRING5 zip;
  STRING4 zip4;
  STRING4 cart;
  STRING1 cr_sort_sz;
  STRING4 lot;
  STRING1 lot_order;
  STRING2 dbpc;
  STRING1 chk_digit;
  STRING2 rec_type;
  STRING5 county; // remember it's 2+3 (st, county)
  STRING10 geo_lat;
  STRING11 geo_long;
  STRING4 msa;
  STRING7 geo_blk;
  STRING1 geo_match;
  STRING4 err_stat;*/
  STRING12 did;
  STRING3 did_score;
  STRING9 ssn_appended;
  STRING12 bdid;
  STRING1 glb_flag; // added on 01/20/2005
  STRING27 LNI;
END;

ut.MAC_Slim_Back(lr, rec, lrslim)

RETURN lrslim;
END;
