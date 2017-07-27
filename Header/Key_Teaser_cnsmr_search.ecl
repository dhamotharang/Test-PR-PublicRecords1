import ut, doxie;

teaser := Header.file_teaser_cnsmr;

layout_teaser_search prep(layout_teaser le) := transform
	self.dph_lname := metaphonelib.DMetaPhone1(le.lname);
	self.pfname := datalib.preferredfirstNew(le.fname,true);
	self.minit := le.mname[1];
	self.yob := le.dob div 10000;
	self := le;
end;

teaser_prepped := project(teaser, prep(left));
// TODO: change name
export Key_Teaser_cnsmr_search := index(teaser_prepped, {dph_lname, lname, isCurrent, st, pfname, fname, zip, yob, minit}, 
																									{teaser_prepped},
																	ut.Data_Location.Person_header + 'thor_data400::key::header.teaser_search_' + doxie.Version_SuperKey);