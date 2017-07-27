import AID_Support, lib_FileServices;

string	lUniqueDateTimeSignature	:=	workunit + '_' + AID_Support.Common.fGetDateTimeString();
/**************************************************************************************
** This section is to produce a single-record dataset to use for signature in filenames
**   later, as it is apparently the only way to get a "constant" per run
**************************************************************************************/
rCommonUniqueSignature	:=
record,maxlength(100)
	string	UniqueSignature;
end;
rCommonUniqueSignature	tCommonUniqueSignature(rCommonUniqueSignature pInput)	:=
transform
	self.UniqueSignature	:=	lUniqueDateTimeSignature;
end;
dCommonUniqueSignature	:=	project(dataset([{(string)random()}],rCommonUniqueSignature),tCommonUniqueSignature(left));	// random() prevents common-up of multiples

lRawSuperName	:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Raw, AID_Support.Constants.Filename.ActivityType.Update, workunit);
lStdSuperName	:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Std, AID_Support.Constants.Filename.ActivityType.Update, workunit);
lACESuperName	:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.ACE, AID_Support.Constants.Filename.ActivityType.Update, workunit);

lRawOutput		:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Raw, AID_Support.Constants.Filename.ActivityType.Update, dCommonUniqueSignature[1].UniqueSignature); //'~thor::base::aid::raw::update::' +	dCommonUniqueSignature[1].UniqueSignature;
lStdOutput		:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Std, AID_Support.Constants.Filename.ActivityType.Update, dCommonUniqueSignature[1].UniqueSignature); //'~thor::base::aid::std::update::' +	dCommonUniqueSignature[1].UniqueSignature;
lACEOutput		:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.ACE, AID_Support.Constants.Filename.ActivityType.Update, dCommonUniqueSignature[1].UniqueSignature); //'~thor::base::aid::ace::update::' +	dCommonUniqueSignature[1].UniqueSignature;

lRawFileMask	:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Raw, AID_Support.Constants.Filename.ActivityType.Update, 'w*');
lStdFileMask	:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Std, AID_Support.Constants.Filename.ActivityType.Update, 'w*');
lACEFileMask	:=	AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.ACE, AID_Support.Constants.Filename.ActivityType.Update, 'w*');

dRawLogicals	:=	nothor(lib_FileServices.FileServices.LogicalFileList(lRawFileMask, true, false, true));
dStdLogicals	:=	nothor(lib_FileServices.FileServices.LogicalFileList(lStdFileMask, true, false, true));
dACELogicals	:=	nothor(lib_FileServices.FileServices.LogicalFileList(lACEFileMask, true, false, true));

zCreateRawSuper	:=	nothor(apply(dRawLogicals, lib_FileServices.FileServices.AddSuperFile('~' + lRawSuperName, '~' + name)));
zCreateStdSuper	:=	nothor(apply(dStdLogicals, lib_FileServices.FileServices.AddSuperFile('~' + lStdSuperName, '~' + name)));
zCreateACESuper	:=	nothor(apply(dACELogicals, lib_FileServices.FileServices.AddSuperFile('~' + lACESuperName, '~' + name)));

dRawSuper	:=	dataset('~' + lRawSuperName, AID_Support.Layouts.rRawCacheUpdate, thor);
dStdSuper	:=	dataset('~' + lStdSuperName, AID_Support.Layouts.rStdCacheUpdate, thor);
dACESuper	:=	dataset('~' + lACESuperName, AID_Support.Layouts.rACECacheUpdate, thor);

fMinDate(AID_Support.Constants.xDateString pDate1, AID_Support.Constants.xDateString pDate2)
 :=	if(pDate1 <> '' and pDate1 <= pDate2,
			 pDate1,
			 if(pDate2 <> '',
					pDate2,
					pDate1
				 )
			);

fMaxDate(AID_Support.Constants.xDateString pDate1, AID_Support.Constants.xDateString pDate2)
 :=	if(pDate1 >= pDate2,
			 pDate1,
			 pDate2
			);

dRawSuperDist	:=	distribute(dRawSuper, hash(AID));
dRawSuperSort	:=	sort(dRawSuperDist, AID, IsNormalized, NormalizeFlags, Flags, StdVersion, StdAID, ReferAID, local);
AID_Support.Layouts.rRawCacheUpdate	tRollupRaw(dRawSuperSort pLeft, dRawSuperSort pRight)
 :=
	transform
		self.DateSeenFirst	:=	fMinDate(pLeft.DateSeenFirst, pRight.DateSeenFirst);
		self.DateSeenLast		:=	fMaxDate(pLeft.DateSeenLast, pRight.DateSeenLast);
		self								:=	pLeft;
	end
 ;
dRawSuperRollup	:=	rollup(dRawSuperSort, tRollupRaw(left,right),
													 AID, IsNormalized, NormalizeFlags, Flags, StdVersion, StdAID, ReferAID,
													 local
													);

dStdSuperDist	:=	distribute(dStdSuper, hash(AID));
dStdSuperSort	:=	sort(dStdSuperDist, AID, Cleaner, CleanAID, ReturnCode, ReferAID, local);
AID_Support.Layouts.rStdCacheUpdate	tRollupStd(dStdSuperSort pLeft, dStdSuperSort pRight)
 :=
	transform
		self.DateSeenFirst	:=	fMinDate(pLeft.DateSeenFirst, pRight.DateSeenFirst);
		self.DateSeenLast		:=	fMaxDate(pLeft.DateSeenLast, pRight.DateSeenLast);
		self.DateCleanLast	:=	fMaxDate(pLeft.DateCleanLast, pRight.DateCleanLast);
		self.DateValidFirst	:=	fMinDate(pLeft.DateValidFirst, pRight.DateValidFirst);
		self.DateValidLast	:=	fMaxDate(pLeft.DateValidLast, pRight.DateValidLast);
		self.DateErrorFirst	:=	fMinDate(pLeft.DateErrorFirst, pRight.DateErrorFirst);
		self.DateErrorLast	:=	fMaxDate(pLeft.DateErrorLast, pRight.DateErrorLast);
		self								:=	pLeft;
	end
 ;
dStdSuperRollup	:=	rollup(dStdSuperSort, tRollupStd(left,right),
													 AID, Cleaner, CleanAID, ReturnCode, ReferAID,
													 local
													);

dACESuperDist	:=	distribute(dACESuper, hash(AID));
dACESuperSort	:=	sort(dACESuperDist, AID, CleanAID, ReferAID, local);
AID_Support.Layouts.rACECacheUpdate	tRollupACE(dACESuperSort pLeft, dACESuperSort pRight)
 :=
	transform
		self.DateSeenFirst	:=	fMinDate(pLeft.DateSeenFirst, pRight.DateSeenFirst);
		self.DateSeenLast		:=	fMaxDate(pLeft.DateSeenLast, pRight.DateSeenLast);
		self								:=	pLeft;
	end
 ;
dACESuperRollup	:=	rollup(dACESuperSort, tRollupACE(left,right),
													 AID, CleanAID, ReferAID,
													 local
													);

zOutputRawUpdate			:=	output(dRawSuperRollup, , '~' + lRawOutput, compressed);
zOutputStdUpdate			:=	output(dStdSuperRollup, , '~' + lStdOutput, compressed);
zOutputACEUpdate			:=	output(dACESuperRollup, , '~' + lACEOutput, compressed);

zCleanupIfSuccess			:=	parallel(lib_FileServices.FileServices.DeleteSuperFile('~' + lRawSuperName, true),
																		lib_FileServices.FileServices.DeleteSuperFile('~' + lStdSuperName, true),
																		lib_FileServices.FileServices.DeleteSuperFile('~' + lACESuperName, true)
																	 );

zSendFailureEmail		:=	lib_FileServices.FileServices.SendEmail(Constants.EmailTargetErrors,'FAILED: ProcRollupUpdates ' + workunit,'FAILED: ProcRollupUpdates ' + workunit);

zCleanupIfFailure			:=	parallel(lib_FileServices.FileServices.DeleteSuperFile('~' + lRawSuperName, false),
																		lib_FileServices.FileServices.DeleteSuperFile('~' + lStdSuperName, false),
																		lib_FileServices.FileServices.DeleteSuperFile('~' + lACESuperName, false),
																		lib_FileServices.FileServices.DeleteLogicalFile('~' + lRawOutput),
																		lib_FileServices.FileServices.DeleteLogicalFile('~' + lStdOutput),
																		lib_FileServices.FileServices.DeleteLogicalFile('~' + lACEOutput),
																		zSendFailureEmail
																	 );

EXPORT ProcRollupUpdates	:= sequential(parallel(zCreateRawSuper, zCreateStdSuper, zCreateACESuper),
																				 parallel(zOutputRawUpdate, zOutputStdUpdate, zOutputACEUpdate),
																				 zCleanupIfSuccess
																				) : failure(zCleanupIfFailure);
