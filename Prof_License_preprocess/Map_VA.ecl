import  Prof_License,ut,Std;
EXPORT Map_VA(dataset({string ftype,string fdate})infile) := module

Prof_License.Layout_proLic_in map2va( Files_VA_Raw.health l) := transform

self.profession_or_board                   := 'Health';                                   
self.business_flag               := 'N';                                     
self.source_st                    := 'VA';                                         
self.license_type                 := l.profession;                              
self.orig_name                    := trim(l.name)[1..80];                          
self.company_name            := ' ';                                  
self.orig_addr_1                  := trim(l.address1)[1..80];                    
self.orig_addr_2                  := l.address2;                                 
self.orig_city                    := l.city;                                       
self.orig_st                      := l.st;                                           
self.orig_zip                     := StringLib.stringfilter(l.zip, '1234567890');   
self.sex                          := ' ';                                                
self.license_obtained_by          := ' ';                                
self.county_str                   := ' ';                                         
self.country_str                  := ' ';                                        
self.expiration_date              := fSlashedMDYtoCYMD(l.expiration_date);    
self.issue_date                   := fSlashedMDYtoCYMD(l.issue_date);              
self.last_renewal_date            := ' ';                                  
self.name_order                   := 'FML';                                       
self.vendor                       := 'Virginia Department of Health Professions';           
self.orig_former_name             := ' ';                                   
self.status                       := map ( l.expired = 'N' =>  'Active' ,            
                                           l.expired = 'Y' => 'Expired' , '');       
                                                                
self.license_number              := l.license_number;                        
self.phone                       := ' ';                                              
self.dob                    := ' ';                                           
self.date_first_seen             := infile(ftype = 'health')[1].fdate;                         
self.date_last_seen              := infile(ftype = 'health')[1].fdate;                          
self := [];
	end;


dVAMed := project( Files_VA_Raw.health  ,map2va(left)) ;
	
	doutmed := Sequential( Output( dVAMed,,'~thor_data400::in::prolic::va::health_'+Std.Date.Today(),overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::va::health'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::va::health','~thor_data400::in::prolic::va::health_'+Std.Date.Today())
															 );
															 
//All Available

getbddesc(string code) := function

return case( code,

'0211' =>   'Real Estate Proprietary School           ',             
'0212' =>   'Rental Location Agency                   ',             
'0225' =>   'A Real Estate Active Associate Brokers   ',             
'0226' =>   'B Real Estate Firms-Branch Offices       ',             
'0230' =>   'Real Estate Course Instructors           ',             
'0231' =>   'Fair Housing Instructor                  ',             
'0232' =>   'Fair Housing Certificate                 ',             
'0234' =>   'Fair Housing School                      ',             
'0250' =>   '1 Real Estate Condominium                ',             
'0401' =>   'APELSCIDLA Architect                     ',             
'0402' =>   'APELSCIDLA Professional Engineer         ',             
'0403' =>   'APELSCIDLA Land Surveyor                 ',             
'0404' =>   'APELSCIDLA Land Surveyors B              ',             
'0405' =>   'APELSCIDLA Professional Corporation      ',             
'0406' =>   'APELSCIDLA Landscape Architects          ',             
'0407' =>   'APELSCIDLA Business Entity               ',             
'0410' =>   'APELSCIDLA Professional Corp. Branch     ',             
'0411' =>   'APELSCIDLA Bus. Entity Branch Office     ',             
'0412' =>   'APELSCIDLA Interior Designer             ',             
'0413' =>   'APELSCIDLA Profess. Limited Liability Co.',             
'0701' =>   'Harbor Branch Pilots                     ',             
'0702' =>   'Harbor Branch Pilots Limited             ',             
'1101' =>   'Optician                                 ',             
'1200' =>   'Cosmetology Temp Permit                  ',             
'1201' =>   'Cosmetologists                           ',             
'1202' =>   'Cosmetology Salons                       ',             
'1204' =>   'Cosmetology Instructors                  ',             
'1205' =>   'Cosmetology School                       ',             
'1206' =>   'Nail Technicians                         ',             
'1207' =>   'Nail Technician Instructors              ',             
'1208' =>   'Nail Technician Salons                   ',             
'1209' =>   'Nail Technician School                   ',             
'1210' =>   'Temporary Nail Technician                ',             
'1211' =>   'Temporary Cosmetologist Instructor       ',             
'1212' =>   'Temporary Nail Instructor                ',             
'1214' =>   'Wax Technician                           ',             
'1215' =>   'Wax Technician Instructor                ',             
'1218' =>   'Waxing Salon                             ',             
'1219' =>   'Waxing School                            ',             
'1222' =>   'Hair Braiders                            ',             
'1223' =>   'Hair Braiding Salons                     ',             
'1224' =>   'Hair Braiding Schools                    ',             
'1231' =>   'Tattooer                                 ',             
'1232' =>   'Tattoo Parlor                            ',             
'1234' =>   'Apprentice Tattooer                      ',             
'1300' =>   'Barber Temporary Permit                  ',             
'1301' =>   'Barbers                                  ',             
'1302' =>   'Barber Teachers                          ',             
'1303' =>   'Barber School                            ',             
'1304' =>   'Barber Shop                              ',             
'1312' =>   'Barber Teacher Temp Permit               ',             
'1601' =>   'Polygraph Licensee                       ',             
'1602' =>   'Polygraph Intern                         ',             
'1901' =>   'Water I Operators-Class I                ',             
'1902' =>   'Water II Operators-Class II              ',             
'1903' =>   'Water III Operators-Class III            ',             
'1904' =>   'Water IV Operators-Class IV              ',             
'1909' =>   'Waste water I Operators-Class I          ',             
'1910' =>   'Waste water II Operators-Class II        ',             
'1911' =>   'Waste water III Operators-Class III      ',             
'1912' =>   'Waste water IV Operators-Class IV        ',             
'1917' =>   'Water V Operators-Class V                ',             
'1918' =>   'Water IV Operators-Class VI              ',             
'1919' =>   'Water VI Operator Restricted             ',             
'2101' =>   'Hearing Aid Specialists                  ',             
'2102' =>   'Hearing Aid Specialist Temp. Licensee    ',             
'2705' =>   'A Class A Contractor                     ',             
'2710' =>   'Tradesman Combined Licenses              ',             
'2717' =>   'Tradesman Backflow Operator              ',             
'2801' =>   'Geologist                                ',             
'2905' =>   'Auctioneer Individuals                   ',             
'2906' =>   'Auctioneer Firms                         ',             
'2907' =>   'Auctioneer Individuals                   ',             
'2908' =>   'Auctioneer Firms                         ',             
'3301' =>   'Asbestos Worker                          ',             
'3302' =>   'Asbestos Supervisors                     ',             
'3303' =>   'Asbestos Inspectors                      ',             
'3304' =>   'Asbestos Management Planners             ',             
'3305' =>   'Asbestos Project Designers               ',             
'3306' =>   'Asbestos Contractors                     ',             
'3309' =>   'Asbestos Project Monitor                 ',             
'3320' =>   'Asbestos Worker Training                 ',             
'3321' =>   'Asbestos Worker Refresher                ',             
'3322' =>   'Asbestos Supervisor Training             ',             
'3323' =>   'Asbestos Supervisor Refresher            ',             
'3324' =>   'Asbestos Inspector Training              ',             
'3325' =>   'Asbestos Inspector Refresher             ',             
'3326' =>   'Asbestos Manager Training                ',             
'3327' =>   'Asbestos Manager Refresher               ',             
'3328' =>   'Asbestos Project Designer Training       ',             
'3329' =>   'Asbestos Project Designer Refresher      ',             
'3333' =>   'Asbestos Analytical Lab                  ',             
'3335' =>   'Asbestos Project Monitor Training        ',             
'3336' =>   'Asbestos Project Monitor Refresher Training',           
'3337' =>   'Asbestos 40hr Project Monitor Initial    ',             
'3351' =>   'Lead Abatement Workers                   ',             
'3353' =>   'Lead Abatement Supervisors               ',             
'3355' =>   'Lead Inspector                           ',             
'3356' =>   'Lead Risk Assessor                       ',             
'3357' =>   'Lead Project Designer                    ',             
'3358' =>   'Lead Abatement Contractor                ',             
'3361' =>   'Lead Worker Initial Course               ',             
'3363' =>   'Supervisor-Initial                       ',             
'3365' =>   'Inspector-Initial                        ',             
'3366' =>   'Risk Assessor-Initial                    ',             
'3367' =>   'Project Designer-Initial                 ',             
'3371' =>   'Lead Worker Refresher Course             ',             
'3373' =>   'Lead Supervisor Refresher Course         ',             
'3375' =>   'Inspector-Refresher                      ',             
'3376' =>   'Risk Assessor-Refresher                  ',             
'3377' =>   'Project Designer-Refresher               ',             
'3380' =>   'Home Inspector                           ',             
'3401' =>   'Soil Scientist                           ',             
'3402' =>   'Wetland Delineators                      ',             
'4001' =>   'C Appraiser Certified Residential        ',                  
'4002' =>   'I Appraiser Instructor                   ',             
'4008' =>   'A Appraiser Association                  ',                  
'4101' =>   'Wrestler                                 ',             
'4102' =>   'Boxer                                    ',             
'4103' =>   'Manager                                  ',             
'4105' =>   'Trainer, Second, Cutman               ',          
'4106' =>   'Promoter                                 ',             
'4111' =>   'Boxing and Wrestling-Fed Id Card Holder  ',             
'4605' =>   '1 Waste Management Operator Class I      ',             
'4901' =>   'Cemetery Company                         ',             
'4902' =>   'Cemetery                                 ',             
'4903' =>   'Cemetery Sales Personnel                 ',             
'');
end;

Prof_License.Layout_proLic_in map2vaall( Files_VA_Raw.all_available l) := transform

newbdcode := intformat( (integer)l.BOARD, 2,1) + intformat( (integer)l.OCCUPATION,2,1);

 self.profession_or_board               := getbddesc( newbdcode);                              
 self.license_type             := getbddesc( newbdcode);                                                                                                                                                                                                         
 self.business_flag           := if ( l.INDIVIDUAL_NAME = ''  and  l.BUSINESS_NAME <> '' , 'Y','N' );                                                                                                                                        
                                                                                                                                                                                                                                    
 self.source_st                := 'VA';                                                                                                                                                                                                            
 self.orig_name                := l.INDIVIDUAL_NAME;                                                                                                                                                                                               
 self.company_name             := l.BUSINESS_NAME[1..100];                                                                                                                                                                                 
 self.orig_addr_1              := l.FIRST_LINE_ADDRESS;                                                                                                                                                                                          
 self.orig_addr_2              := l.SECOND_LINE_ADDRESS[1..80];                                                                                                                                                                                  
 self.orig_city                := l.CITY;                                                                                                                                                                                                          
 self.orig_st                  := l.STATE[1..2];                                                                                                                                                                                                     
 self.orig_zip                 := if ( l.FIVE_DIGIT_ZIP_CODE <> '', StringLib.stringfilter(l.FIVE_DIGIT_ZIP_CODE +  l.ZIP_CODE_EXTENSION, '0123456789')  ,                                                                                   
                                                                    StringLib.stringfilter(l.POSTAL_CODE, '0123456789')
																			);                                                                                                                                                                                     
 self.sex                      := ' ';                                                                                                                                                                                                                   
 self.license_obtained_by      := ' ';                                                                                                                                                                                                   
 self.country_str              := l.COUNTRY;                                                                                                                                                                                                     
 self.expiration_date          := dateconv(trim(l.EXPIRATION_DATE));                                                                                                                                                                          
 self.issue_date               := dateconv(l.CERTIFICATION_DATE);                                                                                                                                                                         
 self.last_renewal_date        := ' ';                                                                                                                                                                                                     
 self.name_order               := if ( l.INDIVIDUAL_NAME <> '', 'FML'   ,'');                                                                                                                                                                      
 self.vendor                   := 'Dept of Professional & Occupational Reg';                                                                                                                                                                          
 self.orig_former_name         := ' ';                                                                                                                                                                                                      
 self.license_number           := trim(l.BOARD) +  trim(l.OCCUPATION) +  trim(l.CERTIFICATE_NO);                                                                                                        
 self.phone                    := ' ';                                                                                                                                                                                                                 
 self.dob                 := ' ';                                                                                                                                                                                                              
 self.orig_addr_3              := l.P_O_BOX_NO;                                                                                                                                                                                                  
 self.county_str               := l.PROVINCE;                                                                                                                                                                                                     
 self.date_first_seen          := infile(ftype = 'available')[1].fdate;                                                                                                                                                                                            
 self.date_last_seen           := infile(ftype = 'available')[1].fdate;                                                                                                                                                                                             
 self.status                    := if ( dateconv(trim(l.EXPIRATION_DATE)) > infile(ftype = 'available')[1].fdate , 'Active'   , '');                                                                                                                                
                                                                                                                                                                                                                                 
    
self := [];
	end;


dVAAll := project( Files_VA_Raw.all_available  ,map2vaall(left)) (profession_or_board <> '') ;
	
	doutAll := Sequential( Output( dVAAll,,'~thor_data400::in::prolic::va::all_available_'+Std.Date.Today(),overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::va::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::va::all_available','~thor_data400::in::prolic::va::all_available_'+Std.Date.Today())
	                    );
											
											
doutfinal := map ( count(infile(ftype = 'health')) = 1 and count(infile) = 1 => doutmed, 
               count(infile(ftype = 'available')) = 1 and count(infile) = 1  => doutAll,
								  Sequential(doutmed , doutAll) );


									 
dinput2clean := map ( count(infile(ftype = 'available')) = 1 and count(infile) = 1  =>  dVAAll,
                   count(infile(ftype = 'health')) = 1 and count(infile) = 1 => dVAMed,
									 dVAMed + dVAAll);

outfile := proc_clean_all(dinput2clean,'VA').cleanout;

export buildprep := Sequential(doutfinal, 
                              FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_va'),
                              if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_va_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_va_old')),
							        	       if ( FileServices.FileExists( '~thor_data400::in::prolic_va_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_va_old')),
                              FileServices.RenameLogicalfile( '~thor_data400::in::prolic_va','~thor_data400::in::prolic_va_old'),                         
											       output( outfile,,'~thor_data400::in::prolic_va',compressed,overwrite),
                            FileServices.StartSuperfiletransaction(),												 
					    							 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_va'),
				    								 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_va_old'),
				   							   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		

