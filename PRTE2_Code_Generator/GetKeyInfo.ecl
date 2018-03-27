import dops, STD;
// Used to get info about keys and key layouts from the cluster.

EXPORT GetKeyInfo(	string dopskeyname, 
					string dopsFCRAkeyname ='', 
					string eflag = 'N', 
					string location = 'B') := FUNCTION

	dNonPRCTKeys := dops.GetRoxieKeys(dopskeyname
							, location
							, 'N'
							,
							,'N'
							,'prod'
						);
						
	dFCRANonPRCTKeys := dops.GetRoxieKeys(dopsFCRAkeyname
							, location
							, 'F'
							,
							,'N'
							,'prod'
						);		
						
	allKeyRecs := IF (dopsFCRAkeyname = '', dNonPRCTKeys, dFCRANonPRCTKeys + dNonPRCTKeys);

	layouts.superkeyrecs xform1(allKeyRecs l) := transform
		SELF.FileDetails := dops.FileInfo(l.logicalkey, Constants.RoxieCert).LayoutDetails();
		SELF.keyedfields := regexreplace('^(,)',SELF.FileDetails[1].keyedfields, ''); 
		SELF.layout 	:= SELF.FileDetails[1].fulllayout;
		rec_layout_sc := regexreplace(',', SELF.FileDetails[1].fulllayout, ';');
		rep1 := regexfindset('\\b\\w+\\b;', rec_layout_sc);
		rep2 := STD.Str.CombineWords(rep1,',');
		full_rec_layout := regexreplace(';|,end;',rep2,'', NOCASE);
		firstword := STD.Str.SplitWords(l.superkey,':')[1];
		SELF.full_layout := full_rec_layout;
		self.orig_logicalkey := regexreplace('[\r\n]',l.logicalkey,'',nocase);//regexreplace(firstword,regexreplace('[\r\n]',l.logicalkey,'',nocase),'prte',nocase);
		SELF.qa_key := regexreplace(firstword,regexreplace('[\r\n]',l.superkey,'',nocase),'prte',nocase);
		SELF.logicalkey :=  '~' + regexreplace(firstword,
								regexreplace('::[0-9]+[a-z]*::', l.logicalkey,'::\' + filedate + \'::', NOCASE)
							,'prte',nocase);
		SELF.superkey := '~' + regexreplace('qa',SELF.qa_key,'@version@', nocase) ;
		SELF.keyname := 	regexreplace('[\\.]', 
												regexreplace('__',
													'key_' + 
													regexreplace('::',
														regexreplace('~prte::key::',
															regexreplace('@version@',
																SELF.superkey
																,'_',nocase)
														,'',nocase)
													,'',nocase)
												,'',nocase)
											, '_');
							
		SELF.qa_key_create_sf := 'MakeSuperKeys (\'' +
		SELF.superkey  +'\');';
		SELF := l;
	end;

	prctSFRec := PROJECT(allKeyRecs, xform1(LEFT));

	return prctSFRec;
end;