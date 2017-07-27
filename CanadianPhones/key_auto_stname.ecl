import doxie;

layout_auto_stname := RECORD
  STRING2 st;
  STRING6 dph_lname;
  STRING20 lname;
  STRING20 pfname;
  STRING20 fname;
  STRING1 minit;
  STRING6 zip;
  UNSIGNED6 did;
END;

layout_auto_stname proj(file_cwp_with_fdid le) := TRANSFORM
	SELF.st := le.province;
	SELF.dph_lname := metaphonelib.DMetaPhone1(le.lastname);
	SELF.lname := le.lastname;
	SELF.pfname := datalib.preferredfirst(le.firstname);
	SELF.fname := le.firstname;
	SELF.minit := le.middlename[1];
	SELF.zip := le.postalcode;
	SELF.did := le.fdid;
END;

p := PROJECT(file_cwp_with_fdid(province<>'',lastname<>''), proj(LEFT));

recs := dedup(sort(p, record), record);
  
export key_auto_stname := INDEX(recs, {recs}, '~thor_data400::key::canadianwp_stname_' + doxie.Version_SuperKey);