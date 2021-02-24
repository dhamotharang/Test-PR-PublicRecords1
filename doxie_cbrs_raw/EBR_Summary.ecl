import ebr, doxie_cbrs, dx_ebr;
export EBR_Summary(
  dataset(doxie_cbrs.layout_references) bdids,
  boolean Include_val = false,
  unsigned3 Max_val = 0
) := MODULE

  shared nn := Max_val * 2;
  shared key_recs := dx_ebr.Get.Executive_Summary_1000_By_Bdid(bdids);

  outrec := {unsigned1 level, RECORDOF(key_recs)};
  outrec makeit(RECORDOF(key_recs) l) := transform
    self.level := 0;
    self := l;
  end;

  outf1 := project(key_recs, makeit(left));
  shared out_f := choosen(sort(outf1, bdid, file_number, -process_date), nn);

  shared simple_count := count(key_recs);
  export records := out_f;
  export record_count(boolean count_only = false) := IF(count_only, simple_count, count(out_f));

END;
