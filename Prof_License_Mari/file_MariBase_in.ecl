import _control, MDR, Data_services, lib_stringlib, Prof_License_Mari, Std, Ut;

FileName	:=	data_services.foreign_prod+'thor_data400::in::proflic_mari::';

fixS0900	:= 	PROJECT(dataset(FileName + 'S0900',	Prof_License_Mari.layout_base_in, thor),													// ** NMLS
															TRANSFORM(Prof_License_Mari.layouts.base, 
															SELF.STD_SOURCE_DESC	:= IF(LEFT.STD_SOURCE_DESC = 'NATIONWIDE MORTGAGE LICENSING SYSTEM & REGISTRY','NMLS CONSUMER ACCESS',LEFT.STD_SOURCE_DESC),SELF:=LEFT, SELF:=[]));

concatenated_basefiles :=  
														PROJECT(dataset(FileName + 'cmrflat',Prof_License_Mari.layout_base_in,thor),							// ** FullDump
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'cmrflat_test',Prof_License_Mari.layout_base_in,thor),			// ** Test Records
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0812',	Prof_License_Mari.layout_base_in,thor),						// ** Alabama Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0845',	Prof_License_Mari.layout_base_in,thor),						// ** Alabama Real Estate Appraiser Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0635',	Prof_License_Mari.layout_base_in,thor),						// ** Alabama Mortgage Professionals 
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0376',	Prof_License_Mari.layout_base_in,thor),						// ** Alaska Department of Community & Economic Development
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0813',	Prof_License_Mari.layout_base_in,thor),						// ** Arizona Department of Real Estate
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0808',	Prof_License_Mari.layout_base_in,thor),						// ** Arizona Board of Appraisers
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0639',	Prof_License_Mari.layout_base_in,thor),						// ** Arizona Mortgage Lenders
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0824',	Prof_License_Mari.layout_base_in,thor),						// ** Arkansas Appraiser Licensing & Certification Board 
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0835',	Prof_License_Mari.layout_base_in,thor),						// ** Arkansas Real Estate Commision
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0681',	Prof_License_Mari.layout_base_in,thor),						// ** California Department of Real Estate
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0847',	Prof_License_Mari.layout_base_in,thor),						// ** California Office of Real Estate Appraisers
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0865',	Prof_License_Mari.layout_base_in,thor),						// ** Colorado Division of Real Estate MTG
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0821',	Prof_License_Mari.layout_base_in,thor),						// ** Colorado Division of Real Estate
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0632',	Prof_License_Mari.layout_base_in,thor),						// ** Colorado Uniform Consumer Credit Code
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0850',	Prof_License_Mari.layout_base_in,thor),						// ** Connecticut Department of Consumer Protection
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0860',	Prof_License_Mari.layout_base_in,thor),						// ** District of Columbia  Real Estate Agents, Brokers & Firms
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0846',	Prof_License_Mari.layout_base_in,thor),						// ** Delaware Division of Professional Regulation
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0630',	Prof_License_Mari.layout_base_in,thor),						// ** Delaware Mortgage 
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0643', 	Prof_License_Mari.layout_base_in,thor),						// ** Federal Deposit Insurance Corporation 
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0280',	Prof_License_Mari.layout_base_in,thor),						// ** Florida Department of Business & Professional Regulation
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0825',	Prof_License_Mari.layout_base_in,thor),						// ** Georgia Real Esate Commision & Appraisers Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0117',	Prof_License_Mari.layout_base_in,thor),						// ** Hawaii Department of Commerce & Consumer Affairs
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0645',  Prof_License_Mari.layout_base_in,thor),  				// ** Department of Housing and Urban Development 
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0262',	Prof_License_Mari.layout_base_in,thor),						// ** Idaho Bureau of Occupational Licenses
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0827',	Prof_License_Mari.layout_base_in,thor),						// ** Idaho Real Estate Commission Agents
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0658',	Prof_License_Mari.layout_base_in,thor),  					// ** Idaho Mortgage Lenders 
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0829',	Prof_License_Mari.layout_base_in,thor),						// ** Illinois Department of Profession Regulation
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0610',	Prof_License_Mari.layout_base_in,thor),						// ** Indiana Secretary of State
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0644',	Prof_License_Mari.layout_base_in,thor),						// ** Indiana Department of Financial Institutes
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0901',	Prof_License_Mari.layout_base_in,thor),						// ** Access Indiana
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0887',	Prof_License_Mari.layout_base_in,thor),						// ** Iowa Real Estate & Commission * Appraisal
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0826',	Prof_License_Mari.layout_base_in,thor),						// ** Iowa Real Estate Commission & Appraisal
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0902',	Prof_License_Mari.layout_base_in,thor),						// ** Kansas Real Estate Appraisers Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0903',	Prof_License_Mari.layout_base_in,thor),						// ** Kansas Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0809',	Prof_License_Mari.layout_base_in,thor),						// ** Kentucky Real Estate Appraisers Board 
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0831',	Prof_License_Mari.layout_base_in,thor),						// ** Kentucky Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0833',	Prof_License_Mari.layout_base_in,thor),						// ** Louisana Real Estate Appraiser Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
	                         + PROJECT(dataset(FileName + 'S0832',	Prof_License_Mari.layout_base_in,thor),						// ** Louisana Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0838',	Prof_License_Mari.layout_base_in,thor),						// ** Maine Board of Real Estate Appraisers
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
                           + PROJECT(dataset(FileName + 'S0888',	Prof_License_Mari.layout_base_in,thor),						// ** Maine Board of Real Estate Appraisers
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0834',	Prof_License_Mari.layout_base_in,thor),						// ** Maryland Commssion of Real Estate Appraiser & Home Inspection
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0836',	Prof_License_Mari.layout_base_in,thor),					// ** Maryland Real Estate Commission 
																					TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													+ PROJECT(dataset(FileName + 'S0021',	Prof_License_Mari.layout_base_in,thor),						// ** Massachussetts, Commonwealth of (Development)
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0298',	Prof_License_Mari.layout_base_in,thor),						// ** Michigan Department of Consumer & Industry Service
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0867',	Prof_License_Mari.layout_base_in,thor),						// ** Minnesotas Bookstore
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0869',	Prof_License_Mari.layout_base_in,thor),						// ** Minnesotas Bookstore
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0815',	Prof_License_Mari.layout_base_in,thor),						// ** Mississippi Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0634',	Prof_License_Mari.layout_base_in,thor),						// ** Missouri Division of Finance
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0820',	Prof_License_Mari.layout_base_in,thor),						// ** Missouri Division of Professional Registration
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0398',	Prof_License_Mari.layout_base_in,thor),						// ** Montana Department of Labor and Industry
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0648',	Prof_License_Mari.layout_base_in,thor),						// ** National Credit Union Administration
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0814',	Prof_License_Mari.layout_base_in,thor),						// ** ASC National Registry
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0842',	Prof_License_Mari.layout_base_in,thor),						// ** Nebraska Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0859',	Prof_License_Mari.layout_base_in,thor),						// ** Nebraska Real Property Appraiser Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0857',	Prof_License_Mari.layout_base_in,thor),						// ** Nevada Real Estate Division
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0856',	Prof_License_Mari.layout_base_in,thor),						// ** New Hampshire Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0033',	Prof_License_Mari.layout_base_in,thor),						// ** New Jersey Department of Law & Public Safety
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0822',	Prof_License_Mari.layout_base_in,thor),						// ** New Mexico Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
                           + PROJECT(dataset(FileName + 'S0843',	Prof_License_Mari.layout_base_in,thor),						// ** New Mexico Real Estate Appraiser Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0828',  Prof_License_Mari.layout_base_in,thor),  					// ** New Your Appraisers
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0840',	Prof_License_Mari.layout_base_in,thor) ,					// ** North Carolina Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0841',	Prof_License_Mari.layout_base_in,thor) ,					// ** North Carolina Appraisal Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0855',	Prof_License_Mari.layout_base_in,thor),						// ** North Dakota Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0654',	Prof_License_Mari.layout_base_in,thor) ,					// ** Ohio Department of Commerce
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0817',	Prof_License_Mari.layout_base_in,thor),						// ** Oklahoma Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
												   + PROJECT(dataset(FileName + 'S0839',	Prof_License_Mari.layout_base_in,thor),						// ** Oregon Real Estate Agency
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0818',  Prof_License_Mari.layout_base_in,thor),						// ** Oregon Real Estate Appraisers
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0868',	Prof_License_Mari.layout_base_in,thor),						// ** Pennsylvania, Commonwealth of - Professional Licenses
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0889',	Prof_License_Mari.layout_base_in,thor) ,					// ** Commissioner of Financial Institute of Puerto Rico
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0811',	Prof_License_Mari.layout_base_in,thor),						// ** State of Rhode Island Department of Business Regulation
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0852',	Prof_License_Mari.layout_base_in,thor),						// ** South Carolina Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0853',	Prof_License_Mari.layout_base_in,thor),						// ** South Carolina Real Estate Appraiser Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
                           + PROJECT(dataset(FileName + 'S0810',	Prof_License_Mari.layout_base_in,thor),						// ** South Dakota Revenue & Regulation
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
                           + PROJECT(dataset(FileName + 'S0844',	Prof_License_Mari.layout_base_in,thor),						// ** South Dakota Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0513',	Prof_License_Mari.layout_base_in,thor),						// ** Tennessee Regulation Board & Commission Commerce & Insurance
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
                           + PROJECT(dataset(FileName + 'S0636',	Prof_License_Mari.layout_base_in,thor),						// ** Texas Office of Consumer Credit Commissioner 
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0819',	Prof_License_Mari.layout_base_in,thor),						// ** Texas Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0404',	Prof_License_Mari.layout_base_in,thor),						// ** Veterans Administration(Development)
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0682',	Prof_License_Mari.layout_base_in,thor) ,					// ** Utah Department of Financial Institutions
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0683',	Prof_License_Mari.layout_base_in,thor),						// ** Utah Division of Real Estate
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0356',	Prof_License_Mari.layout_base_in,thor),						// ** Vermont, Office of the Secretary of State
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0849',  Prof_License_Mari.layout_base_in,thor),						// ** Virginia Department of Professional/Occupational Regulation
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0816',	Prof_License_Mari.layout_base_in,thor),						// ** West Virginia Real Estate Appraisal License & Certification Board
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0854',	Prof_License_Mari.layout_base_in,thor),						// ** Wisconsin Department of Regulation and Licensing
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + PROJECT(dataset(FileName + 'S0858',	Prof_License_Mari.layout_base_in,thor),						// ** Wyoming Real Estate Commission
																				 TRANSFORM(Prof_License_Mari.layouts.base,SELF:=LEFT,SELF:=[]))
													 + MDR.macGetGlobalSid(fixS0900, 'Mari', 'std_source_upd', 'global_sid');								// ** NMLS
													 
													 // + PROJECT(dataset(FileName + 'S0690',	Prof_License_Mari.layout_base_in,thor)					// ** Wyoming Division of Banking
													 
											 
export file_Maribase_in := concatenated_basefiles; 


