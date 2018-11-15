import header, phonesplus, irs_Dummy, doxie, ut, PAW, corp2,mdr;

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
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) = '1542124062')
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
																	,filterbug25304 or filterbug71237 => 0					
																	,phone				
																);
				self.company_name := scrubcompanyname(l.company_name);
				self.fein					:= if(filterbug42740,0						,l.fein						);
	
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
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) = '1542124062')
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
				or	(MDR.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vendor_id,left,right) in ['CP9627346981847888151','CP219395185453452160'])
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

				phone 				:= (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.phone));  // Zero the phone if more than 10-digits
				company_phone := (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.company_phone));  // Zero the companyphone if more than 10-digits
				
				self.phone					:= map(	 (filterbug25304 and l.phone = 2127938763)				
																		or filterbug71237 => 0					
																	,phone				
																);
				self.company_phone	:= map(	 (filterbug25304 and l.company_phone = 2127938763)
																		or filterbug71237 => 0					
																	,company_phone				
																);
				// -- Bug: 63323 - Address report returns error when address begins with percentage sign
				prim_name					:= if(trim(l.prim_name				,left,right)[1] = '%', 'C/O ' + trim(l.prim_name				,left,right)[2..], l.prim_name				);
				company_prim_name := if(trim(l.company_prim_name,left,right)[1] = '%', 'C/O ' + trim(l.company_prim_name,left,right)[2..], l.company_prim_name);

				self.prim_name					:= prim_name				;
				self.company_prim_name	:= company_prim_name;
				self.company_name := scrubcompanyname(l.company_name);
				self.company_fein	:= if(filterbug42740,0						,l.company_fein						);
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
				(		MDR.sourceTools.SourceIsCorpV2(pInput.source)
				 and	trim(pInput.prim_name)	= 	''
				 and	pInput.zip				= 	0
				)

				///////////////////////////////////////////////////////////////////
				// -- Corporations records with certain bad names
				///////////////////////////////////////////////////////////////////
			or	(		pInput.company_name		in [ 'X'
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
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) = '1542124062')
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
																	,filterbug25304 or filterbug71237 => 0					
																	,phone				
																);
				self.company_name := scrubcompanyname(l.company_name);
				self.fein					:= if(filterbug42740,0						,l.fein						);
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
			or (		MDR.sourceTools.SourceIsCorpV2(pInput.source)
				 and	trim(pInput.company_prim_name)	= 	''
				 and	pInput.company_zip				= 	0
				)

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
				or	(MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) = '1542124062')
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
				or	(MDR.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vendor_id,left,right) in ['CP9627346981847888151','CP219395185453452160'])
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
				
				phone 				:= (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.phone));  // Zero the phone if more than 10-digits
				company_phone := (unsigned6)ut.CleanPhone(header.fn_blank_bogus_phones((string)l.company_phone));  // Zero the companyphone if more than 10-digits
				
				// -- Bug: 63323 - Address report returns error when address begins with percentage sign
				prim_name					:= if(trim(l.prim_name				,left,right)[1] = '%', 'C/O ' + trim(l.prim_name				,left,right)[2..], l.prim_name				);
				company_prim_name := if(trim(l.company_prim_name,left,right)[1] = '%', 'C/O ' + trim(l.company_prim_name,left,right)[2..], l.company_prim_name);

				self.prim_name					:= prim_name				;
				self.company_prim_name	:= company_prim_name;
				self.phone					:= map(	 (filterbug25304 and l.phone = 2127938763)				
																		or filterbug71237 => 0					
																	,phone				
																);
				self.company_phone	:= map(	 (filterbug25304 and l.company_phone = 2127938763)
																		or filterbug71237 or filterbug36622 => 0					
																	,company_phone				
																);

				self.company_name 				:= scrubcompanyname(l.company_name);
				self.company_fein					:= if(filterbug42740,0						,l.company_fein						);
				self.vendor_id						:= if(blankbug48348,'',trimids(l.vendor_id));
				self.company_source_group	:= trimids(l.company_source_group);
				self.DID									:= if(filterbug30402, 0, l.did);
				self.ssn									:= if(filterbug30402, 0, l.ssn);
				//for bug 30494 & 30519.  20080424
				self.dt_first_seen				:= (unsigned4)validatedate((string8)l.dt_first_seen						,if(length(trim((string8)l.dt_first_seen						)) = 8,0,1));
				self.dt_last_seen					:= (unsigned4)validatedate((string8)l.dt_last_seen						,if(length(trim((string8)l.dt_last_seen							)) = 8,0,1));
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
													(		pInput.bdid						= 616279283	);

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
				
				self.DID									:= if(filterbug30402, 0, l.did)	;
				self.ssn									:= if(filterbug30402, 0, l.ssn)	;
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
			{107800659,	 113490609}, //*** Bug:95843 - Overlinking of Barbara Griffith with Southern California Pipeline
			{125686733,	 150732877},  //*** Bug:95843 - Overlinking of Barbara Griffith with Southern California Pipeline
			{29095389,   32032819}
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
				(		MDR.sourceTools.SourceIsEBR(pInput.source)) 
			or
				(		pInput.did						= 1363114130
				 and	pInput.bdid						= 14733991
				)
			or	// -- Bug: 103804 - Questionable Company Names.
				(		pInput.bdid 				= 2736997388
				 or (MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.vendor_id,left,right) = '1542124062')
				)			
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
				(		mdr.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) and trim(pInput.vendor_id,left,right) = 'CP219395185453452160')
			or  // -- Bug:121240 -Hewlett Packard Bus Search Result on Portal returns D&B Report
				(		(MDR.sourceTools.SourceIsAZ_Corporations(pInput.source) or MDR.sourceTools.SourceIsUCCV2(pInput.source)) and pInput.vendor_id in ['04-F08167145','DNB000173979719961223'])
			or	// -- Bug: 125332 - People at Work Suppression
			  (		MDR.sourceTools.SourceIsEq_Employer(pInput.source) and trim(pInput.fname) = 'DELORES' and trim(pInput.lname) = 'PARKER' and trim(pInput.mname)='DIANE' and 
							trim(pInput.company_name) in ['MAPLEHURST REALTY INC','MAPLEHURST'])
			or	// -- Bug: 119446 - Remove Zoom Records for LexID 1234490932 Tahir Javed 
				(		MDR.sourceTools.SourceIsZoom(pInput.source) and trim(pInput.company_name) in ['OMAHA WORLD-HERALD COMPANY','OMAHA WORLD-HERALD'] and trim(pInput.fname) = 'TAHIR' and trim(pInput.lname) = 'JAVED')
				;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 
			
			Layout_Business_Contact_Sequenced  	filterDNBAddressPhone(Layout_Business_Contact_Sequenced l) := 
			transform

				filterbug30999 						:=	l.company_fein in  setbadfeins;
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
				self.phone								:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.phone								);
				self.company_phone				:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.company_phone				);
				self.rawaid								:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.rawaid								);
				self.company_rawaid				:= 	if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.company_rawaid				);
				self.company_fein					:= 	if(filterbug30999,0	,l.company_fein						);
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
			{125686733,	 150732877}  //*** Bug:95843 - Overlinking of Barbara Griffith with Southern California Pipeline
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
				(		MDR.sourceTools.SourceIsEBR(pInput.source)) 
			or
				(		(unsigned8)pInput.did			= 1363114130
				 and	(unsigned8)pInput.bdid			= 14733991
				)				
			or	// -- Bug: 103804 - Questionable Company Names.
				(		(unsigned8)pInput.bdid 	= 2736997388
				)
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
				(		MDR.sourceTools.SourceIsFBNV2_Hist_Choicepoint(pInput.source) 
					and trim(pInput.vendor_id,left,right) in ['CP9627346981847888151','CP219395185453452160'])							
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
				;

			boolean lFullFilter 	:= not(lAdditionalFilter);	//negate it 
			
			paw.layout.Employment_Out  filterDNBAddressPhone(paw.layout.Employment_Out l) := 
			transform
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
				self.phone								:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.phone								);
				self.company_phone				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.company_phone				);
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