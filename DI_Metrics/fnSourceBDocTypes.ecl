﻿EXPORT fnSourceBDocTypes (string typ) := FUNCTION
						DocumentType := CASE(trim(typ),                    
																						'AA'  =>  'ASSIGNMENT OF SUB AGREEMENT OF SALE',
																						'AB'  =>  'ASSIGNMENT OF SUB LEASE',
																						'AC'  =>  'ASSIGNMENT OF A COMMERCIAL LEASE',
																						'AD'  =>  'ADMINISTRATORS DEED',
																						'AG'  =>  'AGREEMENT OF SALE',
																						'AH'  =>  'ASSESSOR SALES HISTORY',
																						'AR'  =>  'ASSIGNMENT OF AGREEMENT OF SALE',
																						'AS'  =>  'ASSIGNMENT DEED',
																						'AT'  =>  'AFFIDAVIT OF TRUST OR TRUST AGREEMENT (LOS ANGELES COUNTY ONLY)',
																						'AU'  =>  'ASSIGNMENT OF SUB COMMERCIAL LEASE',
																						'BD'  =>  'BENEFICIARY DEED',
																						'CA'  =>  'COMMISIONERS ASSIGNMENT OF LEASE',
																						'CH'  =>  'CASH SALE DEED',
																						'CL'  =>  'COMMERCIAL LEASE',
																						'CM'  =>  'COMMISSIONERS DEED',
																						'CN'  =>  'CANCELLATION OF AGREEMENT OF SALE',
																						'CO'  =>  'CONSERVATORS DEED',
																						'CP'  =>  'CORPORATION DEED',
																						'CR'  =>  'CORRECTION DEED',
																						'CS'  =>  'CONTRACT OF SALE',
																						'CT'  =>  'CERTIFICATE OF TRANSFER',
																						'DB'  =>  'DEED OF DISTRIBUTION',
																						'DC'  =>  'DECLARATION',
																						'DD'  =>  'TRANSFER ON DEATH DEED',
																						'DG'  =>  'DEED OF GUARDIAN',
																						'DJ'  =>  'AFFIDAVIT OF DEATH OF JOINT TENANT',
																						'DS'  =>  'DISTRESS SALE',
																						'EC'  =>  'EXCHANGE',
																						'EX'  =>  'EXECUTORS DEED',
																						'FD'  =>  'FIDUCIARY DEED',
																						'GR'  =>  'GROUND LEASE',
																						'ID'  =>  'INDIVIDUAL DEED',
																						'LA'  =>  'LEGAL ACTION/COURT ORDER',
																						'LC'  =>  'LEASEHOLD CONVERSION WITH DEED (FREE PURCHASE)',
																						'LD'  =>  'LAND CONTRACT',
																						'LE'  =>  'LEASE',
																						'LH'  =>  'ASSIGNMENT OF LEASE (LEASEHOLD SALE)',
																						'LT'  =>  'LAND COURT',
																						'LW'  =>  'LIMITED WARRANTY DEED',
																						'MD'  =>  'SPECIAL MASTERS DEED',
																						'OT'  =>  'OTHER',
																						'PA'  =>  'PUBLIC AUCTION OR PROPERTY SOLD FOR TAXES',
																						'PR'  =>  'PERSONAL REPRESENTATIVES DEED',
																						'QC'  =>  'QUIT CLAIM DEED',
																						'RA'  =>  'RELEASE/SATISFACTION OF AGREEMENT OF SALE (FREE PROPERTY)',
																						'RD'  =>  'REDEMPTION DEED',
																						'RF'  =>  'REFEREES DEED (FORECLOSURE SALE TRANSFER NY)',
																						'RR'  =>  'RE-RECORDED DOCUMENT TO CORRECT NAME, DESC., ETC.',
																						'RS'  =>  'REO SALE (REO OUT)',
																						'SA'  =>  'SUB AGREEMENT OF SALE',
																						'SC'  =>  'SUB COMMERCIAL LEASE',
																						'SD'  =>  'SHERIFFS DEED',
																						'SL'  =>  'SUB LEASE',
																						'ST'  =>  'AFFIDAVIT DEATH OF TRUSTEE/SUCCESSOR TRUSTEE (LOS ANGELES COUNTY ONLY)',
																						'SV'  =>  'SURVIVORSHIP DEED',
																						'SW'  =>  'SPECIAL WARRANTY DEED',
																						'TD'  =>  'TRUSTEES DEED - (CERTIFICATE OF TITLE)',
																						'VL'  =>  'VENDORS LIEN',
																						'WD'  =>  'WARRANTY DEED',
																						'PD'  =>  'PARTNERSHIP DEED',
																						'DL'  =>  'DEED IN LIEU OF FORECLOSURE',
																						'AF'  =>  'AFFIDAVIT',
																						'JT'  =>  'JOINT TENANCY DEED',
																						'GD'  =>  'GRANT DEED',
																						'DE'  =>  'DEED',
																						'RL'  =>  'RELEASE/SATISFACTION OF AGREEMENT OF SALE (LEASEHOLD PROPERTY)',
																						'LS'  =>  'LEASEHOLD CONVERSION WITH AN AGREEMENT OF SALE',
																						'CD'  =>  'CONDOMINIUM DEED',
																						'BS'  =>  'BARGAIN AND SALE DEED',
																						'GF'  =>  'GIFT DEED',
																						'FC'  =>  'FORECLOSURE',
																						'RC'  =>  'RECEIVERS DEED',
																						'IT'  =>  'INTERFAMILY TRANSFER & DISSOLUTION', 
																						''    =>  '',
																						'invalid_code') ;

						return DocumentType;
						END;                
