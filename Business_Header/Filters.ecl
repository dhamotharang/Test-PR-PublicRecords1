import header, phonesplus, irs_Dummy, doxie, ut, PAW, corp2, mdr, STD;

export Filters :=
module
	
	shared scrubcompanyname(string pcompany_name) :=
	function
		//find number of quotes
		numsinglequotes := length(trim(stringlib.stringfilter(pcompany_name, '\''),left,right));
		numdoublequotes := length(trim(stringlib.stringfilter(pcompany_name, '"'),left,right));

		//only trim the quotes if there is 2
		//otherwise, there are cases where the quotes are just quoting one word
		//at the beginning, and one word at the end, and this would remove the leading and trailing
		//but leave the ones inside the string, which is not good.  So, will avoid those cases for now
		//and grab the low hanging fruit
		
		returnstring := if(numsinglequotes = 2 or numdoublequotes = 2
													,regexreplace('^(["\']*)(.*?)(\\1)$', trim(pcompany_name,left,right), '$2', nocase)
													,pcompany_name
										);
										
		return trim(returnstring,left,right);

	end;
		
		
	shared trimids(string pid) := trim(pid,left,right);
	
	// -- ZOOM vendor_id's that will be filtered from Business contacts and PAW files for the below bug tickets.
	// -- JIRA - DF-19683 Cons. Adv. - LexID 1063521771 Remove PAW & Business Contacts Record
	// -- JIRA - DF-19164 Consumer Advocacy - Remove Zoom Records for LexID 1525274139 -
	// -- JIRA - DF-19343 Consumer Advocacy - Removal of PAW and Business Contacts Record for Tanemura
	// -- JIRA - DF-19818 - Consumer Adv - PAW Record Lex ID: 1974474589 Pickens
	// -- JIRA - DF-20268 - ZOOM Paw record to be removed
	// -- JIRA - DF-20347 - Overlinking of PAW Zoom Record in Lexid 1443992436 - Consumer Advocacy
	// -- JIRA - LNK-788 - Overlinking of Mary J Conley - LexID 496119776 in PAW Record
	// -- JIRA - DF-20087 - Consumer Disputing PAW record - from zoom
	// -- JIRA - DF-21021 - Wrongly Linked Zoom Record-LexID 257274842 Consumer Advocacy
	// -- JIRA - DF-21627 - Incorrect Linking PAW - LexID 9785873368
	// -- JIRA - DF-21478 - Consumer Adv - Overlinked PAW/Business Contacts - LexID 1120761903
	// -- JIRA - DF-22103 - Cons. Adv. - PAW Overlinking LexID 975637332 Gowda
	// -- JIRA - DF-23058 - Paw and Bus Header Records to be removed
	// -- JIRA - DF-22156 - Cons. Adv. - PAW Overlinking - LexID 175941365 - Bell
	// -- JIRA - DF-22311 - Cons. Adv. - Overlinking of PAW for LexID : 2376165181 Alexander
	// -- JIRA - DF-23263 - Consumer Dispute - Paw and Bus Header Records to be Removed
	// -- JIRA - DF-22559 - Consumer Dispute - PAW record to be removed
	// -- JIRA - DF-23018 - Consumer Dispute - Paw Record to be removed
	shared Bad_zoom_vend_ids := [	'1901732652   C23201883',
																'1793702174   C355227920',
																'1793716775   C355227920',
																'1576032856    C351610898',
																'1645018152   C345926789',
																'701965807C343689127',
																'1910149483   C119243747',
																'1166594123    C37536530',
																'1676507481   C37536530',
																'1149525038   C37536530',
																'1665485437   C37536530',
																'2083107149    C107741806',		// JIRA - LNK-788
																'2083107149    C232603813',		// JIRA - LNK-788
																'2061716462    C344399990',
																'3941486       C275579153',
																'1343528727   C354557740',		// JIRA - DF-21627
																'1292818441   C344452260',		// JIRA - DF-21478
																'1615571128   C368649983',		// JIRA - DF-22103
																'1921742036    C71944602',		// JIRA - DF-23058
																'1217197599C70371215',				// JIRA - DF-22156
																'1454639708    C1130871',			// JIRA - DF-22311
																'1454639708    C346868419',		
																'1454639708    C87114637',		
																'87572294C75531529',					// JIRA - DF-23263
																'1188573908C41815327',				// JIRA - DF-22559
																'1281160320C26201112',
																'381789420     C26201112',
																'1281160320    C26201112',
																'1346792667C92292992'					// JIRA - DF-23018
															 ];
	
	export Input :=
	module
	
		export Business_headers(
		
			 dataset(Layout_Business_Header_New) 	pInput
			,boolean															pFilterOut = true
		
		) := 
		function
		
			STRING name_chars := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

			boolean lStandardFilter 	:= 		pInput.company_name 									= ''	//Discard records with blank company names
											or	StringLib.StringFilter(pInput.company_name, name_chars) = ''	//company name must be alphanumeric
											or	regexfind('^null$', trim(pInput.company_name), nocase)	//company name must be alphanumeric
											or (		pInput.state			= '' // Bug: 38505 - removing records where there is just a name
													and	pInput.prim_name 	= '' 
													and pInput.prim_range = '' 
													and pInput.city 			= '' 
													and pInput.fein 			= 0 
													and pInput.phone 			= 0
													//Bug 48030 - allow corp records with company name only into business headers
													and not mdr.sourceTools.sourceisCorpV2(pInput.source)
												)
											;
			boolean lAdditionalFilter	:=	 (MDR.sourceTools.SourceIsOR_Watercraft(pInput.source) and pInput.vendor_id[1..2] in ['OR']) //Discard Oregon Watercraft records
											or  (		pInput.bdid	>= irs_dummy.bdid_cutoff
												)
				///////////////////////////////////////////////////////////////////
				// -- Bug 29741 -- Zoom record not correct, filter out
				///////////////////////////////////////////////////////////////////
				or (
							MDR.sourceTools.SourceIsZOOM(pInput.source)
					and pInput.vendor_id 	= '382516491'
					and pInput.phone 			= 2256739233
					and (			pInput.state			= 'MD'
								or	pInput.state			= ''
							)
				)
				// -- Bug 37037 - Business Header has garbage data with year value for company_name
				or (regexfind('^(?![^[:alpha:]]*[[:alpha:]]+)[^[:digit:]]*[[:digit:]]+.*$', trim(pInput.company_name,left,right)))
				
				// Bug: #37728 - Remove MO Vehicles and DLs from business header and contacts			
				or (pInput.vendor_id[1..2] = 'MO' and 
					(			MDR.sourceTools.SourceIsVehicle	(pInput.source)
						or	MDR.sourceTools.SourceIsDL			(pInput.source)
					)
				)
				or (pInput.vendor_id[1..2] = 'A9' and MDR.sourceTools.SourceIsLiens		(pInput.source))
				// -- Bug: 55936 - IRS 5500 data causing inappropriate overlink
				or	(MDR.sourceTools.SourceIsIRS_5500(pInput.source) and trim(pInput.vendor_id,left,right) = '84037345552793')
				// -- Bug: 89358 - Overlinking of Advance Brands with Remodel USA
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vendor_id,left,right) = '722719402' and (pInput.bdid = 77508945 or not regexfind('remodel',pInput.Company_name,nocase)))
				// -- Bug: 95843 - Overlinking of Barbara Griffith with Southern California Pipeline
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vl_id,left,right) = '811133084' /*and pInput.did = 1000628853*/)
				// -- Bug: 103804 - Questionable Company Names.
				// -- Bug: 145649 - Accurint 52354 - PAW Overlinking of LexID 2715613629 D. Williams
				// -- Bug: 191918/JIRA: DF-14772 - Consumer Privacy Reports Incorrectly Linked PAW Record
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) in ['1542124062','731821740','731821740C20895717','645546729     C352857954'])
				// -- Bug: 107798 - Remove two Business Header records with wrong source codes.
				//or	(MDR.sourceTools.SourceIsAK_Corporations(pInput.source) and pInput.bdid in [4994780, 412358992, 16952458])
				or	(MDR.sourceTools.SourceIsAK_Corporations(pInput.source) and 
						 trim(pInput.company_name,left,right) = 'FRIEDLINE AND ASSOCIATES, INC.' and
						 trim(pInput.prim_range) = '1729' and trim(pInput.prim_name) = 'DURRETT')
				// -- Bug: 87127 - Overlinking of business contacts due to errorneous CP FBN Filing.
				or	(MDR.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vendor_id,left,right) = 'CP9627346981847888151')
				// -- Bug: 113227 - Business Header contains errorneous Corporation record.
				or	(MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) = '06-01620279' and trim(pInput.city) = 'CULVER CITY')
				// -- Bug: 93269 - J&L linking to incorrect company in business report
				or  (MDR.sourceTools.SourceIsZoom(pInput.source) and pInput.source_group = '96813300')
				// -- Bug:121240 -Hewlett Packard Bus Search Result on Portal returns D&B Report
				or  ((MDR.sourceTools.SourceIsAZ_Corporations(pInput.source) or MDR.sourceTools.SourceIsUCCV2(pInput.source)) and pInput.source_group in ['04-F08167145','DNB000173979719961223'])
				// -- Bug:  - Flush the Jigsaw records as per Jason.
				or	(MDR.sourceTools.SourceIsJigsaw(pInput.source))
				// -- Bug # 146862 - These corp keys need to be filtered out of all base files
				or	(MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) in ['06-03155932', '06-200820510058', '06-200620910099'])
				// -- Bug: 162276  - API ESP: BusinessSearch returns hex characters as the Company Name
				or	(MDR.sourceTools.SourceIsYellow_Pages(pInput.source) and ~regexfind(' ',trim(pInput.company_name,left,right),nocase) and trim(pInput.prim_name) = 'MARIETTA' and pInput.dt_last_seen in [20131104,20131105,20131108,20131111,20131113,20131114,20131118,20131119,20140324])
				// -- Bug:98757 - Experian Business Report Filing Numbers are Overlinking Oregon Companies
				or	(MDR.sourceTools.SourceIsEbr(pInput.source) and trim(pInput.source_group,left,right) = '809376459' and regexfind('HEALTHCARE|HOSPITAL',trim(pInput.company_name,left,right),nocase))
				// -- Bug: 174042 - Remove Business Records for J. Vaziri per Privacy Programs Direction
				or	(MDR.sourceTools.SourceIsUCCS(pInput.source) and trim(pInput.vendor_id,left,right) = 'UT28041200122' and trim(pInput.company_name) = 'JENNIFER VAZIRI')
				// -- Bug: 162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vl_id,left,right) = '74072915' and pInput.phone in [5053440663, 5053451176])
				// -- JIRA:DF-16735 Per Privacy Programs - Remove PETER KIRN records.
				or	(regexfind('CAMELBACK GROUP|PETER KIRN|PETERKIRN', pInput.company_name, nocase) and ((pInput.state = 'CO' and trim(pInput.city) in ['GREENWOOD VILLAGE','WINTER PARK','TABERNASH']) or pInput.phone in [3039186563,8702926547]))
				or	(regexfind('PETER KIRN|PETERKIRN', pInput.company_name, nocase))
				; 		

			boolean lFullFilter 		:= if(pFilterOut
																		,not(lStandardFilter or lAdditionalFilter)	//negate it 
																		,(lStandardFilter or lAdditionalFilter)
																	);

			///////////////////////////////////////////////////////////////////
			// -- Bug 25304 -- blank this phone
			// -- Bug 24219 -- Remove this phone
			// -- Bug 42887 -- blank bad phones
			///////////////////////////////////////////////////////////////////
			Layout_Business_Header_New tblankoutphone(Layout_Business_Header_New l) :=
			transform
				
				filterbug71237 :=			l.bdid	= 128805790
													and l.phone	= 5619994400
												;

				filterbug25304 :=			l.phone					= 2127938763
													and l.company_name	= 'CITIGROUP'
												;
				
				filterbug24219 :=		l.company_name	= 'WASTE MANAGEMENT' 
												and l.prim_range		= '6521' 
												and l.prim_name 		= 'VANDERBILT'
												and l.zip 					= 77005
												;
				// Bug: 48348 - DNB, Duns# 364405423 is linking two unrelated businesses
				blankbug48348 := trimids(l.vendor_id) = '364405423' 
												and mdr.sourcetools.SourceIsDunn_Bradstreet(l.source)
												and trimids(l.source_group) = '364405423'
												and trim(l.company_name) = 'EAST LOS ANGELES BAKERY, INC.'
												;
				// Bug: 42740 - Business FEIN #'s transposed
				filterbug42740 :=		regexfind('ELDORADO MANAGEMENT',l.company_name,nocase) 
												and l.fein					= 430915544 
												;				
				// JIRA - DF-8591 Cell Phone reassigned to Irene Pappas 
				filter_DF8591 := trim(l.vendor_id) = '714726209'	and l.phone	= 2673125159
												;				
				// JIRA - DF-21083 PAW Error for LexID 947738531, Heagerty - Consumer Advocacy 
				filter_DF21083 :=	mdr.sourcetools.SourceIsDunn_Bradstreet(l.source) 
													and trim(l.vendor_id) = '140700316'	and l.phone	= 7707819312
													and regexfind('CONSUMER SOLUTIONS', l.company_name, nocase)
												;				
				// JIRA: DF-20009 - Remove FEIN 32-0153283 from BDID 004315292869 Carriage House
				filterbugDF20009 := trimids(l.vl_id) in ['12-M17000000132'] 
												and mdr.sourcetools.SourceIsFL_Corporations(l.source)
												and l.fein = 320153283
												;
				
				phone := (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.phone));  // Zero the phone if more than 10-digits
				
				// -- Bug: 63323 - Address report returns error when address begins with percentage sign
				prim_name := if(trim(l.prim_name,left,right)[1] = '%', 'C/O ' + trim(l.prim_name,left,right)[2..], l.prim_name);
				
				self.prim_range 	:= if(filterbug24219,'1001'				,l.prim_range 		);
				self.prim_name		:= if(filterbug24219,'FANNIN'			,prim_name				);
				self.addr_suffix	:= if(filterbug24219,'ST'					,l.addr_suffix		);
				self.unit_desig		:= if(filterbug24219,'STE'				,l.unit_desig			);
				self.sec_range		:= if(filterbug24219,'4000'				,l.sec_range			);
				self.city					:= if(filterbug24219,'HOUSTON'		,l.city						);
				self.state				:= if(filterbug24219,'TX'					,l.state					);
				self.zip					:= if(filterbug24219, 77002				,l.zip						);
				self.zip4					:= if(filterbug24219, 6711				,l.zip4						);
				self.county				:= if(filterbug24219,'201'				,l.county					);
				self.msa					:= if(filterbug24219,'3360'				,l.msa						);
				self.geo_lat			:= if(filterbug24219,'29.756396'	,l.geo_lat				);
				self.geo_long			:= if(filterbug24219,'-095.364044',l.geo_long				);
				self.phone				:= map(	 filterbug24219 => 7135126200
																	,filterbug25304 or filterbug71237 or filter_DF8591 or filter_DF21083 => 0																	
																	,phone				
																);
				self.company_name := scrubcompanyname(l.company_name);
				self.fein					:= if(filterbug42740 or filterbugDF20009,0						,l.fein);
	
				self.vendor_id		:= if(blankbug48348,'',trimids(l.vendor_id));
				self.source_group	:= if(blankbug48348,'',trimids(l.source_group));
				//for bug 30494 & 30519.  20080424
				self.dt_first_seen						:= (unsigned4)validatedate((string8)l.dt_first_seen						,if(length(trim((string8)l.dt_first_seen						)) = 8,0,1));
				self.dt_last_seen							:= (unsigned4)validatedate((string8)l.dt_last_seen						,if(length(trim((string8)l.dt_last_seen							)) = 8,0,1));
				self.dt_vendor_first_reported	:= (unsigned4)validatedate((string8)l.dt_vendor_first_reported,if(length(trim((string8)l.dt_vendor_first_reported	)) = 8,0,1));
				self.dt_vendor_last_reported	:= (unsigned4)validatedate((string8)l.dt_vendor_last_reported	,if(length(trim((string8)l.dt_vendor_last_reported	)) = 8,0,1));
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));
			
		end;
	
		export Business_contacts(
			 dataset(Layout_Business_Contact_Full_new) 	pInput
			,boolean																		pFilterOut = true
		) := 
		function 
			
			boolean lStandardFilter 	:=		
													pInput.company_name																= ''	// Discard Blank Company names
											or	pInput.lname																			= ''	// Discard Contacts with no last name
											or	regexfind('REGISTERED AGENT', pInput.company_title, nocase) // Discard Registered Agents
											or	regexfind('^null$', trim(pInput.company_name), nocase)	//company name must be alphanumeric
											;
											
			boolean lAdditionalFilter	:= 
													(MDR.sourceTools.SourceIsOR_Watercraft(pInput.source) and pInput.vendor_id[1..2] in ['OR']) //Discard Oregon Watercraft records
											or	(
														pInput.did	>= irs_dummy.did_cutoff and 
														pInput.bdid	>= irs_dummy.bdid_cutoff
												)
											// Filter for bug 28289
											or	(
																pInput.lname					= 'VOSS'
														and pInput.fname					= 'HANS-PETER'
														and regexfind('WILD FLAVORS',pInput.company_name,nocase)
														and pInput.company_title	= 'OWNER'
												)
				// Bug 29741 -- Zoom record not correct
			or	(
							MDR.sourceTools.SourceIsZOOM(pInput.source)
					and regexfind('tessco',pInput.company_name,nocase)
					and pInput.fname = 'RAUL'
					and pInput.lname = 'FRAUSTO'
					and (
										pInput.state					= 'MD' 
								or	pInput.company_state = 'MD'
							)
					)
				// -- Bug 37037 - Business Header has garbage data with year value for company_name
				or (regexfind('^(?![^[:alpha:]]*[[:alpha:]]+)[^[:digit:]]*[[:digit:]]+.*$', trim(pInput.company_name,left,right)))
				// Bug: #37728 - Remove MO Vehicles and DLs from business header and contacts			
				or (pInput.vendor_id[1..2] = 'MO' and (
																									 MDR.sourceTools.SourceIsVehicle	(pInput.source) 
																								or MDR.sourceTools.SourceIsDL				(pInput.source) 
																							))
				or (pInput.vendor_id[1..2] = 'A9' and MDR.sourceTools.SourceIsLiens(pInput.source))
				// -- Bug: 47743 - Compliance Issue - Removal of Wolf Toder from Comp Bus Report
				or (pInput.fname = 'WOLF' and pInput.lname = 'TODER' and regexfind('AIRPORT AUTO GROUP',pInput.company_name,nocase))
				// -- Bug: 55936 - IRS 5500 data causing inappropriate overlink
				or	(MDR.sourceTools.SourceIsIRS_5500(pInput.source) and trim(pInput.vendor_id,left,right) = '84037345552793')
				// -- Bug: 89358 - Overlinking of Advance Brands with Remodel USA
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vendor_id,left,right) = '722719402' and (pInput.bdid = 77508945 or not regexfind('remodel',pInput.Company_name,nocase)))
				// -- Bug: 92729 - Overlinking of George Turner as owner of Kirkwood Roofing	
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vendor_id,left,right) = '771728460' and pInput.bdid = 436581784 and trim(pInput.lname,left,right) = 'TURNER' and trim(pInput.fname,left,right) = 'GEORGE')
				// -- Bug: 95843 - Overlinking of Barbara Griffith with Southern California Pipeline
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vl_id,left,right) = '811133084' /*and pInput.bdid in [127094209, 1165497861]*/)
				// -- Bug: 103804 - Questionable Company Names.
				// -- Bug: 145649 - Accurint 52354 - PAW Overlinking of LexID 2715613629 D. Williams
				// -- Bug: 191918/JIRA: DF-14772 - Consumer Privacy Reports Incorrectly Linked PAW Record
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) in ['1542124062','731821740','731821740C20895717','645546729     C352857954'])
				// -- Bug: 107798 - Remove two Business Header records with wrong source codes.
				//or	(MDR.sourceTools.SourceIsAK_Corporations(pInput.source) and pInput.bdid in [4994780, 412358992, 16952458])
				or	(MDR.sourceTools.SourceIsAK_Corporations(pInput.source) and 
						 trim(pInput.company_name,left,right) = 'FRIEDLINE AND ASSOCIATES, INC.' and
						 trim(pInput.lname) = 'FRIEDLINE' and trim(pInput.fname) = 'JOHN' and trim(pInput.mname) = 'J')
				// -- Bug: 98386 - Robert Spencer and Virginia Union University
				//or	(MDR.sourceTools.SourceIsZoom(pInput.source) and pInput.bdid = 3564212 and pInput.did = 2405720103)
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and (pInput.ssn = 246881888 or pInput.phone = 8042575715) and
						 trim(pInput.company_name,left,right) = 'VIRGINIA UNION UNIVERSITY' and
						 trim(pInput.fname,left,right) = 'ROBERT' and trim(pInput.lname,left,right) = 'SPENCER')
				// -- Bug: 107265 - Remove Person Contacts from BDID 2607452175 Asian Massage
				or	(MDR.sourceTools.SourceIsFBNV2_Experian_Direct(pInput.source) and 
						 trim(pInput.vendor_id,left,right) = 'EXP16725274809092212336' and 
						 trim(pInput.fname,left,right) <> 'NIAM' and trim(pInput.lname,left,right) <> 'LIN')
				// -- Bug: 87127 - Overlinking of business contacts due to errorneous CP FBN Filing.
				// -- Bug: 115130 - Unlink DID for Michael Hild from Serenity Home Care Agency
				// -- Bug: 120900 - Remove FBN Record from Business Header & Contacts for Al-Jarafi
				or	(MDR.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vendor_id,left,right) in ['CP9627346981847888151','CP219395185453452160','CP11910987965939266948'])
				// -- Bug: 109269 - Remove 4 Employment Locator records for David Scott Tronson.
				or  (mdr.sourceTools.SourceIsEq_Employer(pInput.source) and pInput.phone = 2534603191)
				// -- Bug: 113227 - Business Header contains errorneous Corporation record.
				or	(MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) = '06-01620279' and trim(pInput.city) = 'CULVER CITY')
				// -- Bug: 105072 - Tina Gutierrez is Overlinked to Rackspace LTD.
				or	((mdr.sourceTools.SourceIsZoom(pInput.source) or mdr.sourceTools.SourceIsJigsaw(pInput.source)) and trim(pInput.vl_id) in ['1474987798','77956-26478788'])
				// -- Bug: 105072 - Tina Gutierrez is Overlinked to Rackspace LTD.
				or  (mdr.sourceTools.SourceIsSpoke(pInput.source) and trim(pInput.vendor_id) = 'TX-3410800962')
				// -- Bug: 110922 - Remove TMSID from Business Header, Contacts and PAW for Steve Dixon
				or	(mdr.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vl_id) = 'CP12011527270763228237')
				// -- Bug: 93269 - J&L linking to incorrect company in business report
				or  (MDR.sourceTools.SourceIsZoom(pInput.source) and pInput.company_source_group = '96813300')
				// -- Bug: 106251 - Overlinking of Business Contacts to Michael McGovern
				or  (trim(pInput.vendor_id) in ['556053650','NYN3386756439','INF214497643'] and 
						 trim(pInput.fname) = 'MICHAEL' and trim(pInput.lname) = 'MCGOVERN' and pInput.dt_first_seen in [20021227,19930108])
				// -- Bug:121240 -Hewlett Packard Bus Search Result on Portal returns D&B Report
				or  ((MDR.sourceTools.SourceIsAZ_Corporations(pInput.source) or MDR.sourceTools.SourceIsUCCV2(pInput.source)) and pInput.company_source_group in ['04-F08167145','DNB000173979719961223'])
				// -- Bug: 125332 - People at Work Suppression
				or  (MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'DELORES' and trim(pInput.lname) = 'PARKER' and trim(pInput.mname)='DIANE' and 
							trim(pInput.company_name) in ['MAPLEHURST REALTY INC','MAPLEHURST'])
				// -- Bug: 119446 - Remove Zoom Records for LexID 1234490932 Tahir Javed 
				or  (MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.company_name) in ['OMAHA WORLD-HERALD COMPANY','OMAHA WORLD-HERALD'] and trim(pInput.fname) = 'TAHIR' and trim(pInput.lname) = 'JAVED')
				// -- Bug: 119049 - Unlink Bradley Leighty from BOA Auto Sales
				or  ((mdr.sourceTools.SourceIsDunn_Bradstreet(pInput.source) or mdr.sourceTools.SourceIsEBR(pInput.source)) and 
							trim(pInput.vendor_id,left,right) in ['D092297238-BOA AUTO SALES INC','738365619'] and trim(pInput.fname) = 'BRADLEY' and trim(pInput.lname) = 'LEIGHTY')
				// -- Bug: 131131 - Business Contact Information for Opt Out Consumer-Rush Request
				or  ( trim(pInput.company_name,left,right) in ['BAKER & MCKENZIE LLP','JACKSON DEV & CONSTRUCTION INC','MEDIA CENTER PC',
																											 'NATIONAL COLLEGE FOR DUI DEFENSE , INC.','OPPENHEIMER WOLFF DONNELLY LLP',
																											 'SOUTH COAST LITIGATION GROUP','THE NATIONAL COLLEGE FOR DUI DEFENSE , INC.','UNIVERSITY OF PENNSYLVANIA'] and trim(pInput.fname) = 'VANIA' and trim(pInput.lname) = 'CHAKER')
				// -- Bug:  - Flush the Jigsaw records as per Jason.
				or	(MDR.sourceTools.SourceIsJigsaw(pInput.source))
				// -- Bug: 139082 - Remove Ana Lane Gomez from FBN, Business Header and PAW files
				or	(MDR.sourceTools.SourceIsFBNV2_Experian_Direct(pInput.source) and trim(pInput.vendor_id) = 'EXP6160690673128140760')
				// -- Bug:146861 - Remove All Business Records Associate with David Peyman
				// -- Bug:153300 - Remove Lexid 113261977728 for Peyman Shalah
				or	(trim(pInput.lname) = 'PEYMAN' and trim(pInput.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'])
				// -- Bug:146862 - These corp keys need to be filtered out of all base files
				or 	(MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) in ['06-03155932', '06-200820510058', '06-200620910099'])
				// -- Bug: 157298  - Remove Contact Angela Farole from BDID 53982819 Avante Abstract Inc.
				or 	(trim(pInput.company_name) in [	'AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and trim(pInput.fname) = 'ANGELA' and trim(pInput.lname) = 'FAROLE' and trim(pInput.mname) in ['','M'])
				// -- Bug:98757 - Experian Business Report Filing Numbers are Overlinking Oregon Companies				
				or 	(MDR.sourceTools.SourceIsEbr(pInput.source) and trim(pInput.vl_id) = '809376459' and (regexfind('HEALTHCARE|HOSPITAL',trim(pInput.company_name,left,right),nocase) or (trim(pInput.lname) = 'MARCHETTI' and trim(pInput.fname) ='MARK')))
				// -- Bug:166661-Consumer Privacy Requesting PAW Record Removal for LexID 2281518533				
				or 	(MDR.sourceTools.SourceIsDCA(pInput.source) and trim(pInput.vendor_id) = '1323416' and trim(pInput.lname) = 'SCHWARTZ' and trim(pInput.fname) ='DAVID' and pInput.phone = 4083742236)
				// -- Bug: Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.company_source_group,left,right) = '74072915' and (pInput.company_phone in [5053440663, 5053451176] or pInput.phone in [5053440663, 5053451176]))
				// -- Bug: 174042 - Remove Business Records for J. Vaziri per Privacy Programs Direction
				or	(trim(pInput.fname,left,right) = 'JENNIFER' and trim(pInput.lname) = 'VAZIRI' and trim(pInput.mname,left,right) in ['H','HOPE'])
				// -- Bug: 176631 - Business Header Suppression 
				// -- Bug: 197656 - Consumer Privacy Reports Incorrectly Linked PAW Record for Clayton
				or	(MDR.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) in ['1671940052    C355405299','1817929485','1817929485    C61984972','1817929485    C35213276'])
				or	(MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'KIMBERLY' and trim(pInput.mname) = 'MICHELLE' and trim(pInput.lname) = 'CLAYTON' and trim(pInput.company_name) = 'GRADY HEALTH')
				// -- Bug: 183422 - Unlink Daniel A Davenport from this father Daniel S 
				or	(trim(pInput.vendor_id) in ['8090947','NYMVO0458830691'] and trim(pInput.lname) = 'DAVENPORT')
				// -- Bug: 194125 - Consumer Dispute 
				or	((trim(pInput.vl_id) in ['214475444','827237547'] or trim(pInput.company_source_group) in ['214475444','827237547']) and trim(pInput.fname) = 'LINDA')
				// -- JIRA:DF-16735 Per Privacy Programs - Remove PETER KIRN records.
				//or	(stringlib.stringfind(pInput.company_name, 'CAMELBACK GROUP', 1) > 0 and ((pInput.state = 'CO' and trim(pInput.city) in ['GREENWOOD VILLAGE','WINTER PARK','TABERNASH']) or pInput.company_phone=3039186563))
				or	(regexfind('CAMELBACK GROUP|PETER KIRN|PETERKIRN',pInput.company_name, nocase) and trim(pInput.fname,left,right) = 'PETER' and trim(pInput.lname,left,right) = 'KIRN' and trim(pInput.mname,left,right) in ['A','ADAMS',''])
				or	(trim(pInput.fname,left,right) = 'PETER' and trim(pInput.lname,left,right) = 'KIRN' and trim(pInput.mname,left,right) in ['A','ADAMS',''] and pInput.state = 'CO')
				// -- Bug: 203666/JIRA: DF-16118 - Remove Accurtrend Record for INSANE HYDROGRAPHIX LLC
				or	(stringlib.stringfind(pInput.company_name, 'INSANE HYDROGRAPHIX', 1) > 0 and trim(pInput.fname) = 'BRYAN' and trim(pInput.lname) = 'MYERS')
				// -- JIRA - DF-16328 Consumer Dispute - record must be suppressed/deleted
				or	(stringlib.stringfind(pInput.company_name, 'NATIONAL IRANIAN AMERICAN', 1) > 0 and trim(pInput.fname) = 'BABAK' and trim(pInput.lname) = 'BAGHERI')
				// -- JIRA - DF-7752, Claude Blanc incorrectly listed as business owner 
				or 	(mdr.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ(pInput.source) and trim(pInput.vl_id) in ['849828736','986042075'])
				// -- JIRA - DF-17422, Consumer Advocacy Complaint - PAW Linking LexID - BDID 43998720 
				or 	(mdr.sourceTools.SourceIsWorkmans_Comp(pInput.source) and regexfind('YELLOW TRANSPORTATION',pInput.company_name, nocase) and STD.Str.CleanSpaces(pInput.fname + pInput.lname) in ['BOBBY PHILLIPS','INC YELLOW'])
				// -- JIRA - DF-17991 Consumer Dispute - record must be suppressed/deleted
				or  (mdr.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id) = '457217847     C6260365')
				// -- JIRA - DF-18128 Consumer Advocacy - Unlink PAW Record for LexID 54872692 Amodeo
				or  (mdr.sourceTools.SourceIsBusiness_Registration(pInput.source) and trim(pInput.company_source_group) = '3422833PATRICK M MCMATH LAW FIRM L' and trim(pInput.fname) = 'JAMES' and trim(pInput.lname) = 'AMODEO' and trim(pInput.mname) = 'E')
				// -- JIRA - DF-18344 Remove Business Contacts and PAW Record for LexID 13957703, Allene A Traphan
				or  (mdr.sourceTools.SourceIsTXBUS(pInput.source) and regexfind('ALLENE A TRAPHAN', pInput.company_name, nocase))
				// -- JIRA - DF-18950 ZOOM records to be suppressed in PAW
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vl_id) = '1684933816')
				// -- JIRA - DF-18955 PAW record to be supressed or deleted
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and pInput.phone = 7173042300 and trim(pInput.fname) = 'LORI' and trim(pInput.lname) = 'RICH')
				// -- JIRA - DF-19021 Consumer Advocacy - Removal of PAW/Business Contacts for Praveen Sengar
				or  (pInput.phone = 5088728200 and trim(pInput.fname) = 'PRAVEEN' and trim(pInput.lname) = 'SENGAR')
				// -- JIRA - DF-19020 Consumer Advocacy - Removal of PAW/Business Contacts for Sappington
				or  (regexfind('LANDGUARD EAGLE', pInput.company_name, nocase) and trim(pInput.vendor_id) in ['DZXWM0058497187','17-LLC-02958317'] and trim(pInput.fname) = 'CASSANDRA' and trim(pInput.lname) = 'SAPPINGTON')
				// -- JIRA - DF-18970 Remove all PAW/Business Contacts for LexID 724864388 at Las Vegas Address
				or  (trim(pInput.fname) = 'PASTORA' and trim(pInput.lname) = 'ROLDAN' and 
						 ((trim(pInput.prim_name) = 'EASTERN' and pInput.zip = 89123) or (trim(pInput.company_prim_name) = 'EASTERN' and pInput.company_zip = 89123)))
				// -- JIRA - DF-18931 Cons. Adv. Report - Business Contacts Removal for LexID 829850667 Andra Flynn
				or  (trim(pInput.fname) = 'ANDREA' and trim(pInput.lname) = 'FLYNN' and regexfind('PC EXPRESS ENTERPRISES', trim(pInput.company_name), nocase))
				// -- JIRA - DF-19165 Consumer Advocacy - Remove PAW/Business Contacts for LexID 1793247875
				or  (mdr.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'BERNARD' and trim(pInput.lname) = 'THEIS' and regexfind('PAINE WEBER|PAYNE WEBER', pInput.company_name, nocase))
				// -- JIRA - DF-19162 Remove PAW and Business Contact Records for LexID 1510111650
				or  (trim(pInput.fname) in ['LEWIS','CHRIS','CHRISTOPHER'] and trim(pInput.lname) in ['LEWIS','RAND'] and trim(pInput.vendor_id) in ['RGXPY0536216046','01B7E3E6DE670600D8','4007701','IBTK 1 F     6X  P'])
				// -- ZOOM vendor_id's will be filtered from Business contacts and PAW files as per bug tickets listed above.
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) in Bad_zoom_vend_ids)
				// -- JIRA - DF-19767 Consumer Adv - Remove PAW record from LexID 2332177997 SICHERMAN
				or  (mdr.sourceTools.sourceIsDCA(pInput.source) and trim(pInput.vendor_id) in ['3205715'] and trim(pInput.lname) = 'SICHERMAN')
				// -- JIRA - DF-19305 Experian Business Report has incorrect Officer Name of Jon C Dawson 
				or  (mdr.sourceTools.sourceIsEBR(pInput.source) and trim(pInput.vendor_id) in ['940772280'] and trim(pInput.lname) = 'DAWSON')
				// -- JIRA - DF-20318 PAW Error for LexID 13959907050 - Consumer Advocacy
				or  (mdr.sourceTools.sourceIsSpoke(pInput.source) and trim(pInput.lname) = 'JOHNSON' and trim(pInput.fname) in ['CHRISTOPHER','CHRIS'] and pInput.phone = 6123046073)
				// -- JIRA - DF-20685 LexID 523271314 - Wrongly Appended PAW records - Consumer Advocacy.
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.fname) = 'MICHAEL' and trim(pInput.lname) = 'COUTR' and trim(pInput.prim_name) = 'MAIN' and pInput.zip = 7503 and regexfind('ST. JOSEPH HEALTH SYSTEM', pInput.company_name, nocase))
				// -- JIRA - DF-20795 - Consumer disputing association with a company
				or  (mdr.sourceTools.sourceIsEq_Employer(pInput.source) and pInput.company_phone = 3192333309)
				// -- JIRA - DF-21961 - Consumer Adv. - PAW/Bus. Contacts Overlinking LexID 184656279
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) = '2108024717    C90883103' and trim(pInput.prim_name) = 'PO BOX 6')
				// -- JIRA - DF-21988 - Consumer Advocacy - Linking Dispute LexID 1533124325 - Mary Lloyd
				or  ((mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) or mdr.sourceTools.sourceIsFBNV2_Hist_Choicepoint(pInput.source)) and trim(pInput.vendor_id) in ['CP3345616258597945683', '76327426'] and trim(pInput.fname) = 'MARY' and trim(pInput.lname) = 'LLOYD')
				// -- JIRA - DF-22790 - Consumer Dispute - PAW record to be removed
				or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and trim(pInput.vl_id) in ['17794919'] and trim(pInput.fname) = 'TINA' and trim(pInput.lname) = 'TOPE')
				// -- JIRA - DF-22882 - consumer has opted out but these records are still in PAW 
				or  ((mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) or mdr.sourceTools.sourceIsIL_Corporations(pInput.source)) and trim(pInput.vendor_id) in ['17-LLC-03428427','22388016','24834066'] and trim(pInput.lname) in ['RICCARDO','BRADLEY'])
				// -- JIRA - DF-23058 - Consumer Dispute - Paw and Bus Header Records to be removed
				or  (trim(pInput.fname) = 'BROCK' and trim(pInput.lname) = 'KORSAN' and trim(pInput.company_source_group) = 'L14000179431JAMES ROBERTS PAINTING')
				// -- JIRA - DF-22874 - Consumer Dispute Paw records and old business header contact records to be removed
				or  ((trim(pInput.company_source_group) in ['25817K-3 INC','42981866JD PROPERTIES'] or pInput.company_phone = 9492510650) and trim(pInput.fname) = 'YANA' and trim(pInput.lname) in ['ROSTOMYAN','ROSTOMIAN'])
				// -- JIRA - DF-22999 - Consumer Dispute has a Paw record to be removed
				or  (trim(pInput.vendor_id) = 'SKAV4337795' and pInput.company_phone = 6196591085 and trim(pInput.lname) = 'SPINO')
				// -- JIRA - DF-23136 - FCRA PAW Linking - LexID 1386265060 Kiefer
				or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and trim(pInput.company_source_group) = '84399STENSENG CONSULTING' and trim(pInput.lname) = 'KIEFER' and trim(pInput.fname) = 'MAX')
				// -- JIRA - DF-22815 - Overlinking
				// -- JIRA - DF-23226 - Please remove linking of business to consumer
				//or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and trim(pInput.vl_id) in ['67521015','53535058'] and pInput.company_phone in [6196544162,9494978859])
				// -- JIRA - DF-22997 - Consumer associated to Businesses that should be removed
				//or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and trim(pInput.vl_id) in ['56910883','33310807','6374820','53185856','64002274'] and trim(pInput.fname) = 'STEPHANIE' and trim(pInput.lname) = 'WATTS')
				// -- JIRA - DF-22342 - PAW data from zoom and spoke incorrectly linked to consumer
				or  (pInput.phone in [3126169600,2122511234,3126162628] and trim(pInput.lname) = 'JOHNSON' and trim(pInput.fname) = 'JEFF' and trim(pInput.prim_range) = '225' and regexfind('CRAMER-KRASSELT', pInput.company_name, nocase))
				// -- JIRA - DF-22787 - Consumer Dispute - PAW record to be removed
				or  (pInput.phone = 3013803000 and trim(pInput.lname) = 'SMITH' and trim(pInput.fname) = 'BRIAN' and trim(pInput.mname) in ['','W'])
				// -- JIRA - DF-22950 - Paw data from zoom incorrectly conntected to consumer				
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and pInput.phone = 5864658018 and trim(pInput.lname) = 'ADAMASZEK' and trim(pInput.fname) = 'EARL' and trim(pInput.mname) = 'PHILIP')
			;

			boolean lFullFilter 		:= if(pFilterOut
																		,not(lStandardFilter or lAdditionalFilter)	//negate it 
																		,(lStandardFilter or lAdditionalFilter)	//negate it 
																	);
			///////////////////////////////////////////////////////////////////
			// -- Bug 25304 -- blank this phone
			// -- Bug 42887 -- blank bad phones
			///////////////////////////////////////////////////////////////////
			Layout_Business_Contact_Full_new tblankoutphone(Layout_Business_Contact_Full_new l) :=
			transform
				
				filterbug71237 :=			regexfind('DEL TACO',l.company_name,nocase)
													and (			l.phone					= 5619994400
																or	l.company_phone = 5619994400
															)
												;

				filterbug25304 :=		l.company_name	= 'CITIGROUP'
												;

				// -- Bug 37562 - Remove a Title of "Owner" in Business Header Contacts Record
				filterbug37562 := (		l.bdid					= 96625718 
													and l.lname					= 'HENDERSON'
													and l.fname					= 'CURT'
													and l.company_title = 'OWNER'
				);
				// Bug: 42740 - Business FEIN #'s transposed
				filterbug42740 :=		regexfind('ELDORADO MANAGEMENT',l.company_name,nocase) 
												and l.company_fein	= 430915544 
												;
				// Bug: 48348 - DNB, Duns# 364405423 is linking two unrelated businesses
				blankbug48348 := trimids(l.vendor_id) = '364405423' 
												and mdr.sourcetools.SourceIsDunn_Bradstreet(l.source)
												and trim(l.company_name) = 'EAST LOS ANGELES BAKERY, INC.'
												;
				// JIRA: DF-20009 - Remove FEIN 32-0153283 from BDID 004315292869 Carriage House
				filterbugDF20009 := trimids(l.vl_id) in ['12-M17000000132'] 
												and mdr.sourcetools.SourceIsFL_Corporations(l.source)
												and l.company_fein = 320153283
												;
				// JIRA - DF-21083 PAW Error for LexID 947738531, Heagerty - Consumer Advocacy 
				filter_DF21083 :=	mdr.sourcetools.SourceIsDunn_Bradstreet(l.source) 
													and trim(l.vendor_id) = '140700316'	and (l.phone	= 7707819312 or l.company_phone = 7707819312)
													and regexfind('CONSUMER SOLUTIONS', l.company_name, nocase)
												;

				phone 				:= (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.phone));  // Zero the phone if more than 10-digits
				company_phone := (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.company_phone));  // Zero the companyphone if more than 10-digits
				
				self.phone					:= map(	 (filterbug25304 and l.phone = 2127938763)				
																		or filterbug71237 or filter_DF21083 => 0					
																	,phone				
																);
				self.company_phone	:= map(	 (filterbug25304 and l.company_phone = 2127938763)
																		or filterbug71237 or filter_DF21083 => 0					
																	,company_phone				
																);
				// -- Bug: 63323 - Address report returns error when address begins with percentage sign
				prim_name					:= if(trim(l.prim_name				,left,right)[1] = '%', 'C/O ' + trim(l.prim_name				,left,right)[2..], l.prim_name				);
				company_prim_name := if(trim(l.company_prim_name,left,right)[1] = '%', 'C/O ' + trim(l.company_prim_name,left,right)[2..], l.company_prim_name);

				self.prim_name					:= prim_name				;
				self.company_prim_name	:= company_prim_name;
				self.company_name := scrubcompanyname(l.company_name);
				self.company_fein	:= if(filterbug42740 or filterbugDF20009,0						,l.company_fein);
				self.vendor_id		:= if(blankbug48348,'',trimids(l.vendor_id));
				self.company_source_group	:= trimids(l.company_source_group);
				self.dt_first_seen						:= (unsigned4)validatedate((string8)l.dt_first_seen						,if(length(trim((string8)l.dt_first_seen						)) = 8,0,1));
				self.dt_last_seen							:= (unsigned4)validatedate((string8)l.dt_last_seen						,if(length(trim((string8)l.dt_last_seen							)) = 8,0,1));
				//Bug 30987 -- remove site powered by                                                 
				self.company_title := map( stringlib.stringtolowercase(l.company_title) = 'site powered by:'	=> ''
																	,filterbug37562																											=> '' 
																	,l.company_title
															);
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));
		
		end;

	end;
	
	
	export Bases :=
	module
		
		export Business_Headers(

			 dataset(Layout_Business_Header_Base) pInput
			,boolean															pFilterOut = true

		) :=
		function
			
			boolean lStandardFilter 	:=	
				///////////////////////////////////////////////////////////////////
				// -- Corporations with Blank addresses
				///////////////////////////////////////////////////////////////////
				//*** JIRA: DF-17629 PAW - Corp records changing the dt_first_seens to more recent date then before. 
				//*** Removing the below code so the date_first/last_seens dates would retain the oldest dates in the 
				//*** event of flush-n-fills of corp states at source builds
			  //	(		MDR.sourceTools.SourceIsCorpV2(pInput.source)
				// and	trim(pInput.prim_name)	= 	''
				// and	pInput.zip				= 	0
				//)
			
				///////////////////////////////////////////////////////////////////
				// -- Corporations records with certain bad names
				///////////////////////////////////////////////////////////////////
				(		pInput.company_name		in [ 'X'
													,'SAME'
													,'NATIONAL REGISTERED AGENTS, INC.'
													,'NATIONAL REGISTERED AGENTS'
												   ]
				)
				///////////////////////////////////////////////////////////////////
				// -- IRS Dummy records
				///////////////////////////////////////////////////////////////////
			or  (		pInput.bdid	>= irs_dummy.bdid_cutoff
				)
			or	regexfind('^null$', trim(pInput.company_name), nocase)	//company name must be alphanumeric
				; 
			
			boolean lAdditionalFilter	:= 
				///////////////////////////////////////////////////////////////////
				// -- Oregon Watercraft records
				///////////////////////////////////////////////////////////////////
				(			MDR.sourceTools.SourceIsWC(pInput.source)
				 and	pInput.vendor_id[1..2]	=	'OR'
				)
				///////////////////////////////////////////////////////////////////
				// -- Bug 29741 -- Zoom record not correct, filter out
				///////////////////////////////////////////////////////////////////
				or (
							pInput.bdid				= 12317
					and	MDR.sourceTools.SourceIsZOOM(pInput.source)
					and pInput.vendor_id 	= '382516491'
					and pInput.phone 			= 2256739233
				)
				///////////////////////////////////////////////////////////////////
				// -- Bug 31760 -- filter OH liquor licenses 20080515 from business headers  
				///////////////////////////////////////////////////////////////////
				or (
							MDR.sourceTools.SourceIsOH_Liquor_Licenses(pInput.source)
					and pInput.dt_vendor_first_reported 	= 20080515
				)
				///////////////////////////////////////////////////////////////////
				// -- Bug 37034 - Bad Ska records 
				///////////////////////////////////////////////////////////////////
				or (
							MDR.sourceTools.SourceIsSKA(pInput.source)
					and pInput.dt_first_seen 	= 20090203
				)
				// -- Bug 37037 - Business Header has garbage data with year value for company_name
				or (regexfind('^(?![^[:alpha:]]*[[:alpha:]]+)[^[:digit:]]*[[:digit:]]+.*$', trim(pInput.company_name,left,right)))
				or (pInput.vendor_id[1..2] = 'A9' and MDR.sourceTools.SourceIsLiens(pInput.source))	 //LiensV2 Dummy Records
				// -- Bug: 55936 - IRS 5500 data causing inappropriate overlink
				or	(MDR.sourceTools.SourceIsIRS_5500(pInput.source) and trim(pInput.vendor_id,left,right) = '84037345552793')
				// -- Bug: 89358 - Overlinking of Advance Brands with Remodel USA
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vendor_id,left,right) = '722719402' and (pInput.bdid = 77508945 or not regexfind('remodel',pInput.Company_name,nocase)))
				// -- Bug: 95843 - Overlinking of Barbara Griffith with Southern California Pipeline
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vl_id,left,right) = '811133084' /*and pInput.bdid in [127094209, 1165497861]*/)
				// -- Bug: 103804 - Questionable Company Names.
				// -- Bug: 145649 - Accurint 52354 - PAW Overlinking of LexID 2715613629 D. Williams
				// -- Bug: 191918/JIRA: DF-14772 - Consumer Privacy Reports Incorrectly Linked PAW Record
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) in ['1542124062','731821740','731821740C20895717','645546729     C352857954'])				
				// -- Bug: 107798 - Remove two Business Header records with wrong source codes.
				or	(MDR.sourceTools.SourceIsAK_Corporations(pInput.source) and pInput.bdid in [4994780, 412358992, 16952458])
				// -- Bug: 87127 - Overlinking of business contacts due to errorneous CP FBN Filing.
				or	(MDR.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vendor_id,left,right) = 'CP9627346981847888151')
				// -- Bug: 113227 - Business Header contains errorneous Corporation record.
				or	(MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) = '06-01620279' and trim(pInput.city) = 'CULVER CITY')
				// -- Bug: 93269 - J&L linking to incorrect company in business report
				or  (MDR.sourceTools.SourceIsZoom(pInput.source) and pInput.source_group = '96813300')
				// -- Bug:121240 -Hewlett Packard Bus Search Result on Portal returns D&B Report
				or  ((MDR.sourceTools.SourceIsAZ_Corporations(pInput.source) or MDR.sourceTools.SourceIsUCCV2(pInput.source)) and pInput.source_group in ['04-F08167145','DNB000173979719961223'])
				// -- Bug:  - Flush the Jigsaw records as per Jason.
				or	(MDR.sourceTools.SourceIsJigsaw(pInput.source))
				// -- Bug # 146862 - These corp keys need to be filtered out of all base files
				or	(MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) in ['06-03155932', '06-200820510058', '06-200620910099'])
				// -- Bug: 162276  - API ESP: BusinessSearch returns hex characters as the Company Name
				or	(MDR.sourceTools.SourceIsYellow_Pages(pInput.source) and ~regexfind(' ',trim(pInput.company_name,left,right),nocase) and trim(pInput.prim_name) = 'MARIETTA' and pInput.dt_last_seen in [20131104,20131105,20131108,20131111,20131113,20131114,20131118,20131119,20140324])
				// -- Bug:98757 - Experian Business Report Filing Numbers are Overlinking Oregon Companies
				or	(MDR.sourceTools.SourceIsEbr(pInput.source) and trim(pInput.source_group,left,right) = '809376459' and regexfind('HEALTHCARE|HOSPITAL',trim(pInput.company_name,left,right),nocase))
				// -- Bug: 174042 - Remove Business Records for J. Vaziri per Privacy Programs Direction
				or	(MDR.sourceTools.SourceIsUCCS(pInput.source) and trim(pInput.vendor_id,left,right) = 'UT28041200122' and trim(pInput.company_name) = 'JENNIFER VAZIRI')
				or  (pInput.bdid in [127231255, 615805461, 1132464520, 3298931063])
				// -- Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vl_id,left,right) = '74072915' and pInput.phone in [5053440663, 5053451176])
				// -- Flush-N-Fill of Louisiana and Hawaii Corps as per Julie Franzer, Bug: 
				//or	(MDR.sourceTools.SourceIsLA_Corporations(pInput.source))
				//or	(MDR.sourceTools.SourceIsHI_Corporations(pInput.source))
				// -- Bug: 182220 - Record (BDID) Suppression
				or	(pInput.bdid = 1943474549)
				// -- JIRA:DF-16735 Per Privacy Programs - Remove PETER KIRN records.
				or	(regexfind('CAMELBACK GROUP|PETER KIRN|PETERKIRN', pInput.company_name, nocase) and ((pInput.state = 'CO' and trim(pInput.city) in ['GREENWOOD VILLAGE','WINTER PARK','TABERNASH']) or pInput.phone in [3039186563,8702926547]))
				or	(regexfind('PETER KIRN|PETERKIRN', pInput.company_name, nocase))
				// -- Bug:190608 - Flush-n-fill PA Corporations as per Julie.
				//or	(MDR.sourceTools.SourceIsPA_Corporations(pInput.source))
				// -- Bug:198128/202786 - Flush-n-fill Vickers.
				//or	(MDR.sourceTools.SourceIsVickers(pInput.source))
				// -- Jira DF-18364 - Business Header - Flush-n-fill Gong Neustar business records due to bad Source_group
				//or	(MDR.sourceTools.sourceIsGong_Business(pInput.source) and pInput.source_group[1..4] = 'NEU-')
				// -- JIRA# DF-22524 - Business Header/PAW - Bad PA Corps addresses 
				// -- JIRA# DF-22502 - PA Corps contact addresses are skewed
				//or (MDR.sourceTools.sourceIsPA_Corporations(pInput.source) and pInput.dt_last_seen = 20180521)
				// -- JIRA# DF-23181 - FCRA dispute Connection to Business in PAW
				or (MDR.sourceTools.sourceIsMA_Corporations(pInput.source) and trim(pInput.vendor_id) = '25-FW1GV5')
				;

			boolean lFullFilter 		:= if(pFilterOut
																		,not(lStandardFilter or lAdditionalFilter)	//negate it
																		,(lStandardFilter or lAdditionalFilter)
																	);
			
			///////////////////////////////////////////////////////////////////
			// -- Bug 24219 -- Remove this phone
			// -- bUG 25304 -- blank this phone
			// -- Bug 42887 -- blank bad phones
			///////////////////////////////////////////////////////////////////
			Layout_Business_Header_Base tblankoutphone(Layout_Business_Header_Base l) :=
			transform
				// JIRA - DF-20838 Incorrect Date Last Seen in FL FBN Record in old Business Header BDID 48554866
				// One time THOR PATCH Code, had to Remove this code after the next build run.
				str_dt_first_seen 				:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(string8)l.dt_first_seen,'');
				str_dt_last_seen 					:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(string8)l.dt_last_seen,'');
				str_dt_first_reported 		:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(string8)l.dt_vendor_first_reported,'');
				str_dt_last_reported 			:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(string8)l.dt_vendor_last_reported,'');
				temp_dt_first_seen				:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source), str_dt_first_seen[1..4] + str_dt_first_seen[7..8] + str_dt_first_seen[5..6],'');
				temp_dt_last_seen					:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source), str_dt_last_seen[1..4] + str_dt_last_seen[7..8] + str_dt_last_seen[5..6],'');
				temp_dt_first_reported		:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source), str_dt_first_reported[1..4] + str_dt_first_reported[7..8] + str_dt_first_reported[5..6],'');
				temp_dt_last_reported			:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source), str_dt_last_reported[1..4] + str_dt_last_reported[7..8] + str_dt_last_reported[5..6],'');
							
				filterbug24219 :=		(l.bdid				= 942461905
												or	l.company_name	= 'WASTE MANAGEMENT') 
												and l.prim_range	= '6521' 
												and l.prim_name 	= 'VANDERBILT'
												and l.zip 				= 77005
												;
				
				filterbug71237 :=			l.bdid	= 128805790
													and l.phone	= 5619994400
												;

				filterbug25304 :=		l.bdid				= 278065382 
												and l.phone				= 2127938763
												;
				
				// Bug: 48348 - DNB, Duns# 364405423 is linking two unrelated businesses
				blankbug48348 := trimids(l.vendor_id) = '364405423' 
												and mdr.sourcetools.SourceIsDunn_Bradstreet(l.source)
												and trimids(l.source_group) = '364405423'
												and trim(l.company_name) = 'EAST LOS ANGELES BAKERY, INC.'
												;
				
				// Bug: 42740 - Business FEIN #'s transposed
				filterbug42740 :=	(	regexfind('ELDORADO MANAGEMENT',l.company_name,nocase) 
															or	l.bdid					= 340568450
														)
												and l.fein					= 430915544 
												;
												
				// JIRA: DF-20009 - Remove FEIN 32-0153283 from BDID 004315292869 Carriage House
				filterbugDF20009 := trimids(l.vl_id) in ['12-M17000000132'] 
												and mdr.sourcetools.SourceIsFL_Corporations(l.source)
												and l.fein = 320153283
												;
				
				// JIRA - DF-8591 Cell Phone reassigned to Irene Pappas 
				filter_DF8591 :=		trim(l.vendor_id) = '714726209'	and l.phone	= 2673125159 ;
				
				// JIRA - DF-21083 PAW Error for LexID 947738531, Heagerty - Consumer Advocacy 
				filter_DF21083 :=	mdr.sourcetools.SourceIsDunn_Bradstreet(l.source) 
													and trim(l.vendor_id) = '140700316'	and l.phone	= 7707819312
													and regexfind('CONSUMER SOLUTIONS', l.company_name, nocase)
												;	

				phone := (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.phone));  // Zero the phone if more than 10-digits
				// -- Bug: 63323 - Address report returns error when address begins with percentage sign
				prim_name					:= if(trim(l.prim_name				,left,right)[1] = '%', 'C/O ' + trim(l.prim_name				,left,right)[2..], l.prim_name				);
				
				self.prim_range 	:= if(filterbug24219,'1001'				,l.prim_range 		);
				self.prim_name		:= if(filterbug24219,'FANNIN'			,prim_name				);
				self.addr_suffix	:= if(filterbug24219,'ST'					,l.addr_suffix		);
				self.unit_desig		:= if(filterbug24219,'STE'				,l.unit_desig			);
				self.sec_range		:= if(filterbug24219,'4000'				,l.sec_range			);
				self.city					:= if(filterbug24219,'HOUSTON'		,l.city						);
				self.state				:= if(filterbug24219,'TX'					,l.state					);
				self.zip					:= if(filterbug24219, 77002				,l.zip						);
				self.zip4					:= if(filterbug24219, 6711				,l.zip4						);
				self.county				:= if(filterbug24219,'201'				,l.county					);
				self.msa					:= if(filterbug24219,'3360'				,l.msa						);
				self.geo_lat			:= if(filterbug24219,'29.756396'	,l.geo_lat				);
				self.geo_long			:= if(filterbug24219,'-095.364044',l.geo_long				);
				self.phone				:= map(	 filterbug24219 => 7135126200
																	,filterbug25304 or filterbug71237 or filter_DF8591 or filter_DF21083 => 0					
																	,phone				
																);
				self.company_name := scrubcompanyname(l.company_name);
				self.fein					:= if(filterbug42740 or filterbugDF20009,0						,l.fein						);
				self.vendor_id		:= if(blankbug48348,'',trimids(l.vendor_id));
				self.source_group	:= if(blankbug48348,'',trimids(l.source_group));
				//for bug 30494 & 30519.  20080424
				// JIRA - DF-20838 Incorrect Date Last Seen in FL FBN Record in old Business Header BDID 48554866
				// One time THOR PATCH Code, had to Remove this code after the next build run.
				self.dt_first_seen						:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(unsigned4)temp_dt_first_seen,(unsigned4)validatedate((string8)l.dt_first_seen								,if(length(trim((string8)l.dt_first_seen						)) = 8,0,1)));
				self.dt_last_seen							:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(unsigned4)temp_dt_last_seen,(unsigned4)validatedate((string8)l.dt_last_seen									,if(length(trim((string8)l.dt_last_seen							)) = 8,0,1)));
				self.dt_vendor_first_reported	:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(unsigned4)temp_dt_first_reported,(unsigned4)validatedate((string8)l.dt_vendor_first_reported	,if(length(trim((string8)l.dt_vendor_first_reported	)) = 8,0,1)));
				self.dt_vendor_last_reported	:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(unsigned4)temp_dt_last_reported,(unsigned4)validatedate((string8)l.dt_vendor_last_reported		,if(length(trim((string8)l.dt_vendor_last_reported	)) = 8,0,1)));
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));

		end;
		
		export Business_Contacts(
			 dataset(Layout_Business_Contact_Full_new)	pInput
			,boolean																pFilterOut = true
		) :=
		function

			boolean lStandardFilter 	:=
				pInput.from_hdr <> 'N'
				///////////////////////////////////////////////////////////////////
				// -- Corporations with Blank addresses
				///////////////////////////////////////////////////////////////////
				//***JIRA: DF-17629 PAW - Corp records changing the dt_first_seens to more recent date then before. 
				//*** Removing the below code so the date_first/last_seens dates would retain the oldest dates in the 
				//*** event of flush-n-fills of corp states at source builds
				//or (		MDR.sourceTools.SourceIsCorpV2(pInput.source)
				// and	trim(pInput.company_prim_name)	= 	''
				// and	pInput.company_zip				= 	0
				//)
		
				///////////////////////////////////////////////////////////////////
				// -- Corporations records with certain bad names
				///////////////////////////////////////////////////////////////////
			or	(		pInput.company_name				in [ 'X'
															,'SAME'
															,'NATIONAL REGISTERED AGENTS, INC.'
															,'NATIONAL REGISTERED AGENTS'
															]
				)
			or	(
						pInput.did	>= irs_dummy.did_cutoff and 
						pInput.bdid	>= irs_dummy.bdid_cutoff
				)
			or	regexfind('REGISTERED AGENT', pInput.company_title, nocase) // Discard Registered Agents
			or	regexfind('^null$', trim(pInput.company_name), nocase)	//company name must be alphanumeric
				;

			boolean lAdditionalFilter	:= 
				///////////////////////////////////////////////////////////////////
				// -- Bug 23466
				///////////////////////////////////////////////////////////////////
				(		MDR.sourceTools.SourceIsWC			(pInput.source)
				or	MDR.sourceTools.SourceIsVehicle	(pInput.source)
				or	MDR.sourceTools.SourceIsUCCS		(pInput.source)
				)
			or	//Filter this guy for bug #20377
				(			pInput.bdid 					= 60667000
				 and	pInput.did						= 1830088723
				 and	pInput.ssn						= 379607091
				)
				//filter this senator
			or
				(			pInput.did						= 1363114130
				 and	pInput.bdid						= 14733991
				)
				// Filter for bug 28289
			or	(
								pInput.lname					= 'VOSS'
						and pInput.fname					= 'HANS-PETER'
						and regexfind('WILD FLAVORS',pInput.company_name,nocase)
						and pInput.company_title	= 'OWNER'
				)
				// Bug 29741 -- Zoom record not correct
			or	(
							MDR.sourceTools.SourceIsZoom(pInput.source)
					and regexfind('tessco',pInput.company_name,nocase)
					and pInput.fname = 'RAUL'
					and pInput.lname = 'FRAUSTO'
					and (
										pInput.state					= 'MD' 
								or	pInput.company_state = 'MD'
							)
					)
				// Bug 33071 -- P@W search has many first names misparsed 
			or	(
							regexfind('^chief (executive|financial) o$',trim(pInput.company_title,left,right), nocase)
					)
				// Bug 34331 - Yellow Pages data has misparsed names in company_title field
				// can just remove them because the yellow pages data is fixed.
			or regexfind('^MICHAE$', trim(pInput.company_title,left,right), nocase)
				///////////////////////////////////////////////////////////////////
				// -- Bug 37034 - Bad Ska records 
				///////////////////////////////////////////////////////////////////
				or (
							MDR.sourceTools.SourceIsSKA(pInput.source)
					and pInput.dt_first_seen 	= 20090207
				)
				// -- Bug 37037 - Business Header has garbage data with year value for company_name
				or (regexfind('^(?![^[:alpha:]]*[[:alpha:]]+)[^[:digit:]]*[[:digit:]]+.*$', trim(pInput.company_name,left,right)))
				or (pInput.vendor_id[1..2] = 'A9' and MDR.sourceTools.SourceIsLiens(pInput.source))	 //LiensV2 Dummy Records
				// -- Bug: 47743 - Compliance Issue - Removal of Wolf Toder from Comp Bus Report
				or (pInput.bdid = 3809261 and pInput.fname = 'WOLF' and pInput.lname = 'TODER')
				// -- Bug: 55936 - IRS 5500 data causing inappropriate overlink
				or	(MDR.sourceTools.SourceIsIRS_5500(pInput.source) and trim(pInput.vendor_id,left,right) = '84037345552793')
				//Bug: 84168 - Two CA Businesses Being Overlinked
			or
				(			pInput.did						= 1288856306
				 and	pInput.bdid						= 671877838
				)
				// -- Bug: 89358 - Overlinking of Advance Brands with Remodel USA
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vendor_id,left,right) = '722719402' and (pInput.bdid = 77508945 or not regexfind('remodel',pInput.Company_name,nocase)))
				// -- Bug: 91010 - Overlinking of Habiba Nosheen to ICLA DA SILVA FOUNDATION INC, bdid 359274488
				or  (MDR.sourcetools.sourceisZoom(pInput.source) and pInput.did = 141258172160 and pInput.ssn = 143190377 and pInput.bdid = 359274488)
				// -- Bug: 92729 - Overlinking of George Turner as owner of Kirkwood Roofing	
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vendor_id,left,right) = '771728460' and pInput.bdid = 436581784 and pInput.did = 2570172107)
				// -- Bug: 95843 - Overlinking of Barbara Griffith with Southern California Pipeline
				or	(MDR.sourceTools.SourceIsEBR(pInput.source) and trim(pInput.vl_id,left,right) = '811133084' /*and pInput.did = 1000628853*/)
				// -- Bug: 103804 - Questionable Company Names.
				// -- Bug: 145649 - Accurint 52354 - PAW Overlinking of LexID 2715613629 D. Williams
				// -- Bug: 191918/JIRA: DF-14772 - Consumer Privacy Reports Incorrectly Linked PAW Record
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) in ['1542124062','731821740','731821740C20895717','645546729     C352857954'])
				// -- Bug: 107798 - Remove two Business Header records with wrong source codes.
				or	(MDR.sourceTools.SourceIsAK_Corporations(pInput.source) and pInput.bdid in [4994780, 412358992, 16952458])
				// -- Bug: 98386 - Robert Spencer and Virginia Union University
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and pInput.bdid = 3564212 and pInput.did = 2405720103)
				// -- Bug: 107265 - Remove Person Contacts from BDID 2607452175 Asian Massage
				or	(MDR.sourceTools.SourceIsFBNV2_Experian_Direct(pInput.source) and 
						 trim(pInput.vendor_id,left,right) = 'EXP16725274809092212336' and 
						 trim(pInput.fname,left,right) <> 'NIAM' and trim(pInput.lname,left,right) <> 'LIN')
				// -- Bug: 87127 - Overlinking of business contacts due to errorneous CP FBN Filing.
				// -- Bug: 115130 - Unlink DID for Michael Hild from Serenity Home Care Agency
				// -- Bug: 120900 - Remove FBN Record from Business Header & Contacts for Al-Jarafi
				or	(MDR.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vendor_id,left,right) in ['CP9627346981847888151','CP219395185453452160','CP11910987965939266948'])
				// -- Bug: 109269 - Remove 4 Employment Locator records for David Scott Tronson.
				or  (mdr.sourceTools.SourceIsEq_Employer(pInput.source) and pInput.phone = 2534603191)
				// -- Bug: 113227 - Business Header contains errorneous Corporation record.
				or	(MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) = '06-01620279' and trim(pInput.city) = 'CULVER CITY')
				// -- Bug: 105072 - Tina Gutierrez is Overlinked to Rackspace LTD.
				or	((mdr.sourceTools.SourceIsZoom(pInput.source) or mdr.sourceTools.SourceIsJigsaw(pInput.source)) and trim(pInput.vl_id) in ['1474987798','77956-26478788'])
				// -- Bug: 105072 - Tina Gutierrez is Overlinked to Rackspace LTD.
				or  (mdr.sourceTools.SourceIsSpoke(pInput.source) and trim(pInput.vendor_id) = 'TX-3410800962')
				// -- Bug: 110922 - Remove TMSID from Business Header, Contacts and PAW for Steve Dixon
				or	(mdr.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vl_id) = 'CP12011527270763228237')
				// -- Bug: 93269 - J&L linking to incorrect company in business report
				or  (MDR.sourceTools.SourceIsZoom(pInput.source) and pInput.company_source_group = '96813300')
				// -- Bug: 106251 - Overlinking of Business Contacts to Michael McGovern
				or  (pInput.bdid in [3596011, 558650599] and pInput.did = 1671671138)
				// -- Bug:121240 -Hewlett Packard Bus Search Result on Portal returns D&B Report
				or  ((MDR.sourceTools.SourceIsAZ_Corporations(pInput.source) or MDR.sourceTools.SourceIsUCCV2(pInput.source)) and pInput.company_source_group in ['04-F08167145','DNB000173979719961223'])
				// -- Bug: 125332 - People at Work Suppression
				or  (MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'DELORES' and trim(pInput.lname) = 'PARKER' and trim(pInput.mname)='DIANE' and 
							trim(pInput.company_name) in ['MAPLEHURST REALTY INC','MAPLEHURST'])
				// -- Bug: 119446 - Remove Zoom Records for LexID 1234490932 Tahir Javed 
				or  (MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.company_name) in ['OMAHA WORLD-HERALD COMPANY','OMAHA WORLD-HERALD'] and trim(pInput.fname) = 'TAHIR' and trim(pInput.lname) = 'JAVED')
				// -- Bug: 119049 - Unlink Bradley Leighty from BOA Auto Sales
				or  ((mdr.sourceTools.SourceIsDunn_Bradstreet(pInput.source) or mdr.sourceTools.SourceIsEBR(pInput.source)) and 
							trim(pInput.vendor_id,left,right) in ['D092297238-BOA AUTO SALES INC','738365619'] and trim(pInput.fname) = 'BRADLEY' and trim(pInput.lname) = 'LEIGHTY')
				// -- Bug: 131131 - Business Contact Information for Opt Out Consumer-Rush Request
				or  ( trim(pInput.company_name,left,right) in ['BAKER & MCKENZIE LLP','JACKSON DEV & CONSTRUCTION INC','MEDIA CENTER PC',
																											 'NATIONAL COLLEGE FOR DUI DEFENSE , INC.','OPPENHEIMER WOLFF DONNELLY LLP',
																											 'SOUTH COAST LITIGATION GROUP','THE NATIONAL COLLEGE FOR DUI DEFENSE , INC.','UNIVERSITY OF PENNSYLVANIA'] and trim(pInput.fname) = 'VANIA' and trim(pInput.lname) = 'CHAKER')
				// -- Bug:  - Flush the Jigsaw records as per Jason.
				or	(MDR.sourceTools.SourceIsJigsaw(pInput.source))
				// -- Bug: 139082 - Remove Ana Lane Gomez from FBN, Business Header and PAW files
				or	(MDR.sourceTools.SourceIsFBNV2_Experian_Direct(pInput.source) and trim(pInput.vendor_id) = 'EXP6160690673128140760')
				// -- Bug:146861 - Remove All Business Records Associate with David Peyman
				// -- Bug:153300 - Remove Lexid 113261977728 for Peyman Shalah
				or	(trim(pInput.lname) = 'PEYMAN' and trim(pInput.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'])
				// -- Bug:146862 - These corp keys need to be filtered out of all base files
				or	(MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) in ['06-03155932', '06-200820510058', '06-200620910099'])
				// -- Bug: 157298  - Remove Contact Angela Farole from BDID 53982819 Avante Abstract Inc.
				or 	(trim(pInput.company_name) in [	'AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and trim(pInput.fname) = 'ANGELA' and trim(pInput.lname) = 'FAROLE' and trim(pInput.mname) in ['','M'])
				// -- Bug:98757 - Experian Business Report Filing Numbers are Overlinking Oregon Companies				
				or 	(MDR.sourceTools.SourceIsEbr(pInput.source) and trim(pInput.vl_id) = '809376459' and (regexfind('HEALTHCARE|HOSPITAL',trim(pInput.company_name,left,right),nocase) or (trim(pInput.lname) = 'MARCHETTI' and trim(pInput.fname) ='MARK')))
				// -- Bug:166661-Consumer Privacy Requesting PAW Record Removal for LexID 2281518533				
				or 	(MDR.sourceTools.SourceIsDCA(pInput.source) and trim(pInput.vendor_id) = '1323416' and trim(pInput.lname) = 'SCHWARTZ' and trim(pInput.fname) ='DAVID' and pInput.phone = 4083742236)
				// -- Bug: Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.company_source_group,left,right) = '74072915' and (pInput.company_phone in [5053440663, 5053451176] or pInput.phone in [5053440663, 5053451176]))
				// -- Bug: 174042 - Remove Business Records for J. Vaziri per Privacy Programs Direction
				or	(pInput.did = 2603985162 or (trim(pInput.fname,left,right) = 'JENNIFER' and trim(pInput.lname) = 'VAZIRI' and trim(pInput.mname,left,right) in ['H','HOPE']))
				// -- Bug: 176631 - Business Header Suppression
				// -- Bug: 197656 - Consumer Privacy Reports Incorrectly Linked PAW Record for Clayton
				or	(MDR.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) in ['1671940052    C355405299','1817929485','1817929485    C61984972','1817929485    C35213276'])
				or	(MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'KIMBERLY' and trim(pInput.mname) = 'MICHELLE' and trim(pInput.lname) = 'CLAYTON' and trim(pInput.company_name) = 'GRADY HEALTH')
				// -- Bug: 183422 - Unlink Daniel A Davenport from this father Daniel S 
				or	(trim(pInput.vendor_id) in ['8090947','NYMVO0458830691'] and trim(pInput.lname) = 'DAVENPORT')
				// -- Flush-N-Fill of Louisiana and Hawaii Corps as per Julie Franzer Bug: 
				//or	(MDR.sourceTools.SourceIsLA_Corporations(pInput.source))			
				//or	(MDR.sourceTools.SourceIsHI_Corporations(pInput.source))
				// -- Bug: 182220 - Record (BDID) Suppression
				or	(pInput.bdid = 1943474549)
				// -- Bug: 194125 - Consumer Dispute 
				or	((trim(pInput.vl_id) in ['214475444','827237547'] or trim(pInput.company_source_group) in ['214475444','827237547']) and trim(pInput.fname) = 'LINDA')
				// -- JIRA:DF-16735 Per Privacy Programs - Remove PETER KIRN records.
				//or	(stringlib.stringfind(pInput.company_name, 'CAMELBACK GROUP', 1) > 0 and ((pInput.state = 'CO' and trim(pInput.city) in ['GREENWOOD VILLAGE','WINTER PARK','TABERNASH']) or pInput.company_phone=3039186563))
				or	(regexfind('CAMELBACK GROUP|PETER KIRN|PETERKIRN',pInput.company_name, nocase) and trim(pInput.fname,left,right) = 'PETER' and trim(pInput.lname,left,right) = 'KIRN' and trim(pInput.mname,left,right) in ['A','ADAMS',''])
				or	(trim(pInput.fname,left,right) = 'PETER' and trim(pInput.lname,left,right) = 'KIRN' and trim(pInput.mname,left,right) in ['A','ADAMS',''] and pInput.state = 'CO')
				// -- Bug:190608 - Flush-n-fill PA Corporations as per Julie.
				//or	(MDR.sourceTools.SourceIsPA_Corporations(pInput.source))
				// -- Bug:198128/202786 - Flush-n-fill Vickers.
				//or	(MDR.sourceTools.SourceIsVickers(pInput.source))
				// -- Bug: 203666/JIRA: DF-16118 - Remove Accurtrend Record for INSANE HYDROGRAPHIX LLC
				or	(stringlib.stringfind(pInput.company_name, 'INSANE HYDROGRAPHIX', 1) > 0 and trim(pInput.fname) = 'BRYAN' and trim(pInput.lname) = 'MYERS')
				// -- JIRA - DF-16328 Consumer Dispute - record must be suppressed/deleted
				or	(stringlib.stringfind(pInput.company_name, 'NATIONAL IRANIAN AMERICAN', 1) > 0 and trim(pInput.fname) = 'BABAK' and trim(pInput.lname) = 'BAGHERI')
				// -- JIRA - DF-7752, Claude Blanc incorrectly listed as business owner 
				or 	(mdr.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ(pInput.source) and trim(pInput.vl_id) in ['849828736','986042075'])
				// -- JIRA - DF-17422, Consumer Advocacy Complaint - PAW Linking LexID - BDID 43998720 
				or 	(mdr.sourceTools.SourceIsWorkmans_Comp(pInput.source) and regexfind('YELLOW TRANSPORTATION',pInput.company_name, nocase) and STD.Str.CleanSpaces(pInput.fname + pInput.lname) in ['BOBBY PHILLIPS','INC YELLOW'])
				// -- JIRA - DF-17991 Consumer Dispute - record must be suppressed/deleted
				or  (mdr.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id) = '457217847     C6260365')
				// -- JIRA - DF-18128 Consumer Advocacy - Unlink PAW Record for LexID 54872692 Amodeo
				or  (mdr.sourceTools.SourceIsBusiness_Registration(pInput.source) and trim(pInput.company_source_group) = '3422833PATRICK M MCMATH LAW FIRM L' and trim(pInput.fname) = 'JAMES' and trim(pInput.lname) = 'AMODEO' and trim(pInput.mname) = 'E')
				// -- JIRA - DF-18344 Remove Business Contacts and PAW Record for LexID 13957703, Allene A Traphan
				or  (mdr.sourceTools.SourceIsTXBUS(pInput.source) and regexfind('ALLENE A TRAPHAN', pInput.company_name, nocase))
				// -- JIRA - DF-18950 ZOOM records to be suppressed in PAW
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vl_id) = '1684933816')
				// -- JIRA - DF-18955 PAW record to be supressed or deleted
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and pInput.phone = 7173042300 and trim(pInput.fname) = 'LORI' and trim(pInput.lname) = 'RICH')
				// -- JIRA - DF-19021 Consumer Advocacy - Removal of PAW/Business Contacts for Praveen Sengar
				or  (pInput.phone = 5088728200 and trim(pInput.fname) = 'PRAVEEN' and trim(pInput.lname) = 'SENGAR')
				// -- JIRA - DF-19020 Consumer Advocacy - Removal of PAW/Business Contacts for Sappington
				or  (regexfind('LANDGUARD EAGLE', pInput.company_name, nocase) and trim(pInput.vendor_id) in ['DZXWM0058497187','17-LLC-02958317'] and trim(pInput.fname) = 'CASSANDRA' and trim(pInput.lname) = 'SAPPINGTON')
				// -- JIRA - DF-18970 Remove all PAW/Business Contacts for LexID 724864388 at Las Vegas Address
				or  (pInput.did = 724864388 or (trim(pInput.fname) = 'PASTORA' and trim(pInput.lname) = 'ROLDAN' and 
						 ((trim(pInput.prim_name) = 'EASTERN' and pInput.zip = 89123) or (trim(pInput.company_prim_name) = 'EASTERN' and pInput.company_zip = 89123))))
				// -- JIRA - DF-18931 Cons. Adv. Report - Business Contacts Removal for LexID 829850667 Andra Flynn
				or  (trim(pInput.fname) = 'ANDREA' and trim(pInput.lname) = 'FLYNN' and regexfind('PC EXPRESS ENTERPRISES', trim(pInput.company_name), nocase))
				// -- JIRA - DF-19165 Consumer Advocacy - Remove PAW/Business Contacts for LexID 1793247875
				or  (mdr.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'BERNARD' and trim(pInput.lname) = 'THEIS' and regexfind('PAINE WEBER|PAYNE WEBER', pInput.company_name, nocase))
				// -- JIRA - DF-19162 Remove PAW and Business Contact Records for LexID 1510111650
				or  (trim(pInput.fname) in ['LEWIS','CHRIS','CHRISTOPHER'] and trim(pInput.lname) in ['LEWIS','RAND'] and trim(pInput.vendor_id) in ['RGXPY0536216046','01B7E3E6DE670600D8','4007701','IBTK 1 F     6X  P'])
				// -- ZOOM vendor_id's will be filtered from Business contacts and PAW files as per bug tickets listed above.
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) in Bad_zoom_vend_ids)
				// -- JIRA DF-19767 Consumer Adv - Remove PAW record from LexID 2332177997 SICHERMAN
				or  (mdr.sourceTools.sourceIsDCA(pInput.source) and trim(pInput.vendor_id) in ['3205715'] and trim(pInput.lname) = 'SICHERMAN')
				// -- JIRA - DF-19305 Experian Business Report has incorrect Officer Name of Jon C Dawson 
				or  (mdr.sourceTools.sourceIsEBR(pInput.source) and trim(pInput.vendor_id) in ['940772280'] and trim(pInput.lname) = 'DAWSON')
				// -- JIRA - DF-20318 PAW Error for LexID 13959907050 - Consumer Advocacy
				or  (mdr.sourceTools.sourceIsSpoke(pInput.source) and trim(pInput.lname) = 'JOHNSON' and trim(pInput.fname) in ['CHRISTOPHER','CHRIS'] and pInput.phone = 6123046073)
				// -- JIRA - DF-20685 LexID 523271314 - Wrongly Appended PAW records - Consumer Advocacy.
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.fname) = 'MICHAEL' and trim(pInput.lname) = 'COUTR' and trim(pInput.prim_name) = 'MAIN' and pInput.zip = 7503 and regexfind('ST. JOSEPH HEALTH SYSTEM', pInput.company_name, nocase))
				// -- JIRA - DF-20795 - Consumer disputing association with a company
				or  (mdr.sourceTools.sourceIsEq_Employer(pInput.source) and pInput.company_phone = 3192333309)
				// -- JIRA - DF-21961 - Consumer Adv. - PAW/Bus. Contacts Overlinking LexID 184656279
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) = '2108024717    C90883103' and trim(pInput.prim_name) = 'PO BOX 6')
				// -- JIRA - DF-21988 - Consumer Advocacy - Linking Dispute LexID 1533124325 - Mary Lloyd
				or  ((mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) or mdr.sourceTools.sourceIsFBNV2_Hist_Choicepoint(pInput.source)) and trim(pInput.vendor_id) in ['CP3345616258597945683', '76327426'] and trim(pInput.fname) = 'MARY' and trim(pInput.lname) = 'LLOYD')
				// -- JIRA# DF-22524 - Business Header/PAW - Bad PA Corps addresses 
				// -- JIRA# DF-22502 - PA Corps contact addresses are skewed
				or 	(MDR.sourceTools.sourceIsPA_Corporations(pInput.source) and pInput.bdid = 4548595047 and trim(pInput.lname) = '')
				// -- JIRA - DF-22852 - Consumer Dispute - Paw record to be removed
				or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and pInput.bdid = 984406 and pInput.did = 402682961)
				// -- JIRA - DF-22841 - Overlinking in PAW LexID 1224547541
				or  (mdr.sourceTools.sourceIsUT_Corporations(pInput.source) and trim(pInput.vendor_id) = '49-2039256')
				// -- JIRA - DF-22790 - Consumer Dispute - PAW record to be removed
				or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and trim(pInput.vl_id) in ['17794919'] and trim(pInput.fname) = 'TINA' and trim(pInput.lname) = 'TOPE')
				// -- JIRA - DF-22882 - consumer has opted out but these records are still in PAW 
				or  ((mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) or mdr.sourceTools.sourceIsIL_Corporations(pInput.source)) and trim(pInput.vendor_id) in ['17-LLC-03428427','22388016','24834066'] and trim(pInput.lname) in ['RICCARDO','BRADLEY'])
				// -- JIRA - DF-23058 - Consumer Dispute - Paw and Bus Header Records to be removed
				or  (trim(pInput.fname) = 'BROCK' and trim(pInput.lname) = 'KORSAN' and trim(pInput.company_source_group) = 'L14000179431JAMES ROBERTS PAINTING')
				// -- JIRA - DF-22874 - Consumer Dispute Paw records and old business header contact records to be removed
				or  ((trim(pInput.company_source_group) in ['25817K-3 INC','42981866JD PROPERTIES'] or pInput.company_phone = 9492510650) and trim(pInput.fname) = 'YANA' and trim(pInput.lname) in ['ROSTOMYAN','ROSTOMIAN'])
				// -- JIRA - DF-22999 - Consumer Dispute has a Paw record to be removed
				or  (trim(pInput.vendor_id) = 'SKAV4337795' and pInput.company_phone = 6196591085 and trim(pInput.lname) = 'SPINO')
				// -- JIRA - DF-23136 - FCRA PAW Linking - LexID 1386265060 Kiefer
				or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and trim(pInput.company_source_group) = '84399STENSENG CONSULTING' and trim(pInput.lname) = 'KIEFER' and trim(pInput.fname) = 'MAX')
				// -- JIRA# DF-23181 - FCRA dispute Connection to Business in PAW (NOTE:- Remove the filter after the build run)
				or (MDR.sourceTools.sourceIsMA_Corporations(pInput.source) and trim(pInput.vendor_id) = '25-FW1GV5')
				// -- JIRA - DF-22815 - Overlinking
				// -- JIRA - DF-23226 - Please remove linking of business to consumer
				//or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and trim(pInput.vl_id) in ['67521015','53535058'] and pInput.company_phone in [6196544162,9494978859])
				// -- JIRA - DF-22997 - Consumer associated to Businesses that should be removed
				//or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and trim(pInput.vl_id) in ['56910883','33310807','6374820','53185856','64002274'] and trim(pInput.fname) = 'STEPHANIE' and trim(pInput.lname) = 'WATTS')
				// -- JIRA - LNK-1241 - Incorrectly Linked PAW Record to LexID 151903650709 Luis - Consumer Advocacy
				or (MDR.sourceTools.sourceIsFL_Corporations(pInput.source) and trim(pInput.vendor_id) = '12-P00000050597' and trim(pInput.fname) = 'VILLAZON' and trim(pInput.lname) = 'LUIS')
				// -- JIRA - DF-23135 - FCRA PAW Linking - LexID 577977107 Dimas
				or (MDR.sourceTools.sourceIsNM_Corporations(pInput.source) and trim(pInput.vendor_id) = '35-2211597' and trim(pInput.fname) = 'ANNA' and trim(pInput.lname) = 'DAVIS')
				// -- JIRA - DF-22342 - PAW data from zoom and spoke incorrectly linked to consumer
				or (pInput.phone in [3126169600,2122511234,3126162628] and trim(pInput.lname) = 'JOHNSON' and trim(pInput.fname) = 'JEFF' and trim(pInput.prim_range) = '225' and regexfind('CRAMER-KRASSELT', pInput.company_name, nocase))
				// -- JIRA - DF-22787 - Consumer Dispute - PAW record to be removed
				or  (pInput.phone = 3013803000 and trim(pInput.lname) = 'SMITH' and trim(pInput.fname) = 'BRIAN' and trim(pInput.mname) in ['','W'])
				// -- JIRA - DF-22950 - Paw data from zoom incorrectly conntected to consumer				
				or  (mdr.sourceTools.sourceIsZoom(pInput.source) and pInput.phone = 5864658018 and trim(pInput.lname) = 'ADAMASZEK' and trim(pInput.fname) = 'EARL' and trim(pInput.mname) = 'PHILIP')
			;

			boolean lFullFilter 		:= if(pFilterOut
																		,not(lStandardFilter or lAdditionalFilter)	//negate it 
																		,(lStandardFilter or lAdditionalFilter)	//negate it 
																	);

			///////////////////////////////////////////////////////////////////
			// -- Bug 25304 -- blank this phone
			// -- Bug 42887 -- blank bad phones
			///////////////////////////////////////////////////////////////////
			Layout_Business_Contact_Full_new tblankoutphone(Layout_Business_Contact_Full_new l) :=
			transform
				// JIRA - DF-20838 Incorrect Date Last Seen in FL FBN Record in old Business Header BDID 48554866
				// One time THOR PATCH Code, had to Remove this code after the next build run.
				str_dt_first_seen 		:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(string8)l.dt_first_seen,'');
				str_dt_last_seen 			:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(string8)l.dt_last_seen,'');
				temp_dt_first_seen		:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source), str_dt_first_seen[1..4] + str_dt_first_seen[7..8] + str_dt_first_seen[5..6],'');
				temp_dt_last_seen			:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source), str_dt_last_seen[1..4] + str_dt_last_seen[7..8] + str_dt_last_seen[5..6],'');
				
				filterbug71237 :=			regexfind('DEL TACO',l.company_name,nocase)
													and (			l.phone					= 5619994400
																or	l.company_phone = 5619994400
															)
												;
				filterbug25304 :=		l.bdid					= 278065382
												and	l.did						= 113639240254
												;
				filterbug30402 := 	(			l.DID = 001275597776
															or	l.SSN = 110387404
														)
												and l.lname = 'JONES'
												and l.fname = 'HARRY'
												and (			l.mname = 'LEONARD'
															or	l.mname = 'L'
														)
												and l.state = 'TX'
												;
				filterbug36622 := MDR.sourceTools.SourceIsProfessional_License(l.source);
				// -- Bug 37562 - Remove a Title of "Owner" in Business Header Contacts Record
				filterbug37562 := (		l.bdid					= 96625718 
													and l.lname					= 'HENDERSON'
													and l.fname					= 'CURT'
													and l.company_title = 'OWNER'
				);
				// Bug: 42740 - Business FEIN #'s transposed
				filterbug42740 :=		regexfind('ELDORADO MANAGEMENT',l.company_name,nocase) 
												and l.company_fein	= 430915544 
												;
				// Bug: 48348 - DNB, Duns# 364405423 is linking two unrelated businesses
				blankbug48348 := trimids(l.vendor_id) = '364405423' 
												and mdr.sourcetools.SourceIsDunn_Bradstreet(l.source)
												and trim(l.company_name) = 'EAST LOS ANGELES BAKERY, INC.'
												;
				
				// BBug: 114192 -Incorrect individual linked to Business
				filterbug114192 := trimids(l.vl_id) in ['25-00FUD1','25-KD7XE6'] 
												and mdr.sourcetools.SourceIsMA_Corporations(l.source)
												and trim(l.fname) = 'CRISTOPHER' and trim(l.lname) = 'BARRET'
												and l.did = 144086733
												;
				
				// JIRA: LNK-563 - Consumer Advocacy - PAW Linking Questioned
				filterbugLNK563 := trimids(l.vendor_id) in ['12-552868'] 
												and mdr.sourcetools.SourceIsFL_Corporations(l.source)
												and trim(l.fname) = 'SHEILA' and trim(l.lname) = 'BORLAND'
												and l.did = 2323167047
												;
												
				// JIRA: DF-20009 - Remove FEIN 32-0153283 from BDID 004315292869 Carriage House
				filterbugDF20009 := trimids(l.vl_id) in ['12-M17000000132'] 
												and mdr.sourcetools.SourceIsFL_Corporations(l.source)
												and l.company_fein = 320153283
												;
			
				// JIRA - DF-21083 PAW Error for LexID 947738531, Heagerty - Consumer Advocacy 
				filter_DF21083 :=	mdr.sourcetools.SourceIsDunn_Bradstreet(l.source) 
													and trim(l.vendor_id) = '140700316'	and (l.phone	= 7707819312 or l.company_phone = 7707819312)
													and regexfind('CONSUMER SOLUTIONS', l.company_name, nocase)
												;
												
				// JIRA: LNK-1267 - Overlinking of PAW Record in LexID 1262440073 - Consumer Advocacy
				filterbugLNK1267 := trimids(l.company_source_group) in ['899025PERFECT PEACE DAY SPA SALON','899025PERFECT PEACE DAY SPA & SALO'] 
														and mdr.sourcetools.sourceIsBusiness_Registration(l.source)
														and trim(l.fname) = 'MICHELLE' and trim(l.lname) = 'JOHNSON' and trim(l.mname) = 'A'
														and l.did = 1262440073
														;
														
				// JIRA: DF-22318 - Cons. Adv. PAW Overlining 1252928994 Johnson
				filterbugDF22318 := trimids(l.vendor_id) in ['25-9B9IH8','25-006SKW'] 
														and mdr.sourcetools.SourceIsMA_Corporations(l.source)
														and trim(l.fname) = 'DAVID' and trim(l.lname) = 'JOHNSON' and trim(l.mname) = 'L'
														and l.did = 1252928994
														;
				
				// JIRA: DF-23078 - FCRA PAW Overlinking of LexID 1714518962 Meyer
				filterbugDF23078 := trimids(l.vendor_id) in ['12-K92695'] 
														and mdr.sourcetools.SourceIsFL_Corporations(l.source)
														and trim(l.fname) = 'RICHARD' and trim(l.lname) = 'MAYER' and trim(l.mname) = 'M'
														and l.did = 1714518962
														;
				
				// -- JIRA - LNK-1501 - Wrong consumer tied to Business connection and possible employee
				filterbugLNK1501 := l.phone in [3032981000] and trim(l.lname) = 'HUNT' and trim(l.fname) in ['CHRISTOPHE','CHRISTOPHER'] 
														and regexfind('ANSCHUTZ CO', l.company_name, nocase)
														and l.did = 1192309336;
				
				phone 				:= (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.phone));  // Zero the phone if more than 10-digits
				company_phone := (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.company_phone));  // Zero the companyphone if more than 10-digits
				
				// -- Bug: 63323 - Address report returns error when address begins with percentage sign
				prim_name					:= if(trim(l.prim_name				,left,right)[1] = '%', 'C/O ' + trim(l.prim_name				,left,right)[2..], l.prim_name				);
				company_prim_name := if(trim(l.company_prim_name,left,right)[1] = '%', 'C/O ' + trim(l.company_prim_name,left,right)[2..], l.company_prim_name);

				self.prim_name					:= prim_name				;
				self.company_prim_name	:= company_prim_name;
				self.phone					:= map(	 (filterbug25304 and l.phone = 2127938763)				
																		or filterbug71237 or filter_DF21083 => 0					
																	,phone				
																);
				self.company_phone	:= map(	 (filterbug25304 and l.company_phone = 2127938763)
																		or filterbug71237 or filterbug36622 or filter_DF21083 => 0					
																	,company_phone				
																);

				self.company_name 				:= scrubcompanyname(l.company_name);
				self.company_fein					:= if(filterbug42740 or filterbugDF20009,0	,l.company_fein);
				self.vendor_id						:= if(blankbug48348,'',trimids(l.vendor_id));
				self.company_source_group	:= trimids(l.company_source_group);
				self.DID									:= if(filterbug30402 or filterbug114192 or filterbugLNK563 or filterbugLNK1267 or
																				filterbugDF22318 or filterbugDF23078 or filterbugLNK1501, 0, l.did);
				self.ssn									:= if(filterbug30402 or filterbugLNK563 or filterbugLNK1267 or filterbugDF22318 or 
																				filterbugDF23078 or filterbugLNK1501, 0, l.ssn);
				//for bug 30494 & 30519.  20080424
				// JIRA - DF-20838 Incorrect Date Last Seen in FL FBN Record in old Business Header BDID 48554866
				// One time THOR PATCH Code, had to Remove this code after the next build run.
				self.dt_first_seen				:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(unsigned4)temp_dt_first_seen,(unsigned4)validatedate((string8)l.dt_first_seen								,if(length(trim((string8)l.dt_first_seen						)) = 8,0,1)));
				self.dt_last_seen					:= if(mdr.sourceTools.sourceIsFL_Non_Profit(l.source),(unsigned4)temp_dt_last_seen,(unsigned4)validatedate((string8)l.dt_last_seen									,if(length(trim((string8)l.dt_last_seen							)) = 8,0,1)));
				//self.dt_first_seen				:= (unsigned4)validatedate((string8)l.dt_first_seen						,if(length(trim((string8)l.dt_first_seen						)) = 8,0,1));
				//self.dt_last_seen					:= (unsigned4)validatedate((string8)l.dt_last_seen						,if(length(trim((string8)l.dt_last_seen							)) = 8,0,1));
				//Bug 30987 -- remove site powered by                                              
				self.company_title := map( stringlib.stringtolowercase(l.company_title) = 'site powered by:'	=> ''
																	,filterbug37562																											=> '' 
																	,l.company_title
															);
				self											:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));

		end;

		export Business_Header_Best(
			 dataset(Layout_Business_Header_Base) pInput
			,boolean															pFilterOut = true
		) :=
		function

			lfilter		:= 		MDR.sourceTools.SourceIsEBR							(pInput.source)
									or  MDR.sourceTools.SourceIsExperianVehicle	(pInput.source)	//set to false for no filter
									;
									
			boolean lFullFilter 		:= if(pFilterOut
																		,not(lfilter)	//negate it 
																		,(lfilter)	//negate it 
																	);

			Layout_Business_Header_Base tblankoutbadfeins(Layout_Business_Header_Base l) :=
			transform
				
				filterbug30999 :=		l.fein			in  setbadfeins
												;
				
				self.fein					:= if(filterbug30999,0	,l.fein						);
			  self.source				:= l.source;
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutbadfeins(left));
		
		end;
		

	end;
	
	export BasesOut :=
	module
	
		export Business_Headers(

			 dataset(Layout_Business_Header_Base) pInput
			,boolean															pFilterOut = true

		) :=
		function
				
			boolean lFilter 	:= // -- Bug: 113227 - Business Header contains errorneous Corporation record.
													(		pInput.bdid						= 616279283	)
													 // -- Bug: 182220 - Record (BDID) Suppression
											or	(		pInput.bdid						= 1943474549)
													 // -- JIRA:DL-16735 - Consumer Dispute, Drop PETER KIRN records from Business header file.
											or	(		pInput.bdid						= 132614966);

			boolean lFullFilter 		:= if(pFilterOut
																		,not lFilter	//negate it 
																		,lFilter	//negate it 
																	);

			///////////////////////////////////////////////////////////////////
			// -- Bug 25304 -- blank this phone
			///////////////////////////////////////////////////////////////////
			Layout_Business_Header_Base tscrubbh(Layout_Business_Header_Base l) :=
			transform
				
				filterbug71237 :=			l.bdid	= 128805790
													and l.phone	= 5619994400
												;

				self.phone				:= if(	 filterbug71237	,0					
																									,l.phone				
														);
				self							:= l																							;                              
			end;
			
			BH_out := project(pInput(lFullFilter), tscrubbh(left));
			
			///////////////////////////////////////////////////////////////////
			// -- Bug 95843 -- Unlink the SOUTHERN CALIFORNIA PIPELINE and 
			// 								 SOUTHERN CALIFORNIA LEASING, INC. with address 
			//								 250 EL CAMINO REAL, TUSTIN CA 92780
			///////////////////////////////////////////////////////////////////
			bdid_split_filter := BH_out.BDID = 113490609 and 
													 (stringlib.stringfind(BH_out.company_name, 'SOUTHERN CALIFORNIA LEASING',1) > 0 or
														stringlib.stringfind(BH_out.company_name, 'SOUTHERN CALIFORNIA TOURS',1) > 0 or
														(trim(BH_out.company_name) = 'SOUTHERN CALIFORNIA' and BH_out.sec_range = ''));
//										 (stringlib.stringfind(BH_out.company_name, 'SOUTHERN CALIFORNIA PIPELINE',1) > 0 or
//											stringlib.stringfind(BH_out.company_name, 'YOUTHERN CALIFORNIA PIPELINE',1) > 0 or
//										 (trim(BH_out.company_name) = 'SOUTHERN CALIFORNIA' and BH_out.sec_range = '208'));
										
			BH_filtered_BDID := BH_out(bdid_split_filter);
			BH_filtered_rest := BH_out(~bdid_split_filter);

			BH_filtered_BDID_srt := sort(BH_filtered_BDID, rcid);

			//*** Get the min "rcid" value for the BDID group.
			min_rcid := min(BH_filtered_BDID_srt, rcid);

			//*** Project the BDID filetered file to replace the BDID=113490609 with the lowest rcid as new bdid to split.
			BH_filtered_BDID_fixed := project(BH_filtered_BDID_srt, transform(business_header.Layout_Business_Header_Base, self.bdid := min_rcid, self := left));

			BH_final_out := BH_filtered_rest + BH_filtered_BDID_fixed;
			
			return BH_final_out;

		end;

		export Business_Contacts(

			 dataset(Layout_Business_Contact_Full_new)	pInput
			,boolean																pFilterOut = true

		) :=
		function

			boolean lFilter 	:= 				//Bug: 84168 - Two CA Businesses Being Overlinked
			
				(			pInput.did						= 1288856306
				 and	pInput.bdid						= 671877838)
				 or  // -- Bug: 113227 - Business Header contains errorneous Corporation record.
				(			pInput.did						= 1787398109
				 and	pInput.bdid						= 616279283)
				 // -- Bug: 109269 - Remove 4 Employment Locator records for David Scott Tronson.
				or  (mdr.sourceTools.SourceIsEq_Employer(pInput.source) and pInput.phone = 2534603191)
				 // -- Bug: 106251 - Overlinking of Business Contacts to Michael McGovern
				or	(		pInput.bdid in [3596011, 558650599] and pInput.did = 1671671138)
				// -- Bug:146861 - Remove All Business Records Associate with David Peyman
				// -- Bug:153300 - Remove Lexid 113261977728 for Peyman Shalah
				or	(trim(pInput.lname) = 'PEYMAN' and trim(pInput.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'])
				// -- Bug: 157298  - Remove Contact Angela Farole from BDID 53982819 Avante Abstract Inc.
				or 	(trim(pInput.company_name) in [	'AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and trim(pInput.fname) = 'ANGELA' and trim(pInput.lname) = 'FAROLE' and trim(pInput.mname) in ['','M'])
				// -- Bug:98757 - Experian Business Report Filing Numbers are Overlinking Oregon Companies				
				or 	(MDR.sourceTools.SourceIsEbr(pInput.source) and trim(pInput.vl_id) = '809376459' and (regexfind('HEALTHCARE|HOSPITAL',trim(pInput.company_name,left,right),nocase) or (trim(pInput.lname) = 'MARCHETTI' and trim(pInput.fname) ='MARK')))
				// -- Bug: 182220 - Record (BDID) Suppression
				or	(pInput.bdid = 1943474549)
				// -- JIRA: DF-16735 Per Privacy Programs - Remove OH MVR Record for David Kirn in Business Header
				//	Camelback Group, PETER KIRN * DAVID KIRN 
				or	(pInput.did in [1400550559, 154640963692] or pInput.ssn = 273466389)
				// -- JIRA: DF-19162 Remove PAW and Business Contact Records for LexID 1510111650
				or	(pInput.did = 1510111650)
				// -- JIRA: DF-18970 Remove all PAW/Business Contacts for LexID 724864388 at Las Vegas Address
				or	(pInput.did = 724864388)
				// -- JIRA: DF-20795 - Consumer disputing association with a company
				or  (mdr.sourceTools.SourceIsEq_Employer(pInput.source) and pInput.company_phone = 3192333309)
				// -- JIRA: DF-22583 - Consumer Dispute - PAW record to be removed
				or  (mdr.sourceTools.SourceIsZoom(pInput.source) and pInput.did = 1743066322 and pInput.bdid = 975644 and trim(pInput.fname) = 'KARLA' and trim(pInput.lname) = 'MITCHELL' and trim(pInput.mname) = '')
				// -- JIRA - DF-22852 - Consumer Dispute - Paw record to be removed
				or  (mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and pInput.bdid = 984406 and pInput.did = 402682961)
			
				;

			boolean lFullFilter 		:= if(pFilterOut
																		,not lFilter	//negate it 
																		,lFilter	//negate it 
																	);

			///////////////////////////////////////////////////////////////////
			// -- Bug 25304 -- blank this phone
			///////////////////////////////////////////////////////////////////
			Layout_Business_Contact_Full_new tblankoutphone(Layout_Business_Contact_Full_new l) :=
			transform
				
				filterbug30402 := 	(			l.DID = 001275597776
															or	l.SSN = 110387404
														)
												and l.lname = 'JONES'
												and l.fname = 'HARRY'
												and (			l.mname = 'LEONARD'
															or	l.mname = 'L'
														)
												and l.state = 'TX'
												;
				// JIRA: LNK-563 - Consumer Advocacy - PAW Linking Questioned
				filterbugLNK563 := trimids(l.vendor_id) in ['12-552868'] 
												and mdr.sourcetools.SourceIsFL_Corporations(l.source)
												and trim(l.fname) = 'SHEILA' and trim(l.lname) = 'BORLAND'
												and l.did = 2323167047
												;
				// JIRA: LNK-1267 - Overlinking of PAW Record in LexID 1262440073 - Consumer Advocacy
				filterbugLNK1267 := trimids(l.company_source_group) in ['899025PERFECT PEACE DAY SPA SALON','899025PERFECT PEACE DAY SPA & SALO'] 
														and mdr.sourcetools.sourceIsBusiness_Registration(l.source)
														and trim(l.fname) = 'MICHELLE' and trim(l.lname) = 'JOHNSON' and trim(l.mname) = 'A'
														and l.did = 1262440073
														;
				// JIRA: DF-22318 - Cons. Adv. PAW Overlining 1252928994 Johnson
				filterbugDF22318 := trimids(l.vendor_id) in ['25-9B9IH8','25-006SKW'] 
														and mdr.sourcetools.SourceIsMA_Corporations(l.source)
														and trim(l.fname) = 'DAVID' and trim(l.lname) = 'JOHNSON' and trim(l.mname) = 'L'
														and l.did = 1252928994
														;
				// JIRA: DF-23078 - FCRA PAW Overlinking of LexID 1714518962 Meyer
				filterbugDF23078 := trimids(l.vendor_id) in ['12-K92695'] 
														and mdr.sourcetools.SourceIsFL_Corporations(l.source)
														and trim(l.fname) = 'RICHARD' and trim(l.lname) = 'MAYER' and trim(l.mname) = 'M'
														and l.did = 1714518962
														;
				// -- JIRA - LNK-1501 - Wrong consumer tied to Business connection and possible employee
				filterbugLNK1501 := l.phone in [3032981000] and trim(l.lname) = 'HUNT' and trim(l.fname) in ['CHRISTOPHE','CHRISTOPHER'] 
														and regexfind('ANSCHUTZ CO', l.company_name, nocase)
														and l.did = 1192309336;
				// --- Bug#35653 -  For the "Eq_employer" source first & last seen dates are set to zero/blank as the 
				// dates coming in from the base file are harded coded.
				ZeroEq_EmployerDate :=  (MDR.sourceTools.SourceIsEq_Employer(l.source));
				// -- Bug: 41057 - Future Dates Appearing in Business Header Files 
				// -- needs to also be filtered here because the people header and phonesplus
				// -- go in a separate way from the regular sources, and their dates don't get scrubbed.
				unsigned4 dt_first_seen	:= (unsigned4)validatedate((string8)l.dt_first_seen	,if(length(trim((string8)l.dt_first_seen						)) = 8,0,1));
				unsigned4 dt_last_seen	:= (unsigned4)validatedate((string8)l.dt_last_seen	,if(length(trim((string8)l.dt_last_seen							)) = 8,0,1));

				self.dt_first_seen        := if (ZeroEq_EmployerDate, 0, dt_first_seen);
				self.dt_last_seen         := if (ZeroEq_EmployerDate, 0, dt_last_seen);
				
				self.DID									:= if(filterbug30402 or filterbugLNK563 or filterbugLNK1267 or 
																				filterbugDF22318 or filterbugDF23078 or filterbugLNK1501, 0, l.did)	;
				self.ssn									:= if(filterbug30402 or filterbugLNK563 or filterbugLNK1267 or 
																				filterbugDF22318 or filterbugDF23078 or filterbugLNK1501, 0, l.ssn)	;
				self											:= l														;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));

		end;
	
		filterRec := RECORD
			unsigned6 bdid1;
			unsigned6 bdid2;
		END; 
		shared bdidsToBeFiltered := DATASET ([
			{1873281985, 45236859},
			{1873281985, 1947852989},
			{1873281985, 1954159808},
			{1947802553, 45236859},
			{1947802553, 1947852989},
			{1947802553, 1954159808},
			{1954168479, 45236859},
			{1954168479, 1947852989},
			{1954168479, 1954159808},
			{72240697		,45236859},
			{72240697		,1873281985},
			{72240697		,1947802553},
			{72240697		,1954168479},
			{72240697		,1954159808},
			{107800659,	 113490609}, 	//*** Bug:95843 - Overlinking of Barbara Griffith with Southern California Pipeline
			{125686733,	 150732877},  //*** Bug:95843 - Overlinking of Barbara Griffith with Southern California Pipeline
			{29095389,   32032819},
			{69701262,   95194575}, 	//*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   105934715},  //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   167801849},  //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   545038389},  //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   1168297034}, //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   2452906262}, //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{1221621646, 2452906262}, //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{1221644272, 2452906262}, //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{1770940086, 2452906262}, //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{1878015099, 2452906262}  //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			], filterRec);
		
		export Business_Relatives(dataset(Layout_Business_Relative) pInput,boolean pFilterOut = true) :=
		function

			//Filter out any overlinked bdids
			macFilterBdidRelations(pInput, bdidsToBeFiltered, BDid_Filtered,,,pFilterOut);
			
			return BDid_Filtered;
		
		end;
		
		export Business_Relative_Group(dataset(Layout_Business_Relative_Group) pInput,boolean pFilterOut = true) :=
		function

			//Filter out any overlinked bdids
			macFilterBdidRelations(pInput, bdidsToBeFiltered, BDid_Filtered,group_id,bdid,pFilterOut);
			
			return BDid_Filtered;
		
		end;

	end;
	
	export Outs :=
	module
	
		export Business_Headers(
			 dataset(Layout_Business_Header_Base) pInput
			,boolean															pFilterOut = true
		) :=
		function

			lfilter		:= MDR.sourceTools.SourceIsEBR(pInput.source);	//set to false for no filter
			
			boolean lFullFilter 		:= if(pFilterOut
																		,not lFilter	//negate it 
																		,lFilter	//negate it 
																	);

			Layout_Business_Header_Base tblankoutbadfeins(Layout_Business_Header_Base l) :=
			transform
				
				filterbug30999 :=		l.fein			in  setbadfeins
												;
				
				self.fein					:= if(filterbug30999,0	,l.fein						);
				self							:= l																							;                              
			end;
			
			dfilter := project(pInput(lFullFilter), tblankoutbadfeins(left));
			
			dConvertSourceCodesBack := MDR.Align_SourceTools.Backward.fBusinessHeader(dfilter);
			
			return dConvertSourceCodesBack;
			
		end;                  
		
		export Business_Contacts(
			 dataset(Layout_Business_Contact_Full_new)	pInput
			,boolean																pFilterOut = true
		) :=
		function

			boolean lFilter	:= 
						MDR.sourceTools.SourceIsEBR(pInput.source)
			or		MDR.sourceTools.SourceIsZoom(pInput.source)
			or
			(			MDR.sourceTools.SourceIsDunn_Bradstreet(pInput.source)	 // filter out DNB records
			)

			or			pInput.from_hdr					<>	'N'	// filters out all header records(because it is negated below)
			or			Business_Header.CheckUCC(pInput.source, pInput.company_name, pInput.fname, pInput.mname, pInput.lname, pInput.name_suffix)
			or
				(		pInput.did						= 1363114130
				 and	pInput.bdid						= 14733991
				)

			;

			boolean lFullFilter 		:= if(pFilterOut
																		,not lFilter	//negate it 
																		,lFilter	//negate it 
																	);
			///////////////////////////////////////////////////////////////////
			// -- Bug 25257 -- left only lookup join on pull ssn on ssn and did
			///////////////////////////////////////////////////////////////////
			Layout_Business_Contact_Full_new tblankoutbadfeins(Layout_Business_Contact_Full_new l) :=
			transform
				
				filterbug30999 :=		l.company_fein			in  setbadfeins
												;
				
				self.company_fein					:= if(filterbug30999,0	,l.company_fein						);
				self.ssn					:= if(IsValidSsn(l.ssn)	,l.ssn	,0							);
				self							:= l																							;                              
			end;
			
			lInput :=  project(pInput(lFullFilter), tblankoutbadfeins(left));

			pullids := doxie.File_pullSSN;
			
			Layout_Business_Contact_Full_new tremoverecords(Layout_Business_Contact_Full_new l, pullids r) :=
			transform
				self := l;
			end;
			
			pulldids := join(lInput
											,pullids
											,left.did != 0 and left.did = (unsigned6)right.ssn
											,tremoverecords(left,right)
											,lookup
											,left only
											);
			
			pullssns := join(pulldids
											,pullids
											,left.ssn != 0 and left.ssn = (unsigned4)right.ssn
											,tremoverecords(left,right)
											,lookup
											,left only
											);
			dConvertSourceCodesBack := MDR.Align_SourceTools.Backward.fBusinessContacts(pullssns);
			
			return dConvertSourceCodesBack;

		end;


		export PeopleAtWorkSeq(dataset(Layout_Business_Contact_Sequenced) pInput) := 
		function
			boolean lAdditionalFilter	:= 
					// -- Bug: 184195 - DNB DMI Needs Removed from PAW	
				(		MDR.sourceTools.SourceIsDunn_Bradstreet(pInput.source)) 
			or
				(		MDR.sourceTools.SourceIsEBR(pInput.source))
			or // -- Bug:  - Flush the Jigsaw records as per Jason.
				(	MDR.sourceTools.SourceIsJigsaw(pInput.source))
			or
				(		pInput.did						= 1363114130
				 and	pInput.bdid						= 14733991
				)
			or	// -- Bug: 103804 - Questionable Company Names.
				(		pInput.bdid 				= 2736997388)	
			or	// -- Bug: 145649 - Accurint 52354 - PAW Overlinking of LexID 2715613629 D. Williams
					// -- Bug: 191918/JIRA: DF-14772 - Consumer Privacy Reports Incorrectly Linked PAW Record
				(	MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) in ['1542124062','731821740','731821740C20895717','645546729     C352857954'])
						
			or	// -- Bug: 98386 - Robert Spencer and Virginia Union University
				(		MDR.sourceTools.SourceIsZoom(pInput.source) 
				 and pInput.bdid 			= 3564212 
				 and pInput.did  			= 2405720103
				)
			or	// -- Bug: 107265 - Remove Person Contacts from BDID 2607452175 Asian Massage
				(		MDR.sourceTools.SourceIsFBNV2_Experian_Direct(pInput.source) 
				 and pInput.bdid = 2607452175 
				 and (pInput.did in [3543987503, 456312873, 1123277952] or trim(pInput.lname,left,right) = 'DAVIS-CONEY')
				)
			or	// -- Bug: 107798 - Remove two Business Header records with wrong source codes.
				(		MDR.sourceTools.SourceIsAK_Corporations(pInput.source) 
					and pInput.bdid in [16952458])
			or  // -- Bug: 109269 - Remove 4 Employment Locator records for David Scott Tronson.
				(		MDR.sourceTools.SourceIsEq_Employer(pInput.source) 
					and pInput.DID = 2562729144 and pInput.bdid = 2988148887)
			or	// -- Bug: 113227 - Business Header contains errorneous Corporation record.
				(		MDR.sourceTools.SourceIsCA_Corporations(pInput.source) 
					and trim(pInput.vendor_id,left,right) = '06-01620279' and trim(pInput.city) = 'CULVER CITY')
			or	// -- Bug: 105072 - Tina Gutierrez is Overlinked to Rackspace LTD.
				(  pInput.bdid = 1936130951 and pInput.did = 408918097)
			or  // -- Bug: 105072 - Tina Gutierrez is Overlinked to Rackspace LTD.
				(	 mdr.sourceTools.SourceIsSpoke(pInput.source) and trim(pInput.vendor_id) = 'TX-3410800962')
			or	// -- Bug: 110922 - Remove TMSID from Business Header, Contacts and PAW for Steve Dixon
				(		pInput.bdid = 776748497 and pInput.did = 660077201)
			or  // -- Bug: 93269 - J&L linking to incorrect company in business report
				(		MDR.sourceTools.SourceIsZoom(pInput.source) and pInput.company_source_group = '96813300')
			or  // -- Bug: 106251 - Overlinking of Business Contacts to Michael McGovern
				(		pInput.bdid in [3596011, 558650599] and pInput.did = 1671671138)
			or	// -- Bug: 115130 - Unlink DID for Michael Hild from Serenity Home Care Agency
					// -- Bug: 120900 - Remove FBN Record from Business Header & Contacts for Al-Jarafi
				(		mdr.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vendor_id) in ['CP219395185453452160','CP11910987965939266948'])
			or  // -- Bug:121240 -Hewlett Packard Bus Search Result on Portal returns D&B Report
				(		(MDR.sourceTools.SourceIsAZ_Corporations(pInput.source) or MDR.sourceTools.SourceIsUCCV2(pInput.source)) and pInput.vendor_id in ['04-F08167145','DNB000173979719961223'])
			or	// -- Bug: 125332 - People at Work Suppression
			  (		MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'DELORES' and trim(pInput.lname) = 'PARKER' and trim(pInput.mname)='DIANE' and 
							trim(pInput.company_name) in ['MAPLEHURST REALTY INC','MAPLEHURST'])
			or	// -- Bug: 119446 - Remove Zoom Records for LexID 1234490932 Tahir Javed 
				(		MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.company_name) in ['OMAHA WORLD-HERALD COMPANY','OMAHA WORLD-HERALD'] and trim(pInput.fname) = 'TAHIR' and trim(pInput.lname) = 'JAVED')
			//or  // -- Bug: 119049 - Unlink Bradley Leighty from BOA Auto Sales
			//  (		(mdr.sourceTools.SourceIsDunn_Bradstreet(pInput.source) or mdr.sourceTools.SourceIsEBR(pInput.source)) and 
			//				trim(pInput.vendor_id,left,right) in ['D092297238-BOA AUTO SALES INC','738365619'] and trim(pInput.fname) = 'BRADLEY' and trim(pInput.lname) = 'LEIGHTY')
			or	// -- Bug: 131131 - Business Contact Information for Opt Out Consumer-Rush Request
				( trim(pInput.company_name,left,right) in ['BAKER & MCKENZIE LLP','JACKSON DEV & CONSTRUCTION INC','MEDIA CENTER PC',
																									 'NATIONAL COLLEGE FOR DUI DEFENSE , INC.','OPPENHEIMER WOLFF DONNELLY LLP',
																									 'SOUTH COAST LITIGATION GROUP','THE NATIONAL COLLEGE FOR DUI DEFENSE , INC.','UNIVERSITY OF PENNSYLVANIA'] and trim(pInput.fname) = 'VANIA' and trim(pInput.lname) = 'CHAKER')
			or	// -- Bug: 139082 - Remove Ana Lane Gomez from FBN, Business Header and PAW files
				(	MDR.sourceTools.SourceIsFBNV2_Experian_Direct(pInput.source) and trim(pInput.vendor_id) = 'EXP6160690673128140760')
			or	// -- Bug:146861 - Remove All Business Records Associate with David Peyman	-- Bug:153300 - Remove Lexid 113261977728 for Peyman Shalah
				(	trim(pInput.lname) = 'PEYMAN' and trim(pInput.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'])
			or	// -- Bug:146862 - These corp keys need to be filtered out of all base files
				(	MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) in ['06-03155932', '06-200820510058', '06-200620910099'])
			or 	// -- Bug: 157298  - Remove Contact Angela Farole from BDID 53982819 Avante Abstract Inc.
				(	trim(pInput.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																				'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and trim(pInput.fname) = 'ANGELA' and trim(pInput.lname) = 'FAROLE' and trim(pInput.mname) in ['','M'])
			//or 	// -- Bug:98757 - Experian Business Report Filing Numbers are Overlinking Oregon Companies				
			//	(	MDR.sourceTools.SourceIsEbr(pInput.source) and trim(pInput.vendor_id) = '809376459' and (regexfind('HEALTHCARE|HOSPITAL',trim(pInput.company_name,left,right),nocase) or (trim(pInput.lname) = 'MARCHETTI' and trim(pInput.fname) ='MARK')))
			or	// -- Bug:166661-Consumer Privacy Requesting PAW Record Removal for LexID 2281518533				
				( MDR.sourceTools.SourceIsDCA(pInput.source) and trim(pInput.vendor_id) = '1323416' and trim(pInput.lname) = 'SCHWARTZ' and trim(pInput.fname) ='DAVID' and pInput.phone = 4083742236)
			or	// -- Bug: 174042 - Remove Business Records for J. Vaziri per Privacy Programs Direction
				( pInput.did = 2603985162 or (trim(pInput.fname,left,right) = 'JENNIFER' and trim(pInput.lname) = 'VAZIRI' and trim(pInput.mname,left,right) in ['H','HOPE']))
			or	// -- Bug: 176631 - Business Header Suppression 
					// -- Bug: 197656 - Consumer Privacy Reports Incorrectly Linked PAW Record for Clayton
				(	MDR.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) in ['1671940052    C355405299','1817929485','1817929485    C61984972','1817929485    C35213276'])
			or	(MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'KIMBERLY' and trim(pInput.mname) = 'MICHELLE' and trim(pInput.lname) = 'CLAYTON' and trim(pInput.company_name) = 'GRADY HEALTH')
			or	// -- Bug: 183422 - Unlink Daniel A Davenport from this father Daniel S 
				(	trim(pInput.vendor_id) in ['8090947','NYMVO0458830691'] and trim(pInput.lname) = 'DAVENPORT') 
			or	// -- Bug: 194125 - Consumer Dispute
				( pInput.phone in [4042883458,4048636068] and trim(pInput.fname) = 'LINDA')
			or	// -- JIRA:DF-16735 Per Privacy Programs - Remove PETER KIRN records.
				//(	stringlib.stringfind(pInput.company_name, 'CAMELBACK GROUP', 1) > 0 and ((pInput.state = 'CO' and trim(pInput.city) in ['GREENWOOD VILLAGE','WINTER PARK','TABERNASH']) or pInput.company_phone=3039186563))
				(	regexfind('CAMELBACK GROUP|PETER KIRN|PETERKIRN',pInput.company_name, nocase) and trim(pInput.fname,left,right) = 'PETER' and trim(pInput.lname,left,right) = 'KIRN' and trim(pInput.mname,left,right) in ['A','ADAMS',''])
			or	(trim(pInput.fname,left,right) = 'PETER' and trim(pInput.lname,left,right) = 'KIRN' and trim(pInput.mname,left,right) in ['A','ADAMS',''] and pInput.state = 'CO')
			or // -- Bug: 203666/JIRA: DF-16118 - Remove Accurtrend Record for INSANE HYDROGRAPHIX LLC
				(	stringlib.stringfind(pInput.company_name, 'INSANE HYDROGRAPHIX', 1) > 0 and trim(pInput.fname) = 'BRYAN' and trim(pInput.lname) = 'MYERS')
			or // -- JIRA - DF-16328 Consumer Dispute - record must be suppressed/deleted
				(	stringlib.stringfind(pInput.company_name, 'NATIONAL IRANIAN AMERICAN', 1) > 0 and trim(pInput.fname) = 'BABAK' and trim(pInput.lname) = 'BAGHERI')
			or // -- JIRA - DF-17422, Consumer Advocacy Complaint - PAW Linking LexID - BDID 43998720 
			 	( mdr.sourceTools.SourceIsWorkmans_Comp(pInput.source) and regexfind('YELLOW TRANSPORTATION',pInput.company_name, nocase) and STD.Str.CleanSpaces(pInput.fname + pInput.lname) in ['BOBBY PHILLIPS','INC YELLOW'])
			or // -- JIRA - DF-17991 Consumer Dispute - record must be suppressed/deleted
				( mdr.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id) = '457217847     C6260365')
			or // -- JIRA - DF-18128 Consumer Advocacy - Unlink PAW Record for LexID 54872692 Amodeo
				( mdr.sourceTools.SourceIsBusiness_Registration(pInput.source) and regexfind('PATRICK M MCMATH LAW FIRM', pInput.company_name, nocase) and trim(pInput.fname) = 'JAMES' and trim(pInput.lname) = 'AMODEO' and trim(pInput.mname) = 'E')
			or // -- JIRA - DF-18344 Remove Business Contacts and PAW Record for LexID 13957703, Allene A Traphan
				( mdr.sourceTools.SourceIsTXBUS(pInput.source) and regexfind('ALLENE A TRAPHAN', pInput.company_name, nocase))
			or // -- JIRA - DF-18950 ZOOM records to be suppressed in PAW
				(	mdr.sourceTools.sourceIsZoom(pInput.source) and regexfind('1684933816', pInput.vendor_id, nocase))
			or // -- JIRA - DF-18955 PAW record to be supressed or deleted
				(	mdr.sourceTools.sourceIsZoom(pInput.source) and pInput.phone = 7173042300 and trim(pInput.fname) = 'LORI' and trim(pInput.lname) = 'RICH')
			or // -- JIRA - DF-19021 Consumer Advocacy - Removal of PAW/Business Contacts for Praveen Sengar
				(	pInput.phone = 5088728200 and trim(pInput.fname) = 'PRAVEEN' and trim(pInput.lname) = 'SENGAR')
			or // -- JIRA - DF-19020 Consumer Advocacy - Removal of PAW/Business Contacts for Sappington
				(	regexfind('LANDGUARD EAGLE', pInput.company_name, nocase) and trim(pInput.vendor_id) in ['DZXWM0058497187','17-LLC-02958317'] and trim(pInput.fname) = 'CASSANDRA' and trim(pInput.lname) = 'SAPPINGTON')
			or // -- JIRA - DF-18970 Remove all PAW/Business Contacts for LexID 724864388 at Las Vegas Address
				(	pInput.did = 724864388 or (trim(pInput.fname) = 'PASTORA' and trim(pInput.lname) = 'ROLDAN' and 
					((trim(pInput.prim_name) = 'EASTERN' and pInput.zip = 89123) or (trim(pInput.company_prim_name) = 'EASTERN' and pInput.company_zip = 89123))))
			or // -- JIRA - DF-18931 Cons. Adv. Report - Business Contacts Removal for LexID 829850667 Andra Flynn
				( trim(pInput.fname) = 'ANDREA' and trim(pInput.lname) = 'FLYNN' and regexfind('PC EXPRESS ENTERPRISES', trim(pInput.company_name), nocase))
			or // -- JIRA - DF-19165 Consumer Advocacy - Remove PAW/Business Contacts for LexID 1793247875
				(	mdr.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'BERNARD' and trim(pInput.lname) = 'THEIS' and regexfind('PAINE WEBER|PAYNE WEBER', pInput.company_name, nocase))
			or // -- JIRA - DF-19162 Remove PAW and Business Contact Records for LexID 1510111650
				(	pInput.did = 1510111650	or (trim(pInput.fname) in ['LEWIS','CHRIS','CHRISTOPHER'] and trim(pInput.lname) in ['LEWIS','RAND'] and trim(pInput.vendor_id) in ['RGXPY0536216046','01B7E3E6DE670600D8','4007701','IBTK 1 F     6X  P']))
			or // -- ZOOM vendor_id's will be filtered from Business contacts and PAW files as per bug tickets listed above.
				( mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) in Bad_zoom_vend_ids)
			or // -- JIRA DF-19767 Consumer Adv - Remove PAW record from LexID 2332177997 SICHERMAN
				( mdr.sourceTools.sourceIsDCA(pInput.source) and trim(pInput.vendor_id) in ['3205715'] and trim(pInput.lname) = 'SICHERMAN')
			or // -- JIRA - DF-19305 Experian Business Report has incorrect Officer Name of Jon C Dawson 
				( mdr.sourceTools.sourceIsEBR(pInput.source) and trim(pInput.vendor_id) in ['940772280'] and trim(pInput.lname) = 'DAWSON')
			or // -- JIRA - DF-20318 PAW Error for LexID 13959907050 - Consumer Advocacy
				(	mdr.sourceTools.sourceIsSpoke(pInput.source) and trim(pInput.lname) = 'JOHNSON' and trim(pInput.fname) in ['CHRISTOPHER','CHRIS'] and pInput.phone = 6123046073)
			or // -- JIRA - DF-20685 LexID 523271314 - Wrongly Appended PAW records - Consumer Advocacy.
			  ( mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.fname) = 'MICHAEL' and trim(pInput.lname) = 'COUTR' and trim(pInput.prim_name) = 'MAIN' and pInput.zip = 7503 and regexfind('ST. JOSEPH HEALTH SYSTEM', pInput.company_name, nocase))
			or // -- JIRA - DF-20795 - Consumer disputing association with a company
				( mdr.sourceTools.sourceIsEq_Employer(pInput.source) and (integer)pInput.company_phone = 3192333309)
			or // -- JIRA - DF-21961 - Consumer Adv. - PAW/Bus. Contacts Overlinking LexID 184656279
			  ( mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) = '2108024717    C90883103' and trim(pInput.prim_name) = 'PO BOX 6')
			or // -- JIRA - DF-21988 - Consumer Advocacy - Linking Dispute LexID 1533124325 - Mary Lloyd
				((mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) or mdr.sourceTools.sourceIsFBNV2_Hist_Choicepoint(pInput.source)) and trim(pInput.vendor_id) in ['CP3345616258597945683', '76327426'] and trim(pInput.fname) = 'MARY' and trim(pInput.lname) = 'LLOYD')
			or // -- JIRA - DF-22502/DF22524 - PA Corps contact addresses are skewed/Business Header/PAW - Bad PA Corps addresses
				( MDR.sourceTools.sourceIsPA_Corporations(pInput.source) and pInput.bdid = 4548595047 and trim(pInput.lname) = '')
			or // -- JIRA - DF-22852 - Consumer Dispute - Paw record to be removed
				( mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and pInput.bdid = 984406 and pInput.did = 402682961)
			or // -- JIRA - DF-22841 - Overlinking in PAW LexID 1224547541
				( mdr.sourceTools.sourceIsUT_Corporations(pInput.source) and trim(pInput.vendor_id) = '49-2039256')
			or // -- JIRA# DF-23181 - FCRA dispute Connection to Business in PAW (NOTE: Remove the filter after the build run)
				( MDR.sourceTools.sourceIsMA_Corporations(pInput.source) and trim(pInput.vendor_id) = '25-FW1GV5')
				;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 
			
			Layout_Business_Contact_Sequenced  	filterDNBAddressPhone(Layout_Business_Contact_Sequenced l) := 
			transform

				filterbug30999 						:=	l.company_fein in  setbadfeins;
				// JIRA - DF-21083 PAW Error for LexID 947738531, Heagerty - Consumer Advocacy 
				filter_DF21083 						:=	(l.company_phone	= 7707819312 or l.phone = 7707819312)
																			and regexfind('CONSUMER SOLUTIONS', l.company_name, nocase)
																			;
				// JIRA: LNK-563 - Consumer Advocacy - PAW Linking Questioned
				filterbugLNK563 					:= trimids(l.vendor_id) in ['12-552868'] 
																			and mdr.sourcetools.SourceIsFL_Corporations(l.source)
																			and trim(l.fname) = 'SHEILA' and trim(l.lname) = 'BORLAND'
																			and l.did = 2323167047
																			;
				self.prim_range						:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.prim_range						);
				self.predir								:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.predir								);
				self.prim_name						:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.prim_name						);
				self.addr_suffix					:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.addr_suffix					);
				self.postdir							:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.postdir							);
				self.unit_desig						:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.unit_desig						);
				self.sec_range						:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.sec_range						);
				self.zip									:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.zip									);
				self.zip4									:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.zip4									);
				self.county								:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.county								);
				self.msa									:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.msa									);
				self.geo_lat							:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_lat							);
				self.geo_long							:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_long							);
				self.company_prim_range		:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_prim_range		);
				self.company_predir				:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_predir				);
				self.company_prim_name		:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_prim_name		);
				self.company_addr_suffix	:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_addr_suffix	);
				self.company_postdir			:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_postdir			);
				self.company_unit_desig		:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_unit_desig		);
				self.company_sec_range		:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_sec_range		);
				self.company_zip					:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.company_zip					);
				self.company_zip4					:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.company_zip4					);
				self.phone								:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source) or filter_DF21083	,0	,l.phone								);
				self.company_phone				:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source) or filter_DF21083	,0	,l.company_phone				);
				self.rawaid								:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.rawaid								);
				self.company_rawaid				:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.company_rawaid				);
				self.company_fein					:=	if(filterbug30999,0	,l.company_fein						);
				self.did									:=	if(filterbugLNK563, 0, l.did);
				self.ssn									:=	if(filterbugLNK563, 0, l.ssn);
				self 											:= 	l;                     
			end;
		
			filterdnb :=  project(pInput(lFullFilter), filterDNBAddressPhone(left));
			
			///////////////////////////////////////////////////////////////////
			// -- Bug 25257 -- left only lookup join on pullssn on ssn and did
			///////////////////////////////////////////////////////////////////

			pullids := doxie.File_pullSSN;
			
			Layout_Business_Contact_Sequenced tremoverecords(Layout_Business_Contact_Sequenced l, pullids r) :=
			transform
				self := l;
			end;
			
			pulldids := join(filterdnb
											,pullids
											,left.did != 0 and left.did = (unsigned6)right.ssn
											,tremoverecords(left,right)
											,lookup
											,left only
											);
			
			pullssns := join(pulldids
											,pullids
											,left.ssn != 0 and left.ssn = (unsigned4)right.ssn
											,tremoverecords(left,right)
											,lookup
											,left only
											);
			
			return pullssns;
			
		end;
		
		filterRec := RECORD
			unsigned6 bdid1;
			unsigned6 bdid2;
		END; 
		bdidsToBeFiltered := DATASET ([
			{1873281985, 45236859},
			{1873281985, 1947852989},
			{1873281985, 1954159808},
			{1947802553, 45236859},
			{1947802553, 1947852989},
			{1947802553, 1954159808},
			{1954168479, 45236859},
			{1954168479, 1947852989},
			{1954168479, 1954159808},
			{107800659,	 113490609}, //*** Bug:95843 - Overlinking of Barbara Griffith with Southern California Pipeline
			{125686733,	 150732877}, //*** Bug:95843 - Overlinking of Barbara Griffith with Southern California Pipeline
			{69701262,   95194575}, 	//*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   105934715},  //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   167801849},  //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   545038389},  //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			{69701262,   1168297034}  //*** Bug:162910-Consumer Advocacy Reporting Business Overlinking in old Business Report
			], filterRec);
		
		export Business_Relatives(dataset(Layout_Business_Relative) pInput) :=
		function

			//filter out EBR only bdids from relatives file
			macFilterPassedBdids(pInput,					bdid1, QueryGetEBROnlyBdids, br_EBR_Filtered_1st_Pass);
			macFilterPassedBdids(br_EBR_Filtered_1st_Pass,	bdid2, QueryGetEBROnlyBdids, br_EBR_Filtered_2nd_Pass);

			//Filter out any overlinked bdids
			macFilterBdidRelations(br_EBR_Filtered_2nd_Pass, bdidsToBeFiltered, BDid_Filtered);
			
			return BDid_Filtered;
		
		end;
		
		export Business_Relatives_Group(dataset(Layout_Business_Relative_Group) pInput) :=
		function
			
			macFilterPassedBdids(pInput, bdid, QueryGetEBROnlyBdids, brg_Filtered);

			return brg_Filtered;

		end;
		
		export Business_Header_Best(dataset(Layout_Business_Header_Base) pInput) :=
		function

			lfilter		:= 		MDR.sourceTools.SourceIsEBR(pInput.source)
							or 	MDR.sourceTools.SourceIsExperianVehicle(pInput.source)	//set to false for no filter
							;
			lfullfilter := not(lfilter);
			
			Layout_Business_Header_Base  filterDNBAddressPhone(Layout_Business_Header_Base l) := 
			transform
				self.prim_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.prim_range		);
				self.predir				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.predir				);
				self.prim_name		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.prim_name		);
				self.addr_suffix	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.addr_suffix	);
				self.postdir			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.postdir			);
				self.unit_desig		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.unit_desig		);
				self.sec_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.sec_range		);
				self.zip					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.zip					);
				self.zip4					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.zip4					);
				self.county				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.county				);
				self.msa					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.msa					);
				self.geo_lat			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_lat			);
				self.geo_long			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_long			);
				self.phone				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.phone				);
				self.phone_score	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.phone_score	);
				self.rawaid				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.rawaid				);
				self 							:= l;                                              
			end;

			dfilter := project(pInput(lfullfilter), filterDNBAddressPhone(left));
			
			return dfilter;
			
		end;
		
		shared lbhb := 
		record
			Business_Header.Layout_BH_Best;
			qstring34 vendor_id
		end;
		
	
		export Business_Header_Stat(dataset(Layout_Business_Header_Stat) pInput) :=
		function
				
			macFilterPassedBdids(pInput, bdid, QueryGetEBROnlyBdids, bhs_Filtered);
			
			return bhs_Filtered;

		end;
		
	end;
	
	export MaxRcid(dataset(Layout_Business_Header_Base) pInput) :=
	function

			lfilterout		:= 	pInput.bdid	>= irs_dummy.bdid_cutoff;
			
			lfullfilter := not(lfilterout);
			
			return pInput(lfullfilter);
	
	end;

	export HeaderContacts(
		 dataset(header.Layout_Header_v2)	pInput
		,boolean													pFilterOut = true
	) :=
	function

			lselectfilter		:= 		pInput.jflag2 =		'A' 
												or	pInput.did		>=	irs_dummy.did_cutoff
												// Bug: #37728 - Remove MO Vehicles and DLs from business header and contacts			
												or	(			MDR.sourceTools.SourceIsMO_DL						(pInput.src)
															or	MDR.sourceTools.SourceIsMO_Veh					(pInput.src)
															or	MDR.sourceTools.SourceIsMO_Experian_Veh	(pInput.src)
														)
												// Bug: 43998 - remove sources on probation from header contacts
												or				MDR.sourceTools.SourceIsOnProbation			(pInput.src)
												;
			
			boolean lFullFilter 		:= if(pFilterOut
																		,not(lselectfilter)	//negate it 
																		,lselectfilter
																	);
			// -- Bug: 63323 - Address report returns error when address begins with percentage sign
			return project(pInput(lfullfilter)
							,transform(
							 header.Layout_Header_v2
							,self.prim_name := if(trim(left.prim_name,left,right)[1] = '%', 'C/O ' + trim(left.prim_name,left,right)[2..], left.prim_name);
							 self := left;
						));
	
	end;

	export EqContacts(
		 dataset(layout_eq_employer)	pInput
		,boolean											pIsTesting = false
	
	) :=
	function

			lfilterout		:= 		pInput.did	>= irs_dummy.did_cutoff
								;
								
			lfullfilter := not(lfilterout);
			// blank out senator's former employer because it is not correct
			layout_eq_employer  filterSenator(layout_eq_employer l) := 
			transform
				boolean shouldblankrec := 		l.ssn  								=  '158521050' 
																	and regexfind('SOUTH OAK HOSPITAL', l.occupation_employer,nocase);
											
			// -- Bug: 63323 - Address report returns error when address begins with percentage sign
				self.prim_name := if(trim(l.prim_name,left,right)[1] = '%', 'C/O ' + trim(l.prim_name,left,right)[2..], l.prim_name);
				self.occupation_employer	:= if(shouldblankrec	,''	,l.occupation_employer);
				self 							:= l;                     
			end;
			
			return project(pInput(lFullFilter), filterSenator(left));
	
	end;

	export PhonesPlusContacts(dataset(Phonesplus.layoutCommonOut) pInput) :=
	function

			lfilterout		:= 	pInput.did	>= irs_dummy.did_cutoff;
			
			lfullfilter := not(lfilterout);
			
			// -- Bug: 63323 - Address report returns error when address begins with percentage sign
			return project(pInput(lfullfilter)
							,transform(
							 Phonesplus.layoutCommonOut
							,self.prim_name := if(trim(left.prim_name,left,right)[1] = '%', 'C/O ' + trim(left.prim_name,left,right)[2..], left.prim_name);
							 self := left;
						));
	
	end;
	
	export BCExtra(dataset(Layout_Business_Contacts_Temp) pInput) :=
	function

			lfilterout		:= 	false;
			
			lfullfilter := not(lfilterout);
			
			// -- Bug: 63323 - Address report returns error when address begins with percentage sign
			return project(pInput(lfullfilter)
							,transform(
							 Layout_Business_Contacts_Temp
							,self.prim_name					:= if(trim(left.prim_name					,left,right)[1] = '%', 'C/O ' + trim(left.prim_name					,left,right)[2..], left.prim_name					);
							 self.company_prim_name := if(trim(left.company_prim_name	,left,right)[1] = '%', 'C/O ' + trim(left.company_prim_name	,left,right)[2..], left.company_prim_name	);
							 self := left;
						));
	
	end;

	export Keys :=
	module

		export Business_Headers(dataset(Layout_Business_Header_Base) pInput) :=
		function

			lfilter		:= false;	//set to false for no filter
			
			lfullfilter := not(lfilter);
			
			Layout_Business_Header_Base tblankoutbadfeins(Layout_Business_Header_Base l) :=
			transform
				
				filterbug30999 :=		l.fein			in  setbadfeins
												;
				
				self.fein					:= if(filterbug30999,0	,l.fein						);
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutbadfeins(left));

		end;

		export Business_Headers_keybuild(dataset(Layout_Business_Header_Base_Plus) pInput) :=
		function

			lfilter		:= false;	//set to false for no filter
			
			lfullfilter := not(lfilter);
			
			Layout_Business_Header_Base_Plus tblankoutbadfeins(Layout_Business_Header_Base_Plus l) :=
			transform
				
				filterbug30999 :=		l.fein			in  setbadfeins
												;
				
				self.fein					:= if(filterbug30999,0	,l.fein						);
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutbadfeins(left));

		end;

		export Business_Headers_temp(dataset(Layout_Business_Header_temp) pInput) :=
		function

			lfilter		:= false;	//set to false for no filter
			
			lfullfilter := not(lfilter);
			
			Layout_Business_Header_temp tblankoutbadfeins(Layout_Business_Header_temp l) :=
			transform
				
				filterbug30999 :=		l.fein			in  setbadfeins
												;
				
				self.fein					:= if(filterbug30999,0	,l.fein						);
				self.phone				:= (unsigned6)header.fn_blank_bogus_phones((string)l.phone);
				self							:= l																							;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutbadfeins(left));

		end;

		export Business_Contacts(dataset(Layout_Business_Contact_Plus) pInput) :=
		function

			boolean lAdditionalFilter	:=
						MDR.sourceTools.SourceIsZoom(pInput.source) // filter out zoom records
			or			
			(			MDR.sourceTools.SourceIsDunn_Bradstreet(pInput.source)	 // filter out DNB records
			)
			or
				(		(unsigned8)pInput.did			= 1363114130
				 and	(unsigned8)pInput.bdid			= 14733991
				)
			;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 

			Layout_Business_Contact_Plus tblankoutbadfeins(Layout_Business_Contact_Plus l) :=
			transform
				
				filterbug30999 :=		l.company_fein			in  setbadfeins
												;
				
				self.company_fein	:= if(filterbug30999,0	,l.company_fein						);
				self.ssn					:= if(IsValidSsn(l.ssn)	,l.ssn	,0							);
				self							:= l																							;                              
			end;
			
			dproject := project(pInput(lFullFilter), tblankoutbadfeins(left));
			
			ut.mac_suppress_by_phonetype(dproject,phone,state,dsuppressWACellPhones,true,did);	
			
			return dsuppressWACellPhones;

		end;
		
		export PeopleAtWork(dataset(paw.layout.Employment_Out) pInput) := 
		function
			boolean lAdditionalFilter	:= 
					// -- Bug: 184195 - DNB DMI Needs Removed from PAW	
				(		MDR.sourceTools.SourceIsDunn_Bradstreet(pInput.source)) 
			or
				(		MDR.sourceTools.SourceIsEBR(pInput.source))
			or // -- Bug:  - Flush the Jigsaw records as per Jason.
				(	MDR.sourceTools.SourceIsJigsaw(pInput.source))
			or
				(		(unsigned8)pInput.did			= 1363114130
				 and	(unsigned8)pInput.bdid			= 14733991
				)				
			or	// -- Bug: 103804 - Questionable Company Names.
				(		(unsigned8)pInput.bdid 	= 2736997388)
			or	// -- Bug: 145649 - Accurint 52354 - PAW Overlinking of LexID 2715613629 D. Williams
					// -- Bug: 191918/JIRA: DF-14772 - Consumer Privacy Reports Incorrectly Linked PAW Record
				(	MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) in ['1542124062','731821740','731821740C20895717','645546729     C352857954'])
			or	// -- Bug: 98386 - Robert Spencer and Virginia Union University
				(		MDR.sourceTools.SourceIsZoom(pInput.source) 
					and pInput.bdid 						= 3564212 
					and pInput.did  						= 2405720103
				)
			or	// -- Bug: 107265 - Remove Person Contacts from BDID 2607452175 Asian Massage
				(		MDR.sourceTools.SourceIsFBNV2_Experian_Direct(pInput.source) 
				 and pInput.bdid = 2607452175 
				 and (pInput.did in [3543987503, 456312873, 1123277952] or trim(pInput.lname,left,right) = 'DAVIS-CONEY')
				)
			or	// -- Bug: 107798 - Remove two Business Header records with wrong source codes.
				(		MDR.sourceTools.SourceIsAK_Corporations(pInput.source) 
					and pInput.bdid in [4994780, 412358992, 16952458])
			or	// -- Bug: 87127 - Overlinking of business contacts due to errorneous CP FBN Filing.
					// -- Bug: 115130 - Unlink DID for Michael Hild from Serenity Home Care Agency
					// -- Bug: 120900 - Remove FBN Record from Business Header & Contacts for Al-Jarafi 
				(		MDR.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) 
					and trim(pInput.vendor_id,left,right) in ['CP9627346981847888151','CP219395185453452160','CP11910987965939266948'])							
			or  // -- Bug: 109269 - Remove 4 Employment Locator records for David Scott Tronson.
				(		MDR.sourceTools.SourceIsEq_Employer(pInput.source) 
					and pInput.DID = 2562729144 and pInput.bdid = 2988148887)
			or	// -- Bug: 113227 - Business Header contains errorneous Corporation record.
				(		MDR.sourceTools.SourceIsCA_Corporations(pInput.source) 
					and trim(pInput.vendor_id,left,right) = '06-01620279' and trim(pInput.city) = 'CULVER CITY')
			or	// -- Bug: 105072 - Tina Gutierrez is Overlinked to Rackspace LTD.
				(  pInput.bdid = 1936130951 and pInput.did = 408918097)
			or	// -- Bug: 110922 - Remove TMSID from Business Header, Contacts and PAW for Steve Dixon
				(		pInput.bdid = 776748497 and pInput.did = 660077201)
			or  // -- Bug: 106251 - Overlinking of Business Contacts to Michael McGovern
				(		pInput.bdid in [3596011, 558650599] and pInput.did = 1671671138)
			or  // -- Bug:121240 -Hewlett Packard Bus Search Result on Portal returns D&B Report
				(		(MDR.sourceTools.SourceIsAZ_Corporations(pInput.source) or 
						 MDR.sourceTools.SourceIsUCCV2(pInput.source)) and pInput.vendor_id in ['04-F08167145','DNB000173979719961223'])
			or	// -- Bug: 125332 - People at Work Suppression
			  (		MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'DELORES' and trim(pInput.lname) = 'PARKER' and trim(pInput.mname)='DIANE' and 
							trim(pInput.company_name) in ['MAPLEHURST REALTY INC','MAPLEHURST'])
			or	// -- Bug: 119446 - Remove Zoom Records for LexID 1234490932 Tahir Javed 
				(		MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.company_name) in ['OMAHA WORLD-HERALD COMPANY','OMAHA WORLD-HERALD'] and trim(pInput.fname) = 'TAHIR' and trim(pInput.lname) = 'JAVED')
			//or  // -- Bug: 119049 - Unlink Bradley Leighty from BOA Auto Sales
			//	(		(mdr.sourceTools.SourceIsDunn_Bradstreet(pInput.source) or mdr.sourceTools.SourceIsEBR(pInput.source)) and 
			//				trim(pInput.vendor_id,left,right) in ['D092297238-BOA AUTO SALES INC','738365619'] and trim(pInput.fname) = 'BRADLEY' and trim(pInput.lname) = 'LEIGHTY')
			or	// -- Bug: 131131 - Business Contact Information for Opt Out Consumer-Rush Request
				( trim(pInput.company_name,left,right) in ['BAKER & MCKENZIE LLP','JACKSON DEV & CONSTRUCTION INC','MEDIA CENTER PC',
																									 'NATIONAL COLLEGE FOR DUI DEFENSE , INC.','OPPENHEIMER WOLFF DONNELLY LLP',
																									 'SOUTH COAST LITIGATION GROUP','THE NATIONAL COLLEGE FOR DUI DEFENSE , INC.','UNIVERSITY OF PENNSYLVANIA'] and trim(pInput.fname) = 'VANIA' and trim(pInput.lname) = 'CHAKER')
			or	// -- Bug: 139082 - Remove Ana Lane Gomez from FBN, Business Header and PAW files
				(	MDR.sourceTools.SourceIsFBNV2_Experian_Direct(pInput.source) and trim(pInput.vendor_id) = 'EXP6160690673128140760')
			or	// -- Bug:146861 - Remove All Business Records Associate with DAVID & SHALA PEYMAN  -- Bug:153300 - Remove Lexid 113261977728 for Peyman Shalah
				(	trim(pInput.lname) = 'PEYMAN' and trim(pInput.fname) in ['DAVID','SHALA','SHAHLA','SHALAH'])
			or	// -- Bug:146862 - These corp keys need to be filtered out of all base files
				(	MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vendor_id,left,right) in ['06-03155932', '06-200820510058', '06-200620910099'])
			or 	// -- Bug: 157298  - Remove Contact Angela Farole from BDID 53982819 Avante Abstract Inc.
				(	trim(pInput.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																				'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and trim(pInput.fname) = 'ANGELA' and trim(pInput.lname) = 'FAROLE' and trim(pInput.mname) in ['','M'])
			//or 	// -- Bug:98757 - Experian Business Report Filing Numbers are Overlinking Oregon Companies				
			//	(	MDR.sourceTools.SourceIsEbr(pInput.source) and trim(pInput.vendor_id) = '809376459' and (regexfind('HEALTHCARE|HOSPITAL',trim(pInput.company_name,left,right),nocase) or (trim(pInput.lname) = 'MARCHETTI' and trim(pInput.fname) ='MARK')))
			or	// -- Bug:166661-Consumer Privacy Requesting PAW Record Removal for LexID 2281518533				
				( MDR.sourceTools.SourceIsDCA(pInput.source) and trim(pInput.vendor_id) = '1323416' and trim(pInput.lname) = 'SCHWARTZ' and trim(pInput.fname) ='DAVID' and trim(pInput.phone) = '4083742236')
			or	// -- Bug: 174042 - Remove Business Records for J. Vaziri per Privacy Programs Direction
				( pInput.did = 2603985162 or (trim(pInput.fname,left,right) = 'JENNIFER' and trim(pInput.lname) = 'VAZIRI' and trim(pInput.mname,left,right) in ['H','HOPE']))
			or	// -- Bug: 176631 - Business Header Suppression 
					// -- Bug: 197656 - Consumer Privacy Reports Incorrectly Linked PAW Record for Clayton
				(	MDR.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) in ['1671940052    C355405299','1817929485','1817929485    C61984972','1817929485    C35213276'])
			or	(MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'KIMBERLY' and trim(pInput.mname) = 'MICHELLE' and trim(pInput.lname) = 'CLAYTON' and trim(pInput.company_name) = 'GRADY HEALTH')
			or	// -- Bug: 183422 - Unlink Daniel A Davenport from this father Daniel S 
				(	trim(pInput.vendor_id) in ['8090947','NYMVO0458830691'] and trim(pInput.lname) = 'DAVENPORT')
			or	// -- Bug: 194125 - Consumer Dispute
				( trim(pInput.phone) in ['4042883458','4048636068'] and trim(pInput.fname) = 'LINDA')
			or	// -- JIRA:DF-16735 Per Privacy Programs - Remove PETER KIRN records.
				//(	stringlib.stringfind(pInput.company_name, 'CAMELBACK GROUP', 1) > 0 and ((pInput.state = 'CO' and trim(pInput.city) in ['GREENWOOD VILLAGE','WINTER PARK','TABERNASH']) or (trim(pInput.company_phone) in ['3039186563','8702926547'] or trim(pInput.phone) in ['3039186563','8702926547'])))
				(	regexfind('CAMELBACK GROUP|PETER KIRN|PETERKIRN',pInput.company_name, nocase) and trim(pInput.fname,left,right) = 'PETER' and trim(pInput.lname,left,right) = 'KIRN' and trim(pInput.mname,left,right) in ['A','ADAMS',''])
			or	(trim(pInput.fname,left,right) = 'PETER' and trim(pInput.lname,left,right) = 'KIRN' and trim(pInput.mname,left,right) in ['A','ADAMS',''] and pInput.state = 'CO')
			or // -- Bug: 203666/JIRA: DF-16118 - Remove Accurtrend Record for INSANE HYDROGRAPHIX LLC
				(	stringlib.stringfind(pInput.company_name, 'INSANE HYDROGRAPHIX', 1) > 0 and trim(pInput.fname) = 'BRYAN' and trim(pInput.lname) = 'MYERS')
			or // -- JIRA - DF-16328 Consumer Dispute - record must be suppressed/deleted
				(	stringlib.stringfind(pInput.company_name, 'NATIONAL IRANIAN AMERICAN', 1) > 0 and trim(pInput.fname) = 'BABAK' and trim(pInput.lname) = 'BAGHERI')
			or // -- JIRA - DF-17422, Consumer Advocacy Complaint - PAW Linking LexID - BDID 43998720 
			 	( mdr.sourceTools.SourceIsWorkmans_Comp(pInput.source) and regexfind('YELLOW TRANSPORTATION',pInput.company_name, nocase) and STD.Str.CleanSpaces(pInput.fname + pInput.lname) in ['BOBBY PHILLIPS','INC YELLOW'])
			or // -- JIRA - DF-17991 Consumer Dispute - record must be suppressed/deleted
				( mdr.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id) = '457217847     C6260365')
			or // -- JIRA - DF-18128 Consumer Advocacy - Unlink PAW Record for LexID 54872692 Amodeo
				( mdr.sourceTools.SourceIsBusiness_Registration(pInput.source) and regexfind('PATRICK M MCMATH LAW FIRM', pInput.company_name, nocase) and trim(pInput.fname) = 'JAMES' and trim(pInput.lname) = 'AMODEO' and trim(pInput.mname) = 'E')
			or // -- JIRA - DF-18344 Remove Business Contacts and PAW Record for LexID 13957703, Allene A Traphan
				( mdr.sourceTools.SourceIsTXBUS(pInput.source) and regexfind('ALLENE A TRAPHAN', pInput.company_name, nocase))
			or // -- JIRA - DF-18950 ZOOM records to be suppressed in PAW
				(	mdr.sourceTools.sourceIsZoom(pInput.source) and regexfind('1684933816', pInput.vendor_id, nocase))
			or // -- JIRA - DF-18955 PAW record to be supressed or deleted
				(	mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.phone) = '7173042300' and trim(pInput.fname) = 'LORI' and trim(pInput.lname) = 'RICH')
			or // -- JIRA - DF-19021 Consumer Advocacy - Removal of PAW/Business Contacts for Praveen Sengar
				(	trim(pInput.phone) = '5088728200' and trim(pInput.fname) = 'PRAVEEN' and trim(pInput.lname) = 'SENGAR')
			or // -- JIRA - DF-19020 Consumer Advocacy - Removal of PAW/Business Contacts for Sappington
				(	regexfind('LANDGUARD EAGLE', pInput.company_name, nocase) and trim(pInput.vendor_id) in ['DZXWM0058497187','17-LLC-02958317'] and trim(pInput.fname) = 'CASSANDRA' and trim(pInput.lname) = 'SAPPINGTON')
			or // -- JIRA - DF-18970 Remove all PAW/Business Contacts for LexID 724864388 at Las Vegas Address
				(	pInput.did = 724864388 or (trim(pInput.fname) = 'PASTORA' and trim(pInput.lname) = 'ROLDAN' and 
					((trim(pInput.prim_name) = 'EASTERN' and trim(pInput.zip) = '89123') or (trim(pInput.company_prim_name) = 'EASTERN' and trim(pInput.company_zip) = '89123'))))
			or // -- JIRA - DF-18931 Cons. Adv. Report - Business Contacts Removal for LexID 829850667 Andra Flynn
				( trim(pInput.fname) = 'ANDREA' and trim(pInput.lname) = 'FLYNN' and regexfind('PC EXPRESS ENTERPRISES', trim(pInput.company_name), nocase))
			or // -- JIRA - DF-19165 Consumer Advocacy - Remove PAW/Business Contacts for LexID 1793247875
				(	mdr.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'BERNARD' and trim(pInput.lname) = 'THEIS' and regexfind('PAINE WEBER|PAYNE WEBER', pInput.company_name, nocase))
			or // -- JIRA - DF-19162 Remove PAW and Business Contact Records for LexID 1510111650
				(	pInput.did = 1510111650	or (trim(pInput.fname) in ['LEWIS','CHRIS','CHRISTOPHER'] and trim(pInput.lname) in ['LEWIS','RAND'] and trim(pInput.vendor_id) in ['RGXPY0536216046','01B7E3E6DE670600D8','4007701','IBTK 1 F     6X  P']))
			or // -- ZOOM vendor_id's will be filtered from Business contacts and PAW files as per bug tickets listed above.
				( mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) in Bad_zoom_vend_ids)
			or // -- JIRA DF-19767 Consumer Adv - Remove PAW record from LexID 2332177997 SICHERMAN
				( mdr.sourceTools.sourceIsDCA(pInput.source) and trim(pInput.vendor_id) in ['3205715'] and trim(pInput.lname) = 'SICHERMAN')
			or // -- JIRA - DF-19305 Experian Business Report has incorrect Officer Name of Jon C Dawson 
				( mdr.sourceTools.sourceIsEBR(pInput.source) and trim(pInput.vendor_id) in ['940772280'] and trim(pInput.lname) = 'DAWSON')
			or // -- JIRA - DF-20318 PAW Error for LexID 13959907050 - Consumer Advocacy
				(	mdr.sourceTools.sourceIsSpoke(pInput.source) and trim(pInput.lname) = 'JOHNSON' and trim(pInput.fname) in ['CHRISTOPHER','CHRIS'] and trim(pInput.phone) = '6123046073')
			or // -- JIRA - DF-20685 LexID 523271314 - Wrongly Appended PAW records - Consumer Advocacy.
			  ( mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.fname) = 'MICHAEL' and trim(pInput.lname) = 'COUTR' and trim(pInput.prim_name) = 'MAIN' and pInput.zip = '07503' and regexfind('ST. JOSEPH HEALTH SYSTEM', pInput.company_name, nocase))
			or // -- JIRA - DF-20795 - Consumer disputing association with a company
				( mdr.sourceTools.sourceIsEq_Employer(pInput.source) and (integer)pInput.company_phone = 3192333309)
			or // -- JIRA - DF-21961 - Consumer Adv. - PAW/Bus. Contacts Overlinking LexID 184656279
			  ( mdr.sourceTools.sourceIsZoom(pInput.source) and trim(pInput.vendor_id) = '2108024717    C90883103' and trim(pInput.prim_name) = 'PO BOX 6')
			or // -- JIRA - DF-21988 - Consumer Advocacy - Linking Dispute LexID 1533124325 - Mary Lloyd
				((mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) or mdr.sourceTools.sourceIsFBNV2_Hist_Choicepoint(pInput.source)) and trim(pInput.vendor_id) in ['CP3345616258597945683', '76327426'] and trim(pInput.fname) = 'MARY' and trim(pInput.lname) = 'LLOYD')
			or // -- JIRA - DF-22502/DF22524 - PA Corps contact addresses are skewed/Business Header/PAW - Bad PA Corps addresses
				( MDR.sourceTools.sourceIsPA_Corporations(pInput.source) and pInput.bdid = 4548595047 and trim(pInput.lname) = '')
			or // -- JIRA - DF-22852 - Consumer Dispute - Paw record to be removed
				( mdr.sourceTools.sourceIsBusiness_Registration(pInput.source) and pInput.bdid = 984406 and pInput.did = 402682961)
			or // -- JIRA - DF-22841 - Overlinking in PAW LexID 1224547541
				( mdr.sourceTools.sourceIsUT_Corporations(pInput.source) and trim(pInput.vendor_id) = '49-2039256')
			or // -- JIRA# DF-23181 - FCRA dispute Connection to Business in PAW (NOTE: Remove the filter after the build run)
				( MDR.sourceTools.sourceIsMA_Corporations(pInput.source) and trim(pInput.vendor_id) = '25-FW1GV5')
				;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 
			
			paw.layout.Employment_Out  filterDNBAddressPhone(paw.layout.Employment_Out l) := 
			transform
				// JIRA - DF-21083 PAW Error for LexID 947738531, Heagerty - Consumer Advocacy 
				filter_DF21083 						:= ((unsigned)l.company_phone	= 7707819312 or (unsigned)l.phone = 7707819312)
																			and regexfind('CONSUMER SOLUTIONS', l.company_name, nocase)
																			;
				// JIRA: LNK-563 - Consumer Advocacy - PAW Linking Questioned
				filterbugLNK563 					:= trimids(l.vendor_id) in ['12-552868'] 
																			and mdr.sourcetools.SourceIsFL_Corporations(l.source)
																			and trim(l.fname) = 'SHEILA' and trim(l.lname) = 'BORLAND'
																			and l.did = 2323167047
																			;
				self.prim_range						:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.prim_range						);
				self.predir								:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.predir								);
				self.prim_name						:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.prim_name						);
				self.addr_suffix					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.addr_suffix					);
				self.postdir							:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.postdir							);
				self.unit_desig						:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.unit_desig						);
				self.sec_range						:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.sec_range						);
				self.zip									:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.zip									);
				self.zip4									:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.zip4									);
				self.county								:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.county								);
				self.msa									:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.msa									);
				self.geo_lat							:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_lat							);
				self.geo_long							:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_long							);
				self.company_prim_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_prim_range		);
				self.company_predir				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_predir				);
				self.company_prim_name		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_prim_name		);
				self.company_addr_suffix	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_addr_suffix	);
				self.company_postdir			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_postdir			);
				self.company_unit_desig		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_unit_desig		);
				self.company_sec_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_sec_range		);
				self.company_zip					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_zip					);
				self.company_zip4					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_zip4					);
				self.rawaid								:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.rawaid								);
				self.company_rawaid				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.company_rawaid				);
				self.phone								:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	or filter_DF21083,''	,l.phone								);
				self.company_phone				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	or filter_DF21083,''	,l.company_phone				);
				self.did									:= if(filterbugLNK563, 0, l.did);
				self.ssn									:= if(filterbugLNK563, '', l.ssn);
				self 											:= l;                                              
			end;
			
			return project(pInput(lFullFilter), filterDNBAddressPhone(left));
			
		end;

	end;

	export BHBDIDSIC(
	
		 dataset(business_header.Layout_SIC_Code_Internal	) pInput
		,dataset(corp2.Layout_Corporate_Direct_Corp_Base	)	pInactiveCorps = paw.fCorpInactives()
		,string																							pBhVersion		 = 'qa'
	
	) :=
	function
		
		//first get bdids from business header with the offending address
		bh := files(pBhVersion,flags.IsTesting).base.business_headers.new(
			
			//for bug 26195
			(
					prim_name 	= 'EAST WEST'
			and prim_range	= '4400'
			and city				= 'BETHESDA'
			and state				= 'MD'
			)
			
			//for bug 26883
			or
			(
					prim_name 	= '17TH'
			and prim_range	= '1050'
			and postdir			= 'NW'
			and city				= 'WASHINGTON'
			and state				= 'DC'
			)
			//for bug 33776
			or
			(
					prim_name 	= 'GREENWOOD'
			and prim_range	= '4230'
			and city				= 'CHICAGO'
			and state				= 'IL'
			)
			//for bug 36390
			or
			(
					prim_name 	= 'PICARDY'
			and prim_range	= '7525'
			and city				= 'BATON ROUGE'
			and state				= 'LA'
			)
			//for bug 41387
			or
			(
					prim_name 	= 'NEW HAMPSHIRE'
			and prim_range	= '1330'
			and city				= 'WASHINGTON'
			and state				= 'DC'
			)
			//for jira# DF-22823 - HRI SIC code issue for one of address record with wrong sicode of 4311 that came from BusReg.
			or
			(
					prim_name 	= 'WINTER SONG' 
			and prim_range	= '2805'
			and city				= 'RALEIGH'
			and state				= 'NC'
			)
		);

//1330 New Hampshire Avenue NW, Washington DC 20036
//4230 S. Greenwood Ave, Chicago, IL 60653-
//3016		

		bh_table	:= table(bh, {bdid}, bdid, few);
		bh_set 		:= set(bh_table, bdid);
		
		//then select those bdids from the sic code input file that are psychiatric hospitals(sic code 8063)
		//and match one of the bdids for that address

		lfilterout		:=	(	 		pInput.sic_code[1..4] = 	'8063'	//psychiatric hospital
												or	pInput.sic_code[1..4] = 	'8051'	//skilled nursing care facility
												or	pInput.sic_code[1..4] = 	'4311'	//US Postal Service	
											 )
											 and pInput.bdid in bh_set;
			
		lfullfilter := not(lfilterout);
		
		dInactiveCorpBdids := table(pInactiveCorps, {bdid}, bdid);
		
		//remove inactive corp bdids
		dFilteredSics := join(
			 distribute(pInput(lfullfilter), bdid)
			,distribute(dInactiveCorpBdids, bdid)
			,left.bdid = right.bdid
			,transform(Layout_SIC_Code_Internal, self := left)
			,local
			,left only
		);

		return dFilteredSics;
	
	end;

end;