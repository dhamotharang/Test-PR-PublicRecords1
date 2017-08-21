export procPreProcess_IL(string filedate) := function

dsInput	:=	UCCV2.File_IL_ALL_In;

fGetCollateralType(string code)	:=	function
	string145 CollateralType	:=	map(code = '01' => 'ACCOUNTS',
																		code = '02' => 'ACCOUNTS RECEIVABLE',
																		code = '03' => 'ACCOUNTS RECEIVABLE, INVENTORY',
																		code = '04' => 'ACCOUNTS RECEIVABLE, INVENTORY EQUIPMENT',
																		code = '05' => 'ACCOUNTS RECEIVABLE, INVENTORY, CONTRACT RIGHTS CHATTEL PAPER, GENERAL INTANGIBLE',
																		code = '06' => 'CONTRACT RIGHTS',
																		code = '07' => 'CROPS',
																		code = '08' => 'EQUIPMENT',
																		code = '09' => 'EQUIPMENT, INVENTORY',
																		code = '10' => 'EQUIPMENT, FIXTURES',
																		code = '11' => 'EQUIPMENT, FIXTURES, INVENTORY',
																		code = '12' => 'FIXTURES',
																		code = '13' => 'FIXTURES, EQUIPMENT, FURNISHINGS',
																		code = '14' => 'FURNISHINGS',
																		code = '15' => 'GENERAL INTANGIBLES',
																		code = '16' => 'INVENTORY',
																		code = '17' => 'LEASES',
																		code = '18' => 'LIVESTOCK',
																		code = '19' => 'MACHINERY',
																		code = '20' => 'MINERALS',
																		code = '21' => 'PERSONAL PROPERTY',
																		code = '22' => 'REAL ESTATE',
																		code = '23' => 'STOCK & BONDS',
																		code = '24' => 'TIMBER',
																		code = '25' => 'TRANSMITTING UTILITY',
																		code = '26' => 'TRUST',
																		code = '27' => 'BUSINESS BANKER LIEN',
																		''
																		);
	return CollateralType;
end;

fGetTransactionType(string code)	:=	function
	string145 TransactionType	:=	map(code = '01' => 'CONTINUATION',
																		code = '02' => 'PARTIAL RELEASE',
																		code = '03' => 'ASSIGNMENT TO A SECURED PARTY',
																		code = '04' => 'AMENDMENT TO A SECURED PARTY',
																		code = '05' => 'TERMINATION',
																		code = '06' => 'MISC AMENDMENT',
																		code = '07' => 'DEBTOR AMENDMENT (FORMAT 01)',
																		code = '08' => 'SUBORDINATION',
																		code = '09' => 'CORRECTION STATEMENT',
																		code = '10' => 'FILING OFFICER STATEMENT',
																		code = '11' => 'DEBTOR TERMED',
																		''
																		);
																		
	return TransactionType;
end;

UCCV2.Layout_File_IL_Master_in	trfFilingMaster(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.action_code						:=	pInput.line[1];
	self.multi_secured					:=	regexreplace('^0+',pInput.line[156],'');
	self.status									:=	fGetTransactionType(trim(pInput.line[157],left,right));
	self.collateral							:=	fGetCollateralType(trim(pInput.line[158..159],left,right));
	self.proceeds								:=	regexreplace('^0+',pInput.line[162],'');
	self.products								:=	regexreplace('^0+',pInput.line[163],'');
	self.financing_pages				:=	regexreplace('^0+',pInput.line[164..168],'');
	self.transaction_cnt				:=	regexreplace('^0+',pInput.line[169..171],'');
	self.husb_wife_cnt					:=	regexreplace('^0+',pInput.line[172..173],'');	
	self.file_no								:=	pInput.line[2..10];
	self.file_date							:=	pInput.line[11..18];
	self.file_time							:=	pInput.line[19..22];
	self.maturity_date					:=	pInput.line[23..30];
	self.secured_name						:=	pInput.line[31..94];
	self.secured_street					:=	pInput.line[95..126];
	self.secured_city						:=	pInput.line[127..144];
	self.secured_state					:=	pInput.line[145..146];
	self.secured_zip						:=	pInput.line[147..155];
	self.prep_addr_line1				:=	pInput.line[95..126];
	self.prep_addr_last_line		:=	if	(pInput.line[127..144] != '',
																				StringLib.StringCleanSpaces(trim(pInput.line[127..144]) + ', ' + trim(pInput.line[145..146]) + ' ' + trim(pInput.line[147..151])),
																				StringLib.StringCleanSpaces(trim(pInput.line[145..146]) + ' ' + trim(pInput.line[147..151]))
																			 );	
end;
	
FilingMasterIn						:=	project(dsInput(line[1]='M' or line[1]='A' or line[1]='C'),trfFilingMaster(left));
							 
Filing										:=	output(FilingMasterIn,,'~thor_data400::in::uccv2::'+filedate+'::il::filing',overwrite);
AddSuperFiling						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::filing','~thor_data400::in::uccv2::'+filedate+'::il::filing');
AddSuperFilingProcessed		:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::filing::processed','~thor_data400::in::uccv2::'+filedate+'::il::filing');

Collateral_Layout	:=	record	
	string2		state_origin;
	string8 	process_date;
	string1		action_code;
	string9		file_no;
	string8		file_date;
	string4		file_time;
	string8		maturity_date;
	string64	secured_name;
	string32	secured_street;
	string18	secured_city;
	string2		secured_state;
	string9		secured_zip;
	string1		multi_secured;
	string1		status;
	string4		collateral;
	string1		proceeds;
	string1		products;
	string5		financing_pages;
	string3		transaction_cnt;
	string2		husb_wife_cnt;
	string100	prep_addr_line1;
	string50	prep_addr_last_line; 
	unsigned8	RawAid	:= 0;
	unsigned8	ACEAID	:= 0;		
end;

Collateral_Layout	trfMaster(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.state_origin					:=	'IL';
	self.action_code					:=	pInput.line[1];
	self.file_no							:=	pInput.line[2..10];
	self.file_date						:=	pInput.line[11..18];
	self.file_time						:=	pInput.line[19..22];
	self.maturity_date				:=	pInput.line[23..30];
	self.secured_name					:=	pInput.line[31..94];
	self.secured_street				:=	pInput.line[95..126];
	self.secured_city					:=	pInput.line[127..144];
	self.secured_state				:=	pInput.line[145..146];
	self.secured_zip					:=	pInput.line[147..155];	
	self.multi_secured				:=	regexreplace('^0+',pInput.line[156],'');
	self.status								:=	'TERMINATION';
	self.collateral						:=	pInput.line[158..159];
	self.proceeds							:=	regexreplace('^0+',pInput.line[162],'');
	self.products							:=	regexreplace('^0+',pInput.line[163],'');
	self.financing_pages			:=	regexreplace('^0+',pInput.line[164..168],'');
	self.transaction_cnt			:=	regexreplace('^0+',pInput.line[169..171],'');
	self.husb_wife_cnt				:=	regexreplace('^0+',pInput.line[172..173],'');	
	self.process_date					:=	filedate;
	self.prep_addr_line1			:=	pInput.line[95..126];
	self.prep_addr_last_line	:=	if	(pInput.line[127..144] != '',
																				StringLib.StringCleanSpaces(trim(pInput.line[127..144]) + ', ' + trim(pInput.line[145..146]) + ' ' + trim(pInput.line[147..151])),
																				StringLib.StringCleanSpaces(trim(pInput.line[145..146]) + ' ' + trim(pInput.line[147..151]))
																		 );		
end;
	
CollateralIn								:=	project(dsInput(line[1]='D'),trfMaster(left));

Collateral									:=	output(CollateralIn,,'~thor_data400::in::uccv2::'+filedate+'::il::collateral',overwrite);
AddSuperCollateral					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::collateral','~thor_data400::in::uccv2::'+filedate+'::il::collateral');
AddSuperCollateralProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::collateral::processed','~thor_data400::in::uccv2::'+filedate+'::il::collateral');

UCCV2.Layout_File_IL_SecuredParty_in	trfSecuredParty(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.action_code					:=	pInput.line[1];
	self.file_no							:=	pInput.line[2..10];
	self.secured_name					:=	pInput.line[11..74];
	self.secured_street				:=	pInput.line[75..106];
	self.secured_city					:=	pInput.line[107..124];
	self.secured_state				:=	pInput.line[125..126];
	self.secured_zip					:=	pInput.line[127..135];
	self.process_date					:=	filedate;
	self.prep_addr_line1			:=	pInput.line[75..106];
	self.prep_addr_last_line	:=	if	(pInput.line[107..124] != '',
																				StringLib.StringCleanSpaces(trim(pInput.line[107..124]) + ', ' + trim(pInput.line[125..126]) + ' ' + trim(pInput.line[127..131])),
																				StringLib.StringCleanSpaces(trim(pInput.line[125..126]) + ' ' + trim(pInput.line[127..131]))
																		 );			
end;
	
SecuredPartyIn								:=	project(dsInput(line[1]='S'),trfSecuredParty(left));

SecuredParty									:=	output(SecuredPartyIn,,'~thor_data400::in::uccv2::'+filedate+'::il::securedparty',overwrite);
AddSuperSecuredParty					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::securedparty','~thor_data400::in::uccv2::'+filedate+'::il::securedparty');
AddSuperSecuredPartyProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::securedparty::processed','~thor_data400::in::uccv2::'+filedate+'::il::securedparty');

UCCV2.Layout_File_IL_Transaction_in	trfTransaction(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.action_code					:=	pInput.line[1];
	self.file_no							:=	pInput.line[2..10];
	self.trans_no							:=	pInput.line[11..19];
	self.trans_date						:=	pInput.line[20..27];
	self.trans_time						:=	pInput.line[28..31];
	self.trans_type						:=	fGetTransactionType(trim(pInput.line[32..33],left,right));
	self.process_date					:=	filedate;
end;
	
TransactionIn									:=	project(dsInput(line[1]='T'),trfTransaction(left));

Transaction										:=	output(TransactionIn,,'~thor_data400::in::uccv2::'+filedate+'::il::transaction',overwrite);
AddSuperTransaction						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::transaction','~thor_data400::in::uccv2::'+filedate+'::il::transaction');
AddSuperTransactionProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::transaction::processed','~thor_data400::in::uccv2::'+filedate+'::il::transaction');

UCCV2.Layout_File_IL_Debtor_in	trfDebtor(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.action_code					:=	pInput.line[1];
	self.file_no							:=	pInput.line[2..10];
	self.debtor_name_cd				:=	pInput.line[11..11];
	self.debtor_name					:=	pInput.line[12..211];
	self.debtor_street				:=	pInput.line[212..243];
	self.debtor_city					:=	pInput.line[244..261];
	self.debtor_state					:=	pInput.line[262..263];
	self.debtor_zip						:=	pInput.line[264..272];
	self.debtor_no						:=	pInput.line[273..275];
	self.debtor_ssfn					:=	pInput.line[276..284];
	self.process_date					:=	filedate;
	self.prep_addr_line1			:=	pInput.line[212..243];
	self.prep_addr_last_line	:=	if	(pInput.line[244..261] != '',
																				StringLib.StringCleanSpaces(trim(pInput.line[244..261]) + ', ' + trim(pInput.line[262..263]) + ' ' + trim(pInput.line[264..268])),
																				StringLib.StringCleanSpaces(trim(pInput.line[262..263]) + ' ' + trim(pInput.line[264..268]))
																		 );			
end;
	
DebtorIn								:=	project(dsInput(line[1]='N'),trfDebtor(left));

Debtor									:=	output(DebtorIn,,'~thor_data400::in::uccv2::'+filedate+'::il::debtor',overwrite);
AddSuperDebtor					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::debtor','~thor_data400::in::uccv2::'+filedate+'::il::debtor');
AddSuperDebtorProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::il::debtor::processed','~thor_data400::in::uccv2::'+filedate+'::il::debtor');
																	
retval := if (fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::IL::ALL') > 0,
							parallel(	sequential( Filing
																,AddSuperFiling
																,AddSuperFilingProcessed
															),
										sequential( Collateral
																,AddSuperCollateral
																,AddSuperCollateralProcessed
															),	
										sequential( SecuredParty
																,AddSuperSecuredParty
																,AddSuperSecuredPartyProcessed
															),	
										sequential( Transaction
																,AddSuperTransaction
																,AddSuperTransactionProcessed
															),
										sequential( Debtor
																,AddSuperDebtor
																,AddSuperDebtorProcessed
															)																
										),
										output('No new files available for IL')
										);

 
return retval;

end;