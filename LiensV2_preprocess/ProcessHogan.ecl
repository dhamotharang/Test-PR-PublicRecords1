IMPORT LiensV2_preprocess, LiensV2, ut, STD, Address, NID, VersionControl;

EXPORT ProcessHogan := FUNCTION

	process_date := (string)STD.Date.Today();
	
	ValidFileType := ['AC','AJ','AP','AR','AS','BL','BN','BR','BW','CD','CE','CF','CJ','CP','CR','CS','CT','DD','DF','DS',
										'FC','FD','FE','FF','FJ','FK','FN','FP','FR','FS','FT','FV','GN','HL','HR','HW','IE','IL','IR',
										'KL','KR','KW','LP','LR','LW','ML','MM','MW','RC','RD','RF','RL','RM','RS','SC','SE','SR','ST','SZ',
										'TC','TP','TR','TW','TZ','VF','VJ','WE','WR'];
	
	//Filter valid file types
	ds_in	:= LiensV2_Preprocess.Files.Hogan(filetypeid in ValidFileType);
	
RemoveLeadingZeros(string in_str) := FUNCTION
	first_non0 := stringlib.stringfilterOut(in_str,'0')[1];
	first_non0_position := stringlib.StringFind(in_str, first_non0, 1);
	out_str := in_str[(unsigned)first_non0_position..];
	return out_str;
END;
	
	InvalidName	:= '^(NA |N A|N/A)';
	//Clean/uppercase fields
	LiensV2_preprocess.Layouts_Hogan.raw_in CleanFields(ds_in L) := TRANSFORM
		self.ADDDELFLAG		:= ut.CleanSpacesAndUpper(L.ADDDELFLAG);
		self.ENTITYTYPE		:= ut.CleanSpacesAndUpper(L.ENTITYTYPE);
		// self.AKA_YN				:= ut.CleanSpacesAndUpper(L.AKA_YN);
		self.ASSOCCODE		:= ut.CleanSpacesAndUpper(L.ASSOCCODE);
		self.COURTID			:= ut.CleanSpacesAndUpper(L.COURTID);
		self.FILETYPEID		:= ut.CleanSpacesAndUpper(L.FILETYPEID);
		self.CASENUMBER		:= REGEXREPLACE('[^A-Z0-9 ]',RemoveLeadingZeros(ut.CleanSpacesAndUpper(L.CASENUMBER)),'');
		self.BOOK					:= REGEXREPLACE('[^A-Z0-9 ]',RemoveLeadingZeros(ut.CleanSpacesAndUpper(L.BOOK)),'');
		self.PAGE					:= REGEXREPLACE('[^A-Z0-9 ]',RemoveLeadingZeros(ut.CleanSpacesAndUpper(L.PAGE)),'');
		vActionDate				:= STD.Date.IsValidDate((INTEGER)L.ACTIONDATE);
		self.ACTIONDATE		:= IF(vActionDate,L.ACTIONDATE,'');
		self.ORIGLIEN			:= IF(trim(L.ORIGLIEN) = '00000000','',TRIM(L.ORIGLIEN,left,right));
		self.AMOUNT				:= RemoveLeadingZeros(L.AMOUNT);
		self.ASSETS				:= TRIM(L.ASSETS,left,right);
		self.PLAINTIFF		:= ut.CleanSpacesAndUpper(REGEXREPLACE(InvalidName,L.PLAINTIFF,'',NOCASE));
		self.ATTORNEY			:= ut.CleanSpacesAndUpper(REGEXREPLACE(InvalidName,L.ATTORNEY,'',NOCASE));
		self.ATTORPHONE		:= ut.CleanPhone(L.ATTORPHONE);
		self.S341DATE			:= ut.CleanSpacesAndUpper(L.S341DATE);
		self.JUDGE				:= ut.CleanSpacesAndUpper(L.JUDGE);
		self.OTHERCASE		:= REGEXREPLACE('[^A-Z0-9 ]',RemoveLeadingZeros(ut.CleanSpacesAndUpper(L.OTHERCASE)),'');
		self.SSN					:= IF(TRIM(L.SSN) = '000000000','',TRIM(L.SSN,left,right));;
		self.DEFNAME			:= ut.CleanSpacesAndUpper(REGEXREPLACE(InvalidName,L.DEFNAME,'',NOCASE));
		self.GENERATION		:= ut.CleanSpacesAndUpper(L.GENERATION);
		self.ADDRESS			:= ut.CleanSpacesAndUpper(L.ADDRESS);
		self.CITY					:= ut.CleanSpacesAndUpper(L.CITY);
		self.STATE				:= ut.CleanSpacesAndUpper(L.STATE);
		self.ZIP					:= ut.CleanSpacesAndUpper(L.ZIP);
		vUploadDate				:= STD.Date.IsValidDate((INTEGER)L.UPLOADDATE);
		self.UPLOADDATE		:= IF(VUploadDate,L.UPLOADDATE,'');
		self.UNLAWDETYN		:= ut.CleanSpacesAndUpper(L.UNLAWDETYN);
		self.ORIGCASE			:= REGEXREPLACE('[^A-Z0-9 ]',RemoveLeadingZeros(ut.CleanSpacesAndUpper(L.ORIGCASE)),'');
		self.ORIGBOOK			:= REGEXREPLACE('[^A-Z0-9 ]',RemoveLeadingZeros(ut.CleanSpacesAndUpper(L.ORIGBOOK)),'');
		self.ORIGPAGE			:= REGEXREPLACE('[^A-Z0-9 ]',RemoveLeadingZeros(ut.CleanSpacesAndUpper(L.ORIGPAGE)),'');
		self.ATYADDRESS		:= ut.CleanSpacesAndUpper(L.ATYADDRESS);
		// self.ATYCITY			:= ut.CleanSpacesAndUpper(L.ATYCITY);
		self.ATYSTATE			:= ut.CleanSpacesAndUpper(L.ATYSTATE);
		self.ATYZIP				:= ut.CleanSpacesAndUpper(L.ATYZIP);
		self.AVAIL				:= ut.CleanSpacesAndUpper(L.AVAIL);
		self.ACTIONTYPE		:= ut.CleanSpacesAndUpper(L.ACTIONTYPE);
		self.S341TIM			:= ut.CleanSpacesAndUpper(L.S341TIM);
		self.CTYRESID			:= ut.CleanSpacesAndUpper(L.CTYRESID);
		self.STL_TYPE			:= ut.CleanSpacesAndUpper(L.STL_TYPE);
		self.VOL_INVOL		:= ut.CleanSpacesAndUpper(L.VOL_INVOL);
		self.RMSID				:= ut.CleanSpacesAndUpper(L.RMSID);
		self.EMPLOYER_NAME	:= ut.CleanSpacesAndUpper(L.EMPLOYER_NAME);
		// self.lf						:= L.lf;
		vDOB	:=	STD.Date.IsValidDate((INTEGER)L.DOB);
		SELF.DOB	:=	IF(vDOB,L.DOB,'');
		vCollection_Date	:=	STD.Date.IsValidDate((INTEGER)L.Collection_Date);
		SELF.Collection_Date	:=	IF(vCollection_Date,L.Collection_Date,'');
		SELF.CaseLinkID		:= ut.CleanSpacesAndUpper(L.CaseLinkID);
		SELF.Unused	:=	'';
	END;
	
	CleanUpperDS	:= PROJECT(ds_in, CleanFields(left));
	
	remove_junk := 'GUARANTOR| MEMBER|GEN PTR| PTRS| PTR|\\(FIRST NAME UNKNOWN\\)|\\(FIRST UNKNOWN\\)|NOT AVAILABLE|NOT AVAIL|UNKNOWN';

	//Create TMSID/RMSID field and clean address	
	LiensV2.Layout_Liens_Hogan xfrmTM_RMSID(LiensV2_preprocess.Layouts_Hogan.raw_in L) := TRANSFORM
		self.process_date	:= process_date;
		self.orig_RMSID	:= L.RMSID;
		TempIdentifier	:= MAP(trim(L.OTHERCASE) != '' AND trim(L.CASENUMBER) !='' AND trim(L.ORIGCASE) !='' => 0,
														trim(L.OTHERCASE) = '' AND trim(L.CASENUMBER) !='' AND trim(L.ORIGCASE) !='' => 1,
														trim(L.OTHERCASE) = '' AND trim(L.CASENUMBER) !='' AND trim(L.ORIGCASE) ='' => 2,
														trim(L.OTHERCASE) = '' AND trim(L.CASENUMBER) ='' AND trim(L.ORIGCASE) !='' => 3,
														trim(L.OTHERCASE) != '' AND trim(L.CASENUMBER) ='' AND trim(L.ORIGCASE) ='' => 4,
														trim(L.OTHERCASE) = '' AND trim(L.CASENUMBER) ='' AND trim(L.ORIGCASE) ='' => 4,
														trim(L.OTHERCASE) != '' AND trim(L.CASENUMBER) !='' AND trim(L.ORIGCASE) ='' => 5,
														trim(L.OTHERCASE) != '' AND trim(L.CASENUMBER) ='' AND trim(L.ORIGCASE) !='' => 6,7);
		STRING50	OldRMSID	:= IF(TempIdentifier in [0,1,3,6],'HGR'+trim(L.ORIGCASE,left,right)+trim(L.AMOUNT,left,right)+trim(L.COURTID,left,right)+trim(L.FILETYPEID,left,right),
											IF(TempIdentifier in [2,5],'HGR'+trim(L.CASENUMBER,left,right)+trim(L.AMOUNT,left,right)+trim(L.COURTID,left,right)+trim(L.FILETYPEID,left,right),
												IF(TempIdentifier = 4 AND trim(L.ORIGBOOK,left,right) != '' AND trim(L.ORIGPAGE,left,right) !=''
														,'HGR'+HASH(L.DEFNAME,L.ACTIONDATE,L.AMOUNT,L.ORIGBOOK,L.ORIGPAGE,L.COURTID,L.FILETYPEID),
														IF(TempIdentifier = 4 AND trim(L.ORIGBOOK,left,right) = '' AND trim(L.ORIGPAGE,left,right) =''
															,'HGR'+HASH(L.DEFNAME,L.ACTIONDATE,L.AMOUNT,L.BOOK,L.PAGE,L.COURTID,L.FILETYPEID),''))));
		STRING50	OldTMSID	:= IF(TempIdentifier in [0,1,3,6],'HG'+trim(L.ORIGCASE,left,right)+trim(L.AMOUNT,left,right)+trim(L.COURTID,left,right),
											IF(TempIdentifier in [2,5],'HG'+trim(L.CASENUMBER,left,right)+trim(L.AMOUNT,left,right)+trim(L.COURTID,left,right),
												IF(TempIdentifier = 4 AND trim(L.ORIGBOOK,left,right) != '' AND trim(L.ORIGPAGE,left,right) !=''
														,'HG'+HASH(L.DEFNAME,L.ACTIONDATE,L.AMOUNT,L.ORIGBOOK,L.ORIGPAGE,L.COURTID),
														IF(TempIdentifier = 4 AND trim(L.ORIGBOOK,left,right) = '' AND trim(L.ORIGPAGE,left,right) =''
															,'HG'+HASH(L.DEFNAME,L.ACTIONDATE,L.AMOUNT,L.BOOK,L.PAGE,L.COURTID),''))));
		STRING50	NewRMSID	:=	'HGR'+TRIM(L.CaseLinkID,LEFT,RIGHT)+TRIM(L.FILETYPEID,LEFT,RIGHT);
		STRING50	NewTMSID	:=	'HG'+TRIM(L.CaseLinkID,LEFT,RIGHT);
		//	We're not ready to use the new TMS/RMSID
		// self.RMSID	:= IF(TRIM(L.CaseLinkID,LEFT,RIGHT)='',OldRMSID,NewRMSID); 
		// self.TMSID	:= IF(TRIM(L.CaseLinkID,LEFT,RIGHT)='',OldTMSID,NewTMSID);
		self.RMSID	:= IF(TRIM(L.CaseLinkID,LEFT,RIGHT)='',OldRMSID,OldRMSID);
		self.TMSID	:= IF(TRIM(L.CaseLinkID,LEFT,RIGHT)='',OldTMSID,OldTMSID);
		self.RMSID_old	:=	OldRMSID;
		self.TMSID_old	:=	OldTMSID;		
		self.PLAINTIFF						:= STD.Str.CleanSpaces(REGEXREPLACE('^,',REGEXREPLACE(remove_junk,L.PLAINTIFF,''),''));
		SELF.INDIVBUSUN	:=	L.ENTITYTYPE[1];
		SELF.AKA_YN	:=	L.ENTITYTYPE[2];
		self.DEFNAME							:= STD.Str.CleanSpaces(IF(SELF.INDIVBUSUN ='I' AND (SELF.AKA_YN = ' ' OR SELF.AKA_YN = 'I'),
																												REGEXREPLACE(remove_junk,L.DEFNAME,''), L.DEFNAME));
		self.clean_defendent_addr	:= Address.CleanAddress182(TRIM(L.ADDRESS,left,right),TRIM(L.CITY,left,right) + ', '+
																															 TRIM(L.STATE,left,right) +' '+ TRIM(L.ZIP,left,right));
		self.clean_atty_addr			:= Address.CleanAddress182(TRIM(L.ATYADDRESS,left,right),//TRIM(L.ATYCITY,left,right) + ', '+
																															 TRIM(L.ATYSTATE,left,right) +' '+ TRIM(L.ATYZIP,left,right));
		self.GENERATION				:= LiensV2_preprocess.Code_lkps.HG_Gen(TRIM(L.generation,left,right));
		self.court_desc				:= IF(L.COURTID = 'MSHINC3','MISSISSIPPI DEPT OF REVENUE', LiensV2_preprocess.Code_lkps.HG_Court(TRIM(L.COURTID,left,right))); //MSHINC3 is a new court/source
		self.filingtype_desc	:= LiensV2_preprocess.Code_lkps.HG_FileType(TRIM(L.FILETYPEID,left,right));
		self	:= L;
		self := [];
	END;
	
	CreateTM_RMSID	:= PROJECT(CleanUpperDS, xfrmTM_RMSID(left));
	
	//Normalize AKA names
	AKAPattern	:= '(@| C/O| ATTN| ATT | %| AKA |A/K/A | FKA |F/K/A | DBA |D/B/A |;| T/A | NKA |N/K/A )';
	
	
	LiensV2.Layout_Liens_Hogan PlaintAKANames(CreateTM_RMSID L, integer C) := TRANSFORM
		ClnPlaintiff	:= REGEXREPLACE(AKAPattern,STD.Str.FindReplace(L.PLAINTIFF,':',''),'~');
		TempPlaintiff	:= IF(REGEXFIND('~',ClnPlaintiff),ClnPlaintiff[1..STD.Str.Find(ClnPlaintiff,'~',1)-1],ClnPlaintiff);
		TempAKA				:= IF(REGEXFIND('~',ClnPlaintiff),ClnPlaintiff[STD.Str.Find(ClnPlaintiff,'~',1)+1..],'');
		self.PLAINTIFF	:= REGEXREPLACE('^(,:/)|(,:/)$',CHOOSE(C,TempPlaintiff,TempAKA),'');
		self := L;
	END;
	
	nPlaintiff	:= NORMALIZE(CreateTM_RMSID,2,PlaintAKANames(LEFT,COUNTER))(PLAINTIFF <> '');
	
	LiensV2.Layout_Liens_Hogan DefAKANames(nPlaintiff L, integer C) := TRANSFORM
		ClnDefendant	:= REGEXREPLACE(AKAPattern,STD.Str.FindReplace(L.DEFNAME,':',''),'~');
		TempDefendant	:= IF(REGEXFIND('~',ClnDefendant),ClnDefendant[1..STD.Str.Find(ClnDefendant,'~',1)-1],ClnDefendant);
		TempAKA				:= IF(REGEXFIND('~',ClnDefendant),ClnDefendant[STD.Str.Find(ClnDefendant,'~',1)+1..],'');
		self.DEFNAME	:= REGEXREPLACE('^(,:/)|(,:/)$',CHOOSE(C,TempDefendant,TempAKA),'');
		self := L;
	END;
	
	nDef	:= NORMALIZE(nPlaintiff,2,DefAKANames(LEFT,COUNTER))(DEFNAME <> '');
	
	SrtDedup	:= DEDUP(SORT(nDef,RMSID,PLAINTIFF,DEFNAME),ALL) : INDEPENDENT;
	
	//Clean Plaintiff, Defendant, Attorney names
	person_flags := ['P', 'D'];
	business_flags := ['B', 'U', 'I'];
	
	NID.Mac_CleanFullNames(SrtDedup, CleanDef, DEFNAME, _nameorder := 'L',	includeInRepository:=false, normalizeDualNames:=false);
	
	LiensV2.Layout_Liens_Hogan xfmDefName(CleanDef L) := TRANSFORM
		isCompany 	:= IF(L.INDIVBUSUN ='I' AND (TRIM(L.AKA_YN) = '' OR L.AKA_YN = 'I'),'0','1');
		self.clean_def_pname				:= IF(L.nametype IN person_flags, L.cln_title+L.cln_fname+L.cln_mname+L.cln_lname+L.cln_suffix+'  ','');
		self.clean_def_cname				:= IF(isCompany = '1' OR L.nametype IN business_flags, L.DEFNAME,'');
		self.clean_plaintiff_pname	:= '';
		self.clean_plaintiff_cname 	:= '';
 		self.clean_atty_pname 			:= '';
		self.clean_atty_cname 			:= '';
		self := L;
	END;
	
	ClnDef_out := PROJECT(CleanDef, xfmDefName(left)) : INDEPENDENT;
	
	NID.Mac_CleanFullNames(ClnDef_out, CleanPlaint, PLAINTIFF, _nameorder := 'L',	includeInRepository:=false, normalizeDualNames:=false);
	
	LiensV2.Layout_Liens_Hogan xfmPlaintName(CleanPlaint L) := TRANSFORM
		self.clean_plaintiff_pname	:= IF(L.nametype IN person_flags, L.cln_title+L.cln_fname+L.cln_mname+L.cln_lname+L.cln_suffix+'  ','');
		self.clean_plaintiff_cname := IF(L.nametype IN business_flags,L.PLAINTIFF,'');
 		self.clean_atty_pname 			:= '';
		self.clean_atty_cname 			:= '';
		self := L;
	END;
	
	ClnPlaint_out	:= PROJECT(CleanPlaint, xfmPlaintName(left)): INDEPENDENT;
	
		NID.Mac_CleanFullNames(ClnPlaint_out, CleanAtty, ATTORNEY, _nameorder := 'L',	includeInRepository:=false, normalizeDualNames:=false);
	
	LiensV2.Layout_Liens_Hogan xfmAttyName(CleanAtty L) := TRANSFORM
 		self.clean_atty_pname 			:= IF(L.nametype IN person_flags, L.cln_title+L.cln_fname+L.cln_mname+L.cln_lname+L.cln_suffix+'  ','');
		self.clean_atty_cname 			:= IF(L.nametype IN business_flags,L.ATTORNEY,'');
		self := L;
	END;
	
	ClnNames_out	:= PROJECT(CleanAtty, xfmAttyName(left));
	
	//output(CleanDef);
	dsHogan_out	:= output(ClnNames_out,,root + process_date + '::hgn::Okclien',overwrite);
	
	//Build Superfile
	build_super 	:= sequential(
										 FileServices.StartSuperFileTransaction(),
										 FileServices.ClearSuperFile(root + 'hgn::Okclien'),
										 FileServices.AddSuperFile(root + 'hgn::Okclien',root + process_date + '::hgn::Okclien'),
										 FileServices.FinishSuperFileTransaction()
												);
	
	RETURN sequential(dsHogan_out, build_super);
	
END;
	

