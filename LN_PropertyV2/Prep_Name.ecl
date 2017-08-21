import	Address,ut;

export	Prep_Name	:=
module

	export	fnClean2Upper(string	pStr)	:=	stringlib.stringcleanspaces(stringlib.stringtouppercase(pStr));
	
	export	fnLNNameOrder(string	pNameOrder)	:=	case(	pNameOrder,
																											'1'	=>	'FML',
																											'2'	=>	'LFM',
																											'3'	=>	'LFM',
																											''
																										);
	
	// Prep the name (remove FKA, DBA etal)
	export	fnPrepName(string	pName)	:=
	function
		string		vNameUpcase	:=	fnClean2Upper(pName);
		unsigned2	vNameLength	:=	length(vNameUpcase);

		// Line below - If the whole value is only quotes then remove '(' and ')',else remove everything in between '(' and ')'.
		string	vParenContents			:=	if(regexfind('^[(].*[)]$',trim(vNameUpcase)),
																			 regexreplace('[)]$',regexreplace('^[(]',vNameUpcase,''),''),
																			 regexreplace('[(][^)]*[)]',vNameUpcase,'')
																			 );
		string	vRemoveParen				:=	if(	vNameLength	=	2	and	stringlib.stringfind(vNameUpcase,'()',1)	!=	0,
																				'',
																				vParenContents
																			);
		
		string	vRemoveSGNames	:=	if(	vRemoveParen	=	'SG',
																		'',
																		if(	vRemoveParen[1..3]	=	'SG ',
																				vRemoveParen[4..],
																				vRemoveParen
																			)
																	);
		
		string	vBlankBadNames	:=	if(	stringlib.stringfind(vRemoveSGNames,'RECORD',1)	!=	0	and	stringlib.stringfind(vRemoveSGNames,'OWNER',1)	!=	0,
																		'',
																		vRemoveSGNames
																	);

		string	vRemoveBadChars	:=	stringlib.stringcleanspaces(	stringlib.stringfilter(	vBlankBadNames,
																																											'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890;:%/&,.- '
																																										)
																														);

		// Set to blank if value is just a number
		string	vOnlyNumbers		:=	if(	regexfind('^[1234567890-]*$',stringlib.stringcleanspaces(vRemoveBadChars)),
																		'',
																		vRemoveBadChars
																	);

		// Standardize DBA,AKA and FKA acronyms
		string	vStandardizeAcronyms	:=	regexreplace(	'F/K/A ',
																										regexreplace(	'A/K/A ',
																																	regexreplace('D/B/A ',vOnlyNumbers,'DBA ',nocase),
																																	'AKA ',
																																	nocase
																																),
																										'FKA ',
																										nocase
																									);

		string	vRemoveFKA	:=	if(	vStandardizeAcronyms[1..4]	=	'FKA ',
																vStandardizeAcronyms[5..],
																vStandardizeAcronyms
															);

		set of string	vBadNamesSet	:=	['SAME','TRUST','UNKNOWN','HW','VA','CO','LLC THE','LLC'];
		string	vBadNamesPattern1		:=	'^(MM |MW )';
		string	vBadNamesPattern2		:=	'^(SECRETARY/HUD|SEC HUD|USA HUD|HUD)$';
		string	vBadNamesPattern3		:=	' L/TR | L/TRUST ';
		string	vBadNamesPattern4		:=	'/TRUST| TRUS | TRST |/TR';
		string	vBadNamesPattern5		:=	'[-]TRUSTEES |[ -]TRSTS |[ -]TSTEES ';
		
		string	vBlankBadNamePatterns	:=	if(	vRemoveFKA	in	vBadNamesSet,
																					'',
																					regexreplace(vBadNamesPattern1,stringlib.stringcleanspaces(vRemoveFKA),'',nocase)
																				);
		
		string	vReplaceHUD						:=	regexreplace(	'HUD/',
																										if(	stringlib.stringfind(vBlankBadNames,'HUD-HOUSING',1)	!=	0,
																												'HOUSING URBAN DEVELOPMENT',
																												regexreplace(vBadNamesPattern2,stringlib.stringcleanspaces(vBlankBadNamePatterns),'HOUSING URBAN DEVELOPMENT',nocase)
																											),
																										'HOUSING URBAN DEVELOPMENT OF ',
																										nocase
																									);
		
		string	vReplaceLivingTrust		:=	regexreplace(	'STATE/',
																										regexreplace(vBadNamesPattern3,stringlib.stringcleanspaces(vReplaceHUD),' LIVING TRUST ',nocase),
																										'STATE OF ',
																										nocase
																									);
		
		string	vReplaceTrust					:=	regexreplace(vBadNamesPattern4,vReplaceLivingTrust,' TRUST ',nocase);
		
		string	vReplaceTrustees			:=	regexreplace(	'-CO-',
																										regexreplace(vBadNamesPattern5,stringlib.stringcleanspaces(vReplaceTrust),' TRUSTEES ',nocase),
																										' ',
																										nocase
																									);
		
		string	vReplaceOthers				:=	regexreplace(	'^(C/O|%|,|\\)',
																										regexreplace(' LE$| TE$',stringlib.stringcleanspaces(vReplaceTrustees),'',nocase),
																										'',
																										nocase
																									);
		
		string	vReplaceOwnerParts		:=	regexreplace(	' [0-9]/[0-9] ',
																										regexreplace(	' [A-Z]/[A-Z] ',
																																	regexreplace('[0-9]+ %',
																																								regexreplace(	'[0-9 ]+%',
																																															regexreplace(	' [0-9]+/[0-9]+/[0-9][0-9]+ ',
																																																						vNameUpcase,
																																																						' '
																																																					),
																																															' '
																																														),
																																								' '
																																							),
																																	' '
																																),
																										' '
																									);

		string	vReplaceINT						:=	stringlib.stringcleanspaces(	regexreplace(	' INT ',
																																									stringlib.stringfindreplace(vReplaceOwnerParts,'.',' '),
																																									' '
																																								)
																																	);
		
		string	vReplaceDates					:=	stringlib.stringcleanspaces(	regexreplace(	'([ ][0-9]*[/|-]?[0-9]*[-|/]?[0-9]+)$',
																																									vReplaceINT,
																																									' '
																																								)
																																	
																																	);
		
		return	stringlib.stringcleanspaces(vReplaceDates);
	end;
	
	// Function to remove bad patterns in names
	export	fnStandardizeName(string	pName)	:=
	function
		string		vNameUpcase	:=	fnClean2Upper(pName);
		unsigned2	vNameLength	:=	length(vNameUpcase);
		
		// Line below - If the whole value is only quotes then remove '(' and ')',else remove everything in between '(' and ')'.
		string	vParenContents			:=	if(regexfind('^[(].*[)]$',trim(vNameUpcase)),
																			 regexreplace('[)]$',regexreplace('^[(]',vNameUpcase,''),''),
																			 regexreplace('[(][^)]*[)]',vNameUpcase,'')
																			 );
		string	vRemoveParen				:=	if(	vNameLength	=	2	and	stringlib.stringfind(vNameUpcase,'()',1)	!=	0,
																				'',
																				vParenContents
																			);
		
		string	vBadNamesPattern1		:=	' ACCOUNTS PAYABLE | ACCTS PAYABLE | ARCHBIXHOP | CONSERVATOR | IRREV TRU II |';
		string	vBadNamesPattern2		:=	'CO-EXECUTOR| EXECUTOR | FAMILY LP | FAMILY L P| GUARDIAN | GUARDN | GDN  |';
		string	vBadNamesPattern3		:=	'MD PA PEN PLAN|MD PA PROFIT-|DO PA PEN PLAN & TRU|DMD PA PROFIT SH|';
		string	vBadNamesPattern4		:=	'DDS PA PROFIT SHARING PLAN & TRUST|DDS PA PROFIT SHARING PLAN|MD PA PROFIT SHARING PLAN|';
		string	vBadNamesPattern5		:=	' IN REGARDS | IN REGARD | IN RE |[\\- ]LIFE ESTATE | LIFE EST | PER REP | UNDIV | UND | SUR CL |';
		string	vBadNamesPattern6		:=	' DECEASED | DECD | DEC | EXRX | WIDOW | WIDOWER |MR & MRS|MR AND MRS|';
		string	vBadNamesPattern7		:=	'J-TRUST|L-TRUST|- TRUST |- TR | LT | REGARDS|REGARDING | TRES | TRES$| TRE |';
		string	vBadNamesPattern8		:=	'HUSBAND & WIFE|HUSBAND AND WIFE|HER HUSBAND|HIS WIFE| SPOUSE |[/ ]HUSBAND[ \\-]|[/ ]WIFE[ \\-]|';
		string	vBadNamesPattern9		:=	' HB |[/ ]WF | HRS OF | OF HRS |  HRS |UNKNOWN | KNOWN |SECRETARY OF|THEN TO|ITMO:|ATTN:|';
		string	vBadNamesPattern10	:=	' DEC EST |[,]ETAL |[,]ET AL | ETALS | ET ALS | ET ALS TRS |[,]ETUX |[,]ET UX |[,]ETVIR |[,]ET VIR ';
		string	vBadNamesPattern11	:=	'LAW OFFICES OF|LAW OFFICES|LAW OFFICE OF|LAW OFFICE|';
		string	vBadNamesPattern12	:=	' REAL ESTATE | RE ESTATE | ESTATE OF| ESTATE | RE EST | EST OF | EST |';
		string	vBadNamesPattern13	:=	' FAMILY TRUST | FAMILY TR | FAM TRUST | FAM TR | LIVING TRUST | LIVING TR |';
		string	vBadNamesPattern14	:=	'REVOCABLE LIVING TRUST|REVOCABLE LIVING|REVOCABLE TRUST OF|REVOCABLE TRUST|';
		string	vBadNamesPattern15	:=	'REVOCABLE TR|REVOCABLE|REVOC TRUST| REV TRUST |REV LIV TR|REV TR |LIVING TRUST UND|';
		string	vBadNamesPattern16	:=	'INDEPENDENT TRUST FBO|INDEPENDENT TRUST|INDPNT TRUST CORP FBO|INDPNT TRUST FBO|INDPNT TRUST|';
		string	vBadNamesPattern17	:=	'TRUSTEES OF THE |TRUSTEES OF |TRUSTEES FOR | TRUSTEES |IN TRUST FOR| TRUST THE|';
		string	vBadNamesPattern18	:=	'TRUSTEE OF THE |TRUSTEE OF |TRUSTEE FOR |[\\- ]TRUSTEE | TRUSTE | TRSTEES | TRSTE | TRST | TRU ';
		
		string	vBadNamesPattern		:=	vBadNamesPattern1		+	vBadNamesPattern2		+	vBadNamesPattern3		+	vBadNamesPattern4		+
																		vBadNamesPattern5		+	vBadNamesPattern6		+	vBadNamesPattern7		+	vBadNamesPattern8		+
																		vBadNamesPattern9		+	vBadNamesPattern10/*	+	vBadNamesPattern11	+	vBadNamesPattern12	+
																		vBadNamesPattern13	+	vBadNamesPattern14	+	vBadNamesPattern15	+	vBadNamesPattern16	+
																		vBadNamesPattern17	+	vBadNamesPattern18*/
																		;
	
		string	vStandardizeName	:=	regexreplace(vBadNamesPattern,vRemoveParen,' ');
		
		return	regexreplace(',$',stringlib.stringcleanspaces(vStandardizeName),'');
	end;
	
	// Check if the name is one word
	export	fnIsOneWord(string	pName)	:=
	function
		string	vNameUpcase		:=	fnClean2Upper(pName);

		string	vCleanName		:=	regexreplace('^(AKA |DBA )',vNameUpcase,' ',nocase);

		boolean	vOneWordFlag	:=	if(			vCleanName	!=	''
																	and	stringlib.stringfind(vCleanName,',',1)	=	0
																	and	length(stringlib.stringcleanspaces(vCleanName))	=	length(stringlib.stringcleanspaces(regexreplace(' ',vCleanName,''))),
																	true,
																	false
																);

		return	vOneWordFlag;
	end;
	
	// Set for name suffixes
	export	set	of	string	NameSuffix	:=	[	'JR.','SR.','JR','SR','I','II','III','IV','V','VI','VII','VIII','IX',
																						'X','XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX'
																					];
	
	// Pattern for name suffixes
	export	string	NameSuffixPattern		:=	'( JR.| SR.| JR| SR| I| II| III| IV| V| VI| VII| VIII| IX| X| XI|  XII| XIII| XIV| XV| XVI| XVII| XVIII| XIX| XX)$';
	
	// Prep the conjunctive names - like adding the last name
	export	fnPrepConjunctiveNames(string	pName,string	pLastName,string	pFirstName)	:=
	function
		string	vCleanName		:=	fnClean2Upper(pName);
		string	vLastName			:=	fnClean2Upper(pLastName);
		string	vFirstName		:=	fnClean2Upper(pFirstName);
		
		integer	vNumTokens		:=	ut.NoWords(vCleanName);
		
		string	vFirstToken		:=	ut.Word(vCleanName,1);
		string	vSecondToken	:=	ut.Word(vCleanName,2);
		string	vRemainingStr	:=	if(	vNumTokens	>	2,
																	vCleanName[stringlib.stringfind(vCleanName,' ',2)+1..],
																	''
																);
		
		string	vSwapTokens		:=	if(	length(vFirstToken)	=	1	and	length(vSecondToken)	!=	1	and	vSecondToken	not in	NameSuffix,
																	vSecondToken	+	' '	+	vFirstToken,
																	vFirstToken	+	' '	+	vSecondToken
																);
		
		string	vSwappedName	:=	stringlib.stringcleanspaces(vSwapTokens	+	' '	+	vRemainingStr);
		
		string	vLNamePattern	:=	'^('	+	vLastName	+	')|( '	+	vLastName	+	')';
		
		string	vPrepName			:=	if(	regexfind(vLNamePattern,vSwappedName,nocase),
																	stringlib.stringcleanspaces(vLastName	+	' '	+	regexreplace(vLNamePattern,vSwappedName,'')),
																	if(	length(vCleanName)	=	1,
																			vLastName	+	' '	+	vFirstName	+	' '	+	vSwappedName,
																			vLastName	+	' '	+	vSwappedName
																		)
																);
		
		return	vPrepName;
	end;
	
end;