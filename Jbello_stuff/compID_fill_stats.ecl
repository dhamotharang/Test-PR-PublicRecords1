/* 
///////////////////////////////////	GET LICENSES FROM DL
   dl0:=table(DriversV2.File_Dl,{
   				did
   				,qstring24 dln:=trim(dl_number)
   				,qstring24 odln:=trim(old_dl_number)
   				,qstring24 oodln:=trim(oos_previous_dl_number)
   				,qstring2 oost:=trim(oos_previous_st)
   				,st
   				})	:persist('~thor_data400::persist::jbello_dl');
   
   dl1:=normalize(dl0,3,transform(
   							{dl0.did
   							,dl0.dln
   							,dl0.st}
   								,self.did:=left.did
   								,self.dln:=choose(counter,left.dln,left.odln,left.oodln)
   								,self.st:=choose(counter,left.st,left.st,left.oost)
   							));
   
   dl:=dedup(sort(distribute(dl1(dln<>''),hash(did)),did,local),did,all,local)
   						:persist('~thor_data400::persist::jbello_dln');
   ///////////////////////////////////  GET LICENSES FROM VEHICLE
   d:=VehicleV2.File_Vehicles;
   d0:=table(d		,{own_1_did
   				,OWN_1_DRIVER_LICENSE_NUMBER
   				,OWN_1_DOB
   				,OWN_1_SEX
   				,own_2_did
   				,OWN_2_DRIVER_LICENSE_NUMBER
   				,OWN_2_DOB
   				,OWN_2_SEX
   				,reg_1_did
   				,REG_1_DRIVER_LICENSE_NUMBER
   				,REG_1_DOB
   				,REG_1_SEX
   				,reg_2_did
   				,REG_2_DRIVER_LICENSE_NUMBER
   				,REG_2_DOB
   				,REG_2_SEX});
   
   d1:=normalize(d0,4,transform(
   						{did:=d0.own_1_did
   						,vdl:=d0.OWN_1_DRIVER_LICENSE_NUMBER
   						,dob:=d0.OWN_1_DOB
   						,sex:=d0.OWN_1_SEX}
   							,self.did:=choose(counter,left.own_1_did,left.own_2_did,left.reg_1_did,left.reg_2_did)
   							,self.vdl:=choose(counter,left.OWN_1_DRIVER_LICENSE_NUMBER,left.OWN_2_DRIVER_LICENSE_NUMBER,left.REG_1_DRIVER_LICENSE_NUMBER,left.REG_2_DRIVER_LICENSE_NUMBER)
   							,self.dob:=choose(counter,left.OWN_1_DOB,left.OWN_2_DOB,left.REG_1_DOB,left.REG_2_DOB)
   							,self.sex:=choose(counter,left.OWN_1_SEX,left.OWN_2_SEX,left.REG_1_SEX,left.REG_2_SEX)
   						));
   
   d2:=dedup(sort(distribute(d1(trim(did)<>'',trim(vdl)<>''),hash(did)),did,-vdl,local),did,all,local)
   						:persist('~thor_data400::persist::jbello_vdln');
   
   /////////////////////////////////// CLEAN AND LINK ID INPUTS
   // Code	 Code Description
   // A		 NCOA 
   // C		 CLUE 
   // D		 DMV DRIVER - keep
   // E		 ECMD
   // M		 MVR HISTORY 
   // S		 SNDX EQUIFAX
   // T		 TRANS UNION  - keep
   // X		 EXPERIAN  - keep
   
   rIndividualIn :=  record
   	 string	CPS_SIG_IND
   	,string	CPS_LOAD_DTTM
   	,string	CPS_VENDOR_CD
   	,string	CPS_CLOAK
   	,string	LAST_UPDATE_DTE
   	,string	NAME_LAST
   	,string	NAME_FIRST
   	,string	NAME_MID
   	,string	NAME_SUFFIX
   	,string	GENDER_CD
   	,string	BIRTH_DTE
   	,string	SSN
   	,string	DL_NUM
   	,string	DL_EXPIRE_DTE
   	,string	DL_ISSUE_DTE
   	,string	DL_LIC_TYPE_CD
   	,string	DL_RESTRICT_DESC
   	,string	DL_COMMERCIAL_IND_CD
   	,string	DL_LIC_STATE_ABBR
   	,string	CLN_LAST_UPDATE_DTE
   	,string	CLN_BIRTH_DTE
   	,string	CLN_DL_EXPIRE_DTE
   	,string	CLN_DL_ISSUE_DTE
   	,string	CLN_SSN
   	,string	CLN_DL_NUM
   	,string	CPS_DL_LIC_STATE_CD
   	,string	CPS_GEND_CD
   	,string	CPS_GENR_CD
   	,string	MATRIX_NAME_CD
   	,string	MATRIX_LIC_CD
   	,string	MATRIX_SSN_CD
   	,string	MATRIX_DOB_CD
   	,string	MATRIX_SEX_CD
     end;
   
   rAddressIn :=  record
   	 string	CPS_SIG_ADDR
   	,string	CPS_SIG_IND
   	,string	CPS_LOAD_DTTM
   	,string	CPS_ADDR_TYPE_CD
   	,string	ADDR_DTE
   	,string	ADDR_HOUSE_NUM
   	,string	ADDR_PRE_DIR
   	,string	ADDR_STREET_NAME
   	,string	ADDR_SUFFIX
   	,string	ADDR_POST_DIR
   	,string	ADDR_APT_NUM
   	,string	ADDR_CITY
   	,string	ADDR_STATE
   	,string	ADDR_POSTAL_CODE
   	,string	CLN_ADDR_DTE
   	,string	MATRIX_ADDR_CD
     end;
   
   lKeepSourcesRegEx		:=	'[D|T|X]';
   
   dIndividualCurrentRaw	:=	dataset('~thor400_88::in::compid::20090526::individual::current',rIndividualIn,csv(separator('|'),maxlength(4096)));
   dIndividualHistoryRaw	:=	dataset('~thor400_88::in::compid::20090526::individual::History',rIndividualIn,csv(separator('|'),maxlength(4096)));
   dAddressCurrentRaw		:=	dataset('~thor400_88::in::compid::20090526::Address::current',rAddressIn,csv(separator('|'),maxlength(4096)));
   dAddressHistoryRaw		:=	dataset('~thor400_88::in::compid::20090526::Address::History',rAddressIn,csv(separator('|'),maxlength(4096)));
   
   dIndividual_			:=	(dIndividualCurrentRaw + dIndividualHistoryRaw)(lib_stringlib.stringlib.stringfilterout(MATRIX_NAME_CD+MATRIX_LIC_CD+MATRIX_SSN_CD+MATRIX_DOB_CD+MATRIX_SEX_CD,'ACDEMNSTX ') = '');
   dAddress_				:=	(dAddressCurrentRaw + dAddressHistoryRaw)(lib_stringlib.stringlib.stringfilterout(MATRIX_ADDR_CD,'ACDEMNSTX ') = '');
   dIndividual	:=dedup(sort(distribute(dIndividual_,hash(CPS_SIG_IND)),record,local),all,local);
   dAddress	:=dedup(sort(distribute(dAddress_,hash(CPS_SIG_IND)),record,local),all,local);
   
   orig_slim := record
   	String32 key
   	,string28 Last_Name
   	,string20 First_Name
   	,string15 Middle_Name
   	,string3 Sffx
   	,string8 DOB
   	,string9 SSN
   	,string1 Gender
   	,string2 rec_type
   	,string55 Address
   	,string20 City
   	,string2 State
   	,string5 Zip
   	,string20 License_Number
   	,string10 License_Type
   	,string1 Commercial_Drivers_License_Indicator
   	,string15 License_Restrictions
   	,string2 License_State
   	,string6 License_Issue_Date
   	,string6 License_Expiration_Date
   	,String8 mx_name
   	,String8 mx_lic
   	,String8 mx_ssn
   	,String8 mx_dob
   	,String8 mx_sex
   	,String8 mx_addr
   end;
   
   base := record
   	unsigned6 did:=0,
   	integer did_score:=0,
   	recordof(orig_slim) orig_slim;
   	string9		clean_ssn;
   	string8		clean_dob;
   	string20	clean_dl;
   	string5		title;
   	string20	fname;
   	string20	mname;
   	string20	lname;
   	string5		suffix;
   	string3		score;
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
   
   base tr(dIndividual l, dAddress r) := TRANSFORM
   	self.orig_slim.key			:=l.CPS_SIG_IND;
   	self.orig_slim.SSN			:=l.CLN_SSN;
   	self.orig_slim.Gender		:=l.GENDER_CD;
   	self.orig_slim.DOB			:=l.CLN_BIRTH_DTE;
   	self.orig_slim.First_Name	:=l.NAME_FIRST;
   	self.orig_slim.Middle_Name	:=l.NAME_MID;
   	self.orig_slim.Last_Name	:=l.NAME_LAST;
   	self.orig_slim.sffx			:=l.NAME_SUFFIX;
   	self.orig_slim.rec_type		:=r.CPS_ADDR_TYPE_CD;
   	self.orig_slim.address		:=		trim(r.ADDR_HOUSE_NUM)
   								+' '+	trim(r.ADDR_PRE_DIR)
   								+' '+	trim(r.ADDR_STREET_NAME)
   								+' '+	trim(r.ADDR_SUFFIX)
   								+' '+	trim(r.ADDR_POST_DIR)
   								+' '+	trim(r.ADDR_APT_NUM);
   	self.orig_slim.City			:=r.ADDR_CITY;
   	self.orig_slim.state		:=r.ADDR_STATE;
   	self.orig_slim.Zip			:=r.ADDR_POSTAL_CODE;
   	self.orig_slim.License_Number						:=l.DL_NUM;
   	self.orig_slim.License_Type							:=l.DL_LIC_TYPE_CD;
   	self.orig_slim.Commercial_Drivers_License_Indicator	:=l.DL_COMMERCIAL_IND_CD;
   	self.orig_slim.License_Restrictions					:=l.DL_RESTRICT_DESC;
   	self.orig_slim.License_State						:=l.DL_LIC_STATE_ABBR;
   	self.orig_slim.License_Issue_Date					:=l.CLN_DL_ISSUE_DTE;
   	self.orig_slim.License_Expiration_Date				:=l.CLN_DL_EXPIRE_DTE;
   	self.orig_slim.mx_name		:=l.MATRIX_NAME_CD;
   	self.orig_slim.mx_lic		:=l.MATRIX_LIC_CD;
   	self.orig_slim.mx_ssn		:=l.MATRIX_SSN_CD;
   	self.orig_slim.mx_dob		:=l.MATRIX_DOB_CD;
   	self.orig_slim.mx_sex		:=l.MATRIX_SEX_CD;
   	self.orig_slim.mx_addr		:=r.MATRIX_ADDR_CD;
   	clean_dob:=if(length(regexreplace('0',trim(l.CLN_BIRTH_DTE),''))=0,'',l.CLN_BIRTH_DTE);
   	self.clean_dob:=regexreplace('[\?]',trim(clean_dob),'0');
   	self.clean_ssn:=if(length(regexreplace('0',trim(l.CLN_SSN),''))=0,'',trim(l.CLN_SSN));
   	self.clean_dl:=if(length(regexreplace('0',trim(l.CLN_DL_NUM),''))=0,'',trim(l.DL_NUM));
   
   	self						:=[];
   end;
   
   j:=join(distribute(dIndividual,hash(CPS_SIG_IND)),distribute(dAddress,hash(CPS_SIG_IND))
   						,left.CPS_SIG_IND=right.CPS_SIG_IND
   						,tr(left,right)
   						,left outer
   						,local):persist('~thor_data400::persist::compid_preped_jbello');
   
   ds_in:=distribute(j,hash(
   						 trim((qstring)(orig_slim.Address),all)
   						,trim((qstring)(orig_slim.City+orig_slim.State+orig_slim.Zip),all)
   								));
   
   base tr_addr_clean0( ds_in l,compid.cache_addresses r ) :=transform
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
   	self.orig_slim		:=l.orig_slim;
   	self				:=l;
   end;
   
   ds_in1:=join(ds_in,compID.cache_addresses
   			,	trim((qstring)(left.orig_slim.address),all)		=trim(right.addr1,all)
   			and	trim((qstring)(left.orig_slim.City+left.orig_slim.State+left.orig_slim.Zip),all)	=trim(right.addr2,all)
   				,tr_addr_clean0(left,right)
   				,local);
   
   base tr_addr_clean( ds_in l) :=transform
   	string182 caddr		:=	AddrCleanLib.CleanAddress182(l.orig_slim.Address
   										,l.orig_slim.City+' '+l.orig_slim.State+' '+l.orig_slim.Zip);
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
   	self.orig_slim		:=l.orig_slim;
   	self				:=l;
   end;
   
   ds_in2:=join(ds_in,compID.cache_addresses
   			,	trim((qstring)(left.orig_slim.Address),all)		=trim(right.addr1,all)
   			and	trim((qstring)(left.orig_slim.City+left.orig_slim.State+left.orig_slim.Zip),all)	=trim(right.addr2,all)
   				,tr_addr_clean(left)
   				,left only
   				,local) + ds_in1;
   
   base tr_name( ds_in2 l) :=transform
   	name				:=	l.orig_slim.Last_Name+' '+l.orig_slim.First_Name+' '+l.orig_slim.Middle_Name;
   	string73 cname		:=	if(trim(name)<>'',addrcleanlib.cleanpersonlfm73(stringlib.stringcleanspaces(name)),'');
   	self.title     		:= cname[ 1.. 5];
   	self.fname   		:= cname[ 6..25];
   	self.mname			:= cname[26..45];
   	self.lname 			:= cname[46..65];
   	self.suffix			:= if(l.Suffix<>'',l.Suffix,cname[66..70]);
   	self.score 			:= cname[71..73];
   
   	self.orig_slim		:=l.orig_slim;
   	self				:=	l;
   end;
   
   ds_clean	:=	project(ds_in2,tr_name(left))
   :persist('~thor_data400::persist::compid::ds_clean');
   
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
   					,base
   					,true
   					,DID_Score
   					,75
   					,did_out0);
   
   did_out:=dedup(sort(distribute(did_out0,hash(did)),record,local),all,local)
   :persist('~thor_data400::persist::compid::did_out');
   
   ///////////////////////////////////  SLIM DOWN INPUT / CREATE CID MATRIX
   orig_slim := record
   	String32 key
   	,string28 Last_Name
   	,string20 First_Name
   	,string15 Middle_Name
   	,string3 Sffx
   	,string8 DOB
   	,string9 SSN
   	,string1 Gender
   	,string2 rec_type
   	,string55 Address
   	,string20 City
   	,string2 State
   	,string5 Zip
   	,string20 License_Number
   	,string10 License_Type
   	,string1 Commercial_Drivers_License_Indicator
   	,string15 License_Restrictions
   	,string2 License_State
   	,string6 License_Issue_Date
   	,string6 License_Expiration_Date
   	,String8 mx_name
   	,String8 mx_lic
   	,String8 mx_ssn
   	,String8 mx_dob
   	,String8 mx_sex
   	,String8 mx_addr
   end;
   
   base := record
   	unsigned6 did:=0,
   	integer did_score:=0,
   	recordof(orig_slim) orig_slim;
   	string9		clean_ssn;
   	string8		clean_dob;
   	string20	clean_dl;
   	string5		title;
   	string20	fname;
   	string20	mname;
   	string20	lname;
   	string5		suffix;
   	string3		score;
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
   
   d:=dataset('~thor_data400::persist::compid::did_out',base,flat);
   
   did_mx :=  record
   	unsigned6	did,
   	String32	key,
   	string2		rec_type,
   	boolean		Populated_Name;
   	boolean		Populated_Lic;
   	boolean		Populated_SSN;
   	boolean		Populated_DOB;
   	boolean		Populated_Sex;
   	boolean		MatrixBlank_Name;
   	boolean		MatrixBlank_Lic;
   	boolean		MatrixBlank_SSN;
   	boolean		MatrixBlank_DOB;
   	boolean		MatrixBlank_Sex;
   	boolean		MatrixKeep_Name;
   	boolean		MatrixKeep_Lic;
   	boolean		MatrixKeep_SSN;
   	boolean		MatrixKeep_DOB;
   	boolean		MatrixKeep_Sex;
   	boolean 	MatrixBlank;
   	boolean 	MatrixKeep;
     end;
   
   lKeepSourcesRegEx		:=	'[D|T|X]';
   
   did_mx	tr1(d l) :=  transform
   	self.Populated_Name		:=	l.lname + l.fname + l.mname + l.suffix <> '';
   	self.Populated_Lic		:=	l.clean_dl <> '';
   	self.Populated_SSN		:=	(unsigned8)l.clean_SSN <> 0;
   	self.Populated_DOB		:=	(unsigned8)l.clean_dob <> 0;
   	self.Populated_Sex		:=	l.orig_slim.mx_sex in ['M','F'];
   	self.MatrixBlank_Name	:=	l.orig_slim.mx_name = '';
   	self.MatrixBlank_Lic	:=	l.orig_slim.mx_lic = '';
   	self.MatrixBlank_SSN	:=	l.orig_slim.mx_ssn = '';
   	self.MatrixBlank_DOB	:=	l.orig_slim.mx_dob = '';
   	self.MatrixBlank_Sex	:=	l.orig_slim.mx_sex = '';
   	self.MatrixKeep_Name	:=	regexfind(lKeepSourcesRegEx,l.orig_slim.mx_name);
   	self.MatrixKeep_Lic		:=	regexfind(lKeepSourcesRegEx,l.orig_slim.mx_lic);
   	self.MatrixKeep_SSN		:=	regexfind(lKeepSourcesRegEx,l.orig_slim.mx_ssn);
   	self.MatrixKeep_DOB		:=	regexfind(lKeepSourcesRegEx,l.orig_slim.mx_dob);
   	self.MatrixKeep_Sex		:=	regexfind(lKeepSourcesRegEx,l.orig_slim.mx_sex);
   
   	self.MatrixBlank		:=	l.orig_slim.mx_addr = '';
   	self.MatrixKeep			:=	regexfind(lKeepSourcesRegEx,l.orig_slim.mx_addr);
   	self.rec_type			:=	l.orig_slim.rec_type;
   	self.key				:=	l.orig_slim.key;
   	self					:=	l;
     end;
   
   d1	:=	project(d(did>0),tr1(left)):persist('~thor_data400::persist:did_mx_cache');
*/

///////////////////////////////////  APPEND DL/VEH LICENSES TO HEADER AND FLAG ALL SOURCES

hdr0 := table(header.file_headers,{did
									,src
									,ssn
									,dob
									,title
									,fname
									,mname
									,lname
									,name_suffix
									,prim_range
									,prim_name
									,sec_range
									,city_name
									,zip
									,dt_nonglb_last_seen
									,dt_first_seen});

r0:={ unsigned integer6 did, qstring24 dln, qstring2 st };
dl:=dataset(ut.foreign_dataland+'~thor_data400::persist::jbello_dln',r0,flat);
hdr1:=join(distribute(hdr0,hash(did)),distribute(dl,hash(did))
		,	left.did=right.did
		and	mdr.sourcetools.sourceisdl(left.src)
		,transform({hdr0
					,dl.dln}
						,self:=left
						,self:=right)
		,left outer
		,local);

r1:={  string12 did,  string13 vdl,  string8 dob,  string1 sex};
vdl:=dataset('~thor_data400::persist::jbello_vdln',r1,flat);
hdr:=join(distribute(hdr1,hash(did)),distribute(vdl,hash((unsigned6)did))
		,	left.did=(unsigned6)right.did
		and	mdr.sourcetools.sourceisvehicle(left.src)
		,transform({hdr1
					,vdl.vdl
					,dob2:=vdl.dob}
						,self:=left
						,self.dob2:=right.dob
						,self:=right)
		,left outer
		,local);

r2 := record
 unsigned6 did;
 string2  src;
 string9  ssn;
 string24  dl;
 string8  dob;
 string2  title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string10  prim_range;
 string28  prim_name;
 string8   sec_range;
 string25   city_name;
 string5   zip;
 string6   in_eq;
 string6   in_en;
 string6   in_wp;
 string6   in_util;
 string6   in_ts;
 string6   in_veh;
 string6   in_prop;
 string6   in_dl;
 string6   in_other;
 string6   only_glb;
end;

// N =name
// L =Lic
// S =SSN
// D =DOB
// A =Addr
// G =Gender
whats_in_it(hdr l) := function
	_N:=if(l.fname<>'','N',' ');
	_L:=if(l.dln<>'' or l.vdl<>'','L',' ');
	_S:=if(l.ssn<>'','S',' ');
	_D:=if(l.dob>0,'D',' ');
	_A:=if(l.zip<>'' or l.city_name<>'','A',' ');
	_G:=if(l.title<>'','G',' ');
	return _N+_L+_S+_D+_A+_G;
end;

r2 t0(hdr le) := transform
	self.in_eq    := if(le.src='EQ',			whats_in_it(le),'');
	self.in_en    := if(le.src='EN',			whats_in_it(le),'');
	self.in_wp    := if(le.src='WP',			whats_in_it(le),'');
	self.in_util  := if(le.src in ['UT','UW'],	whats_in_it(le),'');
	self.in_ts    := if(le.src='TS',			whats_in_it(le),'');
	self.in_veh   := if(mdr.sourcetools.sourceisvehicle(le.src),whats_in_it(le),'');
	self.in_prop  := if(mdr.sourcetools.sourceisproperty(le.src),whats_in_it(le),'');
	self.in_dl    := if(mdr.sourcetools.sourceisdl(le.src),whats_in_it(le),'');
	self.in_other := if(le.src not in ['EQ','EN','WP','UT','UW','TS']
					and ~mdr.sourcetools.sourceisvehicle(le.src)
					and ~mdr.sourcetools.sourceisproperty(le.src)
					and ~mdr.sourcetools.sourceisdl(le.src)
					,whats_in_it(le),'');

	self.only_glb   := if(mdr.sourcetools.sourceisglb(le.src) and ~(header.isPreGLB(le))
					,whats_in_it(le),'');
	self.dl         := map(	mdr.sourcetools.sourceisvehicle(le.src)=>le.vdl
						,mdr.sourcetools.sourceisdl(le.src)=>le.dln
						,'');
	self.dob        := map(	mdr.sourcetools.sourceisdl(le.src)=>le.dob2
							,(string)le.dob);
	self            := le;
end;
// only_glb is overloaded:
	// 1)	at this point it flags whether the record is glb and what data elements are populated
	// 2)	after the final rollup it flags which data element in the link id
		// appear in glb records only
p1 := project(hdr,t0(left));
p1_dist := distribute(p1,hash(did)):persist('~thor_data400:::header::cache_pre_roll');
s:=[4666668
,4667068
,12750033
,13836685
,44143871
,44744025
,52690913
,54121196
,62691784
,67085364
,71699437
,81254702
,96265445
,109779411
];
output(p1_dist(did in s));
// output(p1_dist);

r2 roll_glb_N(r2 l,r2 r) := transform
	_N:=if(	l.fname+l.mname+l.lname+l.name_suffix<>
			r.fname+r.mname+r.lname+l.name_suffix,r.only_glb[1]
			,if(trim(l.only_glb[1])='',l.only_glb[1],r.only_glb[1]));
	_L:=r.only_glb[2];
	_S:=r.only_glb[3];
	_D:=r.only_glb[4];
	_A:=r.only_glb[5];
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_L(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=if(	l.dl<>r.dl,r.only_glb[2]
		,if(trim(l.only_glb[2])='',l.only_glb[2],r.only_glb[2]));
	_S:=r.only_glb[3];
	_D:=r.only_glb[4];
	_A:=r.only_glb[5];
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_S(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=r.only_glb[2];
	_S:=if(	l.ssn<>r.ssn,r.only_glb[3]
			,if(trim(l.only_glb[3])='',l.only_glb[3],r.only_glb[3]));
	_D:=r.only_glb[4];
	_A:=r.only_glb[5];
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_D(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=r.only_glb[2];
	_S:=r.only_glb[3];
	_D:=if(	l.dob<>r.dob,r.only_glb[4]
			,if(trim(l.only_glb[4])='',l.only_glb[4],r.only_glb[4]));
	_A:=r.only_glb[5];
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_A(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=r.only_glb[2];
	_S:=r.only_glb[3];
	_D:=r.only_glb[4];
	_A:=if(	l.prim_range+l.prim_name+l.sec_range+l.zip<>
			r.prim_range+r.prim_name+r.sec_range+r.zip,r.only_glb[5]
				,if(trim(l.only_glb[5])='',l.only_glb[5],r.only_glb[5]));
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_G(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=r.only_glb[2];
	_S:=r.only_glb[3];
	_D:=r.only_glb[4];
	_A:=r.only_glb[5];
	_G:=if(	l.title<>r.title,r.only_glb[6]
			,if(trim(l.only_glb[6])='',l.only_glb[6],r.only_glb[6]));
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;

rollem(string6 l,string6 r) := function
	_N:=if(trim(l[1])='',r[1],l[1]);
	_L:=if(trim(l[2])='',r[2],l[2]);
	_S:=if(trim(l[3])='',r[3],l[3]);
	_D:=if(trim(l[4])='',r[4],l[4]);
	_A:=if(trim(l[5])='',r[5],l[5]);
	_G:=if(trim(l[6])='',r[6],l[6]);
	return _N+_L+_S+_D+_A+_G;
end;

roll_glb(string6 l,string6 r) := function
	_N:=if(trim(l[1])='',l[1],r[1]);
	_L:=if(trim(l[2])='',l[2],r[2]);
	_S:=if(trim(l[3])='',l[3],r[3]);
	_D:=if(trim(l[4])='',l[4],r[4]);
	_A:=if(trim(l[5])='',l[5],r[5]);
	_G:=if(trim(l[6])='',l[6],r[6]);
	return _N+_L+_S+_D+_A+_G;
end;

r2 t1(r2 le, r2 ri) := transform
	self.in_eq    := if(trim(le.in_eq)=''	, ri.in_eq,		rollem(le.in_eq,ri.in_eq));
	self.in_en    := if(trim(le.in_en)=''	, ri.in_en,		rollem(le.in_en,ri.in_en));
	self.in_wp    := if(trim(le.in_wp)=''	, ri.in_wp,		rollem(le.in_wp,ri.in_wp));
	self.in_util  := if(trim(le.in_util)=''	, ri.in_util,	rollem(le.in_util,ri.in_util));
	self.in_ts    := if(trim(le.in_ts)=''	, ri.in_ts,		rollem(le.in_ts,ri.in_ts));
	self.in_veh   := if(trim(le.in_veh)=''	, ri.in_veh,	rollem(le.in_veh,ri.in_veh));
	self.in_prop  := if(trim(le.in_prop)=''	, ri.in_prop,	rollem(le.in_prop,ri.in_prop));
	self.in_dl    := if(trim(le.in_dl)=''	, ri.in_dl,		rollem(le.in_dl,ri.in_dl));
	self.in_other := if(trim(le.in_other)='', ri.in_other,	rollem(le.in_other,ri.in_other));
	self.only_glb := if(trim(le.only_glb)='', ri.only_glb,	roll_glb(le.only_glb,ri.only_glb));
	self          := le;
end;

p1g:= group(sort(p1_dist,did,local),did,local);
i1 := iterate(sort(p1g,fname,mname,lname,name_suffix,-only_glb),roll_glb_N(left,right));
i2 := iterate(sort(i1,prim_range,prim_name,sec_range,zip,-only_glb),roll_glb_A(left,right));
i3 := iterate(sort(i2,dl,-only_glb),roll_glb_L(left,right));
i4 := iterate(sort(i3,dob,-only_glb),roll_glb_D(left,right));
i5 := iterate(sort(i4,title,-only_glb),roll_glb_G(left,right));
i6 := rollup(sort(i5,-only_glb),left.did=right.did,t1(left,right)):persist('~thor_data400::persist:header::cache');

output(i6(	only_glb[1] in ['N',' ']
			,only_glb[2]=' '
			,only_glb[3] in ['S',' ']
			,only_glb[4]='D'
			,only_glb[5] in ['A',' ']
			,only_glb[6]=' '
			),all);
// output(i6);

///////////////////////////////////  JOION FLAGED HEADER TO COMPID
cid_mx :=  record
	unsigned6	did,
	String32	key,
	string2		rec_type,
	boolean		Populated_Name;
	boolean		Populated_Lic;
	boolean		Populated_SSN;
	boolean		Populated_DOB;
	boolean		Populated_Sex;
	boolean		MatrixBlank_Name;
	boolean		MatrixBlank_Lic;
	boolean		MatrixBlank_SSN;
	boolean		MatrixBlank_DOB;
	boolean		MatrixBlank_Sex;
	boolean		MatrixKeep_Name;
	boolean		MatrixKeep_Lic;
	boolean		MatrixKeep_SSN;
	boolean		MatrixKeep_DOB;
	boolean		MatrixKeep_Sex;
	boolean 	MatrixBlank;
	boolean 	MatrixKeep;
end;
cidmx:=dataset(ut.foreign_dataland+'~thor_data400::persist:did_mx_cache',cid_mx,flat);

outr:=record
	unsigned6	did
	,String32	key
	,string2	rec_type
	,recordof(cid_mx)	-[did,key,rec_type]	compid
	,recordof(i6)		-[did]				header
end;

j1:=join(distribute(cidmx,hash(did)), distribute(i6,hash(did))
						,left.did=right.did
						,transform(outr
									,self.compid:=left
									,self.header:=right
									,self:=left)
						,left outer
						,local);

d:=sort(j1,did,key,rec_type,local):persist('~thor_data400::persist:did_mx_table');

output(choosen(d,100));

///////////////////////////////////  PRODUCE STATS

stats:=table(d,{
			MatrixDrop_Name		:=sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_eq_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_eq,'N',1)>0 ,1,0))
			,name_fill_eq_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_eq,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_en_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_en,'N',1)>0,1,0))
			,name_fill_en_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_en,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_wp_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_wp,'N',1)>0,1,0))
			,name_fill_wp_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_wp,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_ut_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_util,'N',1)>0,1,0))
			,name_fill_ut_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_util,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_ts_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_ts,'N',1)>0,1,0))
			,name_fill_ts_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_ts,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_vh_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_veh,'N',1)>0,1,0))
			,name_fill_vh_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_veh,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_pr_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_prop,'N',1)>0,1,0))
			,name_fill_pr_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_prop,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_dl_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_dl,'N',1)>0,1,0))
			,name_fill_dl_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_dl,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_ot_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_other,'N',1)>0,1,0))
			,name_fill_ot_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.in_other,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))
			,name_fill_og_cnt	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.only_glb,'N',1)>0,1,0))
			,name_fill_og_pct	:=sum(group,if(~compid.MatrixKeep_Name and stringlib.stringfind(header.only_glb,'N',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Name,1,0))

			,MatrixDrop_Lic		:=sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_eq_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_eq,'L',1)>0,1,0))
			,Lic_fill_eq_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_eq,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_en_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_en,'L',1)>0,1,0))
			,Lic_fill_en_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_en,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_wp_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_wp,'L',1)>0,1,0))
			,Lic_fill_wp_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_wp,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_ut_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_util,'L',1)>0,1,0))
			,Lic_fill_ut_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_util,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_ts_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_ts,'L',1)>0,1,0))
			,Lic_fill_ts_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_ts,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_vh_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_veh,'L',1)>0,1,0))
			,Lic_fill_vh_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_veh,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_pr_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_prop,'L',1)>0,1,0))
			,Lic_fill_pr_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_prop,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_dl_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_dl,'L',1)>0,1,0))
			,Lic_fill_dl_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_dl,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_ot_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_other,'L',1)>0,1,0))
			,Lic_fill_ot_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.in_other,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))
			,Lic_fill_og_cnt	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.only_glb,'L',1)>0,1,0))
			,Lic_fill_og_pct	:=sum(group,if(~compid.MatrixKeep_Lic and stringlib.stringfind(header.only_glb,'L',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Lic,1,0))

			,MatrixDrop_SSN		:=sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_eq_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_eq,'S',1)>0,1,0))
			,SSN_fill_eq_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_eq,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_en_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_en,'S',1)>0,1,0))
			,SSN_fill_en_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_en,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_wp_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_wp,'S',1)>0,1,0))
			,SSN_fill_wp_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_wp,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_ut_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_util,'S',1)>0,1,0))
			,SSN_fill_ut_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_util,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_ts_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_ts,'S',1)>0,1,0))
			,SSN_fill_ts_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_ts,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_vh_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_veh,'S',1)>0,1,0))
			,SSN_fill_vh_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_veh,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_pr_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_prop,'S',1)>0,1,0))
			,SSN_fill_pr_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_prop,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_dl_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_dl,'S',1)>0,1,0))
			,SSN_fill_dl_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_dl,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_ot_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_other,'S',1)>0,1,0))
			,SSN_fill_ot_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.in_other,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))
			,SSN_fill_og_cnt	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.only_glb,'S',1)>0,1,0))
			,SSN_fill_og_pct	:=sum(group,if(~compid.MatrixKeep_SSN and stringlib.stringfind(header.only_glb,'S',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_SSN,1,0))

			,MatrixDrop_DOB		:=sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_eq_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_eq,'D',1)>0,1,0))
			,DOB_fill_eq_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_eq,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_en_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_en,'D',1)>0,1,0))
			,DOB_fill_en_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_en,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_wp_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_wp,'D',1)>0,1,0))
			,DOB_fill_wp_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_wp,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_ut_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_util,'D',1)>0,1,0))
			,DOB_fill_ut_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_util,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_ts_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_ts,'D',1)>0,1,0))
			,DOB_fill_ts_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_ts,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_vh_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_veh,'D',1)>0,1,0))
			,DOB_fill_vh_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_veh,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_pr_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_prop,'D',1)>0,1,0))
			,DOB_fill_pr_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_prop,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_dl_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_dl,'D',1)>0,1,0))
			,DOB_fill_dl_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_dl,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_ot_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_other,'D',1)>0,1,0))
			,DOB_fill_ot_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.in_other,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))
			,DOB_fill_og_cnt	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.only_glb,'D',1)>0,1,0))
			,DOB_fill_og_pct	:=sum(group,if(~compid.MatrixKeep_DOB and stringlib.stringfind(header.only_glb,'D',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_DOB,1,0))

			,MatrixDrop_Sex		:=sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_eq_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_eq,'G',1)>0,1,0))
			,Sex_fill_eq_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_eq,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_en_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_en,'G',1)>0,1,0))
			,Sex_fill_en_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_en,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_wp_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_wp,'G',1)>0,1,0))
			,Sex_fill_wp_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_wp,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_ut_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_util,'G',1)>0,1,0))
			,Sex_fill_ut_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_util,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_ts_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_ts,'G',1)>0,1,0))
			,Sex_fill_ts_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_ts,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_vh_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_veh,'G',1)>0,1,0))
			,Sex_fill_vh_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_veh,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_pr_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_prop,'G',1)>0,1,0))
			,Sex_fill_pr_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_prop,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_dl_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_dl,'G',1)>0,1,0))
			,Sex_fill_dl_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_dl,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_ot_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_other,'G',1)>0,1,0))
			,Sex_fill_ot_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.in_other,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))
			,Sex_fill_og_cnt	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.only_glb,'G',1)>0,1,0))
			,Sex_fill_og_pct	:=sum(group,if(~compid.MatrixKeep_Sex and stringlib.stringfind(header.only_glb,'G',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep_Sex,1,0))

			,MatrixDropAddr		:=sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_eq_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_eq,'A',1)>0,1,0))
			,Addr_fill_eq_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_eq,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_en_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_en,'A',1)>0,1,0))
			,Addr_fill_en_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_en,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_wp_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_wp,'A',1)>0,1,0))
			,Addr_fill_wp_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_wp,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_ut_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_util,'A',1)>0,1,0))
			,Addr_fill_ut_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_util,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_ts_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_ts,'A',1)>0,1,0))
			,Addr_fill_ts_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_ts,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_vh_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_veh,'A',1)>0,1,0))
			,Addr_fill_vh_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_veh,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_pr_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_prop,'A',1)>0,1,0))
			,Addr_fill_pr_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_prop,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_dl_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_dl,'A',1)>0,1,0))
			,Addr_fill_dl_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_dl,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_ot_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_other,'A',1)>0,1,0))
			,Addr_fill_ot_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.in_other,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			,Addr_fill_og_cnt	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.only_glb,'A',1)>0,1,0))
			,Addr_fill_og_pct	:=sum(group,if(~compid.MatrixKeep and stringlib.stringfind(header.only_glb,'A',1)>0,1,0)) / sum(group,if(~compid.MatrixKeep,1,0))
			},few,local);

output(stats);












