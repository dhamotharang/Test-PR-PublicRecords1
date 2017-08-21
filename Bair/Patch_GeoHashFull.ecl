import VersionControl,std;

EXPORT Patch_GeoHashFull(string	version, boolean pUseProd = false) := module

		CurFull	 := dataset(bair.Superfile_List(false).BuiltVers, {string Ver, string buildname, string buildtime, boolean deployed}, flat, opt);
		deployed := CurFull[1].deployed;
		pversion := CurFull[1].ver;
			
		LastFullLive := IsPkgLiveOnRoxie(pversion);	  
		
		vMod := IF(version<>'','::'+version,'');
		GHashBaseFileName 	:= Bair._Dataset(pUseProd).thor_cluster_files + 'base::' + Bair._Dataset(pUseProd).Name + '::geohash'+vMod;		
		GHashIndexFileName 	:= Bair._Dataset(pUseProd).thor_cluster_files + 'key::' + Bair._Dataset(pUseProd).Name + '::geohash'+vMod;

		GeoHash0 := join(DISTRIBUTED(bair.Files().GeoHash_Base.built, hash(eid))
							 ,if(not deployed and LastFullLive, Bair.files().AgencyDeletes_base.Built, Bair.AgencyDeletes.eids_to_delete)
							 ,left.eid = right.eid
							 ,transform(left)
							 ,left only
							 ,lookup);
		
		GeoHash0_nonOffender := GeoHash0(etype <> 7);
		GeoHash0_Offender := GeoHash0(etype = 7);
		
		GeoHash := join(DISTRIBUTED(GeoHash0_nonOffender, hash(eid))
							 ,DISTRIBUTED(bair.Files('',false,true).GeoHash_Base.built, hash(eid))
							 ,left.eid = right.eid and left.stamp = right.stamp
							 ,transform({GeoHash0}
									,self.class := if(left.eid = right.eid, right.class, left.class)
									,self.date := if(left.eid = right.eid, right.date, left.date)
									,self 			:= left;)
							 ,keep(1)
							 ,left outer
							 ,local)
							 				+
							 GeoHash0_Offender;
							 
		_buildBase := output(GeoHash,,GHashBaseFileName, compressed, overwrite);
		
		baseDS := DATASET(GHashBaseFileName, {Layouts.GeoHashLayout; UNSIGNED8 __Fpos{virtual(fileposition)}}, THOR);	
		
		Key_GeoHashLayout := record
				bair.Layouts.GeoHashLayout - [gh12];			
				STRING4 	gh4;
				STRING8 	gh8;
				unsigned4	YYYYMM;
				UNSIGNED8 __Fpos{virtual(fileposition)};
		end;
	
		baseDS_p := project(baseDS, transform(key_GeoHashLayout, self.gh4 := left.gh12[1..4]; self.gh8 := left.gh12[5..12]; self.YYYYMM := (unsigned4)((string)left.date)[1..6]; self := left;));
		
		GHashKey  := Index(baseDS_p, {etype,class,gh4,YYYYMM,raids,eid}, {gh8,date,latitude,longitude,ori,group_id,raids,stamp,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,s38,s39,s40,s41,s42,s43,s44,s45,s46,s47,s48,s49,s50,s51,s52,s53,s54,s55,s56,s57,s58,s59,s60,s61,s62,s63,s64,s65,s66,s67,s68,s69,s70,s71,s72,s73,s74,s75,s76,s77,s78,s79,s80,s81,s82,s83,s84,s85,s86,s87,s88,s89,s90,s91,s92,s93,s94,s95,s96,s97,s98,s99}, GHashIndexFileName);
		_buildKey := buildindex(GHashKey, overwrite);		

		export gh := SEQUENTIAL(
										if(STD.File.FileExists(GHashBaseFileName), output(GHashBaseFileName + ' already exist;'), _buildBase),
										if(STD.File.FileExists(GHashIndexFileName), output(GHashIndexFileName + ' already exist;'),	_buildKey),
										bair.Promote(version,pUseProd,false,true).Promote_geohash.buildfiles.New2Built,
										bair.Promote(version,pUseProd,false,false).Promote_geohash.buildfiles.New2Built,
										bair.Promote(version,pUseProd,false,true).Promote_Geohash.buildfiles.Built2QA,
										bair.Promote(version,pUseProd,false,false).Promote_Geohash.buildfiles.Built2QA
									);
end;	
	
	
