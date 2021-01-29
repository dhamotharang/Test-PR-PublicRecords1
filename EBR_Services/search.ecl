import doxie;

export search := FUNCTION

  unsigned2 pt := 10 : stored('PenaltThreshold');
  STRING10 file_number := '' : STORED('FileNumber');
  file_numbers := dataset([{file_number}],ebr_services.layout_file_number);

  doxie.MAC_Header_Field_Declare()

  recs := EBR_Services.autokey_and_header_recs().recs;
  ids  := EBR_Services.autokey_and_header_recs().ids;
  opt1 := EBR_Services.ebr_raw.search_view.by_autokey_and_header_recs(recs);
  opt2 := EBR_Services.ebr_raw.search_view.by_file_number(file_numbers);
  opt_chooser := IF(file_number<>'',opt2,opt1);
  rpen := ebr_services.Fn_ScoreSearchView(opt_chooser);

  rdd := join(rpen, ids,
        left.bdid = right.bdid,
        transform({ids.isDeepDive,rpen}, self.isDeepDive := right.isDeepDive, self := left),
        left outer);

  rsrt := sort(rdd(penalt <= pt),if(isDeepDive,1,0), penalt, -extract_date, -file_estab_date, record);
  doxie.MAC_Marshall_Results(rsrt,rmar);

  RETURN rmar;
END;
