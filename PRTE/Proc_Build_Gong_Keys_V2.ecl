import	_control, PRTE_CSV, gong, NID;

history := PRTE.Get_Gong_Base.rawdata +
			PRTE.Get_Gong_Base.Santander;

weakly := PRTE.Get_Gong_Base.weeklydata +
			PRTE.Get_Gong_Base.Santander;

// change the previous version before running!!!
//previousVersion := '20150404';	// this is the "previous version" for the next update
previousVersion := '20121030';		// layout change for data source

export Proc_Build_Gong_Keys_V2(string pIndexVersion) := function


rKeyGong__key__history__address	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__address;
end;
dKeyGong__key__history__address	:= 	
	project(history(trim(prim_name)<>'', trim(z5)<>''), TRANSFORM(rKeyGong__key__history__address,
			  SELF.current_flag := if(LEFT.current_record_flag='Y',true,false),
			  SELF.business_flag := if(LEFT.listing_type_bus='B',true,false),
			  SELF := LEFT)	
		);
		
kKeyGong__key__history__address := index(dKeyGong__key__history__address, 
             {prim_name,
		    st,    z5, prim_range,    sec_range,
			current_flag, business_flag},
		    {dKeyGong__key__history__address},
			'~prte::key::gong_history::' + pIndexVersion + '::address');
// **********************************
rKeyGong__key__history__phone	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__phone - __internal_fpos__;
end;
dKeyGong__key__history__phone	:= 	
	project(history(trim(phone10)<>''),
			TRANSFORM(rKeyGong__key__history__phone,
				SELF.phone7 := if(LEFT.phone10[8..10]='',LEFT.phone10[1..7],LEFT.phone10[4..10]),
				SELF.area_code := if(LEFT.phone10[8..10]='','',LEFT.phone10[1..3]),
              SELF.p7 := if(LEFT.phone10[8..10]='',LEFT.phone10[1..7],LEFT.phone10[4..10]);,
			  SELF.p3 := if(LEFT.phone10[8..10]='','',LEFT.phone10[1..3]),
			  SELF.current_flag := if(LEFT.current_record_flag='Y',true,false),
			  SELF.business_flag := if(LEFT.listing_type_bus='B',true,false),
			  SELF := LEFT)
			);
kKeyGong__key__history__phone := index(dKeyGong__key__history__phone, 
			  {p7, p3, st, current_flag, business_flag},
		    {dKeyGong__key__history__phone},
			'~prte::key::gong_history::' + pIndexVersion + '::phone');

// **********************************
rKeyGong__key__history__name	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__name;
end;
dKeyGong__key__history__name := project(history(trim(name_last)<>''), 
			TRANSFORM(rKeyGong__key__history__name,
				SELF.dph_name_last := metaphonelib.DMetaPhone1(LEFT.name_last);
				SELF.p_name_first := NID.PreferredFirstNew(LEFT.name_first);
				SELF := LEFT;)
			);
kKeyGong__key__history__name := index(dKeyGong__key__history__name, 
				{dph_name_last,
							name_last,
							st,
					p_name_first,
							name_first},
						  {dKeyGong__key__history__name},
 '~prte::key::gong_history::' + pIndexVersion + '::name');	
//*********************************
rKeyGong__key__history__zip_name	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__zip_name;
end;
dKeyGong__key__history__zip_name := project(history(metaphonelib.DMetaPhone1(name_last) <> '',trim(z5)<>''),
							TRANSFORM(rKeyGong__key__history__zip_name,
								SELF.dph_name_last := metaphonelib.DMetaPhone1(LEFT.name_last);
								SELF.p_name_first := NID.PreferredFirstNew(LEFT.name_first);
								SELF.zip5 := (integer4)LEFT.z5;
								SELF := LEFT;
								));
kKeyGong__key__history__zip_name := index(dKeyGong__key__history__zip_name, 
 			 {dph_name_last, zip5, p_name_first,
						  name_last,
						  name_first
					       },
						  {dKeyGong__key__history__zip_name},
 '~prte::key::gong_history::' + pIndexVersion + '::zip_name');		
//*********************************
rKeyGong__key__history__did	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__did;
end;
dKeyGong__key__history__did	:= 	project(history(did<>0), TRANSFORM(rKeyGong__key__history__did,
				SELF.current_flag := if(LEFT.current_record_flag='Y',true,false),
				SELF.business_flag := if(LEFT.listing_type_bus='B',true,false),
				SELF.l_did := LEFT.did;
				SELF := LEFT;)
			);
kKeyGong__key__history__did := index(dKeyGong__key__history__did, 
						  {l_did, current_flag, business_flag},
						  {dKeyGong__key__history__did},
 '~prte::key::gong_history::' + pIndexVersion + '::did');	
 //*********************************
rKeyGong__key__history__hhid	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__hhid;
end;
dKeyGong__key__history__hhid	:= 	project(history(hhid<>0), TRANSFORM(rKeyGong__key__history__hhid,
				SELF.current_flag := if(LEFT.current_record_flag='Y',true,false),
				SELF.business_flag := if(LEFT.listing_type_bus='B',true,false),
				SELF.s_hhid := LEFT.hhid;
				SELF := LEFT;)
			);
kKeyGong__key__history__hhid := index(dKeyGong__key__history__hhid, 
 						  {s_hhid, current_flag, business_flag},
						  {dKeyGong__key__history__hhid},
 '~prte::key::gong_history::' + pIndexVersion + '::hhid');
//*********************************
rKeyGong__key__history__bdid	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__bdid;
end;
dKeyGong__key__history__bdid	:= 	project(history(bdid<>0), rKeyGong__key__history__bdid);
kKeyGong__key__history__bdid := index(dKeyGong__key__history__bdid, 
 						  {bdid},
						  {dKeyGong__key__history__bdid},
 '~prte::key::gong_history::' + pIndexVersion + '::bdid');	//*********************************
//*********************************
rKeyGong__key__history__surname	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__surnames;
end;
dKeyGong__key__history__surname := project(PRTE_CSV.Gong.dthor_data400__key__gong_history__surnames, rKeyGong__key__history__surname);
kKeyGong__key__history__surname := index(dKeyGong__key__history__surname, 
	{k_name_last,k_name_first,k_st},
	{dKeyGong__key__history__surname},
 '~prte::key::gong_history::' + pIndexVersion + '::surname');
//*********************************
rKeyGong__key__history__companyname	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__companyname;
end;
dKeyGong__key__history__companyname := project(history((unsigned)phone10<>0, listing_type_bus<>'', listed_name<>''),
						TRANSFORM(rKeyGong__key__history__companyname,
							SELF.current_flag := if(LEFT.current_record_flag='Y',true,false),
                            self.listed_name_new := StringLib.StringCleanSpaces(
					           StringLib.StringSubstituteOut(left.listed_name,
							   '~`!@#$%^&*()-_+={[}]|\\;:"\'<,>.?/',' ')
								); 
							SELF := LEFT;)
						);
kKeyGong__key__history__companyname := index(dKeyGong__key__history__companyname(listed_name_new<>''), 
						  {listed_name_new, st, p_city_name,current_flag},
							{dKeyGong__key__history__companyname},
 '~prte::key::gong_history::' + pIndexVersion + '::companyname');
 //*********************************
rKeyGong__key__history__city_st_name	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__city_st_name - __internal_fpos__;
end;
dKeyGong__key__history__city_st_name := project(history(trim(p_city_name)<>'', name_last<>''),
						TRANSFORM(rKeyGong__key__history__city_st_name,
							SELF.city_name:=LEFT.p_city_name;
							SELF.city_code := HASH((qstring25)LEFT.p_city_name);
							SELF.dph_name_last := metaphonelib.DMetaPhone1(LEFT.name_last);
							SELF.p_name_first := NID.PreferredFirstNew(LEFT.name_first);
							SELF := LEFT;)
						);
kKeyGong__key__history__city_st_name := index(dKeyGong__key__history__city_st_name, 
	            {city_code, st, dph_name_last,
					name_last,
					p_name_first, name_first},
						{dKeyGong__key__history__city_st_name},
 '~prte::key::gong_history::' + pIndexVersion + '::city_st_name');								 
//*********************************
rKeyGong__key__history__wild_name_zip	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__wild_name_zip;
end;
dKeyGong__key__history__wild_name_zip := project(history(name_last<>''),
					TRANSFORM(rKeyGong__key__history__wild_name_zip,
						  SELF.zip5 := (integer4)LEFT.z5;
						  SELF := LEFT;)
					);
kKeyGong__key__history__wild_name_zip := index(dKeyGong__key__history__wild_name_zip, 
             {name_last,
						  st,
						  name_first,zip5},
							{dKeyGong__key__history__wild_name_zip},
 '~prte::key::gong_history::' + pIndexVersion + '::wild_name_zip');
//*********************************
 rKeyGong__key__did	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__did - __internal_fpos__;
end;
dKeyGong__key__did	:= 	project(weakly(did<>0), TRANSFORM(rKeyGong__key__did,
				SELF.l_did := LEFT.did;
				SELF := LEFT;
		));
kKeyGong__key__did := index(dKeyGong__key__did, 
                             {l_did},
							 {dKeyGong__key__did},
 '~prte::key::gong::' + pIndexVersion + '::did');
//*********************************
rKeyGong__key__hhid	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__hhid - __internal_fpos__;
end;
dKeyGong__key__hhid	:= 	project(weakly(hhid<>0), TRANSFORM(rKeyGong__key__hhid,
					SELF.s_hhid := LEFT.hhid;
					SELF := LEFT;
				));
kKeyGong__key__hhid := index(dKeyGong__key__hhid, 
                             {s_hhid},
							 {dKeyGong__key__hhid},
 '~prte::key::gong::' + pIndexVersion + '::hhid');
//*********************************
rKeyGong__key__weekly__address_current	:=
record
	string28 prim_name;
	string2 st;
	string5 z5;
	string10 prim_range;
	string8 sec_range;
	string2 predir;
	string4 suffix;
	string10 phone10;
	string120 listed_name;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string1 dual_name_flag;
	string8 date_first_seen;
	unsigned1 listing_type;
	string1 publish_code;
	string1 omit_phone;
end;
dKeyGong__key__weekly__address_current	:= 	project(weakly(prim_name<>'', trim(z5)<>''),
		TRANSFORM(rKeyGong__key__weekly__address_current,
				self.date_first_seen := LEFT.filedate[1..8];
				self.fname := LEFT.name_first;
				self.mname := LEFT.name_middle;
				self.lname := LEFT.name_last;
				Self.listing_type := if (LEFT.listing_type_bus='B', Gong.Constants.PTYPE.BUSINESS, 0) +
                       if (LEFT.listing_type_res='R', Gong.Constants.PTYPE.RESIDENTIAL, 0) +
                       if (LEFT.listing_type_gov='G', Gong.Constants.PTYPE.GOVERNMENT, 0);
				SELF := LEFT;
		));
kKeyGong__key__weekly__address_current := index(dKeyGong__key__weekly__address_current, 
  {prim_name, st, z5, prim_range, sec_range, predir, suffix}, 
  {phone10, listed_name, fname, mname, lname, name_suffix, dual_name_flag, 
	 date_first_seen, listing_type, publish_code, omit_phone},
 '~prte::key::gong_weekly::' + pIndexVersion + '::address_current');
//*********************************
rKeyGong__key__cn	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__cn;
end;
dKeyGong__key__cn	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__cn,
							rKeyGong__key__cn);
kKeyGong__key__cn := index(dKeyGong__key__cn, 
               {string6 dph_cn := metaphonelib.DMetaPhone1(cn), cn, st, p_city_name, v_city_name, z5},{listed_name, phone10},
	 '~prte::key::gong::' + pIndexVersion + '::cn');
//*********************************
rKeyGong__key__cn_to_company	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__cn_to_company;
end;
dKeyGong__key__cn_to_company	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__cn_to_company,
							rKeyGong__key__cn_to_company);
kKeyGong__key__cn_to_company := index(dKeyGong__key__cn_to_company, 
					 {listed_name, st, p_city_name, z5, phone10}, 
					{dKeyGong__key__cn_to_company},
	 '~prte::key::gong::' + pIndexVersion + '::cn_to_company');
// **********************************
rPhoneTable := RECORD
	STRING10	phone10;
	BOOLEAN 	isCurrent;
	unsigned3 dt_first_seen;
	STRING20 	lname;
	string28 	prim_name;
	STRING10 	prim_range;
	string25 	city;
	string2  	state;
	STRING5  	zip5;
	STRING4  	zip4;
	boolean  	potDisconnect := false;
	BOOLEAN  	isaCompany := false;
	STRING1  	company_type := '';
	BOOLEAN  	company_type_A := false;
	string4  	sic_code := '';
	string120 company_name := '';
	unsigned3 hri_dt_first_seen := 0;
	STRING2 	nxx_type := '';
	integer did_ct;
	integer did_ct_c6;	
END;
dPhoneTable := dataset([], rPhoneTable);
Key_Business_Header_Phone_Table_V2 := index(dPhoneTable, {phone10}, {dPhoneTable},
		'~prte::key::business_header::' + pIndexVersion + '::hri::phone10_v2');
/****************  End Gong KEYS ***************************************/
	return	sequential(
				parallel(
				// Gong history keys
					build(kKeyGong__key__history__address, update),
					build(kKeyGong__key__history__phone, update),
					build(kKeyGong__key__history__did, update),
					build(kKeyGong__key__history__hhid, update),
					build(kKeyGong__key__history__bdid, update),
					build(kKeyGong__key__history__name, update),
					build(kKeyGong__key__history__zip_name, update),
					build(kKeyGong__key__history__surname, update),
					build(kKeyGong__key__history__companyname, update),
					build(kKeyGong__key__history__city_st_name, update),
					build(kKeyGong__key__history__wild_name_zip, update),
				// 
					build(kKeyGong__key__did			, update),
					build(kKeyGong__key__hhid			, update),
					build(kKeyGong__key__weekly__address_current, update),
					build(Key_Business_Header_Phone_Table_V2, update),
				// do not rebuild the following keys
					//build(kKeyGong__key__cn				, update),
					//build(kKeyGong__key__cn_to_company	, update)
				)
				//OUTPUT('test build done')
				,CopyMissingKeys('GongKeys',pIndexVersion,previousVersion)
				,PRTE.UpdateVersion('GongKeys',										//	Package name
					 pIndexVersion,												//	Package version
					 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
					'B',		//	B = Boca, A = Alpharetta
					'N',		//	N = Non-FCRA, F = FCRA
					'N'			//	N = Do not also include boolean, Y = Include boolean, too
					)
				);
end;
