import STD;
EXPORT ValidatePRCTFileLayout(string prctbuildversion // version of PRCT indexes built on Thor
																,string thorespip // thor eclwatch/esp IP where the prct indexes are built
																,string certroxieespip // cert roxie fcra/nonfcra/boolean eclwatch/esp IP
																,string dopsdatasetname // Name from DOPS website
																,string dopsclusterflag // N - NonFCRA; F - FCRA; B - Boolean
																,string dopsenvironmentflag = 'Q' // P - Prod Roxie; Q - QA/Cert Roxie
																,string dopslocationflag = 'B' // B - Boca; A - Alpharetta
															) := function

	
	// Get current active cert roxie keys for dataset passed
	
	dNonPRCTKeys := dops.GetRoxieKeys(dopsdatasetname
																			,dopslocationflag
																			,dopsclusterflag
																			,
																			,'N'
																			,'prod'
																		);
	
	rLayoutDetails := record
		string keyedfields;
		string fulllayout;
		string errormsg;
	end;
	
	rCompareLayout := record
		boolean ismatch := true;
		string superkey := '';
		string nonprctkey := '';
		string nonprcterror := '';
		string prctkey := '';
		string prcterror := '';
		dataset(rLayoutDetails) nonprctdetails;
		dataset(rLayoutDetails) prctdetails;
	end;
	
	// Get layout/keyed fields for prct and nonprct keys
	
	rCompareLayout xConvertToPRCTKeys(dNonPRCTKeys l) := transform
		firstword := STD.Str.SplitWords(l.logicalkey,':')[1];
		l_nonprctkey := regexreplace('[\r\n]',l.logicalkey,'');
		l_prctkey := regexreplace
																	('::[0-9]+[a-z]::'
																		,regexreplace
																		('::[0-9]+::'
																			,if ( regexfind('^image',firstword) or regexfind('^key',firstword)
																				,'prte::'+regexreplace('[\r\n]',l.logicalkey,'')
																				,regexreplace(firstword,regexreplace('[\r\n]',l.logicalkey,'',nocase),'prte',nocase)
																				)
																			,'::'+prctbuildversion+'::',nocase)
																		,'::'+prctbuildversion+'::',nocase);
		self.superkey := l.superkey;
		self.nonprctkey := l_nonprctkey;
		self.prctkey :=  l_prctkey;
		self.nonprctdetails := dops.FileInfo(l_nonprctkey
																				,certroxieespip).LayoutDetails();
		self.prctdetails := dops.FileInfo(l_prctkey
																				,thorespip).LayoutDetails();
		self := l;
	end;

	dPRCTKeys := project(dNonPRCTKeys,xConvertToPRCTKeys(left));
	
	// Determine any mismatches in layout
	
	rCompareLayout xisMatch(dPRCTKeys l) := transform
		self.ismatch := if (l.nonprctdetails[1].fulllayout <> l.prctdetails[1].fulllayout
																or l.nonprctdetails[1].keyedfields <> l.prctdetails[1].keyedfields
															,false
															,true);
		self.nonprcterror := if (l.nonprctdetails[1].errormsg <> '', l.nonprctdetails[1].errormsg, '');
		self.prcterror := if (l.prctdetails[1].errormsg <> '', l.prctdetails[1].errormsg, '');
		self := l;
	end;
	
	dFinal := project(dPRCTKeys,xisMatch(left));
		
	return dFinal;
	
end;