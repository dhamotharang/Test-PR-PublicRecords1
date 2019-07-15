EXPORT Map_MN(dataset({string ftype,string fdate})infile) := module

Import Prof_License,ut,lib_stringlib;

//MAP Architect 


getcounty( string2 code) := case ( code, '01' => 'AITKIN       ',   
'02' => 'ANOKA        ',   
'03' => 'BECKER       ',   
'04' => 'BELTRAMI     ',   
'05' => 'BENTON       ',   
'06' => 'BIG-STONE    ',   
'07' => 'BLUE-EARTH   ',   
'08' => 'BROWN        ',   
'09' => 'CARLTON      ',   
'10' => 'CARVER       ',   
'11' => 'CASS         ',   
'12' => 'CHIPPEWA     ',   
'13' => 'CHISAGO      ',   
'14' => 'CLAY         ',   
'15' => 'CLEARWATER   ',   
'16' => 'COOK         ',   
'17' => 'COTTONWOOD   ',   
'18' => 'CROW WING    ',   
'19' => 'DAKOTA       ',   
'20' => 'DODGE        ',   
'21' => 'DOUGLAS      ',   
'22' => 'FARIBAULT    ',   
'23' => 'FILLMORE     ',   
'24' => 'FREEBORN     ',   
'25' => 'GOODHUE      ',   
'26' => 'GRANT        ',   
'27' => 'HENNEPIN     ',   
'28' => 'HOUSTON      ',   
'29' => 'HUBBARD      ',   
'30' => 'ISANTI       ',   
'31' => 'ITASCA       ',   
'32' => 'JACKSON      ',   
'33' => 'KANABEC      ',   
'34' => 'KANDIYOHI    ',   
'35' => 'KITTSON      ',   
'36' => 'KOOCHICHING  ',   
'37' => 'LAC QUI PARLE',   
'38' => 'LAKE         ',   
'39' => 'LAKE OF THE WOOD',
'40' => 'LE SUEUR     ',   
'41' => 'LINCOLN      ',   
'42' => 'LYON         ',   
'43' => 'MCLEOD       ',   
'44' => 'MAHNOMEN     ',   
'45' => 'MARSHALL     ',   
'46' => 'MARTIN       ',   
'47' => 'MEEKER       ',   
'48' => 'MILLE-LACS   ',   
'49' => 'MORRISON     ',   
'50' => 'MOWER        ',   
'51' => 'MURRAY       ',   
'52' => 'NICOLLET     ',   
'53' => 'NOBLES       ',   
'54' => 'NORMAN       ',   
'55' => 'OLMSTED      ',   
'56' => 'OTTERTAIL    ',   
'57' => 'PENNINGTON   ',   
'58' => 'PINE         ',   
'59' => 'PIPESTONE    ',   
'60' => 'POLK         ',   
'61' => 'POPE         ',   
'62' => 'RAMSEY       ',   
'63' => 'RED LAKE     ',   
'64' => 'REDWOOD      ',   
'65' => 'RENVILLE     ',   
'66' => 'RICE         ',   
'67' => 'ROCK         ',   
'68' => 'ROSEAU       ',   
'69' => 'ST LOUIS     ',   
'70' => 'SCOTT        ',   
'71' => 'SHERBURNE    ',   
'72' => 'SIBLEY       ',   
'73' => 'STEARNS      ',   
'74' => 'STEELE       ',   
'75' => 'STEVENS      ',   
'76' => 'SWIFT        ',   
'77' => 'TODD         ',   
'78' => 'TRAVERSE     ',   
'79' => 'WABASHA      ',   
'80' => 'WADENA       ',   
'81' => 'WASECA       ',   
'82' => 'WASHINGTON   ',   
'83' => 'WATONWAN     ',   
'84' => 'WILKIN       ',   
'85' => 'WINONA       ',   
'86' => 'WRIGHT       ',   
'87' => 'YELLOW MEDICINE', 
'');



Prof_License.Layout_proLic_in map2architec( File_MN.architect l) := transform


                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                             
  self.profession_or_board                        := 'Architects';                                                                   
  self.business_flag                    := 'N';                                                                        
  self.source_st                         := 'MN';                                                                            
  self.orig_name                         := l.FNAME+' '+l.LNAME;                                                 
 // self.company_name                 := l.BUSNAME;                                                               
  self.orig_addr_1                       := l.ADDRESS1;                                                                    
  self.orig_addr_2                       := l.ADDRESS2;                                                                    
  self.orig_city                         := l.CITY;                                                                          
  self.orig_st                           := l.STATE;                                                                           
  self.orig_zip                          := StringLib.stringfilter(l.ZIPCODE, '1234567890')[1..9];                            
  self.sex                               := ' ';                                                                                   
  self.license_obtained_by               := ' ';                                                                   
  self.county_str                        := getcounty(l.COUNTY);                                                                                                                                                            
  self.expiration_date                   := dateconv(trim(l.EXPDATE));                                                                       
  self.issue_date                        := dateconv(trim(l.OLD));               
  self.last_renewal_date                 := ' ';                                                                     
  self.name_order                        := 'FML';                                                                          
  self.vendor                            := 'State of Minnesota - License Listing Unit';                                        
  self.orig_former_name                  := ' ';                                                                      
  self.status                            := if ( ut.DaysApart ( self.expiration_date,self.issue_date) > 0 , 'ACTIVE' ,'INACTIVE' ) ;                                                                                
  self.license_number                    := l.LICNUM;                                                                   
  self.phone                             := ' ';                                                                                 
  self.dob                               := ' ';                                                                              
  self.license_type                      := l.LICTYPE;                                                                    
  self.board_action_indicator            := ' ';                                                                
  self.date_first_seen                   := infile(ftype = 'available')[1].fdate;                                                            
  self.date_last_seen                    := infile(ftype = 'available')[1].fdate;                                                             
  self.misc_other_id                     := '';                                                                    
  self.misc_other_id_type                := '';                                   
  self.additional_licensing_specifics    := '';                              
  self.country_str                       := '';    
	self := l;
	self := [];
end;                                                                                                 

dWithArchitect := project( File_MN.architect, map2architec(left));

//MAP BLDG CONT 


Prof_License.Layout_proLic_in map2bldg( File_MN.bldg l) := transform

                                                                                                                                                                      

self.profession_or_board                            := 'Building Contractors';                                                            											
self.business_flag                        := 'N';                                                                                                 
self.source_st                             := 'MN';                                                                                                     
self.orig_name                             := l.NAME;                                                                     
//self.company_name                     := l.CompanyName;                                                                                        
self.orig_addr_1                           := l.Addr1;                                                                                             
self.orig_addr_2                           := l.Addr2;                                                                                             
self.orig_city                             := l.CITY;                                                                                                   
self.orig_st                               := l.St;                                                                                                    
self.orig_zip                              := l.ZIP;                                                              
self.sex                                   := ' ';                                                                                                            
self.license_obtained_by                   := ' ';                                                                                            
self.county_str                            :=  getcounty(l.Countycode);                                                                                                                                                                                                                                     
self.country_str                           := ' ';                                                                                                    
self.expiration_date                       := dateconv(trim(l.Exp_Date));   
                                                                                                                            
self.issue_date                            := dateconv(trim(l.Orig_Date));                
                                                                                                                            
self.last_renewal_date                     := ' ';                                                                                              
self.name_order                            := 'FML';                                                                                                   
self.vendor                                := 'State of Minnesota - License Listing Unit';                                                                 
self.orig_former_name                      := ' ';                                                                                               
self.status                                :=  if ( ut.DaysApart ( self.expiration_date,self.issue_date) > 0 , 'ACTIVE' ,'INACTIVE' );                                                         
                                                                                                                            
self.license_number                        := l.LicNumber;                                                                                            
self.phone                                 := l.Phone_No;                                                                                                  
self.dob                              := ' ';                                                                                                       
self.license_type                          := l.LICTYPE;                                            
                                                                                                                            
self.board_action_indicator                := ' ';                                                                                         
self.date_first_seen                       := infile(ftype = 'available')[1].fdate;                                                                                     
self.date_last_seen                        := infile(ftype = 'available')[1].fdate;                                                                                      
self.status_status_cds                     := '';                                                                                         
//self.additional_name_addr_type             := if ( l.DBA <> '', 'DoingBusinessAs' , '');                                             
//self.additional_orig_name                  := l.DBA;                                                                                      
self.status_effective_dt                   := '';                                                            
self.misc_occupation                       := '';                                             
                                                                                                                            
self.misc_practice_type := '';                                   
                                                                                                                            
self.additional_licensing_specifics := '';   
self := l;
self := [];                         
end;                                                                                                                          
                                                                                                                            
dWithBLDG := project( File_MN.bldg, map2bldg(left));
                                                                                                                            
  
//MAP CPA 
 
 Prof_License.Layout_proLic_in map2cpa( File_MN.cpa l) := transform

  self.profession_or_board                      := 'Accountants';                                                                              
  self.business_flag                  := 'N';                                                                                    
  self.source_st                       := 'MN';                                                                                        
  self.orig_name                       := l.FNAME + ' ' + l.MNAME + ' ' + l.LNAME;                                                     
  self.company_name               := l.EMPLOYER;                                                                          
  self.orig_addr_1                     := l.ADDRESS1;                                                                                
  self.orig_addr_2                     := l.ADDRESS2;                                                                                
  self.orig_city                       := l.CITY;                                                                                      
  self.orig_st                         := l.STATE;                                                                                       
  self.orig_zip                        := l.ZIPCODE;                                                                                    
  self.sex                             := ' ';                                                                                               
  self.license_obtained_by             := ' ';                                                                               
  self.county_str                      :=  getcounty(l.COUNTY);                                                               
  self.country_str                     := ' ';                                                                                       
  self.issue_date                      :=  dateconv(trim(l.OLD)); 
	self.expiration_date                 := dateconv(trim(l.EXP_DATE));
  self.last_renewal_date               := ' ';                                                                                 
  self.name_order                      := 'FML';                                                                                      
  self.vendor                          := 'State of Minnesota - License Listing Unit';                                                    
  self.orig_former_name                := ' ';                                                                                  
  self.status                          := if (l.STATUS = 'ActCur' , 'ACTIVE CURRENT'   , '');                                                   
  self.license_number                  := l.LICNUM;                                                                               
  self.phone                           := '';                                                                                         
  self.dob                        := ' ';                                                                                          
  self.license_type                    := map ( l.LICTYPE = 'CPA' => 'CERTIFIED PUBLIC ACCOUNTANT'  ,                                  
                                                l.LICTYPE = 'LPA' => 'LICENSED PUBLIC ACCOUNTANT' ,
                                                 ''
																							);
                                                                                                       
  self.board_action_indicator         := ' ';                                                                            
  self.date_first_seen                := infile(ftype = 'available')[1].fdate;                                                                        
  self.date_last_seen                 := infile(ftype = 'available')[1].fdate;                                                                         
  self.additional_name_addr_type      := '';                                      
  self.additional_phone                := '';                                               
  SELF := l;
	self := [];
	end;
	
	dWithCPA := project( File_MN.cpa, map2cpa(left));


                                                                                                                            
 
Prof_License.Layout_proLic_in map2dent( File_MN.dentist l) := transform


                                                                                                                
                                                                                          
     self.profession_or_board                            := 'Dentists';                                                                              
     self.business_flag                        := 'N';                                                                                 
     self.source_st                             := 'MN';                                                                                     
     self.orig_name                             := l.FNAME+' '+l.MNAME+' '+l.LNAME;                                        
     self.company_name                     := ' ';                                                                              
     self.orig_addr_1                           := l.ADDRESS1;                                                                            
     self.orig_addr_2                           := l.ADDRESS2;                                                                            
     self.orig_city                             := l.CITY;                                                                                  
     self.orig_st                               := l.STATE[1..2];                                                             
     self.orig_zip                              := StringLib.stringfilter(l.ZIPCODE,'1234567890')[1..9];                              
     self.sex                                   := l.GENDER;                                                                                      
     self.license_obtained_by                   := ' ';                                                                            
     self.county_str                            := getcounty(l.COUNTY);                                                        
     self.country_str                           := l.COUNTRY;                                                                             
     self.expiration_date                       := dateconv(trim(l.EXPDATE)); 
     self.issue_date                            := dateconv(trim(l.OLD));           
                                                                                    
     self.last_renewal_date                     := ' ';                                                                              
     self.name_order                            := 'FML';                                                                                   
     self.vendor                                := 'State of Minnesota - License Listing Unit';                                                 
     self.orig_former_name                      := ' ';                                                                               
     self.status                                := map (l.STATUS = 'APO' => 'ACTIVE PRACTICING OUT STATE',                                        
                                                        l.STATUS = 'API' => 'ACTIVE PRACTICING IN STATE' ,                                                    
                                                        l.STATUS = 'ANO' => 'ACTIVE NOT PRACTICING OUT STATE' ,                                             
                                                        l.STATUS = 'ANI' => 'ACTIVE NOT PRACTICING IN STATE',
	                                                      '');
                                                                                                     
     self.license_number                       := l.LICNUM;                                                                           
     self.phone                                := ' ';                                                                                          
     self.dob                             := dateconv(l.DOB);                                                                  
     self.license_type                         := map ( l.LICNUM[1] = 'D' =>  'DENTIST'        ,                          
                                                        l.LICNUM[1] = 'F' => 'FACULTY DENTIST'  ,                                         
                                                        l.LICNUM[1] = 'R' => 'RESIDENT DENTIST' ,
	                                                      '');
                                                                                                   
     self.board_action_indicator               := ' ';                                                                         
     self.date_first_seen                      := infile(ftype = 'available')[1].fdate;                                                                    
     self.date_last_seen                       := infile(ftype = 'available')[1].fdate;                                                                     
     self.education_continuing_education        := '';             
     self.orig_addr_3                          := l.ADDRESS3;                                                                            
     self.education_1_school_attended          :=  map (  l.INSTITUTION <> '' and l.LOCATION <> '' => trim( l.INSTITUTION) + ' (' +  trim(l.LOCATION) + ')',
		                                              l.INSTITUTION <> '' and l.LOCATION = '' => trim( l.INSTITUTION),
																									l.INSTITUTION = '' and l.LOCATION <> '' => trim(l.LOCATION),
																									'') [ 1..30];
																									
			self := l;
			self := [];
                                                                                      
   end;                                                                                                                                                                                                                                   
                                                                                                                            
                                                                                                                            
   	dWithDentist := project( File_MN.dentist, map2dent(left));
                                                                                                                         
                                                                                                                            
 
 
Prof_License.Layout_proLic_in map2engr( File_MN.engr l) := transform


  self.profession_or_board                                := 'Engineers';
  self.business_flag                            := 'N';
  self.source_st                                 := 'MN';
  self.orig_name                                 := l.FNAME+' '+l.LNAME;
 // self.company_name                         := l.BUSNAME;
  self.orig_addr_1                               := l.ADDRESS1;
  self.orig_addr_2                               := l.ADDRESS2;
  self.orig_city                                 := l.CITY;
  self.orig_st                                   := l.STATE;
  self.orig_zip                                  := StringLib.stringfilter(l.ZIPCODE, '1234567890')[1..9];
  self.sex                                       := ' ';
  self.license_obtained_by                       := ' ';
  self.county_str                                := getcounty(l.COUNTY);
  self.country_str                               := ' ';
  self.issue_date                                := dateconv(trim(l.OLD));
  self.last_renewal_date                         := ' ';
  self.name_order                                := 'FML';
  self.vendor                                    := 'State of Minnesota - License Listing Unit';
  self.orig_former_name                          := ' ';
  self.status                                    := ' ';
  self.license_number                            := l.LICNUM;
  self.phone                                     := ' ';
  self.dob                                  := ' ';
  self.license_type                              := l.LICTYPE;
  self.board_action_indicator                    := ' ';
  self.date_first_seen                           := infile(ftype = 'available')[1].fdate;
  self.date_last_seen                            := infile(ftype = 'available')[1].fdate;
  self.misc_practice_type                        := l.DISCIPLINE;
  self.misc_other_id                             := '';
  self.misc_other_id_type                        := '' ;
  self.additional_licensing_specifics            := '';
  self.expiration_date                           := dateconv(trim(l.EXPDATE));
		self := l;
			self := [];
end;

   	dWithEngineer := project( File_MN.engr, map2engr(left));
		
		
Prof_License.Layout_proLic_in map2vet( File_MN.vet l) := transform


  self.profession_or_board                                      := 'Veterinarians';
  self.business_flag                                  := 'N';
  self.source_st                                       := 'MN';
  self.orig_name                                       := l.FirstName+ l.MiddleName + l.LastName ;
  self.company_name                               := ' ';
  self.orig_addr_1                                     := l.Addr1;
  self.orig_addr_2                                     := l.Addr2;
  self.orig_city                                       := l.City;
  self.orig_st                                         := l.St;
  self.orig_zip                                        := StringLib.Stringfilter(l.Zip, '1234567890')[1..9];
  self.sex                                             := ' ';
  self.license_obtained_by                             := ' ';
  self.county_str                                      := getcounty(StringLib.StringFilterout(l.County,'"'));
  self.country_str                                     := '';
  self.expiration_date                                 := dateconv(trim(l.IssueDate));
  self.issue_date                                      := dateconv(trim(l.ExpireDate));
  self.last_renewal_date                               := ' ';
  self.name_order                                      := 'FML';
  self.vendor                                          := 'State of Minnesota - License Listing Unit';
  self.orig_former_name                                := ' ';
  self.status                                          := l.LicenseS;
  self.license_number                                  := l.Licen;
  self.phone                                           := ' ';
  self.dob                                        := ' ';
  self.license_type                                    := 'Veterinarian';
  self.board_action_indicator                          := ' ';
  self.date_first_seen                                 := infile(ftype = 'available')[1].fdate;
  self.date_last_seen                                  := infile(ftype = 'available')[1].fdate;
  //self.education_1_degree                              := l.Degree;
		self := l;
			self := [];
end;

   	dWithVet := project( File_MN.vet, map2vet(left));
		
		
		dMNAll := dWithArchitect + dWithBLDG  + dWithDentist + dWithEngineer + dWithVet;
		

		
		 dMNAllSF := Sequential( FileServices.ClearSuperfile( '~thor_data400::in::prolic::mn::all_available'),

                              Output( dMNAll,,'~thor_data400::in::prolic::mn::all_available_'+infile(ftype = 'available')[1].fdate,overwrite),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::mn::all_available','~thor_data400::in::prolic::mn::all_available_'+infile(ftype = 'available')[1].fdate)
															 );
Prof_License.Layout_proLic_in map2phy( 	File_MN.phy l ) := transform

lic_status_desc(string lic_status) :=  case ( lic_status,                                                      
                          'CI' =>  'CANCELLED INACTIVE'   ,                    
                          'CR' => 'CRIMINAL REVOCATION'  ,                     
                          'CX' => 'CONDITIONED (INACTIVE)'   ,                 
                          'CZ' => 'CONDITIONED (PENDING CANCELLATION)'   ,      
                          'FI' => 'FORMALLY INACTIVE'  ,                       
                          'LA' => 'LICENSE ACTIVE'  ,                          
                          'LC' => 'LICENSE CONDITIONED'   ,                    
                          'LD' => 'DECEASED'    ,                              
                          'LE' => 'EMERITUS STATUS'     ,                      
                          'LI' => 'LICENSE INACTIVE'   ,                       
                          'LR' => 'LICENSE REVOKED'   ,                        
                          'LS' => 'LICENSE SUSPENDED'   ,                      
                          'RI' => 'RESIGNED INACTIVE'    ,                     
                          'RO' => 'RESIGNED UNDER ORDER INACTIVE'  ,           
                          'RS' => 'RESTRICTED (ACTIVE)'     ,                  
                          'RX' => 'RESTRICTED (INACTIVE)'   ,                  
                          'RZ' => 'RESTRICTED (PENDING CANCELLATION)' ,        
                          'VS' => 'VOLUNTARILY SURRENDERED' ,'')   ;           
                                                                               
                                                                               
														 
 self.profession_or_board      := 'Phys./Phys. Assist.';                                                    
 self.business_flag           := 'N';                                                                      
 self.source_st                := 'MN';                                                                     
 self.orig_name                :=  trim(l.first_name)+ ' ' + trim(l.middle_name) +  ' ' +  trim(l.last_name);              
 self.company_name        := ' ';                                                                      
 self.orig_addr_1              := l.address_line1;                                                               
 self.orig_addr_2              := l.address_line1;                                                               
 self.orig_city                := l.CITY;                                                                   
 self.orig_st                  := l.STATE;                                                                  
 self.orig_zip                 := StringLib.stringfilter(l.zip, '1234567890')[1..9];                    
 self.sex                      := l.GENDER;                                                                 
 self.license_obtained_by      := ' ';                                                                      
 self.county_str               := trim(l.COUNTY);                                                           
 self.country_str              := l.COUNTRY;                                                                
 self.expiration_date          := dateconv(trim(l.expire_date));                                              
 self.issue_date               := dateconv(trim(l.grant_date));                                                  
 self.last_renewal_date        := ' ';                                                                      
 self.name_order               := 'FML';                                                                    
 self.vendor                   := 'Minnesota Board of Medical Practice';                                    
 self.orig_former_name         := ' ';                                                                      
 self.status                   := regexreplace('LICENSE ' , Stringlib.Stringtouppercase(lic_status_desc(l.license_status)),  '');            
 self.license_number           := l.license_nbr;                                                                 
 self.phone                    := ' ';                                                                      
 self.dob                 := l.BirthYear;                                                              
 self.license_type             := map ( l.licenseType = 'PY' =>  'Physician' ,                                         
                                        l.licenseType = 'PA' => 'Physician Assistant' ,                               
                                  l.licenseType);                                                                
 self.board_action_indicator  := if ( trim(l.disciplined) <> '', trim(l.disciplined)[1] , '' ) ;    
 self.date_first_seen         := infile(ftype = 'physician')[1].fdate;                                                            
 self.date_last_seen          := infile(ftype = 'physician')[1].fdate;                                                            
 self.orig_addr_3             := l.address_line3;                                                                
 self.misc_email              := l.email;                                                                  
 self.education_1_degree      := l.degree;                                                                  
 self.misc_web_site           := '';                                    
 self.status_effective_dt     := '';                                       
self := l;
			self := [];
end;

   	dMNPhy := project( File_MN.phy, map2phy(left));
		
		dMNPhySF := Sequential(   
                            FileServices.ClearSuperfile( '~thor_data400::in::prolic::mn::phys'),

                             Output( dMNPhy,,'~thor_data400::in::prolic::mn::physician_'+ut.GetDate,overwrite),
														FileServices.AddSuperfile( '~thor_data400::in::prolic::mn::phys','~thor_data400::in::prolic::mn::physician_'+ut.GetDate)
															 ) ; 
		
input := map ( count(infile(ftype = 'physician')) = 1 and count(infile) = 1 => dMNPhy, 
               count(infile(ftype = 'available')) = 1 and count(infile) = 1  => dMNAll,
								  dMNPhy + dMNAll );

dout := map ( count(infile(ftype = 'physician')) = 1 and count(infile) = 1 => dMNPhySF, 
               count(infile(ftype = 'available')) = 1 and count(infile) = 1  => dMNAllSF,
								  Sequential(dMNPhySF , dMNAllSF) );
															 
outfile := proc_clean_all(input,'MN').cleanout;

export buildprep := Sequential(dout, 
                   FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_mn'),
                        if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_mn_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_mn_old')),
								        if ( FileServices.FileExists( '~thor_data400::in::prolic_mn_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_mn_old')),
                        FileServices.RenameLogicalfile( '~thor_data400::in::prolic_mn','~thor_data400::in::prolic_mn_old'),   
                        
											output( outfile,,'~thor_data400::in::prolic_mn',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
								
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_mn'),
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_mn_old'),

	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		
