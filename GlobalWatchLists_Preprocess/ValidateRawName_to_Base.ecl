IMPORT STD, GlobalWatchLists, GlobalWatchLists_Preprocess, ut, Data_Services;

//Base File
ProdBase := dataset('~thor_data400::base::globalwatchlists',Globalwatchlists.Layout_GlobalWatchLists,flat);

//For date cleaning	
	fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%y'
	];
	fmtout := '%Y%m%d';			

//1==========================================================================================
// US Bureau of Industry and Security - Denied Person List

DeniedPersonsraw := GlobalWatchLists_Preprocess.Files.dsDeniedPersons; //raw
DeniedPersonsbase:= ProdBase(source = 'US Bureau of Industry and Security - Denied Person List');

jDP := join(DeniedPersonsraw,DeniedPersonsbase,
            STD.Str.FindReplace(if(length(TRIM(left.Name, left, right)) > 54 and STD.Str.Find(TRIM(left.Name, left, right), ',', 1) > 1
																,TRIM(left.Name, left, right)[1..STD.Str.Find(TRIM(left.Name, left, right), ',', 1)-1]
																,TRIM(left.Name, left, right)), '"', '')[1..10] = trim(right.orig_pty_name)[1..10] and 
						STD.date.ConvertDateFormatMultiple(left.eff_date,fmtsin,fmtout) = right.effective_date,
            left only);

// output(count(DeniedPersonsraw),named('Cnt_DeniedPersonsRaw'));
// output(count(DeniedPersonsbase),named('Cnt_DeniedPersonsBase'));
MissingDP	:= count(jDP);
jDP_out	:= IF(MissingDP > 0, FAIL(MissingDP + ' DeniedPerson_InRaw_notbase'));
output(jdp,named('DeniedPerson_InRaw_notbase'));
//2==========================================================================================
// Office of the Comptroller of the Currency Alerts
InnovativeSysOCCraw     := GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsOCC;
InnovativeSysOCCBase := ProdBase(source = 'Office of the Comptroller of the Currency Alerts ');			

jISOCC := join(InnovativeSysOCCraw,InnovativeSysOCCBase,
            trim(left.application_code)+trim(left.serial_number) = right.entity_id,
            left only);

// output(count(InnovativeSysOCCraw),named('Cnt_InnovativeSysOCCRaw'));
// output(count(InnovativeSysOCCBase),named('Cnt_InnovativeSysOCCBASe'));
MissingISOCC := count(jISOCC);
jISOCC_out := IF(MissingISOCC > 0, FAIL(MissingISOCC + ' InnovativeSysOCC_InRaw_notbase'));
output(jISOCC,named('InnovativeSysOCC_InRaw_notbase'));
//3==========================================================================================
// State Department Terrorist Exclusions 
StDeptTerroristsraw     := GlobalWatchLists_Preprocess.Files.dsStDeptTerroristExcl(~REGEXFIND('(^Loading |^Orignal |^Number |^Author |^Writing |^Minrow=0 |Extract Date)(.*)',Organization)
																																	and trim(Organization,all) <> '');
StDeptTerroristsBase    := ProdBase(source = 'State Department Terrorist Exclusions');			

jSDT := join(StDeptTerroristsraw,StDeptTerroristsBase,
             ut.CleanSpacesAndUpper(STD.Str.FilterOut(REGEXREPLACE('\\((.*)\\)',left.organization,''),'"')) = right.orig_pty_name,
             left only);

// output(count(StDeptTerroristsraw),named('Cnt_StDeptTerroristsRaw'));
// output(count(StDeptTerroristsBase),named('Cnt_StDeptTerroristsBase'));
MissingSDT	:= count(jSDT);
jSDT_out := IF(MissingSDT > 0, FAIL(MissingSDT + ' StDeptTerroristsExclusions_InRaw_notbase'));
output(jSDT,named('StDeptTerroristExclusions_InRaw_notbase'));
//4=========================================================================================
// European Union Designated Terrorist Individuals
EUDTIraw   := GlobalWatchLists_Preprocess.Files.dsEUterroristListPerson;
EUDTIBase  := ProdBase (source = 'European Union Designated Terrorist Individuals');

ds_person	:= EUDTIraw(~REGEXFIND('(^Loading |^Orignal |^Number |^Author |^Writing |^Minrow=0 |Extract Date)(.*)',Sflag) and trim(Line,all) <> '');

jEUDTI := join(ds_person,EUDTIBase,
             'EUI'+left.individual_id = right.pty_key,
             left only);

// output(count(ds_person),named('Cnt_EU_Designated_Terrorist_IndivRaw'));
// output(count(EUDTIBase(pty_key[1..3] ='EUI')),named('Cnt_EU_Designated_Terrorist_IndivBase'));
MissingEUDTI	:= count(jEUDTI);
jEUDTI_out := IF(MissingEUDTI > 0, FAIL(MissingEUDTI + ' EU_Designated_Terrorist_Indiv_InRaw_notbase'));
output(jEUDTI,named('EU_Designated_Terrorist_Indiv_InRaw_notbase'));
//5===========================================================================================
// European Union Designated Terrorist Groups 			
   EUDTGRaw   := GlobalWatchLists_Preprocess.Files.dsEUterroristListGroup;
   EUDTGBase  := ProdBase(source = 'European Union Designated Terrorist Groups');		
	
	ds_group	:= EUDTGRaw(~REGEXFIND('(^Loading |^Orignal |^Number |^Author |^Writing |^Minrow=0 |Extract Date)(.*)',Sflag) and trim(Unparsed_Data,all) <> '');
	
	jEUDTG:= join(ds_group,EUDTGBase,
             'EUG'+left.record_num = right.pty_key,
             left only);
						 
// output(count(ds_group),named('CntEU_Designated_Terrorist_Grpsraw')); 
// output(count(EUDTGBase(pty_key[1..3] ='EUG')),named('CntEU_Designated_Terrorist_GrpsBase'));
MissingEUDTG := count(jEUDTG); 
jEUDTG_out := IF(MissingEUDTG > 0, FAIL(MissingEUDTG + ' EU_Designated_Terrorist_Grps_InRaw_notbase'));
output(jEUDTG,named('EU_Designated_Terrorist_Grps_InRaw_notbase'));
//6=============================================================================================
// Foreign Agents Registration Act 

	dFAPrincipalsraw	   := GlobalWatchLists_Preprocess.Files.dsFAFP;
	dFARegistrantsraw	 := GlobalWatchLists_Preprocess.Files.dsFARE;
	dFAShortFormRegsraw := GlobalWatchLists_Preprocess.Files.dsFASRE;
  FARABase  := ProdBase(source = 'Foreign Agents Registration Act');

	//Registrant file is the main file that all others are joined to so only need to check that
	jFARA_registrant := join(dFARegistrantsraw,FARABase,
                           'FARA'+left.registration_num = right.pty_key and 
													 stringlib.stringtouppercase(left.registrant) = right.orig_pty_name,
                           left only);

 // output(count(dFARegistrantsraw())  ,named('CntdForeignAgentsRegistrantsraw')); 
 // output(count(FARABase())            ,named('CntForeignAgentsRegs_Base')); 
 MissingFARA	:= count(jFARA_registrant);
 jFARA_out := IF(MissingFARA > 0, FAIL(MissingFARA + ' ForeignAgentsRegistrants_InRaw_notbase'));
 output(jFARA_registrant,named('ForeignAgentsRegistrants_InRaw_notbase'));
//7============================================================================================
// United Nations Named Terrorists 
  UNNTRaw   := GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsUNS(ut.fn_KeepPrintableChars((string)line_data_1) <> '' and STD.Str.Filter((string)line_data_1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') <> '');
  UNNTBase  := ProdBase(source = 'United Nations Named Terrorists');
	
	jUNNT := join(UNNTRaw,UNNTBase,
             (string)STD.Uni.ToUpperCase(TRIM(left.Location) + left.Serial_Number) = right.entity_id,
             left only);
						 
// output(count(UNNTRaw()),named('CntUNNamedTerroristraw')); 
// output(count(UNNTBase()),named('CntUNNamedTerroristBase'));
MissingUNNT := count(jUNNT);
jUNNT_out := IF(MissingUNNT > 0, FAIL(MissingUNNT + ' UNNamedTerrorist_InRaw_notbase'));
output(jUNNT,named('UNNamedTerrorist_InRaw_notbase'));	
//8============================================================================================
// Politically Exposed Persons 
  PEPRaw   := GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsPEP;
  PEPBase  := ProdBase(source = 'Politically Exposed Persons');	
	
		jPEP:= join(PEPRaw,PEPBase,
                 ut.CleanSpacesAndUpper(left.Application_Code + left.Serial_Number) = trim(right.entity_id,left,right),
                 left only);
						 
// output(count(PEPRaw()) ,named('CntPoliticallyExposedPersonsraw')); 
// output(count(PEPBase()),named('CntPoliticallyExposedPersonsBase'));
MissingPEP	:= count(jPEP);
jPEP_out := IF(MissingPEP > 0,FAIL(MissingPEP + ' PoliticallyExposedPersons_InRaw_notbase'));
output(jPEP,named('PoliticallyExposedPersons_InRaw_notbase'));
//9============================================================================================
// World Bank Ineligible Firms 
  WBIFRaw   := GlobalWatchLists_Preprocess.Files.dsWorldBank(orig_firm_name <> '');
  WBIFBase  := ProdBase(source = 'World Bank Ineligible Firms');	
	
	ClnRawName(string InName)	:= FUNCTION
	  StdAKA							:= IF(REGEXFIND('also known as',InName), REGEXREPLACE('also known as ',InName,'AKA '),InName);
		ClnName							:= IF(STD.Str.Find(StdAKA,'*',1) >0, REGEXREPLACE('(.*)[\\*](.*)',StdAKA,'$1'),StdAKA);
		TempName						:= REGEXREPLACE('^DBA ',STD.Str.FilterOut(ClnName, '",*'),'');
		ParseEntity			 		:= IF(REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,NOCASE),
															REGEXFIND('(.*)(AKA |A.K.A.|A/K/A|F/K/A|FKA |DBA |D/B/A)(.*)',TempName,1,NOCASE),
															TempName);
		FinalClean					:= ut.CleanSpacesAndUpper(REGEXREPLACE('(\\([?]+\\))',
																													REGEXREPLACE(' \\(CURRENTLY$| \\($',trim(ParseEntity,left,right),'',NOCASE),
																													''));
		RETURN FinalClean;
	END;
	
	
		jWBIF:= join(WBIFRaw,WBIFBase,
						      regexreplace('[^ -~]', ClnRawName(left.orig_firm_name),'')[1..20] = trim(right.orig_pty_name)[1..20],
									left only);
						 
// output(count(WBIFRaw()),named('Cnt_World_Bank_Ineligible_Firmsraw')); 
// output(count(WBIFBase()),named('Cnt_World_Bank_Ineligible_FirmsBase'));
MissingWBIF := count(jWBIF); 
jWBIF_out := IF(MissingWBIF > 0, FAIL(MissingWBIF + ' World_Bank_Ineligible_Firms_InRaw_notbase'));
output(jWBIF,named('World_Bank_Ineligible_Firms_InRaw_notbase'));
//10============================================================================================
// OSFI - Canada Individuals  
  OSFIRaw := GlobalWatchLists_Preprocess.Files.dsOSFICanadaInd(	TRIM(row_data, left, right) <> u'' and
   																						regexfind(u'[a-z,A-Z,0-9]', row_data) = true and
   																						STD.Uni.Find(row_data, u'Consolidated List of Names subject', 1) = 0 and
   																						STD.Uni.Find(row_data, u'PART A  - INDIVIDUALS', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Names added to the list', 1) = 0 and
																							STD.Uni.Find(row_data, u'Last Name', 1) = 0 and
   																						STD.Uni.Find(row_data, u'This consolidated list has a number ', 1) = 0 and
   																						STD.Uni.Find(row_data, u'http://www.osfi.gc.ca', 1) = 0 and
																							STD.Uni.Find(row_data, u'Features of this list which are', 1) = 0 and
   																						STD.Uni.Find(row_data, u'numbering each person', 1) =0 and
																							STD.Uni.Find(row_data, u'removing honorifics', 1) =0 and
																							STD.Uni.Find(row_data, u'removing the column', 1) =0 and
																							STD.Uni.Find(row_data, u'having separate columns', 1) =0 and
																							STD.Uni.Find(row_data, u'and other cultures, such as Chinese', 1) =0 and
																							STD.Uni.Find(row_data, u'sometimes when individuals deal', 1) =0 and
																							STD.Uni.Find(row_data, u'searches we have recommended', 1) =0 and
																							STD.Uni.Find(row_data, u'Similarly, as many of the names', 1) =0 and
																							STD.Uni.Find(row_data, u'grounds for suspicion do not rely', 1) =0 and
																							STD.Uni.Find(row_data, u'where an alternate spelling appears', 1) =0 and
																							STD.Uni.Find(row_data, u'ID number reflects each individual', 1) = 0 and
																							STD.Uni.Find(row_data, u'Date of Birth is listed in order of', 1) = 0 and
																							STD.Uni.Find(row_data, u'Basis includes only a date', 1) = 0 and
																							STD.Uni.Find(row_data, u'is included on the UN list', 1) = 0 and
																							STD.Uni.Find(row_data, u'DISCLAIMER: This list has been prepared', 1) = 0 and
																							STD.Uni.Find(row_data, u'Acts as passed by Parliament', 1) = 0 and
																							STD.Uni.Find(row_data, u'of the Privy Council and published', 1) = 0 and
																							STD.Uni.Find(row_data, u'Links to the United Nations Act', 1) = 0 and
																							STD.Uni.Find(row_data, u'This file is also available in a .txt format', 1) = 0 and
																							STD.Uni.Find(row_data, u'One name aliases are not included in the', 1) = 0 and
																							STD.Uni.Find(row_data, u'For purposes of', 1) = 0 and
																							STD.Uni.Find(row_data, u'"Hadji", Haji", and "Maulavi"', 1) = 0 and
																							STD.Uni.Find(row_data, u'The Basis includes dates when the name or related identifying information ', 1) = 0 and
																							STD.Uni.Find(row_data, u'However, sometimes when individuals deal with countries such as Canada',1) = 0 and
																							STD.Uni.Find(row_data, u'One name aliases are not included', 1) = 0 and
																							STD.Uni.Find(row_data, u'2 In Arabic ', 1) = 0 and
																							STD.Uni.Find(row_data, u'7.03 Abdul Manan Agha Title', 1) = 0);
  OSFIBase  := ProdBase(source = 'OSFI - Canada Individuals');			
	
	jOSFI:= join(OSFIRaw,OSFIBase,
             (string)left.row_data[1..STD.Uni.Find(left.row_data, u'\t',1) - 1] = right.entity_id,
             left only);
						 
// output(count(OSFIRaw),named('Cnt_OSFICanadaIndividuals_raw')); 
// output(count(OSFIBase),named('Cnt_OSFICanadaIndividuals_Base'));
MissingOSFI := count(jOSFI); 
jOSFI_out := IF(MissingOSFI > 0, FAIL(MissingOSFI + ' Cnt_OSFICanadaIndividuals_InRaw_notBase'));
output(jOSFI,named('Cnt_OSFICanadaIndividuals_InRaw_notBase'));
//11============================================================================================
// Bank of England Sanctions		
  BOERaw   := GlobalWatchlists_Preprocess.Files.dsBankOfEngland;
  BOEBase  := ProdBase(source = 'Bank of England Sanctions');			
	
	jBOE:= join(BOERaw,BOEBase,
	            'BES' + TRIM(left.Group_ID, left, right) = right.pty_key ,
              left only);
						
// output(count(BOERaw()),named('Cnt_BankofEnglandSanctions_Raw')); 
// output(count(BOEBase) ,named('Cnt_BankofEnglandSanctions_Base'));
MissingBOE	:= count(jBOE); 
jBOE_out := IF(MissingBOE > 0, FAIL(MissingBOE + ' BankofEnglandSanctions_NAME_InRaw_notBase'));
output(jBOE,named('BankofEnglandSanctions_NAME_InRaw_notBase'));
//12============================================================================================
// Interpol Most Wanted - Red Notice

  IMWRNRaw   := GlobalWatchLists_Preprocess.Files.dsInterpolMostWantedINT;
  IMWRNBase  := ProdBase(source = 'Interpol Most Wanted - Red Notice');			
	
	jIMWRN:= join(IMWRNRaw,IMWRNBase,
             'INT' + (string)((integer)regexreplace('^92', left.Serial_Number, '')) = right.pty_key,
             left only);
						 
// output(count(IMWRNRaw()),named('Cnt_Interpol_Most_Wanted_REDN_Raw')); 
// output(count(IMWRNBase()),named('Cnt_Interpol_Most_Wanted_REDN_Base')); 
MissingIMWRN := count(jIMWRN);
jIMWRN_out := IF(MissingIMWRN > 0, FAIL(MissingIMWRN + ' Interpol_Most_Wanted_REDN_InRaw_notbase'));
output(jIMWRN,named('Interpol_Most_Wanted_REDN_InRaw_notbase'));
//13============================================================================================
// Interpol Most Wanted 
  IMWRaw   := GlobalWatchLists_Preprocess.Files.dsInterpolMostWanted;
  IMWBase  := ProdBase(source = 'Interpol Most Wanted');		
	
	jIMW:= join(IMWRaw,IMWBase,
              if(STD.Str.Find(left.ID, '/', 1) > 0
															,left.ID[9..18]
															,STD.Str.Filter(left.ID, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')) = right.entity_id,
             left only);
						 
// output(count(IMWRaw()),named('Cnt_Interpol_Most_Wanted_raw')); 
// output(count(IMWBase()),named('Cnt_Interpol_Most_Wanted_Base'));
MissingIMW	:= count(jIMW); 
jIMW_out := IF(MissingIMW > 0, FAIL(MissingIMW + ' Interpol_Most_Wanted_InRaw_notbase'));
output(jIMW,named('Interpol_Most_Wanted_InRaw_notbase'));
//14============================================================================================
// Financial Crimes Enforcement Network Special Alert List
  FCENSALBase  := ProdBase(source = 'Financial Crimes Enforcement Network Special Alert List');		//historical file.  No processing done	
	// output(FCENSALBase());
//15============================================================================================
// Office of Foreign Asset Control

  OFACRaw  := GlobalWatchLists_Preprocess.Files.dsOFACPrimary;
  OFACBase  := ProdBase(source = 'Office of Foreign Asset Control');				
	
	jOFAC:= join(OFACRaw,OFACBase,
              'OFAC' + left.sdn_id = right.pty_key,
              left only);
						 
// output(count(OFACRaw()),named('Cnt_Office_Foreign_Asset_Controlraw')); 
// output(count(OFACBase()),named('Cnt_Office_Foreign_Asset_ControlBase'));
MissingOFAC	:= count(jOFAC); 
jOFAC_out := IF(MissingOFAC > 0, FAIL(MissingOFAC + ' Office_Foreign_Asset_Control_InRaw_notbase'));
output(jOFAC,named('Office_Foreign_Asset_Control_InRaw_notbase'));
//16============================================================================================
// OFAC - Palestinian Legislative Council
 OFACPLCRaw	:= DATASET(GlobalWatchLists_Preprocess.root+'ofac::new_plc',GlobalWatchLists_Preprocess.Layouts.rInputOFAC,CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n']),QUOTE('"')));
 OFACPLCBase  := ProdBase(source = 'OFAC - Palestinian Legislative Council');			
		
	jOFACPLC:= join(OFACPLCRaw,OFACPLCBase,
                  'OFAC'+left.row_data[STD.Str.Find(left.row_data, '|', 1) + 1..STD.Str.Find(left.row_data, '|', 2) - 1] = right.pty_key,
                 left only);
								 
// output(count(OFACPLCRaw()),named('CntUS_OFAC_PLC_raw')); 
// output(count(OFACPLCBase()),named('CntUS_OFAC_PLC_base'));
MissingOFACPLC := count(jOFACPLC); 
jOFACPLC_out := IF(MissingOFACPLC > 0, FAIL(MissingOFACPLC + ' US_OFAC_PLC_InRaw_notbase'));
output(jOFACPLC,named('US_OFAC_PLC_InRaw_notbase'));
//17============================================================================================
// State Department Foreign Terrorist Organizations
 SDFTORaw   := GlobalWatchLists_Preprocess.Files.dsStDeptTerrorist(~REGEXFIND('(^Loading |^Orignal |^Number |^Author |^Writing |^Minrow=0 |Extract Date)(.*)',Organization)
																																	and trim(Organization,all) <> '');
 SDFTOBase  := ProdBase(source = 'State Department Foreign Terrorist Organizations');		
	
	jSDFTO:= join(SDFTORaw,SDFTOBase,
             stringlib.stringtouppercase(left.organization) = right.orig_pty_name,
             left only);
						 
// output(count(SDFTORaw()),named('Cnt_St_Dept_Foreign_Terroristraw')); 
// output(count(SDFTOBase()),named('Cnt_St_Dept_Foreign_TerroristBase'));
MissingSDFTO	:= count(jSDFTO);
jSDFTO_out := IF(MissingSDFTO > 0, FAIL(MissingSDFTO + ' St_Dept_Foreign_Terrorist_InRaw_notbase'));
output(jSDFTO,named('St_Dept_Foreign_Terrorist_InRaw_notbase'));
//18============================================================================================
// Defense Trade Controls (DTC)Debarred Parties
  DTCRaw   := GlobalWatchLists_Preprocess.Files.dsDebarredParties;
  DTCBase  := ProdBase(source = 'Defense Trade Controls (DTC)Debarred Parties');			
	
	jDTC:= join(GlobalWatchLists_Preprocess.Files.dsDebarredParties,
							DTCBase,
             ut.CleanSpacesAndUpper(regexreplace('(.*) [(](.*)',left.name_info,'$1')) = regexreplace('(.*) [(](.*)',right.orig_pty_name,'$1'),
             left only);
						 
// output(count(DTCRaw()),named('Cnt_Defense_Trade_Controls_raw')); 
// output(count(DTCBase()),named('Cnt_Defense_Trade_Controls_Base'));
MissingDTC := count(jDTC); 
jDTC_out := IF(MissingDTC > 0, FAIL(MissingDTC + ' Defense_Trade_Controls_InRaw_notbase'));
output(jDTC,named('Defense_Trade_Controls_InRaw_notbase'));
//19============================================================================================
// US Bureau of Industry and Security - Denied Entity List
  UBISDERaw   := GlobalWatchLists_Preprocess.Files.dsDeniedEntity;
  UBISDEBase  := ProdBase(source = 'US Bureau of Industry and Security - Denied Entity List');			

	CleanPrimaryName(string name)	:= FUNCTION
		clnName				:= REGEXREPLACE('A.K.A.|A.K.A|F.K.A.',ut.CleanSpacesAndUpper(REGEXREPLACE('^,|^-|^\\((A.K.A|F.K.A)',TRIM(name,left,right),'',NOCASE)),'AKA');
		RmvAKA				:= IF(REGEXFIND('\\(AKA [A-Z]+\\)',clnName),REGEXREPLACE('\\)$',REGEXREPLACE('\\(AKA [A-Z]+\\)',clnName,''),''),
												IF(REGEXFIND('AKA(.*)$',clnName),REGEXREPLACE('AKA(.*)$',clnName,''),clnName));
		PrimaryName		:= STD.Str.CleanSpaces(REGEXREPLACE('^THE FOLLOWING|^,|;$|,$| \\($',RmvAKA,''));
		RETURN PrimaryName;
	END;
	
	jUBISDE:= join(UBISDERaw,UBISDEBase,
                 MAP(stringlib.stringfind(left.entities,'~',1) >0 => CleanPrimaryName(left.entities[1..stringlib.stringfind(left.entities,'~',1)-1]),
								     stringlib.stringfind(left.entities,'>',1) >0 => CleanPrimaryName(stringlib.stringtouppercase(left.entities)[1..stringlib.stringfind(left.entities,'>',1)-1]),
										 CleanPrimaryName(left.entities))[1..100] = right.orig_pty_name[1..100],
									left only);
						 
// output(count(UBISDERaw()),named('Cnt_US_BureauofIndustryandSecurityDE_raw')); 
// output(count(UBISDEBase()),named('Cnt_US_BureauofIndustryandSecurityDE_base'));
MissingUBISDE := count(jUBISDE); 
jUBISDE_out := IF(MissingUBISDE > 0, FAIL(MissingUBISDE + ' US_BureauofIndustryandSecurity_InRaw_notbaseDE'));
output(jUBISDE,named('US_BureauofIndustryandSecurity_InRaw_notbaseDE'));
//20============================================================================================
// US Bureau of Industry and Security Unverified Entity List
  UBISUERaw   := GlobalWatchLists_Preprocess.Files.dsUnverified(trim(lstd_entity_address) <> '');
  UBISUEBase  := ProdBase(source = 'US Bureau of Industry and Security Unverified Entity List');			
	
parse_names(string plstd_entity_address) := function
		ClnEntity					:= IF(STD.Str.Find(plstd_entity_address, ', Inc.',1) > 0
													,STD.Str.FindReplace(plstd_entity_address, ', Inc.',' Inc.')
													,IF(STD.Str.Find(plstd_entity_address, ', Ltd.',1) > 0
														,STD.Str.FindReplace(plstd_entity_address, ', Ltd.',' Ltd.'),plstd_entity_address));
		lstd_entity 	:= ut.CleanSpacesAndUpper(ClnEntity[1..STD.Str.Find(ClnEntity,',',1) - 1]);
		return(lstd_entity);
end;
		
	jUBISUE:= join(UBISUERaw,UBISUEBase,
                 parse_names(left.lstd_entity_address) = right.orig_pty_name,
                 left only);
								 
// output(count(UBISUERaw()),named('CntUS_BureauofIndustryandSecurityUNVerified_raw')); 
// output(count(UBISUEBase()),named('CntUS_BureauofIndustryandSecurityUNVerified_base'));
MissingUBISUE := count(jUBISUE);
jUBISUE_out := IF(MissingUBISUE > 0, FAIL(MissingUBISUE + ' US_BureauofIndustryandSecurityUNVerified_InRaw_notbase'));
output(jUBISUE,named('US_BureauofIndustryandSecurityUNVerified_InRaw_notbase'));
//21============================================================================================
// OFAC Sanctioned Countries
  OFACSCRaw	:= GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsOSC;
  OFACSCBase  := ProdBase(source = 'OFAC Sanctioned Countries');			
	
		
	jOFACSC:= join(OFACSCRaw,OFACSCBase,
                 ut.CleanSpacesAndUpper(left.Original_Primary_Name_01 + left.Original_Primary_Name_02) = trim(right.orig_pty_name,left,right),
                 left only);
								 
// output(count(OFACSCRaw()),named('CntUS_OFAC_SanctionedCountries_raw')); 
// output(count(OFACSCBase()),named('CntUS_OFAC_SanctionedCountries_base'));
MissingOFACSC := count(jOFACSC); 
jOFACSC_out := IF(MissingOFACSC > 0, FAIL(MissingOFACSC + ' US_OFAC_SanctionedCountries_InRaw_notbase'));
output(jOFACSC,named('US_OFAC_SanctionedCountries_InRaw_notbase'));
//22============================================================================================
// FBI Fugitives 10 Most Wanted  
  FBIMWRaw	:= GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsFBI;
  FBIMWBase := ProdBase(source = 'FBI Fugitives 10 Most Wanted');			
	
		
	jFBIMW:= join(FBIMWRaw,FBIMWBase,
                 ut.CleanSpacesAndUpper(left.Application_Code + left.Serial_Number) = trim(right.entity_id,left,right),
                 left only);
								 
// output(count(FBIMWRaw()),named('CntUS_FBIFugitives_raw')); 
// output(count(FBIMWBase()),named('CntUS_FBIFugitives_base'));
MissingFBIMW := count(jFBIMW); 
jFBIMW_out := IF(MissingFBIMW > 0, FAIL(MissingFBIMW + ' US_FBIFugitives_InRaw_notbase'));
output(jFBIMW,named('US_FBIFugitives_InRaw_notbase'));
//23============================================================================================
// Cmmdty. Fut. Trad. Commission Lst. of Reg. & Self-Reg. Auth  
  CFTRaw	:= GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsCFT;
  CFTBase := ProdBase(source = 'Cmmdty. Fut. Trad. Commission Lst. of Reg. & Self-Reg. Auth.');			
		
	jCFT:= join(CFTRaw,CFTBase,
                 left.Application_Code + left.Serial_Number = trim(right.entity_id,left,right),
                 left only);
								 
// output(count(CFTRaw()),named('CntCmmdtyFutTradeCommission_raw')); 
// output(count(CFTBase()),named('CntCmmdtyFutTradeCommission_base'));
MissingCFT := count(jCFT); 
jCFT_out := IF(MissingCFT > 0, FAIL(MissingCFT + ' CmmdtyFutTradeCommission_InRaw_notbase'));
output(jCFT,named('CmmdtyFutTradeCommission_InRaw_notbase'));
//24============================================================================================
// OSFI - Canada Entities  
  OSFICERaw	:= GlobalWatchLists_Preprocess.Files.dsOSFICanadaEnt(TRIM(row_data, left, right) <> u'' and
   																						regexfind(u'[a-z,A-Z,0-9]', row_data) = true and
   																						STD.Uni.Find(row_data, u'Consolidated List of Names subject', 1) = 0 and
   																						STD.Uni.Find(row_data, u'or the United Nations Al-Qaida and Taliban Regulations', 1) = 0 and
   																						STD.Uni.Find(row_data, u'http://www.osfi-bsif.gc.ca', 1) = 0 and
   																						STD.Uni.Find(row_data, u'PART B ', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Names added to the list', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Entity	Address', 1) = 0 and
   																						STD.Uni.Find(row_data, u'This consolidated list has a number ', 1) = 0 and
   																						STD.Uni.Find(row_data, u'http://www.osfi.gc.ca', 1) = 0 and
   																						STD.Uni.Find(row_data, u'ID number reflects each entity', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Basis includes', 1) = 0 and
   																						STD.Uni.Find(row_data, u'is included on the UN list', 1) = 0 and
   																						STD.Uni.Find(row_data, u'the listing was changed to all of', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Minus the National Council of Resistance', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Only the Pakistan and Afghanistan offices', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Only the Somalia, Bosnia-Herzegovina', 1) = 0 and
   																						STD.Uni.Find(row_data, u'DISCLAIMER: This list has been prepared', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Acts as passed by Parliament', 1) = 0 and
   																						STD.Uni.Find(row_data, u'of the Privy Council and published', 1) = 0 and
   																						STD.Uni.Find(row_data, u'Links to the United Nations Act', 1) = 0);
  OSFICEBase := ProdBase(source = 'OSFI - Canada Entities');			
	
		
	jOSFICE:= join(OSFICERaw,OSFICEBase,
                 (string)left.row_data[1..STD.Uni.Find(left.row_data, u'\t',1) - 1] = right.entity_id,
                 left only);
								 
// output(count(OSFICERaw()),named('CntOSFICanadaEntities_raw')); 
// output(count(OSFICEBase()),named('CntOSFICanadaEntities_base'));
MissingOSFICE := count(jOSFICE); 
jOSFICE_out := IF(MissingOSFICE > 0, FAIL(MissingOSFICE + ' OSFICanadaEntities_InRaw_notbase'));
output(jOSFICE,named('OSFICanadaEntities_InRaw_notbase'));

EXPORT ValidateRawName_to_Base := SEQUENTIAL(jDP_out,jISOCC_out,jSDT_out,jEUDTI_out,jEUDTG_out,jFARA_out,jUNNT_out,jPEP_out,jWBIF_out,
																						jOSFI_out,jBOE_out,jIMWRN_out,jIMW_out,jOFAC_out,jOFACPLC_out,jSDFTO_out,jDTC_out,jUBISDE_out,
																						jUBISUE_out,jOFACSC_out,jFBIMW_out,jCFT_out,jOSFICE_out)
																: SUCCESS(output('ALL RAW RECORDS FOUND IN BASE')),
																FAILURE(FileServices.sendemail(GlobalWatchLists_Preprocess.Notification_Email_Address,'GLOBAL WATCH LISTS RECORDS MISSING FROM BASE. WU#: '+ workunit, failmessage));