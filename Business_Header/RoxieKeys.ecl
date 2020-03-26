import doxie, tools,business_header_ss,nid,prte_csv,risk_indicators,ut,tools,mdr,header_services,codes;

laybus := business_header.Layout_Business_Header_Base_Plus_Orig;
dbdidpl := PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__bdid_pl;

export RoxieKeys(

	 const string																		pversion							= ''
	,dataset(Layouts.File_Hdr_Biz_Keybuild_Layout)	pBh										= File_business_header_fetch()
	,boolean																				pUseOtherEnvironment	= tools._Constants.isdataland //use prod on dataland, prod on prod
	,string																					pkeystring						= 'key'
	,string																					pPrefix								= 'thor_data400'
	,dataset(Layout_Business_Contact_Plus				 )	pBc										= File_Prep_Business_Contacts_Plus
	,dataset(Layout_SIC_Code										 )	pbdidsic							= prct_bdid_sic()
	,dataset(laybus															 )	pbhPL									= project(dbdidpl	,transform(business_header.Layout_Business_Header_Base_Plus_Orig	,self := left;self.rcid := counter;self := []; ))
	,dataset(Layout_Business_Header_Base				 )	pbhbase								= Business_Header.Files().Base.Business_Headers.built

) :=
module

	shared dBh		:= pBh;
	shared dBc		:= pBc;

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
		shared lknames := keynames(pversion,pUseOtherEnvironment,pkeystring,pPrefix).NewFetch;
		
		tools.mac_FilesIndex('ds_address_dedup		,{ds_address_dedup		}	',lknames.Address			,key_Address		);
		tools.mac_FilesIndex('ds_fein_dedup				,{ds_fein_dedup				}	',lknames.Fein				,key_Fein				);
		tools.mac_FilesIndex('ds_name_dedup				,{ds_name_dedup				}	',lknames.Name				,key_Name				);
		tools.mac_FilesIndex('ds_phone_dedup			,{ds_phone_dedup			}	',lknames.Phone				,key_Phone			);
		tools.mac_FilesIndex('ds_stcityname_dedup	,{ds_stcityname_dedup	}	',lknames.Stcityname	,key_Stcityname	);
		tools.mac_FilesIndex('ds_stname_dedup			,{ds_stname_dedup			}	',lknames.Stname			,key_Stname			);
		tools.mac_FilesIndex('ds_street_dedup			,{ds_street_dedup			}	',lknames.Street			,key_Street			);
		tools.mac_FilesIndex('ds_zip_dedup				,{ds_zip_dedup				}	',lknames.Zip					,key_Zip				);

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
	
	export Contacts :=
	module
		
		// ------------------------------------------------------------
		// -- Datasets used in keys below
		// ------------------------------------------------------------
		shared ds_stlfname 		:= dBc(state <> '', lname <> '');
		shared ds_ssn		  		:= dBc(ssn > 0);
		shared ds_bdid				:= dbc(bdid > 0);
    shared ds_did         := dBc(did != 0);
    
		shared dbdid_table 		:= project(ds_bdid, Layout_Business_Contact_Full);
    shared laystcity      := PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__state_city_name;
    shared ds_stcity      := project(ds_stlfname,laystcity);
    shared ds_ctitle      := business_header.format_CompanyTitle(dBc);
		shared ds_BdidScore   := prct_contact_bdid_rels(project(dBc,Layout_Business_Contact_Full_new));
    // ------------------------------------------------------------
		// -- Key Definitions
		// ------------------------------------------------------------
		shared lknames := keynames(pversion,pUseOtherEnvironment,pkeystring,pPrefix).Contacts;
		
		tools.mac_FilesIndex('ds_stlfname		,{state,string6 dph_lname := metaphonelib.DMetaPhone1 (ds_stlfname.lname),lname,qstring20 pfname := NID.PreferredFirstNew (ds_stlfname.fname,true),fname},	{fp := __filepos}',lknames.StateLfmname	,key_StateLfmname		);
		tools.mac_FilesIndex('ds_ssn				,{ssn                         },{fp := __filepos}'  ,lknames.Ssn					,key_Ssn						);
		tools.mac_FilesIndex('dbdid_table		,{bdid                        },{dbdid_table    }'  ,lknames.Bdid					,key_Bdid						);
		tools.mac_FilesIndex('dBc						,{fp := __filepos             },{dBc            }'  ,lknames.Filepos			,key_Filepos				);
		tools.mac_FilesIndex('ds_did	 		  ,{did                         },{fp := __filepos}'  ,lknames.Did    			,key_Did    				);
		tools.mac_FilesIndex('ds_stcity     ,{lname,state,city,fname,mname},{ds_stcity	    }'  ,lknames.StateCityName,key_StateCityName  );

		tools.mac_FilesIndex('ds_BdidScore	,{bdid,score                  },{did, bdid2           }'  ,lknames.BdidScore		,key_BdidScore  		);
		tools.mac_FilesIndex('ds_ctitle 		,{company_title               },{decode_company_title }'  ,lknames.Companytitle	,key_Companytitle		);

    
	end;

	export Sics :=
	module

		// commercial sic zip key
		f1 	:= 	dedup(sort(distribute(pbdidsic(ut.isNumeric(sic_code)),bdid),bdid,sic_code,local),bdid,sic_code,local);
		f2	:=	dedup(sort(distribute(pbhPL,bdid),bdid,zip,zip4,local),bdid,zip,zip4,local);

		layout_sic_zip_index := record
			string8 sic_code;
			unsigned3 zip;
			unsigned2 zip4;	
			unsigned6 bdid;
		end;

		layout_sic_zip_index JoinedToGetZips(f1 lInput, f2 rInput)	:=	transform
			self	:=	lInput;
			self	:=	rInput;
		end;

		JoinToGetZips	:=	join(	f1,
									f2,
									left.bdid=right.bdid,
									JoinedToGetZips(left,right),
									left outer,
									local
								 );

		shared fdedup := dedup(JoinToGetZips, all);

		// sic code key
		f := pbdidsic;

		layout_sic_index := record
		f.bdid;
		f.sic_code;
		end;

		fprep := table(f, layout_sic_index);
		shared fsicdedup := dedup(fprep, all);


		shared lknames := keynames(pversion,pUseOtherEnvironment,pkeystring,pPrefix).base;
		shared rknames		:= Risk_Indicators.Keynames(pversion,pUseOtherEnvironment,pkeystring,pPrefix);

		tools.mac_FilesIndex('fdedup				,{sic_code, zip, zip4 },{bdid			}'	,lknames.Commercial					,key_SicZip						);
		tools.mac_FilesIndex('fsicdedup			,{bdid 								},{sic_code	}'	,lknames.Siccode						,key_SicCode					);
		tools.mac_FilesIndex('Risk_Indicators.Key_Sic_Description'								,rknames.SicCodeDesc				,key_SicDescrip				);

	end;
	
	// ----------------------------------------------------
	// -- Best Keys
	// ----------------------------------------------------
	export HeaderBest :=
	module

		bh_base := pbhbase;
		dbh_clean := project(pbhbase,transform(Layout_Business_Header_Temp,self := left,self := []));
		
		bh_best_layout := Business_Header.Layout_BH_Best;

		f_best := Business_Header.BestAll(bh_base, 'EB_AE_DNB_PRCT',dbh_clean, TRUE,false);  //Set param to true to retrieve best non D&B

		bh_best_layout  filterDNBAddressPhone(bh_best_layout l) := 
		transform
			self.prim_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.prim_range	);
			self.predir				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.predir			);
			self.prim_name		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.prim_name	);
			self.addr_suffix	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.addr_suffix);
			self.postdir			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.postdir		);
			self.unit_desig		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.unit_desig	);
			self.sec_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.sec_range	);
			self.zip					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,0	,l.zip				);
			self.zip4					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,0	,l.zip4				);
			//self.county				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.county			);
			//self.msa					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.msa				);
			//self.geo_lat			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_lat		);
			//self.geo_long			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_long		);
			self.phone				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.phone_source)	,0	,l.phone			);
			//self.phone_score	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.phone_score);
			self 				:= l;                                                    
		end;

		bh_base_filtered := project(f_best, filterDNBAddressPhone(left));
		// need to match back to BH to see if the dnb records with address information have another source

		Business_Header.Layout_BH_Best tblanksource(Business_Header.Layout_BH_Best l) :=
		transform
			self.source := '';
			self := l;
		end;

		in_hdr := project(bh_base_filtered, tblanksource(left));

		shared f_best_blanksource := in_hdr;

		// -- Knowx key
		bh_base := pbhbase;
		codesV3 := codes.Key_Codes_V3;
		dbh_clean := project(pbhbase,transform(Layout_Business_Header_Temp,self := left,self := []));

		required_src_set := set(codesV3(file_name = 'BUSINESS-HEADER'

																				AND field_name= (STRING50)'CONSUMER-PORTAL'

																				AND field_name2= (STRING5)'ALLOW' )
												,code);


		bh_best_layout := Business_Header.Layout_BH_Best;

		f_best := Business_Header.BestAll(bh_base, 'EB_AE_DNB_For_Knowx_PRCT',dbh_clean, TRUE,false);  //Set param to true to retrieve best non D&B);

		bh_best_layout  filterDNBAddressPhone(bh_best_layout l) := 
		transform
			self.prim_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.prim_range	);
			self.predir				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.predir			);
			self.prim_name		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.prim_name	);
			self.addr_suffix	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.addr_suffix);
			self.postdir			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.postdir		);
			self.unit_desig		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.unit_desig	);
			self.sec_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.sec_range	);
			self.zip					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,0	,l.zip				);
			self.zip4					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,0	,l.zip4				);
			//self.county				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.county			);
			//self.msa					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.msa				);
			//self.geo_lat			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_lat		);
			//self.geo_long			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_long		);
			self.phone				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.phone_source)	,0	,l.phone			);
			//self.phone_score	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.phone_score);
			self 				:= l;                     
		end;

		bh_base_filtered := project(f_best(source in required_src_set), filterDNBAddressPhone(left));


		// need to match back to BH to see if the dnb records with address information have another source

		Business_Header.Layout_BH_Best tblanksource(Business_Header.Layout_BH_Best l) :=
		transform
			self.source := '';
			self := l;
		end;

		in_hdr := project(bh_base_filtered, tblanksource(left));

		shared f_best_blanksource_unique := in_hdr;
	
		shared lknames := keynames(pversion,pUseOtherEnvironment,pkeystring,pPrefix).HeaderBest;

		tools.mac_FilesIndex('f_best_blanksource				,{bdid},{f_best_blanksource				}-business_header.layout_BH_exclusions'	,lknames.FileposData					,key_FileposData						);
		tools.mac_FilesIndex('f_best_blanksource_unique	,{bdid},{f_best_blanksource_unique}-business_header.layout_BH_exclusions'	,lknames.FileposData_Knowx		,key_FileposData_Knowx			);

	end;
	
	export supergroup := 
	module

		shared bh_super_record_bdid := dedup(project(pbhbase	,transform(Layout_BH_Super_Group
			,self.group_id 	:= map(
				 regexfind('josur assoc',left.company_name,nocase)  and left.state = 'IL' => 888800000000
				,regexfind('kimur llc'	,left.company_name,nocase)  and left.state = 'IL' => 888800000004
				,regexfind('kornost l'	,left.company_name,nocase)  and left.state = 'IL' => 888800000006
				,																																						 left.bdid
			);
			,self.bdid 			:= left.bdid
		)),group_id,bdid);
	


		shared lknames := keynames(pversion,pUseOtherEnvironment,pkeystring,pPrefix).Supergroup;

		tools.mac_FilesIndex('bh_super_record_bdid	,{bdid		},{group_id	}'	,lknames.Bdid				,key_Bdid					);
		tools.mac_FilesIndex('bh_super_record_bdid	,{group_id},{bdid			}'	,lknames.Groupid		,key_Groupid			);

	end;

	export Search := 
	module

	shared bh 		  := pbhPL;
  shared lknames  := keynames(pversion,pUseOtherEnvironment,pkeystring,pPrefix).Base;

	shared layout_slim_bh := Business_Header_SS.layout_MakeCNameWords;
  

	layout_slim_bh MungeName(bh l) := TRANSFORM
		SELF := l;
	END;

	shared bh_slim := PROJECT(bh, MungeName(LEFT));

	shared words_final := project(
		business_header_ss.Fn_MakeCNameWords(bh_slim),
		Business_Header_SS.Layout_Header_Word_Index
	);

	// Output the file to TEMP, we won't need it once the index is
	// built on it.
	//switching to base for now to match standard
//	VersionControl.macBuildNewLogicalFile( BaseName.CompanyWords.New	,words_final	,Build_CompanyWords_File	);

//  tools.macf_WriteFile
  
	shared layout_slim_bh2 := RECORD
		bh.bdid;
		bh.city;
		bh.zip;
		bh.fein;
		bh.phone;
	END;

	shared layout_slim_bh2 SlimBH(bh l) := TRANSFORM
		SELF := l;
	END;

	shared bh_slim2 := PROJECT(bh, SlimBH(LEFT));
	shared bh_slim_ded2 := DEDUP(bh_slim2, bdid, city, zip, fein, phone, ALL);

//	VersionControl.macBuildNewLogicalFile( BaseName.Bdid.New	,bh_slim_ded2	,Build_Bdid_File	);

//////////////////////////////////////
//Key_Prep_BH_Header_Words
//////////////////////////////////////

shared wf := project(words_final,transform({recordof(left),unsigned integer8 __filepos { virtual(fileposition)}},self := left;));

shared Layout_Header_Word_Index_Index := RECORD
	wf.word;
	wf.state;
	wf.seq;
	wf.bh_filepos;
	wf.bdid;
	wf.__filepos;
END;
	
// The index contains all the fields in the file -- the file itself is never
// referenced through the index.

//////////////////////////////////////
//Key_Prep_BH_BDID_City_Zip_Fein_Phone
//////////////////////////////////////
shared sbh := project(bh_slim_ded2,transform({recordof(left),unsigned integer8 __filepos { virtual(fileposition)}},self := left;));

shared layout_sbh_index := RECORD
	sbh.bdid;
	sbh.city;
	sbh.zip;
	sbh.fein;
	sbh.phone;
	sbh.__filepos;
END;
	

  
//////////////////////////////////////
//Key_BH_Header_Words_Metaphone
//////////////////////////////////////

//***** CONSTANT
shared ceiling_for_duplicates := 2000;

//***** BUSINESS HEADER FILE 
shared fb :=  pbhPL;

//***** PREPARE TO CALL THE NEWER WORDS FUNCTION
shared pfb2 :=
project(
	fb,
	transform(
		Business_Header_SS.mod_MakeCNameWords.metaphone.inrec,
		self.zip := (string6)left.zip;
		self.__filepos := [],
		self := left;
	)
);

//***** CALL WORDS FUNCTION
shared words_unfiltered := Business_Header_SS.mod_MakeCNameWords.metaphone.mrecords(pfb2);

//***** REQUIRE STATE AND ZIP
shared words_filtered := words_unfiltered(state <> '', zip not in ['','0']);

//***** DROP COMBINATIONS THAT ARE TOO COMMON TO BE USEFUL;
shared p := words_filtered;

shared r := record
	p.metaphone;
	p.state;
	p.zip;
	cnt := count(group);
end;

shared t := table(p, r, metaphone, state, zip);
shared b := t(cnt > ceiling_for_duplicates);

shared words := 
	join(
		words_filtered,
		b,
		left.metaphone = right.metaphone and
		left.state = right.state and
		left.zip = right.zip,
		transform(
			recordof(words_filtered),
			self := left
		),
		left only,
		hash
	);
		

//////////////////////////////////////
//business_header.Key_Business_Header_Address
//////////////////////////////////////
shared df := pbhPL(prim_name != '' or state != '');

		export key_BH_Header_Words		          := tools.macf_FilesIndex('wf	,Layout_Header_Word_Index_Index'	                                                                                                          ,lknames.Conamewords				  );
    export key_BH_BDID_City_Zip_Fein_Phone	:= tools.macf_FilesIndex('sbh	,layout_sbh_index'	                                                                                                                        ,lknames.BdidCityZipFeinPhone );
		export key_BH_Header_Words_Metaphone		:= tools.macf_FilesIndex('dedup(words,metaphone, state, zip, bdid, all),{metaphone, state, zip},{bdid}'	                                                                  ,lknames.CoNameWordsMetaphone );
		export key_BH_Address		                := tools.macf_FilesIndex('df,{string28 pn := ut.stripordinal(df.prim_name),string2 st := df.state,string10 pr := df.prim_range,zip,string8 sr := df.sec_range,__filepos}'	,lknames.PnStPrZipSr          );

	end;

end;
