import ut, doxie;

teaser := Header.file_teaser;

recordof(teaser) prep(recordof(teaser) le) := transform
	self.dt_vendor_first_reported := 0;
	self.dt_vendor_last_reported := 0;
	self := le;
end;

teaser_prepped := project(teaser, prep(left));

export Key_Teaser_did := index(teaser_prepped, {did},{teaser_prepped},
															 ut.Data_Location.Person_header + 'thor_data400::key::watchdog_nonglb.teaser_did_' + doxie.Version_SuperKey);