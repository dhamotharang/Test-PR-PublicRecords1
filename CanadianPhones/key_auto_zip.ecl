import doxie, NID;

layout_auto_zip := record
  STRING6 zip;
  STRING6 dph_lname;
  STRING20 lname;
  STRING20 pfname;
  STRING20 fname;
  STRING1 minit;
  UNSIGNED6 did;
end;

layout_auto_zip proj(file_cwp_with_fdid le) := TRANSFORM
	SELF.zip := le.postalcode;
	SELF.dph_lname := metaphonelib.DMetaPhone1(le.lastname);
	SELF.lname := le.lastname;
	SELF.pfname := NID.PreferredFirstVersionedStr(le.firstname, NID.version);
	SELF.fname := le.firstname;
	SELF.minit := le.middlename[1];
	SELF.did := le.fdid;
END;

p := PROJECT(file_cwp_with_fdid(postalcode<>''), proj(LEFT));

recs := dedup(sort(p, record), record);
  
export key_auto_zip := INDEX(recs, {recs}, '~thor_data400::key::canadianwp_zip_' + doxie.Version_SuperKey);