IMPORT Entiera, Impulse_Email, OptinCellphones, Acquireweb_Email, lib_stringlib, ut;

Entiera_Base		:=	DATASET('~thor_200::base::entiera::basefile', Entiera.Layouts.Base, THOR);
Impulse_Base		:=	DATASET('~thor_data400::base::impulse_email', Impulse_Email.layouts.layout_Impulse_Email_final, THOR);
Acquireweb_Base	:=	DATASET('~thor_data200::base::acquireweb', Acquireweb_Email.layouts.layout_Acquireweb_Base, THOR);
OptIn_Base			:=	DATASET('~thor_data400::base::optincellphones_build', OptinCellphones.layouts.Layout_out, THOR);

layout_email_lkp
	:=
		RECORD
			unsigned6 DID;
			string		email;
			string3		source;
			string10	best_date;
		END;
		
layout_email_lkp	tEntieraLkp(Entiera.Layouts.Base pInput)	:=	TRANSFORM
		self.DID				:=	pInput.DID;
		self.email			:=	Stringlib.StringToLowerCase(TRIM(pInput.orig_email));
		self.source			:=	'4';
		self.best_date	:=	IF(pInput.ln_login_date = '', 
													IF(pInput.date_vendor_first_reported = '',
														IF(pInput.date_first_seen = '', pInput.process_date, pInput.date_first_seen),
													pInput.date_vendor_first_reported), 
												pInput.ln_login_date);
END;

//Records are given a source value for proper ordering when sources are given priority over others
//1 = Impulse, 2 = WA/OptInCellPhone, 3 = Acquireweb, 4 = Entiera
//best_date is used to try and determine the order of the email from newest to oldest.  For AcquireWeb, the emailid is used.
layout_email_lkp	tImpulseLkp(Impulse_Email.layouts.layout_Impulse_Email_final pInput)	:=	TRANSFORM
		self.DID				:=	pInput.DID;
		self.email			:=	Stringlib.StringToLowerCase(TRIM(pInput.email));
		self.source			:=	'1';
		self.best_date	:=	IF((string8)pInput.datevendorfirstreported = '', pInput.file_date, (string8)pInput.datevendorfirstreported);
END;

layout_email_lkp	tAcquireWebLkp(Acquireweb_Email.layouts.layout_Acquireweb_Base pInput)	:=	TRANSFORM
		self.DID				:=	pInput.DID;
		self.email			:=	Stringlib.StringToLowerCase(TRIM(pInput.email));
		self.source			:=	'3';
		self.best_date	:=	TRIM(pInput.emailid);
END;

layout_email_lkp	tOptInLkp(OptinCellPhones.layouts.Layout_out pInput)	:=	TRANSFORM
		self.DID				:=	pInput.DID;
		self.email			:=	Stringlib.StringToLowerCase(TRIM(pInput.email));
		self.source			:=	'2';
		self.best_date	:=	TRIM(pInput.Orig_Date);
END;

EntieraLkp	:=	project(Entiera_Base(DID <> 0), tEntieraLkp(left));
ImpulseLkp	:=	project(Impulse_Base(DID <> 0), tImpulseLkp(left));
AcquireLkp	:=	project(Acquireweb_Base(DID <> 0), tAcquireWebLkp(left));
OptInLkp		:=	project(OptIn_Base(DID <> 0 AND TRIM(email) <> ''), tOptInLkp(left));

AllSrces		:=	ImpulseLkp + OptInLkp + EntieraLkp + AcquireLkp;

//Distribute, sort and dedup to remove duplicates based on DID and source
rsEmailDed	:=	DEDUP(
									SORT(
										DISTRIBUTE(AllSrces, HASH(DID + email + source)), 
									HASH(DID + email + source), source, LOCAL), 
								HASH(DID + email), LOCAL) 
								;

//Remove duplicate emails only keeping those of the priority souces first
rsEmailDedEm	:=	DEDUP(SORT(DISTRIBUTE(rsEmailDed, HASH(TRIM(email))), email, source, LOCAL), HASH(TRIM(email)), LOCAL);
//Distribute and sort to correctly order the emails based on the best_date in decending order
rsEmailSrt		:=	SORT(DISTRIBUTE(rsEmailDedEm, HASH(DID + source)), HASH(DID + source), -(integer)best_date, LOCAL);

layout_did_email_lkp_denormalized
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
			string3 	source;
			unsigned3	email_count;
			unsigned3	total_email_count;
		END;
		
layout_did_email_lkp_denormalized	tPrepFile(layout_email_lkp pInput) := TRANSFORM
	self.did					:=	pInput.did;
	SELF.email1				:= '';
	SELF.email2				:= '';
	SELF.email3				:= '';
	SELF.email4				:= '';
	SELF.email5				:= '';
	SELF.email6				:= '';
	SELF.email7				:= '';
	SELF.email8				:= '';
	SELF.email9				:= '';
	SELF.email10			:= '';
	self.source				:=	pInput.source;
	self.email_count	:=	0;
	self.total_email_count	:=	0;
	self							:=	pInput;
END;

file_did_email_prep	:=	PROJECT(rsEmailSrt, tPrepFile(LEFT));

layout_did_email_lkp_denormalized DeNormThem(layout_did_email_lkp_denormalized L, rsEmailSrt R, INTEGER C) := TRANSFORM
	SELF.email1				:= IF (C=1,  R.email, L.email1);
	SELF.email2				:= IF (C=2,  R.email, L.email2);
	SELF.email3				:= IF (C=3,  R.email, L.email3);
	SELF.email4				:= IF (C=4,  R.email, L.email4);
	SELF.email5				:= IF (C=5,  R.email, L.email5);
	SELF.email6				:= IF (C=6,  R.email, L.email6);
	SELF.email7				:= IF (C=7,  R.email, L.email7);
	SELF.email8				:= IF (C=8,  R.email, L.email8);
	SELF.email9				:= IF (C=9,  R.email, L.email9);
	SELF.email10			:= IF (C=10, R.email, L.email10);
	SELF.email_count 	:= IF (C > 10, 10, C);
	SELF.total_email_count 	:= C;
	SELF 							:= L;
END;

DeNormedRecs := DENORMALIZE(file_did_email_prep, rsEmailSrt,
	LEFT.DID = RIGHT.DID AND LEFT.source = RIGHT.source,
DeNormThem(LEFT,RIGHT,COUNTER));

DeNormedRecsFinal	:=	DEDUP(SORT(DISTRIBUTE(DeNormedRecs, HASH(DID)), DID, LOCAL), ALL, LOCAL);

//Roll em up into a single record
layout_did_email_lkp_final
	:=
		RECORD
				unsigned6 did;
				string 		IMP_email1;
				string 		IMP_email2;
				string 		IMP_email3;
				string 		IMP_email4;
				string 		IMP_email5;
				string 		IMP_email6;
				string 		IMP_email7;
				string 		IMP_email8;
				string 		IMP_email9;
				string 		IMP_email10;
				unsigned3 IMP_email_count;
				unsigned3 IMP_total_email_count;
				string 		WA_email1;
				string 		WA_email2;
				string 		WA_email3;
				string 		WA_email4;
				string 		WA_email5;
				string 		WA_email6;
				string 		WA_email7;
				string 		WA_email8;
				string 		WA_email9;
				string 		WA_email10;
				unsigned3 WA_email_count;
				unsigned3 WA_total_email_count;				
				string 		ACQ_email1;
				string 		ACQ_email2;
				string 		ACQ_email3;
				string 		ACQ_email4;
				string 		ACQ_email5;
				string 		ACQ_email6;
				string 		ACQ_email7;
				string 		ACQ_email8;
				string 		ACQ_email9;
				string 		ACQ_email10;
				unsigned3 ACQ_email_count;
				unsigned3 ACQ_total_email_count;
				string 		ENT_email1;
				string 		ENT_email2;
				string 		ENT_email3;
				string 		ENT_email4;
				string 		ENT_email5;
				string 		ENT_email6;
				string 		ENT_email7;
				string 		ENT_email8;
				string 		ENT_email9;
				string 		ENT_email10;
				unsigned3 ENT_email_count;
				unsigned3 ENT_total_email_count;
		END;

layout_did_email_lkp_final tEmailRollupLayout(DeNormedRecsFinal pInput) := TRANSFORM
	self.DID										:=	pInput.DID;
	self.IMP_email1							:=	IF(pInput.source = '1', pInput.email1, '');
	self.IMP_email2							:=	IF(pInput.source = '1', pInput.email2, '');
	self.IMP_email3							:=	IF(pInput.source = '1', pInput.email3, '');
	self.IMP_email4							:=	IF(pInput.source = '1', pInput.email4, '');
	self.IMP_email5							:=	IF(pInput.source = '1', pInput.email5, '');
	self.IMP_email6							:=	IF(pInput.source = '1', pInput.email6, '');
	self.IMP_email7							:=	IF(pInput.source = '1', pInput.email7, '');
	self.IMP_email8							:=	IF(pInput.source = '1', pInput.email8, '');
	self.IMP_email9							:=	IF(pInput.source = '1', pInput.email9, '');
	self.IMP_email10						:=	IF(pInput.source = '1', pInput.email10, '');
	self.IMP_email_count				:=	IF(pInput.source = '1', pInput.email_count, 0);
	self.IMP_total_email_count	:=	IF(pInput.source = '1', pInput.total_email_count, 0);
	self.WA_email1							:=	IF(pInput.source = '2', pInput.email1, '');
	self.WA_email2							:=	IF(pInput.source = '2', pInput.email2, '');
	self.WA_email3							:=	IF(pInput.source = '2', pInput.email3, '');
	self.WA_email4							:=	IF(pInput.source = '2', pInput.email4, '');
	self.WA_email5							:=	IF(pInput.source = '2', pInput.email5, '');
	self.WA_email6							:=	IF(pInput.source = '2', pInput.email6, '');
	self.WA_email7							:=	IF(pInput.source = '2', pInput.email7, '');
	self.WA_email8							:=	IF(pInput.source = '2', pInput.email8, '');
	self.WA_email9							:=	IF(pInput.source = '2', pInput.email9, '');
	self.WA_email10							:=	IF(pInput.source = '2', pInput.email10, '');
	self.WA_email_count					:=	IF(pInput.source = '2', pInput.email_count, 0);
	self.WA_total_email_count		:=	IF(pInput.source = '2', pInput.total_email_count, 0);	
	self.ACQ_email1							:=	IF(pInput.source = '3', pInput.email1, '');
	self.ACQ_email2							:=	IF(pInput.source = '3', pInput.email2, '');
	self.ACQ_email3							:=	IF(pInput.source = '3', pInput.email3, '');
	self.ACQ_email4							:=	IF(pInput.source = '3', pInput.email4, '');
	self.ACQ_email5							:=	IF(pInput.source = '3', pInput.email5, '');
	self.ACQ_email6							:=	IF(pInput.source = '3', pInput.email6, '');
	self.ACQ_email7							:=	IF(pInput.source = '3', pInput.email7, '');
	self.ACQ_email8							:=	IF(pInput.source = '3', pInput.email8, '');
	self.ACQ_email9							:=	IF(pInput.source = '3', pInput.email9, '');
	self.ACQ_email10						:=	IF(pInput.source = '3', pInput.email10, '');
	self.ACQ_email_count				:=	IF(pInput.source = '3', pInput.email_count, 0);
	self.ACQ_total_email_count	:=	IF(pInput.source = '3', pInput.total_email_count, 0);
	self.ENT_email1							:=	IF(pInput.source = '4', pInput.email1, '');
	self.ENT_email2							:=	IF(pInput.source = '4', pInput.email2, '');
	self.ENT_email3							:=	IF(pInput.source = '4', pInput.email3, '');
	self.ENT_email4							:=	IF(pInput.source = '4', pInput.email4, '');
	self.ENT_email5							:=	IF(pInput.source = '4', pInput.email5, '');
	self.ENT_email6							:=	IF(pInput.source = '4', pInput.email6, '');
	self.ENT_email7							:=	IF(pInput.source = '4', pInput.email7, '');
	self.ENT_email8							:=	IF(pInput.source = '4', pInput.email8, '');
	self.ENT_email9							:=	IF(pInput.source = '4', pInput.email9, '');
	self.ENT_email10						:=	IF(pInput.source = '4', pInput.email10, '');
	self.ENT_email_count				:=	IF(pInput.source = '4', pInput.email_count, 0);
	self.ENT_total_email_count	:=	IF(pInput.source = '4', pInput.total_email_count, 0);
END;

Email_Lkp_RU_Layout	:=	PROJECT(DeNormedRecsFinal, tEmailRollupLayout(LEFT));

layout_did_email_lkp_final tEmailRollup(layout_did_email_lkp_final L, layout_did_email_lkp_final R) := TRANSFORM
	self.DID										:=	L.DID;
	self.IMP_email1							:=	IF(L.IMP_email1 <> '', L.IMP_email1, IF(R.IMP_email1 <> '', R.IMP_email1, ''));
	self.IMP_email2							:=	IF(L.IMP_email2 <> '', L.IMP_email2, IF(R.IMP_email2 <> '', R.IMP_email2, ''));
	self.IMP_email3							:=	IF(L.IMP_email3 <> '', L.IMP_email3, IF(R.IMP_email3 <> '', R.IMP_email3, ''));
	self.IMP_email4							:=	IF(L.IMP_email4 <> '', L.IMP_email4, IF(R.IMP_email4 <> '', R.IMP_email4, ''));
	self.IMP_email5							:=	IF(L.IMP_email5 <> '', L.IMP_email5, IF(R.IMP_email5 <> '', R.IMP_email5, ''));
	self.IMP_email6							:=	IF(L.IMP_email6 <> '', L.IMP_email6, IF(R.IMP_email6 <> '', R.IMP_email6, ''));
	self.IMP_email7							:=	IF(L.IMP_email7 <> '', L.IMP_email7, IF(R.IMP_email7 <> '', R.IMP_email7, ''));
	self.IMP_email8							:=	IF(L.IMP_email8 <> '', L.IMP_email8, IF(R.IMP_email8 <> '', R.IMP_email8, ''));
	self.IMP_email9							:=	IF(L.IMP_email9 <> '', L.IMP_email9, IF(R.IMP_email9 <> '', R.IMP_email9, ''));
	self.IMP_email10						:=	IF(L.IMP_email10 <> '', L.IMP_email10, IF(R.IMP_email10 <> '', R.IMP_email10, ''));
	self.IMP_email_count				:=	IF(L.IMP_email_count > 0, L.IMP_email_count, IF(R.IMP_email_count > 0, R.IMP_email_count, 0));
	self.IMP_total_email_count	:=	IF(L.IMP_total_email_count > 0, L.IMP_total_email_count, IF(R.IMP_total_email_count > 0, R.IMP_total_email_count, 0));
	
	self.WA_email1							:=	IF(L.WA_email1 <> '', L.WA_email1, IF(R.WA_email1 <> '', R.WA_email1, ''));
	self.WA_email2							:=	IF(L.WA_email2 <> '', L.WA_email2, IF(R.WA_email2 <> '', R.WA_email2, ''));
	self.WA_email3							:=	IF(L.WA_email3 <> '', L.WA_email3, IF(R.WA_email3 <> '', R.WA_email3, ''));
	self.WA_email4							:=	IF(L.WA_email4 <> '', L.WA_email4, IF(R.WA_email4 <> '', R.WA_email4, ''));
	self.WA_email5							:=	IF(L.WA_email5 <> '', L.WA_email5, IF(R.WA_email5 <> '', R.WA_email5, ''));
	self.WA_email6							:=	IF(L.WA_email6 <> '', L.WA_email6, IF(R.WA_email6 <> '', R.WA_email6, ''));
	self.WA_email7							:=	IF(L.WA_email7 <> '', L.WA_email7, IF(R.WA_email7 <> '', R.WA_email7, ''));
	self.WA_email8							:=	IF(L.WA_email8 <> '', L.WA_email8, IF(R.WA_email8 <> '', R.WA_email8, ''));
	self.WA_email9							:=	IF(L.WA_email9 <> '', L.WA_email9, IF(R.WA_email9 <> '', R.WA_email9, ''));
	self.WA_email10							:=	IF(L.WA_email10 <> '', L.WA_email10, IF(R.WA_email10 <> '', R.WA_email10, ''));
	self.WA_email_count					:=	IF(L.WA_email_count > 0, L.WA_email_count, IF(R.WA_email_count > 0, R.WA_email_count, 0));
	self.WA_total_email_count		:=	IF(L.WA_total_email_count > 0, L.WA_total_email_count, IF(R.WA_total_email_count > 0, R.WA_total_email_count, 0));	
	
	self.ACQ_email1							:=	IF(L.ACQ_email1 <> '', L.ACQ_email1, IF(R.ACQ_email1 <> '', R.ACQ_email1, ''));
	self.ACQ_email2							:=	IF(L.ACQ_email2 <> '', L.ACQ_email2, IF(R.ACQ_email2 <> '', R.ACQ_email2, ''));
	self.ACQ_email3							:=	IF(L.ACQ_email3 <> '', L.ACQ_email3, IF(R.ACQ_email3 <> '', R.ACQ_email3, ''));
	self.ACQ_email4							:=	IF(L.ACQ_email4 <> '', L.ACQ_email4, IF(R.ACQ_email4 <> '', R.ACQ_email4, ''));
	self.ACQ_email5							:=	IF(L.ACQ_email5 <> '', L.ACQ_email5, IF(R.ACQ_email5 <> '', R.ACQ_email5, ''));
	self.ACQ_email6							:=	IF(L.ACQ_email6 <> '', L.ACQ_email6, IF(R.ACQ_email6 <> '', R.ACQ_email6, ''));
	self.ACQ_email7							:=	IF(L.ACQ_email7 <> '', L.ACQ_email7, IF(R.ACQ_email7 <> '', R.ACQ_email7, ''));
	self.ACQ_email8							:=	IF(L.ACQ_email8 <> '', L.ACQ_email8, IF(R.ACQ_email8 <> '', R.ACQ_email8, ''));
	self.ACQ_email9							:=	IF(L.ACQ_email9 <> '', L.ACQ_email9, IF(R.ACQ_email9 <> '', R.ACQ_email9, ''));
	self.ACQ_email10						:=	IF(L.ACQ_email10 <> '', L.ACQ_email10, IF(R.ACQ_email10 <> '', R.ACQ_email10, ''));
	self.ACQ_email_count				:=	IF(L.ACQ_email_count > 0, L.ACQ_email_count, IF(R.ACQ_email_count > 0, R.ACQ_email_count, 0));
	self.ACQ_total_email_count	:=	IF(L.ACQ_total_email_count > 0, L.ACQ_total_email_count, IF(R.ACQ_total_email_count > 0, R.ACQ_total_email_count, 0));
	
	self.ENT_email1							:=	IF(L.ENT_email1 <> '', L.ENT_email1, IF(R.ENT_email1 <> '', R.ENT_email1, ''));
	self.ENT_email2							:=	IF(L.ENT_email2 <> '', L.ENT_email2, IF(R.ENT_email2 <> '', R.ENT_email2, ''));
	self.ENT_email3							:=	IF(L.ENT_email3 <> '', L.ENT_email3, IF(R.ENT_email3 <> '', R.ENT_email3, ''));
	self.ENT_email4							:=	IF(L.ENT_email4 <> '', L.ENT_email4, IF(R.ENT_email4 <> '', R.ENT_email4, ''));
	self.ENT_email5							:=	IF(L.ENT_email5 <> '', L.ENT_email5, IF(R.ENT_email5 <> '', R.ENT_email5, ''));
	self.ENT_email6							:=	IF(L.ENT_email6 <> '', L.ENT_email6, IF(R.ENT_email6 <> '', R.ENT_email6, ''));
	self.ENT_email7							:=	IF(L.ENT_email7 <> '', L.ENT_email7, IF(R.ENT_email7 <> '', R.ENT_email7, ''));
	self.ENT_email8							:=	IF(L.ENT_email8 <> '', L.ENT_email8, IF(R.ENT_email8 <> '', R.ENT_email8, ''));
	self.ENT_email9							:=	IF(L.ENT_email9 <> '', L.ENT_email9, IF(R.ENT_email9 <> '', R.ENT_email9, ''));
	self.ENT_email10						:=	IF(L.ENT_email10 <> '', L.ENT_email10, IF(R.ENT_email10 <> '', R.ENT_email10, ''));
	self.ENT_email_count				:=	IF(L.ENT_email_count > 0, L.ENT_email_count, IF(R.ENT_email_count > 0, R.ENT_email_count, 0));
	self.ENT_total_email_count	:=	IF(L.ENT_total_email_count > 0, L.ENT_total_email_count, IF(R.ENT_total_email_count > 0, R.ENT_total_email_count, 0));
END;

rolledup_Email_Lkp := ROLLUP(Email_Lkp_RU_Layout, tEmailRollup(LEFT,RIGHT), LEFT.DID = RIGHT.DID);

layout_WeightedEmail := RECORD
	UNSIGNED6 did;
	string1   weight;
	STRING		src_email;
	unsigned3	IMP_email_count;
	unsigned3	WA_email_count;
	unsigned3	ACQ_email_count;
	unsigned3	ENT_email_count;
end;
		
//Transform to only populate final record with priority sources. Up to 10 emails from Impulse and AcquireWeb.  If less than 10 emails exist from 
//those two sources, then try to fill the rest with either AcquireWeb or Entiera. AcquireWeb is given precidence.
layout_WeightedEmail tWeightEmail(layout_did_email_lkp_final pInput, unsigned4 cnt) := transform
	self.did							:= pInput.did;
	self.weight						:= choose(cnt, 
																	if(pInput.IMP_email1 != '','1','0'),
																	if(pInput.IMP_email2 != '','1','0'),
																	if(pInput.IMP_email3 != '','1','0'),
																	if(pInput.IMP_email4 != '','1','0'),
																	if(pInput.IMP_email5 != '','1','0'),
																	if(pInput.IMP_email6 != '','1','0'),
																	if(pInput.IMP_email7 != '','1','0'),
																	if(pInput.IMP_email8 != '','1','0'),
																	if(pInput.IMP_email9 != '','1','0'),
																	if(pInput.IMP_email10 != '','1','0'),
																																
																	if(pInput.WA_email1 != '','2','0'),
																	if(pInput.WA_email2 != '','2','0'),
																	if(pInput.WA_email3 != '','2','0'),
																	if(pInput.WA_email4 != '','2','0'),
																	if(pInput.WA_email5 != '','2','0'),
																	if(pInput.WA_email6 != '','2','0'),
																	if(pInput.WA_email7 != '','2','0'),
																	if(pInput.WA_email8 != '','2','0'),
																	if(pInput.WA_email9 != '','2','0'),
																	if(pInput.WA_email10 != '','2','0'),

																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),														
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),
																	if(	pInput.ACQ_email1 != '' or
																			pInput.ACQ_email2 != '' or
																			pInput.ACQ_email3 != '' or
																			pInput.ACQ_email4 != '' or
																			pInput.ACQ_email5 != '' or
																			pInput.ACQ_email6 != '' or
																			pInput.ACQ_email7 != '' or
																			pInput.ACQ_email8 != '' or
																			pInput.ACQ_email9 != '' or
																			pInput.ACQ_email10 != '','3','0'),																			

																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),														
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'),
																	if(	pInput.ACQ_email1 = '' and
																			pInput.ACQ_email2 = '' and
																			pInput.ACQ_email3 = '' and
																			pInput.ACQ_email4 = '' and
																			pInput.ACQ_email5 = '' and
																			pInput.ACQ_email6 = '' and
																			pInput.ACQ_email7 = '' and
																			pInput.ACQ_email8 = '' and
																			pInput.ACQ_email9 = '' and
																			pInput.ACQ_email10 = '','4','0'));
																			
	self.src_email				:= choose(cnt, pInput.IMP_email1, pInput.IMP_email2, pInput.IMP_email3, pInput.IMP_email4, pInput.IMP_email5, pInput.IMP_email6, pInput.IMP_email7, pInput.IMP_email8, pInput.IMP_email8, pInput.IMP_email10, 
																	pInput.WA_email1, pInput.WA_email2, pInput.WA_email3, pInput.WA_email4, pInput.WA_email5, pInput.WA_email6, pInput.WA_email7, pInput.WA_email8, pInput.WA_email9, pInput.WA_email10, 
																	pInput.ACQ_email1, pInput.ACQ_email2, pInput.ACQ_email3, pInput.ACQ_email4, pInput.ACQ_email5, pInput.ACQ_email6, pInput.ACQ_email7, pInput.ACQ_email8, pInput.ACQ_email9, pInput.ACQ_email10, 
																	pInput.ENT_email1, pInput.ENT_email2, pInput.ENT_email3, pInput.ENT_email4, pInput.ENT_email5, pInput.ENT_email6, pInput.ENT_email7, pInput.ENT_email8, pInput.ENT_email9, pInput.ENT_email10);

	self.IMP_email_count	:=	pInput.IMP_email_count;
	self.WA_email_count		:=	pInput.WA_email_count;
	self.ACQ_email_count	:=	pInput.ACQ_email_count;
	self.ENT_email_count	:=	IF(self.ACQ_email_count = 0, pInput.ENT_email_count, 0);
END;


WeightedEmailNorm	:= normalize(rolledup_Email_Lkp, 40, tWeightEmail(left,counter));

WeightedEmailNormKeepers	:=	sort(WeightedEmailNorm(weight!='0' and src_email!= '' ),did, weight);

layout_did_email_lkp_final_denormalized
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
		
layout_did_email_lkp_final_denormalized	tPrepFinalFile(WeightedEmailNormKeepers pInput) := TRANSFORM
	self.did								:=	pInput.did;
	SELF.email1							:= '';
	SELF.email2							:= '';
	SELF.email3							:= '';
	SELF.email4							:= '';
	SELF.email5							:= '';
	SELF.email6							:= '';
	SELF.email7							:= '';
	SELF.email8							:= '';
	SELF.email9							:= '';
	SELF.email10						:= '';
	self.total_email_count	:=	0;
	self										:=	pInput;
END;

file_did_email_final_denorm_prep	:=	PROJECT(WeightedEmailNormKeepers, tPrepFinalFile(LEFT));

layout_did_email_lkp_final_denormalized FinalDeNormThem(layout_did_email_lkp_final_denormalized L, WeightedEmailNormKeepers R, INTEGER C) := TRANSFORM
	SELF.email1							:= IF (C=1,  R.src_email, L.email1);
	SELF.email2							:= IF (C=2,  R.src_email, L.email2);
	SELF.email3							:= IF (C=3,  R.src_email, L.email3);
	SELF.email4							:= IF (C=4,  R.src_email, L.email4);
	SELF.email5							:= IF (C=5,  R.src_email, L.email5);
	SELF.email6							:= IF (C=6,  R.src_email, L.email6);
	SELF.email7							:= IF (C=7,  R.src_email, L.email7);
	SELF.email8							:= IF (C=8,  R.src_email, L.email8);
	SELF.email9							:= IF (C=9,  R.src_email, L.email9);
	SELF.email10						:= IF (C=10, R.src_email, L.email10);
	SELF.total_email_count 	:= C;
	SELF 										:= L;
END;

FinalDeNormedRecs := DENORMALIZE(file_did_email_final_denorm_prep, WeightedEmailNormKeepers,
	LEFT.DID = RIGHT.DID,
FinalDeNormThem(LEFT,RIGHT,COUNTER));

FinalDeNormedRecsDed	:=	DEDUP(SORT(DISTRIBUTE(FinalDeNormedRecs, HASH(DID)), HASH(DID), LOCAL), HASH(DID), LOCAL);

EXPORT proc_build_Email_Lkp	:=	OUTPUT(FinalDeNormedRecsDed, , '~thor_data200::temp::DIDEmailLkpAll', OVERWRITE);