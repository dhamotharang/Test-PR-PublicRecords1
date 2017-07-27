import lib_keylib, lib_stringlib;

lBaseKeyName 	:= 'key::moxie.civil_party.';

rMoxieFileForKeybuildLayout
 :=
  record
	civil_court.Layout_Moxie_Party;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

dMoxieFile := dataset(civil_court.Name_Moxie_Party_Dev,rMoxieFileForKeybuildLayout,flat);

//begin local functions
string fSingleSpace(string pString1, string pString2, string pString3='', string pString4='')
 := trim(lib_stringlib.stringlib.stringcleanspaces(lib_stringlib.stringlib.stringtouppercase(pString1) + ' ' +
												   lib_stringlib.stringlib.stringtouppercase(pString2) + ' ' +
												   lib_stringlib.stringlib.stringtouppercase(pString3) + ' ' +
												   lib_stringlib.stringlib.stringtouppercase(pString4)
												  ),
		 left,
		 right
		);

string fCleanCompanyName(string pStringIn)
 := lib_stringlib.stringlib.stringcleanspaces(lib_stringlib.stringlib.stringfilter(lib_stringlib.stringlib.stringtouppercase(pStringIn),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '));

integer fSpacePosition(string pStringIn, integer1 pInstance)
 := if(lib_stringlib.stringlib.stringfind(pStringIn,' ',pInstance) = 0,
	   length(trim(pStringIn))+1,
	   lib_stringlib.stringlib.stringfind(pStringIn,' ',pInstance)
	  );

string fGetToken(string pStringIn, integer1 pTokenNumber)
 := if(pTokenNumber = 1,
	   pStringIn[1..fSpacePosition(pStringIn,1)-1],
	   pStringIn[fSpacePosition(pStringIn,pTokenNumber-1)+1..fSpacePosition(pStringIn,pTokenNumber)-1]
	  );

string fReplaceToken(string pStringIn)
 := case(lib_stringlib.stringlib.stringtouppercase(pStringIn),
		 '1' => '',
		 '10' => '',
		 '2' => '',
		 '3' => '',
		 '4' => '',
		 '5' => '',
		 '6' => '',
		 '7' => '',
		 '8' => '',
		 '9' => '',
		 '10TH' => '',
		 '1ST' => '',
		 '2ND' => '',
		 '3RD' => '',
		 '4TH' => '',
		 '5TH' => '',
		 '6TH' => '',
		 '7TH' => '',
		 '8TH' => '',
		 '9TH' => '',
		 'BRANCH' => '',
		 'CO' => '',
		 'COUNTY' => '',
		 'COURT' => '',
		 'CT' => '',
		 'CTY' => '',
		 'DIST' => '',
		 'DISTRICT' => '',
		 'DIV' => '',
		 'DIVI' => '',
		 'DIVISION' => '',
		 'EIGHTH' => '',
		 'FIFTH' => '',
		 'FIRST' => '',
		 'FOURTH' => '',
		 'MUNI' => '',
		 'MUNICIPAL' => '',
		 'NINTH' => '',
		 'SECOND' => '',
		 'SEVENTH' => '',
		 'SIXTH' => '',
		 'TENTH' => '',
		 'THIRD' => '',
		 'LA' => 'LOS ANGELES',
		 pStringIn
		);

string fRemoveBadJurisdictionTokens(string pStringIn)
 := lib_stringlib.stringlib.stringtouppercase(
	  trim(		 fReplaceToken(fGetToken(pStringIn,01)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,02)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,03)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,04)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,05)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,06)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,07)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,08)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,09)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,10)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,11)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,12)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,13)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,14)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,15)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,16)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,17)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,18)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,19)))
	+ trim(' ' + fReplaceToken(fGetToken(pStringIn,20)))
	);
//end local functions

dMoxieFileDist	:= distribute(dMoxieFile,hash(__FilePos));

//begin simple keys
rSimpleKeys_Layout
 :=
  record
	dMoxieFile.case_key;
	dMoxieFile.case_number;
	dMoxieFile.state_origin;
	dMoxieFile.entity_seq_num_1;
	dMoxieFile.entity_type_code_1_master;
	big_endian unsigned8	filepos	:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;
 
dSimple_Keys_Table	:= table(dMoxieFile,rSimpleKeys_Layout);

kCaseEntityKey		:= buildindex(dSimple_Keys_Table(case_key<>''),
						{case_key,entity_type_code_1_master,entity_seq_num_1,filepos},
						lBaseKeyName + 'case_key.entity_type_code_1_master.entity_seq_num_1.key',moxie,overwrite);
kCaseStOriginNo		:= buildindex(dSimple_Keys_Table(case_number<>''),
						{case_number,state_origin,filepos},
						lBaseKeyName + 'case_number.state_origin.key',moxie,overwrite);
//end simple keys

//begin normalized tables
rStCityLFMNameNameAsIs_Layout
 :=
  record
    typeof(dMoxieFile.st1)			st				:= '';
	typeof(dMoxieFile.p_city_name1)	city			:= '';
	string60						nameasis		:= '';
	string10						cn	 			:= '';
	string45						lfmname			:= '';
	typeof(dMoxieFile.zip1)			zip				:= '';
	varstring						ZipToCityList1	:= '';
	varstring						ZipToCityList2	:= '';
	big_endian unsigned8			filepos			:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;
rStCityLFMNameNameAsIs_Layout_alpha
 :=
  record
    typeof(dMoxieFile.st1)			st				:= '';
	typeof(dMoxieFile.p_city_name1)	city			:= '';
	string60						nameasis		:= '';
	string80						cn_all			:= '';
	string45						lfmname			:= '';
	typeof(dMoxieFile.zip1)			zip				:= '';
	varstring						ZipToCityList1	:= '';
	varstring						ZipToCityList2	:= '';
	big_endian unsigned8			filepos			:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;

rStCityLFMNameNameAsIs_Layout	tNormalizeOrigStateLFMName(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.LFMName	:= choose(pCounter,
							  fSingleSpace(pInput.e1_lname1,pInput.e1_fname1,pInput.e1_mname1),
							  fSingleSpace(pInput.e1_lname2,pInput.e1_fname2,pInput.e1_mname2),
							  fSingleSpace(pInput.e1_lname3,pInput.e1_fname3,pInput.e1_mname3),
							  fSingleSpace(pInput.e1_lname4,pInput.e1_fname4,pInput.e1_mname4),
							  fSingleSpace(pInput.e1_lname5,pInput.e1_fname5,pInput.e1_mname5),
							  fSingleSpace(pInput.v1_lname1,pInput.v1_fname1,pInput.v1_mname1),
							  fSingleSpace(pInput.v1_lname2,pInput.v1_fname2,pInput.v1_mname2),
							  fSingleSpace(pInput.v1_lname3,pInput.v1_fname3,pInput.v1_mname3),
							  fSingleSpace(pInput.v1_lname4,pInput.v1_fname4,pInput.v1_mname4),
							  fSingleSpace(pInput.v1_lname5,pInput.v1_fname5,pInput.v1_mname5),
							  fSingleSpace(pInput.e2_lname1,pInput.e2_fname1,pInput.e2_mname1),
							  fSingleSpace(pInput.e2_lname2,pInput.e2_fname2,pInput.e2_mname2),
							  fSingleSpace(pInput.e2_lname3,pInput.e2_fname3,pInput.e2_mname3),
							  fSingleSpace(pInput.e2_lname4,pInput.e2_fname4,pInput.e2_mname4),
							  fSingleSpace(pInput.e2_lname5,pInput.e2_fname5,pInput.e2_mname5),
							  fSingleSpace(pInput.v2_lname1,pInput.v2_fname1,pInput.v2_mname1),
							  fSingleSpace(pInput.v2_lname2,pInput.v2_fname2,pInput.v2_mname2),
							  fSingleSpace(pInput.v2_lname3,pInput.v2_fname3,pInput.v2_mname3),
							  fSingleSpace(pInput.v2_lname4,pInput.v2_fname4,pInput.v2_mname4),
							  fSingleSpace(pInput.v2_lname5,pInput.v2_fname5,pInput.v2_mname5)
							 );
	self.st			:= pInput.state_origin;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;

dOrigStateLFMName_Norm		:= normalize(dMoxieFileDist,20,tNormalizeOrigStateLFMName(left,counter));
dOrigStateLFMName_Sorted	:= sort(dOrigStateLFMName_Norm(LFMName<>''),St,LFMName,FilePos,local);
dOrigStateLFMName_Deduped	:= dedup(dOrigStateLFMName_Sorted,St,LFMName,FilePos,local);

rStCityLFMNameNameAsIs_Layout	tNormalizeOrigStateNameAsIs(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.NameAsIs	:= choose(pCounter,
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname1),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname2),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname3),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname4),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname5),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname1),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname2),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname3),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname4),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname5),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname1),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname2),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname3),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname4),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname5),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname1),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname2),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname3),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname4),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname5)
							 );
	self.st			:= pInput.state_origin;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;

dOrigStateNameAsIs_Norm		:= normalize(dMoxieFileDist,20,tNormalizeOrigStateNameAsIs(left,counter));
dOrigStateNameAsIs_Sorted	:= sort(dOrigStateNameAsIs_Norm(NameAsIs<>''),St,NameAsIs,FilePos,local);
dOrigStateNameAsIs_Deduped	:= dedup(dOrigStateNameAsIs_Sorted,St,NameAsIs,FilePos,local);

rStCityLFMNameNameAsIs_Layout_alpha tNormalizeOrigStateCN_ALL(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.cn_all	:= choose(pCounter,
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname1),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname3),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname4),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname5),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname1),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname3),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname4),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname5),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname1),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname3),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname4),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname5),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname1),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname3),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname4),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname5)
							 );
	self.st			:= pInput.state_origin;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;

dOrigStateCN_ALL_Norm_alpha			:= normalize(dMoxieFileDist,20,tNormalizeOrigStateCN_ALL(left,counter));
dOrigStateCN_ALL_Sorted_alpha		:= sort(dOrigStateCN_ALL_Norm_alpha(cn_all<>''),St,cn_all,FilePos,local);
dOrigStateCN_ALL_Deduped_alpha		:= dedup(dOrigStateCN_ALL_Sorted_alpha,St,cn_all,FilePos,local);

rStCityLFMNameNameAsIs_Layout tNormalizeOrigStateCN(dOrigStateCN_ALL_Deduped_alpha pInput, integer pCounter)
 :=
  transform
	self.cn		:= choose(pCounter,
							  pInput.cn_all[ 1..10],
							  pInput.cn_all[11..20],
							  pInput.cn_all[21..30],
							  pInput.cn_all[31..40],
							  pInput.cn_all[41..50],
							  pInput.cn_all[51..60],
							  pInput.cn_all[61..70],
							  pInput.cn_all[71..80]
							 );
	self.st			:= pInput.st;
	self.filepos	:= (big_endian unsigned8)pInput.filepos;
  end
;
dOrigStateCN_Norm		:= normalize(dOrigStateCN_All_Deduped_alpha,8,tNormalizeOrigStateCN(left,counter));
dOrigStateCN_Sorted		:= sort(dOrigStateCN_Norm(cn<>''),St,cn,FilePos,local);
dOrigStateCN_Deduped	:= dedup(dOrigStateCN_Sorted,St,cn,FilePos,local);

rStCityLFMNameNameAsIs_Layout	tNormalizeLFMName1(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.LFMName	:= choose(pCounter,
							  fSingleSpace(pInput.e1_lname1,pInput.e1_fname1,pInput.e1_mname1),
							  fSingleSpace(pInput.e1_lname2,pInput.e1_fname2,pInput.e1_mname2),
							  fSingleSpace(pInput.e1_lname3,pInput.e1_fname3,pInput.e1_mname3),
							  fSingleSpace(pInput.e1_lname4,pInput.e1_fname4,pInput.e1_mname4),
							  fSingleSpace(pInput.e1_lname5,pInput.e1_fname5,pInput.e1_mname5),
							  fSingleSpace(pInput.v1_lname1,pInput.v1_fname1,pInput.v1_mname1),
							  fSingleSpace(pInput.v1_lname2,pInput.v1_fname2,pInput.v1_mname2),
							  fSingleSpace(pInput.v1_lname3,pInput.v1_fname3,pInput.v1_mname3),
							  fSingleSpace(pInput.v1_lname4,pInput.v1_fname4,pInput.v1_mname4),
							  fSingleSpace(pInput.v1_lname5,pInput.v1_fname5,pInput.v1_mname5),
							  fSingleSpace(pInput.v2_lname1,pInput.v2_fname1,pInput.v2_mname1),
							  fSingleSpace(pInput.v2_lname2,pInput.v2_fname2,pInput.v2_mname2),
							  fSingleSpace(pInput.v2_lname3,pInput.v2_fname3,pInput.v2_mname3),
							  fSingleSpace(pInput.v2_lname4,pInput.v2_fname4,pInput.v2_mname4),
							  fSingleSpace(pInput.v2_lname5,pInput.v2_fname5,pInput.v2_mname5)
							 );
	self.st			:= pInput.st1;
	self.zip		:= pInput.zip1;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;
dLFMName1_Norm		:= normalize(dMoxieFileDist,15,tNormalizeLFMName1(left,counter));
dLFMName1_Sorted	:= sort(dLFMName1_Norm(LFMName<>''),LFMName,FilePos,local);
dLFMName1_Deduped	:= dedup(dLFMName1_Sorted,LFMName,FilePos,local);

rStCityLFMNameNameAsIs_Layout	tNormalizeLFMName2(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.LFMName	:= choose(pCounter,
							  fSingleSpace(pInput.e2_lname1,pInput.e2_fname1,pInput.e2_mname1),
							  fSingleSpace(pInput.e2_lname2,pInput.e2_fname2,pInput.e2_mname2),
							  fSingleSpace(pInput.e2_lname3,pInput.e2_fname3,pInput.e2_mname3),
							  fSingleSpace(pInput.e2_lname4,pInput.e2_fname4,pInput.e2_mname4),
							  fSingleSpace(pInput.e2_lname5,pInput.e2_fname5,pInput.e2_mname5)
							 );
	self.st			:= pInput.st2;
	self.zip		:= pInput.zip2;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;

dLFMName2_Norm		:= normalize(dMoxieFileDist,5,tNormalizeLFMName2(left,counter));
dLFMName2_Sorted	:= sort(dLFMName2_Norm(LFMName<>''),LFMName,FilePos,local);
dLFMName2_Deduped	:= dedup(dLFMName2_Sorted,LFMName,FilePos,local);

rStCityLFMNameNameAsIs_Layout	tNormalizeNameAsIs1(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.NameAsIs	:= choose(pCounter,
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname1),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname2),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname3),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname4),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e1_cname5),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname1),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname2),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname3),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname4),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v1_cname5),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname1),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname2),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname3),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname4),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.v2_cname5)
							 );
	self.st			:= pInput.st1;
	self.zip		:= pInput.zip1;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;

dNameAsIs1_Norm		:= normalize(dMoxieFileDist,15,tNormalizeNameAsIs1(left,counter));
dNameAsIs1_Sorted	:= sort(dNameAsIs1_Norm(NameAsIs<>''),NameAsIs,FilePos,local);
dNameAsIs1_Deduped	:= dedup(dNameAsIs1_Sorted,NameAsIs,FilePos,local);

rStCityLFMNameNameAsIs_Layout	tNormalizeNameAsIs2(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.NameAsIs	:= choose(pCounter,
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname1),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname2),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname3),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname4),
							  Lib_KeyLib.KeyLib.CompNameNoSyn(pInput.e2_cname5)
							 );
	self.st			:= pInput.st2;
	self.zip		:= pInput.zip2;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;

dNameAsIs2_Norm		:= normalize(dMoxieFileDist,5,tNormalizeNameAsIs2(left,counter));
dNameAsIs2_Sorted	:= sort(dNameAsIs2_Norm(NameAsIs<>''),NameAsIs,FilePos,local);
dNameAsIs2_Deduped	:= dedup(dNameAsIs2_Sorted,NameAsIs,FilePos,local);

rStCityLFMNameNameAsIs_Layout_alpha	tNormalizeCN_ALL1_alpha(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.cn_all	:= choose(pCounter,
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname1),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname3),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname4),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e1_cname5),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname1),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname3),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname4),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v1_cname5),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname1),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname3),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname4),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.v2_cname5)
							 );
	self.st			:= pInput.st1;
	self.zip		:= pInput.zip1;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;

dCN_ALL1_Norm_alpha		:= normalize(dMoxieFileDist,15,tNormalizeCN_ALL1_alpha(left,counter));
dCN_ALL1_Sorted_alpha	:= sort(dCN_ALL1_Norm_alpha(cn_all<>''),cn_all,FilePos,local);
dCN_ALL1_Deduped_alpha	:= dedup(dCN_ALL1_Sorted_alpha,cn_all,FilePos,local);

rStCityLFMNameNameAsIs_Layout tNormalizeCN_ALL1(dCN_ALL1_Deduped_alpha pInput, integer pCounter)
 :=
  transform
	self.cn		:= choose(pCounter,
							  pInput.cn_all[ 1..10],
							  pInput.cn_all[11..20],
							  pInput.cn_all[21..30],
							  pInput.cn_all[31..40],
							  pInput.cn_all[41..50],
							  pInput.cn_all[51..60],
							  pInput.cn_all[61..70],
							  pInput.cn_all[71..80]
							 );
	self.st			:= pInput.st;
	self.zip		:= pInput.zip;
	self.filepos	:= (big_endian unsigned8)pInput.filepos;
  end
;
dCN_ALL1_Norm		:= normalize(dCN_ALL1_Deduped_alpha,8,tNormalizeCN_ALL1(left,counter));
dCN_ALL1_Sorted		:= sort(dCN_ALL1_Norm(cn<>''),St,cn,FilePos,local);
dCN_All1_Deduped	:= dedup(dCN_ALL1_Sorted,St,cn,FilePos,local);

rStCityLFMNameNameAsIs_Layout_alpha	tNormalizeCN_ALL2_alpha(dMoxieFile pInput, integer pCounter)
 :=
  transform
	self.cn_all			:= choose(pCounter,
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname1),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname2),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname3),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname4),
							  Lib_KeyLib.KeyLib.GongDacName(pInput.e2_cname5)
							 );
	self.st		:= pInput.st2;
	self.zip		:= pInput.zip2;
	self.filepos	:= (big_endian unsigned8)pInput.__filepos;
  end
 ;

dCN_ALL2_Norm_alpha		:= normalize(dMoxieFileDist,5,tNormalizeCN_ALL2_alpha(left,counter));
dCN_ALL2_Sorted_alpha	:= sort(dCN_ALL2_Norm_alpha(cn_all<>''),cn_all,FilePos,local);
dCN_ALL2_Deduped_alpha	:= dedup(dCN_ALL2_Sorted_alpha,cn_all,FilePos,local);

rStCityLFMNameNameAsIs_Layout tNormalizeCN_ALL2(dCN_ALL2_Deduped_alpha pInput, integer pCounter)
 :=
  transform
	self.cn		:= choose(pCounter,
							  pInput.cn_all[ 1..10],
							  pInput.cn_all[11..20],
							  pInput.cn_all[21..30],
							  pInput.cn_all[31..40],
							  pInput.cn_all[41..50],
							  pInput.cn_all[51..60],
							  pInput.cn_all[61..70],
							  pInput.cn_all[71..80]
							 );
	self.st			:= pInput.st;
	self.zip		:= pInput.zip;
	self.filepos	:= (big_endian unsigned8)pInput.filepos;
  end
;
dCN_ALL2_Norm		:= normalize(dCN_ALL2_Deduped_alpha,8,tNormalizeCN_ALL1(left,counter));
dCN_ALL2_Sorted		:= sort(dCN_ALL2_Norm(cn<>''),St,cn,FilePos,local);
dCN_All2_Deduped	:= dedup(dCN_ALL2_Sorted,St,cn,FilePos,local);

rCities_Layout
 :=
  record
	varstring						ZipToCityList1	:= ZipLib.ZipToCities(dMoxieFile.Zip1);
	varstring						ZipToCityList2	:= ZipLib.ZipToCities(dMoxieFile.Zip2);
	dMoxieFile.P_City_Name1;
	dMoxieFile.P_City_Name2;
	big_endian unsigned8			filepos			:= (big_endian unsigned8)dMoxieFile.__filepos;
  end
 ;

dCities_Table		:= table(dMoxieFileDist,rCities_Layout);

rStCityLFMNameNameAsIs_Layout tNormalizeCities1(rCities_Layout pInput,integer pCounter)
 :=
  transform
	self.city		:= if(pCounter=1,pInput.P_City_Name1,stringlib.stringextract(pInput.ZipToCityList1,pCounter));
	self			:= pInput;
  end
 ;

dCity1_Norm			:= normalize(dCities_Table,
									 (integer)Stringlib.StringExtract(left.ZipToCityList1,1)+1,
									 tNormalizeCities1(left,counter)
								);
dCity1_Sorted		:= sort(dCity1_Norm(City<>''),City,FilePos,local);								
dCity1_Deduped		:= dedup(dCity1_Sorted,City,FilePos,local);								

rStCityLFMNameNameAsIs_Layout tNormalizeCities2(rCities_Layout pInput,integer pCounter)
 :=
  transform
	self.city		:= if(pCounter=1,pInput.P_City_Name2,stringlib.stringextract(pInput.ZipToCityList2,pCounter));
	self			:= pInput;
  end
 ;
 
dCity2_Norm			:= normalize(dCities_Table,
									 (integer)Stringlib.StringExtract(left.ZipToCityList1,1)+1,
									 tNormalizeCities2(left,counter)
								);
dCity2_Sorted		:= sort(dCity2_Norm(City<>''),City,FilePos,local);
dCity2_Deduped		:= dedup(dCity2_Sorted,City,FilePos,local);								

dLFMNameAll_Sorted	:= sort(dLFMName1_Deduped + dLFMName2_Deduped + dOrigStateLFMName_Deduped,st,lfmname,filepos,local);			// already filtered out blanks
dLFMNameAll_Deduped	:= dedup(dLFMNameAll_Sorted,st,lfmname,filepos,local);			// already filtered out blanks
kLFMName			:= buildindex(dLFMNameAll_Deduped,
						{LFMName,FilePos},
						lBaseKeyName + 'lfmname.key',moxie,overwrite,dataset(dMoxieFile));
kStLFMName			:= buildindex(dLFMNameAll_Deduped,
						{st,LFMName,filepos},
						lBaseKeyName + 'st.lfmname.key',moxie,overwrite,dataset(dMoxieFile));

dNameAsIsAll_Sorted	:= sort(dNameAsIs1_Deduped + dNameAsIs2_Deduped + dOrigStateNameAsIs_Deduped,st,nameasis,filepos,local);
dNameAsIsAll_Deduped:= dedup(dNameAsIsAll_Sorted,st,nameasis,filepos,local);		// already filtered out blanks
kNameAsIs			:= buildindex(dNameAsIsAll_Deduped,
						{nameasis,filepos},
						lBaseKeyName + 'nameasis.key',moxie,overwrite,dataset(dMoxieFile));
kStNameAsIs			:= buildindex(dNameAsIsAll_Deduped,
						{st,nameasis,filepos},
						lBaseKeyName + 'st.nameasis.key',moxie,overwrite,dataset(dMoxieFile));

dCN_ALL_Sorted	:= sort(dCN_ALL1_Deduped + dCN_ALL2_Deduped + dOrigStateCN_Deduped,st,cn,filepos,local);
dCN_ALL_Deduped:= dedup(dCN_ALL_Sorted,st,cn,filepos,local);		// already filtered out blanks

kCN				:= buildindex(dCN_ALL_Deduped,
						{cn,filepos},
						lBaseKeyName + 'cn.key',moxie,overwrite,dataset(dMoxieFile));
kStCN			:= buildindex(dCN_ALL_Deduped,
						{st,cn,filepos},
						lBaseKeyName + 'st.cn.key',moxie,overwrite,dataset(dMoxieFile));


rStCityLFMNameNameAsIs_Layout	tJoinNameToCity(rStCityLFMNameNameAsIs_Layout pName, rStCityLFMNameNameAsIs_Layout pCities)
 :=
  transform
	self.city		:= pCities.city;
	self			:= pName;
  end
 ;

dStCityLFMName1		:= join(dLFMName1_Deduped,dCity1_Deduped,
							left.FilePos = right.FilePos,
							tJoinNameToCity(left,right),
							local
						   );
dStCityLFMName2		:= join(dLFMName2_Deduped,dCity2_Deduped,
							left.FilePos = right.FilePos,
							tJoinNameToCity(left,right),
							local
						   );
dStCityNameAsIs1	:= join(dNameAsIs1_Deduped,dCity1_Deduped,
							left.FilePos = right.FilePos,
							tJoinNameToCity(left,right),
							local
						   );
dStCityNameAsIs2	:= join(dNameAsIs2_Deduped,dCity2_Deduped,
							left.FilePos = right.FilePos,
							tJoinNameToCity(left,right),
							local
						   );

dStCityLFMNameAll_Sorted	:= sort(dStCityLFMName1 + dStCityLFMName2,st,city,lfmname,filepos,local);		// already filtered out blanks
dStCityLFMNameAll_Deduped	:= dedup(dStCityLFMNameAll_Sorted,st,city,lfmname,filepos,local);		// already filtered out blanks
kStCityLFMName				:= buildindex(dStCityLFMNameAll_Deduped,
								{st,city,lfmname,filepos},
								lBaseKeyName + 'st.city.lfmname.key',moxie,overwrite,dataset(dMoxieFile));

dStCityNameAsIsAll_Sorted	:= sort(dStCityNameAsIs1 + dStCityNameAsIs2,st,city,nameasis,filepos,local);	// already filtered out blanks
dStCityNameAsIsAll_Deduped	:= dedup(dStCityNameAsIsAll_Sorted,st,city,nameasis,filepos,local);	// already filtered out blanks
kStCityNameAsIs				:= buildindex(dStCityNameAsIsAll_Deduped,
								{st,city,nameasis,filepos},
								lBaseKeyName + 'st.city.nameasis.key',moxie,overwrite,dataset(dMoxieFile));

dStCityCN_ALL1	:= join(dCN_ALL1_Deduped,dCity1_Deduped,
							left.FilePos = right.FilePos,
							tJoinNameToCity(left,right),
							local
						   );
dStCityCN_ALL2	:= join(dCN_ALL2_Deduped,dCity2_Deduped,
							left.FilePos = right.FilePos,
							tJoinNameToCity(left,right),
							local
						   );
						   
dStCityCN_ALL_Sorted	:= sort(dStCityCN_ALL1 + dStCityCN_ALL2,st,city,cn,filepos,local);	// already filtered out blanks
dStCityCN_ALL_Deduped	:= dedup(dStCityCN_ALL_Sorted,st,city,cn,filepos,local);	// already filtered out blanks

kStCityCN			:= buildindex(dStCityCN_ALL_Deduped,
								{st,city,cn,filepos},
								lBaseKeyName + 'st.city.cn.key',moxie,overwrite,dataset(dMoxieFile));


// build address keys
rEntityAddrRecord
 := 
 record
	string5   z5 			:= '';
	string10  prim_range	:= '';
	string28  prim_name		:= '';
	string2   pre_dir		:= '';
	string2   post_dir		:= '';
	string4   suffix		:= '';
	string8   sec_range		:= '';
	dMoxieFile.zip1;
	dMoxieFile.zip2;
	dMoxieFile.prim_name1;
	dMoxieFile.prim_name2;
	dMoxieFile.prim_range1;
	dMoxieFile.prim_range2;
	dMoxieFile.predir1;
	dMoxieFile.predir2;
	dMoxieFile.postdir1;
	dMoxieFile.postdir2;
	dMoxieFile.addr_suffix1;
	dMoxieFile.addr_suffix2;
	dMoxieFile.sec_range1;
	dMoxieFile.sec_range2;
	big_endian unsigned8	filepos	:= (big_endian unsigned8)dMoxieFile.__filepos;
end;

rEntityAddrRecord tNormalizeEntityAddr(rEntityAddrRecord pInput, unsigned1 pCounter) 
 := 
transform
	self.z5 			:= choose(pCounter, pInput.zip1, pInput.zip2);
	self.prim_range 	:= choose(pCounter, pInput.prim_range1, pInput.prim_range2);
	self.prim_name  	:= choose(pCounter, pInput.prim_name1, pInput.prim_name2);
	self.pre_dir 		:= choose(pCounter, pInput.predir1, pInput.predir2);
	self.post_dir 		:= choose(pCounter, pInput.postdir1, pInput.postdir2);
	self.suffix 		:= choose(pCounter, pInput.addr_suffix1, pInput.addr_suffix2);
	self.sec_range  	:= choose(pCounter, pInput.sec_range1, pInput.sec_range2);
	self.filepos		:= pInput.filepos;
	self				:= pInput;
end;

dEntityAddrTable        := table(dMoxieFileDist,rEntityAddrRecord);
dEntityAddrNorm    		:= normalize(dEntityAddrTable,2,tNormalizeEntityAddr(left,counter));
dEntityAddrSorted		:= sort(dEntityAddrNorm(z5<>''),z5,prim_Name,prim_Range,pre_dir,post_dir,suffix,sec_range,filepos,local);
lEntityAddrDeDuped		:= dedup(dEntityAddrSorted,z5,prim_Name,prim_Range,pre_dir,post_dir,suffix,sec_range,filepos,local);

kZ5PrimNameRange		:= buildindex(lEntityAddrDeDuped(z5<>''),
							{z5,prim_name,prim_range,filepos},
							lBaseKeyName + 'z5.prim_name.prim_range.key',moxie,overwrite);
kZ5PrimNameSuffixEtc	:= buildindex(lEntityAddrDeDuped(z5<>''),
							{z5,prim_name,suffix,pre_dir,post_dir,prim_range,sec_range,filepos},
							lBaseKeyName + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key',moxie,overwrite);

//end address keys

rCourtNormalized_Layout
 :=
  record
	string2					St		:= '';
	string25				Court	:= '';
	string8					process_date := '';
	big_endian unsigned8	filepos	:= 0;
  end
 ;

rCourtNormalized_Layout tNormalizeCourt(dMoxieFile pInput,unsigned1 pCounter)
 :=
  transform
	self.Court	:= choose(pCounter,
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),1),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),2),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),3),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),4),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),5),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),1) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),2),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),2) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),3),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),3) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),4),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),4) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),5),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),1) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),2) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),3),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),2) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),3) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),4),
						  fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),3) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),4) + ' ' + fGetToken(fRemoveBadJurisdictionTokens(pInput.Court),5)
						  );
	self.st		:= pInput.State_Origin;
	self.process_date := pInput.process_date;
	self.FilePos:= (big_endian unsigned8)pInput.__filepos;
end;

dCourtNorm		:= normalize(dMoxieFileDist,12,tNormalizeCourt(left,counter));
dCourtSorted	:= sort(dCourtNorm(Court<>''),Court,filepos,local);
dCourtDeduped	:= dedup(dCourtSorted,Court,filepos,local);

rStJuriNameAsIs
 :=
  record
	string2					St			:= '';
	string25				Court 		:= '';
	string60				nameasis	:= '';
	big_endian unsigned8	filepos		:= 0;
  end
 ;

rStJuriCN
 :=
  record
	string2					St			:= '';
	string25				Court 		:= '';
	string10				cn			:= '';
	big_endian unsigned8	filepos		:= 0;
  end
 ;

rStJuriLFMName
 :=
  record
	string2					St			:= '';
	string25				Court 		:= '';
	string45				lfmname		:= '';
	big_endian unsigned8	filepos		:= 0;
  end
 ;

rStJuriQADateLFMName
 :=
  record
	string2					St			:= '';
	string25				Court 		:= '';
	string8				    QADate		:= '';
	string45				lfmname		:= '';
	big_endian unsigned8	filepos		:= 0;
  end
 ;
 
rStQADateLFMName
 :=
  record
	string2					St			:= '';
	string8				    QADate		:= '';
	string45				lfmname		:= '';
	big_endian unsigned8	filepos		:= 0;
  end
 ;

rStJuriNameAsIs tJoinCourtToNameAsIs(dCourtDeduped pCourt,dNameAsIsAll_Deduped pNameAsIs)
 :=
  transform
    self.St			:= pCourt.St;
	self.Court		:= pCourt.Court;
	self.NameAsIs	:= pNameAsIs.NameAsIs;
	self.filepos	:= pCourt.filepos;
  end
 ;
 

rStJuriCN tJoinCourtToCN_All(dCourtDeduped pCourt,dCN_ALL_Deduped pCN)
 :=
  transform
    self.St			:= pCourt.St;
	self.Court		:= pCourt.Court;
	self.cn			:= pCN.cn;
	self.filepos	:= pCourt.filepos;
  end
 ;

rStJuriLFMName tJoinCourtToLFMName(dCourtDeduped pCourt,dLFMNameAll_Deduped pLFMName)
 :=
  transform
    self.St			:= pCourt.St;
	self.Court		:= pCourt.Court;
	self.LFMName	:= pLFMName.LFMName;
	self.filepos	:= pCourt.filepos;
  end
 ;
 
rStJuriQADateLFMName tJoinCourtToLFMNamewithQADate(dCourtDeduped pCourt,dLFMNameAll_Deduped pLFMName)
 :=
  transform
    self.St			:= pCourt.St;
	self.Court		:= pCourt.Court;
	self.QADate		:= pcourt.process_date;
	self.LFMName	:= pLFMName.LFMName;
	self.filepos	:= pCourt.filepos;
  end
 ;

rStQADateLFMName tJoinToLFMNamewithQADate(dCourtDeduped pCourt,dLFMNameAll_Deduped pLFMName)
 :=
  transform
    self.St			:= pCourt.St;
	self.QADate		:= pcourt.process_date;
	self.LFMName	:= pLFMName.LFMName;
	self.filepos	:= pCourt.filepos;
  end
 ;

dStJuriNameAsIs			:= join(dCourtDeduped,dOrigStateNameAsIs_Deduped,
							left.filepos = right.filepos,
							tJoinCourtToNameAsIs(left,right),
							local
						   );

dStJuriCN				:= join(dCourtDeduped,dOrigStateCN_Deduped,
							left.filepos = right.filepos,
							tJoinCourtToCN_ALL(left,right),
							local
						   );
							
dStJuriLFMName			:= join(dCourtDeduped,dOrigStateLFMName_Deduped,
							left.filepos = right.filepos,
							tJoinCourtToLFMName(left,right),
							local
						   );

dStJuriQADateLFMName	:= join(dCourtDeduped,dOrigStateLFMName_Deduped,
							left.filepos = right.filepos,
							tJoinCourtToLFMNamewithQADate(left,right),
							local
						   );
						   
dStQADateLFMName	    := join(dCourtDeduped,dOrigStateLFMName_Deduped,
							left.filepos = right.filepos,
							tJoinToLFMNamewithQADate(left,right),
							local
						   );


dStJuriNameAsIs_Sorted	:= sort(dStJuriNameAsIs,st,court,nameasis,filepos,local);	// already filtered out blanks
dStJuriNameAsIs_Deduped	:= dedup(dStJuriNameAsIs_Sorted,st,court,nameasis,filepos,local);	// already filtered out blanks
kStJuriNameAsIs			:= buildindex(dStJuriNameAsIs_Deduped,
										{St,Court,NameAsIs,filepos},
										lBaseKeyName + 'st.juri.nameasis.key',moxie,overwrite,dataset(dMoxieFile));
dStJuriCN_Sorted	:= sort(dStJuriCN,st,court,cn,filepos,local);	// already filtered out blanks
dStJuriCN_Deduped	:= dedup(dStJuriCN_Sorted,st,court,cn,filepos,local);	// already filtered out blanks
kStJuriCN			:= buildindex(dStJuriCN_Deduped,
										{St,Court,cn,filepos},
										lBaseKeyName + 'st.juri.cn.key',moxie,overwrite,dataset(dMoxieFile));

dStJuriLFMName_Sorted	:= sort(dStJuriLFMName,st,court,lfmname,filepos,local);	// already filtered out blanks
dStJuriLFMName_Deduped	:= dedup(dStJuriLFMName_Sorted,st,court,lfmname,filepos,local);	// already filtered out blanks
kStJuriLFMName			:= buildindex(dStJuriLFMName_Deduped,
										{St,Court,LFMName,filepos},
										lBaseKeyName + 'st.juri.lfmname.key',moxie,overwrite,dataset(dMoxieFile));

dStJuriQADateLFMName_Sorted	:= sort(dStJuriQADateLFMName,st,court,QADate,lfmname,filepos,local);	// already filtered out blanks
dStJuriQADateLFMName_Deduped	:= dedup(dStJuriQADateLFMName_Sorted,st,court,QADate,lfmname,filepos,local);	// already filtered out blanks
kStJuriQADateLFMName			:= buildindex(dStJuriQADateLFMName_Deduped,
										{St,Court,QADate,LFMName,filepos},
										lBaseKeyName + 'st.juri.QADate.lfmname.key',moxie,overwrite,dataset(dMoxieFile));

dStQADateLFMName_Sorted	:= sort(dStQADateLFMName,st,QADate,lfmname,filepos,local);	// already filtered out blanks
dStQADateLFMName_Deduped	:= dedup(dStQADateLFMName_Sorted,st,QADate,lfmname,filepos,local);	// already filtered out blanks
kStQADateLFMName			:= buildindex(dStQADateLFMName_Deduped,
										{St,QADate,LFMName,filepos},
										lBaseKeyName + 'st.QADate.lfmname.key',moxie,overwrite,dataset(dMoxieFile));

export Out_Moxie_Party_Keys
 :=
  parallel(
			 kCaseEntityKey
			,kCaseStOriginNo
			,kNameAsIs
			,kCN
			,kStNameAsIs
			,kStCN			
			,kLFMName
			,kStLFMName
			,kStCityLFMName
			,kStCityNameAsIs
			,kStCityCN
			,kZ5PrimNameRange
			,kZ5PrimNameSuffixEtc
			,kStJuriNameAsIs
			,kStJuriCN
			,kStJuriLFMName
			,kStJuriQADateLFMName
			,kStQADateLFMName
		   )
 ;