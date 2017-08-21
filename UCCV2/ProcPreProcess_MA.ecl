export ProcPreProcess_MA(string filedate) := function

dsInput	:=	UCCV2.File_MA_ALL_In;

UCCV2.Layout_File_MA_in	trfUCC(UCCV2.Layout_File_MA_Temp	pInput)	:=	transform
	self.postalCode						:=	if ((integer)StringLib.StringFindReplace(pInput.postalCode,'-','') = 0,
																				'',
																				StringLib.StringFindReplace(pInput.postalCode,'-','')
																		);															
													
	self.ucc_type_desc				:=	map(pInput.ucctype='135'	=>	'UCC-1 Original',
																		pInput.ucctype='136'	=>	'UCC DBA',
																		pInput.ucctype='137'	=>	'Transmitting Utility',
																		pInput.ucctype='138'	=>	'UCC-3 TERMINATION',
																		pInput.ucctype='139'	=>	'UCC-3 Termination',
																		pInput.ucctype='141'	=>	'Continuation',
																		pInput.ucctype='142'	=>	'Amendment',
																		pInput.ucctype='143'	=>	'Assignment',
																		pInput.ucctype='144'	=>	'Partial Release',
																		pInput.ucctype='145'	=>	'Subordination',
																		pInput.ucctype='149'	=>	'Termination DBA',
																		pInput.ucctype='150'	=>	'Environmental Lien',
																		pInput.ucctype='190'	=>	'UCC-5 CORRECTION',
																		pInput.ucctype='191'	=>	'UCC-5 INTERNAL CORRECTION',
																		''
																	);
															
	self.status_desc					:=	if (pInput.status	=	'True',
																			'ACTIVE',
																			if (pInput.status	=	'False',
																						'INACTIVE',
																						''
																					)
																		);
															
	self.nametype_desc				:=	map(pInput.nametype = 'A'	=>	'Assignor',
																		pInput.nametype = 'D' =>	'Debtor',
																		pInput.nametype = 'C' =>	'Secured Party',
																		''
																		);
															
	self.ficheexists_desc			:=	if (pInput.ficheexists = 'Y',
																			'DOCUMENT EXISTS AS FICHE',
																			'DOCUMENT CAME IN AS IMAGE OR FICHE CONVERTED TO IMAGE'
																		);
	self.status_cd						:=	if (pInput.status	=	'True',
																			'1',
																			if (pInput.status	=	'False',
																						'0',
																						''
																					)
																		);
	self.approvaldate					:=	pInput.approvaldate[1..25];
	self.process_date					:=	filedate;
	self.prep_addr_line1			:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.addr1 + pInput.addr2));
	self.prep_addr_last_line	:=	if	(pInput.city != '',
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.city) + ', ' + trim(pInput.state) + ' ' + trim(pInput.postalcode[1..5]))),
																			StringLib.StringToUpperCase(StringLib.StringCleanSpaces(trim(pInput.state) + ' ' + trim(pInput.postalcode[1..5])))
																	 );	
	self											:=	pInput;
end;
	
MA_UCC_In	:=	project(dsInput,trfUCC(left));

MA_UCC									:=	output(MA_UCC_In,,'~thor_data400::in::uccv2::'+filedate+'::ma',overwrite);
AddSuperMA_UCC					:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ma','~thor_data400::in::uccv2::'+filedate+'::ma');
AddSuperMA_UCCProcessed	:=	fileservices.addsuperfile('~thor_data400::in::uccv2::ma::processed','~thor_data400::in::uccv2::'+filedate+'::ma');

retval := if (fileservices.getsuperfilesubcount(Cluster.Cluster_In + 'in::uccv2::MA::ALL') > 0,
								sequential( MA_UCC
											,AddSuperMA_UCC
											,AddSuperMA_UCCProcessed
										),
										output('No new files available for MA')
										);

return retval;

end;