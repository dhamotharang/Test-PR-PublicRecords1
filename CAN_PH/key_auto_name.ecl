import doxie;

export layout_auto_name := record
  STRING6  dph_lname;
  STRING20 lname;
  STRING20 pfname;
  STRING20 fname;
  STRING1 minit;
  unsigned6 did;
end;

layout_auto_name proj(file_cwp_with_fdid le) := TRANSFORM
	SELF.dph_lname := metaphonelib.DMetaPhone1(le.lastname);
	SELF.lname := le.lastname;
	SELF.pfname := datalib.preferredfirst(le.firstname);
	SELF.fname := le.firstname;
	SELF.minit := le.middlename[1];
	SELF.did := le.fdid;
END;

p := PROJECT(file_cwp_with_fdid(lastname<>''), proj(LEFT));

recs := dedup(sort(p, record), record);
  
export key_auto_name := INDEX(recs, {recs}, '~thor_data400::key::canadianwp_name_' + doxie.Version_SuperKey);