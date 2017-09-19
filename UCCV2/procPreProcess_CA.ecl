export procPreProcess_CA(string filedate) := function

dsInput	:=	UCCV2.File_CA_ALL_In;

fGetFilingType(string code)	:=	function
	string145 FilingType	:=	map(code = '1' => 'FINANCING STATEMENT',
																code = '2' => 'PUBLIC FINANCE TRANSACTION',
																code = '3' => 'MANUFACTURED HOME TRANSACTION',
																code = '4' => 'TRANSMITTING UTILITY',
																code = '5' => 'FEDERAL TAX LIEN',
																code = '6' => 'FEDERAL ESTATE TAX LIEN',
																code = '7' => 'PENSION BENEFIT LIEN',
																code = '8' => 'STATE TAX LIEN',
																code = '9' => 'JUDGMENT LIEN',
																code = '10' => 'ATTACHMENT LIEN',
																code = '11' => 'DAIRY CATTLE LIEN',
																code = '12' => 'FISH/POULTRY LIEN',
																code = '13' => 'CHEMICAL SEED LIEN',
																code = '14' => 'EQUIPMENT REPURCHASE LIEN',
																code = '15' => 'LIVESTOCK LIEN',
																''
																);
	return FilingType;
end;

UCCV2.Layout_File_CA_Filing_Master_in	trfFiling(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.record_type						:=	pInput.line[1];
	self.initial_filing_number	:=	pInput.line[2..15];
	self.ucc_filing_type_desc		:=	fGetFilingType(trim(pInput.line[28..32],left,right));
	self.static									:=	if ((integer)pInput.line[16..27] = 0,
																					'',
																					pInput.line[16..27]
																			);	
	self.initial_filing_type		:=	pInput.line[28..32];
	self.filing_date						:=	pInput.line[33..40];	
	self.filing_time						:=	pInput.line[41..44];	
	self.filing_status					:=	pInput.line[45..45];	
	self.ucc_status_desc				:=	map(pInput.line[45] = 'A' => 'ACTIVE',
																			pInput.line[45] = 'L' => 'LAPSED',
																			pInput.line[45] = 'D' => 'DELETED',
																			pInput.line[45] = 'E' => 'EXPUNGED',
																			''
																			);	
	self.lapse_date							:=	pInput.line[46..53];	
	self.page_count							:=	pInput.line[54..57];	
	self.internal_document_no		:=	pInput.line[58..77];	
end;
	
FilingMasterIn						:=	project(dsInput(line[1]='1'),trfFiling(left));	
										 
FilingMaster							:=	output(FilingMasterIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::initialfiling',overwrite);
AddSuperFiling						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::initialfiling','~thor_data400::in::uccv2::'+filedate+'::ca::initialfiling');
AddSuperFilingProcessed		:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::initialfiling::processed','~thor_data400::in::uccv2::'+filedate+'::ca::initialfiling');

UCCV2.Layout_File_CA_BusinessDebtor_in	trfBusDebtor(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.record_type						:=	pInput.line[1];
	self.initial_filing_number	:=	pInput.line[2..15];
	self.static									:=	if ((integer)pInput.line[16..27] = 0,
																					'',
																					pInput.line[16..27]
																			);
	self.bd_name								:=	StringLib.StringToUpperCase(pInput.line[28..327]);
	self.bd_st_address					:=	StringLib.StringToUpperCase(pInput.line[328..437]);
	self.bd_city								:=	StringLib.StringToUpperCase(pInput.line[438..501]);
	self.bd_state								:=	StringLib.StringToUpperCase(pInput.line[502..533]);
	self.bd_zip									:=	pInput.line[534..548];
	self.bd_zip_extn						:=	pInput.line[549..554];
	self.bd_country_code				:=	StringLib.StringToUpperCase(pInput.line[555..575]);
	self.prep_addr_line1				:=	StringLib.StringToUpperCase(pInput.line[328..437]);
	self.prep_addr_last_line		:=	if	(pInput.line[438..501] != '',
																					StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[438..501]) + ', ' + trim(pInput.line[502..533]) + ' ' + trim(pInput.line[534..538]))),
																					StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[502..533]) + ' ' + trim(pInput.line[534..538])))
																			);	
end;
	
BusDebtorIn	:=	project(dsInput(line[1]='2'),trfBusDebtor(left));

BusDebtor										:=	output(BusDebtorIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::businessdebtor',overwrite);
AddSuperBusDebtor						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::businessdebtor','~thor_data400::in::uccv2::'+filedate+'::ca::businessdebtor');
AddSuperBusDebtorProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::businessdebtor::processed','~thor_data400::in::uccv2::'+filedate+'::ca::businessdebtor');

UCCV2.Layout_File_CA_PersonDebtor_in	trfPerDebtor(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.record_type						:=	pInput.line[1];
	self.initial_filing_number	:=	pInput.line[2..15];
	self.static									:=	if ((integer)pInput.line[16..27] = 0,
																					'',
																					pInput.line[16..27]
																			);																			
	self.pd_last_name						:=	StringLib.StringToUpperCase(pInput.line[28..77]);
	self.pd_first_name					:=	StringLib.StringToUpperCase(pInput.line[78..127]);
	self.pd_middle_name					:=	StringLib.StringToUpperCase(pInput.line[128..177]);
	self.pd_suffix							:=	StringLib.StringToUpperCase(pInput.line[178..183]);
	self.pd_st_address					:=	StringLib.StringToUpperCase(pInput.line[184..293]);
	self.pd_city								:=	StringLib.StringToUpperCase(pInput.line[294..357]);	
	self.pd_state								:=	StringLib.StringToUpperCase(pInput.line[358..389]);
	self.pd_zip									:=	pInput.line[390..404];
	self.pd_zip_extn						:=	if ((integer)pInput.line[405..410] = 0,
																					'',
																					pInput.line[405..410]
																			);
	self.pd_country_code				:=	StringLib.StringToUpperCase(pInput.line[411..413]);		
	self.prep_addr_line1				:=	StringLib.StringToUpperCase(pInput.line[184..293]);
	self.prep_addr_last_line		:=	if	(pInput.line[294..357] != '',
																					StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[294..357]) + ', ' + trim(pInput.line[358..389]) + ' ' + trim(pInput.line[390..394]))),
																					StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[358..389]) + ' ' + trim(pInput.line[390..394])))
																			);		
end;
	
PersonDebtorIn								:=	project(dsInput(line[1]='3'),trfPerDebtor(left));

PersonDebtor									:=	output(PersonDebtorIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::persondebtor',overwrite);
AddSuperPersonDebtor					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::persondebtor','~thor_data400::in::uccv2::'+filedate+'::ca::persondebtor');
AddSuperPersonDebtorProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::persondebtor::processed','~thor_data400::in::uccv2::'+filedate+'::ca::persondebtor');

UCCV2.Layout_File_CA_BusinessSecuredParty_in	trfBusSP(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.record_type						:=	pInput.line[1];
	self.initial_filing_number	:=	pInput.line[2..15];
	self.static									:=	if ((integer)pInput.line[16..27] = 0,
																					'',
																					pInput.line[16..27]
																			);																			
	self.bs_name								:=	StringLib.StringToUpperCase(pInput.line[28..327]);
	self.bs_st_address					:=	StringLib.StringToUpperCase(pInput.line[328..437]);
	self.bs_city								:=	StringLib.StringToUpperCase(pInput.line[438..501]);
	self.bs_state								:=	StringLib.StringToUpperCase(pInput.line[502..533]);
	self.bs_zip									:=	pInput.line[534..548];
	self.bs_zip_extn						:=	if ((integer)pInput.line[549..554] = 0,
																					'',
																					pInput.line[549..554]
																			);
	self.bs_country_code				:=	StringLib.StringToUpperCase(pInput.line[555..557]);	
	self.prep_addr_line1				:=	StringLib.StringToUpperCase(pInput.line[328..437]);
	self.prep_addr_last_line		:=	if	(pInput.line[438..501] != '',
																					StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[438..501]) + ', ' + trim(pInput.line[502..533]) + ' ' + trim(pInput.line[534..538]))),
																					StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[502..533]) + ' ' + trim(pInput.line[534..538])))
																			);	
end;
	
BusSPIn														:=	project(dsInput(line[1]='4'),trfBusSP(left));

BusinessSecuredp									:=	output(BusSPIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::businesssecuredp',overwrite);
AddSuperBusinessSecuredp					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::businesssecuredp','~thor_data400::in::uccv2::'+filedate+'::ca::businesssecuredp');
AddSuperBusinessSecuredpProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::businesssecuredp::processed','~thor_data400::in::uccv2::'+filedate+'::ca::businesssecuredp');

UCCV2.Layout_File_CA_PersonSecuredParty_in	trfPerSP(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.record_type						:=	pInput.line[1];
	self.initial_filing_number	:=	pInput.line[2..15];
	self.static									:=	if ((integer)pInput.line[16..27] = 0,
																					'',
																					pInput.line[16..27]
																			);																			
	self.ps_last_name						:=	StringLib.StringToUpperCase(pInput.line[28..77]);
	self.ps_first_name					:=	StringLib.StringToUpperCase(pInput.line[78..127]);
	self.ps_middle_name					:=	StringLib.StringToUpperCase(pInput.line[128..177]);
	self.ps_suffix							:=	StringLib.StringToUpperCase(pInput.line[178..183]);
	self.ps_st_address					:=	StringLib.StringToUpperCase(pInput.line[184..293]);
	self.ps_city								:=	StringLib.StringToUpperCase(pInput.line[294..357]);
	self.ps_state								:=	StringLib.StringToUpperCase(pInput.line[358..389]);
	self.ps_zip									:=	pInput.line[390..404];
	self.ps_zip_extn						:=	if ((integer)pInput.line[405..410] = 0,
																					'',
																					pInput.line[405..410]
																			);
	self.ps_country_code				:=	StringLib.StringToUpperCase(pInput.line[411..413]);
	self.prep_addr_line1				:=	StringLib.StringToUpperCase(pInput.line[184..293]);
	self.prep_addr_last_line		:=	if	(pInput.line[294..357] != '',
																					StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[294..357]) + ', ' + trim(pInput.line[358..389]) + ' ' + trim(pInput.line[390..394]))),
																					StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[358..389]) + ' ' + trim(pInput.line[390..394])))
																			);		
end;
	
PerSPIn													:=	project(dsInput(line[1]='5'),trfPerSP(left));

PersonSecuredp									:=	output(PerSPIn,,'~thor_data400::in::uccv2::'+filedate+'::ca::personsecuredp',overwrite);
AddSuperPersonSecuredp					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::personsecuredp','~thor_data400::in::uccv2::'+filedate+'::ca::personsecuredp');
AddSuperPersonSecuredpProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::personsecuredp::processed','~thor_data400::in::uccv2::'+filedate+'::ca::personsecuredp');

fGetFilingDesc(string code)	:=	function
	string145 FilingDesc	:=	map(code = '2' 		=> 'FILING OFFICER STATEMENT',
																code = '3' 		=> 'FULL MASTER AMENDMENT',
																code = '4' 		=> 'FULL MASTER ASSIGNMENT',
																code = '5' 		=> 'TERMINATION',
																code = '6' 		=> 'CONTINUATION',
																code = '7' 		=> 'ASSIGNMENT',
																code = '8' 		=> 'AMENDMENT',
																code = '9' 		=> 'CORRECTION STATEMENT',
																code = '10' 	=> 'COURT ORDER',
																code = '11' 	=> 'COURT ORDER NO CHANGE',
																code = '13' 	=> 'FILING OFFICER STATEMENT',
																code = '14' 	=> 'FULL MASTER AMENDMENT',
																code = '15' 	=> 'FULL MASTER ASSIGNMENT',
																code = '16' 	=> 'TERMINATION',
																code = '17' 	=> 'CONTINUATION',
																code = '18' 	=> 'ASSIGNMENT',
																code = '19' 	=> 'AMENDMENT',
																code = '20' 	=> 'CORRECTION STATEMENT',
																code = '21' 	=> 'COURT ORDER',
																code = '22' 	=> 'COURT ORDER NO CHANGE',
																code = '24' 	=> 'FILING OFFICER STATEMENT',
																code = '25' 	=> 'FULL MASTER AMENDMENT',
																code = '26' 	=> 'FULL MASTER ASSIGNMENT',
																code = '27' 	=> 'TERMINATION',
																code = '28' 	=> 'CONTINUATION',
																code = '29' 	=> 'ASSIGNMENT',
																code = '30' 	=> 'AMENDMENT',
																code = '31' 	=> 'CORRECTION STATEMENT',
																code = '32' 	=> 'COURT ORDER',
																code = '33' 	=> 'COURT ORDER NO CHANGE',
																code = '35' 	=> 'FILING OFFICER STATEMENT',
																code = '36' 	=> 'FULL MASTER AMENDMENT',
																code = '37' 	=> 'FULL MASTER ASSIGNMENT',
																code = '38' 	=> 'TERMINATION',
																code = '39' 	=> 'ASSIGNMENT',
																code = '40' 	=> 'AMENDMENT',
																code = '41' 	=> 'CORRECTION STATEMENT',
																code = '42' 	=> 'COURT ORDER',
																code = '43' 	=> 'COURT ORDER NO CHANGE',
																code = '45' 	=> 'FILING OFFICER STATEMENT',
																code = '46' 	=> 'FULL MASTER AMENDMENT',
																code = '48' 	=> 'TERMINATION',
																code = '49' 	=> 'CONTINUATION',
																code = '50' 	=> 'AMENDMENT',
																code = '51' 	=> 'COURT ORDER',
																code = '52' 	=> 'COURT ORDER NO CHANGE',
																code = '54' 	=> 'FILING OFFICER STATEMENT',
																code = '55' 	=> 'FULL MASTER AMENDMENT',
																code = '57' 	=> 'TERMINATION',
																code = '58' 	=> 'CONTINUATION',
																code = '59' 	=> 'AMENDMENT',
																code = '60' 	=> 'COURT ORDER',
																code = '61' 	=> 'COURT ORDER NO CHANGE',
																code = '63' 	=> 'FILING OFFICER STATEMENT',
																code = '64' 	=> 'FULL MASTER AMENDMENT',
																code = '66' 	=> 'TERMINATION',
																code = '67' 	=> 'CONTINUATION',
																code = '68' 	=> 'AMENDMENT',
																code = '69' 	=> 'COURT ORDER',
																code = '70' 	=> 'COURT ORDER NO CHANGE',
																code = '72' 	=> 'FILING OFFICER STATEMENT',
																code = '73' 	=> 'FULL MASTER AMENDMENT',
																code = '75' 	=> 'ERRONEOUS TERMINATION',
																code = '76' 	=> 'CONTINUATION',
																code = '77' 	=> 'AMENDMENT',
																code = '78' 	=> 'COURT ORDER',
																code = '79' 	=> 'COURT ORDER NO CHANGE',
																code = '81' 	=> 'FILING OFFICER STATEMENT',
																code = '82' 	=> 'FULL MASTER AMENDMENT',
																code = '84' 	=> 'TERMINATION',
																code = '85' 	=> 'AMENDMENT',
																code = '86' 	=> 'COURT ORDER',
																code = '87' 	=> 'COURT ORDER NO CHANGE',
																code = '89' 	=> 'FILING OFFICER STATEMENT',
																code = '90' 	=> 'FULL MASTER AMENDMENT',
																code = '92' 	=> 'TERMINATION',
																code = '93' 	=> 'CONTINUATION',
																code = '94' 	=> 'AMENDMENT',
																code = '95' 	=> 'COURT ORDER',
																code = '96' 	=> 'COURT ORDER NO CHANGE',
																code = '98' 	=> 'FILING OFFICER STATEMENT',
																code = '99' 	=> 'FULL MASTER AMENDMENT',
																code = '100' 	=> 'FULL MASTER ASSIGNMENT',
																code = '101' 	=> 'TERMINATION',
																code = '102' 	=> 'ASSIGNMENT',
																code = '103' 	=> 'CONTINUATION',
																code = '104' 	=> 'AMENDMENT',
																code = '105' 	=> 'CORRECTION STATEMENT',
																code = '106' 	=> 'COURT ORDER',
																code = '107' 	=> 'COURT ORDER NO CHANGE',
																code = '109' 	=> 'FILING OFFICER STATEMENT',
																code = '110' 	=> 'FULL MASTER AMENDMENT',
																code = '111' 	=> 'FULL MASTER ASSIGNMENT',
																code = '112' 	=> 'TERMINATION',
																code = '113' 	=> 'ASSIGNMENT',
																code = '114' 	=> 'CONTINUATION',
																code = '115' 	=> 'AMENDMENT',
																code = '116' 	=> 'CORRECTION STATEMENT',
																code = '117' 	=> 'COURT ORDER',
																code = '118' 	=> 'COURT ORDER NO CHANGE',
																code = '120' 	=> 'FILING OFFICER STATEMENT',
																code = '121' 	=> 'FULL MASTER AMENDMENT',
																code = '122' 	=> 'FULL MASTER ASSIGNMENT',
																code = '123' 	=> 'TERMINATION',
																code = '124' 	=> 'ASSIGNMENT',
																code = '125' 	=> 'CONTINUATION',
																code = '126' 	=> 'AMENDMENT',
																code = '127' 	=> 'CORRECTION STATEMENT',
																code = '128' 	=> 'COURT ORDER',
																code = '129' 	=> 'COURT ORDER NO CHANGE',
																code = '131' 	=> 'FILING OFFICER STATEMENT',
																code = '132' 	=> 'FULL MASTER AMENDMENT',
																code = '133' 	=> 'FULL MASTER ASSIGNMENT',
																code = '134' 	=> 'TERMINATION',
																code = '135' 	=> 'ASSIGNMENT',
																code = '136' 	=> 'CONTINUATION',
																code = '137' 	=> 'AMENDMENT',
																code = '138' 	=> 'CORRECTION STATEMENT',
																code = '139' 	=> 'COURT ORDER',
																code = '140' 	=> 'COURT ORDER NO CHANGE',
																code = '142' 	=> 'FILING OFFICER STATEMENT',
																code = '143' 	=> 'FULL MASTER AMENDMENT',
																code = '144' 	=> 'FULL MASTER ASSIGNMENT',
																code = '145' 	=> 'TERMINATION',
																code = '146' 	=> 'ASSIGNMENT',
																code = '147' 	=> 'CONTINUATION',
																code = '148' 	=> 'AMENDMENT',
																code = '149' 	=> 'CORRECTION STATEMENT',
																code = '150' 	=> 'COURT ORDER',
																code = '151' 	=> 'COURT ORDER NO CHANGE',
																code = '283' 	=> 'TERMINATION',
																''
																);
																
	return FilingDesc;
end;

UCCV2.Layout_File_CA_ucc3_in	trfUCC3(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date								:=	filedate;
	self.record_type								:=	pInput.line[1];
	self.initial_filing_number			:=	pInput.line[2..15];
	self.ucc3_filing								:=	pInput.line[16..27];
	self.ucc3_filing_type						:=	pInput.line[28..32];
	self.ucc3_filing_date						:=	pInput.line[33..40];
	self.ucc3_filing_time						:=	pInput.line[41..44];
	self.ucc3_page_count						:=	pInput.line[45..48];
	self.ucc3_internal_document_no	:=	pInput.line[49..68];
	self.ucc3_filing_desc						:=	fGetFilingDesc(trim(pInput.line[28..32],left,right));
end;
	
UCC3In								:=	project(dsInput(line[1]='6'),trfUCC3(left));

ucc3									:=	output(UCC3In,,'~thor_data400::in::uccv2::'+filedate+'::ca::ucc3',overwrite);
AddSuperucc3					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::ucc3','~thor_data400::in::uccv2::'+filedate+'::ca::ucc3');
AddSuperucc3Processed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::ucc3::processed','~thor_data400::in::uccv2::'+filedate+'::ca::ucc3');

// This temporary layout was added to correct an issue with Collateral being truncated. 
// The Layout_File_CA_Collateral_in layout has all_collateral defined as a string 512, but it
// needs to be a varying string until after the rollup.  JIRA DF-19839.
tempCollateralLay := record						
	string8    process_date;
	string1    record_type;
	string14   initial_filing_number;
	string12   static;
	string10   ucc3_filing_number;
	string6    collateral_line_seq_no;
	string80   collateral_desc;
	string     all_collateral; // needs to not be restricted to 512 characters until after rollup
end;

tempCollateralLay	trfCollateral(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date								:=	filedate;
	self.record_type								:=	pInput.line[1];
	self.initial_filing_number			:=	pInput.line[2..15];
	self.static											:=	if ((integer)pInput.line[16..27] = 0,
																					'',
																					pInput.line[16..27]
																			);		
	self.ucc3_filing_number					:=	pInput.line[28..37];
	self.collateral_line_seq_no			:=	pInput.line[38..43];
	self.collateral_desc						:=	StringLib.StringToUpperCase(pInput.line[44..120]);
	self.all_collateral							:=	StringLib.StringToUpperCase(pInput.line[44..120]);
end;
	
CollateralIn							:=	project(dsInput(line[1]='7'),trfCollateral(left));
srtedCollateralIn					:=	sort(CollateralIn,initial_filing_number,ucc3_filing_number,(integer)collateral_line_seq_no);

tempCollateralLay trfRollupCollateral(tempCollateralLay l, tempCollateralLay r) := transform
	self.all_collateral			:=	(l.all_collateral + ' ' + r.all_collateral);
	self										:=	l;
end;

rolledCollateralIn				:=	rollup(	srtedCollateralIn
																			,left.initial_filing_number = right.initial_filing_number and
																			 left.ucc3_filing_number = right.ucc3_filing_number
																			,trfRollupCollateral(left,right)
																		 );

UCCV2.Layout_File_CA_Collateral_in	trfCollOut(rolledCollateralIn	l)	:=	transform
	self.all_collateral			:=	StringLib.StringCleanSpaces(l.all_collateral);
	self										:=	l;
end;
	
CollateralOut							:=	project(rolledCollateralIn,trfCollOut(left));

Collateral									:=	output(CollateralOut,,'~thor_data400::in::uccv2::'+filedate+'::ca::Collateral',overwrite);
AddSupercollateral					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::Collateral','~thor_data400::in::uccv2::'+filedate+'::ca::Collateral');
AddSupercollateralProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ca::Collateral::processed','~thor_data400::in::uccv2::'+filedate+'::ca::Collateral');

																	
retval := if (fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::CA::ALL') > 0,
								parallel(	sequential( FilingMaster
																,AddSuperFiling
																,AddSuperFilingProcessed
															),
										sequential( BusDebtor
																,AddSuperBusDebtor
																,AddSuperBusDebtorProcessed
															),
										sequential( PersonDebtor
																,AddSuperPersonDebtor
																,AddSuperPersonDebtorProcessed
															),
										sequential( BusinessSecuredp
																,AddSuperBusinessSecuredp
																,AddSuperBusinessSecuredpProcessed
															),	
										sequential( PersonSecuredp
																,AddSuperPersonSecuredp
																,AddSuperPersonSecuredpProcessed
															),	
										sequential( ucc3
																,AddSuperucc3
																,AddSuperucc3Processed
															),
										sequential( Collateral
																,AddSuperCollateral
																,AddSuperCollateralProcessed
															)																
										),
										output('No new files for CA'));

 
return retval;

end;