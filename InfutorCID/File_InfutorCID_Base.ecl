ds := dataset('~thor_data400::base::infutorcid', infutorCID.Layout_InfutorCID_Base, thor);

FixDates := project(ds, transform(recordof(ds),
									self.dt_first_seen := min(left.dt_first_seen, left.dt_last_seen);
									self.dt_last_seen := max(left.dt_first_seen, left.dt_last_seen);
									self := left));

export File_InfutorCID_Base := FixDates;