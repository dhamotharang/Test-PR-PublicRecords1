import lib_DataLib, Address, lib_StringLib, lib_FileServices, ut;

export mRawStructToStd(string pLine1, string pLine2='', string pLine3='', string pLineLast)
 :=
  module
		shared		unsigned1	lNormalizeCount	:=	3;
		
		/*************************************************************************************/
		shared		string		fPOBPartString(string pString)
								 :=
									function
										string	lPossiblePOB				:=	regexfind(' ' + Common.ePOBoxReplacement + ' [0-9|A-Z]+[\\-|/]?[0-9|A-Z|\\-|/]*?;?\\,? ?',pString,0);
										string	lNoSlashAfterHyphen	:=	if(regexfind('.*\\-.*/',lPossiblePOB),
																											 regexfind('(.*?)/',lPossiblePOB,1),
																											 lPossiblePOB
																											);
										string	lWithoutMultiHyphen	:=	if(regexfind('.*\\-[^ ]*[\\-|/]',lNoSlashAfterHyphen),
																											 regexfind('(.*)[\\-|/]',lNoSlashAfterHyphen,1),
																											 lNoSlashAfterHyphen
																											);
										boolean	lIsHyphenated				:=	regexfind('[\\-|/]',lWithoutMultiHyphen);
										string	lPostPOBToken				:=	if(not lIsHyphenated,
																											 '',
																											 regexfind(lWithoutMultiHyphen + '([^ ]+)',pString,1)
																											);
										boolean	lLettersInPostToken	:=	if(lPostPOBToken <> '',
																											 regexfind('[A-Z]',lPostPOBToken),
																											 false
																											);
										boolean	lLettersAfterHyphen	:=	if(lIsHyphenated,
																											 regexfind('\\-[A-Z]{2,999}',lWithoutMultiHyphen),
																											 false
																											);
										boolean	lPostStartsSlash		:=	if(lIsHyphenated,
																											 lPostPOBToken[1] = '/',
																											 false
																											);
										string	lReturnPOB					:=	if((lLettersInPostToken or lLettersAfterHyphen) and not lPostStartsSlash,
																											 regexfind('(.*)[\\-|/][^\\-|/]*$',lWithoutMultiHyphen,1),
																											 lWithoutMultiHyphen
																											);
										return	lReturnPOB;
									end
								 ;

		// Prep line 1:  force to uppercase, compact all consecutive spaces to single spaces
//		shared		string		fPrepCommon(string pStringIn)	:=	lib_StringLib.StringLib.StringCleanSpaces(lib_StringLib.StringLib.StringToUpperCase(pStringIn));
		shared	string	fRawFixCommon(string pStringIn)	:=
		function
			string	lNoPeriod						:=	regexreplace('([^0-9])\\.',pStringIn,'\\1 ');
			string	lNoComma						:=	lib_StringLib.StringLib.StringFindReplace(lNoPeriod,',',' ');
			string	lCleanSpaces				:=	lib_StringLib.StringLib.StringCleanSpaces(lNoComma);
			string	lUpperCase					:=	lib_StringLib.StringLib.StringToUpperCase(lCleanSpaces);
			return	lUpperCase;
		end;

		shared	string	fRawFixLine1(string pStringIn)	:=
		function
			string	lFixedCommon				:=	fRawFixCommon(pStringIn);
			string	lFixReversedPOBox		:=	regexreplace('^([0-9]+) (PO BOX)$',lFixedCommon,'\\2 \\1');		// Must be in form of "1234 PO BOX" only, with no extraneous chars
			return	lFixReversedPOBox;
		end;

		shared	string	fRawFixLineLast(STRING pStringIn)	:=
		function
			string	lFixedCommon				:=	fRawFixCommon(pStringIn);
			string	lSplitStateAndZip		:=	regexreplace('(^| )([A-Z]{2})([0-9]{5})(-?[0-9]{4})?$',lFixedCommon,'\\1\\2 \\3\\4');
			string	lDropZip4						:=	regexreplace('(^| )([0-9]{5})-?[0-9]{4}$',lSplitStateAndZip,'\\1\\2');
			return	lDropZip4;
		end;

		// Prep line 1:  upper, compact, adding leading/trailing space
		shared		string		lLine1Prepped				:=	' ' + fRawFixLine1(pLine1) + ' ';
		// Prep line 1:  convert dot-separated multi-directions (e.g. "S.W." or "N.E") by removing dot(s).  Note: "S. W." unaffected
		shared		string		lLine1FixCommonDir	:=	regexreplace(' ([N|S])[\\.]([E|W])[\\.| ] ?([^ ]*)',lLine1Prepped,' \\1\\2 \\3');
		// Prep line 1:  convert multi-hypened characters into double-hyphen
		shared		string		lLine1ObeyDash			:=	regexreplace('\\-{2,}',lLine1FixCommonDir,'--');
		// Prep line 1:  convert variations of "PO BOX" values to "PO BOX" including (but not limited to) "POB" & "P.O. BOX" & "P.O. BX"
		shared		string		lLine1CommonPOB			:=	regexreplace(' P\\.? ?O\\.?B?\\.? ?B ?(?:X|OX)?\\.? ',lLine1ObeyDash,' ' + Common.ePOBoxReplacement + ' ');
		shared		boolean		lPOBFound						:=	lib_StringLib.StringLib.StringFind(lLine1CommonPOB,Common.ePOBoxReplacement,1) <> 0;
		// From line 1:  get PO BOX part, including box numbers/letters
		shared		string		lPOBPart						:=	lib_StringLib.StringLib.StringFindReplace(fPOBPartString(lLine1CommonPOB),'\\','');
		// From line 1:  get pos of PO Box part:  0=not found, 1=first part, 2=final part, 3=middle part
		shared		unsigned1	lIsPOBPartPos				:=	if(lPOBPart <> '',
																									 if(regexfind('^ *' + lPOBPart,lLine1CommonPOB),
																											1,
																											if(regexfind(lPOBPart + ' *$',lLine1CommonPOB),
																												 2,
																												 3
																												)
																										 ),
																									 0
																									);
		shared		string		lPrePOBPart					:=	if(lIsPOBPartPos in [0, 2, 3],
																									 regexfind('^(.*)' + lPOBPart,lLine1CommonPOB,1),
																									 ''
																									);
		shared		string		lPostPOBPart				:=	if(lIsPOBPartPos in [1, 3],
																									 regexfind(lPOBPart + '(.*)$' ,lLine1CommonPOB,1),
																									 ''
																									);
		shared		string		fPostFixCommon(string pStringIn)
								 :=
									function
										string		lCleaned					:=	regexreplace('^[\\-|/| ]*(.*)[\\-|/| ]*$',pStringIn,' \\1 ');
										string		lNoCommasNum			:=	regexreplace('([0,9])\\,([0,9])',lCleaned,'\\1\\2');
										string		lNoCommas					:=	regexreplace('\\,',lNoCommasNum,' ');
										string		lNoShortAbbrev		:=	regexreplace('( [A-Z])\\.([A-Z] )',lNoCommas,'\\1\\2');
										string		lNoAbbrev					:=	regexreplace('([^0-9])\\.',lNoShortAbbrev,'\\1 ');
										string		lNoTrimSlashDash	:=	regexreplace('^[\\/|\\-| ]*(.*?)[\\/|\\-| ]*$',lNoAbbrev,'\\1');
										string		CleanSpaces				:=	trim(lib_StringLib.StringLib.StringCleanSpaces(lNoTrimSlashDash),left,right);
										return		CleanSpaces;
									end
								 ;

		shared		string		lPrePOBPartComplete														:=	if(lPrePOBPart <> '',fPostFixCommon(lPrePOBPart),'');
		shared		string		lPOBPartComplete															:=	if(lPOBPart <> '',fPostFixCommon(lPOBPart),'');
		shared		string		lPostPOBPartComplete													:=	if(lPostPOBPart <> '',fPostFixCommon(lPostPOBPart),'');
		shared		typeof(Layouts.rStdCache.LineLast)	lLineLast						:=	fRawFixLineLast(pLineLast);
		shared		typeof(Common.eNormalizeFlag)				lPrePOBPartFilled		:=	if(lPrePOBPartComplete <> '',Common.eNormalizeFlag.PrePOBPart,0);
		shared		typeof(Common.eNormalizeFlag)				lPOBPartFilled			:=	if(lPOBPartComplete <> '',Common.eNormalizeFlag.POBPart,0);
		shared		typeof(Common.eNormalizeFlag)				lPostPOBPartFilled	:=	if(lPostPOBPartComplete <> '',Common.eNormalizeFlag.PostPOBPart,0);
		shared		typeof(Common.eNormalizeFlag)				lNormalizeFlags			:=	lPrePOBPartFilled | lPOBPartFilled | lPostPOBPartFilled;

		/*************************************************************************************/
		export		boolean															fIsNormalized				:=	lNormalizeFlags Not In [Common.eNormalizeFlag.None,Common.eNormalizeFlag.PrePOBPart,Common.eNormalizeFlag.POBPart];
		export		typeof(Common.eNormalizeFlag)				fNormalizeFlags			:=	if(fIsNormalized,lNormalizeFlags,Common.eNormalizeFlag.None);
		export		typeof(Layouts.rStdCache.Line1)			fPrePOBPart					:=	lPrePOBPartComplete;
		export		typeof(Layouts.rStdCache.Line1)			fPOBPart						:=	lPOBPartComplete;
		export		typeof(Layouts.rStdCache.Line1)			fPostPOBPart				:=	lPostPOBPartComplete;
		export		typeof(Layouts.rStdCache.Line1)			fLine1Full					:=	trim(trim(lPrePOBPartComplete) + trim(' ' + lPOBPartComplete) + trim(' ' + lPostPOBPartComplete),left,right);
		export		typeof(Layouts.rStdCache.LineLast)	fLineLast						:=	fRawFixLineLast(pLineLast);
		export		typeof(Layouts.rRawCache.StdVersion)	fStdVersion				:=	Common.eStdVersion;

		/*************************************************************************************/
		shared		dEmpty			:=	dataset([{''}],{string1 junk});

		Layouts.rStdCache tPrimeStdFromRawStruct(dEmpty pInput, integer pCounter)
		 :=
			transform
				self.Line1											:=	case(pCounter,
																								 1	=>	if(lPrePOBPartFilled <> 0,fPrePOBPart,skip),
																								 2	=>	if(lPOBPartFilled <> 0,fPOBPart,skip),
																								 3	=>	if(lPostPOBPartFilled <> 0,fPostPOBPart,skip),
																								 skip
																								);
				self.LineLast										:=	lLineLast;
				self.AddressType								:=	Common.eAddressType.Std;
				self.Hash32_FUll								:=	hash32(self.Line1,self.LineLast);
				self       											:=	[];
			end                                   			
		 ;                                      			
		shared	dPrimeStdAddressFromRawStruct	:=	normalize(dEmpty,lNormalizeCount,tPrimeStdFromRawStruct(left,counter));
		export	fPrimeStdFromRawStruct			:=	dPrimeStdAddressFromRawStruct;
	end
 ;
