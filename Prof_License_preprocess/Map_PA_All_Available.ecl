Import Prof_License,ut;


EXPORT Map_PA_All_Available (string fdate) := module

get_lictype( string license_number) := case ( license_number,

'CP' =>'ACCOUNTANCY FIRM                         ',
'CA' =>'CERTIFIED PUBLIC ACCOUNTANT              ',
'PA' =>'PUBLIC ACCOUNTANT                        ',
'RA' =>'REGISTERED ARCHITECT                     ',
'AX' =>'ARCHITECTURE FIRM                        ',
'AA' =>'APPRENTICE AUCTIONEER                    ',
'AH' =>'LICENSED AUCTION HOUSE                   ',
'AU' =>'AUCTIONEER                               ',
'AY' =>'LICENSED AUCTION COMPANY                 ',
'RY' =>'REGISTERED AUCTION COMPANY               ',
'RH' =>'REGISTERED AUCTION HOUSE                 ',
'RL' =>'CERTIFIED RESIDENTIAL APPRAISER          ',
'GA' =>'CERTIFIED GENERAL APPRAISER              ',
'AV' =>'CERTIFIED PENNSYLVANIA EVALUATOR         ',
'AZ' =>'CERTIFIED PENNSYLVANIA EVALUATOR         ',
'BA' =>'CERTIFIED BROKER/APPRAISER               ',
'PE' =>'PROFESSIONAL ENGINEER                    ',
'SU' =>'PROFESSIONAL LAND SURVEYOR               ',
'PG' =>'PROFESSIONAL GEOLOGIST                   ',
'LA' =>'LANDSCAPE ARCHITECT                      ',
'AB' =>'ASSOCIATE BROKER                         ',
'NA' =>'ASSOCIATE BROKER                         ',
'AL' =>'CEMETERY ASSOCIATE BROKER                ',
'CE' =>'CEMETERY REGISTRATION                    ',
'LB' =>'CEMETERY BROKER (SOLE PROPRIETOR)        ',
'LM' =>'CEMETERY BROKER OF RECORD                ',
'LS' =>'CEMETERY SALESPERSON                     ',
'MR' =>'MANAGER OF RECORD                        ',
'RO' =>'BRANCH OFFICE                            ',
'RB' =>'BROKER (SOLE PROPRIETOR)                 ',
'SB' =>'BROKER (SOLE PROPRIETOR)                 ',
'NB' =>'BROKER (CORP., LLC, PARTNER)             ',
'RR' =>'RENTAL LISTING REFERRAL AGENT            ',
'SR' =>'RENTAL LISTING REFERRAL AGENT            ',
'NS' =>'REAL ESTATE SALESPERSON                  ',
'RS' =>'REAL ESTATE SALESPERSON                  ',
'RE' =>'REAL ESTATE SCHOOL                       ',
'NM' =>'BROKER MULTI-LICENSE                     ',
'RM' =>'BROKER MULTI-LICENSE                     ',
'MS' =>'CAMPGROUND MEMBERSHIP SALESPERSON        ',
'RC' =>'BUILDER/OWNER SALESPERSON                ',
'TS' =>'TIME SHARE SALESPERSON                   ',
'VD' =>'VEHICLE DEALER                           ',
'MV' =>'VEHICLE SALESPERSON                      ',
'VB' =>'VEHICLE AUCTION                          ',
'VM' =>'VEHICLE MANUFACTURER                     ',
'MB' =>'MANUFACTURER BRANCH                      ',
'VR' =>'VEHICLE REPRESENTATIVE                   ',
'WD' =>'VEHICLE DISTRIBUTOR                      ',
'UL' =>'USED LOT                                 ',
'HA' =>'PILOT-FIRST CLASS                        ',
'HB' =>'PILOT-SECOND CLASS                       ',
'HC' =>'PILOT-THIRD CLASS                        ',
'HD' =>'PILOT-FOURTH CLASS                       ',
'HE' =>'PILOT-FIFTH CLASS                        ',
'HF' =>'PILOT-SIXTH CLASS                        ',
'DC' =>'CHIROPRACTOR                             ',
'DS' =>'DENTIST                                  ',
'DH' =>'DENTAL HYGIENIST                         ',
'DA' =>'ANESTHESIA PERMIT-UNRESTRICTED           ',
'DP' =>'ANESTHESIA PERMIT-RESTRICTED I           ',
'DN' =>'ANESTHESIA PERMIT-RESTRICTED II          ',
'MD' =>'MEDICAL PHYSICIAN AND SURGEON            ',
'LT' =>'INSTITUTIONAL LICENSE                    ',
'MT' =>'GRADUATE MEDICAL TRAINEE                 ',
'ML' =>'MEDICAL INTERIM LIMITED                  ',
'DT' =>'DRUGLESS THERAPIST                       ',
'MA' =>'MEDICAL PHYSICIAN ASSISTANT              ',
'AK' =>'ACUPUNCTURIST                            ',
'MW' =>'MIDWIFE                                  ',
'YM' =>'RESPIRATORY CARE PRACTITIONER            ',
'RT' =>'ATHLETIC TRAINER                         ',
'RN' =>'REGISTERED NURSE                         ',
'PN' =>'PRACTICAL NURSE                          ',
'SP' =>'CERTIFIED REGISTERED NURSE PRACTITIONER  ',
'TP' =>'CERTIFIED REGISTERED NURSE PRACTITIONER  ',
'UP' =>'CERTIFIED REGISTERED NURSE PRACTITIONER  ',
'VP' =>'CERTIFIED REGISTERED NURSE PRACTITIONER  ',
'NH' =>'NURSING HOME ADMINISTRATOR               ',
'SW' =>'SOCIAL WORKER                            ',
'CW' =>'CLINICAL SOCIAL WORKER                   ',
'MF' =>'MARRIGE AND FAMILY THERAPIST             ',
'PC' =>'PROFESSIONAL COUNSELOR                   ',
'SL' =>'SPEECH LANGUAGE PATHOLOGIST              ',
'AT' =>'AUDIOLOGIST                              ',
'TH' =>'TEACHER OF THE HEARING IMPAIRED          ',
'OE' =>'OPTOMETRIST-THERAPEUTICS                 ',
'OS' =>'OSTEOPATHIC PHYSICIAN AND SURGEON        ',
'OA' =>'OSTEOPATHIC PHYSICIAN ASSISTANT          ',
'KO' =>'OSTEOPATHIC ACUPUNCTURIST                ',
'YO' =>'OSTEOPATHIC RESPIRATORY CARE             ',
'DO' =>'OSTEOPATHIC PHYSICIAN                    ',
'OT' =>'GRADUATE OSTEOPATHIC TRAINEE             ',
'RP' =>'PHARMACIST                               ',
'PP' =>'PHARMACY-RETAIL                          ',
'HP' =>'PHARMACY-INSTITUTION                     ',
'SC' =>'DOCTOR OF PODIATRIC MEDICINE             ',
'PS' =>'PSYCHOLOGIST                             ',
'BV' =>'VETERINARIAN                             ',
'VT' =>'VETERINARY TECHNICIAN                    ','' );

Prof_License.Layout_proLic_in map2Aall( File_PA_All_Available.IDActiveA_raw l) := transform

  self.date_last_seen                := fdate;                                                          
  self.date_first_seen               := fdate;                                                         
  self.status                        := 'ACTIVE';                                                                        
  self.profession_or_board           := get_lictype(l.license_number[1..2]);                                  
  self.source_st                     := 'PA';                                                                         
  self.vendor                        := 'Commonwealth of Pennsylvania';                                                  
  self.license_type                  :=  get_lictype(l.license_number[1..2]);                                      
  self.license_number                := l.license_number;                                                        
  self.business_flag                 := 'Y';                                                                     
  self.company_name                  :='';                      
  self.orig_addr_1                   := l.addr_1;                                                                   
  self.orig_addr_2                   := l.addr_2;                                                                   
  self.orig_addr_3                   := l.addr_3;                                                                   
  self.orig_city                     := l.city;                                                                       
  self.orig_st                       := trim(l.state)[1..2];                                 
  self.orig_zip                      := if ( Stringlib.stringfilterout(l.zip, '0') <> '' , Stringlib.Stringfilter(  l.zip, '0123456789'), '');                                 
                                                                                               
  self.county_str                   := l.county;                                                                    
  self.issue_date                   := fSlashedMDYtoCYMD(l.issue_date);                                              
  self.expiration_date              := fSlashedMDYtoCYMD(l.expiration_date);                                    
  self.last_renewal_date            := '';                                                                   
  self.country_str                  := '';                                                                         
  self.license_obtained_by          := '';                                                                 
  self.phone                        := '';                                                                               
  self.dob                     := '';                                                                            
  self.orig_former_name             := '';                                                                    
  self.sex                          := '';                                                                                 
  self.orig_name                    := trim(l.name);
  self     := [];                                               
end;          

d_IDactive_A := project(   File_PA_All_Available.IDActiveA_raw,   map2Aall(left));

Prof_License.Layout_proLic_in map2Ball( File_PA_All_Available.IDActiveB_raw l) := transform


  self.date_last_seen        := fdate;                                                         
  self.date_first_seen       := fdate;                                                       
  self.status                := 'ACTIVE';                                                                      
  self.profession_or_board   :=  get_lictype(l.license_number[1..2]);                                               
  self.source_st             := 'PA';                                                                        
  self.vendor                := 'Commonwealth of Pennsylvania';                                                 
  self.license_type          := get_lictype(l.license_number[1..2]);                                                    
  self.license_number        := l.license_number;                                                      
  self.business_flag        := 'N';                                                                    
  self.name_order            := 'FML';                                                                      
  self.orig_name             := trim(l.first_name)+' ' + trim(l.middle_name)+' '+ trim(l.last_name);                                                 
  self.orig_addr_1           := l.addr_1;                                                                 
  self.orig_addr_2           := l.addr_2;                                                                 
  self.orig_addr_3           := l.addr_3;                                                                 
  self.orig_city             := l.city;                                                                     
  self.orig_st               := trim(l.state)[1..2];                               
  self.orig_zip              := if ( Stringlib.stringfilterout(l.zip, '0') <> '', Stringlib.Stringfilter(trim(l.zip), '0123456789') [1..9] , '');                                  
                                                                                          
  self.county_str            := l.county;                                                                  
  self.issue_date            := fSlashedMDYtoCYMD(l.issue_date);                                            
  self.expiration_date       := fSlashedMDYtoCYMD(l.expiration_date);                                  
  self.last_renewal_date     := '';                                                                  
  self.country_str           := '';                                                                        
  self.license_obtained_by   := '';                                                                
  self.phone                 := '';                                                                              
  self.dob              := ''; 
	self := [];
end;

d_IDactive_B := project(   File_PA_All_Available.IDActiveB_raw,   map2Ball(left));


Prof_License.Layout_proLic_in map2Ainact( File_PA_All_Available.IDInActiveA_raw l) := transform

  self.date_last_seen                := fdate;                                                          
  self.date_first_seen               := fdate;                                                         
  self.status                        := 'INACTIVE';                                                                        
  self.profession_or_board           := get_lictype(l.license_number[1..2]);                                  
  self.source_st                     := 'PA';                                                                         
  self.vendor                        := 'Commonwealth of Pennsylvania';                                                  
  self.license_type                  :=  get_lictype(l.license_number[1..2]);                                      
  self.license_number                := l.license_number;                                                        
  self.business_flag                 := 'Y';                                                                     
  self.company_name                  := trim(l.dbname)[1..100];                      
  self.orig_addr_1                   := '';                                                                   
  self.orig_addr_2                   := '';                                                                   
  self.orig_addr_3                   := '';                                                                   
  self.orig_city                     := l.city;                                                                       
  self.orig_st                       := trim(l.state)[1..2];                                 
  self.orig_zip                      := if ( Stringlib.stringfilterout(l.zip, '0') <> '' , Stringlib.Stringfilter(  l.zip, '0123456789'), '');                                 
                                                                                               
  self.county_str                   := l.county;                                                                    
  self.issue_date                   := fSlashedMDYtoCYMD(l.issue_date);                                              
  self.expiration_date              := fSlashedMDYtoCYMD(l.expiration_date);                                    
  self.last_renewal_date            := '';                                                                   
  self.country_str                  := '';                                                                         
  self.license_obtained_by          := '';                                                                 
  self.phone                        := '';                                                                               
  self.dob                     := '';                                                                            
  self.orig_former_name             := '';                                                                    
  self.sex                          := '';                                                                                 
  self.orig_name                    := trim(l.name);
  self     := [];                                               
end;          

d_IDInactive_A := project(   File_PA_All_Available.IDInActiveA_raw,   map2Ainact(left));

Prof_License.Layout_proLic_in map2Binact( File_PA_All_Available.IDInActiveB_raw l) := transform


  self.date_last_seen        := fdate;                                                         
  self.date_first_seen       := fdate;                                                       
  self.status                := 'INACTIVE';                                                                      
  self.profession_or_board   :=  get_lictype(l.license_number[1..2]);                                               
  self.source_st             := 'PA';                                                                        
  self.vendor                := 'Commonwealth of Pennsylvania';                                                 
  self.license_type          := get_lictype(l.license_number[1..2]);                                                    
  self.license_number        := l.license_number;                                                      
  self.business_flag        := 'N';                                                                    
  self.name_order            := 'FML';                                                                      
  self.orig_name             := trim(l.first_name)+' ' + trim(l.middle_name)+' '+ trim(l.last_name);                                                 
  self.orig_addr_1           := '';                                                                 
  self.orig_addr_2           := '';                                                                 
  self.orig_addr_3           := '';                                                                 
  self.orig_city             := l.city;                                                                     
  self.orig_st               := trim(l.state)[1..2];                               
  self.orig_zip              := if ( Stringlib.stringfilterout(l.zip, '0') <> '', Stringlib.Stringfilter(trim(l.zip), '0123456789') [1..9] , '');                                  
                                                                                          
  self.county_str            := l.county;                                                                  
  self.issue_date            := fSlashedMDYtoCYMD(l.issue_date);                                            
  self.expiration_date       := fSlashedMDYtoCYMD(l.expiration_date);                                  
  self.last_renewal_date     := '';                                                                  
  self.country_str           := '';                                                                        
  self.license_obtained_by   := '';                                                                
  self.phone                 := '';                                                                              
  self.dob              := ''; 
	self := [];
end;

d_IDInactive_B := project(   File_PA_All_Available.IDInActiveB_raw,   map2Binact(left));

d_IDall := (d_IDactive_A + d_IDactive_B + d_IDInactive_A + d_IDInactive_B) ( regexfind('[a-z]',county_str) = true ) ;

dout := Sequential( Output( d_IDall,,'~thor_data400::in::prolic::pa::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::pa::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::pa::all_available','~thor_data400::in::prolic::pa::all_available_'+fdate)
															 );
															 
outfile := proc_clean_all(d_IDall,'PA').cleanout;

export buildprep := Sequential(dout, 
                        FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_pa'),
                        if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_pa_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_pa_old')),
								        if ( FileServices.FileExists( '~thor_data400::in::prolic_pa_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_pa_old')),
                  			FileServices.RenameLogicalfile( '~thor_data400::in::prolic_pa','~thor_data400::in::prolic_pa_old'),                         
											  output( outfile,,'~thor_data400::in::prolic_pa',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),						
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_pa'),
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old::cmp','~thor_data400::in::prolic_pa_old'),	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		


