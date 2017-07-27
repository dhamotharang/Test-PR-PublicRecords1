import doxie, VersionControl;

export RoxieKeys(const string pversion = '') :=
module

	shared dBh		:= File_business_header_fetch;

	export NewFetch :=
	module

		// ------------------------------------------------------------
		// -- Datasets used in keys below
		// ------------------------------------------------------------
		shared ds_fein  			:= dBh(fein				!= 0									);
		shared ds_address  		:= dBh(prim_name	!= ''									);
		shared ds_name  			:= dBh(cname 			!= ''									);
		shared ds_phone  			:= dBh(p7 				!= '' or  p3 		!= ''	);
		shared ds_stcityname  := dBh(city_name 	!= ''									);
		shared ds_stname  		:= dBh(state 			!= '' and cname != ''	);
		shared ds_street  		:= dBh(prim_name 	!= ''									);
		shared ds_zip  				:= dBh(zip 				!= 0									);
		
		
		// ------------------------------------------------------------
		// -- FEIN key Prep
		// ------------------------------------------------------------
		shared ds_fein_project := project(ds_fein
		,transform(Layouts.Key_Hdr_Biz_FEIN_Layout,
			self.f1        := intformat(left.fein,9,1)[1],
			self.f2        := intformat(left.fein,9,1)[2],
			self.f3        := intformat(left.fein,9,1)[3],
			self.f4        := intformat(left.fein,9,1)[4],
			self.f5        := intformat(left.fein,9,1)[5],
			self.f6        := intformat(left.fein,9,1)[6],
			self.f7        := intformat(left.fein,9,1)[7],
			self.f8        := intformat(left.fein,9,1)[8],
			self.f9        := intformat(left.fein,9,1)[9],
			self.word      := left.word,
			self.indic     := left.indic,
			self.sec       := left.sec,
			self.cname     := left.cname,
			self.bdid      := left.bdid)
		);

		shared ds_fein_distrib := distribute(ds_fein_project,hash(bdid));

		shared ds_fein_dedup   := dedup(sort(ds_fein_distrib,record,local),record,local);

		// ------------------------------------------------------------
		// -- Address key Prep
		// ------------------------------------------------------------
		shared ds_address_project := project(ds_address
		,transform(Layouts.Key_Hdr_Biz_Address_Layout,
			self.prim_name := left.prim_name,
			self.prim_range := left.prim_range,
			self.state     := left.state,
			self.city_code := hash((qstring25)left.city_name),
			self.zip       := left.zip,
			self.sec_range := left.sec_range,
			self.word      := left.word,
			self.indic     := left.indic,
			self.sec       := left.sec,
			self.cname     := left.cname,
			self.bdid      := left.bdid)
		);

		shared ds_address_distrib := distribute(ds_address_project,hash(bdid));

		shared ds_address_dedup   := dedup(sort(ds_address_distrib,record,local),record,local);

		// ------------------------------------------------------------
		// -- Name key Prep
		// ------------------------------------------------------------
		shared ds_name_project := project(ds_name
		,transform(Layouts.Key_Hdr_Biz_Name_Layout,
			self.word      := left.word,
			self.indic     := left.indic,
			self.sec       := left.sec,
			self.cname     := left.cname,
			self.fein      := left.fein,
			self.bdid      := left.bdid)
		);

		shared ds_name_distrib := distribute(ds_name_project,hash(bdid));

		shared ds_name_dedup   := dedup(sort(ds_name_distrib,record,local),record,local);

		// ------------------------------------------------------------
		// -- Phone key Prep
		// ------------------------------------------------------------
		shared ds_phone_project := project(ds_phone,transform(Layouts.Key_Hdr_Biz_Phone_Layout,
			self.p7        := left.p7,
			self.p3        := left.p3,
			self.word      := left.word,
			self.indic     := left.indic,
			self.sec       := left.sec,
			self.cname     := left.cname,
			self.state     := left.state,
			self.bdid      := left.bdid));

		shared ds_phone_distrib := distribute(ds_phone_project,hash(bdid));

		shared ds_phone_dedup   := dedup(sort(ds_phone_distrib,record,local),record,local);

		// ------------------------------------------------------------
		// -- StCityName key Prep
		// ------------------------------------------------------------
		shared ds_stcityname_project := project(ds_stcityname,transform(Layouts.Key_Hdr_Biz_StCityName_Layout,
			self.city_code := hash((qstring25)left.city_name),
			self.state     := left.state,
			self.word      := left.word,
			self.indic     := left.indic,
			self.sec       := left.sec,
			self.cname     := left.cname,
			self.bdid      := left.bdid));

		shared ds_stcityname_distrib := distribute(ds_stcityname_project,hash(bdid));

		shared ds_stcityname_dedup   := dedup(sort(ds_stcityname_distrib,record,local),record,local);

		// ------------------------------------------------------------
		// -- StName key Prep
		// ------------------------------------------------------------
		shared ds_stname_project := project(ds_stname,transform(Layouts.Key_Hdr_Biz_StName_Layout,
			self.state     := left.state,
			self.word      := left.word,
			self.indic     := left.indic,
			self.sec       := left.sec,
			self.cname     := left.cname,
			self.fein      := left.fein,
			self.zip       := left.zip,
			self.bdid      := left.bdid));

		shared ds_stname_distrib := distribute(ds_stname_project,hash(bdid));

		shared ds_stname_dedup   := dedup(sort(ds_stname_distrib,record,local),record,local);

		// ------------------------------------------------------------
		// -- Street key Prep
		// ------------------------------------------------------------
		shared ds_street_project := project(ds_street,transform(Layouts.Key_Hdr_Biz_Street_Layout,
			self.prim_name := left.prim_name,
			self.zip       := left.zip,
			self.word      := left.word,
			self.prim_range := left.prim_range,
			self.indic     := left.indic,
			self.sec       := left.sec,
			self.cname     := left.cname,
			self.bdid      := left.bdid));

		shared ds_street_distrib := distribute(ds_street_project,hash(bdid));

		shared ds_street_dedup   := dedup(sort(ds_street_distrib,record,local),record,local);

	
		// ------------------------------------------------------------
		// -- Zip key Prep
		// ------------------------------------------------------------
		shared ds_zip_project := project(ds_zip,transform(Layouts.Key_Hdr_Biz_Zip_Layout,
			self.zip       := left.zip,
			self.word      := left.word,
			self.indic     := left.indic,
			self.sec       := left.sec,
			self.cname     := left.cname,
			self.fein      := left.fein,
			self.bdid      := left.bdid));

		shared ds_zip_distrib := distribute(ds_zip_project,hash(bdid));

		shared ds_zip_dedup   := dedup(sort(ds_zip_distrib,record,local),record,local);

		// ------------------------------------------------------------
		// -- Key Definitions
		// ------------------------------------------------------------
		versioncontrol.macBuildKeyVersionsNoP(ds_address_dedup		,{ds_address_dedup		}	,keynames(pversion).NewFetch.Address		,key_Address		);
		versioncontrol.macBuildKeyVersionsNoP(ds_fein_dedup				,{ds_fein_dedup				}	,keynames(pversion).NewFetch.Fein				,key_Fein				);
		versioncontrol.macBuildKeyVersionsNoP(ds_name_dedup				,{ds_name_dedup				}	,keynames(pversion).NewFetch.Name				,key_Name				);
		versioncontrol.macBuildKeyVersionsNoP(ds_phone_dedup			,{ds_phone_dedup			}	,keynames(pversion).NewFetch.Phone			,key_Phone			);
		versioncontrol.macBuildKeyVersionsNoP(ds_stcityname_dedup	,{ds_stcityname_dedup	}	,keynames(pversion).NewFetch.Stcityname	,key_Stcityname	);
		versioncontrol.macBuildKeyVersionsNoP(ds_stname_dedup			,{ds_stname_dedup			}	,keynames(pversion).NewFetch.Stname			,key_Stname			);
		versioncontrol.macBuildKeyVersionsNoP(ds_street_dedup			,{ds_street_dedup			}	,keynames(pversion).NewFetch.Street			,key_Street			);
		versioncontrol.macBuildKeyVersionsNoP(ds_zip_dedup				,{ds_zip_dedup				}	,keynames(pversion).NewFetch.Zip				,key_Zip				);

		// ------------------------------------------------------------
		// -- QA SuperKeys
		// ------------------------------------------------------------
		export  key_Address_qa		:= key_Address.qa		;
		export  key_Fein_qa				:= key_Fein.qa			;
		export  key_Name_qa				:= key_Name.qa			;
		export  key_Phone_qa			:= key_Phone.qa			;
		export  key_Stcityname_qa	:= key_Stcityname.qa;
		export  key_Stname_qa			:= key_Stname.qa		;
		export  key_Street_qa			:= key_Street.qa		;
		export  key_Zip_qa				:= key_Zip.qa				;
                 
	end;

end;