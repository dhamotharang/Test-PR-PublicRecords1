import lib_StringLib,Prof_License,std;



EXPORT Map_MI(dataset({string ftype,string fdate})infile) := MODULE

/* Trade License */
inTL := File_MI.TradeLic;

string curdate := (STRING8) STD.Date.Today();

Prof_License.Layout_proLic_in map2TL( inTL l) := transform

self.date_first_seen      := infile(ftype = 'TradeLic')[1].fdate;                                                                          
self.date_last_seen       := infile(ftype = 'TradeLic')[1].fdate;                                                                           
self.source_st            := 'MI';                                                                                          
self.vendor               := 'Michigan Dept of Consumer and Indus';                                                            
self.orig_addr_1          := l.Address_1;                                                                                   
self.orig_name            := StringLib.Stringfilterout(trim(l.LastName) + ' '+ trim(l.FirstName),'\'');                                              
self.name_order           := 'LFM';                                                                                        
self.profession_or_board           := 'Trade';                                                                                      
self.license_number       := l.LICENSE; 
//self.issue_date                := if ( trim(l.Date_Issued) <> '' , fSlashedMDYtoCYMD(trim(l.Date_Issued)), '');                                                                                 
self.expiration_date      := if ( trim(l.Date_Expired) <> '' , fSlashedMDYtoCYMD(trim(l.Date_Expired)), '');   
self.orig_addr_2          :=trim(l.City)+' '+StringLib.Stringfilter(l.Zip,'0123456789');                          
self.status               := StringLib.Stringfilterout(l.Status,'\'');  
//self.Phone                := trim(l.Phone1);                                                        
self := [];
end;

dMITrade := project(  inTL,  map2TL(left));


dMITradeSF := Sequential( 
                       if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::mi::trade_license'),FileServices.CreateSuperfile('~thor_data400::in::prolic::mi::trade_license'), 
                                                                                                              FileServices.ClearSuperfile( '~thor_data400::in::prolic::mi::trade_license')),

                        output(dMITrade,,'~thor_data400::in::prolic::mi::trade_license_'+curdate,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::mi::trade_license','~thor_data400::in::prolic::mi::trade_license_'+curdate),
											   FileServices.FinishSuperfiletransaction()
											 );
											 
											 
//Health License
//#########################################################################################
getboard( string2 code) := case ( code, '16'  =>    'Audiology                       ',  
'23'  =>    'Chiropractors                   ',
'26'  =>    'Athletic Trainer                   ',
'29'  =>    'Dentistry                       ',
'32'  =>    'EMS-Personnel                   ',
'41'  =>    'Marriage and Family Therapy     ',
'43'  =>    'Medicine                        ',
'44'  =>    'Respiratory Care                ',
'47'  =>    'Nursing                         ',
'48'  =>    'Nursing Home Administrators                         ',
'49'  =>    'Optometry                        ',
'51'  =>    'Osteopathic Medicine & Surgery                        ',
'52'  =>    'Occupational Therapists                        ',
'53'  =>    'Pharmacy                        ',
'54'  =>    'Acupuncture                        ',
'55'  =>    'Physical Therapy                ',
'56'  =>    'Physicians Assistants           ',
'59'  =>    'Podiatric Medicine & Surgery    ',
'63'  =>    'Psychology                      ',
'64'  =>    'Counselors                      ',
'67'  =>    'Sanitarians                     ',
'68'  =>    'Social Workers                  ',
'69'  =>    'Veterinary Medicine             ',
'71'  =>    'Speech-Language Pathologist     ',
'75'  =>    'Massage Therapist     '
,'' );

get_lictype(string code) := case ( code,'1600' =>   'Audioloist                                   ',     
'1601' =>   'Audiologist-Limited                          ',     
'2300' =>   'Chiropractor                                 ',     
'2303' =>   'Chiropractor - Educational Limited           ',     
'2600' =>   'Athletic Trainer          ',     
'2900' =>   'Dentist                                      ',     
'2901' =>   'Dentist - Clinical Academic Limited          ',     
'2902' =>   'Dentist - Nonclinical Limited                ',     
'2903' =>   'Dentist - Educational Limited                ',     
'2904' =>   'Dentist - Limited I                          ',     
'2906' =>   'Dentist - Special Volunteer                  ',     
'2908' =>   'Dental Hygenist - Clinical Academic          ',     
'2909' =>   'Dental Hygenist - Educational Limited        ',     
'2911' =>   'Dental Hygenist - Nonclinical Limited        ',     
'2912' =>   'Dental Hygenist                              ',     
'2914' =>   'Dental Assistant - Clinical Academic         ',     
'2915' =>   'Dental Assistant - Educational Limited       ',     
'2917' =>   'Dental Assistant - Nonclinical Limited       ',     
'2918' =>   'Dental Assistant                             ',     
'2920' =>   'Prosthodontist                               ',     
'2921' =>   'Endodontist                                  ',     
'2922' =>   'Oral Surgeon                                 ',     
'2923' =>   'Orthodontist                                 ',     
'2924' =>   'Pediatric Dentist                            ',     
'2925' =>   'Periodontist                                 ',     
'2926' =>   'Oral Pathologist                             ',     
'2932' =>   'Dentist - Special Circumstances              ',     
'3201' =>   'Medical First Responder                      ',     
'3202' =>   'IC - Medical First Respnder                  ',     
'3211' =>   'EMT                                          ',     
'3212' =>   'IC-EMT                                       ',     
'3214' =>   'EMT Specialist                               ',     
'3215' =>   'IC - EMT Specialist                          ',     
'3221' =>   'Paramedic                                    ',     
'3222' =>   'IC - Paramedic                               ',     
'4100' =>   'Marriage & Family Therapist                  ',     
'4103' =>   'Marriage & Family Therapist - Educ.LTD       ',     
'4301' =>   'Medical Doctor - Clinical Academic           ',     
'4302' =>   'Medical Doctor - Limited                     ',     
'4303' =>   'Medical Doctor - Educational Limited         ',     
'4305' =>   'Medical Doctor                               ',     
'4310' =>   'Medical Doctor - Special Circumstances       ',     
'4311' =>   'MD - Ed Ltd Special Circumstances            ',     
'4312' =>   'Medical Doctor - Special Volunteer           ',     
'4400' =>   'Respiratory Therapist                        ',     
'4401' =>   'Respiratory Therapist - Temporary            ',     
'4700' =>   'LPN                                          ',     
'4701' =>   'LPN - Clinical Academic Limited              ',     
'4702' =>   'LPN - Nonclinical Academic                   ',  
'4703' =>   'LPN                    ',        
'4704' =>   'RN                                ',     
'4706' =>   'LPN - Special Volunteer                                           ',     
'4711' =>   'RN - Clinical Academic Limited               ',     
'4712' =>   'RN - NonClinical Academic Limited            ',     
'4713' =>   'RN - Provisional                             ',     
'4714' =>   'RN - Limited                                 ',     
'4715' =>   'RN - Temporary                               ',     
'4716' =>   'LPN - Special Circumstances                  ',     
'4717' =>   'RN - Special Circumstances                   ',  
'4718' =>   'RN - Special Volunteer                   ',      
'4720' =>   'Nurse Anesthetist                            ',     
'4721' =>   'Nurse Midwife                                ',     
'4723' =>   'Nurse Practitioner  - Special Volunteer                          ',     
'4769' =>   'Designated Instructor                           ',     
'4770' =>   'Train the Trainer                           ',     
'4800' =>   'Nursing Home Administrator                   ',     
'4803' =>   'NHA - Special Circumstances                  ',     
'4900' =>   'Optometrist                                  ',     
'4901' =>   'Optometrist - Clinical Academic              ',     
'4902' =>   'Optometrist - NonClinical Limited            ',     
'4904' =>   'Optometrist - Limited                        ',     
'4910' =>   'DPA & TPA Certification                      ',     
'4911' =>   'DPA Certification                            ',     
'5100' =>   'Osteopathic Physician                        ',     
'5101' =>   'Osteopathic - Clinical Academic              ',     
'5102' =>   'Osteopathic - NonClinical Limited            ',     
'5103' =>   'Osteopathic - Educational Limited            ',     
'5109' =>   'Osteo Physician - Special Volunteer          ',     
'5200' =>   'Occupational Therapist                       ',     
'5210' =>   'Occupational Therapy Assistant               ',     
'5300' =>   'Pharmacist - Limited                         ',     
'5302' =>   'Pharmacist                                   ',     
'5303' =>   'Pharmacy                                     ',     
'5304' =>   'Pharmacist - Ed Ltd -5                       ',     
'5306' =>   'Pharmacist - Perceptor                       ',     
'5307' =>   'Pharmacist - Temporary                       ',     
'5308' =>   'CS - Pharmacist                              ',     
'5309' =>   'CS - Analytical Labs                         ',     
'5310' =>   'CS - Schedule Lab                            ',     
'5311' =>   'Drug Treatment Program Prescriber            ',     
'5312' =>   'CS - Research Lab                            ',     
'5313' =>   'CS - Sodium Pentobarbital Facility           ',     
'5316' =>   'Mfr/Wholesaler                               ',     
'5317' =>   'Clinical Thermometer Certification           ',     
'5318' =>   'Drug Control - Location                      ',     
'5321' =>   'CS - I                                       ',     
'5322' =>   'CS - Facility                                ',     
'5324' =>   'Pharmacist - Ed Ltd -2                       ',     
'5325' =>   'CS - 2                                       ',     
'5326' =>   'CS - 3                                       ',     
'5330' =>   'CS - 2 Optometry                             ',     
'5331' =>   'Pharmacist - Special Circumstances           ',     
'5340' =>   'Pharmacy Technician          ',     
'5341' =>   'Pharmacy Technician Limited           ',     
'5342' =>   'Pharmacy Technician Temporary           ',     
'5344' =>   'CS - Hospital Automated Device          ',     
'5345' =>   'CS - Nursing Home Automated Device           ',     
'5346' =>   'Non - CS Automated Device           ',     
'5400' =>   'Acupuncturist                                ',     
'5500' =>   'Physical Therapist                           ',     
'5501' =>   'Physical Therapist - Clinical Academic       ',     
'5502' =>   'Physical Therapist - Nonclinical Limited     ',     
'5504' =>   'Physical Therapist - Limited                 ',     
'5505' =>   'Physical Therapist - Temporary               ',     
'5507' =>   'Physical Therapist Assistant                 ',     
'5508' =>   'Physical Therapist Assistant - Limited       ',     
'5506' =>   'Physical Therapist - Special Circumstances   ',     
'5600' =>   'Physician Assistant                          ',     
'5601' =>   'Physician Assistant - Clinical Academic      ',     
'5602' =>   'Physician Assistant - Nonclinical LTD        ',     
'5604' =>   'Physician Assistant - Limited                ',     
'5605' =>   'Physician Assistant - Temporary              ',     
'5900' =>   'Podiatrist                                   ',     
'5901' =>   'Podiatrist - Clinical Academic               ',     
'5902' =>   'Podiatrist - Noncilincal Limited             ',     
'5903' =>   'Podiatrist - Educational Limited             ',     
'5904' =>   'Podiatrist - Limited                         ',     
'5905' =>   'Podiatrist - Temporary                       ',     
'5906' =>   'Podiatrist - Educational Preceptoship        ',     
'5909' =>   'Podiatrist - Special Volunteer               ',     
'6300' =>   'Psychologist                                 ',     
'6303' =>   'Psychologist - Doctoral Educ Ltd             ',     
'6305' =>   'Masters Ltd Psychologist - Educ Ltd         ',     
'6310' =>   'Masters Ltd Psychologist                    ',     
'6400' =>   'Professional Counselor                       ',     
'6403' =>   'Prof. Counselor - Educ LTD                   ',     
'6700' =>   'Sanitarian                                   ',     
'6701' =>   'Sanitarian - Clinical Academic               ',     
'6702' =>   'Sanitarian - Nonclinical Academic            ',     
'6704' =>   'Sanitarian - Limited                         ',     
'6800' =>   'Masters Social Worker                        ',     
'6801' =>   'Masters Ltd Social Worker                    ',     
'6802' =>   'Masters Social Worker-Special                    ',     
'6810' =>   'Bachelors Social Worker                      ',   
'6811' =>   'Bachelors Ltd Social Worker                      ',     
'6820' =>   'Social Service Techinician                   ',     
'6821' =>   'Social Service Ltd Techinician               ',     
'6830' =>   'MSW Macro Specialty               ',     
'6850' =>   'MA Social Worker - Special Circumstances     ',     
'6860' =>   'BA Social Worker - Special Circumstances     ',     
'6880' =>   'MastersSocialWorker-Temp Military     ',     
'6900' =>   'Veterinarian                                 ',     
'6901' =>   'Veterinarian - Clinical Academic Limited     ',     
'6902' =>   'Veterinarian - Nonclinical Academic          ',     
'6903' =>   'Veterinarian - Educational Limited           ',     
'6904' =>   'Veterinarian - Limited                       ',     
'6905' =>   'Veterinarian - Temporary                     ',     
'6910' =>   'Veterinary Tech                              ',     
'6914' =>   'Veterinary Tech - Limited                    ',     
'6916' =>   'Veterinarian - Special Circumstances         ',     
'6917' =>   'Veterinary Tech - Special Circumstances      ',     
'6919' =>   'Veterinarian - Special Volunteer      ',     
'7100' =>   'Speech-Language Pathologist                  ',     
'7101' =>   'Speech-Language Pathologist Limited          ',     
'7102' =>   'Speech-Language Pathologist Ed Limited       ',    
'7501' =>   'Massage Therapist       ', '' );

//############################################################################################################


//Occupational License
//DF-24196

getOccboard( string2 code) := case ( code, '11'  =>    'Accountancy                       ',  
'12'  =>    'Real Estate Appraisers                   ',
'13'  =>    'Architects                       ',
'17'  =>    'Barbers                   ',
'24'  =>    'Collection Practices     ',
'27'  =>    'Cosmetology                        ',
'35'  =>    'Hearing Aid Dealers                ',
'39'  =>    'Landscape Architects                         ',
'40'  =>    'Professional Surveyors                ',
'61'  =>    'Personnel Agency           ',
'62'  =>    'Professional Engineers    ',
'65'  =>    'Real Estate                      '
,'' );





get_Occlictype(string code) := case ( code,'1101' =>   'Registered Accountant                                   ',     
'1102' =>   'Licensed Accountant                         ',     
'1103' =>   'Accountancy Firm                                 ',     
'1200' =>   'Limited Real Estate Appraiser           ',     
'1201' =>   'State Licensed Real Estate                                      ',     
'1202' =>   'Certified General Real Estate          ',     
'1203' =>   'Certified Residential RE Appraiser                ',     
'1204' =>   'Temporary Practice Permit                ',     
'1205' =>   'Education Provider                          ',     
'1206' =>   'Appraisal Management Company                  ',     
'1300' =>   'Architect          ',     
'1700' =>   'Barber        ',     
'1702' =>   'Barber Instructor        ',     
'1703' =>   'Barber Student                              ',     
'1704' =>   'Barber Shop         ',     
'1708' =>   'Barber Student Instructor       ',     
'1709' =>   'Barber College - Private       ',     
'2400' =>   'Agency - Non-Owner Manager                             ',     
'2401' =>   'Non-Owner Manager                               ',     
'2403' =>   'Agency - Owner Manager                                  ',     
'2700' =>   'Cosmetologist                                 ',     
'2701' =>   'Cosmetology Instructor                                 ',     
'2702' =>   'Cosmetology Ltd Instructor                            ',     
'2703' =>   'Cosmetology School - Private                                 ',     
'2705' =>   'Cosmetology Shop                           ',     
'2706' =>   'Cosmetology Shop Ltd              ',     
'2707' =>   'Electrologist                     ',     
'2710' =>   'Esthetician                  ',     
'2712' =>   'Manicurist                                          ',     
'2714' =>   'Nat. Hair Culturist                                       ',     
'2716' =>   'Apprentice Cosmetologist                               ',     
'2717' =>   'Apprentice Electrologist                          ',     
'2718' =>   'Apprentice Esthetician                                    ',     
'2719' =>   'Apprentice Manicurist                               ',     
'2720' =>   'Apprentice Nat. Hair Culturist                  ',     
'2721' =>   'Manicurist Ltd Instructor       ',     
'2722' =>   'Esthetician Ltd Instructor           ',     
'2724' =>   'Electrologist Ltd Instructor                     ',     
'2725' =>   'Electrologist Instructor         ',     
'2726' =>   'Cosmetology School - Public                              ',     
'2738' =>   'Cosmetology School Branch       ',     
'3500' =>   'Hearing Aid Trainee            ',     
'3501' =>   'Hearing Aid Dealer           ',     
'3502' =>   'Hearing Aid Salesperson                       ',     
'3901' =>   'Licensed Landscape Architect            ',     
'4000' =>   'Professional Surveyor                                          ',     
'6100' =>   'Type A Personnel Agency              ',     
'6101' =>   'Type B Personnel Agency                   ',     
'6102' =>   'Agent                                ',     
'6200' =>   'Professional Engineer                                           ',     
'6501' =>   'Salesperson               ',     
'6502' =>   'Associate Broker            ',     
'6503' =>   'Branch Office                            ',     
'6504' =>   'Individual Broker                                ',     
'6505' =>   'Broker Company                              ',     
     '' );
		 
//############################################################################################################		 

get_licstatus(string code ) := case ( code, '1'    => 'Active                                    ',
'2'    => 'Pending                                   ',
'6'    => 'Expired                                   ',
'8'    => 'Denied                                    ',
'10'   => 'Null & Void                               ',
'13'   => 'Reinstatement Pending                     ',
'17'   => 'Transfer Pending                          ',
'22'   => 'Withdrawn                                 ',
'26'   => 'Deleted                                   ',
'500'  => 'Lapsed                                    ',
'505'  => 'Lapsed - Court Stay                       ',
'510'  => 'Lapsed - Disciplinary Limited             ',
'515'  => 'Lapsed - Voluntary Limited                ',
'520'  => 'Lapsed - Limited                          ',
'523'  => 'Bad Check                                 ',
'525'  => 'Lapsed - Suspended                        ',
'540'  => 'Revoked                                   ',
'600'  => 'Voluntary Termination                     ',
'700'  => 'Closed                                    ',
'800'  => 'Deceased                                  ',
'805'  => 'Deceased - Lapsed - Disciplinary Limited  ',
'810'  => 'Deceased - Lapsed - Suspened              ',
'815'  => 'Deceased - Revoked                        ',
'820'  => 'Deceased - Voluntary Termination          ',
'1000' => 'Release Holds License                     ',
'1005' => 'Active - Court Stay                       ',
'1010' => 'Disciplinary Limited                      ',
'1015' => 'Voluntary Limited                         ',
'1020' => 'Limited                                   ',
'1025' => 'Suspended                                 ',
'1040' => 'Active - Renewal Exempt                   ',
'1050' => 'Renewal- In Review                        ',
'1051' => 'Application Withdrawn                     ',
'1052' => 'Inactive Application                      ',
'1053' => 'Application Rejected                      ',
'1081' => 'Deregulated as of October 1, 2015         ',
'2000' => 'Approved                                  ',
'4600' => 'Approved                                  ',
'4601' => 'Locked Out                                ',
'4602' => 'Waiver Granted                            ',
'4603' => 'Conditional Approval                      ',
'4604' => 'NA Prog - Inactive                        ',
'4605' => 'DEAD                                      ',
'8700' => 'Lapsed Cert                               ',
'9001' => 'Converted                                 ',
'9200' => 'Certified                                 ',
'9201' => 'Lapsed Cert                               ',
'9970' => 'X Nursys Push                             ',
'9971' => 'X Add Renewal Late Fee                    ',
'9972' => 'X FSW Change Lic Type                     ',
'9973' => 'X FWS Trans License                       ',
'9974' => 'X Push Renewal Back to MyLicense          ',
'9975' => 'X Reset License to Date of Last Renewal   ',
'9976' => 'X Delete From Print Queue                 ',
'9977' => 'X Force Elicense Refresh For Person       ',
'9978' => 'XN Delete Previous Name                   ',
'9979' => 'XN Restore Previous Name                  ',
'9980' => 'XA Delete Previous Address                ',
'9981' => 'XA Restore Previous Address               ',
'9982' => 'X Change Xpir Date to Issue Date          ',
'9983' => 'X No Renewals - 1                         ',
'9984' => 'X No Renewals + 1                         ',
'9985' => 'X Fix Relic Checklist                     ',
'9986' => 'X Fixchecklist                            ',
'9987' => 'XReset Renewal and not change stat        ',
'9988' => 'X Delete Renewal                          ',
'9989' => 'X Delete Lockbox Payments                 ',
'9990' => 'XR ReActivate Renewal                     ',
'9991' => 'XR Reinstate License after Autolapse      ',
'9992' => 'X Delete All License Hist Status Lines    ',
'9993' => 'X Insert 4 License Hist Status Line       ',
'9994' => 'X Insert 3 License Hist Status Line       ',
'9995' => 'X Insert 2 License Hist Status Line       ',
'9996' => 'X Insert 1 License Hist Status Line       ',
'9997' => 'X Back to Pending wo/License No           ',
'9998' => 'X Back to Pending w/License No            ',
'9999' => 'X Delete License                          ',
'10000' => 'Contact Licensing Board - 517-335-0918   ',
'10099' => 'Special Group Functions                  ',
'20001' => 'X Fix LHD Body Art                       ',
'20023' => 'Expired Application                      ',
'20024' => 'XB Active HI License for Inspection      ',
'22000' => 'Cancelled                                ',
'22001' => 'Retired                                  ',
'22002' => 'Facility Closed                          ',
'22003' => 'Deceased                                 ',
'22004' => 'No Longer Practicing In Michigan         ',
'22005' => 'Not Producing Medical Waste              ',
'22006' => 'Registered Under Another Facility        ',
'22007' => 'Other (SPECIFY)                          ',
'22008' => 'Practice Sold                            ',
'22009' => 'Practice Moved                           ',
'53001' => 'Active - Unlimited Renewal               ','' );


get_country(string code) := case( code, '52'   =>   'Greece            ',  
'53'   =>   'Guam              ',
'54'   =>   'Haiti             ',
'55'   =>   'Iceland           ',
'56'   =>   'Italy             ',
'57'   =>   'Japan             ',
'58'   =>   'Jordan            ',
'59'   =>   'Kenya             ',
'60'   =>   'Lebanon           ',
'61'   =>   'Malaysia          ',
'62'   =>   'Norway            ',
'63'   =>   'Pakistan          ',
'64'   =>   'Panama            ',
'65'   =>   'Papua New Guinea  ',
'66'   =>   'Poland            ',
'67'   =>   'Swaziland         ',
'68'   =>   'Sweden            ',
'69'   =>   'Taiwan            ',
'70'   =>   'Thailand          ',
'71'   =>   'Venezuela         ',
'72'   =>   'Zambia            ',
'73'   =>   'Belize            ',
'74'   =>   'Oatar             ',
'75'   =>   'Uganda            ',
'76'   =>   'American Samoa    ',
'77'   =>   'Liberia           ',
'78'   =>   'Benin             ',
'79'   =>   'Jamaica           ',
'80'   =>   'Trinidad          ',
'81'   =>   'Ethiopia          ',
'82'   =>   'Ivory Coast       ',
'83'   =>   'Romania           ',
'84'   =>   'Macau             ',
'85'   =>   'Botswana          ',
'86'   =>   'Nicaragua         ',
'87'   =>   'Syria             ',
'88'   =>   'Srilanka          ',
'89'   =>   'Paraguay          ',
'90'   =>   'Yemen             ',
'91'   =>   'Czech Republic    ',
'92'   =>   'Luxembourg        ',
'93'   =>   'Scotland          ',
'94'   =>   'Bahamas           ',
'95'   =>   'Nepal             ',
'96'   =>   'SW Pacific        ',
'97'   =>   'Cayman Islands    ',
'98'   =>   'Gautemela         ',
'99'   =>   'Ukraine           ',
'100'  =>   'England           ',
'101'  =>   'Albania           ',
'102'  =>   'Russia            ',
'103'  =>   'Guyana            ',
'104'  =>   'Northern Ireland  ','' );

//inHLTH := File_MI.Health +  File_MI.Occup;

Prof_License.Layout_proLic_in map2Occup ( File_MI.Occup l) := transform

 self.license_number          := l.license_no;
  self.orig_name              := STD.Str.CleanSpaces ( trim(l.first_name) + ' '+ trim(l.middle_name) + ' '+ trim(l.last_name));
  self.company_name           := if ( trim(l.Is_Org) = 'Y' , trim(l.sort_name) , '');
  self.issue_date              := dateconv(l.issue_date);
  self.orig_zip                := StringLib.stringfilter(l.addr_zipcode, '0123456789')[1..9];
  self.county_str              := l.addr_county;
  self.orig_addr_1             := l.addr_line_1;
  self.orig_city               := l.addr_city;
  self.orig_st                 := l.addr_state;
  self.orig_addr_2             := l.addr_line_2;
  self.orig_addr_3             := l.addr_line_3;
  self.orig_addr_4             := '';
  self.last_renewal_date       :='';
  self.expiration_date         :=dateconv( l.expiration_date);
  self.source_st               := 'MI';
  self.business_flag          :=l.Is_Org;
  self.previous_license_number :='';
  self.orig_former_name        := '';
  self.license_obtained_by     := '';
  self.profession_or_board     := trim(getOccboard(trim(l.profession_id))); 
  self.license_type            := trim(get_Occlictype(trim(l.license_type)));
  self.status                  := '';
  self.country_str             := '';
  self.name_order              := 'FML';
  self.vendor                  := 'Michigan Department of Consumer/Industr';
  self.date_first_seen         := infile(ftype = 'Health')[1].fdate;
  self.date_last_seen          := infile(ftype = 'Health')[1].fdate;
self := [];
end;

dMIOccup := project(  File_MI.Occup,  map2Occup(left));



Prof_License.Layout_proLic_in map2Health ( File_MI.Health l) := transform

 self.license_number          := l.license_no;
  self.orig_name              := STD.Str.CleanSpaces(trim(l.first_name) + ' '+ trim(l.middle_name) + ' '+ trim(l.last_name));
  self.company_name           := if ( trim(l.first_name) = '' and   trim(l.last_name) = '', trim(l.sort_name) , '');
  self.issue_date              :=dateconv(l.issue_date);
  self.orig_zip                := StringLib.stringfilter(l.addr_zipcode, '0123456789')[1..9];
  self.county_str              := l.addr_county;
  self.orig_addr_1             := l.addr_line_1;
  self.orig_city               := l.addr_city;
  self.orig_st                 := l.addr_state;
  self.orig_addr_2             := l.addr_line_2;
  self.orig_addr_3             := l.addr_line_3;
  self.orig_addr_4             := '';
  self.last_renewal_date       :='';
  self.expiration_date         := dateconv(l.expiration_date);
  self.source_st               := 'MI';
  self.business_flag          :='';
  self.previous_license_number :='';
  self.orig_former_name        := '';
  self.license_obtained_by     := '';
  self.profession_or_board     := trim(getboard(trim(l.profession_id))); 
  self.license_type            := trim(get_lictype(trim(l.license_type)));
  self.status                  := '';
  self.country_str             := '';
  self.name_order              := 'FML';
  self.vendor                  := 'Michigan Department of Consumer/Industr';
  self.date_first_seen         := infile(ftype = 'Health')[1].fdate;
  self.date_last_seen          := infile(ftype = 'Health')[1].fdate;
self := [];
end;

dMIHealth := project(  File_MI.Health,  map2Health(left));

dMIHealthall := dMIHealth + dMIOccup;

dMIHealthSF := Sequential( 
                         if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::mi::health'),FileServices.CreateSuperfile('~thor_data400::in::prolic::mi::health'),
                                                                                                         FileServices.ClearSuperfile( '~thor_data400::in::prolic::mi::health')),

                        output(dMIHealthall,,'~thor_data400::in::prolic::mi::health_'+curdate,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::mi::health','~thor_data400::in::prolic::mi::health_'+curdate),
											   FileServices.FinishSuperfiletransaction()
											 );
											 

input := map ( count(infile(ftype = 'TradeLic')) = 1 and count(infile) = 1 => dMITrade, 
               count(infile(ftype = 'Health')) = 1 and count(infile) = 1  => dMIHealth,
								  dMITrade + dMIHealth );

dout := map ( count(infile(ftype = 'TradeLic')) = 1 and count(infile) = 1 => dMITradeSF, 
               count(infile(ftype = 'Health')) = 1 and count(infile) = 1  => dMIHealthSF,
								  Sequential(dMITradeSF , dMIHealthSF) );


outfile := proc_clean_all(input,'MI').cleanout;

export buildprep := Sequential(dout, 
                        FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_mi'),
                 if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_mi_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_mi_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_mi_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_mi_old')),
                        FileServices.RenameLogicalfile( '~thor_data400::in::prolic_mi','~thor_data400::in::prolic_mi_old'),
                         
											output( outfile,,'~thor_data400::in::prolic_mi',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
								
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_mi'),
  										    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_mi_old'),

	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           

                                                                                                             
