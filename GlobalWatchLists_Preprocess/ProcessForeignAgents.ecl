IMPORT GlobalWatchLists_Preprocess, STD, lib_StringLib, ut, BO_address, Address;

EXPORT ProcessForeignAgents := FUNCTION

IMPORT GlobalWatchLists_Preprocess, STD, lib_StringLib, ut, BO_address, Address;

//EXPORT ProcessForeignAgents := FUNCTION

	dFAPrincipals	:= GlobalWatchLists_Preprocess.Files.dsFAFP;
	dFARegistrants	:= GlobalWatchLists_Preprocess.Files.dsFARE;
	dFAShortFormRegs := GlobalWatchLists_Preprocess.Files.dsFASRE;
	
	//History file
	l_hist	:= RECORD
		string	Country;
		string	Registrant_ID;
		string	Registrant;
	END;
	
	dFAHist :=  DATASET(GlobalWatchLists_Preprocess.root+'foreign_agents_registration',l_hist,
											CSV(HEADING(0),SEPARATOR('\t'),TERMINATOR(['\n'])))(registrant_id <> '');
	dedHist	:= dedup(sort(dFAHist,Registrant_ID,Registrant),Registrant_ID,Registrant);
	
	//Parse Foreign Principal Address
	l_parseAddr	:= RECORD
		GlobalWatchLists_Preprocess.Layouts.rFAPrincipals;
		string	Address_Line_1;
		string	Address_Line_2;
		string	Address_Line_3;
		string	ZipCode;
	END;
	
	l_parseAddr xfrmAddress(dFAPrincipals L) := TRANSFORM
		integer WordCount	:= STD.Str.FindCount(REGEXREPLACE('^<br>',L.Address,''),'<br>');
		tempAddress			:= ut.CleanSpacesAndUpper(L.Address);
		self.Address 		:= tempAddress;
		self.State			:= ut.CleanSpacesAndUpper(L.State);
		TempAddr1						:= IF(WordCount = 0, tempAddress, tempAddress[1..STD.Str.Find(L.Address,'<br>',1) - 1]);
		self.Address_Line_1 := REGEXREPLACE('^R>|<BR>|< BR>| BR>|<BR |&NBSP|;',TempAddr1,'');
		TempAddr2						:= IF(WordCount = 1, tempAddress[STD.Str.Find(L.Address,'<br>',1)..STD.Str.Find(L.Address,'&nbsp;&nbsp;',1) - 1],
														IF(WordCount = 2, tempAddress[STD.Str.Find(L.Address,'<br>',1)..STD.Str.Find(L.Address,'<br>',2) - 1],''));
		self.Address_Line_2	:= REGEXREPLACE('^R>|<BR>|< BR>| BR>|<BR |&NBSP|;|&N$',TempAddr2,'');
		TempAddr3						:= IF(WordCount = 2, tempAddress[STD.Str.Find(L.Address,'<br>',2)..STD.Str.Find(L.Address,'&nbsp;&nbsp;',1) - 1],'');
		self.Address_Line_3	:= REGEXREPLACE('^R>|<BR>|< BR>| BR>|<BR |&NBSP|;|&N$',TempAddr3,'');
		self.ZipCode				:= REGEXREPLACE('&nbsp;&nbsp;',IF(REGEXFIND('&nbsp;&nbsp;[0-9]+$',L.Address),REGEXFIND('&nbsp;&nbsp;[0-9]+$',L.Address,0),''),'');
		self := L;
	END;
	
	pFPAddr	:= project(dFAPrincipals, xfrmAddress(left));
					
	//Join with Principal and Registrants file
	GlobalWatchLists_Preprocess.Layouts.rFAJoinRE_FP xfrmREFP(dFARegistrants L, pFPAddr R) := TRANSFORM
		self.Country				:= ut.CleanSpacesAndUpper(R.Country_Location_Represented);
		self.Registrant_ID	:= trim(L.Registration_Num,left,right);
		self.Registrant			:= ut.CleanSpacesAndUpper(L.Registrant);
		self.Registrant_Terminated	:= '';
		self.Address_Line_1	:= REGEXREPLACE('^BR>|<$|<B$',trim(R.Address_Line_1),'');
		self.Address_Line_2	:= IF(R.ZipCode <> '' and R.Address_Line_3 = '',
														trim(R.Address_Line_2,left,right)+' '+trim(R.State,left,right)+' '+trim(R.ZipCode,left,right),
														R.Address_Line_2);
		self.Address_Line_3 := IF(R.ZipCode <> '' and R.Address_Line_3 <> '',
														trim(R.Address_Line_3,left,right)+' '+trim(R.State,left,right)+' '+trim(R.ZipCode,left,right),
														R.Address_Line_3);
		self.Foreign_Principal	:= ut.CleanSpacesAndUpper(R.Foreign_Principal);
		self.orig_raw_name	:= ut.CleanSpacesAndUpper(L.Registrant);
	END;

	jREFP	:= JOIN(SORT(DISTRIBUTE(dFARegistrants,hash(Registration_Num)),Registration_Num,local),
								SORT(DISTRIBUTE(pFPAddr,hash(Registration_Num)),Registration_Num,local),
								trim(left.Registration_Num,left,right) = trim(right.Registration_Num,left,right),
								xfrmREFP(left,right),left outer,local);
								
	//Normalize AKA and add sequence_num for SRE
	l_AddSeq	:= RECORD
		integer		rec_num;
		string		Registrant;
		string		Registrant_ID;
		string		Short_Form_Name;
		string		Name_Type;
		string		Short_Form_Terminated;
		string		orig_raw_name;
	END;
	
	l_AddSeq	xAddSeq(dFAShortFormRegs L, integer C) := TRANSFORM
		self.rec_num		:= C;
		self.Registrant	:= ut.CleanSpacesAndUpper(L.Registrant);
		self.Short_Form_Name := ut.CleanSpacesAndUpper(L.Short_Form_Name);
		self.Short_Form_Terminated := 'N';
		self.orig_raw_name := ut.CleanSpacesAndUpper(L.Short_Form_Name);
		self := [];
	END;
	
	pAddSeq	:= PROJECT(dFAShortFormRegs, xAddSeq(left,counter));
	
	l_AddSeq	xfrmSRE(pAddSeq L, integer C) := TRANSFORM
		TempName						 := CHOOSE(C,REGEXREPLACE('\\((.*)\\)',L.Short_Form_Name,''),
																		IF(REGEXFIND('\\((.*)\\)',L.Short_Form_Name),
																		REGEXREPLACE('\\((.*)\\)',L.Short_Form_Name[1..STD.Str.Find(L.Short_Form_Name,',',1)],'')+' '+REGEXFIND('\\((.*)\\)',L.Short_Form_Name,1)
																		,''));
		self.Short_Form_Name := STD.Str.CleanSpaces(TempName);
		self.Name_Type	:= CHOOSE(C,'PRIMARY','AKA');
		self := L;
	END;
	
	nShortFormRegs	:= NORMALIZE(pAddSeq,IF(REGEXFIND('\\((.*)\\)',left.Short_Form_Name),2,1),
																xfrmSRE(left,counter));
																
	
	//Join Registrant/Principal to short form and historical to short form.
	//Registration_ID must be found in Registrants file or record will be rejected
	l_AddSeq joinREFP_SRE(jREFP L, 	nShortFormRegs R) := TRANSFORM
		self.Registrant 			:= L.Registrant;
		self.Registrant_ID 		:= L.Registrant_ID;
		self.rec_num					:= R.rec_num;
		self.Short_Form_Name 	:= R.Short_Form_Name;
		self.Name_type				:= R.Name_Type;
		self.Short_Form_Terminated	:= R.Short_Form_Terminated;
		self.orig_raw_name		:= R.orig_raw_name;
		self	:= [];
	END;
	
	jRE_SRE	:= join(sort(jREFP,Registrant),
									sort(nShortFormRegs,Registrant),
									trim(left.Registrant,left,right) = trim(right.Registrant,left,right),
									joinREFP_SRE(left,right));
									
	l_AddSeq joinSRE_Hist(nShortFormRegs L, dedHist R):= TRANSFORM
		self.Registrant 			:= R.Registrant;
		self.Registrant_ID 		:= R.Registrant_ID;
		self.rec_num					:= L.rec_num;
		self.Short_Form_Name 	:= L.Short_Form_Name;
		self.Name_type				:= L.Name_Type;
		self.Short_Form_Terminated	:= L.Short_Form_Terminated;
		self.orig_raw_name		:= L.Short_Form_Name;
	END;
	
	jSRE_hist	:= join(sort(nShortFormRegs,Registrant),
										sort(dedHist,Registrant),
										trim(left.Registrant,left,right) = ut.CleanSpacesAndUpper(right.Registrant),
										joinSRE_Hist(left,right),left outer);
										
	//Combine both joins
	JoinSRE	:= jRE_SRE+jSRE_hist;
	dJoinSRE := dedup(sort(JoinSRE,Registrant_ID,Registrant),all);
	
	//Format into common output - Registrants
	GlobalWatchLists_Preprocess.rOutLayout xfrmCommonRE(jREFP Input) := TRANSFORM
		self.pty_key				:= 'FARA'+Input.Registrant_ID;
		self.source					:= 'Foreign Agents Registration Act';
		self.orig_pty_name	:= ut.CleanSpacesAndUpper(Input.Registrant);
		self.country				:= ut.CleanSpacesAndUpper(STD.Str.FindReplace(REGEXREPLACE('\f',Input.Country,''),'RNATIONAL','INTERNATIONAL'));
		self.addr_1					:= ut.CleanSpacesAndUpper(Input.Address_Line_1);
		self.addr_2					:= ut.CleanSpacesAndUpper(Input.Address_Line_2);
		self.addr_3					:= ut.CleanSpacesAndUpper(Input.Address_Line_3);
		self.remarks_1			:= ut.CleanSpacesAndUpper(IF(Input.Country <> '', 'COUNTRY REPRESENTED: '+trim(Input.Country,left,right),''));
		self.remarks_2			:= ut.CleanSpacesAndUpper(IF(Input.Foreign_Principal <> '','FOREIGN PRINCIPAL: '+Input.Foreign_Principal[1..75],''));
		self.remarks_3			:= ut.CleanSpacesAndUpper(IF(Input.Foreign_Principal <> '',Input.Foreign_Principal[76..],''));
		IsCompany						:= GlobalWatchLists_Preprocess.is_company(Input.Registrant);
		ClnName							:= Address.CleanPersonLFM73(Input.Registrant);
		self.cname_clean		:= ut.CleanSpacesAndUpper(IF(IsCompany = 1, Input.Registrant,''));
		self.pname_clean		:= IF(IsCompany = 0, ClnName,'');
		line1								:= STD.Str.CleanSpaces(IF(Input.Address_Line_3 = '',Input.Address_Line_1
																								,IF(Input.Address_Line_3 <> '',trim(Input.Address_Line_1,left,right)+' '+trim(Input.Address_Line_2)
																								,'')));
		line2								:= STD.Str.CleanSpaces(IF(Input.Address_Line_3 = '',Input.Address_Line_2,Input.Address_Line_3));
		ClnAddr							:= bo_address.CleanAddress182(line1, line2);
		self.addr_clean			:= if(ClnAddr[179..180] <> 'E5' and 
															ClnAddr[179..182] <> 'E213' and
															ClnAddr[179..182]	<> 'E101', ClnAddr, '');
		self.date_first_seen 	:= GlobalWatchLists_Preprocess.Versions.Foreign_Agents_Version;
		self.date_last_seen 	:= GlobalWatchLists_Preprocess.Versions.Foreign_Agents_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.Foreign_Agents_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.Foreign_Agents_Version;
		self.orig_entity_id		:= ut.CleanSpacesAndUpper(Input.Registrant_ID);
		self.orig_first_name	:= ut.CleanSpacesAndUpper(REGEXREPLACE(', JR\\.|JR\\.,|JR\\.',
																		IF(self.pname_clean <> '',Input.Registrant[STD.Str.Find(Input.Registrant,',',1)+1..],''),''));
		self.orig_last_name		:= 	ut.CleanSpacesAndUpper(IF(self.pname_clean <> '',Input.Registrant[1..STD.Str.Find(Input.Registrant,',',1) - 1],''));
		self.orig_giv_designator	:= IF(self.cname_clean <> '','G','I');
		self.orig_address_line_1 	:= ut.CleanSpacesAndUpper(Input.Address_Line_1);
		self.orig_address_line_2 	:= ut.CleanSpacesAndUpper(Input.Address_Line_2);
		self.orig_address_line_3  := ut.CleanSpacesAndUpper(Input.Address_Line_3);
		self.orig_foreign_principal	:= ut.CleanSpacesAndUpper(Input.Foreign_Principal);
		self.orig_registrant_terminated_flag := 'N';
		self.orig_foreign_principal_terminated_flag := 'N';
		self.orig_raw_name	:= ut.CleanSpacesAndUpper(Input.orig_raw_name);
		self := [];
	END;
	
	pREFP	:= project(jREFP, xfrmCommonRE(left));
	
	//Format into common output - Short Form Registrants
	GlobalWatchLists_Preprocess.rOutLayout xfrmCommonSRE(dJoinSRE Input) := TRANSFORM
		self.pty_key				:= 'FARA'+Input.Registrant_ID+'-'+Input.rec_num;
		self.source					:= 'Foreign Agents Registration Act';
		self.orig_pty_name	:= ut.CleanSpacesAndUpper(Input.Short_Form_Name);
		self.country				:= '';
		self.name_type			:= ut.CleanSpacesAndUpper(Input.Name_Type);
		self.addr_1					:= '';
		self.addr_2					:= '';
		self.addr_3					:= '';
		self.remarks_1			:= ut.CleanSpacesAndUpper(IF(Input.Registrant <> '','REGISTRANT: '+Input.Registrant,''));
		self.remarks_2			:= '';
		self.remarks_3			:= '';
		ClnName							:= Address.CleanPersonLFM73(Input.Registrant);
		self.cname_clean		:= '';
		self.pname_clean		:= IF(STD.Str.Find(Input.Short_Form_Name,',',1)>0,Address.CleanPersonLFM73(Input.Short_Form_Name)
															,Address.CleanPersonFML73(Input.Short_Form_Name));
		self.addr_clean			:= '';
		self.date_first_seen 	:= GlobalWatchLists_Preprocess.Versions.Foreign_Agents_Version;
		self.date_last_seen 	:= GlobalWatchLists_Preprocess.Versions.Foreign_Agents_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.Foreign_Agents_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.Foreign_Agents_Version;
		self.orig_entity_id		:= ut.CleanSpacesAndUpper(Input.Registrant_ID);
		self.orig_first_name	:= ut.CleanSpacesAndUpper(Input.Short_Form_Name[STD.Str.Find(Input.Short_Form_Name,',',1)+1..]);
		self.orig_last_name		:= ut.CleanSpacesAndUpper(Input.Short_Form_Name[1..STD.Str.Find(Input.Short_Form_Name,',',1) - 1]);
		self.orig_aka_id			:= ut.CleanSpacesAndUpper(IF(Input.name_type = 'AKA',Input.Registrant_ID+'-'+Input.rec_num,''));
		self.orig_aka_type		:= IF(Input.name_type = 'AKA','AKA','');
		self.orig_giv_designator	:= 'I';
		self.orig_membership_1 := ut.CleanSpacesAndUpper(Input.Registrant);
		self.orig_short_form_terminated_flag := Input.Short_Form_Terminated;
		self.orig_raw_name	:= ut.CleanSpacesAndUpper(Input.orig_raw_name);
		self := [];
	END;
	
	pSRE	:= project(dJoinSRE, xfrmCommonSRE(left));	
	
	//Combine both output's and final dedup
	CommonAll	:=	pREFP + pSRE;
	dCommonAll	:= dedup(sort(CommonAll, pty_key,orig_pty_name,addr_1,addr_2),all);	
	
	RETURN dCommonAll(orig_pty_name <> '');
	
END;