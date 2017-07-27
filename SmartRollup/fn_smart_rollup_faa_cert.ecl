IMPORT iesp;
//one certification for each STATE/COUNTY
export fn_smart_rollup_faa_cert (DATASET(iesp.bpsreport.t_BpsFAACertification) inRecs) := function
  sRecs := sort(inRecs, address.state, address.county,-DateCertifiedMedical.year, -DateCertifiedMedical.month);
	sRecs loadit(sRecs L, sRecs R) := transform
	   self := L;
	end;
	rRecs := rollup(sRecs, LEFT.address.state = RIGHT.address.State and LEFT.address.county=RIGHT.address.county, loadit(LEFT,RIGHT));
  outRecs := sort(rRecs,-DateCertifiedMedical.year, -DateCertifiedMedical.month);
	RETURN outRecs;
end;