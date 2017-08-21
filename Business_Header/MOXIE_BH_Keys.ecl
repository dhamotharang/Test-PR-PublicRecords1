import Business_Header,Lib_KeyLib, versioncontrol;

export MOXIE_BH_Keys(

	string pversion

) :=
function

	shared h := Business_Header.Layout_Business_Header_Out_Keybuild;

	shared MyFields := record, maxlength(4096)
			h.bdid;            // Seisint Business Identifier
			string30 name_company := h.company_name[1..30];
			h.company_name;
			h.prim_range;
			h.predir;
			h.prim_name;
			h.addr_suffix;
			h.postdir;
			h.sec_range;
			h.city;
			h.state;
			h.zip;
			h.zip4;
			h.phone;
		h.fein;
		h.geo_lat;
		h.geo_long;
		real lat := (real) (h.geo_lat);
		real latradians := (real) (h.geo_lat) / 57.296;
		real long := (real) (h.geo_long);
		integer milesperband := 25;
		string12 street := h.prim_name[1..13];
		string13 pcity := h.city[1..13];
		string16 dph_cname := keyLib.GongCompName(h.company_name);
		string5 dph_city := metaphonelib.DMetaPhone1(h.city);
		string5 dph_street := metaphonelib.DMetaPhone1(h.prim_name);
		string6 exchange := h.phone[1..6];
		string3 zip3 := h.zip[1..3];
			string30 nameasis := KeyLib.CompNameNoSyn(h.company_name);
		string80 cn_all := keyLib.GongDacName(h.company_name);
		string40 pcn_all := keyLib.GongDaphcName(h.company_name);
		VARSTRING citylist := ZipLib.ZipToCities(h.zip);
		h.__filepos;
	end;
		
	shared t := table(h, MyFields);

	shared simple_rec := record
		t.phone;
		t.fein;
		t.bdid;
		t.__filepos;
	end;

	// No point to build keys if the field is empty
	shared fein_records := table(t(t.fein <> ''),simple_rec);
	shared phoneno_records := table(t(t.phone <> ''),simple_rec);
	shared bdid_records := table(t(t.bdid <> ''),simple_rec);


	shared address_rec := record
		t.zip;
		t.prim_name;
		t.prim_range;
		t.addr_suffix;
		t.predir;
		t.postdir;
		string60 company_clean := keyLib.CompName(t.company_name);
		t.sec_range;
		t.__filepos;
	end;

	shared address_records := table(t,address_rec);

	shared latlong_rec := record
		t.state;
		t.city;
		t.zip;
		t.geo_lat;
		t.geo_long;
		t.lat;
		t.latradians;
		t.long;
		t.milesperband;
		real milesperdegree := 3959.0 * (acos(sin(t.latradians) * sin(t.latradians) + cos(t.latradians) * cos(t.latradians) * cos(1.0 / 57.296)));
		t.cn_all;
		t.__filepos;
	end;

	shared latlong_records := table(t,latlong_rec);

	shared cn_rec := record
		latlong_records.state;
		latlong_records.city;
		latlong_records.zip;
		latlong_records.geo_lat;
		latlong_records.geo_long;
		latlong_records.lat;
		latlong_records.latradians;
		latlong_records.long;
		latlong_records.milesperband;
		latlong_records.milesperdegree;
		string10 cn := '';
		string6 lat25 := '';
		string6 long25 := '';
		t.__filepos;
	end;

	shared cn_rec use_cn(latlong_rec l, unsigned1 cnt) := TRANSFORM
		self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
								 l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
		self.lat25 := intformat((integer) ((l.lat) * 69.098 / l.milesperband + .5), 6, 1);
		self.long25 := intformat((integer) ((l.long + 180) * l.milesperdegree / l.milesperband + 0.5), 6, 1);
		self := l;
	end;

	shared cn_records := NORMALIZE(latlong_records,8,use_cn(left,counter));

	shared nameasis_rec := record
		t.nameasis;
		t.state;
		t.zip;
		t.city;
		t.__filepos;
	end;

	shared nameasis_records := table(t,nameasis_rec);


	shared pcn_rec := record
		t.nameasis;
		t.state;
		t.zip;
		t.city;
		string5 pcn :='';
		t.__filepos;
	end;

	shared pcn_rec use_pcn(MyFields l, unsigned1 cnt) := TRANSFORM
		self.pcn := choose(cnt,l.pcn_all[1..5], l.pcn_all[6..10],l.pcn_all[11..15],l.pcn_all[16..20],
								 l.pcn_all[21..25],l.pcn_all[26..30],l.pcn_all[31..35],l.pcn_all[36..40]);
		self := l;
	end;

	shared pcn_records := NORMALIZE(t,8,use_pcn(left,counter));


	shared ph_rec := record
		t.name_company;
		t.prim_range;
		t.predir;
		t.postdir;
		t.street;
		t.sec_range;
		t.pcity;
		t.state;
		t.zip;
		t.zip3;
		t.phone;
		t.exchange;
		string4 dph_cname :='';
		t.dph_city;
		t.dph_street;
		t.__filepos;
	end;

	shared ph_rec use_ph(MyFields l, unsigned1 cnt) := TRANSFORM
		self.dph_cname  := choose(cnt, l.dph_cname[1..4], l.dph_cname[5..8], l.dph_cname[9..12],l.dph_cname[13..16]);
		self := l;
	end;

	shared ph_records := NORMALIZE(t,4,use_ph(left,counter));
	shared ph_duped := DEDUP(ph_records(ph_records.dph_cname <> ''), dph_cname,__filepos,all);


	shared ph2_rec := record
		t.name_company;
		t.prim_range;
		t.predir;
		t.postdir;
		t.street;
		t.sec_range;
		t.pcity;
		t.state;
		t.zip;
		t.zip3;
		t.phone;
		t.exchange;
		t.dph_city;
		t.dph_street;
		t.__filepos;
	end;

	shared ph := table(t, ph2_rec);



	shared ZipCityRec := RECORD
			t.city;
			t.state;
		string2 st;
			t.nameasis;
		t.cn_all;
		t.pcn_all;
		string25 city_from_zip;
		t.__filepos;
	END;
	 
	shared ZipCityRec NormCityList(t L, INTEGER C) := TRANSFORM
		SELF.city_from_zip := IF ( C = 1, l.city, Stringlib.StringExtract(L.citylist, C ));
		self.st := l.state;
		SELF := L;
	END;
	 
	shared ZipCitySet	:= distribute(t,hash(__filepos));
	shared ZCS_Norm	:= normalize(ZipCitySet,(INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst(LEFT, COUNTER));


				
	// --------------------
	// CN city key
	// --------------------
	shared cn2_rec := record
		ZCS_Norm.st;
		ZCS_Norm.city_from_zip;
		string10 cn := '';
		ZCS_Norm.__filepos;
	end;

	shared cn2_rec use_cn2(ZCS_Norm l, unsigned1 cnt) := TRANSFORM
		self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
								 l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
		self := l;
	end;

	shared cn2_records := NORMALIZE(ZCS_Norm,8,use_cn2(left,counter));


				
	// ------------------			
	// PCN city key
	// ------------------
	shared pcn2_rec := record
		ZCS_Norm.nameasis;
		ZCS_Norm.st;
		ZCS_Norm.city_from_zip;
		string5 pcn :='';
		ZCS_Norm.__filepos;
	end;

	shared pcn2_rec use_pcn2(ZCS_Norm l, unsigned1 cnt) := TRANSFORM
		self.pcn := choose(cnt,l.pcn_all[1..5], l.pcn_all[6..10],l.pcn_all[11..15],l.pcn_all[16..20],
								 l.pcn_all[21..25],l.pcn_all[26..30],l.pcn_all[31..35],l.pcn_all[36..40]);
		self := l;
	end;

	shared pcn2_records := NORMALIZE(ZCS_Norm,8,use_pcn2(left,counter));


	/////////////////////////////////////////////////			
	// FPOS DATA KEY	
	/////////////////////////////////////////////////			
	shared unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
		if (filepos<headersize, rawsize+filepos, filepos);

	shared rawsize := sizeof(Business_Header.Layout_Business_Header_Out) * count(h) : global;
	shared headersize := sizeof(Business_Header.Layout_Business_Header_Out) : global;

	/////////////////////////////////////////////////			
	// Index Definitions	
	/////////////////////////////////////////////////			
	shared names := Moxie_Keynames(pversion).Business_headers;

	shared key1		:= index( phoneno_records																						,{phone,(big_endian unsigned8 )__filepos}																																																				,names.key1.root	);
	shared key2		:= index( fein_records																							,{fein,(big_endian unsigned8 )__filepos}																																																				,names.key2.root	);
	shared key3		:= index( bdid_records																							,{bdid,(big_endian unsigned8 )__filepos}																																																				,names.key3.root	);
	shared key4		:= index( address_records(zip != '')																,{zip,prim_name,prim_range,(big_endian unsigned8 )__filepos}																																										,names.key4.root	);
	shared key5		:= index( address_records(zip != '')																,{zip,prim_name,addr_suffix,predir,postdir,prim_range,company_clean,sec_range,(big_endian unsigned8 )__filepos}																	,names.key5.root	);
	shared key6		:= index( cn_records(cn<>'')																				,{cn,(big_endian unsigned8 )__filepos}																																																					,names.key6.root	);
	shared key7		:= index( cn_records(state <> '' and cn<>'')												,{state,cn,(big_endian unsigned8 )__filepos}																																																		,names.key7.root	);
	shared key8		:= index( cn2_records(st<>'' and city_from_zip <> '' and cn <> '')	,{st,city_from_zip,cn,(big_endian unsigned8 )__filepos}																																													,names.key8.root	);
	shared key9		:= index( cn_records(zip <> '' and cn<>'')													,{zip,cn,(big_endian unsigned8 )__filepos}																																																			,names.key9.root	);
	shared key10	:= index( nameasis_records(nameasis <> '')													,{nameasis,(big_endian unsigned8 )__filepos}																																																		,names.key10.root	);
	shared key11	:= index( nameasis_records(state <> '' and nameasis <> '')					,{state,nameasis,(big_endian unsigned8 )__filepos}																																															,names.key11.root	);
	shared key12	:= index( ZCS_Norm(st <> '' and city_from_zip <> '')								,{st,city_from_zip,nameasis,(big_endian unsigned8 )__filepos}																																										,names.key12.root	);
	shared key13	:= index( nameasis_records(zip <> '' and nameasis <> '')						,{zip,nameasis,(big_endian unsigned8 )__filepos}																																																,names.key13.root	);
	shared key14	:= index( pcn_records(pcn<>'')																			,{pcn,nameasis,(big_endian unsigned8 )__filepos}																																																,names.key14.root	);
	shared key15	:= index( pcn_records(state <> '' and pcn<>'')											,{state,pcn,nameasis,(big_endian unsigned8 )__filepos}																																													,names.key15.root	);
	shared key16	:= index( pcn2_records(st <> '' and city_from_zip <> '' and pcn<>''),{st,city_from_zip,pcn,nameasis,(big_endian unsigned8 )__filepos}																																								,names.key16.root	);
	shared key17	:= index( pcn_records(zip <> '' and pcn<>'')												,{zip,pcn,nameasis,(big_endian unsigned8 )__filepos}																																														,names.key17.root	);
	shared key18	:= index( ph_duped																									,{dph_cname,prim_range,dph_street,name_company,pr := prim_range,predir,street,sec_range,pcity,state,zip,phone,(big_endian unsigned8 )__filepos}	,names.key18.root	);
	shared key19	:= index( ph_duped																									,{dph_cname,zip,name_company,prim_range,predir,street,sec_range,pcity,state,z := zip,phone,(big_endian unsigned8 )__filepos}										,names.key19.root	);
	shared key20	:= index( ph_duped																									,{dph_cname,zip3,name_company,prim_range,predir,street,sec_range,pcity,state,zip,phone,(big_endian unsigned8 )__filepos}												,names.key20.root	);
	shared key21	:= index( ph_duped(state <> '')																			,{state,dph_cname,name_company,prim_range,predir,street,sec_range,pcity,st := state,zip,phone,(big_endian unsigned8 )__filepos}									,names.key21.root	);
	shared key22	:= index( ph(exchange <> '' and name_company <> '')									,{exchange,name_company,prim_range,predir,street,sec_range,pcity,state,zip,phone,(big_endian unsigned8 )__filepos}															,names.key22.root	);
	shared key23	:= index( ph(prim_range <> '' and state <> '')											,{prim_range,state,dph_city,name_company,pr :=prim_range,predir,street,	sec_range,pcity,st := state,zip,phone,(big_endian unsigned8 )__filepos}	,names.key23.root	);
	shared key24	:= index( ph(prim_range <> '' and zip <> '')												,{prim_range,zip,name_company,pr := prim_range,predir,street,	sec_range,pcity,state,z := zip,phone,(big_endian unsigned8 )__filepos}						,names.key24.root	);
	shared key25	:= index( cn_records(lat25 <> '' and long25 <> '' and cn<>'')				,{lat25,long25,cn,(big_endian unsigned8 )__filepos}																																															,names.key25.root	);
	shared key26	:= INDEX(h																													,{f:= moxietransform(__filepos, rawsize, headersize)},{h}																																												,names.key26.root	);
              	                                                                                                                                                                                               
	           
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
	versioncontrol.macBuildNewLogicalKeyWithName(key22	,names.key22.new,BuildKey22	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key23	,names.key23.new,BuildKey23	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key24	,names.key24.new,BuildKey24	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key25	,names.key25.new,BuildKey25	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key26	,names.key26.new,BuildKey26	,,,true);

	shared keygroup1names := 
				names.key1.dAll_filenames                                                                           
			+ names.key2.dAll_filenames
			+ names.key3.dAll_filenames
			+ names.key4.dAll_filenames
			+ names.key5.dAll_filenames
			; 

	shared keygroup2names := 
				names.key6.dAll_filenames
			+ names.key7.dAll_filenames
			+ names.key8.dAll_filenames
			+ names.key9.dAll_filenames
			+ names.key10.dAll_filenames
			+ names.key11.dAll_filenames
			+ names.key12.dAll_filenames
			;
			
	shared keygroup3names := 
				names.key13.dAll_filenames
			+ names.key14.dAll_filenames
			+ names.key15.dAll_filenames
			+ names.key16.dAll_filenames
			+ names.key17.dAll_filenames
			+ names.key18.dAll_filenames
			+ names.key19.dAll_filenames
			; 
			
	shared keygroup4names := 
				names.key20.dAll_filenames
			+ names.key21.dAll_filenames
			+ names.key22.dAll_filenames
			+ names.key23.dAll_filenames
			+ names.key24.dAll_filenames
			+ names.key25.dAll_filenames
			+ names.key26.dAll_filenames
			; 

	shared keygroup1 :=
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroup1names)
	,parallel(
		 BuildKey1	
		,BuildKey2	
		,BuildKey3	
		,BuildKey4	
		,BuildKey5
	));

	shared keygroup2 := 
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroup2names)
	,parallel(
		 BuildKey6	
		,BuildKey7	
		,BuildKey8	
		,BuildKey9	
		,BuildKey10	
		,BuildKey11	
		,BuildKey12	
	));

	shared keygroup3 := 
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroup3names)
	,parallel(
		 BuildKey13	
		,BuildKey14	
		,BuildKey15	
		,BuildKey16	
		,BuildKey17	
		,BuildKey18	
		,BuildKey19	
	));

	shared keygroup4 := 
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroup4names)
	,parallel(
		 BuildKey20	
		,BuildKey21	
		,BuildKey22	
		,BuildKey23	
		,BuildKey24	
		,BuildKey25	
		,BuildKey26	
	));

	return
	sequential(
		 keygroup1
		,keygroup2
		,keygroup3
		,keygroup4
	);
 
end;