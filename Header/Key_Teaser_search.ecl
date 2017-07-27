import ut, doxie;

teaser := Header.file_teaser;

layout_teaser_search prep(layout_teaser le) := transform
	self.dph_lname := metaphonelib.DMetaPhone1(le.lname);
	self.pfname := datalib.preferredfirstNew(le.fname,true);
	self.minit := le.mname[1];
	self.yob := le.dob div 10000;
	self := le;
end;

teaser_prepped := project(teaser, prep(left));

export Key_Teaser_search := index(teaser_prepped, {dph_lname, lname, isCurrent, st, pfname, fname, zip, yob, minit}, 
																									{teaser_prepped},
																	'~thor_data400::key::watchdog_nonglb.teaser_search_' + doxie.Version_SuperKey);