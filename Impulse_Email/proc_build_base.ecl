IMPORT ut
     , _control
		 , address
		 , AID
		 , DID_Add
		 , header_slimsort
		 , lib_stringlib
		 , idl_header
		 , mdr
		 , std;
		 
export proc_build_base(string file_date)
	:=
		FUNCTION
		
	rsImpulseEmail	:=	fn_rollup_Impulse_Email(file_date);
	// rsImpulseEmail	:=	files.file_Impulse_Email_In;
	
	layout_Impulse_Email_Seq
		:=
			RECORD, MAXLENGTH(8192)
				unsigned6 append_seqNum	:=	0;
				layouts.layout_Impulse_Email_Dates_append;
			END;
	
	rsImpulseEmailSeqIn	:=	PROJECT(rsImpulseEmail, layout_Impulse_Email_Seq);
	
	ut.MAC_Sequence_Records(rsImpulseEmailSeqIn, append_seqNum, rsImpulseEmailSeq);

	rsImpulseEmailSeqDist	:=	DISTRIBUTE(rsImpulseEmailSeq, HASH(append_seqNum));
	rsImpulseEmailSeqSrt	:=	SORT(rsImpulseEmailSeqDist, append_seqNum, LOCAL);

	layout_Impulse_Email_cleaner_input_Seq
		:=
			RECORD
				unsigned6 append_seqNum	:=	0;
				layouts.layout_Impulse_Email_cleaner_input;
				layouts.layout_Impulse_Email_Prepped_DID_AID;
			END;
	
	layout_Impulse_Email_cleaner_input_Seq	tSprayedPreClean(rsImpulseEmailSeq pInput)
		:=
			TRANSFORM
				self.RawAID										:=	IF(pInput.RawAID <> 0, pInput.RawAID, 0);
				self.Append_Prep_Address1 		:= lib_StringLib.StringLib.StringToUpperCase(trim(pInput.ADDRESS1,left,right))
																					+ ' '
																					+ lib_StringLib.StringLib.StringToUpperCase(trim(pInput.ADDRESS2,left,right));
				self.Append_Prep_Address_Last 	:= lib_StringLib.StringLib.StringToUpperCase(trim(pInput.CITY + if(pInput.CITY <> '',', ',''),left)
																					+ trim(pInput.STATE,left,right) + ' '
																					+ trim(pInput.ZIP,left,right)
																					);
				// self.AID											:=	0;
				self.cln_PRIM_RANGE						:=	'';
				self.cln_PRIM_NAME						:=	'';
				self.cln_SEC_RANGE						:=	'';
				self.cln_ST										:=	'';
				self.cln_ZIP									:=	'';
				self.clean_name								:=	'';
				self.DID											:=	0;
				self.DID_Score								:=	0;
				self.cln_FNAME								:=	'';
				self.cln_MNAME								:=	'';
				self.cln_LNAME								:=	'';
				self.cln_NAME_SUFFIX					:=	'';
				self 													:= pInput;
			END;

	rsImpulseEmailPreClean := PROJECT(rsImpulseEmailSeq ,tSprayedPreClean(left));

	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	AID.MacAppendFromRaw_2Line(rsImpulseEmailPreClean,
		Append_Prep_Address1, Append_Prep_Address_Last, RawAID,
		rsImpulseEmailCleanAid,
		lAIDFlags
		);
	
	layouts.layout_Impulse_Email_AID_Parsed	tImpulseEmailAIDParse(rsImpulseEmailCleanAid pInput)
		:=
			TRANSFORM
				self.RawAID				:=	pInput.AIDWork_RawAID;
				self.prim_range		:=	pInput.aidwork_acecache.prim_range;
				self.predir				:=	pInput.aidwork_acecache.predir;
				self.prim_name		:=	pInput.aidwork_acecache.prim_name;
				self.addr_suffix	:=	pInput.aidwork_acecache.addr_suffix;
				self.postdir			:=	pInput.aidwork_acecache.postdir;
				self.unit_desig		:=	pInput.aidwork_acecache.unit_desig;
				self.sec_range		:=	pInput.aidwork_acecache.sec_range;
				self.p_city_name	:=	pInput.aidwork_acecache.p_city_name;
				self.v_city_name	:=	pInput.aidwork_acecache.v_city_name;
				self.st						:=	pInput.aidwork_acecache.st;
				self.zip5					:=	pInput.aidwork_acecache.zip5;
				self.zip4					:=	pInput.aidwork_acecache.zip4;
				self.cart					:=	pInput.aidwork_acecache.cart;
				self.cr_sort_sz		:=	pInput.aidwork_acecache.cr_sort_sz;
				self.lot					:=	pInput.aidwork_acecache.lot;
				self.lot_order		:=	pInput.aidwork_acecache.lot_order;
				self.dbpc					:=	pInput.aidwork_acecache.dbpc;
				self.chk_digit		:=	pInput.aidwork_acecache.chk_digit;
				self.rec_type			:=	pInput.aidwork_acecache.rec_type;
				self.county				:=	pInput.aidwork_acecache.county;
				self.geo_lat			:=	pInput.aidwork_acecache.geo_lat;
				self.geo_long			:=	pInput.aidwork_acecache.geo_long;
				self.msa					:=	pInput.aidwork_acecache.msa;
				self.geo_blk			:=	pInput.aidwork_acecache.geo_blk;
				self.geo_match		:=	pInput.aidwork_acecache.geo_match;
				self.err_stat			:=	pInput.aidwork_acecache.err_stat;
				self.clean_name		:=	address.CleanPersonFML73(TRIM(TRIM(pInput.FIRSTNAME) + ' ' + TRIM(pInput.MIDDLENAME) + ' ' + TRIM(pInput.LASTNAME)));
				self							:=	pInput;
			END;
	
	rsImpulseEmailCleanName		:=	PROJECT(rsImpulseEmailCleanAid, tImpulseEmailAIDParse(LEFT));
	
	layouts.layout_Impulse_Email_DID_Prepped	tImpulseEmailCleanNameParse(rsImpulseEmailCleanName pInput)
		:=
			TRANSFORM
				self.DID							:=	0;
				self.DID_Score				:=	0;
				self.cln_FNAME				:=	pInput.clean_name[6..25];
				self.cln_MNAME				:=	pInput.clean_name[26..45];
				self.cln_LNAME				:=	pInput.clean_name[46..65];
				self.cln_NAME_SUFFIX	:=	pInput.clean_name[66..70];
				self									:=	pInput;
			END;

	rsImpulseCleanParsed	:=	PROJECT(rsImpulseEmailCleanName, tImpulseEmailCleanNameParse(LEFT));
	
	//Flip names before DID process
	ut.mac_flipnames(rsImpulseCleanParsed,cln_fname,cln_mname,cln_lname,rsCleanedFlipNames);
	
	matchset	:=	['A','D','S','P','Z'];
	
	DID_Add.MAC_Match_Flex(rsCleanedFlipNames, matchset,
											 SSN, DOB, cln_FNAME, cln_MNAME, cln_LNAME, cln_NAME_SUFFIX, 
											 prim_range, prim_name, sec_range, zip, st, HOMEPHONE,
											 DID,
											 layouts.layout_Impulse_Email_DID_Prepped,
											 true, DID_Score, //these should default to zero in definition
											 75,	  //dids with a score below here will be dropped 	
											 rsImpulseEmailDid);

	rsImpulseEmailCleanNameDIDDist	:=	DISTRIBUTE(rsImpulseEmailDid, HASH(append_seqNum));
	rsImpulseEmailCleanNameDIDSrt		:=	SORT(rsImpulseEmailCleanNameDIDDist, append_seqNum, LOCAL);
	rsImpulseEmailCleanNameDID			:=	rsImpulseEmailCleanNameDIDSrt : persist(Impulse_Email.cluster + 'persist::impulse_email_clean_DID');


	rsImpulseEmailCleanNameDIDJoin	:=	JOIN(rsImpulseEmailCleanNameDID, rsImpulseEmailSeqSrt, left.append_seqNum = right.append_seqNum, INNER, LOCAL);

	layouts.layout_Impulse_Email_final	tImpulseEmailFinal(rsImpulseEmailCleanNameDIDJoin pInput)
		:=
			TRANSFORM
				self.RECORD_TYPE	:=	'';
				self.ln_SSN						:=	pInput.SSN;
				self.ln_DOB						:=	MAP(pInput.DOB != '' => pInput.DOB[1..4] + pInput.DOB[6..7] + pInput.DOB[9..10], pInput.DOB = '' => pInput.YEAROB + pInput.DAYOB + pInput.MONTHOB, '');
				self.ln_ANNUALINCOME	:=	MAP(
																			pInput.INCOME_MONTHLY_NET != '' => (integer)pInput.INCOME_MONTHLY_NET*12,
																			pInput.ANNUAL_INCOME != '' => (integer)pInput.ANNUAL_INCOME,
																			pInput.MONTHSALARY != '' => (integer)pInput.MONTHSALARY*12,
																			pInput.INCOME_MONTHLY != '' => (integer)pInput.INCOME_MONTHLY*12,
																			pInput.GROSSMONTHLYINCOME != '' => (integer)pInput.GROSSMONTHLYINCOME*12,
																			pInput.TOTALINCOME != '' => (integer)pInput.TOTALINCOME,
																			0
																		);
				self.source						:=  mdr.sourceTools.src_Impulse;
				//Added for CCPA-108
				self.global_sid       :=  25041;  //Added for CCPA-108.  Impulse_Email has a single source and global_sid lookup function not yet available.
				self.record_sid       :=  0;      //Added for CCPA-108
				self									:=	pInput;
			END;

	ruIERec	:=	PROJECT(rsImpulseEmailCleanNameDIDJoin, tImpulseEmailFinal(LEFT));
	
	addGlobalSID := MDR.macGetGlobalSid(ruIERec,'ImpulseEmail','','global_sid'); //DF-25972: Add Global_SID

	//Separate records without a did and flag them as 'I' (invalid for keys)											
	Impulse_Email_No_DID	:=	addGlobalSID(DID = 0);
	Impulse_Email_DID			:=	addGlobalSID(DID <> 0);

	dsSort			:= sort(Impulse_Email_DID, DID);
	dsGroup     := group(dsSort, DID);
	dsSortGroup := sort(dsGroup, -version_date);											
												
	layouts.layout_Impulse_Email_final SetRecordType(layouts.layout_Impulse_Email_final L, layouts.layout_Impulse_Email_final R) := transform
		self.RECORD_TYPE  	:= if(l.RECORD_TYPE = '', 'C', 'H');
		self										:= r;
	end;

	Impulse_Email_base_flagged_DID	:=	group(iterate(dsSortGroup, SetRecordType(left, right)));

	layouts.layout_Impulse_Email_final SetRecordTypeInvalid(layouts.layout_Impulse_Email_final pInput) := transform
		self.RECORD_TYPE	:= 'I';
		self							:= pInput;
	end;								

	Impulse_Email_base_flagged_NoDID	:=	PROJECT(Impulse_Email_No_DID, SetRecordTypeInvalid(left));

	Impulse_Email_base_flagged	:=	Impulse_Email_base_flagged_DID + Impulse_Email_base_flagged_NoDID;

RETURN	Impulse_Email_base_flagged;

END;