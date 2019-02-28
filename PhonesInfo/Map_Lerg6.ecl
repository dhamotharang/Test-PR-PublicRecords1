IMPORT Mdr, Std, Ut;

	//DF-23660: Create Lerg6 Keybuild
	//DF-24140: Lerg6 Layout Change

	////////////////////////////////////////////////////////////////////////////////
	//Input Files
	////////////////////////////////////////////////////////////////////////////////
	ds_monthly 			:= PhonesInfo.File_Lerg.Lerg6;
	ds_base					:= PhonesInfo.File_Lerg.Lerg6Main;

	////////////////////////////////////////////////////////////////////////////////
	//Reformat Monthly Files to Common Layout
	////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Layout_Lerg.lerg6Main ccTr(ds_monthly l):= transform
		
		self.source							:= mdr.sourceTools.src_Phones_Lerg6;
		
		//Pull Date From Filename
			trFName			:= trim(l.filename, left, right);
			fileDate		:= stringlib.stringfilter(trFName[Std.str.Find(trFName, 'lerg6', 1)+6..], '0123456789');
		
		self.dt_first_reported	:= if(Std.Date.IsValidDate((integer)fileDate), fileDate, '');
		self.dt_last_reported		:= if(Std.Date.IsValidDate((integer)fileDate), fileDate, '');
		
		/*Per Vendor - "LATA" Field: Defines the area within which those local SPs directly addressed by the 1984 Modified Final Judgment (MFJ) (i.e. AT&T Divestiture) are permitted to carry traffic.
			Defined by a three-position number, each of which has an associated LATA NAME.
			Some LATA descriptions indicate a five position field for the LATA code.  The last two digits are for the LATA sub-zone (in Florida only) which represent Equal Access Exchange Areas (EAEAs).  The LATA sub-zone is blank in all other cases.
		*/
		self.lata								:= stringlib.stringfilter(l.lata, '0123456789');
		self.lata_name					:= stringlib.stringfilter(l.lata_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- ');
		
		/*Per Vendor - "STATUS" Field: Used in conjunction with an EFFDATE, the STATUS code indicates a specific type of activity that is to occur on that date in all files that provide future activity.
				•	E = indicates that the specific record is to be “established” in the network on the associated EFFDATE.
				•	M = indicates that a record in existence before associated “M” EFFDATE will have some data element(s) changed on the “M” EFFDATE.  To determine the changing element(s) you must compare the data, field by field, to the preexisting state of the record (also provided in the LERG, usually the preceding line).
				•	D = indicates that the specific record is to be “disconnected” from the network on the associated EFFDATE.
				• (b)(blank) = indicates the information provided is “current/active” at the time the LERG was produced.
		*/
		self.status							:= stringlib.stringfilter(l.status, 'EMD ');
		
		/*Per Vendor - "EFFDATE" Field: The date that a record key is to be implemented or a change to data associated with that key change is to be effective.
			Relates to an E, M, or D STATUS code indicating the type of change.
		*/ 	
		//Split & Standardize Effective Date/Time
			efDate 		:= Std.Date.FromStringToDate(trim(l.eff_date[1..stringlib.stringfind(l.eff_date, ' ', 1)], left, right), '%m/%d/%Y');
			efDateVal	:= (string)(if(Std.Date.IsValidDate((integer)efDate), (integer)efDate, 0));	
			efTime 		:= (integer)(stringlib.stringfilter(trim(l.eff_date[stringlib.stringfind(l.eff_date, ' ', 1)..], left, right), '0123456789'));
			
		self.eff_date						:= efDateVal;
		self.eff_time						:= (string)(intformat(efTime, 6, 1));
		
		/*Per Vendor - "NPA" Field: First three digits of a 10 digit NANP telephone number... Commonly referred to as an Area Code*/
		self.npa								:= stringlib.stringfilter(l.npa, '0123456789');
		
		/*Per Vendor - "NXX" Field: May also be referred to as a Central Office Code (COC) or Destination Code.  
			NXXs are technically the three digits following the NPA (Area Code) in the numbering schema used by countries participating in the North American Numbering Plan (NANP).
		*/	
		self.nxx								:= stringlib.stringfilter(l.nxx, '0123456789');
		
		/*Per Vendor - "BLOCK ID" Field: 
			•	“A” for NPA NXX records that are “assigned” to the Code Holder per the Central Office Code Assignment Guidelines
			•	Numeric BLOCK IDs correlates to the 1000 line numbers that begin with the BLOCK ID “thousand” (e.g. BLOCK ID 3 correlates to a range of 3000-3999)
		*/
		self.block_id						:= stringlib.stringfilter(l.block_id, 'A0123456789');
		
		/*Per Vendor - "COCTYPE" Field: Defines the use of the Central Office Code.  
			Used in conjunction with the SSC value to identify the "function" that the CO Code (NXX) or Thousands Block is performing by the party assigned the numbering resource.  
			•	ATC	= Access Tandem Code - used in Operator Services routing are considered a variation of Oddball Codes in that Rate Centers do not apply to them.  However, they are not included in the LERG6ODD file since, due to the need to provide the Operator Services Codes associated with them, they are listed separately in the LERG6ATC file.
			•	EOC	= End Office Code - used to identify a CO Code (NXX) or Thousands Block for which all line numbers, or a subset thereof, are used to provide Plain Old Telephone Service (POTS).  This is often referred to as “wireline” or “landline” and generally is considered the historically standard “telephone” voice service provided to residential and business customers.
			•	PLN	= Planned Code - non-routable.  Currently used infrequently by some companies to address situations that do not readily conform to other permissible values.  PLN codes cannot be ported or pooled.
			•	PMC	= Public Mobile Carrier (Type 2A Interconnected) - PMC identifies a CO Code (NXX) or Thousands Block that has been assigned as a (100%) fully dedicated Type 2A wireless interconnection.  
			•	RCC	= Radio Common Carrier (Dedicated Type 1 Interconnected) - RCC identifies a CO Code (NXX) or Thousands Block that has been assigned as a (100%) fully dedicated Type 1 wireless interconnection.  
			•	SIC	= Special 800 Service Code - This is used to indicate a non-dialable, but routable code.  For example, a customer dials a certain number that is then translated locally to a second number.  The second number would be then routed to, and would appear in BIRRDS with a COCTYPE of SIC.  SIC codes cannot be ported or pooled.
			•	SP1	= Service Provider Miscellaneous Service (Type 1 Interconnected) - SP1 identifies a CO Code (NXX) or Thousands Block that has been assigned as a (100%) fully dedicated Type 1 wireless interconnection for such services as Personal Communications Services (PCS).  
			•	SP2	= Service Provider Miscellaneous Service (Type 2A Interconnected) - SP2 identifies a CO Code (NXX) or Thousands Block that has been assigned as a (100%) fully dedicated Type 2A wireless interconnection for such services as Personal Communications Services (PCS).  
			•	TST	= Standard Plant Test Code - TST identifies a CO Code (NXX) that is needed to be shown for plant or other "testing" purposes.  This only pertains to non-pooled NXXs.  Test codes, specifically NXXs 958 and 959, unless they are assigned by the Code Administrator to a company, are generic test codes that can be used by multiple carriers.  They may also appear with a Rate Center value of XXXXXXXXXX and a SWITCH value of XXXXXXXXXXX and thus could be considered Oddball Codes.  TST codes cannot be ported or pooled.
			•	VOI	= Identifies a CO Code (NXX) or Thousand Block (NXX-X) that has been assigned for use as Voice over Internet Protocol (VoIP) to a SP identified with a NECA Company Code Category of IPES.
		
			(Oddball)
			•	AIN	= Advanced Intelligent Network – Usually a routing code (NXX) assigned to a SP offering a wide range of circuit switched services and utilizing elements of Advanced Intelligent Network (AIN) platforms to determine proper termination of a call.  AIN codes may terminate to different locations dependent upon where the call originates, and requires a database application and/or query for processing.  AIN codes cannot be ported or pooled.
			•	BLG	= Billing Only – A non-ratable NXX used for billing purposes only.  These codes are used to generate bills, often for isolated and obscure call situations, but are not dialable or switched through the PSTN.  BLG codes cannot be ported or pooled
			•	BRD = Broadband – An NXX assigned for multiple Broadband service offerings.  Currently, these codes are not ratable in the PSTN; however, this is subject to change.  Subscriber bills for usage are generated for Broadband telephone numbers.  BRD codes cannot be ported or pooled.
			•	CDA = Customer Directory Assistance only (line number 1212) – This COCTYPE value is used as secondary means of flagging "555" (i.e., DA line numbers only, line number 1212).  NXX 555 line numbers, beyond x1212 for directory assistance are assigned by NANPA and are not applicable to this document.  NXX 555 line number assignment procedures (other than line number 1212) are addressed in ATIS-0300048 (formerly INC document INC 94-0429-002).  CDA codes cannot be ported or pooled.
			•	CTV = Cable Television – An NXX assigned for subscriber access to a cable television company.  The telephone numbers are usually assigned on a 7-digit basis, are ratable on a limited basis, and may be used to determine subscriber charges for selective viewing or special events.  CTV codes cannot be ported or pooled.
			•	ENP = Emergency Preparedness – A non-N11 NXX used for emergencies and disaster recovery (e.g. earthquakes, floods, etc.).  ENP codes cannot be ported or pooled.		
			•	FGB = Feature Group B Access – NXX 950. Used for trunk-side termination arrangements that provide FGB originating and terminating exchange access.  FGB codes cannot be ported or pooled.	
			•	HVL = High Volume – indicates an NXX from which the assigned company provides line numbers to address cases involving a high volume of calls over a short period of time (e.g. media promotional call-in requests, certain emergency and relief situations, etc.).  The NXX involved is not associated with a given Rate Center or switch.  Assigned HVL numbers may also often be referred to as “Mass Calling” numbers.  When an NXX is dedicated to a specific switch and Rate Center and is involved with “Mass Calling”, it would be considered non-Oddball and represented as COCTYPE EOC / SSC M (when some lines serve for “Mass Calling”) or COCTYPE EOC / SSC MO (when all assigned lines serve for “Mass Calling”).  HVL codes cannot be ported or pooled.
			•	INP = Information Provider – An NXX used uniquely for providing various “information services."  These include NXX 976 and “976 Like” codes.  “976” is reported assigned in an NPA when there is a state tariff (or other regulatory body decision) defining its use.  This includes “blockable” codes as defined by the New York Public Service Commission.  INP records with an SSC of T or W indicate that the entire NXX is dedicated to providers provisioning Time or Weather respectively and inclusively.
			•	N11 = NXXs 211 through 911.  N11 usage in the United States is defined by the FCC, which has formally addressed 211, 311, 511, 711, 811, and 911.  Similarly, in Canada N11 code use is defined by the Canadian Radio-television and Telecommunications Commission (CRTC).
							211 – Community Support and Referral Services
							311 – Non-Emergency Government Services
							411 – Local Directory Assistance
							511 – Government Provided Traffic/Travel/Road Condition Report 
							611 – Repair Service
							711 – Telecom Relay Operator for Hearing/Speech Impaired
							811 – U.S. = One Call Services for Pipeline/Utility Excavations
										Canada = Non-urgent Health Care Telephone Triage Svc
							911 – Emergencies (Police, Fire, Ambulance, etc.)
							N11 codes cannot be ported or pooled.
							N11 use in other NANP countries is managed by the country’s regulatory authority; however, should such assignments exist or been made, the assignee in those cases may face some problems due to handling of N11 in call processing and in general telecom-related software, resulting in call-completion issues and related issues.   
			•	ONA = Open Network Architecture – An NXX assigned exclusively for ONA services.  The NXX may be dialable on a company-wide, region-wide, or other limited calling area.  ONA codes cannot be ported or pooled.			
			•	RTG = Routing Only – An NXX used by a SP for administrative or official calling purposes.  Assigned telephone numbers consist of the pseudo NXX and a four-digit line number.  Routing codes are dialable on a 7-digit basis only and are not associated, dialed, translated, nor terminated with a Home or Foreign NPA.  Such codes may terminate to multiple locations dependent upon where the call originates, and usually require 7-digit routing and code conversion in the translations process.  Routing codes are not rated.  RTG codes cannot be ported or pooled.			
			•	UFA = Unavailable for Assignment – Certain NXXs may be deemed unavailable for assignment to SPs for various reasons.  For example, NXXs may be protected in a specific NPA (withheld from assignment) due to certain characteristics and interrelationships between the NPA and NXXs involved, dialing plans, etc. – which, if assigned would create routing and rating conflicts.  NXXs may also be considered unavailable for assignment for various other reasons.
			•	700 = 700 IntraLATA Presubscription – dialing (home NPA)-700-xxxx is used for subscribers’ access into their presubscribed IntraLATA provider’s network.  x4141 is reserved to provide an indication to subscribers of the network to which they are presubscribed.  NXX 700 can only be assigned as a standard Central Office (CO) Code if the assigned company agrees to reserve x4141 for the indicated purpose.  This noted use of NXX 700 applies only the U.S. and its territories.  700 IntraLATA Presubscription codes cannot be ported or pooled.
		*/
		self.coc_type						:= PhonesInfo._Functions.fn_standardName(l.coc_type);
		
		/*Per Vendor - "SSC" Field: Special Service Code (SSC) is used in conjunction with the COCTYPE field to identify further special services provided by a Destination Code (NXX) record.  
			•	A	=	INTRALATA – for INTRALATA use only. 
			•	B	=	Paging Services – Information supplied by data providers regarding the “use” of an NXX or thousands block may vary over time due to a company’s line assignments.  
			•	C	=	Cellular Services – Information supplied by data providers regarding the “use” of an NXX or thousands block may vary over time due to a company’s line assignments.  	
			•	I	=	Pseudo 800 Service Code – Used for INWATS service.  These numbers are the actual ring to number for an 800 number that is PIC'd to a long distance carrier and terminates within the LATA.  	
			•	J	=	Designates that this NXX and/or thousands block has an extended/expanded local calling area.  
			•	M	=	Local Mass Calling – This is different than choke or high volume calling codes that are Oddball codes identified with a COCTYPE of HVL. 	
			•	N	=	Not Applicable – No SSC is needed, nor is one applicable.  Examples of types of services where an SSC of “N” is used may include Plain Old Telephone Service (POTS), 9YY Service, Test Code, and Non-Geographic 5XX-NXX.	
			•	O	=	Other – When ”O” is used, there may be restrictions and/or special services that are otherwise not definable by an existing SSC value (e.g. “blockable” codes as defined by the New York Public Service Commission).  	
			•	R	=	Two-way Conventional Mobile Radio – This is a pre-cellular technology primarily used for situations where there needed to be two-way communications and an ability to patch to a phone.  	
			•	S	=	Miscellaneous Services – For example, Personal Communications Services (PCS), Voice Mail, etc.	
			•	T	=	Time – This is used if an entire thousands block or entire NXX is dedicated to providing a “time of day” announcement or service.  
			•	V	=	Internet Protocol Voice Enabled Services
			•	X	=	Service Provider requests Local Exchange /Company IntraLATA Special Billing Option.
						Indicates that there may be line numbers or thousands blocks assigned to a SP who has requested a LEC IntraLATA special billing option on a LATA-wide basis.  
			•	Z	=	Service Provider requests SELECTIVE Local / Exchange Company IntraLATA Special Billing Option.
						Indicates that there may be line numbers or thousands blocks assigned to a SP who has requested a LEC IntraLATA special billing option on a SELECTIVE Exchange basis.  
			•	8	=	Puerto Rico and U.S. Virgin Islands.
						The SSC value of “8” applies to NXXs in Puerto Rico and the U.S. Virgin Islands.
		*/
		self.ssc								:= PhonesInfo._Functions.fn_standardName(l.ssc);
		
		/*Per Vendor - "DIND" Field: A (Y/N) indicator used to indicate whether or not the NPA NXX is or is not dialable by a subscriber or an operator.*/
		self.dind								:= stringlib.stringfilter(l.dind, 'YN');
	
		/*Per Vendor - "TR DIG" Field: EO (End Office) field indicates the number of terminating digits required for a call to be directly routed to the “end office” where the NPA NXX resides. 
			NA (Not Applicable) exists for Host/Remote situations where the host and remote switches are in different LATAs.
		*/
		self.td_eo							:= PhonesInfo._Functions.fn_standardName(l.td_eo);

		/*Per Vendor - "TR DIG" Field: AT (Access Tandem) field indicates the number of terminating digits required if the routing of the call is via the primary access tandem associated in LERG7SHA and LERG9 with that end office.
			NA (Not Applicable) can exist for mass calling NXXs where the call should not be routed to the Access Tandem
		*/
		self.td_at							:= PhonesInfo._Functions.fn_standardName(l.td_at);
		
		/*Per Vendor - "PORTABLE" Field: A ‘Y’ in this field indicates that at least one line number in the NPA NXX BLOCK may be ported either due to Thousands-Block-Number Pooling and/or SP Local Number Portability.  
			Porting involves mapping a given line number to a Location Routing Number (LRN) via the Number Portability Administration Center (NPAC) for routing the call (i.e. the basic process involved with Local Number Portability, (LNP).
		*/
		self.portable						:= stringlib.stringfilter(l.portable, 'YN');	
		
		/*Per Vendor - "AOCN" Field: Administrative Operating Company Number.  This iconectiv TRA term identifies the company responsible for the maintenance of the data for a given record in the iconectiv BIRRDS database.*/
		self.aocn								:= PhonesInfo._Functions.fn_standardName(l.aocn);
		
		/*Per Vendor - "OCN" Field: Operating Company Number. This is a four-position alphanumeric field, is a method for identifying NPA-NXX code-holders, switching entity companies, non-facility-based SPs such as resellers, billing SPs, etc.*/
		self.ocn								:= PhonesInfo._Functions.fn_standardName(l.ocn[1..4]);
		
		self.loc_name						:= PhonesInfo._Functions.fn_alphaNumText(l.loc_name);
		self.loc								:= PhonesInfo._Functions.fn_alphaText(l.loc);
		self.loc_state					:= PhonesInfo._Functions.fn_alphaText(l.loc_state);
		
		/*Per Vendor - "RATE CENTER ABBREVIATION" Field: In cases where the Rate Center name exceeds 10 characters, it has been abbreviated.*/
		self.rc_abbre						:= PhonesInfo._Functions.fn_alphaNumText(l.rc_abbre);
		
		/*Per Vendor - "RC TYPE" Field: Used to identify Rate Centers requiring special identification.  The following are examples of  RC TYPEs identifying a particular Rate Center:
				•	Unrestricted (blank) = The Rate Center provides a range of telecommunications services and is not restricted to a specific function.
				•	Suburban Zone (S) = Unit established to further define large exchange areas.  Suburban Zones apply to large metropolitan areas and mayinclude only the area around a city (e.g., Pittsburgh Suburban Zones) or the city and its surrounding area (e.g., Wheeling Suburban Zones).  The exchange area must be large enough to warrant a subdivision of two or more suburban zones.  Suburban Zones are assigned a vertical and horizontal coordinate for use in measurements between Rate Centers, suburban zones or Zoned Cities, in the same manner as Rate Center vertical and horizontal coordinates.
				•	Zoned City (Z) = Unit established to further define large exchange areas usually encompassing a city (e.g., New York City).  Each zoned city will be assigned a vertical and horizontal coordinate (identified as the “Major Zone”).  In addition, the zoned city will be sub-divided into two or more city zones.  Vertical and Horizontal coordinates will be assigned to each city zone to be used in the same manner as suburban zone vertical and horizontal coordinates.
				•	Restricted (+) = Operator switched nondialed services (e.g. ring down lines).  This currently only applies to isolated cases in Alaska.
		*/
		self.rc_ty							:= stringlib.stringfilter(l.rc_ty, 'SZ+ ');
		
		/*Per Vendor - "LINES FROM/TO" Fields: Two four-digit values representing numbers served by the associated switching entity for the NPA NXX (i.e., both working and spare).  
		  The first four digits represent the starting number in the block of numbers.  The last four digits represent the last number in the block of numbers.  
		  In LERG6, for “A” BLOCK IDs, the FROM will be 0000 and TO will be 9999 with the exception of NXX 555 which will have 1212 and 1212 respectively; numeric blocks 0-9 should be 0000-0999, 1000-1999, etc. where the first digit of the FROM and TO is the same as the BLOCK ID.  
		  A “full set” of BLOCK IDs (0-9) should not be assumed; therefore, a full complement of ranges equating to 0000-9999 should not be assumed for NXX records that have numeric BLOCK IDs.
		*/
		self.line_fr						:= stringlib.stringfilter(l.line_fr, '0123456789');
		self.line_to						:= stringlib.stringfilter(l.line_to, '0123456789');
		
		/*Per Vendor - "SWITCH" Field: For Oddball NXXs, the SWITCH field is often populated with XXXXXXXXXXX as an indication that the “switch” involved may vary based on the type or service provided, due to carriers processing of a given NXX differently that other (e.g. network by network), etc.*/
		/*The loc_name and rc_abbre fields appear to be also affected in such cases - W20181217-133029*/
		self.switch							:= PhonesInfo._Functions.fn_standardName(l.switch);
		
		/*Per Vendor - "SWITCH HOMING ARRANGEMENT" Field: The Switch Homing Arrangement (SHA) Indicator is used to identify, in combination with the SWITCH, the “homing” arrangement to be used for an NPA NXX BLOCK.  
      In correlating the LERG6 and LERG7SHA files, the SHA value must be used in conjunction with the SWITCH to obtain the appropriate homing for a given NPA NXX.
		*/
		self.sha_indicator			:= stringlib.stringfilter(l.sha_indicator, '0123456789');
		
		/*Per Vendor - "TEST LINE" Field: This is a line number component of the associated NPA NXX that the SP has indicated is a test line.  This is optional entry for BLOCK records.  
      Test lines may be operational only for a specified period and thereafter subject to later assignment to a subscriber.  Assignment, use, and other aspects of test line numbers are largely a function of company-specific policies.
		*/  
		self.test_line_num			:= stringlib.stringfilter(l.test_line_num, '0123456789');
		
		/*Per Vendor = "TEST LINE RESPONSE" Field: Indicates the type of response that a call placed to the indicated TEST LINE
				•	A = Announcement 
				•	M = Milliwatt tone
		*/	
		self.test_line_response	:= stringlib.stringfilter(l.test_line_num, 'AM ');
	
		/*Per Vendor = "TEST LINE EXPIRATION DATE" Field: Indicates the expectation that the TEST LINE provided for the NPA NXX BLOCK will no longer be used as a TEST LINE after the indicated EXPIRATION DATE.*/
		//Split & Standardize Test Date/Time
			exDate 			:= Std.Date.FromStringToDate(trim(l.test_line_exp_date[1..stringlib.stringfind(l.test_line_exp_date, ' ', 1)], left, right), '%m/%d/%Y');
			exDateVal		:= (string)(if(Std.Date.IsValidDate((integer)exDate), (integer)exDate, 0));	
			exTime 			:= (integer)(stringlib.stringfilter(trim(l.test_line_exp_date[stringlib.stringfind(l.test_line_exp_date, ' ', 1)..], left, right), '0123456789'));
			
		self.test_line_exp_date := exDateVal;
		self.test_line_exp_time := (string)(intformat(exTime, 6, 1));
		
		/*Per Vendor - "THOUSANDS BLOCK POOLING INDICATOR" Field: 
				•	Y = Indicates that the NPA NXX has been identified to be part of a pool of NXXs, within a given NPA, that are assigned 1000 lines at a time by the Pool Administrator (currently only applicable to the United States and Puerto Rico) to potentially different companies.  
				•	N = Indicates that the NXX is not publicly pooled and that there is no information below the NXX level.
				•	S = Indicates that the NXX is not publicly pooled, but that the SP has chosen, for purposes of Intra Service Provider (SP) Pooling, seven digit routing, or other reason, to show its fully assigned NXX to be “split” at the thousands block level.  This can apply to any NPA within the NANP.
				•	I = Indicates the same as “S”, except that the Pool Administrator has been requested by the Code Holder to establish BIRRDS system controls regarding the “split” of its NXX into thousands blocks.  This applies to only NPAs that are in the Pool Administrator’s inventory and currently applicable to just FCC regulated areas (U.S. and U.S. Territories).
		*/
		self.blk_1000_pool			:= stringlib.stringfilter(l.blk_1000_pool, 'YNSI');
		
		self.rc_lata						:= stringlib.stringfilter(l.rc_lata, '0123456789');
		
		/*Per Vendor - "CREATION DATE IN BIRRDS" Field: 	The date the record was physically created in BIRRDS.  The date should always be a date earlier than the LERG product date.*/
		//Split & Standardize Creation Date/Time
			crDate 			:= Std.Date.FromStringToDate(trim(l.creation_date[1..stringlib.stringfind(l.creation_date, ' ', 1)], left, right), '%m/%d/%Y');
			crDateVal		:= (string)(if(Std.Date.IsValidDate((integer)crDate), (integer)crDate, 0));	
			crTime 			:= (integer)(stringlib.stringfilter(trim(l.creation_date[stringlib.stringfind(l.creation_date, ' ', 1)..], left, right), '0123456789'));
		
		self.creation_date			:= crDateVal;
		self.creation_time			:= (string)(intformat(crTime, 6, 1));
		
		/*Per Vendor "E STATUS DATE" Field: Date that BIRRDS has as the “establishing” (“E” STATUS) date of a given record.  It could be a past or future date.*/
		//Split & Standardize E Status Date/Time
			esDate 			:= Std.Date.FromStringToDate(trim(l.e_status_date[1..stringlib.stringfind(l.e_status_date, ' ', 1)], left, right), '%m/%d/%Y');
			esDateVal		:= (string)(if(Std.Date.IsValidDate((integer)esDate), (integer)esDate, 0));		
			esTime 			:= (integer)(stringlib.stringfilter(trim(l.e_status_date[stringlib.stringfind(l.e_status_date, ' ', 1)..], left, right), '0123456789'));
			
		self.e_status_date			:= esDateVal;
		self.e_status_time			:= (string)(intformat(esTime, 6, 1));	
		
		/*Per Vendor "LAST MODIFICATION DATE" Field: For currently active records (including their future views, if any) this is the latest date (prior to the LERG production date) 
			that, based on current information in BIRRDS, activity (changes) to the record was last effective (i.e. EFFDATE of the last change).
		*/
		//Split & Standardize Last Modified Date/Time
			lmDate 			:= Std.Date.FromStringToDate(trim(l.last_modified_date[1..stringlib.stringfind(l.last_modified_date, ' ', 1)], left, right), '%m/%d/%Y');
			lmDateVal		:= (string)(if(Std.Date.IsValidDate((integer)lmDate), (integer)lmDate, 0));			
			lmTime 			:= (integer)(stringlib.stringfilter(trim(l.last_modified_date[stringlib.stringfind(l.last_modified_date, ' ', 1)..], left, right), '0123456789'));
		
		self.last_modified_date	:= lmDateVal;
		self.last_modified_time := (string)(intformat(lmTime, 6, 1));	
		
		//Pull Date		
		self.dt_start						:= self.creation_date;
		self.dt_end							:= '';	
		
		//Set Latest Update Records to Current
		self.is_current					:= if(l.eff_date <>'' and l.eff_date > self.dt_last_reported, false,	//FALSE: Record has eff_date<>'' and eff_date > dt_last_reported
																	if(l.eff_date <>'' and l.status in ['D','M'], false,						//FALSE: Record has eff_date<>'' and status not 'D' or 'M'
																	true)); 																												//TRUE:  Record found in the latest update; Record may have (eff_date='') or (eff_date<>'' and status='E' and eff_date < dt_last_reported)
																																																			
		self.os1								:= '';
		self.os2								:= '';
		self.os3								:= '';
		self.os4								:= '';
		self.os5								:= '';
		self.os6								:= '';
		self.os7								:= '';
		self.os8								:= '';
		self.os9								:= '';
		self.os10								:= '';
		self.os11								:= '';
		self.os12								:= '';
		self.os13								:= '';
		self.os14								:= '';
		self.os15								:= '';
		self.os16								:= '';
		self.os17								:= '';
		self.os18								:= '';
		self.os19								:= '';
		self.os20								:= '';
		self.os21								:= '';
		self.os22								:= '';
		self.os23								:= '';
		self.os24								:= '';
		self.os25								:= '';
		self.notes							:= '';	
		self.record_sid					:= 0;
		self.global_sid					:= 0;
		self										:= l;
	end;
	
	pCC							:= project(ds_monthly, ccTr(left));
	latestFileDate	:= PhonesInfo._Functions.fn_maxLerg6FileDt(pCC);
	
	pCC_Curr				:= pCC(is_current=true);	//Current Records
	pCC_NonCurr			:= pCC(is_current=false);	//NonCurrent Records

	////////////////////////////////////////////////////////////////////////////////
	//Update Dates by Comparing Current Records with Previous Base
	////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Layout_Lerg.lerg6Main updTr(pCC_Curr l, ds_base r) := transform
		self.dt_first_reported 	:= (string)ut.min2((unsigned)l.dt_first_reported, (unsigned)r.dt_first_reported);
		self.dt_last_reported 	:= (string)max((unsigned)l.dt_last_reported, (unsigned)r.dt_last_reported);	
		self.dt_start						:= (string)ut.min2((unsigned)l.dt_start, (unsigned)r.dt_start);	
		self 										:= l;
	end;

	updRec 				:= join(sort(distribute(pCC_Curr, hash(ocn, npa, nxx, block_id, switch, sha_indicator)), ocn, npa, nxx, block_id, switch, sha_indicator, local),
												sort(distribute(ds_base(is_current), hash(ocn, npa, nxx, block_id, switch, sha_indicator)), ocn, npa, nxx, block_id, switch, sha_indicator, local),
												left.ocn = right.ocn and 
												left.npa = right.npa and
												left.nxx = right.nxx and
												left.block_id = right.block_id and
												left.switch = right.switch and
												left.sha_indicator = right.sha_indicator,
												updTr(left, right),
												left outer,
												local);

	////////////////////////////////////////////////////////////////////////////////
	//Set Existing Base Records Not Found in Current File to FALSE
	////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Layout_Lerg.lerg6Main remTr(ds_base l, pCC r) := transform
		self.is_current 				:= false;
		self.dt_end					  	:= latestFileDate;
		self 										:= l;
	end;

	remRec 				:= join(sort(distribute(ds_base(is_current), hash(ocn, npa, nxx, block_id, switch, sha_indicator)), ocn, npa, nxx, block_id, switch, sha_indicator, local),
												sort(distribute(pCC_Curr, hash(ocn, npa, nxx, block_id, switch, sha_indicator)), ocn, npa, nxx, block_id, switch, sha_indicator, local),
												left.ocn = right.ocn and 
												left.npa = right.npa and
												left.nxx = right.nxx and
												left.block_id = right.block_id and
												left.switch = right.switch and
												left.sha_indicator = right.sha_indicator,
												remTr(left, right),
												left only,
												local);

	////////////////////////////////////////////////////////////////////////////////
	//Set Effective Date Records Found in Latest Monthly File to FALSE
	////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Layout_Lerg.lerg6Main effTr(pCC_NonCurr l) := transform
		self.is_current 				:= false;
		self.dt_end					  	:= latestFileDate;
		self 										:= l;
	end;
	
	effRec				:= project(pCC_NonCurr, effTr(left));

	////////////////////////////////////////////////////////////////////////////////
	//Concat All Records
	////////////////////////////////////////////////////////////////////////////////
	allRec 				:= updRec 					+ remRec 														 + ds_base(~is_current)			 + effRec; 
	//               Current Records 	+ Newly Flagged Non-Current Records  + Non-Current Base Records  + Latest Effective Date Records (Status = D or M)
	
	ddAllRec			:= dedup(sort(distribute(allRec, hash(ocn, npa, nxx, block_id, switch)), record, local), record, local);
	
	////////////////////////////////////////////////////////////////////////////////
	//Rollup Same Records Diff dt_last_reported
	///////////////////////////////////////////////////////////////////////////////
	aggrSrt				:= sort(ddAllRec, ocn, npa, nxx, block_id, switch, aocn, sha_indicator, status, eff_date, dt_start, -dt_last_reported, local);
	
	PhonesInfo.Layout_Lerg.lerg6Main roll(aggrSrt l, aggrSrt r) := transform
		self.dt_first_reported	:= (string)ut.min2((unsigned)l.dt_first_reported, (unsigned)r.dt_first_reported);
		self.dt_last_reported		:= (string)max((unsigned)l.dt_last_reported, (unsigned)r.dt_last_reported);
		self.dt_end							:= if((string)min((unsigned)l.dt_end, (unsigned)r.dt_end)='0',
																	'',
																	(string)max((unsigned)l.dt_end, (unsigned)r.dt_end));
		self 										:= r;
	end;

	aggrRoll			:= rollup(aggrSrt, 
													left.ocn = right.ocn and
													left.npa = right.npa and
													left.nxx = right.nxx and
													left.block_id = right.block_id and
													left.switch = right.switch and
													left.aocn = right.aocn and
													left.sha_indicator = right.sha_indicator and
													left.status = right.status and
													left.eff_date = right.eff_date and
													left.dt_start = right.dt_start, 
													roll(left, right), local);	

	////////////////////////////////////////////////////////////////////////////////
	//Append Record ID
	////////////////////////////////////////////////////////////////////////////////	
	PhonesInfo.Layout_Lerg.lerg6Main addRecTr(aggrRoll l):= TRANSFORM
		self.record_sid					:=  hash64(mdr.sourceTools.src_Phones_Lerg6 + l.ocn + l.npa + l.nxx + l.block_id + l.switch + l.aocn + l.sha_indicator + l.status + l.eff_date + l.dt_start);
		self 	                	:= l;
	END;

	addRecID 			:= project(aggrRoll, addRecTr(left));

EXPORT Map_Lerg6 := addRecID;