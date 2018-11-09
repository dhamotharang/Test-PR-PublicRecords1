import lib_StringLib,Prof_License,ut;


EXPORT Map_OK_Medical(string fdate) := module

infile := Files_OK_Medical.raw;

dateconv_bi( string10 date) := function

 return    map ( trim(date[1..2]) in [ '19','20' ] and trim(date[5]) in ['-','/'] => trim(date[1..4]) + trim(date[6..7]) + trim(date[9..10]) ,
               trim(date[(length(trim(date))-3)..(length(trim(date))-2)]) in [ '19','20' ] => ut.date_slashed_MMDDYYYY_to_YYYYMMDD(trim(date)),
							 
          if ( trim(date[8]) in ['0','1'],'20', '19') + trim(date[8..9]) +  case ( trim(date[4..6]) , 'Jan' => '01',
									                                                   'Feb' => '02',
																																	   'Mar' => '03',
																															       'Apr' => '04',
																																		 'May' => '05',
																																	   'Jun' => '06',
																																     'Jul' => '07',
																																		 'Aug' => '08',
																																		 'Sep' => '09',
																																	   'Oct' => '10',
																																		 'Nov' => '11',
																																		 'Dec' => '12','00' ) + trim(date[1..2])
																																																		
						);
	end;




Files_OK_Medical.preprec conv2date( infile l) := transform

self.process_date       := fdate;                                  
self.BIRTHDATE         :=  dateconv_bi(trim(l.BIRTHDATE));                    
self.PRACTCOUNTY       := l.PractCounty;                           
self.License_No        := l.LicenseNum;                             
self.License_Issue_Date := dateconv_bi(trim(l.IssueDate));   
self.Status_Class       := l.StatusClass;                          
self.Speciality_1       := l.SPECIALTY1;                           
self.Speciality_2       := l.SPECIALTY2;                           
self.Speciality_3       := l.SPECIALTY3;                           
self.Speciality_4       := l.SPECIALTY4;                           
self.Medical_School_Name := l.LastMedSch;                    
self.Med_Sch_Foreign_Name := '';                             
self.Med_Sch_YR_To      := '';                       
self.COUNTYNAME         := l.MailCounty;                             
self.UG_Sch_Type        := '';                                      
self.Disc_Action        :=l.DiscAct;                                      
self.Disc_Remarks       := l.Disc_Remarks;                                       
self.Speciality_5       := l.SPECIALTY5;                                     
self.ADDRLINE1          := l.ADDRLINE1;                     
self.ADDRLINE2          := l.ADDRLINE2;                     
self.ADDRLINE3          := l.ADDRLINE3;                     
self.CITY               := l.CITY;                            
self.STATECODE          := l.STATECODE;                      
self.ZIP                := l.ZIP;                              
self.ProfTYPE           := l.LicType;                              
self.STATUS             := l.STATUS;                                 
self.DATEEXPIRE         :=    dateconv_bi(trim(l.DATEEXPIRE)); 
self := l;               
end;

d_OKMed := project( infile, conv2date (left));



Prof_License.Layout_proLic_in map2ok( d_OKMed l ) := transform


  self.profession_or_board := map( trim(l.ProfTYPE) = 'POD' =>  'Podiatric' ,                                                                                                                                                                                                                       
                         trim(l.ProfTYPE) = 'LP' => 'Perfusionists' ,                                                                                                                                                                                                                       
                                                     'Medical' );                                                                                                                                                                                                                           
  self.business_flag := 'N';                                                                                                                                                                                                                                                               
  self.source_st := 'OK';                                                                                                                                                                                                                                                                   
  self.license_type := case( trim(l.ProfTYPE),
	                                         'AA' =>  'Apprentice Athletic Trainer ',     
                                          'AT' =>  'Licensed Athletic Trainer',     
                                          'MD' =>  'Medical Doctor ',     
                                          'PA' =>  'Physician Assistant',     
                                          'OT' =>  'Occupational Therapists',     
                                          'OA' =>  'Occupational Therapy Assistant ',     
                                          'RE' =>  'Registered Electrologist',     
                                          'LPED' => 'Licensed Pedorthist',     
                                          'LPO' => 'Licensed Prosthetist/Orthotist',     
                                          'LPR' => 'Licensed Prosthetist',     
                                          'LO' =>  'Licensed Orthotist',     
                                          'RPA' => 'Registered Prothetist Assistant',     
                                          'PT' =>  'Physical Therapist',     
                                          'TA' =>  'Physical Therapists Assistant',     
                                          'LD' =>  'Licensed Dietitian',     
                                          'PD' =>  'Provisionally Licensed Dietitian',     
                                          'RC' =>  'Respiratory Care Practitioner',     
                                          'PR' =>  'Provisional Respiratory Care Practitioner   ',     
                                          'RPOA' => 'Registered Prosthetist/Orthotist Assistant  ',     
                                          'RTO' => 'Registered Techician - Orthotic',     
                                          'RTP' => 'Registered Technician - Prosthetic          ',     
                                          'RTPO' => 'Registered Technician - Prosthetic/Orthotic ',     
                                          'POD' => 'Podiatrist',     
                                          'LP' =>  'Licensed Perfusionist',    '' ); 

                                                                                                                                                                                                                          
  self.orig_name := trim(trim(l.FIRSTNAME)+' '+ trim(l.MIDDLENAME)+ ' ' + trim(l.LASTNAME) + ' ' + trim(l.SUFFIXNAME));                                                                                                                                                                     
  self.company_name := ' ';                                                                                                                                                                                                                                                            
  self.orig_addr_1 := l.ADDRLINE1;                                                                                                                                                                                                                                                          
  self.orig_addr_2 := l.ADDRLINE2;                                                                                                                                                                                                                                                          
  self.orig_city := trim(l.CITY) +  ' ' + trim(l.STATEPROV);                                                                                                                                                                                                                                
  self.orig_st := l.STATECODE[1..2];                                                                                                                                                                                                                                                        
  self.orig_zip := StringLib.stringfilter(l.ZIP,'0123456789')[1..9];                                                                                                                                                                                                                        
  self.sex := trim(l.SEX);                                                                                                                                                                                                                                                                  
  self.county_str := regexreplace('NOT OKLAHOMA',l.COUNTYNAME, '')[1..25];                                                                                                                                                                                                                  
  self.country_str := l.COUNTRY;                                                                                                                                                                                                                                                            
  self.expiration_date := l.DATEEXPIRE;                                                                                                                                                                                                                                   
  self.issue_date := l.License_Issue_Date;                                                                                                                                                                                                                                
  self.last_renewal_date := ' ';                                                                                                                                                                                                                                                            
  self.name_order := 'FML';                                                                                                                                                                                                                                                                 
  self.vendor := map (trim(l.ProfTYPE) = 'POD'  =>  'Oklahoma Podiatric Medical Examiners'         ,                                                                                                                                                                                        
                      trim(l.ProfTYPE) = 'LP'  =>  'Oklahoma Licenses Perfusionists Examiners'    ,                                                                                                                                                                                        
                        'Oklahoma Medical Licensure' );                                                                                                                                                                                                                                     
  self.status := map ( l.Status_Class <> '' => l.Status_Class ,                                                                                                                                                                                                                             
                       Stringlib.StringToUpperCase(trim(l.STATUS)) = 'A' =>  'ACTIVE' ,                                                                                                                                                                                                         
                        Stringlib.StringToUpperCase(trim(l.STATUS)) = 'I' => 'INACTIVE' , '' );                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                                            
  self.phone := StringLib.stringfilter(l.Practice_Phone,'0123456789')[1..10];                                                                                                                                                                                                               
  self.dob := l.BIRTHDATE;                                                                                                                                                                                                                                           
  self.orig_former_name := ' ';                                                                                                                                                                                                                                                             
  self.orig_addr_3 := l.ADDRLINE3;                                                                                                                                                                                                                                                          
  self.date_first_seen := l.process_date;                                                                                                                                                                                                                                                   
  self.date_last_seen := l.process_date;                                                                                                                                                                                                                                                    
  self.additional_orig_additional_1 := l.PRACTADDR1;                                                                                                                                                                                                                                        
  self.additional_orig_additional_2 := l.PRACTADDR2;                                                                                                                                                                                                                                        
  self.additional_orig_additional_3 := l.PRACTADDR3;                                                                                                                                                                                                                                        
  self.additional_orig_city := trim(l.PRACTCITY)+ ' ' +  trim(l.PRACTPROV);                                                                                                                                                                                                                 
  self.additional_orig_st := l.PRACTSTATE[1..2];                                                                                                                                                                                                                                            
  self.additional_orig_zip := Stringlib.stringfilter(l.PRACTZIP,'0123456789')[1..9];                                                                                                                                                                                                        
  self.additional_licensing_specifics :=  trim(regexreplace( '\\*'    ,                                                                                                                                                                                                                       
                                                  regexreplace( ', \\*'    ,                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                            
                                                    if ( l.PRACTCOUNTRY <> '' , 'Practice Country: ' + trim(l.PRACTCOUNTRY) +  ', ' , '') +                                                                                                                                                   
                                                    if ( l.PRACTCOUNTY <> '', 'Practice County: ' + trim(l.PRACTCOUNTY)  , '' ) + '*',                                                                                                                                                
                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                            
                                                          ''),                                                                                                                                                                                                                        
                                                      ''))[1..75];                                                                                                                                                                                                                          
  self.status_status_cds := trim(l.STATUS)[1..10];                                                                                                                                                                                                                                          
  self.misc_practice_type := trim(regexreplace( '\\*'     ,                                                                                                                                                                                                                                   
                                    regexreplace( ', \\*',                                                                                                                                                                                                                                    
                                                 if ( l.Board_Certification1 <> '',  trim(l.Board_Certification1) + ', ' , '') +                                                                                                                                                            
                                                  if ( l.Board_Certification2 <> '',  trim(l.Board_Certification2) + ', ' , '') +                                                                                                                                                           
                                                 if ( l.Board_Certification3 <> '',  trim(l.Board_Certification3)  , '') + '*'                                                                                                                                                     
                                                , ''),                                                                                                                                                                                                                                      
                                        ''))  [1..50];                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                                                                            
  self.misc_occupation :=                                                                                                                                                                                                                                                                   
                           trim(regexreplace( '\\*'     ,                                                                                                                                                                                                                                     
                                   regexreplace( ', \\*',                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                            
                                       if (l.Speciality_1 <> '' , trim(l.Speciality_1) + ', ' , '' ) +                                                                                                                                                                                      
                                       if(l.Speciality_2 <> '',   trim(l.Speciality_2) +  ', ' , '' )+                                                                                                                                                                                      
                                        if(l.Speciality_3 <> '', trim(l.Speciality_3) +  ', ',  '' )+                                                                                                                                                                                      
                                       if(l.Speciality_4 <> '', trim(l.Speciality_4),'') + '*' ,                                                                                                                                                                                                 
                                       '') ,                                                                                                                                                                                                                                               
                                 '')) [1..50];                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                            
  self.board_action_indicator := if (l.Disc_Action <> '', 'Y' , '' ) ;                                                                                                                                                                                                                      
  self.action_desc := l.Disc_Action;                                                                                                                                                                                                                                                        
  self.education_continuing_education := l.UG_Sch_Type;                                                                                                                                                                                                                                     
  self.license_number := l.License_No;
	self := [];
end;                                                                                                                                                                                                                                                                                        
                                                             
dWithMed:= project( d_OKMed, map2ok(left));


outfile := proc_clean_all(dWithMed,'OK').cleanout;

dOKMedicalSF := Sequential(  
                        FileServices.ClearSuperfile( '~thor_data400::in::prolic::ok::medical'),

                        output(dWithMed,,'~thor_data400::in::prolic::ok::medical_'+fdate,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::ok::medical'),FileServices.CreateSuperfile('~thor_data400::in::prolic::ok::medical')),

												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::ok::medical','~thor_data400::in::prolic::ok::medical_'+fdate),
											   FileServices.FinishSuperfiletransaction()
											 );

export buildprep := Sequential( dOKMedicalSF,
                  FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ok'),
                        if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ok_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ok_old')),
								        if ( FileServices.FileExists( '~thor_data400::in::prolic_ok_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_ok_old')),
                        FileServices.RenameLogicalfile( '~thor_data400::in::prolic_ok','~thor_data400::in::prolic_ok_old'),   
                         
											output( outfile,,'~thor_data400::in::prolic_ok',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
							
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ok'),
	FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ok_old'),
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		