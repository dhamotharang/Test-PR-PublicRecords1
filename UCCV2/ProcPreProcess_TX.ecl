export ProcPreProcess_TX(string filedate) := function

dsInput	:=	UCCV2.File_TX_ALL_In;

fGetFilingType(string code)	:=	function
	string45 FilingType	:=	map(code = ''   => 	'UCC STANDARD',
															code = 'A'	=>	'AGRICULTURAL STATUTORY LIEN',
															code = 'C'	=>	'COUNTY CONTINUATION',
															code = 'F'	=>	'FEDERAL LIEN',
															code = 'M'	=>	'MANUFACTURED HOMES',
															code = 'P'	=>	'UCC PUBLIC FINANCE',
															code = 'R'	=>	'RESTITUTION LIEN',
															code = 'T'	=>	'TRANSITION PROPERTY LIEN',
															code = 'U'	=>	'UTILITY SECURITY INSTRUMENT',
															code = 'S'	=>	'UCC TRANSMITTING UTILITY',
															''
															);
															
	return FilingType;
end;

UCCV2.Layout_File_TX_Master_in	trfFilingMaster(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date							:=	filedate;
	self.transaction_code					:=	pInput.line[1];
	self.original_filing_number		:=	pInput.line[2..13];
	self.filing_type							:=	fGetFilingType(pInput.line[14]);
	self.filing_status						:=	map(pInput.line[15] = 'A' => 'ACTIVE',
																				pInput.line[15] = 'L' => 'LAPSED',
																				''
																				);
	self.expiration_date					:=	pInput.line[16..23];
	self.page_count								:=	pInput.line[24..27];
	self.document_nbr_orig_filing	:=	pInput.line[28..47];
end;

FilingMasterIn					:=	project(dsInput(line[1] = '1'),trfFilingMaster(left));

Filing									:=	output(FilingMasterIn,,'~thor_data400::in::uccv2::'+filedate+'::tx::filing',overwrite);
AddSuperFiling					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::filing','~thor_data400::in::uccv2::'+filedate+'::tx::filing');
AddSuperFilingProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::filing::processed','~thor_data400::in::uccv2::'+filedate+'::tx::filing');

UCCV2.Layout_File_TX_BusinessDebtor_in	trfB_Debtor(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date							:=	filedate;
	self.transaction_code					:=	pInput.line[1];
	self.original_filing_number		:=	pInput.line[2..13];
	self.bd_name									:=	StringLib.StringToUpperCase(pInput.line[14..313]);
	self.bd_street_address				:=	StringLib.StringToUpperCase(pInput.line[314..423]);
	self.bd_city									:=	StringLib.StringToUpperCase(pInput.line[424..487]);
	self.bd_state									:=	StringLib.StringToUpperCase(pInput.line[488..489]);
	self.bd_zip										:=	pInput.line[490..497];
	self.bd_zip_ext								:=	pInput.line[498..503];
	self.bd_country_code					:=	StringLib.StringToUpperCase(pInput.line[504..506]);	
	self.prep_addr_line1					:=	StringLib.StringToUpperCase(pInput.line[314..423]);
	self.prep_addr_last_line			:=	if	(pInput.line[424..487] != '',
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[424..487]) + ', ' + trim(pInput.line[488..489]) + ' ' + trim(pInput.line[490..494]))),
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[488..489]) + ' ' + trim(pInput.line[490..494])))
																	 );	
end;

B_DebtorIn									:=	project(dsInput(line[1] = '2'),trfB_Debtor(left));
	 
B_Debtor										:=	output(B_DebtorIn,,'~thor_data400::in::uccv2::'+filedate+'::tx::bdebtor',overwrite);
AddSuperB_Debtor						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::bdebtor','~thor_data400::in::uccv2::'+filedate+'::tx::bdebtor');
AddSuperB_DebtorProcessed		:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::bdebtor::processed','~thor_data400::in::uccv2::'+filedate+'::tx::bdebtor');

UCCV2.Layout_File_TX_PersonDebtor_in	trfP_Debtor(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date							:=	filedate;
	self.transaction_code					:=	pInput.line[1];
	self.original_filing_number		:=	pInput.line[2..13];
	self.pd_last_name							:=	StringLib.StringToUpperCase(pInput.line[14..63]);
	self.pd_first_name						:=	StringLib.StringToUpperCase(pInput.line[64..113]);
	self.pd_middle_name						:=	StringLib.StringToUpperCase(pInput.line[114..163]);
	self.pd_suffix								:=	StringLib.StringToUpperCase(pInput.line[164..169]);
	self.pd_street_address				:=	StringLib.StringToUpperCase(pInput.line[170..279]);
	self.pd_city									:=	StringLib.StringToUpperCase(pInput.line[280..343]);
	self.pd_state									:=	StringLib.StringToUpperCase(pInput.line[344..345]);
	self.pd_zip										:=	pInput.line[346..353];
	self.pd_zip_ext								:=	pInput.line[354..359];
	self.pd_country_code					:=	StringLib.StringToUpperCase(pInput.line[360..362]);
	self.prep_addr_line1					:=	StringLib.StringToUpperCase(pInput.line[170..279]);
	self.prep_addr_last_line			:=	if	(pInput.line[280..343] != '',
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[280..343]) + ', ' + trim(pInput.line[344..345]) + ' ' + trim(pInput.line[346..350]))),
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[344..345]) + ' ' + trim(pInput.line[346..350])))
																	 );		
end;

P_DebtorIn								:=	project(dsInput(line[1] = '3'),trfP_Debtor(left));

P_Debtor									:=	output(P_DebtorIn,,'~thor_data400::in::uccv2::'+filedate+'::tx::pdebtor',overwrite);
AddSuperP_Debtor					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::pdebtor','~thor_data400::in::uccv2::'+filedate+'::tx::pdebtor');
AddSuperP_DebtorProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::pdebtor::processed','~thor_data400::in::uccv2::'+filedate+'::tx::pdebtor');

UCCV2.Layout_File_TX_BusinessSecuredParty_in	trfB_SecuredParty(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date							:=	filedate;
	self.transaction_code					:=	pInput.line[1];
	self.original_filing_number		:=	pInput.line[2..13];
	self.bs_name									:=	StringLib.StringToUpperCase(pInput.line[14..313]);
	self.bs_street_address				:=	StringLib.StringToUpperCase(pInput.line[314..423]);
	self.bs_city									:=	StringLib.StringToUpperCase(pInput.line[424..487]);
	self.bs_state									:=	StringLib.StringToUpperCase(pInput.line[488..489]);
	self.bs_zip										:=	pInput.line[490..497];
	self.bs_zip_ext								:=	pInput.line[498..503];
	self.bs_country_code					:=	StringLib.StringToUpperCase(pInput.line[504..506]);
	self.prep_addr_line1					:=	StringLib.StringToUpperCase(pInput.line[314..423]);
	self.prep_addr_last_line			:=	if	(pInput.line[424..487] != '',
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[424..487]) + ', ' + trim(pInput.line[488..489]) + ' ' + trim(pInput.line[490..494]))),
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[488..489]) + ' ' + trim(pInput.line[490..494])))
																	 );			
end;

B_SecuredPartyIn								:=	project(dsInput(line[1] = '4'),trfB_SecuredParty(left));

B_SecuredParty									:=	output(B_SecuredPartyIn,,'~thor_data400::in::uccv2::'+filedate+'::tx::bsecuredparty',overwrite);
AddSuperB_SecuredParty					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::bsecuredparty','~thor_data400::in::uccv2::'+filedate+'::tx::bsecuredparty');
AddSuperB_SecuredPartyProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::bsecuredparty::processed','~thor_data400::in::uccv2::'+filedate+'::tx::bsecuredparty');

UCCV2.Layout_File_TX_PersonSecuredParty_in	trfP_SecuredParty(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date							:=	filedate;
	self.transaction_code					:=	pInput.line[1];
	self.original_filing_number		:=	pInput.line[2..13];
	self.ps_last_name							:=	StringLib.StringToUpperCase(pInput.line[14..63]);
	self.ps_first_name						:=	StringLib.StringToUpperCase(pInput.line[64..113]);
	self.ps_middle_name						:=	StringLib.StringToUpperCase(pInput.line[114..163]);
	self.ps_suffix								:=	StringLib.StringToUpperCase(pInput.line[164..169]);
	self.ps_street_address				:=	StringLib.StringToUpperCase(pInput.line[170..279]);
	self.ps_city									:=	StringLib.StringToUpperCase(pInput.line[280..343]);
	self.ps_state									:=	StringLib.StringToUpperCase(pInput.line[344..345]);
	self.ps_zip										:=	pInput.line[346..353];
	self.ps_zip_ext								:=	pInput.line[354..359];
	self.ps_country_code					:=	StringLib.StringToUpperCase(pInput.line[360..362]);
	self.prep_addr_line1					:=	StringLib.StringToUpperCase(pInput.line[170..279]);
	self.prep_addr_last_line			:=	if	(pInput.line[280..343] != '',
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[280..343]) + ', ' + trim(pInput.line[344..345]) + ' ' + trim(pInput.line[346..350]))),
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.line[344..345]) + ' ' + trim(pInput.line[346..350])))
																	 );		
end;

P_SecuredPartyIn								:=	project(dsInput(line[1] = '5'),trfP_SecuredParty(left));

P_SecuredParty									:=	output(P_SecuredPartyIn,,'~thor_data400::in::uccv2::'+filedate+'::tx::psecuredparty',overwrite);
AddSuperP_SecuredParty					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::psecuredparty','~thor_data400::in::uccv2::'+filedate+'::tx::psecuredparty');
AddSuperP_SecuredPartyProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::psecuredparty::processed','~thor_data400::in::uccv2::'+filedate+'::tx::psecuredparty');

fGetAmendType(string code)	:=	function
	string45 AmendType	:=	map(code = 'A'	=>	'Assignment, Full Master Assignment',
															code = 'AM'	=>	'Amendment, Master Amendment',
															code = 'C'	=>	'Continuation',
															code = 'J'	=>	'Judicial Findings of Fact',
															code = 'MR'	=>	'Master Record (Original Filing UCC-1)',
															code = 'O'	=>	'Correction',
															code = 'RV'	=>	'Revoked, Revoked Edit',
															code = 'T'	=>	'Termination',
															''
															);
															
	return AmendType;
end;

UCCV2.Layout_File_TX_Amendment_in	trfAmendment(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date							:=	filedate;
	self.transaction_code					:=	pInput.line[1];
	self.original_filing_number		:=	pInput.line[2..13];
	self.ucc3_filing_number				:=	pInput.line[14..23];
	self.amendment_type						:=	fGetAmendType(pInput.line[24..25]);
	self.filing_date							:=	pInput.line[26..33];
	self.filing_time							:=	pInput.line[34..37];
	self.page_count								:=	pInput.line[38..41];
	self.filing_entry_date				:=	pInput.line[42..49];
	self.filing_entry_time				:=	pInput.line[50..53];
	self.filing_history_comment		:=	StringLib.StringToUpperCase(pInput.line[54..309]);
	self.document_number					:=	pInput.line[310..329];
end;

AmendmentIn									:=	project(dsInput(line[1] = '6'),trfAmendment(left));

Amendment										:=	output(AmendmentIn,,'~thor_data400::in::uccv2::'+filedate+'::tx::amendment',overwrite);
AddSuperAmendment						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::amendment','~thor_data400::in::uccv2::'+filedate+'::tx::amendment');
AddSuperAmendmentProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::amendment::processed','~thor_data400::in::uccv2::'+filedate+'::tx::amendment');

UCCV2.Layout_File_TX_Collateral_in	trfCollateral(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date											:=	filedate;
	self.transaction_code									:=	pInput.line[1];
	self.original_filing_number						:=	pInput.line[2..13];
	self.ucc3_filing_number								:=	pInput.line[14..23];
	self.collateral_line_sequence_number	:=	intformat((integer)pInput.line[24..29], 6, 0);
	self.collateral_description						:=	StringLib.StringToUpperCase(pInput.line[30..109]);
	self.all_collateral										:=	StringLib.StringToUpperCase(pInput.line[30..109]);
end;
	
CollateralIn							:=	project(dsInput(line[1]='7'),trfCollateral(left));
srtedCollateralIn					:=	sort(CollateralIn,original_filing_number,ucc3_filing_number,collateral_line_sequence_number);

UCCV2.Layout_File_TX_Collateral_in trfRollupCollateral(UCCV2.Layout_File_TX_Collateral_in l, UCCV2.Layout_File_TX_Collateral_in r) := transform
	self.all_collateral			:=	(l.collateral_description + ' ' + r.collateral_description);
	self										:=	l;
end;

rolledCollateralIn				:=	rollup(	srtedCollateralIn
																			,trfRollupCollateral(left,right)
																			,original_filing_number
																			,ucc3_filing_number
																		 );

Collateral									:=	output(rolledCollateralIn,,'~thor_data400::in::uccv2::'+filedate+'::tx::collateral',overwrite);
AddSupercollateral					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::collateral','~thor_data400::in::uccv2::'+filedate+'::tx::collateral');
AddSupercollateralProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::tx::collateral::processed','~thor_data400::in::uccv2::'+filedate+'::tx::collateral');

				
retval := if (fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::tx::ALL') > 0,parallel(	sequential( Filing
																,AddSuperFiling
																,AddSuperFilingProcessed
															),
										sequential( B_Debtor
																,AddSuperB_Debtor
																,AddSuperB_DebtorProcessed
															),	
										sequential( P_Debtor
																,AddSuperP_Debtor
																,AddSuperP_DebtorProcessed
															),	
										sequential( B_SecuredParty
																,AddSuperB_SecuredParty
																,AddSuperB_SecuredPartyProcessed
															),
										sequential( P_SecuredParty
																,AddSuperP_SecuredParty
																,AddSuperP_SecuredPartyProcessed
															),	
										sequential( Amendment
																,AddSuperAmendment
																,AddSuperAmendmentProcessed
															),															
										sequential( Collateral
																,AddSuperCollateral
																,AddSuperCollateralProcessed
															)																
										),
										output('No new files available for TX')
										);

 
return retval;

end;