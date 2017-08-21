import Business_Header,Lib_KeyLib, versioncontrol;

export MOXIE_BH_Contacts_Keys(

	string pversion

) :=
function

	shared h := distribute(Business_Header.Layout_Business_Contact_Out_Keybuild, random()) : persist(persistnames().MOXIEBHContactsKeys);

	shared MyFields := record
		h.did; 
	//	h.preGLB_did;
		h.bdid;
		h.ssn;
		h.fname;
		h.mname;
		h.lname;
		h.prim_range;
		h.predir;
		h.prim_name;
		h.addr_suffix;
		h.postdir;
		h.sec_range;
		h.city;
		h.company_city;
		h.state;
		h.company_state;
		string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + TRIM(h.mname,right);
			h.zip;
		h.company_zip;
		h.__filepos;
		h.geo_lat;
		h.geo_long;
		real lat := (real) (h.geo_lat);
		real latradians := (real) (h.geo_lat) / 57.296;
		real long := (real) (h.geo_long);
		integer milesperband := 25;

	end;

	shared t := table(h, MyFields);

	// made changes to these keys to include the company state and city	
	shared st_rec := record
		t.lfmname;
		t.state;
		t.city;
		t.company_state;
		t.company_city;
		string25 city_all := '';
		string2 state_all := '';
		string5 zip_all := '';
		t.__filepos;
	end;

	shared st_rec use_st(MyFields l, unsigned1 cnt) := TRANSFORM
		self.city_all := choose(cnt, l.city[1..13], l.company_city[1..13]);
		self.state_all := choose(cnt, l.state, l.company_state);
		self.zip_all := choose(cnt, l.zip, l.company_zip);
		self := l;
	end;

	shared st_records := NORMALIZE(t,2,use_st(left,counter));
				
				
	shared ZipCitiesRec := record
		st_records.city_all;
		st_records.state_all;
		st_records.lfmname;
		st_records.zip_all;
		VARSTRING citylist;
		st_records.__filepos;
	end;

	// Project to get city list for each zip
	shared ZipCitiesRec GetCityList(st_records L) := TRANSFORM
		SELF.citylist := ZipLib.ZipToCities(L.zip_all);
		SELF:= L;
	END;
	 
	shared ZipCitiesSet := PROJECT(st_records, GetCityList(LEFT));

	shared ZipCityRec := RECORD
		ZipCitiesSet.city_all;
		ZipCitiesSet.state_all;
		ZipCitiesSet.lfmname;
		string25 city_from_zip;
		ZipCitiesSet.__filepos;
	END;
	 
	shared ZipCityRec NormCityList(ZipCitiesRec L, INTEGER C) := TRANSFORM
		SELF.city_from_zip := IF ( C = 1, l.city_all, Stringlib.StringExtract(L.citylist, C ));
		SELF := L;
	END;
	 
	shared ZipCitySet	:= distribute(ZipCitiesSet,hash(__filepos));
	shared ZCS_Norm	:= normalize(ZipCitySet,(INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst(LEFT, COUNTER));			
				
				

	/////////////////////////////////////////////////			
	// FPOS DATA KEY	
	/////////////////////////////////////////////////			
	shared unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
		if (filepos<headersize, rawsize+filepos, filepos);

	shared rawsize := sizeof(Business_Header.Layout_Business_Contact_Out) * count(h) : global;
	shared headersize := sizeof(Business_Header.Layout_Business_Contact_Out) : global;



	////////////////////////////////////////////////////////
	shared latlong_rec := record
		t.geo_lat;
		t.geo_long;
		t.lat;
		t.latradians;
		t.long;
		t.milesperband;
		real milesperdegree := 3959.0 * (acos(sin(t.latradians) * sin(t.latradians) + cos(t.latradians) * cos(t.latradians) * cos(1.0 / 57.296)));
		t.lfmname;
		t.__filepos;
	end;

	shared latlong_records := table(t,latlong_rec);

	shared lfmnamelatlong_rec := record
		latlong_records.geo_lat;
		latlong_records.geo_long;
		latlong_records.lat;
		latlong_records.latradians;
		latlong_records.long;
		latlong_records.milesperband;
		latlong_records.milesperdegree;
		latlong_records.lfmname;
		string6 lat25 := '';
		string6 long25 := '';
		t.__filepos;
	end;

	shared lfmnamelatlong_rec use_lfmname(latlong_rec l) := TRANSFORM
		self.lat25 := intformat((integer) ((l.lat) * 69.098 / l.milesperband + .5), 6, 1);
		self.long25 := intformat((integer) ((l.long + 180) * l.milesperdegree / l.milesperband + 0.5), 6, 1);
		self := l;
	end;

	shared lfmnamelatlong_records := project(latlong_records,use_lfmname(left));

	shared names := Moxie_Keynames(pversion).Business_Contacts;

	shared key1		:= INDEX(t(lfmname <> '')																											,{lfmname,(big_endian unsigned8 )__filepos}																												,names.key1.root	);
	shared key2		:= INDEX(t(zip <> '')																													,{zip,prim_name,prim_range,(big_endian unsigned8 )__filepos}																			,names.key2.root	);
	shared key3		:= INDEX(t(did <> '')																													,{did,(big_endian unsigned8 )__filepos}																														,names.key3.root	);
	shared key4		:= INDEX(t(bdid <> '')																												,{bdid,(big_endian unsigned8 )__filepos}																													,names.key4.root	);
	shared key5		:= INDEX(t(ssn <> '')																													,{ssn,(big_endian unsigned8 )__filepos}																														,names.key5.root	);
	shared key6		:= INDEX(t(zip <> '')																													,{zip,prim_name,addr_suffix,predir,postdir,prim_range,sec_range,(big_endian unsigned8 )__filepos}	,names.key6.root	);
	shared key7		:= INDEX(st_records(state_all <> '')																					,{state_all,lfmname,(big_endian unsigned8 )__filepos}																							,names.key7.root	);
	shared key8		:= INDEX(ZCS_Norm(state_all <> '')																						,{state_all,city_from_zip,lfmname,(big_endian unsigned8 )__filepos}																,names.key8.root	);
	shared key9		:= INDEX(h																																		,{f:= moxietransform(__filepos, rawsize, headersize)},{h}																					,names.key9.root	);
	shared key10	:= INDEX(lfmnamelatlong_records(lat25 <> '' and long25 <> '' and lfmname<>'')	,{lat25,long25,lfmname,(big_endian unsigned8 )__filepos}																					,names.key10.root	);
	
	versioncontrol.macBuildNewLogicalKeyWithName(key1		,names.key1.new	,BuildKey1	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key2		,names.key2.new	,BuildKey2	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key3		,names.key3.new	,BuildKey3	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key4		,names.key4.new	,BuildKey4	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key5		,names.key5.new	,BuildKey5	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key6		,names.key6.new	,BuildKey6	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key7		,names.key7.new	,BuildKey7	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key8		,names.key8.new	,BuildKey8	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key9		,names.key9.new	,BuildKey9	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key10	,names.key10.new,BuildKey10	,,,true);

	build_keys := if(not VersionControl.DoAllFilesExist.fNamesBuilds(names.dAll_filenames)
		,parallel(
			 BuildKey1		
			,BuildKey2		
			,BuildKey3		
			,BuildKey4		
			,BuildKey5		
			,BuildKey6		
			,BuildKey7		
			,BuildKey8		
			,BuildKey9		
			,BuildKey10		
		));

	return build_keys;

end;