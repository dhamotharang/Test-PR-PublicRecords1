import std,address,bair,ut,VehicleV2_Services,DID_Add,bair_composite,bair_importer;

EXPORT GenerateDID_Payload (string version, boolean pUseProd = false, boolean pDelta = false) := function

	AddressCache  := dedup(bair_importer.files().baseLNAddressCache.built(ac_x_coordinate != 0 and ac_y_coordinate != 0), ac_address, all);	
	dpl:=Bair.files().DataProviderLoc_base.built;
	
	// r := bair.layouts.rCompositeBase;
	r := {bair.layouts.rCompositeBase, boolean has_fn, string20 fn, string20 mn, string20 ln};
	
	delta_payload :=
			Bair.PrepDID_Payload(version,pUseProd).CFS_Delta
		+ Bair.PrepDID_Payload(version,pUseProd).MO_Delta
		+ Bair.PrepDID_Payload(version,pUseProd).PER_Delta
		+ Bair.PrepDID_Payload(version,pUseProd).VEH_Delta
		+ Bair.PrepDID_Payload(version,pUseProd).OFF_Delta
		+ Bair.PrepDID_Payload(version,pUseProd).CRA_Delta
		+ Bair.PrepDID_Payload(version,pUseProd).LPR_Delta;
	
	full_payload :=
			Bair.PrepDID_Payload(version,pUseProd).CFS_Full
		+	Bair.PrepDID_Payload(version,pUseProd).MO_Full
		+ Bair.PrepDID_Payload(version,pUseProd).PER_Full
		+ Bair.PrepDID_Payload(version,pUseProd).VEH_Full
		+ Bair.PrepDID_Payload(version,pUseProd).OFF_Full
		+ Bair.PrepDID_Payload(version,pUseProd).CRA_Full
		+ Bair.PrepDID_Payload(version,pUseProd).LPR_Full;
		
	payloadDS := if(pDelta, delta_payload, full_payload);
	
	r AddCacheAddr(r l, AddressCache r) := transform
		string182 cleanaddress182 := if(ut.CleanSpacesAndUpper(l.orig_address) = ut.CleanSpacesAndUpper(r.ac_address), r.ac_clean_address_182, '');
		SELF.cached_addr 					:= if(ut.CleanSpacesAndUpper(l.orig_address) = ut.CleanSpacesAndUpper(r.ac_address), true, false);							
		SELF.prim_range  			:= cleanaddress182[  1..10];
		SELF.predir      			:= cleanaddress182[ 11..12];
		SELF.prim_name   			:= cleanaddress182[ 13..40];
		SELF.addr_suffix 			:= cleanaddress182[ 41..44];
		SELF.postdir     			:= cleanaddress182[ 45..46];
		SELF.unit_desig  			:= cleanaddress182[ 47..56];
		SELF.sec_range   			:= cleanaddress182[ 57..64];
		SELF.p_city_name 			:= cleanaddress182[ 65..89];
		SELF.v_city_name 			:= cleanaddress182[ 90..114];
		SELF.st          			:= cleanaddress182[115..116];
		SELF.zip         			:= cleanaddress182[117..121];
		SELF.zip4       	 		:= cleanaddress182[122..125];
		SELF.cart        			:= cleanaddress182[126..129];
		SELF.cr_sort_sz  			:= cleanaddress182[130..130];
		SELF.lot         			:= cleanaddress182[131..134];
		SELF.lot_order   			:= cleanaddress182[135..135];
		SELF.dbpc        			:= cleanaddress182[136..137];
		SELF.chk_digit   			:= cleanaddress182[138..138];
		SELF.rec_type    			:= cleanaddress182[139..140];
		SELF.fips_st     			:= cleanaddress182[141..142];
		SELF.county      			:= cleanaddress182[143..145];
		SELF.geo_lat     			:= cleanaddress182[146..155];
		SELF.geo_long    			:= cleanaddress182[156..166];
		SELF.msa         			:= cleanaddress182[167..170];
		SELF.geo_blk     			:= cleanaddress182[171..177];
		SELF.geo_match   			:= cleanaddress182[178..178];
		SELF.err_stat    			:= cleanaddress182[179..182];
		self := l;
	end;
	
	dd := join(distribute(dedup(payloadDS(orig_address <> ''),record,except Prepped_rec_type, all), hash(ut.CleanSpacesAndUpper(orig_address))), 
						 distribute(AddressCache, hash(ut.CleanSpacesAndUpper(ac_address))), 
						 left.data_provider_id = right.ac_dataProviderID and ut.CleanSpacesAndUpper(left.orig_address) = ut.CleanSpacesAndUpper(right.ac_address), 
						 AddCacheAddr(left, right),							
						 left outer,
						 local)
						 + payloadDS(orig_address = '');

	ddd:=dedup(dd,record,except Prepped_rec_type, all);

	d:=join(ddd, dpl
					,left.data_provider_id = right.dataProviderID
						,transform(r
							,self.eid_hash:=bair_composite.fn_scale_eid(trim(left.eid,left,right))
							,self.orig_City:= if(left.Prepped_rec_type not in [Bair._Constant.Offenders_, Bair._Constant.Events_Mo_address_of_crime]
																	,if(right.dataProviderID>0 and right.city<>'',right.city,left.orig_City)
																	,if(left.orig_City<>'',left.orig_City,right.City)
																	)
							,self.orig_st:= if(left.Prepped_rec_type not in [Bair._Constant.Offenders_, Bair._Constant.Events_Mo_address_of_crime]
																,if(right.dataProviderID>0   and right.state<>''  ,right.state,left.orig_st)
																,if(left.orig_st<>'',left.orig_st,right.state)
																)
							,SELF.Prepped_addr1 := trim(StringLib.StringCleanSpaces(left.orig_address))
							,SELF.Prepped_addr2 := trim(StringLib.StringCleanSpaces(	trim(self.orig_City) + if(self.orig_city <> '',',','')
																	+ ' '+ self.orig_st
																	+ ' '+ left.orig_zip
																	),left,right)
							,SELF.Prepped_name := trim(StringLib.StringCleanSpaces(left.orig_name))
							,self:=left
							)
					,lookup
					,LEFT OUTER
					);

	r tr0 (d l) := transform
		NonAlphaNum  := '[^a-z0-9]';
		NonAlpha     := '[^a-z]';
		NonAlphaNum_ := '[^a-z0-9 ]';
		NonAlpha_    := '[^a-z ]';
		NonNum       := '[^0-9]';
		
		vin:=trim(regexreplace(NonAlphaNum,l.vin,'',nocase),left,right);		
		self.vin := if(length(vin)<10 or trim(regexreplace('0',vin,''))='','',vin);								

		InvalidPlate:='UNKNOWN|NONE|^UNK$|NOTAG|DRIVEOU|TEMP|DRIVEOUT|NOPLATE'
								 +'|PAPERTAG|MOPED|ZZZZ|DEALER|UNKOWN|XXXX'
								 ;
		plate0:=trim(regexreplace(NonAlphaNum+'|'+InvalidPlate,stringlib.stringfilterout(l.plate,'}{.^!$+<>@=%?*\''),'',nocase),left,right);
		plate:=trim(regexreplace(NonAlphaNum+'|'+InvalidPlate,l.plate,'',nocase),left,right);
		self.plate:=if(length(plate) < 4 or trim(regexreplace('0',plate,''))='','',plate);

		plate_st:=trim(regexreplace(NonAlpha_,l.plate_st,'',nocase),left,right);
		self.plate_st:=if(length(plate_st) < 2,'',plate_st);

		make:=trim(regexreplace(NonAlphaNum_,l.make,'',nocase),left,right);
		self.make:=if(length(make) < 2,'',make);

		model:=trim(regexreplace(NonAlphaNum_,l.model,'',nocase),left,right);
		self.model:=if(length(model) < 2,'',model);

		style:=trim(regexreplace(NonAlphaNum_,l.style,'',nocase),left,right);
		self.style:=if(length(style) < 2,'',style);

		color:=trim(regexreplace(NonAlpha_,l.color,'',nocase),left,right);
		self.color:=if(length(color) < 2,'',color);

		year:=trim(regexreplace(NonNum,l.year,'',nocase),left,right);
		self.year:=if(length(year) < 4 or (unsigned)year not between 1800 and (unsigned)((STRING8)Std.Date.Today())[1..4]+1,'',year);

		InvalidDL:='NONE|UNKNOWN|NONEFOUND|NOLICENSE|UKUNKNOWN|UNLICENSED|123456789|NULL|PARKED|TN000000000'
							+'|A0000000|UK000000000|NOTFOUND|999999999|^XXX$|XXXXXXXXXXXXX'
							;
		dl:=trim(regexreplace(NonAlphaNum+'|'+InvalidDL,l.dl,'',nocase),left,right);
		self.dl:=if(length(dl) < 5 or trim(regexreplace('0',dl,''))='','',dl);

		dl_st0:=trim(regexreplace(NonAlpha_,l.dl_st,'',nocase),left,right);
		dl_st:=Stringlib.StringtoUpperCase(if(length(dl_st0) < 2,'',dl_st0));
		self.dl_st :=Bair_composite.fn_st2abbrev(trim(dl_st,left,right));

		self.phone:=if(length(trim(regexreplace(NonNum,l.phone,'',nocase),left,right))=10
									,trim(regexreplace(NonNum,l.phone,'',nocase),left,right)
									,'');

		self.dob:=if(bair.fnAge(l.dob) < 0,0,l.dob);
		self.age:=if(l.age between 0 and 120,l.age,0);

		Possible_SSN:=trim(regexreplace(NonNum,l.orig_sid,''),left,right);
		SELF.Possible_SSN := if(length(Possible_SSN)=9
														and Possible_SSN not in ut.Set_BadSSN
														and (unsigned)Possible_SSN > 0
														,Possible_SSN
														,'');

		LFM:='^[a-z]{1,}, *[a-z]{1,} *[a-z]*$';
		FML:='^[a-z]{1,}  *[a-z -]{1,}$';
		BUS:='xfinity|t-mobile|^att | att$| att | inc$|sprint|MONOTRONICS|tyco| mart |office| mart$| motel|security'
				+'|^adt |^adt$| adt$| adt |utilit|APARTMENT|wireles|verizon|state of|TARGET|DIGITEL|POLICE| state |DISPATCH'
				+'|city|JC PENNEY|WALMART|SOCIETY|WAL-MART|LAQUINTA|NETWORK|PORTECTION|SAFEWAY|RENT A CAR|ELEMENTARY SCHOOL|MIDDLE SCHOOL'
				+'|PARK CARE|HIGH SCHOOL|CHURCH OF|BMW BANK NORTH AMER|BUFFALO WILD WINGS|FUNLINER AUTO SALES|DRIVING SCHOOL|LAWN CARE|BAPTIST CHURCH';
		INV:='^sgt |^see |^sec |employee|Unknown|REFUSED|COMMONWEALTH';
		
		self.name_hint:=map(
												regexfind(BUS,trim(l.Prepped_name),nocase) => 'B'
												,l.name_hint<>'' => l.name_hint
												,regexfind(INV,trim(l.Prepped_name),nocase) => 'I'
												,length(trim(regexreplace(NonNum,l.Prepped_name,'',nocase)))>1 => 'I'
												,STD.Str.WordCount(l.Prepped_name)=1
													and ~regexfind(',',l.Prepped_name) => 'I'
												,regexfind(LFM,trim(l.Prepped_name),nocase) => 'LFM'
												,regexfind(FML,trim(l.Prepped_name),nocase) => 'FML'
												,'U'
												);

		self.Prepped_name:=Stringlib.StringtoUpperCase(
												if(regexfind(INV,l.Prepped_name,nocase)
													,''
													,l.Prepped_name));

		s:='(.*)([,]* [a-z_]{1,}[,]* [a-z]{2}[,]* [0-9]{5}[-0-9]*[, ]*[a-z]*$)';
		s1:='\\\\.|,';
		INV2:='UNKOWN|UKNOWN|HOMLESS|MEXICO|GENERAL DELIVERY|WALMART|CONFIDENTIAL|DECEASED'
				+'|unknown.*|yes|xy.|homeless|none|no address|transient|refuse|^unk$|address|hpcd'
				+'|UNK|UNK|UNKNWON|UNKNOW|UNKNONW|at large'
				;

		addr1_s0:=STD.Str.ToUpperCase(trim(l.Prepped_addr1,left,right));
		addr1_s1:=map(
									addr1_s0[1..3]='VIN'  => ''
									,trim(regexfind(s,trim(addr1_s0),1,nocase),left,right)=''
																				=> trim(addr1_s0,left,right)
								 ,regexfind(s,trim(addr1_s0,left,right),1,nocase)
								 );
		addr1_s2:=if(regexfind(s1,addr1_s1,nocase),regexreplace(s1,addr1_s1,' ',nocase),addr1_s1);
		addr1_s3:=if(regexfind(INV2,trim(addr1_s2,left,right),nocase),' ',addr1_s2);
		addr1_s4:=if(length(trim(addr1_s3,left,right))<5,'',addr1_s3);
		addr1_prepped:=Stringlib.StringtoUpperCase(trim(STD.Str.CleanSpaces(regexreplace(',',addr1_s4,' ')),left,right));

		addr2_s0:=STD.Str.ToUpperCase(trim(l.Prepped_addr2,left,right));
		addr2_s1:=map(
									addr1_prepped='' => ''
									,regexfind(s,trim(addr1_prepped),2,nocase)<>''
																	 => regexfind(s,trim(addr1_prepped),2,nocase)
									,trim(addr2_s0,left,right)
									);
		addr2_s2:=if(regexfind('san juan',addr2_s1,nocase)
									,regexreplace(' PA ',addr2_s1,' PR ',nocase)
									,addr2_s1
								);
		addr2_prepped:=Stringlib.StringtoUpperCase(trim(STD.Str.CleanSpaces(regexreplace('_',addr2_s2,' ')),left,right));

		self.Prepped_addr1:=if(stringlib.stringfilterout(addr1_prepped,',')=stringlib.stringfilterout(addr2_prepped,','),'',addr1_prepped);
		self.Prepped_addr2:=if(stringlib.stringfilterout(addr1_prepped,',')=stringlib.stringfilterout(addr2_prepped,','),'',addr2_prepped);

		self:=l;
	End;

	d1    := project(d,tr0(left));
	addrs := dedup(d1,Prepped_addr1,Prepped_addr2,all);

	r tr1 (addrs l) := transform, skip(l.Prepped_addr1='' or l.Prepped_addr2='')
		Clean_Address := address.CleanAddress182(l.Prepped_addr1,l.Prepped_addr2);
		SELF.prim_range  			:= if(l.cached_addr, l.prim_range, Clean_Address[ 1..10]);
		SELF.predir      			:= if(l.cached_addr, l.predir, Clean_Address[ 11..12]);
		SELF.prim_name   			:= if(l.cached_addr, l.prim_name, Clean_Address[13..40]);
		SELF.addr_suffix 			:= if(l.cached_addr, l.addr_suffix, Clean_Address[ 41..44]);
		SELF.postdir     			:= if(l.cached_addr, l.postdir, Clean_Address[ 45..46]);
		SELF.unit_desig  			:= if(l.cached_addr, l.unit_desig, Clean_Address[ 47..56]);
		SELF.sec_range   			:= if(l.cached_addr, l.sec_range, Clean_Address[ 57..64]);
		SELF.p_city_name 			:= if(l.cached_addr, l.p_city_name, Clean_Address[ 65..89]);
		SELF.v_city_name 			:= if(l.cached_addr, l.v_city_name, Clean_Address[ 90..114]);
		SELF.st          			:= if(l.cached_addr, l.st, Clean_Address[115..116]);
		SELF.zip         			:= if(l.cached_addr, l.zip, Clean_Address[117..121]);
		SELF.zip4       	 		:= if(l.cached_addr, l.zip4, Clean_Address[122..125]);
		SELF.cart        			:= if(l.cached_addr, l.cart, Clean_Address[126..129]);
		SELF.cr_sort_sz  			:= if(l.cached_addr, l.cr_sort_sz, Clean_Address[130..130]);
		SELF.lot         			:= if(l.cached_addr, l.lot, Clean_Address[131..134]);
		SELF.lot_order   			:= if(l.cached_addr, l.lot_order, Clean_Address[135..135]);
		SELF.dbpc        			:= if(l.cached_addr, l.dbpc, Clean_Address[136..137]);
		SELF.chk_digit   			:= if(l.cached_addr, l.chk_digit, Clean_Address[138..138]);
		SELF.rec_type    			:= if(l.cached_addr, l.rec_type, Clean_Address[139..140]);
		SELF.fips_st     			:= if(l.cached_addr, l.fips_st, Clean_Address[141..142]);
		SELF.county      			:= if(l.cached_addr, l.county, Clean_Address[143..145]);
		SELF.geo_lat     			:= if(l.cached_addr, l.geo_lat, Clean_Address[146..155]);
		SELF.geo_long    			:= if(l.cached_addr, l.geo_long, Clean_Address[156..166]);
		SELF.msa         			:= if(l.cached_addr, l.msa, Clean_Address[167..170]);
		SELF.geo_blk     			:= if(l.cached_addr, l.geo_blk, Clean_Address[171..177]);
		SELF.geo_match   			:= if(l.cached_addr, l.geo_match, Clean_Address[178..178]);
		SELF.err_stat    			:= if(l.cached_addr, l.err_stat, Clean_Address[179..182]);
		SELF := l;
	END;

	d2:=project(addrs,tr1(left));

	j:=join(distribute(d1(Prepped_addr1<>'' and Prepped_addr2<>''),hash(Prepped_addr1,Prepped_addr2))
				,distribute(d2                                          ,hash(Prepped_addr1,Prepped_addr2))
				,   left.Prepped_addr1=right.Prepped_addr1
				and left.Prepped_addr2=right.Prepped_addr2
				,transform(r
					,self.prim_range   :=if(left.Prepped_addr1=right.Prepped_addr1,right.prim_range,'')
					,self.predir       :=if(left.Prepped_addr1=right.Prepped_addr1,right.predir,'')
					,self.prim_name    :=if(left.Prepped_addr1=right.Prepped_addr1,right.prim_name,'')
					,self.addr_suffix  :=if(left.Prepped_addr1=right.Prepped_addr1,right.addr_suffix,'')
					,self.postdir      :=if(left.Prepped_addr1=right.Prepped_addr1,right.postdir,'')
					,self.unit_desig   :=if(left.Prepped_addr1=right.Prepped_addr1,right.unit_desig,'')
					,self.sec_range    :=if(left.Prepped_addr1=right.Prepped_addr1,right.sec_range,'')
					,self.p_city_name  :=if(left.Prepped_addr1=right.Prepped_addr1,right.p_city_name,'')
					,self.v_city_name  :=if(left.Prepped_addr1=right.Prepped_addr1,right.v_city_name,'')
					,self.st           :=if(left.Prepped_addr1=right.Prepped_addr1,right.st,'')
					,self.zip          :=if(left.Prepped_addr1=right.Prepped_addr1,right.zip,'')
					,self.zip4         :=if(left.Prepped_addr1=right.Prepped_addr1,right.zip4,'')
					,self.cart         :=if(left.Prepped_addr1=right.Prepped_addr1,right.cart,'')
					,self.cr_sort_sz   :=if(left.Prepped_addr1=right.Prepped_addr1,right.cr_sort_sz,'')
					,self.lot          :=if(left.Prepped_addr1=right.Prepped_addr1,right.lot,'')
					,self.lot_order    :=if(left.Prepped_addr1=right.Prepped_addr1,right.lot_order,'')
					,self.dbpc         :=if(left.Prepped_addr1=right.Prepped_addr1,right.dbpc,'')
					,self.chk_digit    :=if(left.Prepped_addr1=right.Prepped_addr1,right.chk_digit,'')
					,self.rec_type     :=if(left.Prepped_addr1=right.Prepped_addr1,right.rec_type,'')
					,self.fips_st      :=if(left.Prepped_addr1=right.Prepped_addr1,right.fips_st,'')
					,self.county       :=if(left.Prepped_addr1=right.Prepped_addr1,right.county,'')
					,self.geo_lat      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_lat,'')
					,self.geo_long     :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_long,'')
					,self.msa          :=if(left.Prepped_addr1=right.Prepped_addr1,right.msa,'')
					,self.geo_blk      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_blk,'')
					,self.geo_match    :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_match,'')
					,self.err_stat     :=if(left.Prepped_addr1=right.Prepped_addr1,right.err_stat,'')
					,self:=left)
				,left outer
				,local
				)
				+ d1(Prepped_addr1='' or Prepped_addr2='')
				;

	names00:=table(j(Prepped_name<>''),{Prepped_name,name_hint,title,fname,mname,lname,name_suffix,clean_company_name});
	names0 := dedup(sort(names00,Prepped_name),Prepped_name);

	names0 tr2 (names0 l) :=transform
		SELF.clean_company_name := if(l.name_hint='B'
																,if(ut.CleanCompany(l.Prepped_name) <> ''
																	,ut.CleanCompany(l.Prepped_name)
																	,datalib.companyclean(l.Prepped_name))
																,'');
		cleanName := map(
										 l.name_hint='U'
											=>Address.CleanPerson73(trim(STD.Str.CleanSpaces(l.Prepped_name),left,right))
										,l.name_hint='FML'
											=>Address.CleanPersonFML73(trim(STD.Str.CleanSpaces(l.Prepped_name),left,right))
										,l.name_hint='LFM'
											=>Address.CleanPersonLFM73(trim(STD.Str.CleanSpaces(l.Prepped_name),left,right))
										,''
										);
		self.title       := if(cleanName[1..5] in ['MR','MS'],cleanName[1..5],'');
		self.fname       := cleanName[6..25];
		self.mname       := cleanName[26..45];
		self.lname       := cleanName[46..65];
		self.name_suffix := ut.fGetSuffix(cleanName[66..70]);
		self:=l;
	end;

	names:=project(names0,tr2(left))
					;

	j2:=join(distribute(j(Prepped_name<>''),hash(Prepped_name))
					,distribute(names              ,hash(Prepped_name))
					,left.Prepped_name=right.Prepped_name
					,transform(r
						,self.title:=if(right.title in ['MR','MS'],right.title,'')
						,self.fname:=if(left.has_fn and (right.fname = '' or right.mname = '' or right.lname = ''), left.fn, right.fname)
						,self.mname:=if(left.has_fn and (right.fname = '' or right.mname = '' or right.lname = ''), left.mn, right.mname)
						,self.lname:=if(left.has_fn and (right.fname = '' or right.mname = '' or right.lname = ''), left.ln, right.lname)
						,self.name_suffix:=right.name_suffix
						,self.clean_company_name:=right.clean_company_name
						,self:=left)
					,left outer
					,local
					)
					+ j(Prepped_name='')
					;

	r tr3 (j2 l) :=transform
			valid_male:= 'MALE|M - MALE|M-MALE|M MALE';
			valid_female:= 'FEMALE|F - FEMALE|F-FEMALE|F FEMALE';
			valid_unknown:= 'UNKNOWN|UNK|U-UNKNOWN|UNKOWN|U - UNKNOWN|U UNKNOWN';
			
			self.clean_gender := MAP(regexreplace(valid_male,trim(l.orig_gender,left,right),'M',nocase)='M'	=>'M'
															,regexreplace(valid_female,trim(l.orig_gender,left,right),'F',nocase)='F' =>'F'
															,regexreplace(valid_unknown,trim(l.orig_gender,left,right),'U',nocase)='U' =>'U'
															,trim(l.title,left,right)='MR' =>'M'
															,trim(l.title,left,right)='MS' =>'F'
															,'');
      Self.st						:= If(l.st='',l.plate_st,l.st);																
			Self.Search_Addr1	:= trim(StringLib.StringCleanSpaces(l.prim_range+' '+l.predir+' '+l.prim_name+' '+l.addr_suffix+' '+l.postdir+' '+l.unit_desig+' '+l.sec_range),left,right);
			Self.Search_Addr2	:= trim(StringLib.StringCleanSpaces(l.p_city_name +' '+l.st +' '+l.zip),left,right);
			self:=l;																																								
	end;
	
	j3:= Project(j2,tr3(left));

	//vin decoder
	Vin_input := dedup(project(j3(vin<>''),transform(VehicleV2_Services.Layout_Vehicle_Vin,self.vin:=left.vin,SELF.state_origin:='')),all);
	Vin_out := VehicleV2_Services.Get_Polk_Vina_Data(Vin_input);
	veh_wd_input := dedup(table(vin_out,{vin,make_desc,model_desc,body_style_desc,major_color_desc,vehicle_type_desc,model_year}),all);

	j4 := join(j3(vin<>'')
					,veh_wd_input
					,left.vin=right.vin
					,transform(r
						,self.make:=if(left.make<>'',left.make,right.make_desc)
						,self.model:=if(left.model<>'',left.model,right.model_desc)
						,self.style:=if(left.style<>'',left.style,right.body_style_desc)
						,self.color:=if(left.color<>'',left.color,right.major_color_desc)
						,self.vehicle_type:=if(left.vehicle_type<>'',left.vehicle_type,right.vehicle_type_desc)
						,self.wd_make:=if(left.wd_make<>'',left.wd_make,bair_composite.Functions.make_clean(STD.Str.ToUpperCase(trim(right.make_desc,left,right))))
						,self.wd_model:=if(left.wd_model<>'',left.wd_model,right.model_desc)
						,self.wd_color:=if(left.wd_color<>'',left.wd_color,bair_composite.functions.color_clean(std.str.touppercase(trim(right.major_color_desc,left,right))))
						,self.wd_bodystyle:=if(left.wd_bodystyle<>'',left.wd_bodystyle,bair_composite.Functions.body_clean(STD.Str.ToUpperCase(trim(right.body_style_desc,left,right))))
						,self.year:=if(left.year<>'',left.year,right.model_year)
						,self:=left)
					,left outer
					,local
					)
					+ j3(vin='')
					;
	
	composite := project(j4, bair.layouts.rCompositeBase);
	
	Did_Matchset := ['A','P','D','S'];

	DID_Add.MAC_Match_Flex(
		 composite                  // Input Dataset
		,Did_Matchset             	// Did_Matchset  what fields to match on
		,possible_ssn        				// ssn
		,dob                 				// dob
		,fname											// fname
		,mname			     						// mname
		,lname			     						// lname
		,name_suffix     						// name_suffix
		,prim_range	          			// prim_range
		,prim_name	          			// prim_name
		,sec_range	          			// sec_range
		,zip 				          			// zip5
		,st   			          			// state
		,phone			          			// phone10
		,lexid                     	// Did
		,bair.layouts.rCompositeBase// output layout
		,TRUE                     	// Does output record have the score
		,lexid_score               	// did score field
		,75                        	// score threshold
		,dDidOut     								// output dataset
	);
	
	return dDidOut;
END;