export file_aircraft_registration_bldg_bid :=
	project(file_aircraft_registration_bldg,
		transform(layout_aircraft_registration_out_slim,
			self.bdid_out := left.bid_out,
			self := left));