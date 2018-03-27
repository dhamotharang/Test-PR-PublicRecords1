// Moving any "static" name/address related fields (non-data) into the target data record(s)	
Layout2 	:= Layouts_Foreclosures.FRCL_XRef_Layout2;

EXPORT Layout2 transformScramble_Foreclosures (Layout2 L,Layout2 R) := TRANSFORM
		appendSpaceIf(STRING base, STRING appnd) := IF(appnd='',base,base+' '+appnd);
		replaceIfNotBlank(STRING base, STRING replaceIf) := IF(base='', base, replaceIf);


			SELF.BaseRec := R.BaseRec;
			SELF.MatchRec := L.BaseRec;
			SELF.XRec1 := R.XRec1;
			SELF.XRec2 := R.XRec2;
				SELF.fname := R.fname;
				SELF.mname := R.mname;
				SELF.lname := R.lname;
				SELF.SSN := R.SSN;
				SELF.DOB := R.DOB;
				SELF.Address := R.Address;
				SELF.Apt := R.Apt;
				SELF.City := R.City;
				SELF.st := R.st;
				SELF.zip := R.zip;
				SELF.uniqueid := R.uniqueid;
				SELF.first_name_in := R.first_name_in;
				SELF.middle_initial_in := R.middle_initial_in;
				SELF.last_name_in := R.last_name_in;
				SELF.street_address_in := R.street_address_in;
				SELF.apt_in := R.apt_in;
				SELF.city_in := R.city_in;
				SELF.state_in := R.state_in;
				SELF.zip_in := R.zip_in;
				SELF.zip4_in := R.zip4_in;
				SELF.prim_range_1 := R.prim_range_1;
				SELF.predir_1 := R.predir_1;
				SELF.prim_name_1 := R.prim_name_1;
				SELF.suffix_1 := R.suffix_1;
				SELF.postdir_1 := R.postdir_1;
				SELF.unit_desig_1 := R.unit_desig_1;
				SELF.sec_range_1 := R.sec_range_1;
				SELF.p_city_name_1 := R.p_city_name_1;
				SELF.st_1 := R.st_1;
				SELF.zip_1 := R.zip_1;
				SELF.zip4 := R.zip4;
				SELF.geo_lat := R.geo_lat;
				SELF.geo_long := R.geo_long;
				SELF.geo_blk := R.geo_blk;
				SELF.dms_lat := R.dms_lat;
				SELF.dms_long := R.dms_long;
				SELF.county := R.county;
				SELF.msa := R.msa;
				SELF.geo_match := R.geo_match;
				SELF.geolink := R.geolink;
				SELF  := L;
				SELF  := [];

END;