import ebr, doxie_cbrs, dx_common, dx_ebr;
export EBR_Summary(
  dataset(doxie_cbrs.layout_references) bdids,
  boolean Include_val = false,
  unsigned3 Max_val = 0
) := MODULE

  //TODO: Convert this direct join to a dx get pattern.

  shared k := ebr.Key_1000_Executive_Summary_BDID;
  nn := Max_val * 2;

  outrec := {unsigned1 level, recordof(k)};
  outrec makeit(k l) := transform
    self.level := 0;
    self := l;
  end;

  pre_outf1 := project(k(bdid > 0 and bdid in SET(bdids,bdid)), makeit(left));
  outf1 := dx_common.Incrementals.mac_Rollup(pre_outf1, dx_EBR.mod_delta_rid.key_1000_delta_rid);
  shared out_f := choosen(sort(outf1,bdid,file_number,-process_date),nn);

  shared simple_count :=
    count(k(keyed(bdid in SET(bdids, bdid))));

    export records := out_f;
    export record_count(boolean count_only = false) :=
                            IF(count_only,simple_count,count(out_f));

END;
