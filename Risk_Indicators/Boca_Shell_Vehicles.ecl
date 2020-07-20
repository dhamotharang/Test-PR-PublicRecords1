import drivers, VehicleV2, riskwise, risk_indicators;

export Boca_Shell_Vehicles (GROUPED DATASET(risk_indicators.Layout_Boca_Shell_ids) ids, unsigned1 dppa, boolean dppa_ok, boolean includeRel,
														unsigned1 BSversion) := FUNCTION

kv := VehicleV2.Key_BocaShell_Vehicles;

vehrec := risk_indicators.Layout_Vehicles.VehRec;

vehrec get_vehicles(ids L, kv R) := transform
	self := L;
	self.vehicle1 := if (drivers.state_dppa_ok(R.vehicle1.orig_state,dppa,R.vehicle1.source_code), R.vehicle1);
	self.vehicle2 := if (drivers.state_dppa_ok(R.vehicle2.orig_state,dppa,R.vehicle2.source_code), r.vehicle2);
	self.vehicle3 := if (drivers.state_dppa_ok(r.vehicle3.orig_state,dppa,R.vehicle3.source_code), r.vehicle3);
	self.relative_owned_count := if(l.isrelat and r.current_count>0, 1, 0);
	self.historical_count := if(~l.isrelat, r.historical_count, 0);
	self.current_count := if(~l.isrelat, r.current_count, 0);
	self := R;
	self := [];
end;

f := if(includeRel and BSversion>1, ids, ids(~isrelat));	// only do the relatives if includeRelatives and bocashell version>1

outf := join (ungroup(f), KV,
              keyed(left.did = right.did) and	dppa_ok,
              get_vehicles(LEFT,RIGHT), 
		    ATMOST(left.did=right.did, Riskwise.max_atmost),keep(100));
				

				
vehrec roll_relative_count(vehrec L, vehrec R) := transform
	self.relative_owned_count := l.relative_owned_count + r.relative_owned_count;
	self := l;
END;
final := ungroup( rollup(group(sort(outf,seq,isrelat, did),seq), left.seq=right.seq, roll_relative_count(LEFT,RIGHT)) );

out := if(includeRel, final, outf);	// only do the rollup if we are using the relatives

return out;

end;
