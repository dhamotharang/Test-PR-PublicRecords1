import ut;

export lien_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

lr := doxie_cbrs.lien_records(bdids);

rec := record
 string1 	  sourcecode;
   string1    indivbusun;
   string1    aka_yn;
   string1    assoccode;
   string7    courtid;
   string50   court_desc;
   string3    filetypeid;
   string50   filingtype_desc;
   string17   casenumber;
   string6    book;
   string6    page;
   string8    filing_date;
   string8    release_date;
   string12   amount;
   string9    assets;
   string32   plaintiff;
   string13   othercase;
   string9    orig_ssn;
   string100   defname;//string300   defname;
   string10    generation;
   /*string120   address;
   string50   orig_city;
   string2    orig_state;
   string5    orig_zip;*/
   string8    uploaddate;
   string1    unlawdetyn;
   string17   origcase;
   string6    origbook;
   string6    origpage;
   string2    actiontype;
   string2    stl_type;
   string10   rmsid;
   string5	  def_title;
   string20	  def_fname;
   string20	  def_mname;
   string20	  def_lname;
   string5	  def_name_suffix;
   string3	  def_name_score;
   string200  def_company;//string300  def_company;
   string5	  plain_title;
   string20	  plain_fname;
   string20	  plain_mname;
   string20	  plain_lname;
   string5	  plain_name_suffix;
   string3	  plain_name_score;
   string34  plain_company;/*
   string10   prim_range;
   string2    predir;
   string28   prim_name;
   string4 	  suffix;
   string2 	  postdir;
   string10   unit_desig;
   string8 	  sec_range;
   string25   p_city_name;
   string25   v_city_name;
   string2 	  state;
   string5 	  zip;
   string4 	  zip4;
   string4 	  cart;
   string1 	  cr_sort_sz;
   string4 	  lot;
   string1 	  lot_order;
   string2 	  dbpc;
   string1 	  chk_digit;
   string2 	  rec_type;
   string5 	  county;		// remember it's 2+3 (st, county)
   string10   geo_lat;
   string11   geo_long;
   string4 	  msa;
   string7 	  geo_blk;
   string1 	  geo_match;
   string4 	  err_stat;*/
   string12   did;
   string3    did_score;
   string9    ssn_appended;
   string12	  bdid;
   string1	  glb_flag; // added on 01/20/2005
   string27   LNI;
end;

ut.MAC_Slim_Back(lr, rec, lrslim)

return lrslim;
END;