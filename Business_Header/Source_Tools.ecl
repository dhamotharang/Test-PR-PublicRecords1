import MDR;
export Source_Tools :=
module

	export layout_description_old :=
	RECORD
		STRING2		code				;
		STRING100 description	;
	END;

	export layout_description :=
	RECORD

		STRING2		code												;
		STRING100	description									;
		boolean		IsBusinessSource	:= false	;
		boolean		IsHeaderSource		:= false	;
		boolean		IsPawSource				:= false	;
		boolean		IsFCRA						:= false	;
		boolean		IsDPPA						:= false	;
		boolean		IsUtility					:= false	;
		boolean		IsOnProbation			:= false	;
		boolean		IsDeath 					:= false	;
		boolean		IsDL 							:= false	;
		boolean		IsWC							:= false	;
		boolean		IsProperty				:= false	;
		boolean		IsTransUnion			:= false	;
		boolean		isWeeklyHeader		:= false	;
		boolean		isVehicle					:= false	;
		boolean		isLiens						:= false	;
		boolean		isBankruptcy			:= false	;
		boolean		isUpdating				:= true		;
	           
	END;

	export dSource_Codes := DATASET([
		 {'!E'   	,'OH Experian Veh'                                                                         ,false,true,false}
		,{'!W'   	,'WV Watercraft'                                                                           ,false,true,false}
		,{'#E'   	,'WY Experian Veh'                                                                         ,false,true,false}
		,{'#W'   	,'AK Watercraft'                                                                           ,false,true,false}
		,{'$E'   	,'DE Experian Veh'                                                                         ,false,true,false}
		,{'$W'   	,'KY Watercraft (LN)'                                                                      ,false,true,false}
		,{'&E'   	,'DC Experian Veh'                                                                         ,false,true,false}
		,{'(W'   	,'FL Watercraft (LN)'                                                                      ,false,true,false}
		,{')W'   	,'MO Watercraft (LN)'                                                                      ,false,true,false}
		,{'+E'   	,'NM Experian Veh'                                                                         ,false,true,false}
		,{'.E'   	,'TX Experian Veh'                                                                         ,false,true,false}
		,{'1W'   	,'MN Watercraft'                                                                           ,false,true,false}
		,{'1X'   	,'CO Experian DL'                                                                          ,false,true,false}
		,{'2W'   	,'MS Watercraft'                                                                           ,false,true,false}
		,{'2X'   	,'DE Experian DL'                                                                          ,false,true,false}
		,{'3W'   	,'MT Watercraft'                                                                           ,false,true,false}
		,{'3X'   	,'ID Experian DL'                                                                          ,false,true,false}
		,{'4W'   	,'ND Watercraft'                                                                           ,false,true,false}
		,{'4X'   	,'IL Experian DL'                                                                          ,false,true,false}
		,{'5W'   	,'NE Watercraft'                                                                           ,false,true,false}
		,{'5X'   	,'KY Experian DL'                                                                          ,false,true,false}
		,{'6W'   	,'NH Watercraft'                                                                           ,false,true,false}
		,{'6X'   	,'LA Experian DL'                                                                          ,false,true,false}
		,{'7W'   	,'NV Watercraft'                                                                           ,false,true,false}
		,{'7X'   	,'MD Experian DL'                                                                          ,false,true,false}
		,{'8W'   	,'OR Watercraft'                                                                           ,false,true,false}
		,{'8X'   	,'MS Experian DL'                                                                          ,false,true,false}
		,{'9W'   	,'UT Watercraft'                                                                           ,false,true,false}
		,{'9X'   	,'ND Experian DL'                                                                          ,false,true,false}
		,{'=E'   	,'OR Experian Veh'                                                                         ,false,true,false}
		,{'?E'   	,'NV Experian Veh'                                                                         ,false,true,false}
		,{'@E'   	,'ND Experian Veh'                                                                         ,false,true,false}
		,{'@W'   	,'WY Watercraft'                                                                           ,false,true,false}
		,{'[W'   	,'TX Watercraft'                                                                           ,false,true,false}
		,{'^W'   	,'AK Commercial Fishing Vessels'                                                           ,false,true,false}
		,{'AA'   	,'SDAA - Standard Directory of Ad Agencies and International Ad Agencies (Redbooks)'       ,true ,false,true }
		,{'AB'   	,'Alaska Business Registrations'                                                           ,true ,false,true	}
		,{'AD'   	,'ME DL'                                                                                   ,false,true,false}
		,{'AE'   	,'AK Experian Veh'                                                                         ,false,true,false}
		,{'AE'   	,'Experian Vehicles'                                                                       ,true ,false     ,false }
		,{'AF'   	,'ATF Firearms and Explosives'                                                             ,true ,false     ,true }
		,{'AK'   	,'AK Perm Fund'                                                                            ,false,true,false}
		,{'AL'   	,'Accurint Arrest Log'                                                                     ,false,true,false}
		,{'AM'   	,'Airmen'                                                                                  ,false,true,false}
		,{'AR'   	,'Aircrafts'                                                                               ,false,true,false}
		,{'AS'   	,'Accurint Sex offender'                                                                   ,false,true,false}
		,{'AT'   	,'Accurint Trade Show'                                                                     ,true ,false     ,true }
		,{'AV'   	,'ME Veh'                                                                                  ,false,true,false}
		,{'AW'   	,'Watercraft'                                                                              ,true ,false ,false }
		,{'B'    	,'Bankruptcy'                                                                              ,true ,false ,true }
		,{'BA'   	,'Bankruptcy'                                                                              ,false,true,false}
		,{'BE'   	,'AL Experian Veh'                                                                         ,false,true,false}
		,{'BM'   	,'Better Business Bureau Member'                                                           ,true ,false ,false }
		,{'BN'   	,'Better Business Bureau Non-Member'                                                       ,true ,false ,false }
		,{'BR'   	,'Business Registration'                                                                   ,true ,false ,true }
		,{'BW'   	,'MO Watercraft'                                                                           ,false,true,false}
		,{'BX'   	,'WV Experian DL'                                                                          ,false,true,false}
		,{'C'    	,'Corporate'                                                                               ,true ,false     ,true }
		,{'CC'   	,'Accurint Crim Court'                                                                     ,false,true,false}
		,{'CD'   	,'MI DL'                                                                                   ,false,true,false}
		,{'CE'   	,'CT Experian Veh'                                                                         ,false,true,false}
		,{'CF'   	,'ACF - America\'s Corporate Financial Directory'                                          ,true ,false     ,true }
		,{'CG'   	,'US Coastguard'                                                                           ,false,true,false}
		,{'CL'   	,'California Liquor Licenses'                                                              ,true  ,false    ,true }
		,{'CO'   	,'A corrections/override (used in FCRA products) record'                                   ,false,true,false}
		,{'CT'   	,'Conneticut Liquor Licenses'                                                              ,true  ,false    ,true }
		,{'CU'   	,'Credit Unions'                                                                           ,true  ,false    ,true }
		,{'CW'   	,'CO Watercraft'                                                                           ,false,true,false}
		,{'CY'   	,'Certegy'                                                                           			 ,false,true,false}
		,{'D'    	,'Dunn & Bradstreet'                                                                       ,true  ,false    ,true }
		,{'DA'   	,'DEA'                                                                                     ,false,true,false}
		,{'DC'   	,'Accurint DOC'                                                                            ,false,true,false}
		,{'DC'   	,'DCA'                                                                                     ,true  ,false    ,true }
		,{'DD'   	,'CT DL'                                                                                   ,false,true,false}
		,{'DE'   	,'DEA'                                                                                     ,true ,false     ,true }
		,{'DE'   	,'Death Master'                                                                            ,false,true,false}
		,{'DS'   	,'Death State'                                                                             ,false,true,false}
		,{'DU'   	,'Dummy Records'                                                                           ,true ,false     ,true }
		,{'DW'   	,'MD Watercraft'                                                                           ,false,true,false}
		,{'E'    	,'Edgar'                                                                                   ,true ,false     ,true }
		,{'EB'   	,'eMerge Boat'                                                                             ,false,true,false}
		,{'EB'   	,'Experian Business Reports'                                                               ,true ,false     ,true }
		,{'ED'   	,'Employee Directories'                                                                    ,true ,false     ,true }
		,{'ED'   	,'NM DL'                                                                                   ,false,true,false}
		,{'EE'   	,'CO Experian Veh'                                                                         ,false,true,false}
		,{'EM'   	,'EMerge Master'                                                                           ,false,true,false}
		,{'EQ'   	,'Equifax'                                                                                 ,false,true,false}
		,{'EV'   	,'NE Veh'                                                                                  ,false,true,false}
		,{'EW'   	,'CT Watercraft'                                                                           ,false,true,false}
		,{'F'    	,'Fictitious Business Names'                                                               ,true ,false     ,true }
		,{'FA'   	,'FAA Aircraft Registrations'                                                              ,true ,false     ,true }
		,{'FA'   	,'Fares Assessors'                                                                         ,false,true,false}
		,{'FB'   	,'Fares Deeds from Assessors'                                                              ,false,true,false}
		,{'FC'   	,'FCC Radio Licenses'                                                                      ,true ,false     ,true }
		,{'FC'   	,'FL CH'                                                                                   ,false,true,false}
		,{'FD'   	,'FDIC'                                                                                    ,true ,false     ,false }
		,{'FD'   	,'FL DL'                                                                                   ,false,true,false}
		,{'FE'   	,'Federal Explosives'                                                                      ,false,true,false}
		,{'FF'   	,'Federal Firearms'                                                                        ,false,true,false}
		,{'FF'   	,'Florida FBN'                                                                             ,true ,false     ,true }
		,{'FN'   	,'Florida Non-Profit'                                                                      ,true ,false     ,true }
		,{'FP'   	,'Fares Deeds'                                                                             ,false,true,false}
		,{'FR'   	,'Foreclosures'                                                                            ,false,true,false}
		,{'FS'   	,'FL SO'                                                                                   ,false,true,false}
		,{'FV'   	,'FL Veh'                                                                                  ,false,true,false}
		,{'FW'   	,'FL Watercraft'                                                                           ,false,true,false}
		,{'GB'   	,'Gong Business'                                                                           ,true ,false     ,true }
		,{'GC'   	,'GA CH'                                                                                   ,false,true,false}
		,{'GE'   	,'FL Experian Veh'                                                                         ,false,true,false}
		,{'GG'   	,'Gong Government'                                                                         ,true ,false     ,true }
		,{'GO'   	,'Gong History'                                                                            ,false,true,false}
		,{'GS'   	,'GA SO'                                                                                   ,false,true,false}
		,{'GW'   	,'GA Watercraft'                                                                           ,false,true,false}
		,{'HE'   	,'NE Experian Veh'                                                                         ,false,true,false}
		,{'HW'   	,'KS Watercraft'                                                                           ,false,true,false}
		,{'I'    	,'IRS 5500'                                                                                ,true ,false     ,true }
		,{'IA'   	,'INFOUSA ABIUS(USABIZ)'                                                                   ,true ,false     ,true }
		,{'ID'   	,'ID DL'                                                                                   ,false,true,false}
		,{'ID'   	,'INFOUSA DEAD COMPANIES'                                                                  ,true ,false     ,true }
		,{'IE'   	,'IL Experian Veh'                                                                         ,false,true,false}
		,{'IF'   	,'FBNV2'				                                                                           ,true ,false     ,true }
		,{'II'   	,'INFOUSA IDEXEC'                                                                          ,true ,false     ,true }
		,{'IL'   	,'Indiana Liquor Licenses'                                                                 ,true ,false     ,true }
		,{'IN'   	,'IRS Non-Profit'                                                                          ,true ,false     ,true }
		,{'IP'   	,'Ingenix National Provider Sanctions'                                                     ,true ,false     ,true }
		,{'IV'   	,'ID Veh'                                                                                  ,false,true,false}
		,{'IW'   	,'IA Watercraft'                                                                           ,false,true,false}
		,{'JD'   	,'IA DL'                                                                                   ,false,true,false}
		,{'JE'   	,'ID Experian Veh'                                                                         ,false,true,false}
		,{'JI'    ,'Jigsaw' 		                                                                             ,true ,false     ,true }
		,{'JW'   	,'MA Watercraft'                                                                           ,false,true,false}
		,{'KD'   	,'KY DL'                                                                                   ,false,true,false}
		,{'KE'   	,'KY Experian Veh'                                                                         ,false,true,false}
		,{'KV'   	,'KY Veh'                                                                                  ,false,true,false}
		,{'KW'   	,'KY Watercraft'                                                                           ,false,true,false}
		,{'L2'   	,'Liens v2'                                                                                ,true ,true,false }
		,{'LA'   	,'Lexis Assessors'                                                                         ,false,true,false}
		,{'LB'   	,'Lobbyists'                                                                               ,true ,false     ,true }
		,{'LE'   	,'LA Experian Veh'                                                                         ,false,true,false}
		,{'LI'   	,'Liens'                                                                                   ,false,true,false}
		,{'LJ'   	,'Liens and Judgments'                                                                     ,true ,false     ,false }
		,{'LL'   	,'Louisana Liquor Licenses'                                                                ,true ,false     ,true }
		,{'LP'   	,'Lexis Deeds and Mortgages'                                                               ,false,true,false}
		,{'LP'   	,'LN Property'                                                                             ,true ,false     ,true }
		,{'LT'   	,'Lexis Trans Union'                                                                       ,false,true,false}
		,{'LV'   	,'MT Veh'                                                                                  ,false,true,false}
		,{'LW'   	,'AL Watercraft'                                                                           ,false,true,false}
		,{'MA'   	,'Mixed DPPA'                                                                              ,false,true,false}
		,{'MC'   	,'Mixed Probation'                                                                         ,false,true,false}
		,{'MD'   	,'Medical Information Directory'                                                           ,true ,false     ,true }
		,{'MD'   	,'MO DL'                                                                                   ,false,true,false}
		,{'ME'   	,'MD Experian Veh'                                                                         ,false,true,false}
		,{'MH'   	,'MartinDale Hubbell'                                                                      ,true ,false     ,true }
		,{'MI'   	,'Mixed Non-DPPA'                                                                          ,false,true,false}
		,{'MS'   	,'MI SO'                                                                                   ,false,true,false}
		,{'MU'   	,'Mixed Utilities'                                                                         ,false,true,false}
		,{'MV'   	,'Motor Vehicles'                                                                          ,true ,false     ,true }
		,{'MV'   	,'MS Veh'                                                                                  ,false,true,false}
		,{'MW'		,'MS Worker Comp'																																					 ,false,true,false}
		,{'NC'   	,'NCOA'                                                                                    ,false,true,false}
		,{'ND'   	,'MN DL'                                                                                   ,false,true,false}
		,{'NE'   	,'MA Experian Veh'                                                                         ,false,true,false}
		,{'NJ'   	,'New Jersey Gaming Licenses'                                                              ,true ,false     ,true }
		,{'NV'   	,'MN Veh'                                                                                  ,false,true,false}
		,{'NW'   	,'NC Watercraft'                                                                           ,false,true,false}
		,{'OD'   	,'OH DL'                                                                                   ,false,true,false}
		,{'OE'   	,'OK Experian Veh'                                                                         ,false,true,false}
		,{'OL'   	,'Ohio Liquor Licenses'                                                                    ,true ,false     ,true }
		,{'OS'   	,'OSHAIR'                                                                                  ,true ,false     ,false }
		,{'OV'   	,'OH Veh'                                                                                  ,false,true,false}
		,{'OW'   	,'OH Watercraft'                                                                           ,false,true,false}
		,{'PC'   	,'PA CH'                                                                                   ,false,true,false}
		,{'PD'   	,'MA DL'                                                                                   ,false,true,false}
		,{'PE'   	,'MI Experian Veh'                                                                         ,false,true,false}
		,{'PH'   	,'Appended phone from gong file'                                                           ,false,true,false}
		,{'PI'   	,'Pennsylvania Liquor Licenses'                                                            ,true ,false     ,true }
		,{'PL'   	,'Professional License'                                                                    ,true ,true,true }
		,{'PP'   	,'Phones Plus'                                                                             ,true ,false     ,true }
		,{'PQ'   	,'Miscellaneous'                                                                           ,false ,true     ,false }		//got this from MDR.source_is_marketing_eligible
		,{'PR'   	,'Property File'                                                                           ,true ,false     ,true }
		,{'PS'   	,'PA SO'                                                                                   ,false,true,false}
		,{'PV'   	,'ND Veh'                                                                                  ,false,true,false}
		,{'PW'   	,'IL Watercraft'                                                                           ,false,true,false}
		,{'QE'   	,'NY Experian Veh'                                                                         ,false,true,false}
		,{'QH'   	,'Equifax Quick'                                                                           ,false,true,false}
		,{'QQ'   	,'Eq Employer'                                                                             ,true ,false     ,true }
		,{'QV'   	,'NV Veh'                                                                                  ,false,true,false}
		,{'QW'   	,'ME Watercraft'                                                                           ,false,true,false}
		,{'RB'   	,'Redbooks International Advertisers'                                                      ,true,false,true,}
		,{'RD'   	,'OR DL'                                                                                   ,false,true,false}
		,{'RE'   	,'ME Experian Veh'                                                                         ,false,true,false}
		,{'RV'   	,'NC Veh'                                                                                  ,false,true,false}
		,{'RW'   	,'AR Watercraft'                                                                           ,false,true,false}
		,{'SA'   	,'SDA -  Standard Directory of Advertisers and Int\'l Advertisers (Redbooks)'              ,true ,false     ,true }
		,{'SB'   	,'SEC Broker/Dealer'                                                                       ,true ,false     ,true }
		,{'SD'   	,'TN DL'                                                                                   ,false,true,false}
		,{'SE'   	,'SC Experian Veh'                                                                         ,false,true,false}
		,{'SG'   	,'Sheila Greco'                                                                            ,true ,false     ,true }
		,{'SK'   	,'SK&A Medical Professionals'                                                              ,true ,false     ,true }
		,{'SL'   	,'American Students List'                                                                  ,false,true,false}
		,{'SP'   	,'Spoke'                                                                                   ,true ,false     ,true }
		,{'ST'   	,'State Sales Tax'                                                                         ,true ,false     ,true }
		,{'SV'   	,'MO Veh'                                                                                  ,false,true,false}
		,{'SW'   	,'SC Watercraft'                                                                           ,false,true,false}
		,{'TB'   	,'TCOA'                                                                                    ,false,true,false}
		,{'TC'   	,'TCOA'                                                                                    ,false,true,false}
		,{'TD'   	,'TX DL'                                                                                   ,false,true,false}
		,{'TE'   	,'TN Experian Veh'                                                                         ,false,true,false}
		,{'TL'   	,'Texas Liquor Licenses'                                                                   ,true ,false     ,true }
		,{'TP'   	,'Tax practitioner'                                                                        ,true ,false     ,true }
		,{'TS'   	,'TUCS_Ptrack'                                                                        		 ,false,true,false}
		,{'TU'   	,'TransUnion'                                                                              ,false,true,false}
		,{'TV'   	,'TX Veh'                                                                                  ,false,true,false}
		,{'TW'   	,'TN Watercraft'                                                                           ,false,true,false}
		,{'TX'   	,'Texas Sales Tax Registrations(TXBUS)'                                                    ,true ,false     ,true }
		,{'U'    	,'UCC'                                                                                     ,true ,false     ,false }
		,{'U2'   	,'UCCV2'                                                                                   ,true ,false     ,false }
		,{'UC'   	,'UT CH'                                                                                   ,false,true,false}
		,{'UD'   	,'UT DL'                                                                                   ,false,true,false}
		,{'UE'   	,'UT Experian Veh'                                                                         ,false,true,false}
		,{'US'   	,'UT SO'                                                                                   ,false,true,false}
		,{'UT'   	,'Utilities'                                                                               ,false,true,false}
		,{'UV'   	,'UT Veh'                                                                                  ,false,true,false}
		,{'UW'   	,'Util Work Phone'                                                                         ,false,true,false}
		,{'V'    	,'Vickers'                                                                                 ,true ,false     ,true }
		,{'VD'   	,'WV DL'                                                                                   ,false,true,false}
		,{'VE'   	,'MN Experian Veh'                                                                         ,false,true,false}
		,{'VO'   	,'Voters v2'                                                                               ,false,true,false}
		,{'VW'   	,'VA Watercraft'                                                                           ,false,true,false}
		,{'W'    	,'Domain Registrations (WHOIS)'                                                            ,true ,false     ,true }
		,{'WC'   	,'State Workers Comp'                                                                      ,true ,false     ,true }
		,{'WD'   	,'WI DL'                                                                                   ,false,true,false}
		,{'WE'   	,'WI Experian Veh'                                                                         ,false,true,false}
		,{'WH'   	,'Equifax Weekly'                                                                          ,false,true,false}
		,{'WP'   	,'Targus White pages'                                                                      ,false,true,false}
		,{'WT'   	,'Wither and Die'                                                                          ,true ,false     ,true }
		,{'WV'   	,'WI Veh'                                                                                  ,false,true,false}
		,{'WW'   	,'WI Watercraft'                                                                           ,false,true,false}
		,{'XE'   	,'MS Experian Veh'                                                                         ,false,true,false}
		,{'XV'   	,'NM Veh'                                                                                  ,false,true,false}
		,{'XW'   	,'MI Watercraft'                                                                           ,false,true,false}
		,{'XX'   	,'SC Experian DL'                                                                          ,false,true,false}
		,{'Y'    	,'Yellow Pages'                                                                            ,true ,false     ,true }
		,{'YD'   	,'WY DL'                                                                                   ,false,true,false}
		,{'YE'   	,'MO Experian Veh'                                                                         ,false,true,false}
		,{'YV'   	,'WY Veh'                                                                                  ,false,true,false}
		,{'YW'   	,'NY Watercraft'                                                                           ,false,true,false}
		,{'ZE'   	,'MT Experian Veh'                                                                         ,false,true,false}
		,{'ZM'   	,'ZOOM'                                                                                    ,true  ,false    ,true }
		,{'ZW'   	,'AZ Watercraft'                                                                           ,false,true,false}
		,{'ZX'   	,'NH Experian DL'                                                                          ,false,true,false}
                                                                                                        
	], layout_description);

	shared setNonUpdatingSources := [
		 'AE'
		,'AT'
		,'CU'
		,'E'
		,'ED'
		,'FN'
		,'IA'
		,'ID'
//		,'IF'
		,'II'
		,'LB'
		,'LJ'
		,'MD'
		,'QQ'
		,'TP'
		,'U'
		,'W'
		,'WT'
	];

	layout_description tSetSources(layout_description l) :=
	transform

		self.IsFCRA						 	:= MDR.sourceTools.SourceIsFCRA					(l.code) and l.IsHeaderSource;
		self.IsDPPA						 	:= MDR.sourceTools.SourceIsDPPA					(l.code) and l.IsHeaderSource;
		self.IsUtility				 	:= MDR.sourceTools.SourceIsUtility			(l.code) and l.IsHeaderSource;
		self.IsOnProbation			:= MDR.sourceTools.SourceIsOnProbation	(l.code) and l.IsHeaderSource;
		self.IsDeath 						:= MDR.sourceTools.SourceIsDeath 				(l.code) and l.IsHeaderSource;
		self.IsDL 							:= MDR.sourceTools.SourceIsDL 					(l.code) and l.IsHeaderSource;
		self.IsWC								:= MDR.sourceTools.sourceIsWC						(l.code) and l.IsHeaderSource;
		self.IsProperty					:= MDR.sourceTools.SourceIsProperty			(l.code) and l.IsHeaderSource;
		self.IsTransUnion				:= MDR.sourceTools.SourceIsTransUnion		(l.code) and l.IsHeaderSource;
		self.isWeeklyHeader			:= MDR.sourceTools.sourceisWeeklyHeader	(l.code) and l.IsHeaderSource;
		self.isVehicle					:= MDR.sourceTools.sourceisVehicle			(l.code) and l.IsHeaderSource;
		self.isLiens						:= MDR.sourceTools.sourceisLiens				(l.code) and l.IsHeaderSource;
		self.isBankruptcy				:= MDR.sourceTools.sourceisBankruptcy		(l.code) and l.IsHeaderSource;
		self.isUpdating					:= l.code not in setNonUpdatingSources;
		self										:= l;                                                     

	end;

	export dSource_Codes_proj := project(dSource_Codes, tSetSources(left));

	export fTranslateSource(string pSource, boolean pIsHeaderSource = false) :=
	function
		
		regexsource1 := regexreplace('(.)'	,pSource			,'[$1]'		,nocase);
		regexsource2 := regexreplace('(\\^)',regexsource1	,'\\\\\\^',nocase);
		
		source_header 		:= dSource_Codes(regexfind('^' + regexsource2 + '$', code,nocase),IsHeaderSource)[1].description;
		source_nonheader	:= dSource_Codes(regexfind('^' + regexsource2 + '$', code,nocase),IsBusinessSource or IsPawSource)[1].description;
		
		return if(pIsHeaderSource = true, source_header, source_nonheader);

	end;

	export fGetSubsetOfSources(
	
		 string1	pIsBusinessSource		= ''
		,string1	pIsHeaderSource			= ''
		,string1	pIsPawSource				= ''
		,string1	pIsFCRA							= ''
		,string1	pIsDPPA							= ''
		,string1	pIsUtility					= ''
		,string1	pIsOnProbation			= ''
		,string1	pIsDeath 						= ''
		,string1	pIsDL 							= ''
		,string1	pIsWC								= ''
		,string1	pIsProperty					= ''
		,string1	pIsTransUnion				= ''
		,string1	pisWeeklyHeader			= ''
		,string1	pisVehicle					= ''
		,string1	pisLiens						= ''
		,string1	pisBankruptcy				= ''
		,string1	pisUpdating					= ''
		           
	) :=
	function

		lIsBusinessSource	:= if(pIsBusinessSource	= '', true, if(pIsBusinessSource	= 'Y', dSource_Codes_proj.IsBusinessSource	= true, dSource_Codes_proj.IsBusinessSource	= false));
    lIsHeaderSource		:= if(pIsHeaderSource		= '', true, if(pIsHeaderSource		= 'Y', dSource_Codes_proj.IsHeaderSource		= true, dSource_Codes_proj.IsHeaderSource		= false));
    lIsPawSource			:= if(pIsPawSource			= '', true, if(pIsPawSource				= 'Y', dSource_Codes_proj.IsPawSource				= true, dSource_Codes_proj.IsPawSource			= false));
    lIsFCRA						:= if(pIsFCRA						= '', true, if(pIsFCRA						= 'Y', dSource_Codes_proj.IsFCRA						= true, dSource_Codes_proj.IsFCRA						= false));
    lIsDPPA						:= if(pIsDPPA						= '', true, if(pIsDPPA						= 'Y', dSource_Codes_proj.IsDPPA						= true, dSource_Codes_proj.IsDPPA						= false));
    lIsUtility				:= if(pIsUtility				= '', true, if(pIsUtility					= 'Y', dSource_Codes_proj.IsUtility					= true, dSource_Codes_proj.IsUtility				= false));
    lIsOnProbation		:= if(pIsOnProbation	 	= '', true, if(pIsOnProbation	 		= 'Y', dSource_Codes_proj.IsOnProbation			= true, dSource_Codes_proj.IsOnProbation		= false));
    lIsDeath 					:= if(pIsDeath 				 	= '', true, if(pIsDeath 				 	= 'Y', dSource_Codes_proj.IsDeath 					= true, dSource_Codes_proj.IsDeath 					= false));
		lIsDL 						:= if(pIsDL 					 	= '', true, if(pIsDL 					 		= 'Y', dSource_Codes_proj.IsDL 							= true, dSource_Codes_proj.IsDL 						= false));
    lIsWC							:= if(pIsWC						 	= '', true, if(pIsWC						 	= 'Y', dSource_Codes_proj.IsWC							= true, dSource_Codes_proj.IsWC							= false));
    lIsProperty				:= if(pIsProperty			 	= '', true, if(pIsProperty			 	= 'Y', dSource_Codes_proj.IsProperty				= true, dSource_Codes_proj.IsProperty				= false));
		lIsTransUnion			:= if(pIsTransUnion		 	= '', true, if(pIsTransUnion		 	= 'Y', dSource_Codes_proj.IsTransUnion			= true, dSource_Codes_proj.IsTransUnion			= false));
    lisWeeklyHeader		:= if(pisWeeklyHeader	 	= '', true, if(pisWeeklyHeader	 	= 'Y', dSource_Codes_proj.isWeeklyHeader		= true, dSource_Codes_proj.isWeeklyHeader		= false));
    lisVehicle				:= if(pisVehicle			 	= '', true, if(pisVehicle			 		= 'Y', dSource_Codes_proj.isVehicle					= true, dSource_Codes_proj.isVehicle				= false));
    lisLiens					:= if(pisLiens				 	= '', true, if(pisLiens				 		= 'Y', dSource_Codes_proj.isLiens						= true, dSource_Codes_proj.isLiens					= false));
    lisBankruptcy			:= if(pisBankruptcy	 		= '', true, if(pisBankruptcy	 		= 'Y', dSource_Codes_proj.isBankruptcy			= true, dSource_Codes_proj.isBankruptcy			= false));
    lisUpdating				:= if(pisUpdating		 		= '', true, if(pisUpdating	 			= 'Y', dSource_Codes_proj.isUpdating				= true, dSource_Codes_proj.isUpdating				= false));
		                                                                                                                              
		filtered_sources 		:= dSource_Codes_proj(
			 lIsBusinessSource	
			,lIsHeaderSource		
			,lIsPawSource		
			,lIsFCRA						
			,lIsDPPA						
			,lIsUtility				
			,lIsOnProbation	
			,lIsDeath 				
			,lIsDL 					
			,lIsWC						
			,lIsProperty			
			,lIsTransUnion		
			,lisWeeklyHeader	
			,lisVehicle			
			,lisLiens				
			,lisBankruptcy	
			,lisUpdating	
		);  
		
		return filtered_sources;

	end;
	
	export fGetBusinessSourcesinOldLayout
	:= project(fGetSubsetOfSources(pIsBusinessSource := 'Y'), transform(layout_description_old, self := left));

	export fGetDuplicateSourceCodes :=
	function

		source_table := table(dSource_Codes_proj, {code, unsigned2 cnt := count(group)}, code, few);

		source_table_multiple := source_table(cnt > 1);

		source_table_set := set(source_table_multiple, code);

		sources_multiple := dSource_Codes_proj(code in source_table_set);
		
		return sequential(
			 output(source_table_multiple	, named('DuplicateSourceCodesCount'	))
			,output(sources_multiple			, named('DuplicateSourceCodes'			))
		);

	end;
	
	export fGetDuplicateSources :=
	function

		source_table := table(dSource_Codes_proj, {description, unsigned2 cnt := count(group)}, description, few);

		source_table_multiple := source_table(cnt > 1);

		source_table_set := set(source_table_multiple, description);

		sources_multiple := dSource_Codes_proj(description in source_table_set);
		
		return sequential(
			 output(source_table_multiple	, named('DuplicateSourcesCount'	))
			,output(sources_multiple			, named('DuplicateSources'			))
		);

	end;
	
	export fGetAllSourceInfo :=
	function
		return
			sequential(
				 fGetDuplicateSources
				,output(fGetSubsetOfSources(pIsBusinessSource	:= 'Y'),named('IsBusinessSource'	),all)
				,output(fGetSubsetOfSources(pIsHeaderSource		:= 'Y'),named('IsHeaderSource'		),all)
				,output(fGetSubsetOfSources(pIsPawSource			:= 'Y'),named('IsPawSource'				),all)
				,output(fGetSubsetOfSources(pIsFCRA						:= 'Y'),named('IsFCRA'						),all)
				,output(fGetSubsetOfSources(pIsDPPA						:= 'Y'),named('IsDPPA'						),all)
				,output(fGetSubsetOfSources(pIsUtility				:= 'Y'),named('IsUtility'					),all)
				,output(fGetSubsetOfSources(pIsOnProbation		:= 'Y'),named('IsOnProbation'			),all)
				,output(fGetSubsetOfSources(pIsDeath 					:= 'Y'),named('IsDeath'						),all)
				,output(fGetSubsetOfSources(pIsDL 						:= 'Y'),named('IsDL'							),all)
				,output(fGetSubsetOfSources(pIsWC							:= 'Y'),named('IsWC'							),all)
				,output(fGetSubsetOfSources(pIsProperty				:= 'Y'),named('IsProperty'				),all)
				,output(fGetSubsetOfSources(pIsTransUnion			:= 'Y'),named('IsTransUnion'			),all)
				,output(fGetSubsetOfSources(pisWeeklyHeader		:= 'Y'),named('isWeeklyHeader'		),all)
				,output(fGetSubsetOfSources(pisVehicle				:= 'Y'),named('isVehicle'					),all)
				,output(fGetSubsetOfSources(pisLiens					:= 'Y'),named('isLiens'						),all)
				,output(fGetSubsetOfSources(pisBankruptcy			:= 'Y'),named('isBankruptcy'			),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'Y',pIsBusinessSource	:= 'Y'),named('isUpdatingBusiness'		),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'N',pIsBusinessSource	:= 'Y'),named('isNotUpdatingBusiness'	),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'Y',pIsHeaderSource		:= 'Y'),named('isUpdatingPeople'			),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'N',pIsHeaderSource		:= 'Y'),named('isNotUpdatingPeople'		),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'Y',pIsPawSource				:= 'Y'),named('isUpdatingPaw'					),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'N',pIsPawSource				:= 'Y'),named('isNotUpdatingPaw'			),all)
			);                                                          

	end;

end;