IMPORT Enclarity_Facility_Sanctions;
EXPORT Sanction_Code_Lookup := MODULE

		SancLookupTable := RECORD
			string Severity;
			string Code;
			string Type;
			string SancName;
			string SancDesc;
		END;
		Export dsSancLookup :=
				dataset([ {'1','CandDP',	'State',		'Cease And Desist From Practicing',	''},
									{'1','DEB',			'State',		'Debarred',													''},
									{'1','SME',			'Medicaid',	'Medicaid Exclusion',								''},
									{'1','OTHE',		'State',		'Other Exclusion',									''},
									{'1','LICD',		'State',		'License Denied',										''},
									{'1','REV',			'State',		'Revocation',												''},
									{'1','TERM',		'State',		'Termination',											''},
									{'2','EXP',			'State',		'Exppired/Lapsed',									''},
									{'2','SUX',			'State',		'Surrender',												''},
									{'3','SMEP',		'Medicaid',	'Partial Medicaid Exclusion',				''},
									{'3','SMEPO',		'Medicaid',	'Medicaid Probation',								''},
									{'3','LL',			'State',		'Limited License',									''},
									{'3','PROB',		'State',		'Probation',												''},
									{'3','SUSP',		'State',		'Suspension',												''},
									{'4','AAC',			'State',		'AA Citation',											'An AA Citation is a violation that has been ' 
																																								+	'\'determined to have been a direct proximate '
																																								+ 'cause of death or a patient or resident of a '
																																								+ 'long term care facility.\' CA only'},
									{'4','REP',			'State',		'Reprimand',												''},
									{'4','SUSPST',	'State',		'Suspension/Stayed',								''},
									{'4','REVST',		'State',		'Revocation/Stayed',								''},
									{'4','SUXST',		'State',		'Surrender/Stayed',									''},
									{'5','CA',			'State',		'Civil Action',											''},
									{'5','CandDoth','State',		'Cease And Desist Other',						''},
									{'5','CO',			'State',		'Consent Order',										''},
									{'5','FINE',		'State',		'Fine',															''},
									{'5','RFINE',		'State',		'Reduced Fine',											''},
									{'5','LofC',		'State',		'Letter of Concern, Public Reproval or Reprimand',''},
									{'5','MISC',		'State',		'Misc. Agreement/Settlement/Stipulation',					''},
									{'5','SofC',		'State',		'Statement of Charges',							''},
									{'5','BREACH',	'State',		'Breach',														'Breach of confidential patient information'},
									{'0','MOD', 		'State',		'Modification of Previous Order',		''},
									{'0','OTH',			'State',		'Other',														'Non-specified action'},
									{'0','SMR',			'Medicaid',	'Medicaid Reinstatement',						''},
									{'0','OTHR',		'State',		'Other Reinstatement',							'License, registration, certification reinstatement '
																																								+	'by the board. Practice restrictions lifted.'}
								],SancLookupTable);
	// severity:
	// 0 - reinstatement, modification or unspecified action
	// 1 - no practice priveledge or excluded entirely from program
	// 2 - no practice priveledge - voluntarily
	// 3 - limited practice or partially excluded from program
	// 4 - possible quality of care but no current practice or program restrictions
	// 5 - no practice or program ramifications
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	// File codes are used to identify the Sanction Board Name/Type
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	BoardLookupTable := RECORD
			string Filecode;
			string State;
			string BoardName;
			string BoardType;
			string SancType;
			string Status;
		END;
		Export dsBoardLookup :=
				dataset([ {'SNC_AKF1','AK','Department of Health and Social Services',						'Medicaid Board',										'Medicaid',	'Cumulative'														},
									{'SNC_ALF1','AL','License Board',																				'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_ALF2','AL','Medicaid Agency',																			'Medicaid Board',										'Medicaid',	'Full Refresh'													},
									{'SNC_AZF2','AZ','Department of Health Services',												'License Board',										'State',		'Cumulative'														},
									{'SNC_CAF1','CA','Department of Health Care Services',									'Medicaid Board',										'Medicaid',	'Full Refresh'													},
									{'SNC_CAF2','CA','Department of Public Health',													'License Board',										'State',		'Cumulative'														},
									{'SNC_CAF3','CA','Department of Public Health',													'License Board',										'State',		'Cumulative'														},
									{'SNC_CAF4','CA','Department of Public Health', 												'Health Board',											'State',		'Cumulative'														},
									{'SNC_CAF7','CA','Department of Consumer Affairs',											'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_CAF8','CA','Department of Consumer Affairs',											'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_CTF2','CT','Department of Public Health',													'Regulatory Action Report',					'State',		'Cumulative'														},
									{'SNC_CTF3','CT','Department of Public Health',													'Regulatory Action Report',					'State',		'Cumulative'														},	
									{'SNC_CTF5','CT','Department of Social Services',												'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_DCF1','DC','Department of Health	Health',												'Regulation Administration',				'State',		'Cumulative'														},
									{'SNC_DEF2','DE','License Board',																				'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_FLF1','FL','Agency for Healthcare Administration', 								'License Board and Medicaid Board',	'State',		'Full refresh'													},
									{'SNC_FLF2','FL','Agency for Healthcare Administration', 								'License Board and Medicaid Board',	'Medicaid',	'Full refresh'													},
									{'SNC_FLF3','FL','Agency for Healthcare Administration', 								'License Board and Medicaid Board',	'Medicaid',	'Full refresh'													},
									{'SNC_FLF4','FL','Agency for Healthcare Administration', 								'License Board and Medicaid Board',	'State',		'Full refresh'													},
									{'SNC_FLF5','FL','Department of Health',																'License Boards',										'State',		'Full refresh'													},
									{'SNC_GAF1','GA','Department of Health',																'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_HIF1','HI','Department of Commerce and Consumer Affairs',					'Hearings Office',									'State',		'Cumulative'														},
									{'SNC_HIF2','HI','Quest Hawaii',																				'Medicaid Board',										'Medicaid',	'Full refresh including reinstatements'	},
									{'SNC_IAF2','IA','Department of Human Services',												'Medicaid Board',										'Medicaid',	'Cumulative'														},
									{'SNC_IDF2','ID','Department of Health',																'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_ILF1','IL','Department of Financial and Professional Regulation',	'License Board',										'State',		'Cumulative'														},
									{'SNC_ILF2','IL','Department of Public Health', 												'License Board',										'State',		'Cumulative'														},
									{'SNC_ILF4','IL','Healthcare and Family Services',											'Medicaid Board',										'Medicaid',	'Cumulative'														},
									{'SNC_KSF1','KS','Department of Health and Environment',								'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_KSF3','KS','License Board',																				'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_KYF1','KY','Cabinet for Health and Family Services',							'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_LAF3','LA','Department of Health and Hospitals',									'Medicaid Board',										'Medicaid',	'Full refresh including reinstatements'	},
									{'SNC_MAF2','MA','Health and Human Services',														'Medicaid Board',										'Medicaid',	'Cumulative'														},
									{'SNC_MDF3','MD','Department of Health and Mental Hygiene',							'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_MDF4','MD','Department of Health and Mental Hygiene',							'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_MEF1','ME','Department of Health and Human Services',							'Medicaid Board',										'Medicaid',	'Cumulative'														},
									{'SNC_MIF1','MI','Department of Licensing and Regulatory Affairs',			'License Board',										'State',		'Cumulative'														},
									{'SNC_MIF2','MI','Department of Health and Human Services',							'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_MNF1','MN','Department of Human Services',												'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_MOF1','MO','Department of Social Services',												'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_MSF1','MS','Division of Medicaid',																'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_MTF2','MT','Department of Public Health and Human Services',			'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_NCF1','NC','License Board',																				'Pharmacy Board',										'State',		'Cumulative'														},														
									{'SNC_NCF2','NC','Division of Health Service Regulation',								'Adult Care  Board',								'State',		'Full refresh'													},
									{'SNC_NCF3','NC','Medical Assistance Health and Human Services',				'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_NDF1','ND','Department of Human Services',												'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_NEF1','NE','Department of Health and Human Services',							'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_NMF3','NM','Regulation and Licensing Department',									'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_NVF1','NV','Division of Health Care Financing and Policy', 				'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_NYF2','NY','Office of the Medicaid Inspector General',						'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_NYF3','NY','Office of the Professions',														'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_OHF1','OH','Department of Medicaid',															'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_PAF1','PA','Department of Human Services',												'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_RIF1','RI','Department of Health',																'License Board',										'State',		'Cumulative'														},
									{'SNC_SCF1','SC','Health Connections Medicaid',													'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_TNF1','TN','Division of Health Care Finance and Administration',	'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_TNF2','TN','Department of Health',																'License Board',										'State',		'Cumulative'														},
									{'SNC_TXF1','TX','Health and Human Services',														'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_TXF2','TX','Department of State Health Services',									'License Board',										'State',		'Cumulative'														},
									{'SNC_TXF4','TX','License Board',																				'Pharmacy Board',										'State',		'Cumulative'														},
									{'SNC_VAF1','VA','Department of Health Professions',										'License Board',										'State',		'Cumulative'														},
									{'SNC_WIF1','WI','Department of Safety and Professional Services',			'License Board',										'State',		'Cumulative'														},
									{'SNC_WVF1','WV','Medicaid Management Information System',							'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_WVF2','WV','State Medicaid',																			'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_WVF3','WV','State Medicaid',																			'Medicaid Board',										'Medicaid',	'Full refresh'													},
									{'SNC_WYF1','WY','Department of Health',																'Medicaid Board',										'Medicaid',	'Cumulative'														}
								],BoardLookupTable);

END;



