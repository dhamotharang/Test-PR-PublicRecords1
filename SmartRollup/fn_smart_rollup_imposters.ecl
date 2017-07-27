 import iesp,smartRollup;
export fn_smart_rollup_imposters(dataset(iesp.bps_share.t_BpsReportImposter) imposters2dedup) := function
  imposters2dedup dedupIt(imposters2dedup l) := transform
     self.akas := SmartRollup.fn_smart_rollup_names(l.akas);
	end;
 outrecs := project(imposters2dedup, dedupIt(left));			
 return outrecs;
end;