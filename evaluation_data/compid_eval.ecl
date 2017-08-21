import ut, did_add, header_slimsort, didville,watchdog,doxie,header, address;

h:=distribute(header.File_Headers,hash(did));
ds_in0 := project(File_compid,transform({unsigned6 rid:=0,File_compid},self:=left));

//sequence records
ut.MAC_Sequence_Records(ds_in0,rid,ds_in1);
ds_in:=ds_in1 :persist('~thor400_84::persist::jbello_compid_seq');
// ds_in:=dataset(ut.foreign_dataland+'~thor400_84::persist::jbello_compid_seq',{ds_in1},flat);


clean_did_rec:=record
	unsigned6 did:=0,
	integer did_score:=0,

	recordof(ds_in) compid;
	recordof(watchdog.File_Best) watchdog;

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

	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		suffix;
	string3		score;

	string9		DRVR_SOCIAL_SECURITY_NUM;
	string8		dob;
	STRING10	ind := '';
	qSTRING1	rec_tp := '';
	qSTRING1	valid_ssn := '';
	qstring1	eq_best_dob:='';
	qstring1	neq_best_dob:='';
	qstring1	ln_blank_dob:='';
	qstring1	cp_blank_dob:='';

	qstring1	eq_best_ssn:='';
	qstring1	neq_best_ssn:='';
	qstring1	ln_blank_ssn:='';
	qstring1	cp_blank_ssn:='';

	qstring1	eq_best_name:='';
	qstring1	neq_best_name:='';
	qstring1	ln_blank_name:='';
	qstring1	cp_blank_name:='';

	qstring1	eq_best_addr:='';
	qstring1	neq_best_addr:='';
	qstring1	ln_blank_addr:='';
	qstring1	cp_blank_addr:='';

	qstring1	eq_best_dl:='';
	qstring1	neq_best_dl:='';
	qstring1	ln_blank_dl:='';
	qstring1	cp_blank_dl:='';

end;

//normalize imput
clean_did_rec tr_nrm( ds_in l,integer c) :=transform
	self.compid				:=	l;

	name					:=	l.DRVR_LAST_NAME+' '+l.DRVR_FIRST_NAME+' '+l.DRVR_MID_NAME;

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonlfm73(stringlib.stringcleanspaces(name)),'');

	string182 caddr			:=	choose(c
										,if(trim(l.DRVR_CURR_ADDR)<>'',Address.CleanAddress182(l.DRVR_CURR_ADDR+' '+l.DRVR_CURR_APT_NUM,l.DRVR_CURR_CITY_NAME+' '+l.DRVR_CURR_STATE_CODE+' '+l.DRVR_CURR_ZIP_NUM),'')
										,if(trim(l.DRVR_PRIOR_ADDR1)<>'',Address.CleanAddress182(l.DRVR_PRIOR_ADDR1+' '+l.DRVR_PRIOR_APT_NUM1,l.DRVR_PRIOR_CITY_NAME1+' '+l.DRVR_PRIOR_STATE_CODE1+' '+l.DRVR_PRIOR_ZIP_NUM1),'')
										,if(trim(l.DRVR_PRIOR_ADDR2)<>'',Address.CleanAddress182(l.DRVR_PRIOR_ADDR2+' '+l.DRVR_PRIOR_APT_NUM2,l.DRVR_PRIOR_CITY_NAME2+' '+l.DRVR_PRIOR_STATE_CODE2+' '+l.DRVR_PRIOR_ZIP_NUM2),'')
										,if(trim(l.DRVR_PRIOR_ADDR3)<>'',Address.CleanAddress182(l.DRVR_PRIOR_ADDR3+' '+l.DRVR_PRIOR_APT_NUM3,l.DRVR_PRIOR_CITY_NAME3+' '+l.DRVR_PRIOR_STATE_CODE3+' '+l.DRVR_PRIOR_ZIP_NUM3),'')
										);

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

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.suffix			:= if(l.drvr_suf_name<>'',l.drvr_suf_name,cname[66..70]);
	self.score 			:= cname[71..73];

	self.dob:=if(length(regexreplace('0',l.DRVR_BIRTH_YMD_DATE,''))=0,'','19'+l.DRVR_BIRTH_YMD_DATE);
	self.DRVR_SOCIAL_SECURITY_NUM:=if(length(regexreplace('0',l.DRVR_SOCIAL_SECURITY_NUM,''))=0,'',l.DRVR_SOCIAL_SECURITY_NUM);
	self.rec_tp	:=(qstring)c;
end;

ds_nrm0	:=	normalize(ds_in,4,tr_nrm(left,counter),local);
ds_nrm	:=	dedup(sort(distribute(ds_nrm0,hash(compid.rid)),record,local),record,local)
 :persist('~thor400_84::persist::jbello_compid_nrm')
;
// ds_nrm:=dataset(ut.foreign_dataland+'~thor400_84::persist::jbello_compid_nrm',{ds_nrm0},flat);

//did new file
matchset := ['A','D','S','Q'];

did_add.MAC_Match_Flex
	(ds_nrm
	,matchset
	,DRVR_SOCIAL_SECURITY_NUM
	,dob
	,fname
	,mname
	,lname
	,suffix
	,prim_range
	,prim_name
	,sec_range
	,zip5
	,st
	,Phonenum
	,DID
	,clean_did_rec
	,true
	,DID_Score
	,75
	,did_out);

//append watchdog
with_wdog := join(distribute(did_out(did>0),hash(did)),watchdog.file_best
					,left.did=right.did
					,transform({did_out},self.watchdog:=right,self:=left)
					,left outer
					,local
					 ) + did_out(did=0);

//populate compare flags
clean_did_rec tr1(with_wdog l) := TRANSFORM

	ln_name				:=trim(	l.watchdog.lname
								// +l.watchdog.mname
								+l.watchdog.fname
								+l.watchdog.name_suffix);
	cp_name				:=trim(	l.lname
								// +l.mname
								+l.fname
								+l.suffix);

	self.eq_best_name	:=if(cp_name=ln_name and ln_name<>'','Y','');
	self.neq_best_name	:=if(cp_name<>ln_name and ln_name<>'' and cp_name<>'','Y','');
	self.ln_blank_name	:=if(ln_name='','Y','');
	self.cp_blank_name	:=if(cp_name='','Y','');

	self.eq_best_dob	:=if((integer)l.dob=l.watchdog.dob and l.watchdog.dob<>0,'Y','');
	self.neq_best_dob	:=if((integer)l.dob<>l.watchdog.dob and l.watchdog.dob>0 and l.dob<>'','Y','');
	self.ln_blank_dob	:=if(l.watchdog.dob=0,'Y','');
	self.cp_blank_dob	:=if(l.dob='','Y','');

	self.eq_best_ssn	:=if(l.DRVR_SOCIAL_SECURITY_NUM=l.watchdog.ssn	and l.watchdog.ssn<>'','Y','');
	self.neq_best_ssn	:=if(l.DRVR_SOCIAL_SECURITY_NUM<>l.watchdog.ssn and l.watchdog.ssn<>'' and l.DRVR_SOCIAL_SECURITY_NUM<>'','Y','');
	self.ln_blank_ssn	:=if(l.watchdog.ssn='','Y','');
	self.cp_blank_ssn	:=if(l.DRVR_SOCIAL_SECURITY_NUM='','Y','');

	self.eq_best_dl		:=if(l.compid.DRVR_LIC_NUM=l.watchdog.DL_number	and l.watchdog.DL_number<>'','Y','');
	self.neq_best_dl	:=if(l.compid.DRVR_LIC_NUM<>l.watchdog.DL_number and l.watchdog.DL_number<>'' and l.compid.DRVR_LIC_NUM<>'','Y','');
	self.ln_blank_dl	:=if(l.watchdog.DL_number='','Y','');
	self.cp_blank_dl	:=if(l.compid.DRVR_LIC_NUM='','Y','');

	cp_addr			:=trim(l.prim_range+
						// l.predir+ 
						l.prim_name+
						// l.addr_suffix+
						// l.postdir+
						// l.unit_desig+
						l.sec_range+
						// l.v_city_name+
						// l.st+
						l.zip5);
	ln_addr			:=trim(l.watchdog.prim_range+
						// l.watchdog.predir+ 
						l.watchdog.prim_name+
						// l.watchdog.suffix+
						// l.watchdog.postdir+
						// l.watchdog.unit_desig+
						l.watchdog.sec_range+
						// l.watchdog.city_name+
						// l.watchdog.st+
						l.watchdog.zip);

	self.eq_best_addr	:=if(cp_addr=ln_addr and ln_addr<>'','Y','');
	self.neq_best_addr	:=if(cp_addr<>ln_addr and ln_addr<>'' and cp_addr<>'','Y','');
	self.ln_blank_addr	:=if(ln_addr='','Y','');
	self.cp_blank_addr	:=if(cp_addr='','Y','');

	self := l;
END;

field_compare := project(with_wdog,tr1(LEFT));

//appent segment indicator
segmented_h := distribute(Header.fn_ADLSegmentation(h).core_check,hash(did));
seg_ind := JOIN(distribute(field_compare(did>0),hash(did)),segmented_h
					,	left.did=right.did
					and	right.ind<>''
					,transform({field_compare}
								,self.ind:=right.ind
								,self:=left)
					,left outer
					,keep(1)
					,LOCAL) + field_compare(did=0)
					 :persist('~thor400_84::persist::jbello_compid_seg_ind')
					;

//append valid_ssn flag
ssn_flg := JOIN(distribute(seg_ind(did>0),hash(did)),h
					,	left.did=right.did
					and	right.valid_ssn<>''
					,transform({seg_ind}
								,self.valid_ssn:=right.valid_ssn
								,self:=left)
					,left outer
					,keep(1)
					,LOCAL) + seg_ind(did=0)
					 :persist('~thor400_84::persist::jbello_compid_ssn_flg')
					;
// ssn_flg:=dataset(ut.foreign_dataland+'~thor400_84::persist::jbello_compid_ssn_flg',{w_seg},flat);

//remove blank previous address
recordof(ssn_flg) tr2(ssn_flg l) := transform
	self.rec_tp:=if(
					trim(l.compid.DRVR_PRIOR_ADDR1)='' and l.rec_tp='2'
				or	trim(l.compid.DRVR_PRIOR_ADDR2)='' and l.rec_tp='3'
				or	trim(l.compid.DRVR_PRIOR_ADDR3)='' and l.rec_tp='4'
				,'D'
				,l.rec_tp);
	self:=l;
end;

outfile := project(ssn_flg,tr2(left),local)(rec_tp<>'D');

export compid_eval := output(outfile,,'~thor_data400::out::choicepoint::compid',__compressed__,overwrite);