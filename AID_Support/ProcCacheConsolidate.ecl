import AID_Support, AID, lib_FileServices;

lUniqueDateTimeSignature	:=	global(workunit + '_' + AID_Support.Common.fGetDateTimeString()) : independent;

string	lRawName	:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Raw, AID_Support.Constants.Filename.ActivityType.Cache, lUniqueDateTimeSignature);
string	lStdName	:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Std, AID_Support.Constants.Filename.ActivityType.Cache, lUniqueDateTimeSignature);
string	lACEName	:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.ACE, AID_Support.Constants.Filename.ActivityType.Cache, lUniqueDateTimeSignature);

string	lRawDiscard			:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Raw, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Discard);
string	lRawGrandFather	:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Raw, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.GrandFather);
string	lRawFather			:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Raw, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Father);
string	lRawProd				:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Raw, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Prod);
sRawSupers							:=	[lRawProd, lRawFather, lRawGrandfather, lRawDiscard];
string	lStdDiscard			:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Std, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Discard);
string	lStdGrandFather	:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Std, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.GrandFather);
string	lStdFather			:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Std, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Father);
string	lStdProd				:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.Std, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Prod);
sStdSupers							:=	[lStdProd, lStdFather, lStdGrandfather, lStdDiscard];
string	lACEDiscard			:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.ACE, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Discard);
string	lACEGrandFather	:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.ACE, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.GrandFather);
string	lACEFather			:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.ACE, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Father);
string	lACEProd				:=	'~' + AID_Support.Common.fConstructFilename(AID_Support.Constants.AddressType.ACE, AID_Support.Constants.Filename.ActivityType.Cache, AID_Support.Constants.Filename.SuperGeneration.Prod);
sACESupers							:=	[lACEProd, lACEFather, lACEGrandfather, lACEDiscard];

zOutputRaw	:=	output(distribute(AID.Files.RawCacheProd, AID), , lRawName, compressed);
zOutputStd	:=	output(distribute(AID.Files.StdCacheProd, AID), , lStdName, compressed);
zOutputACE	:=	output(distribute(AID.Files.ACECacheProd, AID), , lACEName, compressed);

zSendFailureEmail		:=	lib_FileServices.FileServices.SendEmail(Constants.EmailTargetErrors,'FAILED: ProcCacheConsolidate ' + workunit,'FAILED: ProcCacheConsolidate ' + workunit);

export ProcCacheConsolidate := sequential(	parallel(ZOutputRaw, zOutputStd, zOutputACE),
																						lib_fileservices.FileServices.PromoteSuperFileList(sRawSupers, lRawName),
																						lib_fileservices.FileServices.PromoteSuperFileList(sStdSupers, lStdName),
																						lib_fileservices.FileServices.PromoteSuperFileList(sACESupers, lACEName),
																						lib_fileservices.FileServices.ClearSuperFile(lRawDiscard, true),
																						lib_fileservices.FileServices.ClearSuperFile(lStdDiscard, true),
																						lib_fileservices.FileServices.ClearSuperFile(lACEDiscard, true)
																					) : failure(zSendFailureEmail);
