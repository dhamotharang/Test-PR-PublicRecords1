import ut, Prof_License_Mari, lib_stringlib;

FileName	:=	'~thor_data400::in::proflic_mari::';

concat_maribase := dataset(FileName + 'S0812',	Prof_License_Mari.layout_orig.base,thor)	// ** Alabama Real Estate Commission
													 + dataset(FileName + 'S0845',	Prof_License_Mari.layout_orig.base,thor)	// ** Alabama Real Estate Appraiser Board
													 + dataset(FileName + 'S0635',	Prof_License_Mari.layout_orig.base,thor)
													 + dataset(FileName + 'S0376',	Prof_License_Mari.layout_orig.base,thor) 	// ** Alaska Department of Community & Economic Development
													 // + dataset(FileName + 'S0813',	Prof_License_Mari.layout_orig.base,thor)	// ** Arizona Department of Real Estate
													 // + dataset(FileName + 'S0808',	Prof_License_Mari.layout_orig.base,thor)	// ** Arizona Board of Appraisers
													 // + dataset(FileName + 'S0639',	Prof_License_Mari.layout_orig.base,thor)
													 // + dataset(FileName + 'S0835',	Prof_License_Mari.layout_orig.base,thor)	// ** Arkansas Real Estate Commision
													 // + dataset(FileName + 'S0681',	Prof_License_Mari.layout_orig.base,thor)	// ** California Department of Real Estate
													 // + dataset(FileName + 'S0847',	Prof_License_Mari.layout_orig.base,thor)	// ** California Office of Real Estate Appraisers
													 // + dataset(FileName + 'S0821',	Prof_License_Mari.layout_orig.base,thor)	// ** Colorado Division of Real Estate
													 // + dataset(FileName + 'S0850',	Prof_License_Mari.layout_orig.base,thor)	// ** Connecticut Department of Consumer Protection
													 // + dataset(FileName + 'S0846',	Prof_License_Mari.layout_orig.base,thor)	// ** Delaware Division of Professional Regulation
													 // + dataset(FileName + 'S0630',	Prof_License_Mari.layout_orig.base,thor)
													 // + dataset(FileName + 'S0280',	Prof_License_Mari.layout_orig.base,thor)	// ** Florida Department of Business & Professional Regulation
													 // + dataset(FileName + 'S0825',	Prof_License_Mari.layout_orig.base,thor)	// ** Georgia Real Esate Commision & Appraisers Board
													 // + dataset(FileName + 'S0117',	Prof_License_Mari.layout_orig.base,thor)	// ** Hawaii Department of Commerce & Consumer Affairs
													 // + dataset(FileName + 'S0262',	Prof_License_Mari.layout_orig.base,thor)	// ** Idaho Bureau of Occupational Licenses
													 // + dataset(FileName + 'S0827',	Prof_License_Mari.layout_orig.base,thor)	// ** Idaho Real Estate Commission Agents
													 // + dataset(FileName + 'S0658',	Prof_License_Mari.layout_orig.base,thor)
													 // + dataset(FileName + 'S0829',	Prof_License_Mari.layout_orig.base,thor)	// ** Illinois Department of Profession Regulation
													 // + dataset(FileName + 'S0631',	Prof_License_Mari.layout_orig.base,thor)
													 // + dataset(FileName + 'S0610',	Prof_License_Mari.layout_orig.base,thor)	// ** Indiana Secretary of State
													 // + dataset(FileName + 'S0644',	Prof_License_Mari.layout_orig.base,thor)	// ** Indiana Department of Financial Institutes
													 // + dataset(FileName + 'S0901',	Prof_License_Mari.layout_orig.base,thor)	// ** Access Indiana
													 // + dataset(FileName + 'S0887',	Prof_License_Mari.layout_orig.base,thor)	// ** Iowa Real Estate & Commission * Appraisal
													 // + dataset(FileName + 'S0826',	Prof_License_Mari.layout_orig.base,thor)	// ** Iowa Real Estate Commission & Appraisal
													 // + dataset(FileName + 'S0833',	Prof_License_Mari.layout_orig.base,thor)	// ** Vendor Hold(Webscrape) ** Louisana Real Estate Appraiser Board
	                         // + dataset(FileName + 'S0832',	Prof_License_Mari.layout_orig.base,thor)	// ** Louisana Real Estate Commission
													 // + dataset(FileName + 'S0838',	Prof_License_Mari.layout_orig.base,thor)	// ** Maine Board of Real Estate Appraisers
                           + dataset(FileName + 'S0888',	Prof_License_Mari.layout_orig.base,thor)	// ** Maine Board of Real Estate Appraisers
													 // + dataset(FileName + 'S0834',	Prof_License_Mari.layout_orig.base,thor)	// ** Maryland Commssion of Real Estate Appraiser & Home Inspection
													 // + dataset(FileName + 'S0021',	Prof_License_Mari.layout_orig.base,thor)	// ** Massachussetts, Commonwealth of 
													 // + dataset(FileName + 'S0298',	Prof_License_Mari.layout_orig.base,thor)	// ** Michigan Department of Consumer & Industry Service
													 // + dataset(FileName + 'S0867',	Prof_License_Mari.layout_orig.base,thor)	// ** Minnesotas Bookstore
													 // + dataset(FileName + 'S0869',	Prof_License_Mari.layout_orig.base,thor) 	// ** Minnesotas Bookstore
													 // + dataset(FileName + 'S0815',	Prof_License_Mari.layout_orig.base,thor)	// ** Mississippi Real Estate Commission
													 // + dataset(FileName + 'S0634',	Prof_License_Mari.layout_orig.base,thor) 	// ** Missouri Division of Finance
													 // + dataset(FileName + 'S0820',	Prof_License_Mari.layout_orig.base,thor)	// ** Missouri Division of Professional Registration
													 // + dataset(FileName + 'S0398',	Prof_License_Mari.layout_orig.base,thor)	// ** Montana Department of Labor and Industry
													 // + dataset(FileName + 'S0648',	Prof_License_Mari.layout_orig.base,thor) 	// ** National Credit Union Administration
													 // + dataset(FileName + 'S0814',	Prof_License_Mari.layout_orig.base,thor)	// ** ASC National Registry
													 + dataset(FileName + 'S0842',	Prof_License_Mari.layout_orig.base,thor)	// ** Nebraska Real Estate Commission
													 + dataset(FileName + 'S0857',	Prof_License_Mari.layout_orig.base,thor)	// ** Nevada Real Estate Division
													 + dataset(FileName + 'S0856',	Prof_License_Mari.layout_orig.base,thor)	// ** New Hampshire Real Estate Commission
													 // + dataset(FileName + 'S0859',	Prof_License_Mari.layout_orig_reference.layout.base,thor)	// ** Vendor Hold(Webscrape) ** Nebraska Real Property Appraiser Board
													 // + dataset(FileName + 'S0033',	Prof_License_Mari.layout_orig_reference.maribase,thor)	// ** New Jersey Department of Law & Public Safety
													 + dataset(FileName + 'S0822',	Prof_License_Mari.layout_orig.base,thor)	// ** New Mexico Real Estate Commission
                           + dataset(FileName + 'S0843',	Prof_License_Mari.layout_orig.base,thor)	// ** New Mexico Real Estate Appraiser Board
													 + dataset(FileName + 'S0840',	Prof_License_Mari.layout_orig.base,thor) 	// ** North Carolina Real Estate Commission
													 + dataset(FileName + 'S0841',	Prof_License_Mari.layout_orig.base,thor) 	// ** North Carolina Appraisal Board
													 + dataset(FileName + 'S0855',	Prof_License_Mari.layout_orig.base,thor)	// ** North Dakota Real Estate Commission
													 + dataset(FileName + 'S0654',	Prof_License_Mari.layout_orig.base,thor) 	// ** Ohio Department of Commerce
													 + dataset(FileName + 'S0817',	Prof_License_Mari.layout_orig.base,thor)	// ** Oklahoma Real Estate Commission
												   + dataset(FileName + 'S0839',	Prof_License_Mari.layout_orig.base,thor)	// ** Oregon Real Estate Agency
													 // + dataset(FileName + 'S0811',	Prof_License_Mari.layout_orig.base,thor)	// ** State of Rhode Island Department of Business Regulation
													 + dataset(FileName + 'S0852',	Prof_License_Mari.layout_orig.base,thor)	// ** South Carolina Real Estate Commission
													 + dataset(FileName + 'S0853',	Prof_License_Mari.layout_orig.base,thor)	// ** South Carolina Real Estate Appraiser Board
                           + dataset(FileName + 'S0810',	Prof_License_Mari.layout_orig.base,thor)	// ** South Dakota Revenue & Regulation
                           + dataset(FileName + 'S0844',	Prof_License_Mari.layout_orig.base,thor)	// ** South Dakota Real Estate Commission
													 + dataset(FileName + 'S0513',	Prof_License_Mari.layout_orig.base,thor)	// ** Tennessee Regulation Board & Commission Commerce & Insurance
													 + dataset(FileName + 'S0819',	Prof_License_Mari.layout_orig.base,thor)	// ** Texas Real Estate Commission
													 // + dataset(FileName + 'S0404',	Prof_License_Mari.layout_orig.base,thor)	// ** Veterans Administration
													 // + dataset(FileName + 'S0682',	Prof_License_Mari.layout_orig.base,thor) 	// ** Utah Department of Financial Institutions
													 + dataset(FileName + 'S0683',	Prof_License_Mari.layout_orig.base,thor)	// ** Utah Division of Real Estate
													 + dataset(FileName + 'S0356',	Prof_License_Mari.layout_orig.base,thor)	// ** Vermont, Office of the Secretary of State
													 + dataset(FileName + 'S0849',  Prof_License_Mari.layout_orig.base,thor)	// ** Virginia Department of Professional/Occupational Regulation
													 // + dataset(FileName + 'S0816',	Prof_License_Mari.layout_orig.base,thor)	// ** West Virginia Real Estate Appraisal License & Certification Board
													 + dataset(FileName + 'S0854',	Prof_License_Mari.layout_orig.base,thor)	// ** Wisconsin Department of Regulation and Licensing
													 + dataset(FileName + 'S0690',	Prof_License_Mari.layout_orig.base,thor)	// ** Wyoming Division of Banking
													 + dataset(FileName + 'cmrflat',Prof_License_Mari.layout_orig.base,thor); 	// ** FullDump
													 // + dataset(FileName + 'S0900',	Prof_License_Mari.layout_orig.base,thor);
													 

dsfile:= project(concat_maribase, TRANSFORM(Prof_License_Mari.layouts.base,
																																// self.mltreckey := left.mltrec_key;
																																self := left;
																																self := []));


export file_Maribase_old := dsfile   : persist('~thor_data400::persist::proflic_mari::all_sources');


// NewRecs := PROJECT(People,TRANSFORM(NewRec,SELF := LEFT));
// ut.MAC_SF_BuildProcess(concatenated_basefiles, '~thor_data400::in::proflic_mari::all_sources', all_sources, 3, /*csvout*/false, /*compress*/true);
// export base_new := concatenated_basefiles; 

// export base_old := concat_maribase;

// export base_old := output(concat_maribase,,'~thor_data400::in::proflic_mari::all_sources_' + filedate,overwrite);

// END;