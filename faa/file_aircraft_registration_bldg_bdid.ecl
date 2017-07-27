export file_aircraft_registration_bldg_bdid :=
	project(file_aircraft_registration_bldg,
		transform(layout_aircraft_registration_out_slim,
			self.bdid_out := left.bdid_out,
			self := left));