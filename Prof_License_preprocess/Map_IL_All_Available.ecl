import Prof_License;

EXPORT Map_IL_All_Available( string fdate) := module

fin_il := File_IL_All_Available.raw ;

get_license( string Credential_Prefix) := case ( Credential_Prefix,
'001'  =>   'Architect                         ',           
'002'  =>   'Professional Boxing               ',           
'004'  =>   'Wholesale Drug Distributor        ',           
'006'  =>   'Barber                            ',           
'007'  =>   'Barber Teacher                    ',           
'008'  =>   'Barber School                     ',           
'009'  =>   'Collection Agency Branch Office   ',           
'011'  =>   'Cosmetologist                     ',           
'012'  =>   'Cosmetology Teacher               ',           
'013'  =>   'Cosmetology School                ',           
'015'  =>   'State Owned Cosmetology School    ',           
'016'  =>   'Podiatric Physician               ',           
'017'  =>   'Collection Agency                 ',           
'018'  =>   'Temporary Dentist                 ',           
'019'  =>   'Dentist                           ',           
'020'  =>   'Dental Hygienist                  ',           
'021'  =>   'Specialist in Dentistry           ',           
'028'  =>   'Land Surveyor in Training         ',           
'031'  =>   'Funeral Director                  ',           
'033'  =>   'Funeral Director & Embalmer Trainee',          
'034'  =>   'Funeral Director & Embalmer       ',           
'035'  =>   'Professional Land Surveyor        ',           
'036'  =>   'Physician                         ',           
'037'  =>   'Osteopath                         ',           
'038'  =>   'Chiropractic Physician            ',           
'041'  =>   'Professional Nurse                ',           
'043'  =>   'Practical Nurse                   ',           
'044'  =>   'Nursing Home Administrator        ',           
'045'  =>   'Temporary Nursing Home Admin.     ',           
'046'  =>   'Optometrist                       ',           
'047'  =>   'Ancillary Optometric License      ',           
'049'  =>   'Pharmacy Technician               ',           
'050'  =>   'Assistant Pharmacist              ',           
'051'  =>   'Pharmacist                        ',           
'054'  =>   'Division I Pharmacy               ',           
'056'  =>   'Occupational Therapist            ',           
'057'  =>   'Occupational Therapy Assistant    ',           
'058'  =>   'Division II Pharmacy              ',           
'059'  =>   'Division III Pharmacy             ',           
'060'  =>   'Professional Service Corp.        ',           
'061'  =>   'Engineer Intern                   ',           
'062'  =>   'Professional Engineer             ',           
'063'  =>   'Detection of Deception Trainee    ',           
'064'  =>   'Division IV Pharmacy              ',           
'065'  =>   'Public Accountant                 ',           
'066'  =>   'Public Accounting Firm            ',           
'070'  =>   'Physical Therapist                ',           
'071'  =>   'Clinical Psychologist             ',           
'072'  =>   'Registered Psychologist           ',           
'073'  =>   'Psychological Partnership         ',           
'081'  =>   'Structural Engineer               ',           
'082'  =>   'Structural Engineer Intern        ',           
'083'  =>   'Restricted Shorthand Reporter     ',           
'084'  =>   'Certified Shorthand Reporter      ',           
'085'  =>   'Physicians Assistant in Medicine  ',           
'088'  =>   'Chiropractic Preceptor            ',           
'089'  =>   'Chiropractic Preceptor Program    ',           
'090'  =>   'Veterinarian                      ',           
'093'  =>   'Division V Pharmacy               ',           
'094'  =>   'Detection of Deception Examiner   ',           
'095'  =>   'Veterinary Technician             ',           
'096'  =>   'Athletic Trainer                  ',           
'097'  =>   'Controlled Substance License      ',           
'098'  =>   'Psychological Association         ',           
'102'  =>   'Firearm Security Guard School     ',           
'104'  =>   'Roofing Contractor                ',           
'105'  =>   'Qualifying Party Roofing Contractor',          
'106'  =>   'Visiting Physician Permit         ',           
'113'  =>   'Visiting Physician                ',           
'115'  =>   'Private Detective                 ',           
'117'  =>   'Private Detective Agency          ',           
'118'  =>   'Private Det. Agency Branch Office ',           
'119'  =>   'Private Security Contractor       ',           
'120'  =>   'Proprietary Security Force        ',           
'122'  =>   'Private Sec. Contractor Agency    ',           
'123'  =>   'Private Sec. Contractor Branch Off',           
'124'  =>   'Private Alarm Contractor          ',           
'125'  =>   'Medical Temporary                 ',           
'127'  =>   'Private Alarm Contractor Agency   ',           
'128'  =>   'Private Alarm Cont Agency Br Off',          
'129'  =>   'Permanent Employee Registration Card',         
'130'  =>   'Limited Licensed Medical Temporary',           
'131'  =>   'Esthetician                       ',           
'132'  =>   'Esthetics Teacher                 ',           
'133'  =>   'Esthetics School                  ',           
'135'  =>   'Podiatric Temporary License       ',           
'136'  =>   'Temporary Dental Teaching License ',           
'137'  =>   'Dental Sedation Permit            ',           
'138'  =>   'Approved Optometry CE Sponsor     ',           
'139'  =>   'Appr. Nursing Home Adm CE Sponsor',           
'146'  =>   'Speech Language Pathologist       ',           
'147'  =>   'Audiologist                       ',           
'149'  =>   'Clinical Social Worker            ',           
'150'  =>   'Licensed Social Worker            ',           
'151'  =>   'Podiatry CE Sponsor               ',           
'157'  =>   'Landscape Architect               ',           
'158'  =>   'Pubic Accountant CPE Sponsor      ',           
'159'  =>   'Social Worker CE Sponsor          ',           
'160'  =>   'Physical Therapy Assistant        ',           
'161'  =>   'Interior Designer                 ',           
'164'  =>   'Dietitian                         ',           
'165'  =>   'Nutrition Counselor               ',           
'166'  =>   'Marriage and Family Therapist     ',           
'168'  =>   'Marr. & Fam. Ther. CE Sponsor     ',           
'169'  =>   'Nail Technician                   ',           
'170'  =>   'Nail Technology Teacher           ',           
'171'  =>   'Nail Technology School            ',           
'174'  =>   'Approved Dental CE Sponsor        ',           
'177'  =>   'Temporary Professional Counselor  ',           
'178'  =>   'Professional Counselor            ',           
'180'  =>   'Clinical Professional Counselor   ',           
'181'  =>   'Naprapath                         ',           
'183'  =>   'Environmental Health Practitioner ',           
'184'  =>   'Prof. Design Firm Registration    ',           
'185'  =>   'Residential Interior Designer     ',           
'186'  =>   'Athletic Trainer CE Sponsor       ',           
'187'  =>   'Shorthand Reporter CE Sponsor     ',           
'188'  =>   'Temp Visiting Resident Permit     ',           
'189'  =>   'Salon/Shop Registration           ',           
'190'  =>   'B.C.E.N.T. CE Sponsor             ',           
'191'  =>   'Locksmith                         ',           
'192'  =>   'Locksmith Agency                  ',           
'193'  =>   'Locksmith Agency Branch Office    ',           
'194'  =>   'Respiratory Care Practitioner     ',           
'195'  =>   'Resp. Care Practitioner CE Sponsor',           
'196'  =>   'Professional Geologist            ',           
'197'  =>   'Prof Couns./Clin.Couns. CE Sponsor',           
'198'  =>   'Acupuncturist                     ',           
'199'  =>   'Diet./Nut. Counselor CE Sponsor   ',           
'200'  =>   'Env.Health Practitioner CE Sponsor',           
'201'  =>   'Approved Training Course School   ',           
'202'  =>   'Speech Language Path. CE Sponsor  ',           
'203'  =>   'Home Med. Equipment Serv. Provider',           
'204'  =>   'Medical CE Sponsor                ',           
'205'  =>   'Cosmetology clinical Teacher      ',           
'208'  =>   'Associate in MFT                  ',           
'209'  =>   'Advanced Practice Nurse           ',           
'210'  =>   'Mail Order Opthalmic Provider     ',           
'211'  =>   'Prosthetist                       ',           
'212'  =>   'Pedorthist                        ',           
'213'  =>   'Orthotist                         ',           
'214'  =>   'Licensed Perfusionist             ',           
'215'  =>   'Temporary Licensed Social Worker  ',           
'216'  =>   'Physical Therapy CE Sponsor       ',           
'217'  =>   'Speech Language Path. Assistant   ',           
'218'  =>   'Veterinary CE Sponsor             ',           
'220'  =>   'Electrologist                     ',           
'221'  =>   'Environmental Health Practitioner in Training',
'222'  =>   'Optometric Limited Residency      ',           
'224'  =>   'Occupational Therapy CE Sponsor   ',           
'225'  =>   'Acupuncture CE Sponsor            ',           
'227'  =>   'Massage Therapist                 ',           
'228'  =>   'Certified Euthanasia Agency       ',           
'229'  =>   'Firearm Authorization Card        ',           
'230'  =>   'Firearm Training Certificate      ',           
'235'  =>   'Certified Euthanasia Technician   ',           
'237'  =>   'Surgical Technologist             ',           
'238'  =>   'Surgical Assistant                ',           
'239'  =>   'Registered Certified Public Accountant',       
'300'  =>   'Pharmacy Controlled Substance License',        
'304'  =>   'Wholesale Drug Distr. CS License  ',           
'309'  =>   'Advanced Practice Nurse CS License',           
'316'  =>   'Podiatric Physician CS License    ',           
'319'  =>   'Dentist CS License                ',           
'328'  =>   'Certified Euthanasia Agency CS License',       
'336'  =>   'Physician CS License              ',           
'346'  =>   'Optometrist CS License            ',           
'385'  =>   'Physician.s Asst. CS License      ',           
'390'  =>   'Veterinarian CS License           ',  '');         


Prof_License.Layout_proLic_in map2comm( fin_il l) := transform

  self.profession_or_board    :=  get_license(l.Credential_Prefix) ;                                                                                                                             
  self.source_st              := 'IL';                                                                                                                                                                                                                                               
  self.orig_name              := l.Name;                                                                                                                                                                                                                                             
  self.orig_city              := StringLib.StringToUpperCase(trim(l.City));                                                                                                                                                                                                                        
  self.orig_st                := trim(l.State);                                                                                                                                                                                                                                        
  self.orig_zip               := if (trim(StringLib.StringFilterout((StringLib.stringfilter(l.Zip_Code,'0123456789')[1..9]), '0')) <> '' , StringLib.stringfilter(l.Zip_Code,'0123456789')[1..9], '' );                                                                                  
                                                                                                                                                                                                                                                                                                      
  self.sex                    := ' ';                                                                                                                                                                                                                                                      
  self.license_obtained_by    := ' ';                                                                                                                                                                                                                                      
  self.country_str            := ' ';                                                                                                                                                                                                                                              
  self.last_renewal_date      := ' ';                                                                                                                                                                                                                                        
  self.vendor                 := 'Dept of Professional Regulation - IL';                                                                                                                                                                                                                
  self.orig_former_name       := ' ';                                                                                                                                                                                                                                         
  self.status                 := l.Status;                                                                                                                                                                                                                                              
  self.license_number         := Stringlib.stringfilterout(l.Credential_Number,'.');                                                                                                                                                                                                   
  self.phone                  := ' ';                                                                                                                                                                                                                                                    
  self.business_flag         := 'N';                                                                                                                                                                                                                                           
  self.board_action_indicator := trim(l.Has_Been_Disciplined);                                                                                                                                                                                                          
  self.license_type           :=  get_license(l.Credential_Prefix) ;                                                                                            
  self.date_first_seen        := fdate;                                                                                                                                                                                                                               
  self.date_last_seen         := fdate;                                                                                                                                                                                                                                
  self.name_order             := 'FML';                                                                                                                                                                                                                                      
  self.issue_date             := trim(l.License_Issuance_Date);                                                                                                                                                                                                                     
  self.expiration_date        := trim(l.License_Expiration_Date);                                                                                                                                                                                                              
  self.county_str             := l.County;                                                                                                                                                                                                                                          
  self.company_name      := l.Business_Name;                                                                                                                                                                                                                            
  self.orig_addr_1            := l.Address_Line1;                                                                                                                                                                                                                                  
  self.orig_addr_2            := l.Address_Line2;                                                                                                                                                                                                                                  
  self := [];
end;                                                                

fout_IL := project ( fin_il , map2comm (left));

 dout := Sequential( Output( fout_IL,,'~thor_data400::in::prolic::il::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::il::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::il::all_available','~thor_data400::in::prolic::il::all_available_'+fdate)
															 );
															 
outfile := proc_clean_all(fout_IL,'IL').cleanout;

export buildprep := Sequential(dout, 
                                   FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_il'),
																	   if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_il_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_il_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_il_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_il_old')),
                       FileServices.RenameLogicalfile( '~thor_data400::in::prolic_il','~thor_data400::in::prolic_il_old'),
			
               
                         
											output( outfile,,'~thor_data400::in::prolic_il',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
										    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_il_old'),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_il'),
	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		


