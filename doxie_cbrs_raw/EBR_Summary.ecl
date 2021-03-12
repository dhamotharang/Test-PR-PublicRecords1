import ebr, doxie_cbrs, dx_common, dx_ebr;
export EBR_Summary(
  dataset(doxie_cbrs.layout_references) bdids,
  boolean Include_val = false,
  unsigned3 Max_val = 0
) := MODULE

  shared k := ebr.Key_1000_Executive_Summary_BDID;
  nn := Max_val * 2;
  bdids_set := SET(bdids(bdid > 0), bdid);

  outrec := {unsigned1 level, recordof(k)};
  outrec makeit(k l) := transform
    self.level := 0;
    self := l;
  end;

  recs := dx_EBR.Read.Executive_Summary_1000_By_Bdid(bdids_set, nn);
  outf1 := project(recs, TRANSFORM(outrec, self.level := 0, self := left));

  shared out_f := sort(outf1,bdid,file_number,-process_date);

  shared simple_count :=
    // Leaving this as is since it's only interested in counts.
    // Passing this data to the incremental macro without a choosen limit could lead to issues otherwise.
    count(k(keyed(bdid in SET(bdids, bdid))));

    export records := out_f;
    export record_count(boolean count_only = false) :=
                            IF(count_only,simple_count,count(out_f));

END;
