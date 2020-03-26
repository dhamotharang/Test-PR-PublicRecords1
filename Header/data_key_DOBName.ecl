IMPORT header, ut, dx_Header;

ds_src := header.prepped_for_keys;

layout_slim := RECORD
  unsigned6 did;
  integer4  dob;
	string20  lname;
  string20  fname;
  string2   st;
  string5   zip;
END;

// filter invalid records
ds_filt := distribute(PROJECT (ds_src(dob div 10000 >= 1900,length(trim(lname)) <> 0), layout_slim), hash(did));

ds_sort := SORT(ds_filt, did, lname, fname, -dob, -zip, -st, LOCAL);
ds_grp := GROUP(ds_sort, did, lname, fname,LOCAL);
// collapse any lesser qualified dates into the more fully qualified form
// i.e., if we have 19650523 and 19650500, only keep the former, given the way the fetch works
ds_ready := DEDUP(ds_grp, ut.NNEQ_Date(LEFT.dob, RIGHT.dob) and ut.NNEQ(Left.zip, Right.zip) and ut.NNEQ(Left.st, Right.st));

layout_dob_key := RECORD
	UNSIGNED2 yob;
	STRING6 dph_lname;
  STRING20 lname;
  STRING20 pfname;
  STRING20 fname;
	UNSIGNED1 mob;
	UNSIGNED1 day;
  STRING2 st;
	STRING5 zip;
	INTEGER4 dob;
	UNSIGNED6 did;
END;


layout_dob_key trans(layout_slim l) := TRANSFORM
	SELF.yob := l.dob div 10000;
	SELF.dph_lname := metaphonelib.DMetaPhone1(l.lname);
	SELF.lname := l.lname;
	SELF.pfname := datalib.preferredfirst(l.fname);
	SELF.fname := l.fname;
	SELF.mob := (l.dob div 100) % 100;
	SELF.day := l.dob % 100;
	SELF.st := l.st;
	SELF.zip := l.zip;
	SELF.dob := l.dob;
	SELF.did := l.did;	
END;

recs := PROJECT(ds_ready, trans(LEFT));

EXPORT data_key_DOBName := PROJECT (recs, dx_Header.layouts.i_DOBName);

//EXPORT Key_Header_DOBName := INDEX (recs, {recs}, ut.Data_Location.Person_header+'thor_data400::key::header.dobname_' + doxie.version_superkey, OPT);
