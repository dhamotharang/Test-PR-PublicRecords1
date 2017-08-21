IMPORT address, DID_Add, header_slimsort, ut;

layout_citi_infile
	:=
		RECORD
			string FirstName;
			string LastName;
			string Address1;
			string City;
			string State;
			string Zip;
			string SSN;
			string AccountNumber;
			string EmailAddress1;
			string EmailAddress2;
			string EmailAddress3;
			string EmailAddress4;
			string EmailAddress5;
			string EmailAddress6;
			string EmailAddress7;
			string EmailAddress8;
			string EmailAddress9;
			string EmailAddress10;
		END;

layout_email_lkp
	:=
		RECORD
			unsigned6 did;
			string 		email1;
			string 		email2;
			string 		email3;
			string 		email4;
			string 		email5;
			string 		email6;
			string 		email7;
			string 		email8;
			string 		email9;
			string 		email10;
			unsigned3	IMP_email_count;
			unsigned3	WA_email_count;
			unsigned3	ACQ_email_count;
			unsigned3	ENT_email_count;
			unsigned3	total_email_count;
		END;
		
file_email_lkp		:=	DATASET('~thor_data200::temp::DIDEmailLkpAll', layout_email_lkp, THOR);
file_citi_infile1	:=	DATASET(ut.foreign_dataland + 'thor_data200::in::citi_email::inputfile1', layout_citi_infile, CSV(HEADING(1), terminator('\r\n'),separator(','),quote('"'), MAXLENGTH(8192)));
file_citi_infile2	:=	DATASET(ut.foreign_dataland + 'thor_data200::in::citi_email::inputfile2', layout_citi_infile, CSV(HEADING(1), terminator('\r\n'),separator(','),quote('"'), MAXLENGTH(8192)));
file_citi_infile3	:=	DATASET(ut.foreign_dataland + 'thor_data200::in::citi_email::inputfile3', layout_citi_infile, CSV(HEADING(1), terminator('\r\n'),separator(','),quote('"'), MAXLENGTH(8192)));
file_citi_infile4	:=	DATASET(ut.foreign_dataland + 'thor_data200::in::citi_email::inputfile4', layout_citi_infile, CSV(HEADING(1), terminator('\r\n'),separator(','),quote('"'), MAXLENGTH(8192)));
file_citi_infile	:=	file_citi_infile1 + file_citi_infile2 + file_citi_infile3 + file_citi_infile4;

layout_citi_pre_clean
	:=
		RECORD
			layout_citi_infile;
			string182	clean_address;
			string73	clean_name;
		END;

layout_citi_pre_clean	tPreCleanNameAddr(layout_citi_infile pInput)	:=	TRANSFORM
	self.clean_name			:=	address.CleanPersonFML73(TRIM(TRIM(pInput.FIRSTNAME) + ' ' + TRIM(pInput.LASTNAME)));
	self.clean_address	:=	addrcleanlib.cleanaddress182(pInput.Address1, pInput.City + ' ' + pInput.State + ' ' + pInput.Zip);
	self								:=	pInput;
END;

rsCitiPreClean	:=	PROJECT(file_citi_infile, tPreCleanNameAddr(LEFT));

layout_citi_clean
	:=
		RECORD
			layout_citi_infile;
			unsigned6	DID;
			unsigned6	DID_Score;
			string20	cln_FNAME;
			string20	cln_MNAME;
			string20	cln_LNAME;
			string5		cln_NAME_SUFFIX;
			string10	cln_PRIM_RANGE;
			string28	cln_PRIM_NAME;
			string8		cln_SEC_RANGE;
			string2		cln_ST;
			string5		cln_ZIP;
		END;

layout_citi_clean	tCleanNameAddr(layout_citi_pre_clean pInput)	:=	TRANSFORM
	self.DID							:=	0;
	self.DID_Score				:=	0;
	self.cln_FNAME				:=	pInput.clean_name[6..25];
	self.cln_MNAME				:=	pInput.clean_name[26..45];
	self.cln_LNAME				:=	pInput.clean_name[46..65];
	self.cln_NAME_SUFFIX	:=	pInput.clean_name[66..70];
	self.cln_PRIM_RANGE		:=	pInput.clean_address[1..10];
	self.cln_PRIM_NAME		:=	pInput.clean_address[13..40];
	self.cln_SEC_RANGE		:=	pInput.clean_address[57..64];
	self.cln_ST						:=	pInput.clean_address[115..116];
	self.cln_ZIP					:=	pInput.clean_address[117..121];
	self									:=	pInput;
END;

rsCitiClean	:=	PROJECT(rsCitiPreClean, tCleanNameAddr(LEFT));

matchset	:=	['A','S','Z'];
	
DID_Add.MAC_Match_Flex(rsCitiClean, matchset,
											SSN, foo, cln_FNAME, cln_MNAME, cln_LNAME, cln_NAME_SUFFIX, 
											cln_prim_range, cln_prim_name, cln_sec_range, cln_zip, cln_st, foo,
											DID,
											layout_citi_clean,
											true, DID_Score, //these should default to zero in definition
											75,	  //dids with a score below here will be dropped 	
											rsCitiDidOut);
											
rsCitiDid	:=	rsCitiDidOut : PERSIST('~thor_data200::persist::rsCitiCleanDID');

layout_citi_DID_Join
	:=
		RECORD
			layout_citi_infile;
			unsigned6	DID;
			unsigned6	DID_Score;
			unsigned3	IMP_email_count;
			unsigned3	WA_email_count;
			unsigned3	ACQ_email_count;
			unsigned3	ENT_email_count;
			unsigned3	total_email_count;
		END;

layout_citi_DID_Join	tBlankEmailAddr(layout_citi_clean pInput)	:=	TRANSFORM
	self.EmailAddress1			:=	'';
	self.EmailAddress2			:=	'';
	self.EmailAddress3			:=	'';
	self.EmailAddress4			:=	'';
	self.EmailAddress5			:=	'';
	self.EmailAddress6			:=	'';
	self.EmailAddress7			:=	'';
	self.EmailAddress8			:=	'';
	self.EmailAddress9			:=	'';
	self.EmailAddress10			:=	'';
	self.IMP_email_count		:=	0;
	self.WA_email_count			:=	0;
	self.ACQ_email_count		:=	0;
	self.ENT_email_count		:=	0;
	self.total_email_count	:=	0;
	self										:=	pInput;
END;

rsCitiDIDBlankEmail	:=	PROJECT(rsCitiDid, tBlankEmailAddr(LEFT));

rsCitiJoinPrep			:=	DISTRIBUTE(rsCitiDIDBlankEmail(DID <> 0), DID);
rsCitiJoinPrepNoDID	:=	rsCitiDIDBlankEmail(DID = 0);
rsEmailLkpJoinPrep	:=	DISTRIBUTE(file_email_lkp, DID);

layout_citi_DID_Join	tJoinEmailLkp(layout_citi_DID_Join lInput, layout_email_lkp rInput)	:=	TRANSFORM
	self.DID								:=	lInput.DID;
	self.DID_Score					:=	lInput.DID_Score;
	self.EmailAddress1			:=	rInput.email1;
	self.EmailAddress2			:=	rInput.email2;
	self.EmailAddress3			:=	rInput.email3;
	self.EmailAddress4			:=	rInput.email4;
	self.EmailAddress5			:=	rInput.email5;
	self.EmailAddress6			:=	rInput.email6;
	self.EmailAddress7			:=	rInput.email7;
	self.EmailAddress8			:=	rInput.email8;
	self.EmailAddress9			:=	rInput.email9;
	self.EmailAddress10			:=	rInput.email10;
	self.IMP_email_count		:=	rInput.IMP_email_count;
	self.WA_email_count			:=	rInput.WA_email_count;
	self.ACQ_email_count		:=	rInput.ACQ_email_count;
	self.ENT_email_count		:=	rInput.ENT_email_count;
	self.total_email_count	:=	rInput.total_email_count;
	self										:=	lInput;
END;

rsCitiJoined	:=	JOIN(rsCitiJoinPrep, rsEmailLkpJoinPrep, LEFT.DID = RIGHT.DID, tJoinEmailLkp(LEFT, RIGHT), LEFT OUTER, LOCAL);

rsCitiAll			:=	rsCitiJoined + rsCitiJoinPrepNoDID;

layout_counts_total
	:=
		RECORD
			unsigned6	IMP_email_total;
			unsigned6	WA_email_total;
			unsigned6	ACQ_email_total;
			unsigned6	ENT_email_total;
			unsigned6	ALL_email_total;
		END;
		
layout_counts_total	tTotalCounts(layout_citi_DID_Join pInput)	:=	TRANSFORM
	self.IMP_email_total := SUM(rsCitiJoined, rsCitiJoined.IMP_email_count);
	self.WA_email_total := SUM(rsCitiJoined, rsCitiJoined.WA_email_count);
	self.ACQ_email_total := SUM(rsCitiJoined, rsCitiJoined.ACQ_email_count);
	self.ENT_email_total := SUM(rsCitiJoined, rsCitiJoined.ENT_email_count);
	self.ALL_email_total := SUM(rsCitiJoined, rsCitiJoined.total_email_count);
END;

rsCitiEmailTotals	:=	DEDUP(PROJECT(rsCitiJoined, tTotalCounts(LEFT)), ALL);

OUTPUT(rsCitiEmailTotals,NAMED('CountTotals'));

rsCitiFinal		:=	PROJECT(rsCitiAll, layout_citi_infile);
export proc_join_citi_email := OUTPUT(rsCitiFinal, ,'~thor_data200::out::CitiEmailOut', CSV(SEPARATOR(','), TERMINATOR('\r\n'),QUOTE('"')), OVERWRITE);