import lib_StringLib,Prof_License;

EXPORT Map_MD_Medical(string fdate) := module

infile := Prof_License_preprocess.File_MD_Medical.raw;


Prof_License.Layout_proLic_in t_MD( inFile l) := transform

    self.date_first_seen       := fdate;                                                                                                                                                                                                                                                                                                                                             
    self.date_last_seen        := fdate;                                                                                                                                                                                                                                                                                                                                              
    self.business_flag        := 'N';                                                                                                                                                                                                                                                                                                                                                         
    self.source_st             := 'MD';                                                                                                                                                                                                                                                                                                                                                             
    self.profession_or_board            := 'Medical';                                                                                                                                                                                                                                                                                                                                                       
    self.name_order            := 'LFM';                                                                                                                                                                                                                                                                                                                                                           
    self.vendor                := 'Board of Physician Quality Assurance';                                                                                                                                                                                                                                                                                                                              
    self.license_number        := l.lic_no;                                                                                                                                                                                                                                                                                                                                                    
    self.orig_name             := trim(regexreplace( ' +', l.phy_last_name +  ' ' + l.generation + ' ' + l.phy_first_name, ' '));                                                                                                                                                                                                                                                                    
    self.orig_addr_1           :=  trim(StringLib.stringfilterout(l.address1,'\''));
    self.orig_addr_2           := trim(StringLib.stringfilterout(l.address2, '\''));                                                                                                                                                                                                                                                                                                                       
    self.orig_city             := l.city;                                                                                                                                                                                                                                                                                                                                                           
    self.orig_st               := l.state;                                                                                                                                                                                                                                                                                                                                                            
    self.orig_zip              := StringLib.stringfilter(l.zipcode, '1234567890')[1..9];                                                                                                                                                                                                                                                                                                    
    self.country_str           := l.foreign_country;                                                                                                                                                                                                                                                                                                                                              
    self.license_obtained_by   := l.how_licensed;                                                                                                                                                                                                                                                                                                                                         
    self.last_renewal_date     := l.renew_year;                                                                                                                                                                                                                                                                                                                                             
    self.status                := map( l.phy_lic_stat[1] = 'A' => 'ACTIVE',
		                                    l.phy_lic_stat[1] = 'P' => 'PROBATION',
												                l.phy_lic_stat[1] = 'N' => 'NON-RENEWED',
												                l.phy_lic_stat[1] = 'I' => 'INACTIVE',
												                l.phy_lic_stat[1] = 'S' => 'SUSPENDED',
												                l.phy_lic_stat[1] = 'R' => 'REVOKED',
												                l.phy_lic_stat[1] = 'U' => 'SURRENDERED',
												                l.phy_lic_stat[1] = 'A' => 'ACTIVE','');
			                                                                                                                                                                                                                                                                                                                     
    self.issue_date := MAP ( length(trim( l.date_orig_lic)) = 8 => l.date_orig_lic[5..8] + l.date_orig_lic[1..2]+ l.date_orig_lic[3..4] ,                                                                                                                                                                               
                             length(trim( l.date_orig_lic)) = 7 AND ( l.date_orig_lic[2] IN ['0','1'] ) =>  l.date_orig_lic[4..7] + '0' + l.date_orig_lic[1] + l.date_orig_lic[2..3] ,                                                                                                
                             length(trim( l.date_orig_lic)) = 7 AND ( l.date_orig_lic[1] IN ['0','1'] ) =>  l.date_orig_lic[4..7] + l.date_orig_lic[1..2]+'0'+l.date_orig_lic[3] ,                                                                                                
                                                                                                                                                                                                                                                                                                                                                                                        
                             l.date_orig_lic[3..6] + '0'+ l.date_orig_lic[1]+'0'+l.date_orig_lic[2]);                                                                                                                                                                                                                                             
    self.expiration_date := fSlashedMDYtoCYMD(l.expiration_date[1..StringLib.StringFind(trim(l.expiration_date),' ',1)]);                                                                                                                                                                                                                                                        
    self.license_type := map( l.lic_no[1] = 'C' =>  'PHYSICIAN ASSISTANT            ',
                         l.lic_no[1] = 'D' =>  'PHYSICIAN                      ',
                         l.lic_no[1] = 'H' =>  'DOCTOR OF OSTEOPATHY           ',
                         l.lic_no[1] = 'X' =>  'RESTRICTED DOCTOR OF OSTEOPATHY',
                         l.lic_no[1] = 'M' =>  'MEDICAL RADIATION TECHNOLOGIST ',
                         l.lic_no[1] = 'O' =>  'MEDICAL RADIATION TECHNOLOGIST ',
                         l.lic_no[1] = 'R' =>  'MEDICAL RADIATION TECHNOLOGIST ',
                         l.lic_no[1] = 'N' =>  'NUCLEAR MEDICAL TECHNOLOGIST   ',
                         l.lic_no[1] = 'L' =>  'RESPIRATORY CARE PRACTITIONER  ',
                         l.lic_no[1] = 'S' =>  'PSYCHIATRIST ASSISTANT         ','' );
                                                                                                                                                                                                                                                                                                                                         
    self.status_status_cds := l.phy_lic_stat;                                                                                                                                                                                                                                                                                                                                           
    self.company_name := ''   ;                                                                                                                                                                                                                                                                                                                                  
    self.county_str := ' ';                                                                                                                                                                                                                                                                                                                                                             
    self.phone := ' ';                                                                                                                                                                                                                                                                                                                                                                  
    self.sex := ' ';                                                                                                                                                                                                                                                                                                                                                                    
    self.dob := ' ';                                                                                                                                                                                                                                                                                                                                                               
    self.orig_former_name := ' ';                                                                                                                                                                                                                                                                                                                                                       
    self.misc_practice_type := trim(l.specialty_title)[1..50];
		self := [];
  end;                                                                                                                                                                                                                                                                                                                                                                                  


dMDMedical := project(  inFile, t_MD(left));

dMDMedicalSF := Sequential(  
                        FileServices.ClearSuperfile( '~thor_data400::in::prolic::md::medical'),

                        output(dMDMedical,,'~thor_data400::in::prolic::md::medical_'+fdate,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::md::medical'),FileServices.CreateSuperfile('~thor_data400::in::prolic::md::medical')),

												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::md::medical','~thor_data400::in::prolic::md::medical_'+fdate),
											   FileServices.FinishSuperfiletransaction()
											 );
											 
											 
outfile := proc_clean_all(dMDMedical,'MD').cleanout;

export buildprep :=FileServices.StartSuperfiletransaction(),
                                   FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_md'),
																	   if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_md_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_md_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_md_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_md_old')),
                       FileServices.RenameLogicalfile( '~thor_data400::in::prolic_md','~thor_data400::in::prolic_md_old'),
										    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_md_old'),
										            FileServices.FinishSuperfiletransaction(),
                         
											output( outfile,,'~thor_data400::in::prolic_md',overwrite),
            
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ma'),
	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
