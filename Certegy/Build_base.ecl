import ut, did_add, header_slimsort, didville,watchdog,doxie,header, lib_stringlib,mdr,address;

export Build_base(string filedate) := function

ds_in:=Certegy.Files.certegy_in;

//slim and clean imput
layouts.base tr_base( ds_in l) :=transform
	self.orig_DL_State:=l.DL_STATE;
	self.orig_DL_Num:=l.DL_NUM;
	self.orig_ssn:=l.ssn;
	self.orig_DL_Issue_Dte:=l.DL_Issue_Dte;
	self.orig_DL_Expire_Dte:=l.DL_Expire_Dte;
	self.orig_Professional_Title:=l.Professional_Title;
	self.orig_Functional_Title:=l.Functional_Title;
	self.orig_House_Bldg_Num:=l.House_Bldg_Num;
	self.orig_Street_Suffix:=l.Street_Suffix;
	self.orig_Apt_Num:=l.Apt_Num;
	self.orig_Unit_Desc:=l.Unit_Desc;
	self.orig_Street_Post_Dir:=l.Street_Post_Dir;
	self.orig_Street_Pre_Dir:=l.Street_Pre_Dir;
	self.orig_State:=l.State;
	self.orig_Zip:=l.Zip;
	self.orig_DOB:=l.dob;
	self.orig_Deceased_Dte:=l.DECEASED_DTE;
	self.orig_Home_Tel_Area:=l.Home_Tel_Area;
	self.orig_Home_Tel_Num:=l.Home_Tel_Num;
	self.orig_Work_Tel_Area:=l.Work_Tel_Area;
	self.orig_Work_Tel_Num:=l.Work_Tel_Num;
	self.orig_Work_Tel_Ext:=l.Work_Tel_Ext;
	self.orig_First_Name:=l.First_Name;
	self.orig_Mid_Name:=l.Mid_Name;
	self.orig_Last_Name:=l.Last_Name;
	self.orig_Street_Name:=l.Street_Name;
	self.orig_City:=l.City;

	name					:=	trim(l.Last_Name)+' '+trim(l.First_Name)+' '+trim(l.Mid_Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonlfm73(stringlib.stringcleanspaces(name)),'');

	addr					:=	trim(l.House_Bldg_Num)+' '+
								trim(l.Street_Pre_Dir)+' '+
								trim(l.Street_Name)+' '+
								trim(l.Street_Suffix)+' '+
								trim(l.Street_Post_Dir)+' '+
								trim(l.Unit_Desc)+' '+
								trim(l.Apt_Num);

	string182 caddr			:=	if(trim(addr)<>'',Address.CleanAddress182(addr,trim(l.City)+' '+
																					trim(l.State)+' '+
																					trim(l.Zip)),'');

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
	self.zip			:= caddr[	117	..	121	];
	self.zip4			:= caddr[	122	..	125	];
	self.cart			:= caddr[	126	..	129	];
	self.cr_sort_sz		:= caddr[	130	..	130	];
	self.lot			:= caddr[	131	..	134	];
	self.lot_order		:= caddr[	135	..	135	];
	self.dbpc			:= caddr[	136	..	137	];
	self.chk_digit		:= caddr[	138	..	138	];
	self.rec_type		:= caddr[	139	..	140	];
	self.fips_county	:= caddr[	141	..	142	];
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
	self.name_suffix	:= if(l.Functional_Title<>'',l.Functional_Title,cname[66..70]);
	self.name_score 	:= cname[71..73];

	clean_dob:=if(l.dob='2099-12-31','',stringlib.stringfindreplace(trim(l.dob),'-',''));
	self.clean_dob:=if(length(stringlib.stringfindreplace(trim(clean_dob),'0',''))=0,'',clean_dob);

	hphone	:= stringlib.stringfindreplace(l.Home_Tel_Area,' ','0') + stringlib.stringfindreplace(l.Home_Tel_Num,' ','0');
	self.clean_hphone:=if(stringlib.stringfindreplace(hphone,'0','')='','',hphone);

	wphone	:= stringlib.stringfindreplace(l.Work_Tel_Area,' ','0') + stringlib.stringfindreplace(l.Work_Tel_Num,' ','0');
	self.clean_wphone:=if(stringlib.stringfindreplace(wphone,'0','')='','',wphone);

	self.clean_ssn:=if(stringlib.stringfindreplace(l.ssn,'0','')='','',l.ssn);

	self.date_first_seen            :='';
	self.date_last_seen             :='';
	self.date_vendor_first_reported :=filedate;
	self.date_vendor_last_reported  :=filedate;
end;

ds_previous := files.certegy_base;

ds_clean0	:=	project(ds_in,tr_base(left),local)
								:persist('~thor400_44::persist::certegy_ds_clean')
								//:persist('~thor400_60::persist::certegy_ds_clean')*/
								//:persist('~thor400_20::persist::certegy_ds_clean')
								;

ds_clean00 := ds_clean0 + ds_previous;

recordof(ds_clean00) t_blank_dates(ds_clean00 le) := transform
 self.date_first_seen            :='';
 self.date_last_seen             :='';
 self                            :=le;
end;

ds_clean := project(ds_clean00,t_blank_dates(left));

//add src
src_rec := record
header_slimsort.Layout_Source;
layouts.base;
end;

DID_Add.Mac_Set_Source_Code(ds_clean, src_rec, 'CY', ds_clean_src)

//did new file
matchset := ['A','D','S','Q'];

did_add.MAC_Match_Flex
	(ds_clean_src
	,matchset
	,clean_ssn
	,clean_dob
	,fname
	,mname
	,lname
	,name_suffix
	,prim_range
	,prim_name
	,sec_range
	,zip
	,st
	,clean_hphone
	,DID
	,src_rec
	,true
	,DID_Score
	,75
	,outfile_src,true,src);

//remove src	
outfile:= project(outfile_src, transform(layouts.base, self := left));
retval := outfile;
return retval;
end;