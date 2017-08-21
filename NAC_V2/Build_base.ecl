import ut, VersionControl,lib_stringlib,lib_fileservices,_control,did_add,_validate, address, NID;
EXPORT Build_base(DATASET(vLoad) f0, string Version) := FUNCTION

//f0:=NAC.Files().Load_in;
//f0 := NAC_V2.POC.File_MO;

NAC_V2.Layouts.base tr(f0 l) := transform
	self.FileName := l.fn;

	sub:=stringlib.stringfind(l.fn,'20',1);
	sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
	self.ProcessDate := (unsigned)Version;
	NCF_FileDate := (unsigned)l.fn[sub..sub+7];
	NCF_FileTime := l.fn[sub2..sub2+5];
	self.NCF_FileDate := if(NCF_FileDate>20130000,NCF_FileDate,self.ProcessDate);
	self.NCF_FileTime :=map(
													NCF_FileTime in ['0000.a','0000.s','0000.o','0000.n'] =>'999999'
													,NCF_FileTime ='5527.a' =>'195527'
													,NCF_FileTime ='1911.a' =>'091911'
													,NCF_FileTime ='0359.s' =>'140359'
													,NCF_FileTime ='2744.s' =>'102744'
													,NCF_FileTime ='0033.o' =>'140033'
													,NCF_FileTime ='1935.o' =>'111935'
													,NCF_FileTime
													);
	self.Case_Id := hash32(
												 trim(l.Case_Last_Name)
												,trim(l.Case_First_Name)
												,trim(l.Case_Middle_Name)
												,trim(l.Client_SSN)
												,trim(l.Client_DOB)
												,trim(l.Case_Physical_Address_Street_1)
												,trim(l.Case_Physical_Address_Street_2)
												,trim(l.Case_Physical_Address_City)
												,trim(l.Case_Physical_Address_State)
												,trim(l.Case_Physical_Address_Zip)
												,trim(l.Case_Mailing_Address_Street_1)
												,trim(l.Case_Mailing_Address_Street_2)
												,trim(l.Case_Mailing_Address_City)
												,trim(l.Case_Mailing_Address_State)
												,trim(l.Case_Mailing_Address_Zip)
												);
	Client_Id := hash32(
												 trim(l.Client_Last_Name)
												,trim(l.Client_First_Name)
												,trim(l.Client_Middle_Name)
												,trim(l.Client_SSN)
												,trim(l.Client_DOB)
												,trim(l.Case_Physical_Address_Street_1)
												,trim(l.Case_Physical_Address_Street_2)
												,trim(l.Case_Physical_Address_City)
												,trim(l.Case_Physical_Address_State)
												,trim(l.Case_Physical_Address_Zip)
												,trim(l.Case_Mailing_Address_Street_1)
												,trim(l.Case_Mailing_Address_Street_2)
												,trim(l.Case_Mailing_Address_City)
												,trim(l.Case_Mailing_Address_State)
												,trim(l.Case_Mailing_Address_Zip)
												);

	self.Case_Email:=stringlib.stringtouppercase(l.Case_Email);
	self.Case_County_Parish_Name:=stringlib.stringtouppercase(l.Case_County_Parish_Name);
	self.Client_Email:=stringlib.stringtouppercase(l.Client_Email);

	self.State_Contact_Name:=stringlib.stringtouppercase(l.State_Contact_Name);
	self.State_Contact_Email:=stringlib.stringtouppercase(l.State_Contact_Email);

	self:=l;
	self:=[];
end;

f1:=project(f0(
								Case_State_Abbreviation<>''
								,Case_Benefit_Type<>''
								,Case_Benefit_Month<>''
								,Case_Identifier<>''
								,Case_Last_Name<>''
								,Case_First_Name<>''
								,Client_Identifier<>''
								,Client_Last_Name<>''
								,Client_First_Name<>''
								),tr(left));

fn_dedup(dataset(Layouts.base) infile):=function
	// rollup by BenefitState + BenefitType + BenefitMonth + CaseID + ClientID, keep most recent ncf_filedate 
	in_dis:=distribute(infile,hash(Case_State_Abbreviation,Case_Identifier));

	in_srt:=sort(in_dis
				,Case_State_Abbreviation
				,Case_Benefit_Type
				,Case_Benefit_Month
				,Case_Identifier
				,Client_Identifier
				,-NCF_FileDate
				,-NCF_FileTime
				,local
				);

	Layouts.base tr(in_srt l, in_srt r) :=transform
		self.PrepRecSeq:=min(l.PrepRecSeq,r.PrepRecSeq);
		self:=l;
	end;

	in_ddp:=rollup(in_srt,tr(left,right)
																			,Case_State_Abbreviation
																			,Case_Benefit_Type
																			,Case_Benefit_Month
																			,Case_Identifier
																			,Client_Identifier
																			,local
																			);

	return in_ddp;
end;

f1_dedup:=fn_dedup(f1);

IsInitialBuild:=nothor(Fileservices.GetSuperFileSubcount(Superfile_List().Base))=0;
seed:=if(IsInitialBuild,1,max(NAC_V2.Files().Base,PrepRecSeq)+1);
MAC_Sequence_Records(f1_dedup,PrepRecSeq,f2,seed);

NAC_V2.Layouts.base tr3 (NAC_V2.Layouts.base L, INTEGER C):= TRANSFORM

	SELF.Prepped_Name := Address.NameFromComponents(
										StringLib.stringtouppercase(L.Client_First_Name)
										,stringlib.stringtouppercase(L.Client_Middle_Name)
										,stringlib.stringtouppercase(L.Client_Last_Name)
										,''
										);

	SELF.Prepped_addr1            := choose(c
																					,trim(StringLib.StringCleanSpaces(L.Case_Physical_Address_Street_1
																					+' '+L.Case_Physical_Address_Street_2))
																					,trim(StringLib.StringCleanSpaces(L.Case_Mailing_Address_Street_1
																					+' '+L.Case_Mailing_Address_Street_2)));
	SELF.Prepped_addr2            := choose(c
																					,trim(StringLib.StringCleanSpaces(	trim(L.Case_Physical_Address_City) + if(L.Case_Physical_Address_City <> '',',','')
																					+ ' '+ L.Case_Physical_Address_State
																					+ ' '+ L.Case_Physical_Address_Zip
																					),left,right)
																					,trim(StringLib.StringCleanSpaces(	trim(L.Case_Mailing_Address_City) + if(L.Case_Mailing_Address_City <> '',',','')
																					+ ' '+ L.Case_Mailing_Address_State
																					+ ' '+ L.Case_Mailing_Address_Zip
																					),left,right));

	SELF.clean_dob                := if(l.Client_DOB_Type_Indicator = Mod_sets.Actual_Type
																			,(unsigned)_validate.date.fCorrectedDateString(l.Client_DOB,false)
																			,0);

	integer YYYYMMDDToDays(string pInput) := 
	 (((integer)(pInput[1..4])*365) + ((integer)(pInput[5..6])*30)+ ((integer)(pInput[7..8])));
	today := YYYYMMDDToDays(ut.GetDate);

	SELF.age:=if(SELF.clean_dob>0,(integer)((today - YYYYMMDDToDays((string)SELF.clean_dob)) / 365),-999);

	Client_SSN		                := if(l.Client_SSN_Type_Indicator=NAC_V2.Mod_Sets.Actual_Type
																		and length(regexreplace('[^0-9]',l.Client_SSN,''))=9
																		,l.Client_SSN
																		,'');
	SELF.clean_ssn                := if((unsigned)Client_SSN > 0,if(Client_SSN in ut.Set_BadSSN ,'',Client_SSN), '');
	SELF                          := L;
	SELF                          := [];
END;

normed      := NORMALIZE(f2, 2, tr3(LEFT, COUNTER))(Prepped_Name<>'',Prepped_addr1<>'');
normed_ddpd := dedup(distribute(normed,Case_Id),record,all,local);

//<tkirk-start/////////////////////////////////////////////////////////
UniqueNames:=dedup(table(normed_ddpd,{Client_Gender,Prepped_name,prefname
										,title,fname,mname,lname,name_suffix,client_first_name,client_middle_name,client_last_name}),Client_Gender,Prepped_name,all);
///////////////////////////////////////////////////////////
fPrepRawForComparison(string pName) :=
function
	string		lNoHyphenOnly		:=	if(trim(pName) = '-', '', pName);
	string		lNoSpacedHyphen	:=	regexreplace(' *\\-+ *', lNoHyphenOnly, '-');
	string		lUpperCaseTrim	:=	trim(StringLib.StringToUpperCase(lNoSpacedHyphen));
	string		lNoCommaPeriod	:=	StringLib.StringTranslate(lUpperCaseTrim, '.,', '  ');
	string		lCleanSpaces		:=	StringLib.StringCleanSpaces(lNoCommaPeriod);
	string		lCharsOnly			:=	StringLib.StringFilter(lCleanSpaces, ' -ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	return	lCharsOnly;
end;

fCleanisBad(string pclient_first_name, string pclient_middle_name, string pclient_last_name, string pfname, string pmname, string plname, string pname_suffix) :=
function
	return	((StringLib.CountWords(pclient_first_name, ' ', false) = 1 and pclient_first_name <> pfname)
					 or trim(pclient_first_name) + trim(' ' + pclient_middle_name) <> trim(pfname) + trim(' ' + pmname)
					)
			or	(pclient_last_name <> plname and (pname_suffix <> '' and plname <> pclient_last_name[1..(length(trim(plname)))]));
end;

///////////////////////////////////////////////////////////
{UniqueNames} tCleanNamesFML1(UniqueNames l) := transform
	lOrigCleanName						:=	Address.CleanNameFields(Address.CleanPersonFML73(l.Prepped_Name)).CleanNameRecord;
	self											:=	lOrigCleanName;
	self											:=l;
end;

UniqueNamesCleanFML1:=nofold(project(UniqueNames,tCleanNamesFML1(left)));
///////////////////////////////////////////////////////////
{UniqueNames} tCleanNamesFML2(UniqueNames l) := transform
	lRawFirstCompare					:=	fPrepRawForComparison(l.client_first_name);
	lRawMiddleCompare					:=	fPrepRawForComparison(l.client_middle_name);
	lRawLastCompare						:=	fPrepRawForComparison(l.client_last_name);
	lIsOrigFMLBad							:=	fCleanisBad(lRawFirstCompare, lRawMiddleCompare, lRawLastCompare, l.fname, l.mname, l.lname, l.name_suffix);
	lIsFNameRemoved						:=	StringLib.StringFind(l.fname + l.mname + l.lname, trim(lRawFirstCompare), 1) = 0;
	lIsLNameRemoved						:=	StringLib.StringFind(l.fname + l.mname + l.lname, trim(lRawLastCompare), 1) = 0;
	lIsMNamePushedToLName			:=	lRawMiddleCompare = StringLib.StringGetNthWord(l.lname, 1) and l.mname = '';//and lRawMiddleCompare not in ['O', 'D'];
	lIsLNameSplitIntoMName		:=	lRawMiddleCompare	= '' and l.mname = StringLib.StringGetNthWord(lRawLastCompare, 1) and StringLib.StringWordCount(lRawLastCompare) > StringLib.StringWordCount(l.lname); 

	lFML2Prepped							:=	trim(if(lIsFNameRemoved,'ZZZ','') + lRawFirstCompare) + if(StringLib.StringWordCount(lRawFirstCompare) > 1,'ZZZ','') + trim(' ' + if(lIsMNamePushedToLName,'ZZZ','') + StringLib.StringFindReplace(trim(lRawMiddleCompare), ' ', 'YYY')) + trim(' ' + if(lIsLNameRemoved,'ZZZ','') + StringLib.StringFindReplace(trim(lRawLastCompare), ' ', 'YYY'));
	lFML2CleanName						:=	iff(lIsOrigFMLBad, Address.CleanNameFields(Address.CleanPersonFML73(lFML2Prepped)).CleanNameRecord, transfer((string73)'', recordof(Address.Layout_Clean_Name))); 

	self.Prepped_Name					:=	if(lIsOrigFMLBad, lFML2Prepped, l.Prepped_Name);
	self.fname								:=	if(lIsOrigFMLBad, StringLib.StringFindReplace(lFML2CleanName.fname, 'ZZZ', ''), l.fname);
	self.mname								:=	if(lIsOrigFMLBad, StringLib.StringFindReplace(StringLib.StringFindReplace(lFML2CleanName.mname, 'YYY', ' '), 'ZZZ', ''), l.mname);
	self.lname								:=	if(lIsOrigFMLBad, StringLib.StringFindReplace(StringLib.StringFindReplace(lFML2CleanName.lname, 'YYY', ' '), 'ZZZ', ''), l.lname);
	self.name_suffix					:=	if(lIsOrigFMLBad, StringLib.StringFindReplace(lFML2CleanName.name_suffix, 'ZZZ', ''), l.name_suffix);
////////////////////////////////////////////////////
	self.title								:=	if(lIsOrigFMLBad, 'FML2', 'FML');	// tkirk-signal to next project will know we cleaned FML2
	self											:=	l;
end;

UniqueNamesCleanFML2:=nofold(project(UniqueNamesCleanFML1,tCleanNamesFML2(left)));
///////////////////////////////////////////////////////////
{UniqueNames} tCleanNamesLFM(UniqueNames l) := transform
	lRawFirstCompare					:=	fPrepRawForComparison(l.client_first_name);
	lRawMiddleCompare					:=	fPrepRawForComparison(l.client_middle_name);
	lRawLastCompare						:=	fPrepRawForComparison(l.client_last_name);

	lIsFML2CleanNameBad				:=	l.title = 'FML2' and fCleanisBad(lRawFirstCompare, lRawMiddleCompare, lRawLastCompare, l.fname, l.mname, l.lname, l.name_suffix);
	lIsFML2FNameRemoved				:=	StringLib.StringFind(l.fname + l.mname + l.lname, trim(lRawFirstCompare), 1) = 0;
	lIsFML2LNameRemoved				:=	StringLib.StringFind(l.fname + l.mname + l.lname, trim(lRawLastCompare), 1) = 0;
	lIsMNamePushedToLName			:=	lRawMiddleCompare = StringLib.StringGetNthWord(l.lname, 1) and l.mname = '';//and lRawMiddleCompare not in ['O', 'D'];
	lIsFML2BrokenMultiLName		:=	StringLib.CountWords(lRawFirstCompare, ' ', false) > StringLib.CountWords(trim(l.lname) + ' ' + l.name_suffix, ' ', false);

	lLFMPrepped								:=	trim(if(lIsFML2LNameRemoved, 'ZZZ', '') + lRawLastCompare) + ', ' + trim(if(lIsFML2FNameRemoved, 'ZZZ', '') + lRawFirstCompare + trim(' ' + if(lIsMNamePushedToLName,'ZZZ','') + lRawMiddleCompare));
	lLFMCleanName							:=	iff(lIsFML2CleanNameBad, Address.CleanNameFields(Address.CleanPersonFML73(lLFMPrepped)).CleanNameRecord, transfer((string73)'', recordof(Address.Layout_Clean_Name))); 

	self.Prepped_Name					:=	if(lIsFML2CleanNameBad, lLFMPrepped, l.Prepped_Name);
	self.fname								:=	if(lIsFML2CleanNameBad, StringLib.StringFindReplace(lLFMCleanName.fname, 'ZZZ', ''), l.fname);
	self.mname								:=	if(lIsFML2CleanNameBad, StringLib.StringFindReplace(lLFMCleanName.mname, 'ZZZ', ''), l.mname);
	self.lname								:=	if(lIsFML2CleanNameBad, StringLib.StringFindReplace(lLFMCleanName.lname, 'ZZZ', ''), l.lname);
	self.name_suffix					:=	if(lIsFML2CleanNameBad, StringLib.StringFindReplace(lLFMCleanName.name_suffix, 'ZZZ', ''), l.name_suffix);
////////////////////////////////////////////////////
	self.title       					:=	map(
																		l.Client_Gender='M' => 'MR'
																		,l.Client_Gender='F' => 'MS'
																		,'');
	self.prefname		  				:=	NID.PreferredFirstNew(self.fname);
	self											:=	l;
end;

UniqueNamesClean:=nofold(project(UniqueNamesCleanFML2,tCleanNamesLFM(left)));
////////////////////////////////////////////////////
NamesAppended:=join(distribute(normed_ddpd, hash(client_first_name,client_middle_name,client_last_name))
						,distribute(UniqueNamesClean,   hash(client_first_name,client_middle_name,client_last_name))
								,   left.Client_Gender=right.Client_Gender
								and left.client_first_name=right.client_first_name
								and left.client_middle_name=right.client_middle_name
								and left.client_last_name=right.client_last_name
								,transform(NAC_V2.Layouts.base
									,self.title       :=right.title
									,self.fname       :=if(left.client_first_name=right.client_first_name and left.client_middle_name=right.client_middle_name and left.client_last_name=right.client_last_name,right.fname,'')
									,self.mname       :=if(left.client_first_name=right.client_first_name and left.client_middle_name=right.client_middle_name and left.client_last_name=right.client_last_name,right.mname,'')
									,self.lname       :=if(left.client_first_name=right.client_first_name and left.client_middle_name=right.client_middle_name and left.client_last_name=right.client_last_name,right.lname,'')
									,self.name_suffix :=if(left.client_first_name=right.client_first_name and left.client_middle_name=right.client_middle_name and left.client_last_name=right.client_last_name,right.name_suffix,'')
									,self.prefname    :=if(left.client_first_name=right.client_first_name and left.client_middle_name=right.client_middle_name and left.client_last_name=right.client_last_name,right.prefname,'')
									,self:=left)
								,left outer
								,local);
////////////////////////////////////////////////////end-tkirk>

WithName:=NamesAppended;

UniqueAddresses:=dedup(
									WithName(
										Prepped_addr1<>''
										,Prepped_addr2<>''
										,trim(regexreplace(Mod_Sets.RegexBadAddress,StringLib.StringCleanSpaces(Prepped_addr1),'$2',nocase))
															not in Mod_Sets.SetBadAddress
										,trim(regexreplace(Mod_Sets.RegexBadAddress,StringLib.StringCleanSpaces(Prepped_addr2),'$2',nocase))
															not in Mod_Sets.SetBadAddress
													),Prepped_addr1,Prepped_addr2,all);

NAC_V2.Layouts.base tr4(UniqueAddresses l) := transform
	Clean_Address := address.CleanAddress182(l.Prepped_addr1,l.Prepped_addr2);
	STRING28  v_prim_name 		:= Clean_Address[13..40];
	STRING5   v_zip       		:= Clean_Address[117..121];
	STRING4   v_zip4      		:= Clean_Address[122..125];
	SELF.prim_range  			:= Clean_Address[ 1..  10];
	SELF.predir      			:= Clean_Address[ 11.. 12];
	SELF.prim_name   			:= v_prim_name;
	SELF.addr_suffix 			:= Clean_Address[ 41.. 44];
	SELF.postdir     			:= Clean_Address[ 45.. 46];
	SELF.unit_desig  			:= Clean_Address[ 47.. 56];
	SELF.sec_range   			:= Clean_Address[ 57.. 64];
	SELF.p_city_name 			:= Clean_Address[ 65.. 89];
	SELF.v_city_name 			:= Clean_Address[ 90..114];
	SELF.st          			:= Clean_Address[115..116];
	SELF.zip         			:= if(v_zip='00000','',v_zip);
	SELF.zip4       	 		:= if(v_zip4='0000','',v_zip4);
	SELF.cart        			:= Clean_Address[126..129];
	SELF.cr_sort_sz  			:= Clean_Address[130..130];
	SELF.lot         			:= Clean_Address[131..134];
	SELF.lot_order   			:= Clean_Address[135..135];
	SELF.dbpc        			:= Clean_Address[136..137];
	SELF.chk_digit   			:= Clean_Address[138..138];
	SELF.rec_type    			:= Clean_Address[139..140];
	SELF.fips_county 			:= Clean_Address[141..142];
	SELF.county      			:= Clean_Address[143..145];
	SELF.geo_lat     			:= Clean_Address[146..155];
	SELF.geo_long    			:= Clean_Address[156..166];
	SELF.msa         			:= Clean_Address[167..170];
	SELF.geo_blk     			:= Clean_Address[171..177];
	SELF.geo_match   			:= Clean_Address[178..178];
	SELF.err_stat    			:= Clean_Address[179..182];
	SELF := l;
END;

AddressClean := project(UniqueAddresses,tr4(left));

Preprocess:=join(distribute(WithName,     hash(Prepped_addr1,Prepped_addr2))
								,distribute(AddressClean, hash(Prepped_addr1,Prepped_addr2))
								,   left.Prepped_addr1=right.Prepped_addr1
								and left.Prepped_addr2=right.Prepped_addr2
								,transform(Layouts.base
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
									,self.fips_county  :=if(left.Prepped_addr1=right.Prepped_addr1,right.fips_county,'')
									,self.county       :=if(left.Prepped_addr1=right.Prepped_addr1,right.county,'')
									,self.geo_lat      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_lat,'')
									,self.geo_long     :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_long,'')
									,self.msa          :=if(left.Prepped_addr1=right.Prepped_addr1,right.msa,'')
									,self.geo_blk      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_blk,'')
									,self.geo_match    :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_match,'')
									,self.err_stat     :=if(left.Prepped_addr1=right.Prepped_addr1,right.err_stat,'')
									,self:=left)
								,left outer
								,local);

ProdVer:=did_add.get_EnvVariable('header_build_version')[1..8];
flag:=dataset(Superfile_List().Flag,{string8 Prod_Ver},flat,opt);

ToADL := if(nothor(fileservices.fileExists(Superfile_List().Flag)) and ProdVer = flag[1].Prod_Ver
						,Preprocess
						,Preprocess  + NAC_V2.Files().Base);

matchset := ['A','Z','D','S'];

did_add.MAC_Match_Flex
	(ToADL , matchset,
	 clean_ssn,clean_dob, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip, st,'',
	 DID, NAC_V2.Layouts.base, true, did_score,
	 0, ds_did);

did_add.MAC_Add_SSN_By_DID(ds_did,did,best_ssn,out1);
did_add.MAC_Add_DOB_By_DID(out1,did,best_dob,out);

NewBaseCat0 := if(nothor(fileservices.fileExists(Superfile_List().Flag)) and ProdVer = flag[1].Prod_Ver
								,out  + NAC_V2.Files().Base
								,out)(FileName<>'test_seed');

NewBaseCat := project(NewBaseCat0
								,transform(NAC_V2.Layouts.base
									,self.did      :=map(
																			left.did_score < 75 => 0
																			,left.age > 17       => left.did
																			,left.clean_dob > 0 and left.best_dob > 0
																				and header.sig_near_dob(left.clean_dob,left.best_dob)
																													 => left.did
																			,0
																			)
									,self.did_score:=if(self.did=0,0,left.did_score)
									,self:=left
									))
									;

NewBase := fn_dedup(NewBaseCat) + Files().test_seed;

RETURN NewBase;

END;