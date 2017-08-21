import doxie, NID;

layout_auto_citystname := RECORD
  unsigned4 city_code;
  STRING2 st;
  STRING6 dph_lname;
  STRING20 lname;
  STRING20 pfname;
  STRING20 fname;
  STRING1 minit;
  UNSIGNED6 did;
END;

layout_auto_citystname proj(file_cwp_with_fdid le) := TRANSFORM
	SELF.city_code := HASH((qstring30)le.POSTALCITY);
	SELF.st := le.PROVINCE;
	SELF.dph_lname := metaphonelib.DMetaPhone1(le.lastname);
	SELF.lname := le.lastname;
	SELF.pfname := NID.PreferredFirstVersionedStr(le.firstname, NID.version);
	SELF.fname := le.firstname;
	self.minit := le.middlename[1];
	SELF.did := le.fdid;
END;

p := PROJECT(file_cwp_with_fdid(POSTALCITY<>''), proj(LEFT));

recs := dedup(sort(p, record), record);
  
export key_auto_citystname := INDEX(recs, {recs}, '~thor_data400::key::canadianwp_citystname_' + doxie.Version_SuperKey);