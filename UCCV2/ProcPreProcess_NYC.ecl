export ProcPreProcess_NYC(string filedate) := function

dsInput	:=	UCCV2.File_NYC_ALL_In;

UCCV2.Layout_File_NYC_Remark_in	trfRemarks(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.unique_key							:=	pInput.line[1..StringLib.StringFind(pInput.line, '|', 1) - 1];
	self.record_type						:=	pInput.line[StringLib.StringFind(pInput.line, '|', 1) + 1..StringLib.StringFind(pInput.line, '|', 2) - 1];
	self.Seq										:=	pInput.line[StringLib.StringFind(pInput.line, '|', 2) + 1..StringLib.StringFind(pInput.line, '|', 3) - 1];
	self.Text										:=	pInput.line[StringLib.StringFind(pInput.line, '|', 3) + 1..StringLib.StringFind(pInput.line, '|', 4) - 1];
end;

RemarksIn									:=	project(dsInput(line[StringLib.StringFind(line, '|', 1) + 1] = 'R'),trfRemarks(left));

Remarks										:=	output(RemarksIn,,'~thor_data400::in::uccv2::'+filedate+'::nyc::remark',overwrite);
AddSuperRemarks						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::remark','~thor_data400::in::uccv2::'+filedate+'::nyc::remark');
AddSuperRemarksProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::remark::processed','~thor_data400::in::uccv2::'+filedate+'::nyc::remark');

fGetCollateralType(string code)	:=	function
	string45 CollateralType	:=	map(code = 'C' => 'COOPERATIVE',
																	code = 'D' =>	'TRANSMITTING UTILITIES DBTR',
																	code = 'F' => 'FIXTURE FILING',
																	code = 'M' => 'MANUFACTURED HOUSING',
																	code = 'O' => 'OTHER',	
																	code = 'R' => 'CROPS/EXTRACTED/COLLATERAL/TIMBER TO BE CUT',
																	''
																	);
	return CollateralType;
end;

fGetDocType(string code)	:=	function
	string50 DocType	:=	map(code = 'AMND' => 'UCC3 AMENDMENT',
														code = 'ASGN' => 'UCC3 ASSIGNMENT',
														code = 'BOND' => 'BOND',
														code = 'BRUP' => 'UCC3 BANKRUPTCY',
														code = 'CONT' => 'UCC3 CONTINUATION',
														code = 'INIC' => 'INITIAL COOP UCC1',
														code = 'INIT' => 'INITIAL UCC1',
														code = 'PSGN' => 'UCC3 PARTIAL ASSIGNMENT',
														code = 'RLSE' => 'UCC3 RELEASE',
														code = 'SUBO' => 'UCC3 SUBORDINATION',
														code = 'MFL'  => 'AMENDMENT OF FEDERAL LIEN',
														code = 'CNFL' => 'CONTINUATION OF FEDERAL LIEN',
														code = 'DTLD' => 'DISCHARGE OF TAX LIEN',
														code = 'FL'   => 'FEDERAL LIEN',
														code = 'FTL'  => 'FEDERAL TAX LIEN',
														code = 'PRFL' => 'PARTIAL RELEASE OF FEDERAL LIEN',
														code = 'RFL'  => 'RELEASE OF FEDERAL LIEN',
														code = 'TERM' => 'UCC3 TERMINATION',
														''
														);
	return DocType;
end;

reformatDate(string inDate) := function
	string8 clean_inDate := trim(regexreplace('/',inDate,''),left,right);
	string8 newDate := clean_inDate[5..8] + clean_inDate[1..2] + clean_inDate[3..4];
	
	return newDate;	
end;	

UCCV2.Layout_File_NYC_Filing_Master_in	trfFilingMaster(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.unique_key							:=	pInput.line[1..StringLib.StringFind(pInput.line, '|', 1) - 1];
	self.record_type						:=	pInput.line[StringLib.StringFind(pInput.line, '|', 1) + 1..StringLib.StringFind(pInput.line, '|', 2) - 1];
	self.filing_date						:=	reformatDate(pInput.line[StringLib.StringFind(pInput.line, '|', 2) + 1..StringLib.StringFind(pInput.line, '|', 3) - 1]);
	self.filing_number					:=	pInput.line[StringLib.StringFind(pInput.line, '|', 3) + 1..StringLib.StringFind(pInput.line, '|', 4) - 1];
	string boroughCode					:=	pInput.line[StringLib.StringFind(pInput.line, '|', 4) + 1..StringLib.StringFind(pInput.line, '|', 5) - 1];
	self.borough								:=	map(boroughCode = '1' => 'MANHATTAN',
																			boroughCode = '2' => 'BRONX',
																			boroughCode = '3' => 'BROOKLYN',
																			boroughCode = '4' => 'QUEENS',
																			''
																			);
	self.Doc_type								:=	fGetDocType(trim(pInput.line[StringLib.StringFind(pInput.line, '|', 5) + 1..StringLib.StringFind(pInput.line, '|', 6) - 1],left,right));
	self.Not_Used								:=	pInput.line[StringLib.StringFind(pInput.line, '|', 6) + 1..StringLib.StringFind(pInput.line, '|', 7) - 1];
	self.Document_amt						:=	pInput.line[StringLib.StringFind(pInput.line, '|', 7) + 1..StringLib.StringFind(pInput.line, '|', 8) - 1];
	self.Record_datetime				:=	reformatDate(pInput.line[StringLib.StringFind(pInput.line, '|', 8) + 1..StringLib.StringFind(pInput.line, '|', 9) - 1]);
	self.Ucc_collateral					:=	fGetCollateralType(pInput.line[StringLib.StringFind(pInput.line, '|', 9) + 1..StringLib.StringFind(pInput.line, '|', 10) - 1]);
	self.Fedtax_serial_nbr			:=	pInput.line[StringLib.StringFind(pInput.line, '|', 10) + 1..StringLib.StringFind(pInput.line, '|', 11) - 1];
	self.Fedtax_assess_date			:=	reformatDate(pInput.line[StringLib.StringFind(pInput.line, '|', 11) + 1..StringLib.StringFind(pInput.line, '|', 12) - 1]);
	self.Rpttl_nbr							:=	if ((integer)pInput.line[StringLib.StringFind(pInput.line, '|', 12) + 1..StringLib.StringFind(pInput.line, '|', 13) - 1]=0,
																					'',
																					pInput.line[StringLib.StringFind(pInput.line, '|', 12) + 1..StringLib.StringFind(pInput.line, '|', 13) - 1]
																			);
	self.Modified_date					:=	reformatDate(pInput.line[StringLib.StringFind(pInput.line, '|', 13) + 1..StringLib.StringFind(pInput.line, '|', 14) - 1]);
	self.Reel_yr								:=	pInput.line[StringLib.StringFind(pInput.line, '|', 14) + 1..StringLib.StringFind(pInput.line, '|', 15) - 1];	
	self.Reel_nbr								:=	pInput.line[StringLib.StringFind(pInput.line, '|', 15) + 1..StringLib.StringFind(pInput.line, '|', 16) - 1];	
	self.Reel_pg								:=	pInput.line[StringLib.StringFind(pInput.line, '|', 16) + 1..StringLib.StringFind(pInput.line, '|', 17) - 1];	
	self.File_nbr								:=	pInput.line[StringLib.StringFind(pInput.line, '|', 17) + 1..StringLib.StringFind(pInput.line, '|', 18) - 1];	
	
	self	:=	[];

end;

FilingMasterIn						:=	project(dsInput(line[StringLib.StringFind(line, '|', 1) + 1] = 'A'),trfFilingMaster(left));
	 
Filing										:=	output(FilingMasterIn,,'~thor_data400::in::uccv2::'+filedate+'::nyc::master',overwrite);
AddSuperFiling						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::master','~thor_data400::in::uccv2::'+filedate+'::nyc::master');
AddSuperFilingProcessed		:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::master::processed','~thor_data400::in::uccv2::'+filedate+'::nyc::master');

fGetPropType(string code)	:=	function
	string30 PropType	:=	map(code = 'F1' =>	'1-3 FAMILY WITH STORE / OFFICE',
														code = 'F4' =>	'4-6 FAMILY WITH STORE / OFFICE',
														code = 'D1' =>	'DWELLING ONLY - 1 FAMILY',
														code = 'D2' =>	'DWELLING ONLY - 2 FAMILY',
														code = 'D3' =>	'DWELLING ONLY - 3 FAMILY',
														code = 'D4' =>	'DWELLING ONLY - 4 FAMILY',
														code = 'D5' =>	'DWELLING ONLY - 5 FAMILY',
														code = 'D6' =>	'DWELLING ONLY - 6 FAMILY',
														code = 'SC' =>	'SINGLE RESIDENTIAL CONDO UNIT',
														code = 'MC' =>	'MULTIPLE RESIDENTIAL CONDO UNT',
														code = 'SP' =>	'SINGLE RESIDENTIAL COOP UNIT',
														code = 'MP' =>	'MULTIPLE RESIDENTIAL COOP UNIT',
														code = 'CC' =>	'COMMERCIAL CONDO UNIT(S)',
														code = 'AP' =>	'APARTMENT BUILDING',
														code = 'OF' =>	'OFFICE BUILDING',
														code = 'IB' =>	'INDUSTRIAL BUILDING',
														code = 'RB' =>	'RETAIL BUILDING',
														code = 'VL' =>	'VACANT LAND',
														code = 'MU' =>	'MULTIPLE PROPERTIES',
														code = 'OT' =>	'OTHER',
														code = 'PA' =>	'PRE-ACRIS',
														code = 'MR' =>	'MAIDS ROOM',
														code = 'SR' =>	'STORAGE ROOM',
														code = 'PS' =>	'PARKING SPACE',
														''
														);
														
	return PropType;
end;

UCCV2.Layout_File_NYC_Lot_in	trfLot(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.unique_key							:=	pInput.line[1..StringLib.StringFind(pInput.line, '|', 1) - 1];
	self.record_type						:=	pInput.line[StringLib.StringFind(pInput.line, '|', 1) + 1..StringLib.StringFind(pInput.line, '|', 2) - 1];
	string boroughCode					:=	pInput.line[StringLib.StringFind(pInput.line, '|', 2) + 1..StringLib.StringFind(pInput.line, '|', 3) - 1];
	self.borough								:=	map(boroughCode = '1' => 'MANHATTAN',
																			boroughCode = '2' => 'BRONX',
																			boroughCode = '3' => 'BROOKLYN',
																			boroughCode = '4' => 'QUEENS',
																			''
																			);
	self.Block									:=	regexreplace('^0',pInput.line[StringLib.StringFind(pInput.line, '|', 3) + 1..StringLib.StringFind(pInput.line, '|', 4) - 1],'');
	self.Lot										:=	regexreplace('^0',pInput.line[StringLib.StringFind(pInput.line, '|', 4) + 1..StringLib.StringFind(pInput.line, '|', 5) - 1],'');
	self.Easement								:=	pInput.line[StringLib.StringFind(pInput.line, '|', 5) + 1..StringLib.StringFind(pInput.line, '|', 6) - 1];
	string lotCode							:=	pInput.line[StringLib.StringFind(pInput.line, '|', 6) + 1..StringLib.StringFind(pInput.line, '|', 7) - 1];
	self.Partial_lot						:=	map(lotCode = 'P' => 'PARTIAL',
																			lotCode = 'E' => 'ENTIRE',
																			''
																			);
	self.Air_rights							:=	pInput.line[StringLib.StringFind(pInput.line, '|', 7) + 1..StringLib.StringFind(pInput.line, '|', 8) - 1];
	self.Subterranean_rights		:=	pInput.line[StringLib.StringFind(pInput.line, '|', 8) + 1..StringLib.StringFind(pInput.line, '|', 9) - 1];
	self.Property_type					:=	fGetPropType(pInput.line[StringLib.StringFind(pInput.line, '|', 9) + 1..StringLib.StringFind(pInput.line, '|', 10) - 1]);
	self.Street_number					:=	pInput.line[StringLib.StringFind(pInput.line, '|', 10) + 1..StringLib.StringFind(pInput.line, '|', 11) - 1];
	self.Street_name						:=	pInput.line[StringLib.StringFind(pInput.line, '|', 11) + 1..StringLib.StringFind(pInput.line, '|', 12) - 1];	
	self.Addr_unit							:=	pInput.line[StringLib.StringFind(pInput.line, '|', 12) + 1..StringLib.StringFind(pInput.line, '|', 13) - 1];	
end;

LotIn									:=	project(dsInput(line[StringLib.StringFind(line, '|', 1) + 1] = 'L'),trfLot(left));
	
Lot										:=	output(LotIn,,'~thor_data400::in::uccv2::'+filedate+'::nyc::lot',overwrite);
AddSuperLot						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::lot','~thor_data400::in::uccv2::'+filedate+'::nyc::lot');
AddSuperLotProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::lot::processed','~thor_data400::in::uccv2::'+filedate+'::nyc::lot');

UCCV2.Layout_File_NYC_Party_in	trfParty(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.unique_key							:=	pInput.line[1..StringLib.StringFind(pInput.line, '|', 1) - 1];
	self.record_type						:=	pInput.line[StringLib.StringFind(pInput.line, '|', 1) + 1..StringLib.StringFind(pInput.line, '|', 2) - 1];
	self.Party_type							:=	pInput.line[StringLib.StringFind(pInput.line, '|', 2) + 1..StringLib.StringFind(pInput.line, '|', 3) - 1];
	self.Name										:=	pInput.line[StringLib.StringFind(pInput.line, '|', 3) + 1..StringLib.StringFind(pInput.line, '|', 4) - 1];
	self.Addr1									:=	pInput.line[StringLib.StringFind(pInput.line, '|', 4) + 1..StringLib.StringFind(pInput.line, '|', 5) - 1];
	self.Addr2									:=	pInput.line[StringLib.StringFind(pInput.line, '|', 5) + 1..StringLib.StringFind(pInput.line, '|', 6) - 1];
	self.Country								:=	pInput.line[StringLib.StringFind(pInput.line, '|', 6) + 1..StringLib.StringFind(pInput.line, '|', 7) - 1];
	self.City										:=	pInput.line[StringLib.StringFind(pInput.line, '|', 7) + 1..StringLib.StringFind(pInput.line, '|', 8) - 1];
	self.State									:=	pInput.line[StringLib.StringFind(pInput.line, '|', 8) + 1..StringLib.StringFind(pInput.line, '|', 9) - 1];
	self.Zip										:=	pInput.line[StringLib.StringFind(pInput.line, '|', 9) + 1..StringLib.StringFind(pInput.line, '|', 10) - 1];
	self.prep_addr_line1				:=	StringLib.StringCleanSpaces((self.addr1 + self.addr2));
	self.prep_addr_last_line		:=	if	(self.City != '',
																					StringLib.StringCleanSpaces(trim(self.City) + ', ' + trim(self.State) + ' ' + trim(self.Zip[1..5])),
																					StringLib.StringCleanSpaces(trim(self.State) + ' ' + trim(self.Zip[1..5]))
																			);		
	
end;

PartyIn									:=	project(dsInput(line[StringLib.StringFind(line, '|', 1) + 1] = 'P'),trfParty(left));

Party										:=	output(PartyIn,,'~thor_data400::in::uccv2::'+filedate+'::nyc::party',overwrite);
AddSuperParty						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::party','~thor_data400::in::uccv2::'+filedate+'::nyc::party');
AddSuperPartyProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::party::processed','~thor_data400::in::uccv2::'+filedate+'::nyc::party');

UCCV2.Layout_File_NYC_Ref_in	trfRef(UCCV2.Layout_File_Variable_All	pInput)	:=	transform
	self.process_date						:=	filedate;
	self.unique_key							:=	pInput.line[1..StringLib.StringFind(pInput.line, '|', 1) - 1];
	self.record_type						:=	pInput.line[StringLib.StringFind(pInput.line, '|', 1) + 1..StringLib.StringFind(pInput.line, '|', 2) - 1];
	self.CRFN										:=	pInput.line[StringLib.StringFind(pInput.line, '|', 2) + 1..StringLib.StringFind(pInput.line, '|', 3) - 1];
	self.Doc_id_ref							:=	pInput.line[StringLib.StringFind(pInput.line, '|', 3) + 1..StringLib.StringFind(pInput.line, '|', 4) - 1];
	self.Not_Used								:=	pInput.line[StringLib.StringFind(pInput.line, '|', 4) + 1..StringLib.StringFind(pInput.line, '|', 5) - 1];
	self.REF_File_nbr						:=	pInput.line[StringLib.StringFind(pInput.line, '|', 5) + 1..StringLib.StringFind(pInput.line, '|', 6) - 1];
end;

RefIn									:=	project(dsInput(line[StringLib.StringFind(line, '|', 1) + 1] = 'X'),trfRef(left));

Ref										:=	output(RefIn,,'~thor_data400::in::uccv2::'+filedate+'::nyc::ref',overwrite);
AddSuperRef						:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::ref','~thor_data400::in::uccv2::'+filedate+'::nyc::ref');
AddSuperRefProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::nyc::ref::processed','~thor_data400::in::uccv2::'+filedate+'::nyc::ref');
				
retval := if (fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::ny_new_york::ALL') > 0,
									parallel(	sequential( Remarks
																,AddSuperRemarks
																,AddSuperRemarksProcessed
															),
										sequential( Filing
																,AddSuperFiling
																,AddSuperFilingProcessed
															),	
										sequential( Lot
																,AddSuperLot
																,AddSuperLotProcessed
															),	
										sequential( Party
																,AddSuperParty
																,AddSuperPartyProcessed
															),
										sequential( Ref
																,AddSuperRef
																,AddSuperRefProcessed
															)																
										),
										output('No new files available for ny_new_york')
										);

 
return retval;

end;