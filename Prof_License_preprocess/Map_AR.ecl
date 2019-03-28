EXPORT Map_AR(dataset({string ftype,string fdate})infile) := module
  import Prof_License, lib_StringLib, ut,Std;

//DDS
  

//Map to final layout

  Prof_License.Layout_proLic_in t_common( Files_AR_raw.DDS l) := transform
    self.date_first_seen                      := infile(ftype = 'dentists')[1].fdate;                                                                                                                                                                                                                                                    
    self.date_last_seen                      := infile(ftype = 'dentists')[1].fdate;                                                                                                                                                                                                                                                    
    self.orig_addr_1                        := l.Home_Address;                                                                                                                                                                                                                                                  
    self.vendor                           := 'Arkansas State Board of Dental Examiners';                                                                                                                                                                                                                        
    self.source_st                         := 'AR';                                                                                                                                                                                                                                                              
    self.profession_or_board                  := 'Dental';                                                                                                                                                                                                                                                          
    self.name_order                        := 'FML';                                                                                                                                                                                                                                                             
    self.orig_city                          := l.City;                                                                                                                                                                                                                                                            
    self.orig_st                           := trim(l.State);                                                                                                                                                                                                                                                     
    self.orig_zip                           := StringLib.StringFilter(l.Zip_Code,'0123456789')[1..9];                                                                                                                                                                                                          
    self.orig_name                         := trim(l.First_Name)+' '+trim(l.Last_Name);                                                                                                                                                                                                      
    self.license_type                        := 'Dentist';                                                                                                                                                                                                                                                         
    self.phone                            := StringLib.StringFilter(l.Office_Phone,'0123456789');                                                                                                                                                                                                            
    self.education_1_degree                   := trim(l.Degree)[1..15];                                                                                                                                                                                                                                         
    self.misc_email                         := l.Email;                                                                                                                                                                                                                                                           
    self.misc_fax                           := StringLib.StringFilter(l.Fax_Number,'0123456789');                                                                                                                                                                                                              
    self.license_number                      := l.License_Number;                                                                                                                                                                                                                                                  
    self.issue_date                         := fSlashedMDYtoCYMD(trim(l.Date_of_License));                                                                                                                                                                                                                                           
    self.dob                              := fSlashedMDYtoCYMD(trim(l.Date_of_Birth));                                                                                                                                                                                                                                             
    self.sex                               := l.Sex;                                                                                                                                                                                                                                                             
    self.additional_licensing_specifics            := l.Speciality;                                                                                                                                                                                                                                                 
    self.misc_other_id                       := l.DEA_License_Number;                                                                                                                                                                                                                                              
    self.misc_other_id_type                   := if( l.DEA_License_Number <> '', 'DEA Number' , '') ;                                                                                                                                                                                                               
    self.additional_orig_city                   := l.City;                                                                                                                                                                                                                                                            
    self.additional_orig_st                    := l.State;                                                                                                                                                                                                                                                           
    self.additional_orig_zip                    := StringLib.StringFilter(l.Zip_Code,'0123456789')[1..9];                                                                                                                                                                                                          
    self.expiration_date                      := fSlashedMDYtoCYMD(trim(l.Expiration_Date));                                                                                                                                                                                                                                           
    self.personal_race_desc                   := l.Race;                                                                                                                                                                                                                                                            
    self.status                            := if ( l.Expiration_Date <> '' and  (string) Std.Date.Today()   < self.expiration_date , 'Active'  , 'Expired'    );                                                                                                                                                       
    self  := l;                                                                                                                                                                                                                                                                                           
    self  := [];                                                                                                                                                                                                                                                                                          

  end;

map2commondds := project( Files_AR_raw.DDS,t_common(left));

//RDA


 Prof_License.Layout_proLic_in rda_common( Files_AR_raw.RDA l) := transform
  self.date_first_seen                 := infile(ftype = 'dentists')[1].fdate;                                  
  self.date_last_seen                 := infile(ftype = 'dentists')[1].fdate;                                  
  self.vendor                      := 'Arkansas State Board of Dental Examiners';      
  self.source_st                    := 'AR';                                            
  self.profession_or_board            := 'Dental';                                        
  self.license_type                  := 'Dental Assistant';                              
  self.license_number                := l.License_Number;                                
  self.name_order                  := 'FML';                                           
  self.orig_name                   := trim(l.First_Name)+' '+trim(l.Last_Name);        
  self.orig_addr_1                  := l.Address;                                       
  self.orig_city                    := l.City;                                          
  self.orig_st                     := trim(l.State);                                   
  self.orig_zip                    := StringLib.Stringfilter(l.Zip_Code,'0123456789')[1..9];  
  self.misc_email                  := l.Email;                                         
  self.issue_date                  := fSlashedMDYtoCYMD(trim(l.Date_of_License));                         
  self.dob                       := fSlashedMDYtoCYMD(trim(l.Date_of_Birth));                           
  self.phone                     := StringLib.Stringfilter(l.Phone,'0123456789');           
  self.expiration_date               := fSlashedMDYtoCYMD(trim(l.Expiration_Date));                         
  self.status                     := map ( trim( l.Status) = 'A' => 'Active' ,        
                                        trim( l.Status) = 'I' => 'InActive' , ''   
                                      );
																				
  self := []; 
 end;                                                                                

  map2commonrda := project( Files_AR_raw.RDA,rda_common(left));


//RDH

  Prof_License.Layout_proLic_in rdh_common( Files_AR_raw.RDH l) := transform
    self.date_first_seen            := infile(ftype = 'dentists')[1].fdate;                                  
    self.date_last_seen            := infile(ftype = 'dentists')[1].fdate;                                   
    self.vendor                 := 'Arkansas State Board of Dental Examiners';               
    self.source_st               := 'AR';                                                  
    self.profession_or_board        := 'Dental';                                             
    self.license_type              := 'Dental Hygienist';                                 
    self.license_number            := l.License_Number;                                 
    self.name_order              := 'FML';                                                
    self.orig_name               := trim(l.First_Name)+' '+trim(l.Last_Name);              
    self.orig_addr_1              := l.Address;                                          
    self.orig_city                := l.City;                                                
    self.orig_st                 := trim(l.State);                                           
    self.orig_zip                := StringLib.Stringfilter(l.Zip_Code,'0123456789')[1..9];         
    self.phone                 := StringLib.Stringfilter(l.Home_Phone,'0123456789');                
    self.misc_email              := l.Email;                                              
    self.issue_date              := fSlashedMDYtoCYMD(trim(l.Date_of_License));                              
    self.dob                   := fSlashedMDYtoCYMD(trim(l.Date_of_Birth));                                            
    self.sex                     := l.Gender;                                                    
    self.education_1_degree        := l.Degree_Type;                                
    self.education_1_school_attended := trim(l.Dental_School)[1..30]; 
    self.expiration_date           := fSlashedMDYtoCYMD(trim(l.Expiration_Date));                         
    self.status                 := if ( l.Expiration_Date <> '' and  (string) Std.Date.Today()   < self.expiration_date , 'Active'  , 'Expired'    );  
    self := [];                                                                                                                                                      
end;

map2commonrdh := project( Files_AR_raw.RDH,rdh_common(left));

dARdent := Sequential( FileServices.ClearSuperfile( '~thor_data400::in::prolic::ar::dentist'),
                    output(map2commondds+map2commonrda+map2commonrdh ( trim(orig_city) <> 'City'),,'~thor_data400::in::prolic::ar::dentist_'+infile(ftype = 'dentists')[1].fdate,overwrite);
                         FileServices.StartSuperfiletransaction(),
												     if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::ar::dentist'),FileServices.CreateSuperfile('~thor_data400::in::prolic::ar::dentist')),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::ar::dentist','~thor_data400::in::prolic::ar::dentist_'+infile(ftype = 'dentists')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );

Prof_License.Layout_proLic_in pharm_common( Files_AR_raw.pharmacy l) := transform

self.date_first_seen      := infile(ftype = 'pharmacy')[1].fdate;                                                 
self.date_last_seen       := infile(ftype = 'pharmacy')[1].fdate;                                                 
self.profession_or_board           := 'Pharmacist';                                                   
self.orig_name            :=STD.Str.CleanSpaces ( trim(l.First_Name) + ' '+ trim(l.Middle_Name) + ' '+ trim(l.Last_Name));                                       
self.name_order           := 'FML';                                                          
self.orig_addr_1          := l.Mail_Street;                                                  
self.orig_city            := StringLib.stringfilterout(l.Mail_City,'"');                     
self.orig_st              := trim(l.Mail_State);                                             
self.orig_zip             := StringLib.stringfilter(l.Mail_Zip, '0123456789');                        
self.source_st            := 'AR';                                                           
self.vendor               := 'Arkansas State Board of Pharmacy';                             
self.phone                := StringLib.stringfilter(l.Mail_WorkPhone,'0123456789')[1..10];   
self.issue_date           := fSlashedMDYtoCYMD(l.EffectiveDate);                              
self.expiration_date      := fSlashedMDYtoCYMD(l.ExpirationDate);                             
self.status               := l.LicenseStatus;                                                
self.license_number       := l.LicenseNumber;                                                
self.misc_fax             := StringLib.stringfilterout(trim(l.Mail_Fax),'()- ');    
self.sex                  := l.Gender;                                                       
self.license_type         := l.LicenseType;    
self := [];                                              
end;                                                                                           

map2commonph := project( Files_AR_raw.pharmacy,pharm_common(left));

dARph := Sequential(    FileServices.ClearSuperfile( '~thor_data400::in::prolic::ar::pharmacist'),
                        output(map2commonph,,'~thor_data400::in::prolic::ar::pharmacist_'+infile(ftype = 'pharmacy')[1].fdate,overwrite);
                         FileServices.StartSuperfiletransaction(),
												 if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::ar::pharmacist'),
												                                                                                    FileServices.CreateSuperfile('~thor_data400::in::prolic::ar::pharmacist')
														),											 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::ar::pharmacist','~thor_data400::in::prolic::ar::pharmacist_'+infile(ftype = 'pharmacy')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );

Prof_License.Layout_proLic_in opt_common( Files_AR_raw.optometry l) := transform

self.date_first_seen     := infile(ftype = 'optometry')[1].fdate;                                                  
self.date_last_seen      := infile(ftype = 'optometry')[1].fdate;                                                  
self.profession_or_board          := 'Optometrist';                                                   
self.orig_name           := StringLib.stringfilterout(l.Firstname+ ' ' + if ( l.Initals <> '', l.Initals,'') + ' '+  l.Lastname,'"');   
self.name_order          := 'FML';                                                           
self.orig_addr_1         := l.Mailing_Address;                                               
self.orig_city           := StringLib.stringfilterout(l.Mail_City,'"');                      
self.orig_st             := trim(l.Mail_State);                                              
self.orig_zip            := StringLib.stringfilter(l.Mail_Zipcode, '0123456789');            
self.source_st           := 'AR';                                                            
self.vendor              := 'Arkansas State Board of Optometry';                             
self.phone               := '';                    
self.misc_email          := l.EMAIL_ADDRESS;                                                 
self.issue_date          := Prof_License_preprocess.dateconv(trim(l.Date_Licensed));
self.expiration_date     := Prof_License_preprocess.dateconv(trim(l.Licenses_Expires));														
self.dob                 := Prof_License_preprocess.dateconv(trim(l.DOB));
self.license_number      := l.LicNum;                                                        
self.status              := l.Status;                                                        
self.misc_fax            := '';                   
self.education_1_dates_attended := '';                                         
self.misc_other_id              := '';                                             
self := [];                                              
end;                                                                                           

map2commonopt := project( Files_AR_raw.optometry,opt_common(left));                                                                                             

dARopt := Sequential(   FileServices.ClearSuperfile( '~thor_data400::in::prolic::ar::optometrist'),
                        output(map2commonopt,,'~thor_data400::in::prolic::ar::optometrist_'+infile(ftype = 'optometry')[1].fdate,overwrite);
                         FileServices.StartSuperfiletransaction(),
												   if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::ar::optometrist'),FileServices.CreateSuperfile('~thor_data400::in::prolic::ar::optometrist')),
												   FileServices.AddSuperfile( '~thor_data400::in::prolic::ar::optometrist','~thor_data400::in::prolic::ar::optometrist_'+infile(ftype = 'optometry')[1].fdate),
											  FileServices.FinishSuperfiletransaction()
											 );

prep := map ( count(infile(ftype = 'dentists')) = 1 and count(infile) = 1 => dARdent, 
               count(infile(ftype = 'optometry')) = 1 and count(infile) = 1  => dARopt,
								count(infile(ftype =	'pharmacy')) = 1 	and count(infile) = 1 => dARph,
								count(infile(ftype in ['dentists','optometry'])) = 2 and count(infile) = 2 => Sequential( dARdent , dARopt), 
								count(infile(ftype in ['dentists','pharmacy'])) = 2 and count(infile) = 2 => Sequential( dARdent , dARph),
								count(infile(ftype in ['optometry','pharmacy'])) = 2 and count(infile) = 2 => Sequential( dARph , dARopt),
								Sequential( dARdent , dARopt , dARph) 
								)  ;
 

input := map ( count(infile(ftype = 'dentists')) = 1 and count(infile) = 1 => map2commondds + map2commonrda + map2commonrdh, 
               count(infile(ftype = 'optometry')) = 1 and count(infile) = 1  => map2commonopt,
								count(infile(ftype =	'pharmacy')) = 1 	and count(infile) = 1 => map2commonph,
								count(infile(ftype in ['dentists','optometry'])) = 2 and count(infile) = 2 => map2commondds + map2commonrda + map2commonrdh + map2commonopt,
								count(infile(ftype in ['dentists','pharmacy'])) = 2 and count(infile) = 2 => map2commondds + map2commonrda + map2commonrdh + map2commonph,
								count(infile(ftype in ['optometry','pharmacy'])) = 2 and count(infile) = 2 => map2commonopt + map2commonph,
								map2commondds + map2commonrda + map2commonrdh + map2commonopt + map2commonph )  ;



outfile := proc_clean_all(input,'AR').cleanout;

arbase := dataset('~thor_data400::in::prolic_ar',Prof_License.Layout_proLic_in ,flat);


//Verifying License numbers in  base from prep file
validate_prep := Prof_License_preprocess.fn_ValidateLicInBase (input, arbase,'ar').out;

superfile_trans := Sequential(    FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ar'),
                        if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ar_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ar_old')),
								        if ( FileServices.FileExists( '~thor_data400::in::prolic_ar_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_ar_old')),
                        FileServices.RenameLogicalfile( '~thor_data400::in::prolic_ar','~thor_data400::in::prolic_ar_old'),
										 );

export buildprep := Sequential( prep,
                         superfile_trans,
                         output( outfile,,'~thor_data400::in::prolic_ar',compressed,overwrite),
												             validate_prep,
                         FileServices.StartSuperfiletransaction(),
	                         FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ar'),
													             FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ar_old'), 											   
													           FileServices.FinishSuperfiletransaction()
											       );

end;                                                                
