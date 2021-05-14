import ut;
EXPORT Map_CO(dataset({string ftype,string fdate})infile) := module

import Prof_License,Lib_StringLib;

//convert files with missing lic type to common layout 

concatin := File_CO.med ;
						 
//concatout := project(		concatin ,transform(	File_CO.common_lt, self := left,self := [] )) + File_CO.med2 (regexfind('[A-Z]',zipcode) = false);		 

Prof_License.Layout_proLic_in map2med( concatin l ) := transform

    self.date_first_seen         := infile(ftype = 'medical')[1].fdate;                                                              
    self.date_last_seen          := infile(ftype = 'medical')[1].fdate;                                                         
    self.profession_or_board     := 'Medical';                                                                   
    self.license_type            := case ( StringLib.StringToUpperCase(trim(l.LicenseType)), 
                                                              'AV' => 'Academic Veterinarian' ,
                                                                                                          
                                   'ACU' => 'Acupuncturist' ,                             
                                                                                                
                                   'ARC' => 'Architect' ,                                 
                                                                                                  
                                   'AUD' => 'Audiologist' ,                               
                                                                                            
                                   'BAR' => 'Barber' ,                                             
                                                                                          
                                   'BOX' => 'Boxing' ,                                   
                                                                                          
                                   'CST' => 'Boxing Contestant' ,                         
                                                                                          
                                   'OFC' => 'Boxing Official' ,                            
                                                                                          
                                   'PRO' =>  'Boxing Promoter' ,                         
                                                                                           
                                   'SEC' =>  'Boxing Second' ,                            
                                                                                          
                                   'ACA' => 'Certified Addiction Counselor I' ,           
                                                                                          
                                   'ACB' => 'Certified Addiction Counselor II' ,         
                                                                                          
                                   'ACC' => 'Certified Addiction Counselor III' ,         
                                                                                          
                                   'NA' =>  'Certified Nurse Aide' ,                      
                                                                                          
                                   'CPA' => 'Certified Public Accountant' ,               
                                                                                          
                                   'CHR' =>  'Chiropractic' ,                             
                                                                                          
                                   'CFY' => 'Clinical Fellow in Audiology' ,              
                                                                                          
                                   'COS' =>  'Cosmetologist' ,                            
                                                                                          
                                   'DH' => 'Dental Hygienist' ,                           
                                                                                          
                                   'DEN' => 'Dentist' ,                                   
                                                                                          
                                   'MWR' => 'Direct Entry Midwife' ,                     
                                                                                          
                                   'DRU' => 'Drug Company' ,                              
                                                                                          
                                   'APE' => 'Electrical Apprentice' ,                     
                                                                                          
                                   'EC' => 'Electrical Contractor' ,                      
                                                                                          
                                   'EI' => 'Engineer Intern' ,                            
                                                                                          
                                   'COZ' => 'Esthetician' ,                               
                                                                                          
                                   'TDP' => 'Foreign TeachingPhysician' ,                 
                                                                                          
                                   'HST' => 'Hair Stylist' ,                              
                                                                                          
                                   'HAA' => 'Hearing Aid Associate' ,                     
                                                                                          
                                   'HAD' => 'Hearing Aid Provider' ,                      
                                                                                          
                                   'HAT' => 'Hearing Aid Provider - Trainee' ,            
                                                                                          
                                   'JW' => 'Journeyman Electrician' ,                     
                                                                                          
                                   'JP' =>   'Journeyman Plumber' ,                       
                                                                                          
                                   'LSI' =>  'Land Surveyor Intern' ,                     
                                                                                          
                                   'ACD' => 'Licensed Addiction Counselor' ,              
                                                                                        
                                   'CSW' => 'Licensed Clinical Social Worker' ,           
                                                                                        
                                   'ISW' => 'Licensed Independent Social Worker' ,        
                                                                                        
                                   'PN' => 'Licensed Practical Nurse' ,                   
                                                                                        
                                   'LPC' => 'Licensed Professional Counselor' ,           
                                                                                          
                                   'PSY' => 'Licensed Psychologist' ,                     
                                                                                          
                                   'LSW' => 'Licensed Social Worker' ,                    
                                                                                          
                                   'LTD' => 'Limited License' ,                           
                                                                                          
                                   'MAN' => 'Manicurist' ,                                
                                                                                          
                                   'MFR' => 'Manufacturer' ,                              
                                                                                          
                                   'MFT' => 'Marriage and Family Therapist' ,             
                                                                                          
                                   'ME' => 'Master Electrician' ,                         
                                                                                          
                                   'MP' =>  'Master Plumber' ,                            
                                                                                          
                                   'AIT' => 'NHA - In Training' ,                         
                                                                                          
                                   'NHA' => 'Nursing Home Administrator' ,                
                                                                                          
                                   'OPT' =>  'Optometrist' ,                              
                                                                                        
                                   'OO' => 'Other Outlet' ,                               
                                                                                          
                                   'OUT' => 'Outfitter' ,                                 
                                                                                          
                                   'PHA' => 'Pharmacist' ,                            
                                                                                          
                                   'IN' => 'Pharmacist Intern',                         
                                                                                          
                                   'PTL' => 'Physical Therapist' ,                        
                                                                                          
                                   'DR' =>  'Physician' ,                                 
                                                                                          
                                   'PA' =>  'Physician Assistant' ,                       
                                                                                          
                                   'PAL' => 'Physician Assistant - Pending Supervisor' ,  
                                                                                        
                                   'TL' => 'Physician Training License' ,                 
                                                                                        
                                   'AP' => 'Plumbing Apprentice' ,                        
                                                                                          
                                   'POD' => 'Podiatrist' ,         
                                                                                          
                                   'PDO' => 'Prescription Drug Outlet- In-State' ,      
                                                                                          
                                   'OSP' => 'Prescription Drug Outlet-Out-of-State' ,     
                                                                                          
                                   'PE' =>  'Professional Engineer' ,                
                                                                                          
                                   'PLS' => 'Professional Land  Surveyor' ,               
                                                                                          
                                   'LPP' => 'Provisional LPC' ,                          
                                                                                          
                                   'MFP' =>  'Provisional MFT' ,                          
                                                                                          
                                   'PSP' => 'Provisional PSY' ,                           
                                                                                          
                                   'SWP' => 'Provisional SW' ,                            
                                                                                          
                                   'DD' =>  'Psy Tech-Developmentally Disabled' ,         
                                                                                          
                                   'MI' => 'Psy Tech-Mentally Ill' ,                     
                                                                                          
                                   'FRM' => 'Public Accounting Firm' ,                    
                                                                                        
                                   'RN' => 'Registered Nurse' ,                           
                                                                                          
                                   'RSW' => 'Registered Social Worker' ,                  
                                                                                        
                                   'RP' => 'Residential Plumber' ,                        
                                                                                          
                                   'RW' => 'Residential Wireman' ,                      
                                                                                          
                                   'RTL' => 'Respiratory Therapist' ,                     
                                                                                          
                                   'REG' => 'Shop Registration' ,                         
                                                                                          
                                   'SHP' => 'Shriners Hospital Physician' ,               
                                                                                          
                                   'SPN' => 'Special Student Permit - LPN' ,              
                                                                                          
                                   'SRN' => 'Special Student Permit - RN' ,               
                                                                                          
                                   'TPA' => 'Temporary CPA Permit' ,                      
                                                                                          
                                   'TDH' => 'Temporary Dental Hygienist' ,                
                                                                                          
                                   'TDL' => 'Temporary Dentist'         ,                 
                                                                                          
                                   'TOC' => 'Temporary Olympic License - Chiropractic'  , 
                                                                                          
                                   'TOM' => 'Temporary Olympic License - Medical' ,       
                                                                                          
                                   'TRA' => 'Tramway Area' ,                              
                                                                                          
                                   'TRM' => 'Tramway Lift' ,                              
                                                                                          
                                   'NLC' => 'Unlicensed Psychotherapist' ,                
                                                                                          
                                   'VET' => 'Veterinarian' ,                              
                                                                                          
                                   'WHI' => 'Wholesaler In-State' ,                       
                                                                                          
                                   'WHO' => 'Wholesaler Out-of-State' , '');   

    self.license_number       :=  regexreplace('=|"',l.LicenseNumber,'');                                                              
    self.status               := l.Status;                                                                       
    self.company_name    := trim(l.Entity_Name);                                        
    self.orig_name            := trim(l.FirstName + ' ' + l.MiddleName + ' ' + l.LastName + ' ' + l.Suffix);              
    self.name_order           := if ( l.Entity_Name <> '' , 'FML' ,'' );                                       
    self.orig_addr_1          := l.Address;                                                           
    self.orig_addr_2          := l.Address_2;                                                           
    self.orig_city            := l.City;                                                                      
    self.orig_st              := trim(l.StateCode)[1..2];                                  
    self.orig_zip             := StringLib.Stringfilter(l.ZipCode,'0123456789')[1..9];                      
    self.phone                :=  '';//StringLib.Stringfilter(l.Phone,'0123456789')[1..10];                  
    self.issue_date           := Prof_License_preprocess.dateconv(trim(l.FirstIssueDate));                                        
    self.expiration_date      := Prof_License_preprocess.dateconv(trim(l.ExpirationDate));                                      
    self.last_renewal_date    := Prof_License_preprocess.dateconv(trim(l.LastRenewalDate));                                         
    self.education_1_degree   := trim(l.Degree)[1..15];                    
    self.education_2_degree    := '';//l.Degree1;                                                          
    self.education_3_degree   := '';//l.Degree2;                                                          
    self.license_obtained_by  := '';//if ( l.License_Method <> '' , l.License_Method , '' ) ;                              
    self.additional_licensing_specifics := regexreplace(     ', *',                    
                                                      regexreplace( 'Specialties: *' ,                                                                                
                                                                                    
                                                                  'Specialties: ' +                                                                                  
                                                                    if ( l.Speciality <> '', trim(l.Speciality)  , '' )  +       
                                                                     '*'                                                                                              
                                                                                                                                                                         
                                                                  ,  '')                                                                          
                                                         ,  '')  [1..75];                                                                                   
                                                                                          
    self.vendor                := 'Colorado Board of Medical Examiners';                                           
    self.source_st             := 'CO';                                                                         
    self.action_case_number    := trim(l.CaseNumber);                                           
    self.action_desc           := trim(l.ProgramAction);                                             
    self.action_effective_dt   := trim(l.DisciplineEffectiveDate);                                         
    self.action_posting_status_dt := trim(l.DisciplineCompletedDate);                                                                                                                                                                                                                                                                     
self := l;
self := [];

end;

dOutMed := project( concatin, map2med(left));

dOutMedSF := Sequential( FileServices.ClearSuperfile( '~thor_data400::in::prolic::co::medical'),
                         output( dOutMed (profession_or_board <> ''),,'~thor_data400::in::prolic::co::medical_'+infile(ftype = 'medical')[1].fdate	,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::co::medical'),FileServices.CreateSuperfile('~thor_data400::in::prolic::co::medical')),

												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::co::medical','~thor_data400::in::prolic::co::medical_'+infile(ftype = 'medical')[1].fdate),
	
											   FileServices.FinishSuperfiletransaction()
											 );





Prof_License.Layout_proLic_in map2all( File_CO.available l ) := transform

  self.date_first_seen := infile(ftype = 'available')[1].fdate;
  self.date_last_seen := infile(ftype = 'available')[1].fdate;
  self.profession_or_board := case( StringLib.StringToUpperCase(trim(l.License_Type)) ,
  'AV' => 'Academic Veterinarian' ,

'ACU' => 'Acupuncturist' ,

'ARC' => 'Architect' ,
                    
'AUD' => 'Audiologist' ,
               
'BAR' => 'Barber' ,
               
'BOX' => 'Boxing' ,
                 
'CST' => 'Boxing Contestant' ,
                    
'OFC' => 'Boxing Official' ,
                    
'PRO' =>  'Boxing Promoter' ,
                   
'SEC' =>  'Boxing Second' ,
                   
'ACA' => 'Certified Addiction Counselor I' ,
                     
'ACB' => 'Certified Addiction Counselor II' ,
                     
'ACC' => 'Certified Addiction Counselor III' ,
                    
'NA' =>  'Certified Nurse Aide' ,
                    
'CPA' => 'Certified Public Accountant' ,
                   
'CHR' =>  'Chiropractic' ,
                   
'CFY' => 'Clinical Fellow in Audiology' ,
                     
'COS' =>  'Cosmetologist' ,
                   
'DH' => 'Dental Hygienist' ,
                    
'DEN' => 'Dentist' ,
                    
'MWR' => 'Direct Entry Midwife' ,
                   
'DRU' => 'Drug Company' ,
                     
'APE' => 'Electrical Apprentice' ,
                   
'EC' => 'Electrical Contractor' ,
                    
'EI' => 'Engineer Intern' ,
                     
'COZ' => 'Esthetician' ,
                  
'TDP' => 'Foreign TeachingPhysician' ,
                    
'HST' => 'Hair Stylist' ,
                    
'HAA' => 'Hearing Aid Associate' ,
                    
'HAD' => 'Hearing Aid Provider' ,
                    
'HAT' => 'Hearing Aid Provider - Trainee' ,
                    
'JW' => 'Journeyman Electrician' ,
                   
'JP' =>   'Journeyman Plumber' ,
                  
'LSI' =>  'Land Surveyor Intern' ,
                 
'ACD' => 'Licensed Addiction Counselor' , 

'CSW' => 'Licensed Clinical Social Worker' ,

'ISW' => 'Licensed Independent Social Worker' ,

'PN' => 'Licensed Practical Nurse' ,

'LPC' => 'Licensed Professional Counselor' ,
                    
'PSY' => 'Licensed Psychologist' ,
                     
'LSW' => 'Licensed Social Worker' ,
                     
'LTD' => 'Limited License' ,
                     
'MAN' => 'Manicurist' ,
                     
'MFR' => 'Manufacturer' ,
                    
'MFT' => 'Marriage and Family Therapist' ,
                     
'ME' => 'Master Electrician' ,
                     
'MP' =>  'Master Plumber' ,
                     
'AIT' => 'NHA - In Training' ,

'NHA' => 'Nursing Home Administrator' ,
                    
'OPT' =>  'Optometrist' , 

'OO' => 'Other Outlet' ,
                     
'OUT' => 'Outfitter' ,
                     
'PHA' => 'Pharmacist' ,
                     
'IN' => 'Pharmacist Intern' ,
                     
'PTL' => 'Physical Therapist' ,
                     
'DR' =>  'Physician' ,
                     
'PA' =>  'Physician Assistant' ,
                     
'PAL' => 'Physician Assistant - Pending Supervisor' , 

'TL' => 'Physician Training License' ,

'AP' => 'Plumbing Apprentice' ,
                     
'POD' => 'Podiatrist' ,
                     
'PDO' => 'Prescription Drug Outlet- In-State' ,
                     
'OSP' => 'Prescription Drug Outlet-Out-of-State' ,
                     
'PE' =>  'Professional Engineer' ,
                     
'PLS' => 'Professional Land  Surveyor' ,
                     
'LPP' => 'Provisional LPC' ,
                     
'MFP' =>  'Provisional MFT' ,
                    
'PSP' => 'Provisional PSY' ,
                     
'SWP' => 'Provisional SW' ,
                    
'DD' =>  'Psy Tech-Developmentally Disabled' ,
                    
'MI' => 'Psy Tech-Mentally Ill' ,
                    
'FRM' => 'Public Accounting Firm' ,

'RN' => 'Registered Nurse' ,
                    
'RSW' => 'Registered Social Worker' ,

'RP' => 'Residential Plumber' ,
                     
'RW' => 'Residential Wireman' ,
                     
'RTL' => 'Respiratory Therapist' ,
                     
'REG' => 'Shop Registration' ,
                    
'SHP' => 'Shriners Hospital Physician' ,
                     
'SPN' => 'Special Student Permit - LPN' ,
                    
'SRN' => 'Special Student Permit - RN' ,
                     
'TPA' => 'Temporary CPA Permit' ,
                     
'TDH' => 'Temporary Dental Hygienist' ,
                     
'TDL' => 'Temporary Dentist' ,
                   
'TOC' => 'Temporary Olympic License - Chiropractic' ,
                      
'TOM' => 'Temporary Olympic License - Medical' ,
                     
'TRA' => 'Tramway Area' ,
                     
'TRM' => 'Tramway Lift' ,
                    
'NLC' => 'Unlicensed Psychotherapist' ,
                    
'VET' => 'Veterinarian' ,
                    
'WHI' => 'Wholesaler In-State' ,
                     
'WHO' => 'Wholesaler Out-of-State' , '');

  self.license_type := case( StringLib.StringToUpperCase(trim(l.License_Type)) ,
  'AV' => 'Academic Veterinarian' ,

'ACU' => 'Acupuncturist' ,

'ARC' => 'Architect' ,
                    
'AUD' => 'Audiologist' ,
               
'BAR' => 'Barber' ,
               
'BOX' => 'Boxing' ,
                 
'CST' => 'Boxing Contestant' ,
                    
'OFC' => 'Boxing Official' ,
                    
'PRO' =>  'Boxing Promoter' ,
                   
'SEC' =>  'Boxing Second' ,
                   
'ACA' => 'Certified Addiction Counselor I' ,
                     
'ACB' => 'Certified Addiction Counselor II' ,
                     
'ACC' => 'Certified Addiction Counselor III' ,
                    
'NA' =>  'Certified Nurse Aide' ,
                    
'CPA' => 'Certified Public Accountant' ,
                   
'CHR' =>  'Chiropractic' ,
                   
'CFY' => 'Clinical Fellow in Audiology' ,
                     
'COS' =>  'Cosmetologist' ,
                   
'DH' => 'Dental Hygienist' ,
                    
'DEN' => 'Dentist' ,
                    
'MWR' => 'Direct Entry Midwife' ,
                   
'DRU' => 'Drug Company' ,
                     
'APE' => 'Electrical Apprentice' ,
                   
'EC' => 'Electrical Contractor' ,
                    
'EI' => 'Engineer Intern' ,
                     
'COZ' => 'Esthetician' ,
                  
'TDP' => 'Foreign TeachingPhysician' ,
                    
'HST' => 'Hair Stylist' ,
                    
'HAA' => 'Hearing Aid Associate' ,
                    
'HAD' => 'Hearing Aid Provider' ,
                    
'HAT' => 'Hearing Aid Provider - Trainee' ,
                    
'JW' => 'Journeyman Electrician' ,
                   
'JP' =>   'Journeyman Plumber' ,
                  
'LSI' =>  'Land Surveyor Intern' ,
                 
'ACD' => 'Licensed Addiction Counselor' , 

'CSW' => 'Licensed Clinical Social Worker' ,

'ISW' => 'Licensed Independent Social Worker' ,

'PN' => 'Licensed Practical Nurse' ,

'LPC' => 'Licensed Professional Counselor' ,
                    
'PSY' => 'Licensed Psychologist' ,
                     
'LSW' => 'Licensed Social Worker' ,
                     
'LTD' => 'Limited License' ,
                     
'MAN' => 'Manicurist' ,
                     
'MFR' => 'Manufacturer' ,
                    
'MFT' => 'Marriage and Family Therapist' ,
                     
'ME' => 'Master Electrician' ,
                     
'MP' =>  'Master Plumber' ,
                     
'AIT' => 'NHA - In Training' ,

'NHA' => 'Nursing Home Administrator' ,
                    
'OPT' =>  'Optometrist' , 

'OO' => 'Other Outlet' ,
                     
'OUT' => 'Outfitter' ,
                     
'PHA' => 'Pharmacist' ,
                     
'IN' => 'Pharmacist Intern' ,
                     
'PTL' => 'Physical Therapist' ,
                     
'DR' =>  'Physician' ,
                     
'PA' =>  'Physician Assistant' ,
                     
'PAL' => 'Physician Assistant - Pending Supervisor' , 

'TL' => 'Physician Training License' ,

'AP' => 'Plumbing Apprentice' ,
                     
'POD' => 'Podiatrist' ,
                     
'PDO' => 'Prescription Drug Outlet- In-State' ,
                     
'OSP' => 'Prescription Drug Outlet-Out-of-State' ,
                     
'PE' =>  'Professional Engineer' ,
                     
'PLS' => 'Professional Land  Surveyor' ,
                     
'LPP' => 'Provisional LPC' ,
                     
'MFP' =>  'Provisional MFT' ,
                    
'PSP' => 'Provisional PSY' ,
                     
'SWP' => 'Provisional SW' ,
                    
'DD' =>  'Psy Tech-Developmentally Disabled' ,
                    
'MI' => 'Psy Tech-Mentally Ill' ,
                    
'FRM' => 'Public Accounting Firm' ,

'RN' => 'Registered Nurse' ,
                    
'RSW' => 'Registered Social Worker' ,

'RP' => 'Residential Plumber' ,
                     
'RW' => 'Residential Wireman' ,
                     
'RTL' => 'Respiratory Therapist' ,
                     
'REG' => 'Shop Registration' ,
                    
'SHP' => 'Shriners Hospital Physician' ,
                     
'SPN' => 'Special Student Permit - LPN' ,
                    
'SRN' => 'Special Student Permit - RN' ,
                     
'TPA' => 'Temporary CPA Permit' ,
                     
'TDH' => 'Temporary Dental Hygienist' ,
                     
'TDL' => 'Temporary Dentist' ,
                   
'TOC' => 'Temporary Olympic License - Chiropractic' ,
                      
'TOM' => 'Temporary Olympic License - Medical' ,
                     
'TRA' => 'Tramway Area' ,
                     
'TRM' => 'Tramway Lift' ,
                    
'NLC' => 'Unlicensed Psychotherapist' ,
                    
'VET' => 'Veterinarian' ,
                    
'WHI' => 'Wholesaler In-State' ,
                     
'WHO' => 'Wholesaler Out-of-State' , '');
  self.license_number := regexreplace('=|"',l.License_Number,'');           
  self.status := l.License_Status_Description;
  self.company_name := trim(l.Entity_Name);
  self.orig_name := trim(l.Formatted_Name);
  self.name_order := if (l.Entity_Name <> '','FML','');
  self.orig_addr_1 := l.Address_Line_1;
  self.orig_addr_2 := l.Address_Line_2;
  self.orig_city := l.City;
  self.orig_st := trim(l.State)[1..2];
  self.orig_zip := StringLib.stringfilter(l.Mail_Zip_Code,'0123456789')[1..9];
  self.issue_date := Prof_License_preprocess.dateconv(trim(l.License_First_Issue_Date));
  self.expiration_date := Prof_License_preprocess.dateconv(trim(l.License_Expiration_Date));
  self.last_renewal_date := Prof_License_preprocess.dateconv(trim(l.License_Last_Renewed_Date));
  self.education_1_degree := trim(l.Degree)[1..15];
  self.additional_licensing_specifics := l.Specialty;
  self.vendor := 'State of Colorado Division of Licensing';
  self.source_st := 'CO';
  self.action_case_number := trim(l.Case_Number);
  self.action_desc := trim(l.Program_Action);
  self.action_effective_dt := if (trim(l.Discipline_Effective_Date) <> '', fSlashedMDYtoCYMD(trim(l.Discipline_Effective_Date)),'') ;
  self.action_posting_status_dt := if (trim(l.Discipline_Complete_Date) <> '', fSlashedMDYtoCYMD(trim(l.Discipline_Complete_Date)),'');
  self.county_str := l.County;
  self.misc_occupation := l.Title;
self := l;
self := [];

end;

dOutall := project( File_CO.available, map2all(left))(profession_or_board <> '');

dOutAllSF := Sequential( FileServices.ClearSuperfile( '~thor_data400::in::prolic::co::all_available'),
                         output( dOutall ,,'~thor_data400::in::prolic::co::all_available_'+infile(ftype = 'available')[1].fdate	,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::co::all_available'),FileServices.CreateSuperfile('~thor_data400::in::prolic::co::all_available')),

												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::co::all_available','~thor_data400::in::prolic::co::all_available_'+infile(ftype = 'available')[1].fdate),
	
											   FileServices.FinishSuperfiletransaction()
											 );

doutfinal := map ( count(infile(ftype = 'available')) = 1 and count(infile) = 1 => dOutall, 
               count(infile(ftype = 'medical')) = 1 and count(infile) = 1  => dOutMed,
								  dOutall + dOutMed );

 
 
dout :=  map ( count(infile(ftype = 'available')) = 1 and count(infile) = 1 => dOutAllSF,
												                                                        
								        	count(infile(ftype = 'medical')) = 1	and count(infile) = 1 =>	   dOutMedSF,
													Sequential( dOutAllSF,dOutMedSF)
							);
 

outfile := proc_clean_all(doutfinal,'CO').cleanout;

superfile_trans := Sequential(
                           FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_co'),
												       if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_co_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_co_old')),
								               if ( FileServices.FileExists( '~thor_data400::in::prolic_co_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_co_old')),
                               FileServices.RenameLogicalfile( '~thor_data400::in::prolic_co','~thor_data400::in::prolic_co_old'),
											);


export buildprep := Sequential( dout,
                             superfile_trans,
			          								output( outfile,,'~thor_data400::in::prolic_co',compressed,overwrite),
                                FileServices.StartSuperfiletransaction(),  
												        FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_co'),
																				 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_co_old'),

											          FileServices.FinishSuperfiletransaction()
											      );

end;                                                                                                                             
		
		
