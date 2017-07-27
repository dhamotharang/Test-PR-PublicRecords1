import ut, did_add, header_slimsort, didville,watchdog,doxie,header,DriversV2,codes;

export compID_weekly(
					string filedate
					,boolean DoPersist=false
					) := function

	File_Dl:=dedup(sort(distribute(DriversV2.File_Dl,hash(did)),did, history, -dt_last_seen, -dt_first_seen,local),did,local);

	ds_in:=distribute(File_compID,hash(
							 trim((qstring)(Address_1+Address_2),all)
							,trim((qstring)(City+State+Zip_Code),all)
									));
	r:=record
		unsigned6 did:=0,
		integer did_score:=0,
		recordof(ds_in) compid_in;
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		suffix;
		string3		score;
		string9		clean_ssn;
		string8		clean_dod;
		string8		clean_dob;
		string20	clean_dl;
		string10	prim_range;
		string2		predir;
		string28	prim_name;
		string4		addr_suffix;
		string2		postdir;
		string10	unit_desig;
		string8		sec_range;
		string25	p_city_name;
		string25	v_city_name;
		string2		st;
		string5		zip5;
		string4		zip4;
		string4		cart;
		string1		cr_sort_sz;
		string4		lot;
		string1		lot_order;
		string2		dpbc;
		string1		chk_digit;
		string2		rec_type;
		string2		ace_fips_st;
		string3		county;
		string10	geo_lat;
		string11	geo_long;
		string4		msa;
		string7		geo_blk;
		string1		geo_match;
		string4		err_stat;
		string10	ind;
	end;

	r tr_addr_clean0( ds_in l,cache_addresses r ) :=transform
		self.prim_range		:= r.clean[	1	..	10	];
		self.predir			:= r.clean[	11	..	12	];
		self.prim_name		:= r.clean[	13	..	40	];
		self.addr_suffix	:= r.clean[	41	..	44	];
		self.postdir		:= r.clean[	45	..	46	];
		self.unit_desig		:= r.clean[	47	..	56	];
		self.sec_range		:= r.clean[	57	..	64	];
		self.p_city_name	:= r.clean[	65	..	89	];
		self.v_city_name	:= r.clean[	90	..	114	];
		self.st				:= r.clean[	115	..	116	];
		self.zip5			:= r.clean[	117	..	121	];
		self.zip4			:= r.clean[	122	..	125	];
		self.cart			:= r.clean[	126	..	129	];
		self.cr_sort_sz		:= r.clean[	130	..	130	];
		self.lot			:= r.clean[	131	..	134	];
		self.lot_order		:= r.clean[	135	..	135	];
		self.dpbc			:= r.clean[	136	..	137	];
		self.chk_digit		:= r.clean[	138	..	138	];
		self.rec_type		:= r.clean[	139	..	140	];
		self.ace_fips_st	:= r.clean[	141	..	142	];
		self.county			:= r.clean[	143	..	145	];
		self.geo_lat		:= r.clean[	146	..	155	];
		self.geo_long		:= r.clean[	156	..	166	];
		self.msa			:= r.clean[	167	..	170	];
		self.geo_blk		:= r.clean[	171	..	177	];
		self.geo_match		:= r.clean[	178	..	178	];
		self.err_stat		:= r.clean[	179	..	182	];
		self.compid_in		:=l;
		self				:=[];
	end;

	ds_in1:=join(ds_in,cache_addresses
				,	trim((qstring)(left.Address_1+left.Address_2),all)		=trim(right.addr1,all)
				and	trim((qstring)(left.City+left.State+left.Zip_Code),all)	=trim(right.addr2,all)
					,tr_addr_clean0(left,right)
					,local);

	r tr_addr_clean( ds_in l) :=transform
		string182 caddr		:=	AddrCleanLib.CleanAddress182(l.Address_1+' '+l.Address_2
											,l.City+' '+l.State+' '+l.Zip_Code);
		self.prim_range		:= caddr[	1	..	10	];
		self.predir			:= caddr[	11	..	12	];
		self.prim_name		:= caddr[	13	..	40	];
		self.addr_suffix	:= caddr[	41	..	44	];
		self.postdir		:= caddr[	45	..	46	];
		self.unit_desig		:= caddr[	47	..	56	];
		self.sec_range		:= caddr[	57	..	64	];
		self.p_city_name	:= caddr[	65	..	89	];
		self.v_city_name	:= caddr[	90	..	114	];
		self.st				:= caddr[	115	..	116	];
		self.zip5			:= caddr[	117	..	121	];
		self.zip4			:= caddr[	122	..	125	];
		self.cart			:= caddr[	126	..	129	];
		self.cr_sort_sz		:= caddr[	130	..	130	];
		self.lot			:= caddr[	131	..	134	];
		self.lot_order		:= caddr[	135	..	135	];
		self.dpbc			:= caddr[	136	..	137	];
		self.chk_digit		:= caddr[	138	..	138	];
		self.rec_type		:= caddr[	139	..	140	];
		self.ace_fips_st	:= caddr[	141	..	142	];
		self.county			:= caddr[	143	..	145	];
		self.geo_lat		:= caddr[	146	..	155	];
		self.geo_long		:= caddr[	156	..	166	];
		self.msa			:= caddr[	167	..	170	];
		self.geo_blk		:= caddr[	171	..	177	];
		self.geo_match		:= caddr[	178	..	178	];
		self.err_stat		:= caddr[	179	..	182	];
		self.compid_in		:=l;
		self				:=[];
	end;

	ds_in2:=join(ds_in,cache_addresses
				,	trim((qstring)(left.Address_1+left.Address_2),all)		=trim(right.addr1,all)
				and	trim((qstring)(left.City+left.State+left.Zip_Code),all)	=trim(right.addr2,all)
					,tr_addr_clean(left)
					,left only
					,local) + ds_in1;

	r tr( ds_in2 l) :=transform
		name				:=	l.compid_in.Last_Name+' '+l.compid_in.First_Name+' '+l.compid_in.Middle_Name;
		string73 cname		:=	if(trim(name)<>'',addrcleanlib.cleanpersonlfm73(stringlib.stringcleanspaces(name)),'');
		self.title     		:= cname[ 1.. 5];
		self.fname   		:= cname[ 6..25];
		self.mname			:= cname[26..45];
		self.lname 			:= cname[46..65];
		self.suffix			:= if(l.Suffix<>'',l.Suffix,cname[66..70]);
		self.score 			:= cname[71..73];

		self.clean_dod:=if(length(regexreplace('0',trim(l.compid_in.dod),''))=0,'','19'+trim(l.compid_in.dod));
		self.clean_dob:=if(length(regexreplace('0',trim(l.compid_in.dob),''))=0,'','19'+trim(l.compid_in.dob));
		self.clean_ssn:=if(length(regexreplace('0',trim(l.compid_in.ssn),''))=0,'',trim(l.compid_in.ssn));
		self.clean_dl:=if(length(regexreplace('0',trim(l.compid_in.License_Number),''))=0,'',trim(l.compid_in.License_Number));
		self.compid_in		:=l.compid_in;
		self				:=	l;
	end;

	ds_clean	:=	project(ds_in2,tr(left))
	:persist('~thor_data400::persist::compid::ds_clean_input');
	// ds_clean:=dataset('~thor_data400::persist::compid::ds_clean_input',r,flat);

	//did new file
	matchset := ['A','D','S','Q'];

	did_add.MAC_Match_Flex
	(ds_clean
	,matchset
	,clean_ssn
	,clean_dob
	,fname
	,mname
	,lname
	,suffix
	,prim_range
	,prim_name
	,sec_range
	,zip5
	,st
	,foo
	,DID
	,r
	,true
	,DID_Score
	,75
	,did_out0);

	did_out:=sort(distribute(did_out0,hash(did)),record,local)
		:persist('~thor_data400::persist::compid::did_out');
	// did_out:=dataset(ut.foreign_prod+'~thor_data400::persist::compid::did_out',r,flat);

	
	h:=header.file_headers;
	segmented_wdog := distribute(Header.fn_ADLSegmentation(h).core_check,hash(did));
	wdog_with_ind := JOIN(distribute(file_compid_best,hash(did)),segmented_wdog
						,left.did=right.did
						,transform({file_compid_best,segmented_wdog.ind}
									,self.ind:=right.ind
									,self:=left)
						,LOCAL)
						 :persist('~thor_data400::persist::compid::wdog_with_ind1')
						;

	r tr_wdog(did_out l, wdog_with_ind r) :=transform

		threshld :=15;
		integer YYYYMMDDToDays(string pInput) :=	(((integer)(pInput[1..4])*365)
												+	((integer)(pInput[5..6])*30)
												+	((integer)(pInput[7..8])));
		today := YYYYMMDDToDays(ut.GetDate);
		of_age :=(integer)((today - YYYYMMDDToDays((string) r.dob)) / 365) >= threshld;

		boolean new_core 				:= l.did=0 and r.ind='CORE' and r.dod='' and of_age;

		//even if the record ADLd, do not send it back if it is not in watchdog
		self.did						:=if(new_core,r.did,if(l.did=r.did and l.did>0,l.did,0));

		self.compID_in.original_state	:=if(new_core,'',l.compID_in.original_state);
		self.compID_in.Original_CID_ADL	:=if(new_core,'',l.compID_in.Original_CID_ADL);

		self.compID_in.last_name		:=if(r.did>0,r.lname,l.compID_in.last_name);
		self.compID_in.first_name		:=if(r.did>0,r.fname,l.compID_in.first_name);
		self.compID_in.middle_name		:=if(r.did>0,r.mname,l.compID_in.middle_name);
		self.compID_in.Suffix			:=if(r.did>0,r.name_suffix,l.compID_in.Suffix);
		self.compID_in.dob				:=if(r.did>0,(string8)r.dob[3..8],l.compID_in.dob);
		self.compID_in.ssn				:=if(r.did>0,r.ssn,l.compID_in.ssn);
		self.compID_in.Zip_Code			:=if(r.did>0,r.zip,l.compID_in.Zip_Code);
		self.compID_in.Address_1		:=if(r.did>0,	trim(r.prim_range)
													+' '+trim(r.predir)
													+' '+trim(r.prim_name)
													+' '+trim(r.suffix)
													+' '+trim(r.postdir),l.compID_in.Address_1);
		self.compID_in.Address_2		:=if(r.did>0,	trim(r.unit_desig)
													+' '+trim(r.sec_range),l.compID_in.Address_2);
		self.compID_in.City				:=if(r.did>0,r.city_name,l.compID_in.City);
		self.compID_in.State			:=if(r.did>0,r.st,l.compID_in.State);
		self.compID_in.ZIP4				:=if(r.did>0,r.zip4,l.compID_in.ZIP4);
		self.compID_in.DOD_Ind			:=if(r.did>0,if(r.DOD<>'','Y',''),l.compID_in.DOD_Ind);
		self.compID_in.DOD				:=if(r.did>0,r.DOD[3..6],l.compID_in.DOD);
		self.compID_in.cr				:='\n';
		self.compid_in					:=l.compid_in;
		self.ind						:=if(r.did>0,r.ind,'');
		self:=l;
	end;

	with_wdog :=join(distribute(did_out(did>0),hash(did)),distribute(wdog_with_ind,hash(did))
					,left.did=right.did
					,tr_wdog(left,right)
					,local):persist('~thor_data400::persist::compid::wdog1');

	r tr_dl(with_wdog l,File_Dl r) :=transform
		self.compID_in.Gender					:=r.sex_flag;
		self.compID_in.License_Number			:=r.dl_number;
		self.compID_in.License_Type				:=r.license_type;
		type_desc	:=codes.DRIVERS_LICENSE.LICENSE_TYPE(trim(r.state),trim(r.license_type));
		class_desc	:=codes.DRIVERS_LICENSE.LICENSE_TYPE(trim(r.state),trim(r.license_class));
		self.compID_in.Commercial_Drivers_License_Indicator	:=
			if(	stringlib.stringfind(stringlib.stringtouppercase(type_desc+class_desc),'COMMER',1)>0
			and stringlib.stringfind(stringlib.stringtouppercase(type_desc+class_desc),'NON-COMMER',1)=0
			,'Y','');
		self.compID_in.License_Restrictions		:=r.restrictions;
		self.compID_in.License_State			:=r.state;
		self.compID_in.License_Issue_Date		:=r.lic_issue_date[3..8];
		self.compID_in.License_Expiration_Date	:=r.expiration_date[3..8];
		self.compid_in		:=l.compid_in;
		self:=l;
	end;

	// append DL
	out0 := join(distribute(with_wdog(did>0),hash(did)),File_Dl
					,left.did=right.did
					,tr_dl(left,right)
					,left outer
					,local)
	:persist('~thor_data400::persist::compid::out01');

	compID_out:=project(out0(did>0,trim(compid_in.state)<>'')
								,transform({Layout_compID_out}
										,self.NEW_CID_ADL:=intformat(left.did,16,0)
										,self.adl_stability_flag:=''
										,self:=left.compid_in));

	compID_out1:=compID_out:persist('~thor_data400::persist::compid_best');

	return if(DoPersist,compID_out1,compID_out);
end;