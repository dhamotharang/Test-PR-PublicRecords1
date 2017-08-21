import address,std,nid,AID;

export preprocess(string8 filedate) := function

	firearms_data_final:=files.Firearms_license;

	layouts.Temp transfrm1(layouts.firearms_in d1):=transform
		self.date_first_seen:=filedate;
		self.date_last_seen:=filedate;
		self.expiration_flag:='A';
		self.record_type:='F';
		self.license_number:=
												TRIM(d1.lic_regn,LEFT,right)+
												TRIM(d1.Lic_Dist,LEFT,right)+
												TRIM(d1.Lic_CNTY,LEFT,right)+
												TRIM(d1.Lic_TYPE,LEFT,right)+
												TRIM(d1.Lic_Xprdte,LEFT,right)+
												TRIM(d1.Lic_Seqn,LEFT,right);
		self:=d1;
		self:=[];
  end;

	firearms_data:=project(firearms_data_final,transfrm1(left));//:persist('~Thor_data400::testjdh::firearms_data_0627_05c2');
	


	   Explosives_data_final:=files.Explosives_license;
	
	
	
		layouts.Temp transfrm2(layouts.Explosives_in d1):=transform
   		self.date_first_seen:=filedate;
   		self.date_last_seen:=filedate;
   		self.expiration_flag:='A';
   		self.record_type:='E';
   		self.license_number:=
   											 TRIM(d1.lic_regn,LEFT,right)+
   											 TRIM(d1.Lic_Dist,LEFT,right)+
   											 TRIM(d1.Lic_CNTY,LEFT,right)+
   											 TRIM(d1.Lic_TYPE,LEFT,right)+
   											 TRIM(d1.Lic_Xprdte,LEFT,right)+ 
   											 TRIM(d1.Lic_Seqn,LEFT,right);
   		self:=d1;
   		self:=[];
   	end;
   
   	explosives_data:=project(explosives_data_final,transfrm2(left));//:persist('~Thor_data400::testjdh::explosives_data_0627_05c2');;;
		
		
	
	firearmsexplosivedata:=firearms_data(license_number<>'')+explosives_data(license_number<>'');//:persist('~Thor_data400::testjdh::firearmsexplosives_0627_05c2');;
																		
	NID.Mac_CleanFullNames(firearmsexplosivedata,clean_lic_Names,license_name,includeInRepository:=true, normalizeDualNames:=false);
  
	cl_lic_names:=clean_lic_Names;
	
	 
			 
layouts.temp_rec tCleanNames(cl_lic_names l) := transform

		self.license1_title       := if(l.nametype in ['P','D','I'],l.cln_title,'');
   		self.license1_fname       := if(l.nametype in ['P','D','I'],l.cln_fname,'');
   		self.license1_mname       := if(l.nametype in ['P','D','I'],l.cln_mname,'');
   		self.license1_lname       := if(l.nametype in ['P','D','I'],l.cln_lname,'');
   		self.license1_name_suffix := if(l.nametype in ['P','D','I'],l.cln_suffix,'');
   		self.license1_cname       := l.license_name;
      self.license1_NAMETYPE    := L.NAMETYPE;
   		self.license2_title       := if(l.nametype = 'D',l.cln_title2,'');
   		self.license2_fname       := if(l.nametype = 'D',l.cln_fname2,'');
   		self.license2_mname       := if(l.nametype = 'D',l.cln_mname2,'');
   		self.license2_lname       := if(l.nametype = 'D',l.cln_lname2,'');
   		self.license2_name_suffix := if(l.nametype = 'D',l.cln_suffix2,'');
   		self.license2_cname 			:= '';
			self.license2_nametype		:= l.nametype;
      self.business_cname 			:= l.business_name;
			self.license3_title				:= if(l.nametype = 'B',l.cln_title,'');
			self.license3_fname       := if(l.nametype = 'B',l.cln_fname,'');
			self.license3_mname       := if(l.nametype = 'B',l.cln_mname,'');
			self.license3_lname       := if(l.nametype = 'B',l.cln_lname,'');
			self.license3_name_suffix := if(l.nametype = 'B',l.cln_suffix,'');
			self.license3_cname 			:= '';
			self.license3_nametype		:= if(l.nametype = 'B',l.nametype,'');
			self.license4_title       := if(l.nametype = 'B',l.cln_title2,'');
			self.license4_fname       := if(l.nametype = 'B',l.cln_fname2,'');
			self.license4_mname       := if(l.nametype = 'B',l.cln_mname2,'');
			self.license4_lname       := if(l.nametype = 'B',l.cln_lname2,'');
			self.license4_name_suffix := if(l.nametype = 'B',l.cln_suffix2,'');
			self.license4_cname 			:= '';
			self.license4_nametype		:= l.nametype;
  		SELF.Prepped_addr1:=
											trim(StringLib.StringCleanSpaces(
											trim(l.premise_city)
										+ if(l.premise_city <> '',',','')
										+ ' '+ l.premise_state
										+ ' '+ l.premise_zip),left,right);                                        
	  	SELF.Prepped_addr2:=
											trim(StringLib.StringCleanSpaces(
											trim(l.mail_city)
										+ if(l.mail_city <> '',',','')
										+ ' '+ l.mail_state
										+ ' '+ l.mail_zip_code),left,right);
		self:=l;
	end;

 	cleaned_license_name:=project(cl_lic_names,tCleanNames(left)); 
	NID.Mac_CleanFullNames(cleaned_license_name,clean_bus_Names,business_name,includeInRepository:=true, normalizeDualNames:=false);

cl_bus_names :=clean_bus_Names;
	layouts.temp_rec  CleanbusinessNames(cl_bus_names l) := transform

				self.license1_title      := if(l.nametype in ['P','D','I'] AND l.license1_title = '',l.cln_title,l.license1_title);
   		self.license1_fname       := if(l.nametype in ['P','D','I'] AND l.license1_fname = '',l.cln_fname,l.license1_fname);
   		self.license1_mname       := if(l.nametype in ['P','D','I'] AND l.license1_mname = '',l.cln_mname,l.license1_mname);
   		self.license1_lname       := if(l.nametype in ['P','D','I'] AND l.license1_lname = '',l.cln_lname,l.license1_lname);
   		self.license1_name_suffix := if(l.nametype in ['P','D','I'] AND l.license1_name_suffix = '',l.cln_suffix,l.license1_name_suffix );
   		self.license1_cname       := l.license_name;
      self.license2_title       := if(l.nametype = 'D' AND l.license2_title = '',l.cln_title2,l.license2_title);
   		self.license2_fname       := if(l.nametype = 'D' AND l.license2_fname = '',l.cln_fname2,l.license2_fname );
   		self.license2_mname       := if(l.nametype = 'D' AND l.license2_mname = '',l.cln_mname2,l.license2_mname);
   		self.license2_lname       := if(l.nametype = 'D' AND l.license2_lname = '',l.cln_lname2,l.license2_lname);
   		self.license2_name_suffix := if(l.nametype = 'D' AND l.license2_name_suffix = '',l.cln_suffix2,l.license2_name_suffix);
   		self.license2_cname 			:= '';
			self.license3_title				:= if(l.nametype = 'B' AND l.license3_title = '',l.cln_title,l.license3_title);
			self.license3_fname       := if(l.nametype = 'B' AND l.license3_fname = '',l.cln_fname,l.license3_fname);
			self.license3_mname       := if(l.nametype = 'B' AND l.license3_mname = '',l.cln_mname,l.license3_mname);
			self.license3_lname       := if(l.nametype = 'B' AND l.license3_lname = '',l.cln_lname,l.license3_lname);
			self.license3_name_suffix := if(l.nametype = 'B' AND l.license3_name_suffix = '',l.cln_suffix,l.license3_name_suffix);
			self.license3_cname 			:= '';
			self.license3_nametype		:= l.nametype;
			self.license4_title       := if(l.nametype = 'B' AND l.license4_title = '',l.cln_title2,l.license4_title);
			self.license4_fname       := if(l.nametype = 'B' AND l.license4_fname = '',l.cln_fname2,l.license4_fname);
			self.license4_mname       := if(l.nametype = 'B' AND l.license4_mname = '',l.cln_mname2,l.license4_mname);
			self.license4_lname       := if(l.nametype = 'B' AND l.license4_lname = '',l.cln_lname2,l.license4_lname);
			self.license4_name_suffix := if(l.nametype = 'B' AND l.license4_name_suffix = '',l.cln_suffix2,l.license4_name_suffix);
			self.license4_cname 			:= '';
			self.license4_nametype		:= l.nametype; 		
			self.business_cname := if(l.nametype<>'P' or l.nametype<>'D' ,l.business_name,'');
		self:=l;
	end;   										 

	cleaned_business_name0:=project(cl_bus_names,CleanbusinessNames(left));
	cleaned_business_name1	:= project(cleaned_business_name0, atf.layouts.temp);
	
	unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
	aid.MacAppendFromRaw_2Line(cleaned_business_name1,premise_street,Prepped_addr1,RawAID,clean_addr,lFlags);
	premise_street:=clean_addr;
		 
	layouts.Temp tr (premise_street l) := transform
	 STRING28  v_prim_name 		:= stringlib.stringfilterout(l.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
	 STRING5  v_premise_zip   := l.aidwork_acecache.zip5;  
	 self.premise_prim_range  :=l.aidwork_acecache.prim_range;
	 self.premise_predir      :=l.aidwork_acecache.predir;
	 SELF.premise_prim_name  	:= v_prim_name;
	 self.premise_suffix      :=l.aidwork_acecache.addr_suffix;
	 self.premise_postdir     :=l.aidwork_acecache.postdir;
	 self.premise_unit_desig  :=l.aidwork_acecache.unit_desig;
	 self.premise_sec_range   := stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
	 self.premise_v_city_name := if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
	 self.premise_p_city_name := if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
	 self.premise_orig_zip    := if(v_premise_zip='00000','',v_premise_zip);
	 self.premise_zip4        := l.aidwork_acecache.zip4;
	 SELF.premise_cart       	:= l.aidwork_acecache.cart;
	 SELF.premise_cr_sort_sz 	:= l.aidwork_acecache.cr_sort_sz;
	 SELF.premise_lot        	:= l.aidwork_acecache.lot;
	 SELF.premise_lot_order  	:= l.aidwork_acecache.lot_order;
	 SELF.premise_dpbc       	:= l.aidwork_acecache.dbpc;
	 SELF.premise_chk_digit  	:= l.aidwork_acecache.chk_digit;
	 SELF.premise_rec_type   	:= l.aidwork_acecache.rec_type;
	 self.premise_st          := l.aidwork_acecache.st;
	 self.premise_fips_st     :=l.aidwork_acecache.county[1..2];
	 self.premise_fips_county := l.aidwork_acecache.county[3..5];
	 SELF.premise_geo_lat    	:= l.aidwork_acecache.geo_lat;
	 SELF.premise_geo_long   	:= l.aidwork_acecache.geo_long;
	 self.premise_msa         := if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
	 SELF.premise_geo_blk    	:=l.aidwork_acecache.geo_blk;
	 SELF.premise_geo_match  	:= l.aidwork_acecache.geo_match;
	 SELF.premise_err_stat   	:= l.aidwork_acecache.err_stat;
	 SELF.ORIG_LIC_DIST       :=L.LIC_DIST;
	 SELF.Premise_Zip         :=L.Premise_Zip;
	 SELF.lic_dist:=case(l.lic_dist,
											'01' => 'ME',
											'02' => 'NH',
											'03' => 'VT',
											'04' => 'MA',
											'05' => 'RI',
											'06' => 'CT',
											'11' => 'NY',      															
											'13' => 'NY',
											'14' => 'NY',
											'16' => 'NY',
											'22' => 'NJ',
											'23' => 'PA',
											'25' => 'PA',
											'31' => 'OH',
											'33' => 'CA',
											'34' => 'OH',
											'35' => 'IN',
											'36' => 'IL',
											'37' => 'IL',
											'38' => 'MI',
											'39' => 'WI',
											'41' => 'MN',
											'42' => 'IA',
											'43' => 'MO',
											'45' => 'ND',
											'46' => 'SD',
											'47' => 'NE',
											'48' => 'KS',
											'51' => 'DE',
											'52' => 'MD',
											'54' => 'VA',
											'55' => 'WV',
											'56' => 'NC',
											'57' => 'SC',
											'58' => 'GA',
											'59' => 'FL',
											'61' => 'KY',
											'62' => 'TN',
											'63' => 'AL',
											'64' => 'MS',
											'66' => 'PR',
											'68' => 'CA',
											'71' => 'AR',
											'72' => 'LA',
											'73' => 'OK',
											'74' => 'TX',
											'75' => 'TX',
											'76' => 'TX',
											'77' => 'CA',
											'81' => 'MT',
											'82' => 'ID',
											'83' => 'WY',
											'84' => 'CO',
											'85' => 'NM',
											'86' => 'AZ' ,
											'87' => 'UT',
											'88' => 'NV',
											'91' => 'WA',
											'92' => 'AK',
											'93' => 'OR',
											'94' => 'CA',
											'95' => 'CA',
											'98' => 'GU',
											'99' => 'HI',
											l.lic_dist);   
	 self.irs_region:=MAP(
											 l.lic_dist in
											 ['71','AR','42','IA','36','37','IL','48','KS','41',
												'MN','43','MO','45','ND','47','NE','73','OK','46',
												'SD','74','75','76','TX','39','WI'
											 ]=>'1',
											 l.lic_dist in
											 ['06','CT','04','MA','01','ME','38','MI','02','NH',
												'22','NJ','11','13','14','16','NY','31','34','OH',
												'23','25','PA','05','RI','03','VT'
											 ]=>'2',
											 l.lic_dist in
											 ['92','AK','86','AZ','33','68','77','95','94','CA',
												'84','CO','99','HI','82','ID','81','MT','85','NM',
												'88','NV','93','OR','87','UT','91','WA','83','WY'
											 ]=>'3',
											 l.lic_dist in
											 ['63','AL','DC','51','DE','59','FL','58','GA','35',
												'IN','61','KY','72','LA','52','MD','64','MS','56',
												'NC','57','SC','62','TN','54','VA','55','WV'
											 ]=>'4',
									 '');								
	 self:= l.aidwork_acecache; 
	 SELF := l;
	END;

	cleaned_premise_street_addr0:=project(premise_street,tr(left)):persist('~thor_data400::persist::cleaned_premise_street_addr');
	aid.MacAppendFromRaw_2Line(cleaned_premise_street_addr0,mail_street,Prepped_addr2,RawAID,clean_addr1,lFlags);
					
	layout_firearms_explosives_in tr1 (clean_addr1 l) := transform
		STRING28 v_mail_prim_name:= stringlib.stringfilterout(l.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
		STRING5  v_mail_zip       := l.aidwork_acecache.zip5;
		SELF.mail_prim_range 			:= l.aidwork_acecache.prim_range;
		SELF.mail_predir    			:= l.aidwork_acecache.predir;
		SELF.mail_prim_name  			:= v_mail_prim_name;
		SELF.mail_suffix 					:= l.aidwork_acecache.addr_suffix;
		SELF.mail_postdir    			:= l.aidwork_acecache.postdir;
		SELF.mail_unit_desig			:= l.aidwork_acecache.unit_desig;
		SELF.mail_sec_range   		:=  stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
		SELF.mail_p_city_name			:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
		SELF.mail_v_city_name 		:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
		SELF.mail_st          		:= l.aidwork_acecache.st;
		SELF.mail_zip         		:= if(v_mail_zip='00000','',v_mail_zip);
		SELF.mail_zip4       			:= l.aidwork_acecache.zip4;
		SELF.mail_cart        		:= l.aidwork_acecache.cart;
		SELF.mail_cr_sort_sz  		:= l.aidwork_acecache.cr_sort_sz;
		SELF.mail_lot         		:= l.aidwork_acecache.lot;
		SELF.mail_lot_order   		:= l.aidwork_acecache.lot_order;
		SELF.mail_dpbc       			:= l.aidwork_acecache.dbpc;
		SELF.mail_chk_digit   		:= l.aidwork_acecache.chk_digit;
		SELF.mail_rec_type    		:= l.aidwork_acecache.rec_type;
		SELF.mail_fips_st 		    := l.aidwork_acecache.county[1..2];
		SELF.mail_fips_county 		:= l.aidwork_acecache.county[3..5];
		SELF.mail_geo_lat     		:= l.aidwork_acecache.geo_lat;
		SELF.mail_geo_long    		:= l.aidwork_acecache.geo_long;
		SELF.mail_msa         		:= if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
		SELF.mail_geo_blk     		:= l.aidwork_acecache.geo_blk;
		SELF.mail_geo_match   		:= l.aidwork_acecache.geo_match;
		SELF.mail_err_stat    		:= l.aidwork_acecache.err_stat;
		self:= l.aidwork_acecache; 
		SELF := l;
	end;

	cleaned_mail_street_addr0:=project(clean_Addr1,tr1(left));

	oldandnewfile:=distribute(cleaned_mail_street_addr0
													+file_firearms_explosives_in
												  ,hash(Lic_Regn,lic_dist,lic_cnty,lic_type,lic_xprdte,
															  Lic_Seqn,License_Name,Business_Name,Premise_Street,
															  Premise_City,Premise_State,Premise_orig_Zip,Mail_Street,
														   	Mail_City,Mail_State,Mail_Zip_Code,Voice_Phone));

	BASE_FIREARMS_EXPLOSIVES_s := sort(oldandnewfile,
																	Lic_Regn,
																	lic_dist,
																	lic_cnty,
																	lic_type,
																	lic_xprdte,
																	Lic_Seqn,
																	License_Name,
																	Business_Name,
																	Premise_Street,
																	Premise_City,
																	Premise_State,
																	Premise_orig_Zip,
																	Mail_Street,
																	Mail_City,
																	Mail_State,
																	Mail_Zip_Code,
																	Voice_Phone
																		,local);										
	BASE_FIREARMS_EXPLOSIVES_d := dedup(BASE_FIREARMS_EXPLOSIVES_s,record,except Lic_Regn,all,local);																						

	layout_firearms_explosives_in t_rollup(layout_firearms_explosives_in le,layout_firearms_explosives_in ri) := transform
		self.date_first_seen:= (string)ut.min2((integer)le.date_first_seen,(integer) ri.date_first_seen);
		self.date_last_seen := (string)max((integer)le.date_last_seen, (integer)ri.date_last_seen);
		self := le;
	end;

	input_Prepped := rollup(BASE_FIREARMS_EXPLOSIVES_d
																		, left.Lic_Regn=right.Lic_Regn
																			and left.lic_dist=right.lic_dist
																			and left.lic_cnty=right.lic_cnty
																			and left.lic_type=right.lic_type
																			and left.lic_xprdte=right.lic_xprdte
																			and left.Lic_Seqn=right.Lic_Seqn
																			and left.License_Name=right.License_Name
																			and left.Business_Name=right.Business_Name
																			and left.Premise_Street=right.Premise_Street
																			and left.Premise_City=right.Premise_City
																			and left.Premise_State=right.Premise_State
																			and left.Premise_orig_Zip=right.Premise_orig_Zip
																			and left.Mail_Street=right.Mail_Street
																			and left.Mail_City=right.Mail_City
																			and left.Mail_State=right.Mail_State
																			and left.Mail_Zip_Code=right.Mail_Zip_Code
																			and left.voice_phone=right.voice_phone
																			,t_rollup(left, right)
																			,local);

	 return input_Prepped;
	

end;