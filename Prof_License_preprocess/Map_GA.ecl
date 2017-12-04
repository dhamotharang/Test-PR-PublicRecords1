EXPORT Map_GA(dataset({string ftype,string fdate})infile) := module

import Prof_License,ut;


Prof_License.Layout_proLic_in map2final( Files_GA_raw.file_aa l) := transform
  self.profession_or_board          := l.LicenseType;
  self.source_st                    := 'GA';                                                                                  
  self.license_type                 := l.LicenseType;                                                                      
  self.orig_addr_1                  := if ( trim(l.addr_line_1) = '0' , '' , trim(l.addr_line_1)[1..80]);                  
  self.orig_addr_2                  := if ( trim(l.addr_line_2) = '0' , '' , trim(l.addr_line_2));                         
  self.orig_addr_3                  := if ( trim(l.addr_line_3) = '0' , '' , trim(l.addr_line_3));                         
  self.orig_city                    := l.addr_city;                                                                           
  self.orig_st                      := l.addr_state[1..2];                                                                      
  self.orig_zip                     := StringLib.Stringfilter(l.addr_zipcode,'0123456789')[1..9];                           
  self.sex                          := ' ';                                                                                         
  self.license_obtained_by          := ' ';                                                                         
  self.county_str                   := l.addr_county;                                                                        
  self.country_str                  := ' ';                                                                                 
  self.issue_date                   := fSlashedMDYtoCYMD(l.issue_date);                                                       
  self.last_renewal_date            := ' ';                                                                           
  self.name_order                   := 'LFM';                                                                                
  self.vendor                       := 'Georgia Secretary of State';                                                             
  self.orig_former_name             := ' ';                                                                            
  self.status                       := l.status;                                                                                 
  self.license_number               := l.License_No;                                                                     
  self.phone                        := ' ';                                                                                       
  self.expiration_date              := fSlashedMDYtoCYMD(l.expiration_date);                                             
  self.date_first_seen              := infile(ftype = 'available')[1].fdate;                                                                      
  self.date_last_seen               := infile(ftype = 'available')[1].fdate;                                                                       
  self.orig_name                    := trim(l.sort_name)[1..80];  
	self := [];
end;

 allavailable := project( Files_GA_raw.file_aa , map2final(left)) ( profession_or_board <> ''  and  regexfind(' GA | APO AE | CA | FL | MD | MS | OR | SC | TX | WA ',profession_or_board ) = FALSE ) ;

dGAAllout := Sequential( FileServices.ClearSuperfile( '~thor_data400::in::prolic::ga::available'),
                        output(allavailable,,'~thor_data400::in::prolic::ga::available_'+infile(ftype = 'available')[1].fdate,overwrite);
                         FileServices.StartSuperfiletransaction(),
												 if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::ga::available'),FileServices.CreateSuperfile('~thor_data400::in::prolic::ga::available')),											 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::ga::available','~thor_data400::in::prolic::ga::available_'+infile(ftype = 'available')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );


dmedtrim := Files_GA_raw.file_med_raw ( License <> 'License.');

medical_ex_out := 
record                                  
  string8 filedate;                 
  string4 Client;                       
  string40 Name;                        
  string8 License;                      
  string18 Expiration_Date;             
  string53 Main_Address1;               
  string56 Main_Address2;               
  string17 City;                        
  string5 State;                        
  string11 Zipcode;                     
  string6 Status_code;                  
  string18 Date_of_First_License;       
  string11 Title;                       
  string9 License_Specialty;            
  string10 Public_Board_Order;          
  string14 Date_of_Public_Board_Order;  
  string2 lf;                           
                                        
end;                                    

medical_ex_out map2medical( dmedtrim l) := transform
  string11 clean_zip           := if ( l.ZIP <> '', map ( StringLib.StringFind(trim(l.ZIP),'^0-0$|^02\\//201976$',1) > 0 =>   regexreplace('^0-0$|^02\\//201976$',trim(l.ZIP),' '),                                                                                                                                                                                                                                                                                                                          
                                                          StringLib.StringFind(trim(l.ZIP),'^[0-9]+-0$',1) > 0  =>  regexreplace('^[0-9]+-0$',trim(l.ZIP),StringLib.StringFilter(trim(l.ZIP),'([0-9]+)')),                                                                                                                                                                                                                                                                                                
                                                           trim(l.ZIP) = 'N/A' =>  '',                                                                                                                                                                                                                                                                                                                                            
																								          l.ZIP),
																                       '');                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                        
  self.Main_Address1           := map ( regexfind('^UNK$|^PENDING$',StringLib.StringToUpperCase(trim(l.Address_1)),0) <> ''  =>  regexreplace('^UNK$|^PENDING$',StringLib.StringToUpperCase(trim(l.Address_1)),''),                                                                                                                                                                                                                                                                                        
                                        StringLib.Stringfilterout(l.Address_1,' 0') = '' =>  ''  ,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                                        regexreplace('\'',l.Address_1,'')
														          );                                                                                                                                                                                                                                                                                                                                              
  self.Main_Address2           := map (StringLib.StringFind(l.Address_2,'`150',1) > 0 =>     regexreplace('`150',l.Address_2,'150'),                                                                                                                                                                                                                                                                                                                       
  		                                 StringLib.stringfilterout(l.Address_2,' 0') = '' => '',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                       trim(l.Address_2) = 'N/A' => '',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
                                       trim(l.Address_2) =  '#' => '',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                                       trim(l.Address_2) =  '(SEE LICENSE NUMB\')' => '',                                                                                                                                                                                                                                                                                                                               
                                       regexreplace('\'',l.Address_2,'')
														          );                                                                                                                                                                                                                                                                                                                                             
  self.City                     := map (StringLib.StringFind(StringLib.StringToUpperCase(trim(l.City)),'^UNK$',1) > 0  =>  regexreplace('^UNK$',StringLib.StringToUpperCase(trim(l.City)),''),                                                                                                                                                                                                                                                                                                         
                                        StringLib.stringfilterout(l.Address_1,' 0') = '' => '',                                                                                                                                                                                                                                                                                                                                     
                                        regexreplace('\'',l.City,'')
															         );                                                                                                                                                                                                                                                                                                                                                           
  self.State                    := if (StringLib.StringFind(trim(l.State)[1..2],'^99$',1) > 0 ,  regexreplace('^99$',trim(l.State)[1..2],' '),  regexreplace('\'',l.State[1..2],'') );                                                                                                                                                                                                                                                                                                                         
  self.Zipcode                  := regexreplace('\'',clean_zip,'');																																																																																																																																																																																 
  self.filedate                 := infile(ftype = 'medical')[1].fdate;                                                                                                                                                                                                                                                                                                                                                                      
  self.License                  := if ( trim(l.License)= '0' , '' , regexreplace('\'',trim(l.License),''));                                                                                                                                                                                                                                                                                                                
  self.Name                     := regexreplace('\'',trim(l.Full_Name),'');                                                                                                                                                                                                                                                                                                                                                  
  self.Date_of_First_License    :=  dateconv(trim(l.Date_of_First_License));                                                                                                                                                                                                                                                                            
  self.Expiration_Date          :=  dateconv(trim(l.Expiration));
  self.Status_code              :=  trim(l.Status);                                                                                                                                                                                                                                                                                                                                                                  
  self.Title                    :=  trim(l.Designation);                                                                                                                                                                                                                                                                                                                                                                   
  self.License_Specialty        := regexreplace('\'',trim(l.Speciality),'');                                                                                                                                                                                                                                                                                                                                    
  self.Client                   := trim(l.Client);                                                                                                                                                                                                                                                                                                                                                                        
  self.Public_Board_Order       := l.PBO;                                                                                                                                                                                                                                                                                                                                                                     
  self.Date_of_Public_Board_Order := regexreplace('\'',trim(l.PBDate),''); 
	self.lf                        := '';

end;

 gatemp := project( dmedtrim , map2medical(left)) ;

Prof_License.Layout_proLic_in map2gamedical( gatemp l,File_GA_Medical_LL r) := transform
 self.date_first_seen         := l.filedate;                                                                                                                                                                                                                                                                                                                                                        
self.date_last_seen           := l.filedate;                                                                                                                                                                                                                                                                                                                                                        
self.source_st                := 'GA';                                                                                                                                                                                                                                                                                                                                                                  
self.vendor                   := 'Georgia Composite State Board of Medical Examiners';                                                                                                                                                                                                                                                                                                                           
self.profession_or_board               := 'Medical Examiners';                                                                                                                                                                                                                                                                                                                                                   
self.license_type             := map ( trim(l.Client) = '1101' => 'Physician Assistant' ,                                                                                                                                                                                                                                                                                                               
                                      trim(l.Client) = '1102' => 'Cardiac Technician' ,                                                                                                                                                                                                                                                                                                                
                                      trim(l.Client) = '1103' => 'Paramedic' ,                                                                                                                                                                                                                                                                                                                         
                                      trim(l.Client) = '1104' => 'Physician' ,                                                                                                                                                                                                                                                                                                                         
                                      trim(l.Client) = '1105' => 'Limited Osteopath' ,                                                                                                                                                                                                                                                                                                                 
                                      trim(l.Client) = '1106' => 'Respritory Care Professional',                                                                                                                                                                                                                                                                                                       
                                      trim(l.Client) = '1107' => 'Provisional Physician' ,                                                                                                                                                                                                                                                                                                             
                                      trim(l.Client) = '1108' => 'Institutional Physician' ,                                                                                                                                                                                                                                                                                                           
                                      trim(l.Client) = '1109' => 'Accupunctunit' ,                                                                                                                                                                                                                                                                                                                     
                                      trim(l.Client) = '1110' => 'Auricular Detox Specialist' ,                                                                                                                                                                                                                                                                                                        
                                      trim(l.Client) = '1111' => 'Volunteer Medicine' ,                                                                                                                                                                                                                                                                                                                
                                      trim(l.Client) = '1112' => 'Perfusionist' ,                                                                                                                                                                                                                                                                                                                      
                                      trim(l.Client) = '1113' => 'Physician Teacher' ,                                                                                                                                                                                                                                                                                                                 
                                      trim(l.Client) = '1114' => 'Tmp Residency Training Permit' ,                                                                                                                                                                                                                                                                                                     
                                          trim(l.Client) = '1115' => 'Orthotist' ,                                                                                                                                                                                                                                                                                                                     
                                          trim(l.Client) = '1116' => 'Prosthetist' ,                                                                                                                                                                                                                                                                                                                   
                                          trim(l.Client) = '1117' => 'Orthotist & Prosthetist' ,                                                                                                                                                                                                                                                                                                       
                                   '');                                                                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                                                                                       
self.status               := map( l.Status_code = '15' => 'Admin Hold'  ,                                                                                                                                                                                                                                                                                                                              
                                  l.Status_code = '20' => 'Active'  ,                                                                                                                                                                                                                                                                                                                                  
                                  l.Status_code = '30' => 'Probation'  ,                                                                                                                                                                                                                                                                                                                               
                                  l.Status_code = '40' => 'Inactive'  ,                                                                                                                                                                                                                                                                                                                                
                                  l.Status_code = '45' => 'Lapsed'  ,                                                                                                                                                                                                                                                                                                                                  
                                  l.Status_code = '47' => 'Suspended'  ,                                                                                                                                                                                                                                                                                                                               
                                  l.Status_code = '50' => 'Revoked'  ,                                                                                                                                                                                                                                                                                                                                 
                                  l.Status_code = '51' => 'Surrendered'  ,                                                                                                                                                                                                                                                                                                                             
                                  l.Status_code = '55' => 'Voluntary Surrendered'  ,                                                                                                                                                                                                                                                                                                                   
                                  l.Status_code = '60' => 'Terminated'  ,                                                                                                                                                                                                                                                                                                                              
                                  l.Status_code = '70' => 'Closed'  ,                                                                                                                                                                                                                                                                                                                                  
                                  l.Status_code = '80' => 'Deceased'  ,                                                                                                                                                                                                                                                                                                                                
                                  l.Status_code = '98' => 'Error'  ,                                                                                                                                                                                                                                                                                                                                   
                                  l.Status_code = '99' => 'Deleted'  , '');                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                       
self.status_status_cds   := l.Status_code;                                                                                                                                                                                                                                                                                                                                                             
self.license_number      := l.License;                                                                                                                                                                                                                                                                                                                                                                 
self.orig_name           := l.Name;                                                                                                                                                                                                                                                                                                                                                                    
self.name_order          := 'LFM';                                                                                                                                                                                                                                                                                                                                                                     
self.orig_addr_1         := l.Main_Address1;                                                                                                                                                                                                                                                                                                                                                           
self.orig_addr_2         := l.Main_Address2;                                                                                                                                                                                                                                                                                                                                                           
self.orig_city           := l.City;                                                                                                                                                                                                                                                                                                                                                                    
self.orig_st             := trim(l.State);                                                                                                                                                                                                                                                                                                                                                             
self.orig_zip            := StringLib.Stringfilter(l.Zipcode,'0123456789')[1..9];                                                                                                                                                                                                                                                                                                                      
self.business_flag      := 'N';                                                                                                                                                                                                                                                                                                                                                                       
self.issue_date          := l.Date_of_First_License;                                                                                                                                                                                                                                                                                                   
self.expiration_date     := l.Expiration_Date;                                                                                                                                                                                                                                                                                                         
self.action_effective_dt := map ( trim(l.Date_of_Public_Board_Order) = ' ' or regexfind('[a-zA-Z]',trim(l.Date_of_Public_Board_Order)) => ''   ,                                                                                                                                                                                                                                                                                                                   
		                              length(trim(l.Date_of_Public_Board_Order))=7 => (l.Date_of_Public_Board_Order[4..7] + '0' + l.Date_of_Public_Board_Order[1..3]) ,                                                                                                                                                                                                                                   
		                              length(trim(l.Date_of_Public_Board_Order))=8 => (l.Date_of_Public_Board_Order[5..8] + l.Date_of_Public_Board_Order[1..4]) ,                                                                                                                                                                                                                                          
		                              trim(l.Date_of_Public_Board_Order)                                                                                                                                                                                                                                                                                                                                   
		                            );                                                                                                                                                                                                                                                                                                                                                                     
self.misc_practice_type  := r.desc;                                                                                                                                                                                                                                                                                                           
self.education_1_degree  :=  map ( l.Client not in [ '1104' , '1101' ] => '' ,                                                                                                                                                                                                                                                                                                                         
		                               l.Title <> '1' => 'MD' ,                                                                                                                                                                                                                                                                                                                                            
		                               l.Title = '2' => 'DO' ,                                                                                                                                                                                                                                                                                                                                             
		                                 '');                                                                                                                                                                                                                                                                                                                                                              
self.board_action_indicator := if (l.Public_Board_Order = 'Y' , 'Y' , 'N' );                                                                                                                                                                                                                                                                                                                          

	self := [];
end;

 dGAmedical := Join( gatemp , File_GA_Medical_LL,
                                 left.License_Specialty=right.code,
																 map2gamedical(left,right),
																 left outer,lookup) ( profession_or_board <> ''  and  regexfind(' GA | APO AE | CA | FL | MD | MS | OR | SC | TX | WA ',profession_or_board ) = FALSE ) ;
																 
dGAMedout := Sequential(  
                        FileServices.ClearSuperfile( '~thor_data400::in::prolic::ga::medical'),
                        output(dGAmedical,,'~thor_data400::in::prolic::ga::medical_'+infile(ftype = 'medical')[1].fdate,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::ga::medical'),FileServices.CreateSuperfile('~thor_data400::in::prolic::ga::medical')),												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::ga::medical','~thor_data400::in::prolic::ga::medical_'+infile(ftype = 'medical')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );

//PREPROCESS NURSES

Prof_License.Layout_proLic_in map2gaLPN( Files_GA_raw.file_lpn_raw l ) := transform

 self.date_first_seen       := infile(ftype = 'nurse')[1].fdate;                                       
 self.date_last_seen        := infile(ftype = 'nurse')[1].fdate;                                       
 self.license_type          := l.license_type;                                       
 self.source_st             := 'GA';                                                 
 self.vendor                := 'Georgia Secretary of State';                         
 self.license_number        := l.license_no[1..10];                                  
 self.orig_name             := trim(l.sort_name);                                    
 self.name_order            := 'LFM';                                                
 self.status                := l.status;                                             
 self.orig_addr_1           := l.addr_line1;                                         
 self.orig_addr_2           := l.addr_line2;                                         
 self.orig_addr_3           := l.addr_line3;                                         
 self.orig_city             := l.city;                                               
 self.orig_st               := l.state;                                              
 self.orig_zip              := StringLib.Stringfilter(l.zip,'0123456789')[1..9];     
 self.sex                   := ' ';                                                  
 self.license_obtained_by   := ' ';                                                  
 self.county_str            := l.county;                                             
 self.country_str           := '';                                                   
 self.issue_date            := if ( l.issue_date <> '', fSlashedMDYtoCYMD(l.issue_date),'');                      
 self.expiration_date       := if ( l.expiration_date <> '',fSlashedMDYtoCYMD(l.expiration_date),'');                 
 self.last_renewal_date     := ' ';                                                  
 self.orig_former_name      := ' ';                                                  
 self.phone                 := ' ';                                                  
 self.orig_addr_4           := l.addr_line4;                                         
 self.profession_or_board            := l.license_type; 
 self := [];
end;                                                                                  


dLPNout := Project( Files_GA_raw.file_lpn_raw,map2gaLPN(left));


Prof_License.Layout_proLic_in map2gaRN( Files_GA_raw.file_rn_raw l ) := transform

 self.date_first_seen       := infile(ftype = 'nurse')[1].fdate;                                       
 self.date_last_seen        := infile(ftype = 'nurse')[1].fdate;                                       
 self.license_type          := l.license_type;                                       
 self.source_st             := 'GA';                                                 
 self.vendor                := 'Georgia Secretary of State';                         
 self.license_number        := l.license_no[1..10];                                  
 self.orig_name             := trim(l.sort_name);                                    
 self.name_order            := 'LFM';                                                
 self.status                := l.status;                                             
 self.orig_addr_1           := l.addr_line1;                                         
 self.orig_addr_2           := l.addr_line2;                                         
 self.orig_addr_3           := l.addr_line3;                                         
 self.orig_city             := l.city;                                               
 self.orig_st               := l.state;                                              
 self.orig_zip              := StringLib.Stringfilter(l.zip,'0123456789')[1..9];     
 self.sex                   := ' ';                                                  
 self.license_obtained_by   := ' ';                                                  
 self.county_str            := l.county;                                             
 self.country_str           := '';                                                   
 self.issue_date            := fSlashedMDYtoCYMD(l.issue_date);                      
 self.expiration_date       := fSlashedMDYtoCYMD(l.expiration_date);                 
 self.last_renewal_date     := ' ';                                                  
 self.orig_former_name      := ' ';                                                  
 self.phone                 := ' ';                                                  
 self.orig_addr_4           := l.addr_line4;                                         
 self.profession_or_board   := l.license_type;
  self := [];

end;                                                                                  


dRNout := Project( Files_GA_raw.file_rn_raw,map2gaRN(left));

dNurseAll := Sequential( FileServices.ClearSuperfile( '~thor_data400::in::prolic::ga::nurses'),
                         output( dLPNout + dRNout,,'~thor_data400::in::prolic::ga::nurses_'+infile(ftype = 'nurse')[1].fdate,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::ga::nurses'),FileServices.CreateSuperfile('~thor_data400::in::prolic::ga::nurses')),												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::ga::nurses','~thor_data400::in::prolic::ga::nurses_'+infile(ftype = 'nurse')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );



  prep :=  map ( count(infile(ftype = 'medical')) = 1 and count(infile) = 1 => dGAMedout, 
                     count(infile(ftype = 'available')) = 1 and count(infile) = 1 => dGAAllout,
									count(infile(ftype =	'nurse')) = 1 and count(infile) = 1 =>  dNurseAll,
									count(infile(ftype in ['medical','available'])) = 2 and count(infile) = 2 =>  Sequential( dGAMedout, dGAAllout),
									 count(infile(ftype in ['medical','nurse'])) = 2 and count(infile) = 2 => Sequential(dGAMedout, dNurseAll),
									 count(infile(ftype in ['nurse','available'])) = 2 and count(infile) = 2 => Sequential(dNurseAll,dGAAllout),
									 Sequential( dGAMedout, dGAAllout,dNurseAll) ) ;
                                      
//call macro

input := map ( count(infile(ftype = 'medical')) = 1 and count(infile) = 1 => dGAmedical, 
               count(infile(ftype = 'available')) = 1 and count(infile) = 1  => allavailable,
								count(infile(ftype =	'nurse')) = 1 	and count(infile) = 1 => dLPNout + dRNout,
								count(infile(ftype in ['medical','available'])) = 2 and count(infile) = 2 => dGAmedical + allavailable,
								count(infile(ftype in ['medical','nurse'])) = 2 and count(infile) = 2 => dGAmedical + dLPNout + dRNout,
								count(infile(ftype in ['nurse','available'])) = 2 and count(infile) = 2 => dLPNout + dRNout +allavailable,
								dGAmedical + allavailable + dLPNout + dRNout )  ;

outfile := proc_clean_all(input,'GA').cleanout;

export dGAout := Sequential(prep, 
                                   FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ga'),
																	   if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ga_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ga_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_ga_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_ga_old')),
                       FileServices.RenameLogicalfile( '~thor_data400::in::prolic_ga','~thor_data400::in::prolic_ga_old'),
											      output( outfile,,'~thor_data400::in::prolic_ga',compressed,overwrite),
                            FileServices.StartSuperfiletransaction(),
												    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ga'),
													 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ga_old'),

											      FileServices.FinishSuperfiletransaction()
											   );

end;
