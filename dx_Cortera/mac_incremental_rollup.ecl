/*
  **
  ** Custom macro to apply incremental (deltas) rollup logic. Required as we need to account for updates to
  ** vendor last reported dates.
  **
  ** @param inf                    Input dataset; REQUIRED. 
  ** @param outf                   Output dataset; REQUIRED. 
  ** @param current_field          Current indicator field; OPTIONAL. 
  ** @param dt_vendor_report_field Vendor last report date field; OPTIONAL. 
  ** @param use_dist               Distribute datasets (Thor only); OPTIONAL, defaults to FALSE. 
  ** @returns                      Result dataset corresponds to all 'active' records, taking into account all updates and 
  **                               deletes found in incremental keys.
  */
EXPORT mac_incremental_rollup(inf, outf, current_field = 'current', dt_vendor_report_field = 'dt_vendor_last_reported', use_dist = FALSE) := MACRO
  IMPORT dx_common, dx_Cortera;

  #uniquename(layout_out_rec)
  #uniquename(recs_roll)

  %layout_out_rec% := RECORDOF(inf);
  %recs_roll% := dx_common.Incrementals.mac_Rollup(inf, use_distributed := use_dist);

  #uniquename(dt_build_ver)
  %dt_build_ver% := dx_Cortera.last_build_date;

  outf := PROJECT(%recs_roll%, TRANSFORM(%layout_out_rec%,
    SELF.dt_vendor_last_reported := IF(LEFT.current_field AND LEFT.delta_ind = 0, 
      %dt_build_ver%, LEFT.dt_vendor_report_field);
    SELF := LEFT;
  ));

ENDMACRO;
