import ut, doxie, NID;

teaser := Header.file_teaser;

layout_teaser_search prep(layout_teaser le) := transform
	self.dt_vendor_first_reported := 0;
	self.dt_vendor_last_reported := 0;
	self.dph_lname := metaphonelib.DMetaPhone1(le.lname);
	self.pfname := NID.PreferredFirstVersionedStr(le.fname,NID.version);
	self.minit := le.mname[1];
	self.yob := le.dob div 10000;
	self := le;
end;

teaser_prepped := project(teaser, prep(left));

export Key_Teaser_search := index(teaser_prepped, {dph_lname, lname, isCurrent, st, pfname, fname, zip, yob, minit}, 
																									{teaser_prepped},
																	ut.Data_Location.Person_header + 'thor_data400::key::watchdog_nonglb.teaser_search_' + doxie.Version_SuperKey);