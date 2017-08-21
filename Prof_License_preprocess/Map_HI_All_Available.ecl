EXPORT Map_HI_All_Available(string fdate) := module

import NID,Prof_License;

aa_outrec := record                                     
   string8 process_date;                   
   string3 BOARD_CODE;                     
   string60 INDIVIDUAL_OR_BUSINESS_NAME;   
   string5 LICENSE_TYPE;                   
   string6 LICENSE;                        
   string3 LIC_OFFICE;                     
   string2 RECORD_TYPE_NUMBER;             
   string4 BOARD_ALPHA;                    
   string92 LICENSE_NAME;                  
   string8 EFFECTIVE_DATE;                 
   string8 EXPIRE_DATE;                    
   string2 LICENSE_STATUS;                 
   string1 Blank;                          
   string3 EMPLOY_POSITION_CODE;           
   string1 EMPLOY_STATUS;                  
   string5 EMPLOY_LIC_TYPE;                
   string7 NUMBER;                         
   string3 EMPLOY_LIC_OFFICE_Number;       
   string60 EMPLOY_BP_SORTNAME;            
   string1 SPECIALTY_PRIVIL_CODE;          
   string1  LIC_RESTRICTION;               
   string1 CONDITIONAL_LIC_INDICATOR;      
   string30 ADDRESS1;                      
   string30 ADDRESS2;                      
   string20 CITY;                          
   string2 STATE;                          
   string5 ZIP;                            
   string2 BUSINESS_ADD_RESTRIC_CODE;      
   string30 PUBLIC_ADDRESS1;               
   string27 PUBLIC_ADDRESS2;               
   string13 CITY1;                         
   string2 STATE1;                         
   string5 ZIP1;                           
   string3 CLASS_PREFIX1;                  
   string1 lf;                             
end;                                        

aa_outrec map2fixed( File_HI_All_Available.File_aa l ) := transform
self.process_date := fdate;                                       
self.BOARD_CODE := l.Board_Code;                                       
self.INDIVIDUAL_OR_BUSINESS_NAME := l.Sortname;                        
self.LICENSE_TYPE := l.License_Type;                                   
self.LICENSE := l.License_Number;                                      
self.LIC_OFFICE := l.License_Office;                                   
self.RECORD_TYPE_NUMBER := l.Record_Type;                              
self.BOARD_ALPHA := l.Board_Alpha;                                     
self.LICENSE_NAME := l.License_Sortname;                               
self.EFFECTIVE_DATE := l.Effective_Date;                               
self.EXPIRE_DATE := l.Expiration_Date;                                 
self.LICENSE_STATUS := trim(l.LICENSE_STATUS);                               
self.EMPLOY_POSITION_CODE := l.Employment_Position_Code;               
self.EMPLOY_STATUS := l.Employment_Status;                             
self.EMPLOY_LIC_TYPE := l.Employer_License_Type;                       
self.NUMBER := l.Employer_License_Number;                              
self.EMPLOY_LIC_OFFICE_Number := l.Employer_License_Office_Number;     
self.EMPLOY_BP_SORTNAME := l.Employer_BP_Sortname;                     
self.SPECIALTY_PRIVIL_CODE := l.Special_Privilege_Indicator;           
self.LIC_RESTRICTION := l.License_Restriction_Indicator;               
self.CONDITIONAL_LIC_INDICATOR := l.Conditional_License_Indicator;     
self.ADDRESS1 := l.Business_Address_1;                                 
self.ADDRESS2 := l.Business_Address_2;                                 
self.CITY := l.Business_City;                                          
self.STATE := l.Business_State;                                        
self.ZIP := l.Business_Zipcode;                                        
self.BUSINESS_ADD_RESTRIC_CODE := l.Business_Address_Restriction_Code; 
self.PUBLIC_ADDRESS1 := l.Public_Address_1;                            
self.PUBLIC_ADDRESS2 := l.Public_Address_2;                            
self.CITY1 := l.Public_City;                                           
self.STATE1 := l.Public_State;                                         
self.ZIP1 := l.Public_Zipcode;                                         
self.CLASS_PREFIX1 := l.Class_Prefix;                                  
self.Blank := '';  
self.lf := '';                                                    
end;

dWithFixed := project(  File_HI_All_Available.file_aa,    map2fixed(left));

Prof_License.Layout_proLic_in map2common ( dWithFixed l ) := transform
license_type_desc   := case( trim(l.LICENSE_TYPE) ,    
'ACU'  =>   'ACUPUNCTURIST',    
'AD'  =>   'ACTIVITY DESKS',      
'ADB'  =>   'ACTIVITY DESK BRANCH',     
'AMD'  =>   'CERTIFIED PHYSICIAN\'S ASSISTANT',      
'APRN' =>   'ADVANCED PRACTICE REGISTERED NURSE RECOGNITION',     
'AR'  =>   'ARCHITECT',      
'AUC'  =>   'AUCTION',     
'AUD'  =>   'AUDIOLOGIST',     
'BAR'  =>   'BARBER',     
'BAS'  =>   'BARBER SHOP',     
'BEO'  =>   'BEAUTY OPERATOR',     
'BSC'  =>   'BEAUTY SCHOOL',     
'BSH'  =>   'BEAUTY SHOP',     
'BXA'  =>   'BOXING ANNOUNCER',     
'CCV'  =>   'CONSUMER CONSULTANT VEHICLE',     
'CE'  =>   'CEMETERY AUTHORITY',      
'CGA'  =>   'CERTIFIED GENERAL APPRAISER',     
'CHO'  =>   'CONDOMINIUM HOTEL OPERATOR',     
'CMA'  =>   'CONDOMINIUM MANAGING AGENT',     
'COLA' =>   'COLLECTION AGENCY',     
'COLAX'=>   'EXEMPT OUT-OF-STATE COLLECTION AGENCY',     
'CPA'  =>   'CERTIFIED PUBLIC ACCOUNTANT',     
'CRA'  =>   'CERTIFIED RESIDENTIAL APPRAISER',     
'CS'  =>   'MOTOR VEHICLE SALESPERSON',      
'CT'  =>   'CONTRACTOR',      
'DC'  =>   'CHIROPRACTOR',      
'DH'  =>   'DENTAL HYGIENIST',      
'DIO'  =>   'DISPENSING OPTICIAN',     
'DIS'  =>   'DISTRIBUTOR',     
'DOS'  =>   'OSTEOPATHIC PHYSICIAN AND SURGEON',     
'DOSR' =>   'OSTEOPATHIC RESIDENT',     
'DT'  =>   'DENTIST',      
'EJ'  =>   'JOURNEYMAN ELECTRICIAN',      
'EJI'  =>   'JOURNEYMAN INDUSTRIAL ELECTRICIAN',     
'EJS'  =>   'JOURNEYMAN SPECIALTY ELECTRICIAN',     
'EL'  =>   'ELECTROLOGIST',      
'EM'  =>   'MAINTENANCE ELECTRICIAN',      
'EMA'  =>   'EMPLOYMENT AGENCY',     
'EMP'  =>   'PRINCIPAL AGENT OF EMPLOYMENT AGENCY',     
'EMTB' =>   'EMERGENCY MEDICAL TECHNICIAN-BASIC',     
'EMTP' =>   'EMERGENCY MEDICAL TECHNICIAN-PARAMEDIC',     
'ES'  =>   'SUPERVISING ELECTRICIAN',      
'ESI'  =>   'SUPERVISING INDUSTRIAL ELECTRICIAN',     
'ESS'  =>   'SUPERVISING SPECIALTY ELECTRICIAN',     
'EVM'  =>   'ELEVATOR MECHANIC',     
'GD'  =>   'GUARD',      
'GDA'  =>   'GUARD AGENCY',     
'HA'  =>   'HEARING AID DEALER & FITTER',      
'I'  =>   'BEAUTY INSTRUCTOR',       
'LA'  =>   'LANDSCAPE ARCHITECT',      
'LPN'  =>   'LICENSED PRACTICAL NURSE',     
'LS'  =>   'LAND SURVEYOR', 
 'LSW'  =>   'LICENSED SOCIAL WORKER',										
'LTD'  =>   'LIMITED PRACTICAL NURSE',     
'MAE'  =>   'MASSAGE ESTABLISHMENT',     
'MAT'  =>   'MASSAGE THERAPIST',     
'MB'  =>   'MORTGAGE BROKER',      
'MBB'  =>   'MORTGAGE BROKER BRANCH OFFICE',     
'MC'  =>   'CERTIFIED MECHANIC',      
'MD'  =>   'PHYSICIAN',      
'MDG'  =>   'PHYSICIAN-LIMITED (GOVERNMENT)',     
'MDR'  =>   'PHYSICIAN-RESIDENT',     
'MDS'  =>   'PHYSICIAN-LIMITED (SPONSORSHIP)',     
'MDT'  =>   'MEDICAL BOARD TEACHER',     
'MFT'  =>   'MARRIAGE AND FAMILY THERAPIST',     
'MR'  =>   'REGISTERED MECHANIC',      
'MRC'  =>   'REGISTERED AND CERTIFIED MECHANIC',     
'MS'  =>   'MORTGAGE SOLICITOR',      
'MVB'  =>   'MOTOR VEHICLE BRANCH LOCATION',     
'MVD'  =>   'MOTOR VEHICLE DEALER',     
'ND'  =>   'NATUROPATHIC PHYSICIAN',      
'NHA'  =>   'NURSING HOME ADMINISTRATOR',     
'OD'  =>   'OPTOMETRIST',      
'OT'  =>   'REGISTERED OCCUPATIONAL THERAPIST',
'PA'  =>   'PUBLIC ACCOUNTANT',      
'PCFR' =>   'FIELD REPRESENTATIVE',     
'PCO'  =>   'PEST CONTROL OPERATOR',     
'PD'  =>   'PRIVATE DETECTIVE',      
'PDA'  =>   'PRIVATE DETECTIVE AGENCY',     
'PE'  =>   'PROFESSIONAL ENGINEER',      
'PH'  =>   'PHARMACIST',      
'PHY'  =>   'PHARMACY',     
'PJ'  =>   'JOURNEYMAN PLUMBER',      
'PM'  =>   'MASTER PLUMBER',      
'PMP'  =>   'MISCELLANEOUS PERMIT',     
'PNF'  =>   'PRE-NEED FUNERAL AUTHORITY',     
'PO'  =>   'PODIATRIST',      
'PP'  =>   'PORT PILOT',      
'PPD'  =>   'DEPUTY PORT PILOT',     
'PSY'  =>   'PSYCHOLOGIST',     
'PSYI' =>   'INDUSTRIAL PSYCHOLOGIST',     
'PT'  =>   'PHYSICAL THERAPIST',      
'PWD'  =>   'WHOLESALE PRESCRIPTION DRUG DISTRIBUTOR',     
'RB'  =>   'REAL ESTATE BROKER',      
'RBO'  =>   'REAL ESTATE BRANCH OFFICE',     
'RD'  =>   'MOTOR VEHICLE REPAIR DEALER',      
'RDS'  =>   'MOTOR VEHICLE REPAIR SALVAGE DEALER',     
'RN'  =>   'REGISTERED NURSE',      
'RS'  =>   'REAL ESTATE SALESPERSON',      
'RSO'  =>   'REAL ESTATE SITE OFFICE',     
'RX'  =>   'APRN-RX   ADVANCED PRACTICE RN PRESCRIPTIVE AUTHORITY',    
'SLA'  =>   'STATE LICENSED APPRAISER',     
'SP'  =>   'SPEECH PATHOLOGIST',      
'TAR'  =>   'TRAVEL AGENCY',     
'VE'  =>   'VETERINARIAN',
'');
	
self.license_type :=   license_type_desc;                                                                                                                                                                                                           
    self.source_st := 'HI';                                                                                                                                                                                                                                                         
    self.company_name := if ( NID.GetNameType ( l.INDIVIDUAL_OR_BUSINESS_NAME) <> 'B' ,'',  l.INDIVIDUAL_OR_BUSINESS_NAME );                                                                                                                                                            
                                                                                                                                                                                                                                              
    self.orig_name := if ( NID.GetNameType ( l.INDIVIDUAL_OR_BUSINESS_NAME) = 'B' ,'',  l.INDIVIDUAL_OR_BUSINESS_NAME );                                                                                                                                                                                                                                                                                                                                    
    self.name_order :=  if ( NID.GetNameType ( l.INDIVIDUAL_OR_BUSINESS_NAME) <> 'B','FML' ,'');                                                                                                                                                                                                                                                                                                                                                                                             

    self.business_flag := if ( NID.GetNameType ( l.INDIVIDUAL_OR_BUSINESS_NAME) <> 'B' ,'N','Y' );                                                                                                                                                               
                                                                                                                                                                                                                                                          
    self.vendor := 'State of Hawaii, Hawaii Information Consortium';                                                                                                                                                                                                                
    self.status :=   map ( trim(l.LICENSE_STATUS) = 'C' =>   'CURRENT, VALID & IN GOOD STANDING                            ',        
                        trim(l.LICENSE_STATUS) = 'CM' =>   'CURRENT, VALID & IN GOOD STANDING/MAINT. REQUIREMENT DUE     ',        
                        trim(l.LICENSE_STATUS) = 'CR' =>   'CURRENT/NEXT RENEWAL PAID                                    ',        
                        trim(l.LICENSE_STATUS) = 'D' =>   'DELINQUENT                                                   ',        
                        trim(l.LICENSE_STATUS) = 'DA' =>   'DELINQUENT RESTORATION SUBJECT TO APPROVAL/MAINT. MAY BE DUE ',        
                        trim(l.LICENSE_STATUS) = 'DM' =>   'DELINQUENT/MAINTENANCE REQUIREMENT DUE                       ',        
                        trim(l.LICENSE_STATUS) = 'DN' =>   'DOWNGRADED LICENSE TYPE                                      ',        
                        trim(l.LICENSE_STATUS) = 'EX' =>   'EXEMPT FROM CMA REGISTRATION                                 ',        
                        trim(l.LICENSE_STATUS) = 'F' =>   'FORFEITED, APPLY AS NEW APPLICANT                            ',        
                        trim(l.LICENSE_STATUS) = 'FA' =>   'FORFEITED, RESTORATION SUBJECT TO APPROVAL AND MAYBE         ',        
                        trim(l.LICENSE_STATUS) = 'FM' =>   'FORFEITED/MAINTENANCE REQUIREMENT DUE                        ',        
                        trim(l.LICENSE_STATUS) = 'H' =>   'HISTORY                                                      ',        
                        trim(l.LICENSE_STATUS) = 'LP' =>   'LAW REPEALED                                                 ',        
                        trim(l.LICENSE_STATUS) = 'NS' =>   'NO STATUS OR STATUS NOT APPLICABLE                           ',        
                        trim(l.LICENSE_STATUS) = 'R' =>   'VALID THRU EXPIRATION DATE, RENEWAL NOTICE SENT              ',        
                        trim(l.LICENSE_STATUS) = 'RM' =>   'VALID THRU EXPIRATION DATE, RENEWAL NOTICE SENT/MAINTENANCE  ',        
                        trim(l.LICENSE_STATUS) = 'SC' =>   'SOLE OWNER LICENSE CANCELLED, CORPORATION/PARTNERSHIP        ',        
                        trim(l.LICENSE_STATUS) = 'TC' =>   'CLOSED OR CANCELLED                                          ',        
                        trim(l.LICENSE_STATUS) = 'TD' =>   'DECEASED                                                     ',        
                        trim(l.LICENSE_STATUS) = 'TF' =>   'RME 0R CORP. FORFEITED DUE TO LOSS OF PRIN. & FAILURE TO     ',        
                        trim(l.LICENSE_STATUS) = 'TI' =>   'INACTIVE NURSE APRN, RN & LPN                                ',        
                        trim(l.LICENSE_STATUS) = 'TN' =>   'LICENSING NO LONGER REQUIRED                                 ',        
                        trim(l.LICENSE_STATUS) = 'TR' =>   'RESCINDED LICENSE                                            ',        
                        trim(l.LICENSE_STATUS) = 'TS' =>   'FORFEITED DUE TO NONPAYMENT OF CT SPECIAL ASSESSMENT         ',        
                        trim(l.LICENSE_STATUS) = 'TX' =>   'TERMINATED AND REFUNDED                                      ',        
                        trim(l.LICENSE_STATUS) = 'UP' =>   'UPGRADED                                                     ',        
                        trim(l.LICENSE_STATUS) = 'Y' =>   'APPROVED BY BOARD                                            ',        
                        trim(l.LICENSE_STATUS) = 'Z' =>   'CURRENT & VALID, BUT SUBJECT TO DISCIPLINARY REQUIREMENT     ',        
                        trim(l.LICENSE_STATUS) = 'Z1' =>   'SUSPENSION PERIOD ALMOST OVER AND ELIGIBLE FOR REINSTATEMEN  ',        
                        trim(l.LICENSE_STATUS) = 'ZC' =>   'VOLUNTARILY SURRENDER OR FORFEIT LICENSE DUE TO              ',        
                        trim(l.LICENSE_STATUS) = 'ZD' =>   'DELINQUENT/FORFEITED DISCIPLINED LICENSE                     ',        
                        trim(l.LICENSE_STATUS) = 'ZF' =>   'TERMINATED DUE TO RECOVERY FUND PAYOUT                       ',        
                        trim(l.LICENSE_STATUS) = 'ZI' =>   'AUTOMATICALLY FORFEITED DUE TO INSURANCE LOSS                ',        
                        trim(l.LICENSE_STATUS) = 'ZM' =>   'CURRENT & VALID, BUT SUBJECT TO DISCIPLINARY/MAINTENANCE     ',        
                        trim(l.LICENSE_STATUS) = 'ZO' =>   'OUT OF STATE DISCIPLINARY ACTION                             ',        
                        trim(l.LICENSE_STATUS) = 'ZR' =>   'REVOKED                                                      ',        
                        trim(l.LICENSE_STATUS) = 'ZS' =>   'SUSPENDED                                                    ',        
                        trim(l.LICENSE_STATUS) = 'ZT' =>   'REMAIN FORFEITED DUE TO FAILURE TO RESTORE WITHIN THE 60     ',        
                        trim(l.LICENSE_STATUS) = 'ZW' =>   'CONDITIONAL LICENSE WITHDRAWN                                ',        
                    '') [1..45];                                                                                                                                                                                                                             
    self.license_number := l.LICENSE;                                                                                                                                                                                                                                               
    self.profession_or_board := license_type_desc;                                                                                                                                                                                                 
    self.date_first_seen := fdate;                                                                                                                                                                                                                                         
    self.date_last_seen := fdate;                                                                                                                                                                                                                                          
    self.issue_date := if ( (l.EFFECTIVE_DATE) <> ' ' ,                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                    
                                                   if(    l.EFFECTIVE_DATE[5..6]  <= '20' and l.EFFECTIVE_DATE[5..6] >= '00' , '20' , '19' ) +                                                                                                                                                              
                                                       l.EFFECTIVE_DATE[5..6] +l.EFFECTIVE_DATE[1..4] , '');                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                              
    self.expiration_date := if(l.EXPIRE_DATE  <> ' ',                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                    
                                      if( l.EXPIRE_DATE[5..6]  < '50' and l.EXPIRE_DATE[5..6] >= '00' , '20' , '19') +                                                                                                                                                                       
                                     l.EXPIRE_DATE[5..6] +l.EXPIRE_DATE[1..4] , '');                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                 
    self.orig_addr_1 := l.ADDRESS1;                                                                                                                                                                                                                                                 
    self.orig_addr_2 := l.ADDRESS2;                                                                                                                                                                                                                                                 
    self.orig_city := l.CITY;                                                                                                                                                                                                                                                       
    self.orig_st := l.STATE;                                                                                                                                                                                                                                                        
    self.orig_zip := l.ZIP;                                                                                                                                                                                                                                                         
    self.additional_orig_additional_1 := l.PUBLIC_ADDRESS1;                                                                                                                                                                                                                         
    self.additional_orig_additional_2 := l.PUBLIC_ADDRESS2;                                                                                                                                                                                                                         
    self.additional_orig_city := l.CITY1;                                                                                                                                                                                                                                           
    self.additional_orig_st := l.STATE1;                                                                                                                                                                                                                                            
    self.additional_orig_zip := l.ZIP1;                                                                                                                                                                                                                                             
    self.additional_name_addr_type := if ( l.PUBLIC_ADDRESS1 <> '' or l.PUBLIC_ADDRESS2 <> ''  or  l.CITY1 <> '' or l.STATE1 <> '', 'Public Address' , '');                                                                                                                                                                             
    self.additional_licensing_specifics := map ( l.SPECIALTY_PRIVIL_CODE = 'A' =>  'GENERAL ANESTHESIA' ,                                                                                                                                                                                    
  				                               	l.SPECIALTY_PRIVIL_CODE = 'C' => 'CHARTER TOUR OPERATOR' ,                                                                                                                                                                                                                
  				                               	l.SPECIALTY_PRIVIL_CODE = 'D' =>  'DIAGNOSTIC PHARMACEUTICAL AGENTS' ,                                                                                                                                                                                                     
  				                               	l.SPECIALTY_PRIVIL_CODE = 'E' =>  'APPROVED TO USE DOCTORAL TITLE' ,                                                                                                                                                                                                       
  				                              	l.SPECIALTY_PRIVIL_CODE ='H' => 'HOME STUDY' ,                                                                                                                                                                                                                           
  				                                l.SPECIALTY_PRIVIL_CODE ='I' => 'INFILTRATION' ,                                                                                                                                                                                                                        
  				                               	l.SPECIALTY_PRIVIL_CODE = 'L' => 'INFILTRATION & BLOCK' ,                                                                                                                                                                                                                 
  				                               	l.SPECIALTY_PRIVIL_CODE = 'P' => 'PERMIT TO PRACTICE' ,                                                                                                                                                                                                                   
  				                               	l.SPECIALTY_PRIVIL_CODE = 'S' => 'CLINICAL SOCIAL WORKER' ,                                                                                                                                                                                                               
  					                              l.SPECIALTY_PRIVIL_CODE = 'T' => 'THERAPEUTIC PHARMACEUTICAL AGENTS'  , '');                                                                                                                                                                                               
    self.misc_other_id := map ( 
		                      l.LIC_RESTRICTION = ' ' => ' ',  
                          l.LIC_RESTRICTION = 'G' => 'MEDICAL GASES ONLY',  
                          l.LIC_RESTRICTION = 'M' => 'MOBILE            ',  
                          l.LIC_RESTRICTION = 'R' => 'RESTRICTED        ',  
                          l.LIC_RESTRICTION = 'T' => 'NO PHYSIOTHERAPY  ',  
                          l.LIC_RESTRICTION = 'V' => 'VAULT FUMIGATION  ', '');  
    self.misc_other_id_type := if(l.LIC_RESTRICTION <> '', 'Lic. Restr' , '');   
		self := [];
  end;                                                                                                                                                                                                                                                                              

 dHiAllout := project( dWithFixed , map2common(left))(profession_or_board <> '');
 
  dout := Sequential( Output( dHiAllout,,'~thor_data400::in::prolic::hi::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::hi::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::hi::all_available','~thor_data400::in::prolic::hi::all_available_'+fdate)
															 );
 
 outfile := proc_clean_all(dHiAllout,'HI').cleanout;

 
 export prep :=  Sequential( dout, 
                  FileServices.StartSuperfiletransaction(),
                                   FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_hi'),
																	   if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_hi_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_hi_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_hi_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_hi_old')),
                       FileServices.RenameLogicalfile( '~thor_data400::in::prolic_hi','~thor_data400::in::prolic_hi_old'),
										    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_hi_old'),
										            FileServices.FinishSuperfiletransaction(),
                         
											output( outfile,,'~thor_data400::in::prolic_hi',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
											   FileServices.RenameLogicalfile( '~thor_data400::in::prolic_hi','~thor_data400::in::prolic_hi_old'),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_hi'),
												 FileServices.FinishSuperfiletransaction()

											 );

end;
