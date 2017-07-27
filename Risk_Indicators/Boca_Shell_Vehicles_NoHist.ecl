import drivers, doxie_files;

export Boca_Shell_Vehicles_NoHist(GROUPED DATASET(Layout_Boca_Shell_ids) ids, boolean isLN, unsigned1 dppa, boolean dppa_ok) :=
FUNCTION

vehrec :=
RECORD
	Layout_Boca_Shell_ids;
	Layout_Vehicles;
	unsigned6 seq_no;
END;

vehrec get_vehicles(ids L, doxie_files.Key_BocaShell_Vehicles R) := transform
	self := L;
	self.vehicle1 := if (drivers.state_dppa_ok(R.vehicle1.orig_state,dppa,R.vehicle1.source_code), R.vehicle1);
	self.vehicle2 := if (drivers.state_dppa_ok(R.vehicle2.orig_state,dppa,R.vehicle2.source_code), r.vehicle2);
	self.vehicle3 := if (drivers.state_dppa_ok(r.vehicle3.orig_state,dppa,r.vehicle3.source_code), r.vehicle3);
	self := R;
end;

outf := join(ids(~isrelat), 
		   doxie_files.Key_BocaShell_Vehicles,
				keyed(left.did = right.did) and
				dppa_ok,
		   get_vehicles(LEFT,RIGHT));

return outf;

end;
