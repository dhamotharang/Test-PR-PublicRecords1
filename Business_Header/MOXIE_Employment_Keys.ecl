import Business_Header,Lib_KeyLib, versioncontrol;

export MOXIE_Employment_Keys(

	string pversion

) :=
function


	shared h := filters.keys.peopleatwork(Business_Header.File_Employment_Keybuild);

	shared MyFields := record
		h.did; 
	//	h.preGLB_did;
		h.bdid;
		h.ssn;
			string9 fein := h.company_fein;
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
		h.state;
			h.zip;
	//company stuff
		h.company_prim_range;
		h.company_predir;
		h.company_prim_name;
		h.company_addr_suffix;
		h.company_postdir;
		h.company_sec_range;
		h.company_city;
		h.company_state;
			h.company_zip;

		string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + TRIM(h.mname,right);
			h.company_phone;
			h.phone;
	//	string60 company1 := KeyLib.CompName(h.company_name); // 120 bytes
		string30 nameasis := KeyLib.CompNameNoSyn(h.company_name);
			string3 inverted_score := intformat(500 - (integer)h.score, 3, 1);
		string80 cn_all := keyLib.GongDacName(h.company_name);

		h.__filepos;
	end;

	shared t := table(h, MyFields);

	shared phone_rec := record
		t.company_phone;
		t.phone;
		string10 phoneno;
		t.__filepos;
	end;

	shared phone_rec norm_phone(MyFields l, unsigned1 cnt) := TRANSFORM
		self.phoneno := choose(cnt, l.company_phone, l.phone);
		self := l;
	end;

	shared phone_records := NORMALIZE(t,2,norm_phone(left,counter));

	shared multi_address_rec := record
	string10  all_prim_range;
	string2   all_predir;
	string28  all_prim_name;
	string4   all_addr_suffix;
	string2   all_postdir;
	string8   all_sec_range;
	string25  all_city;
	string2   all_state;
	string5   all_zip;
		t.prim_range;
		t.predir;
		t.prim_name;
		t.addr_suffix;
		t.postdir;
		t.city;
		t.state;
			t.zip;
		t.company_prim_range;
		t.company_predir;
		t.company_prim_name;
		t.company_addr_suffix;
		t.company_postdir;
		t.company_city;
		t.company_state;
			t.company_zip;
		t.lfmname;
		t.nameasis;
		t.cn_all;
		t.__filepos;
	end;

	shared multi_address_rec norm_address(MyFields l, unsigned1 cnt) := TRANSFORM
		self.all_prim_range := choose(cnt, l.company_prim_range, l.prim_range);
		self.all_prim_name := choose(cnt, l.company_prim_name, l.prim_name);
		self.all_predir := choose(cnt, l.company_predir, l.predir);
		self.all_postdir := choose(cnt, l.company_postdir, l.postdir);
		self.all_addr_suffix := choose(cnt, l.company_addr_suffix, l.addr_suffix);
		self.all_sec_range := choose(cnt, l.company_sec_range, l.sec_range);
		self.all_city := choose(cnt, l.company_city, l.city);
		self.all_zip := choose(cnt, l.company_zip, l.zip);
		self.all_state := choose(cnt, l.company_state, l.state);
		self := l;
	end;

	shared multi_address_records := NORMALIZE(t,1,norm_address(left,counter));
				

	shared ZipCitiesRec := record, maxlength(1000)
		multi_address_records.all_city;
		multi_address_records.all_state;
		multi_address_records.all_zip;
		multi_address_records.lfmname;
		multi_address_records.nameasis;
		VARSTRING citylist;
		multi_address_records.cn_all;
		multi_address_records.__filepos;
	end;

	// Project to get city list for each zip
	shared ZipCitiesRec GetCityList(multi_address_records L) := TRANSFORM
		SELF.citylist := ZipLib.ZipToCities(L.all_zip);
		SELF:= L;
	END;
	 
	shared ZipCitiesSet := PROJECT(multi_address_records, GetCityList(LEFT));

	shared ZipCityRec := RECORD
		ZipCitiesSet.all_city;
		ZipCitiesSet.all_state;
		ZipCitiesSet.all_zip;
		ZipCitiesSet.lfmname;
		ZipCitiesSet.nameasis;
		string13 city_from_zip;
		ZipCitiesSet.cn_all;
		ZipCitiesSet.__filepos;
	END;
	 
	shared ZipCityRec NormCityList(ZipCitiesRec L, INTEGER C) := TRANSFORM
		SELF.city_from_zip := IF ( C = 1, l.all_city, Stringlib.StringExtract(L.citylist, C ));
		SELF := L;
	END;
	 
	shared ZipCitySet := NORMALIZE(ZipCitiesSet, (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst(LEFT, COUNTER));
	shared zcs_dist := distribute(ZipCitySet, hash(city_from_zip,all_state,lfmname,__filepos));
	shared zcs_srtd := sort(zcs_dist, city_from_zip, all_state, lfmname,__filepos, local);
	shared City_d := DEDUP(zcs_srtd, city_from_zip, all_state, lfmname,__filepos, local);
				
	shared cn_rec := record
		City_d.all_state;
		City_d.city_from_zip;
		City_d.all_zip;
		string10 cn := '';
		t.__filepos;
	end;

	shared cn_rec use_cn(City_d l, unsigned1 cnt) := TRANSFORM
		self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
								 l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
		self := l;
	end;

	shared cn_records := NORMALIZE(City_d,8,use_cn(left,counter));
	shared zcs_dist_cn := distribute(cn_records, hash(all_zip,all_state,city_from_zip,cn,__filepos));
	shared zcs_srtd_cn := sort(zcs_dist_cn, all_zip,all_state,city_from_zip,cn,__filepos, local);
	shared cn_dedup := DEDUP(zcs_srtd_cn, all_zip,all_state,city_from_zip,cn,__filepos, local);


	shared unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
		if (filepos<headersize, rawsize+filepos, filepos);

	shared rawsize := sizeof(Business_Header.Layout_Employment_Out) * count(h) : global;
	shared headersize := sizeof(Business_Header.Layout_Employment_Out) : global;


	/////////////////////////////////////////////////			
	// Index Definitions	
	/////////////////////////////////////////////////			
	shared names := Moxie_Keynames(pversion).paw;
	
	shared key1		:= INDEX(t(lfmname != '')																							,{lfmname,(big_endian unsigned8 )__filepos}																																										,names.key1.root	);
	shared key2		:= INDEX(t(did != '')																									,{did,(big_endian unsigned8 )__filepos}																																												,names.key2.root	);
	shared key3		:= INDEX(t(bdid != '')																								,{bdid,(big_endian unsigned8 )__filepos}																																											,names.key3.root	);
	shared key4		:= INDEX(t(did != '')																									,{did,bdid,(big_endian unsigned8 )__filepos}																																									,names.key4.root	);
	shared key5		:= INDEX(t(ssn != '')																									,{ssn,(big_endian unsigned8 )__filepos}																																												,names.key5.root	);
	shared key6		:= INDEX(t(ssn != '')																									,{ssn,inverted_score,(big_endian unsigned8 )__filepos}																																				,names.key6.root	);
	shared key7		:= INDEX(t(fein != '')																								,{fein,(big_endian unsigned8 )__filepos}																																											,names.key7.root	);
	shared key8		:= INDEX(t(nameasis <> '')																						,{nameasis,(big_endian unsigned8 )__filepos}																																									,names.key8.root	);
	shared key9		:= INDEX(phone_records(phoneno <> '')																	,{phoneno,(big_endian unsigned8 )__filepos}																																										,names.key9.root	);
	shared key10	:= INDEX(multi_address_records(all_state <> '')												,{all_state,lfmname,(big_endian unsigned8 )__filepos}																																					,names.key10.root	);
	shared key11	:= INDEX(multi_address_records(all_zip <> '')													,{all_zip,all_prim_name,all_prim_range,(big_endian unsigned8 )__filepos}																											,names.key11.root	);
	shared key12	:= INDEX(multi_address_records(all_zip <> '')													,{all_zip,all_prim_name,all_addr_suffix,all_predir,all_postdir,all_prim_range,all_sec_range,(big_endian unsigned8 )__filepos}	,names.key12.root	);
	shared key13	:= INDEX(multi_address_records(all_state <> '')												,{all_state,nameasis,(big_endian unsigned8 )__filepos}																																				,names.key13.root	);
	shared key14	:= INDEX(multi_address_records(all_zip <> '')													,{all_zip,nameasis,(big_endian unsigned8 )__filepos}																																					,names.key14.root	);
	shared key15	:= INDEX(City_d(all_state <> '')																			,{all_state,city_from_zip,lfmname,(big_endian unsigned8 )__filepos}																														,names.key15.root	);
	shared key16	:= INDEX(City_d(all_state <> '')																			,{all_state,city_from_zip,nameasis,(big_endian unsigned8 )__filepos}																													,names.key16.root	);
	shared key17	:= INDEX(cn_dedup(cn<>'')																							,{cn,(big_endian unsigned8 )__filepos}																																												,names.key17.root	);
	shared key18	:= INDEX(cn_dedup(all_state <> '' and cn<>'')													,{all_state,cn,(big_endian unsigned8 )__filepos}																																							,names.key18.root	);
	shared key19	:= INDEX(cn_dedup(all_state <> '' and city_from_zip <> '' and cn<>'')	,{all_state,city_from_zip,cn,(big_endian unsigned8 )__filepos}																																,names.key19.root	);
	shared key20	:= INDEX(cn_dedup(all_zip <> '' and cn<>'')														,{all_zip,cn,(big_endian unsigned8 )__filepos}																																								,names.key20.root	);
	shared key21	:= INDEX(h																														,{f:= moxietransform(__filepos, rawsize, headersize)},{h}																																			,names.key21.root	);
																											                                                                                                                                              
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
	versioncontrol.macBuildNewLogicalKeyWithName(key11	,names.key11.new,BuildKey11	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key12	,names.key12.new,BuildKey12	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key13	,names.key13.new,BuildKey13	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key14	,names.key14.new,BuildKey14	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key15	,names.key15.new,BuildKey15	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key16	,names.key16.new,BuildKey16	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key17	,names.key17.new,BuildKey17	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key18	,names.key18.new,BuildKey18	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key19	,names.key19.new,BuildKey19	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key20	,names.key20.new,BuildKey20	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key21	,names.key21.new,BuildKey21	,,,true);

	shared keygroup1names := 
				names.key1.dAll_filenames                                                                           
			+ names.key2.dAll_filenames
			+ names.key3.dAll_filenames
			+ names.key4.dAll_filenames
			+ names.key5.dAll_filenames
			+ names.key6.dAll_filenames
			+ names.key7.dAll_filenames
			; 

	shared keygroup2names := 
				names.key8.dAll_filenames
			+ names.key9.dAll_filenames
			+ names.key10.dAll_filenames
			+ names.key11.dAll_filenames
			+ names.key12.dAll_filenames
			+ names.key13.dAll_filenames
			+ names.key14.dAll_filenames
			;
			
	shared keygroup3names := 
				names.key15.dAll_filenames
			+ names.key16.dAll_filenames
			+ names.key17.dAll_filenames
			+ names.key18.dAll_filenames
			+ names.key19.dAll_filenames
			+ names.key20.dAll_filenames
			+ names.key21.dAll_filenames
			; 

	shared keygroup1 :=
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroup1names)
	,parallel(
		 BuildKey1	
		,BuildKey2	
		,BuildKey3	
		,BuildKey4	
		,BuildKey5
		,BuildKey6	
		,BuildKey7	
	));

	shared keygroup2 := 
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroup2names)
	,parallel(
		 BuildKey8	
		,BuildKey9	
		,BuildKey10	
		,BuildKey11	
		,BuildKey12	
		,BuildKey13	
		,BuildKey14	
	));

	shared keygroup3 := 
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroup3names)
	,parallel(
		 BuildKey15	
		,BuildKey16	
		,BuildKey17	
		,BuildKey18	
		,BuildKey19	
		,BuildKey20	
		,BuildKey21	
	));

	return
	sequential(
		 keygroup1
		,keygroup2
		,keygroup3
	);

end;