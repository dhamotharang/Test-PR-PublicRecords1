import lib_stringlib,Prof_License, ut;

EXPORT Map_SC (dataset({string ftype,string fdate})infile) := module

inmed := if ( count(File_SC.medical.rcps) > 0 ,project(File_SC.medical.rcps,transform(File_SC.Layout_medical,self.NAME := left.PNAME,self := left,self := []))) +
        if ( count(File_SC.medical.phys) > 0 , project(File_SC.medical.phys,transform(File_SC.Layout_medical,self := left,self := []))) +
				if ( count(File_SC.medical.pas) > 0 , project( File_SC.medical.pas,transform(File_SC.Layout_medical,self.NAME := left.PNAME,self := left,self := []))) + 
				if ( count(File_SC.medical.opts) > 0 , project(File_SC.medical.opts,transform(File_SC.Layout_medical,self.code := '9',self := left,self := []))) +  
				if ( count(File_SC.medical.pharm) > 0 , project(File_SC.medical.pharm,transform(File_SC.Layout_medical,self.NAME := trim(left.FNAME) + ' '+ TRIM(left.LNAME),self.code := '10',self := left,self := []))) +   
				if ( count(File_SC.medical.pta) > 0 , project(File_SC.medical.pta,transform(File_SC.Layout_medical,self := left,self := []))) + 
     if ( count(File_SC.medical.ota) > 0 ,    project(File_SC.medical.ota,transform(File_SC.Layout_medical,self := left,self := []))) +  
				if ( count(File_SC.medical.orthotec) > 0 , project(File_SC.medical.orthotec,transform(File_SC.Layout_medical,self := left,self := []))) + 
				if ( count(File_SC.medical.dentec) > 0 , project(File_SC.medical.dentec,transform(File_SC.Layout_medical,self := left,self := []))) +  
				if ( count(File_SC.medical.ccpt) > 0 , project(File_SC.medical.ccpt,transform(File_SC.Layout_medical,self.NAME := trim(left.FNAME) + ' '+ TRIM(left.LNAME),self := left,self := []))) +   
				if ( count(File_SC.medical.drug) > 0 , project(File_SC.medical.drug,transform(File_SC.Layout_medical,self.NAME := trim(left.PHNAME),self := left,self := []))) +  
				if ( count(File_SC.medical.dhy) > 0 , project(File_SC.medical.dhy,transform(File_SC.Layout_medical,self := left,self := []))) +  
				if ( count(File_SC.medical.dnt) > 0 , project(File_SC.medical.dnt,transform(File_SC.Layout_medical,self := left,self := [])))  ;
				
				




Prof_License.Layout_proLic_in map2medical( inmed l ) := transform

get_licdesc( string practype ) := case ( practype,

'A'  =>  'ALLERGY                                       ',
'AD'  =>  'ADMINISTRATIVE MEDICINE                       ',
'ADL'  =>  'ADOLESCENT MEDICINE                           ',
'ADM'  =>  'ADDICTION MEDICINE                            ',
'ADP'  =>  'ADDICTION PSYCHIATRY                          ',
'AF'  =>  'U.S. AIR FORCE                                ',
'AI'  =>  'ALLERGY AND IMMUNOLOGY                        ',
'ALI'  =>  'ALLERGY IMMUNOLOGY/CLINICAL LAB IMMUNOLOGY    ',
'AM'  =>  'AEROSPACE MEDICINE                            ',
'AMI'  =>  'ADOLESCENT MEDICINE (INTERNAL MEDICINE)       ',
'AN'  =>  'ANESTHESIOLOGY                                ',
'APM'  =>  'PAIN MANAGEMENT (ANESTHESIOLOGY)              ',
'AS'  =>  'ABDOMINAL SURGERY                             ',
'ATP'  =>  'ANATOMIC PATHOLOGY                            ',
'BBK'  =>  'BLOOD BANKING/TRANSFUSION MEDICINE            ',
'CBG'  =>  'CLINICAL BIOCHEMICAL GENETICS                 ',
'CCA'  =>  'CRITICAL CARE MEDICINE (ANESTHESIOLOGY)       ',
'CCG'  =>  'CLINICAL CYTOGENETICS                         ',
'CCM'  =>  'CRITICAL CARE MEDICINE (INTERNAL MEDICINE)    ',
'CCP'  =>  'PEDIATRIC CRITICAL CARE MEDICINE              ',
'CCS'  =>  'SURGICAL CRITICAL CARE (SURGERY)              ',
'CD'  =>  'CARDIOVASCULAR DISEASE                        ',
'CDS'  =>  'CARDIOVASCULAR SURGERY                        ',
'CE'  =>  'CARDIAC ELECTROPHYSIOLOGY                     ',
'CG'  =>  'CLINICAL GENETICS                             ',
'CHN'  =>  'CHILD NEUROLOGY                               ',
'CHP'  =>  'CHILD AND ADOLESCENT PSYCHIATRY               ',
'CLP'  =>  'CLINICAL PATHOLOGY                            ',
'CMG'  =>  'CLINICAL MOLECULAR GENETICS                   ',
'CN'  =>  'CLINICAL NEUROPHYSIOLOGY                      ',
'CRS'  =>  'COLON RECTAL SURGERY                          ',
'CTS'  =>  'CARDIOTHORACIC SURGERY                        ',
'D'  =>  'DERMATOLOGY                                   ',
'DBP'  =>  'DEVELOPMENTAL BEHAVIORAL PEDIATRICS           ',
'DDL'  =>  'CLINICAL LABORATORY DERMATOLOGICAL IMMUNOLOG  ',
'DIA'  =>  'DIABETES                                      ',
'DLI'  =>  'DIAGNOSTIC LABORATORY/IMMUNOLOGY              ',
'DMP'  =>  'DERMATOPATHOLOGY                              ',
'DR'  =>  'DIAGNOSTIC RADIOLOGY                          ',
'EM'  =>  'EMERGENCY MEDICINE                            ',
'END'  =>  'ENDOCRINOLOGY, DIABETES AND METABOLISM        ',
'ESM'  =>  'SPORTS MEDICINE (EMERGENCY MEDICINE)          ',
'ETX'  =>  'MEDICAL TOXICOLOGY (EMERGENCY MEDICINE)       ',
'FOP'  =>  'FORENSIC PATHOLOGY                            ',
'FP'  =>  'FAMILY PRACTICE                               ',
'FPG'  =>  'GERIATRIC MEDICINE (FAMILY PRACTICE)          ',
'FPS'  =>  'FACIAL PLASTIC SURGERY                        ',
'FSM'  =>  'SPORTS MEDICINE (FAMILY PRACTICE)             ',
'GE'  =>  'GASTROENTEROLOGY                              ',
'GER'  =>  'GERIATRICS                                    ',
'GO'  =>  'GYNECOLOGICAL ONCOLOGY                        ',
'GP'  =>  'GENERAL PRACTICE                              ',
'GPM'  =>  'GENERAL PREVENTIVE MEDICINE                   ',
'GS'  =>  'GENERAL SURGERY                               ',
'GYN'  =>  'GYNECOLOGY                                    ',
'HEM'  =>  'HEMATOLOGY (INTERNAL MEDICINE)                ',
'HEP'  =>  'HEPATOLOGY                                    ',
'HMP'  =>  'HEMATOLOGY (PATHOLOGY)                        ',
'HNS'  =>  'HEAD AND NECK SURGERY                         ',
'HO'  =>  'HEMATOLOGY/ONCOLOGY                           ',
'HSO'  =>  'HAND SURGERY (ORTHOPEDIC SURGERY)             ',
'HSP'  =>  'SURGERY OF THE HAND (PLASTIC SURGERY)         ',
'HSS'  =>  'SURGERY OF THE HAND (SURGERY)                 ',
'IC'  =>  'INTERVENTIONAL CARDIOLOGY                     ',
'ID'  =>  'INFECTIOUS DISEASE                            ',
'IG'  =>  'IMMUNOLOGY                                    ',
'ILI'  =>  'CLINICAL LABORATORY IMMUNOLOGY INTERN. MED.   ',
'IM'  =>  'INTERNAL MEDICINE                             ',
'IMG'  =>  'GERIATRIC MEDICINE (INTERNAL MEDICINE)        ',
'INT'  =>  'INTERN                                        ',
'ISM'  =>  'SPORTS MEDICINE (INTERNAL MEDICINE)           ',
'LM'  =>  'LEGAL MEDICINE                                ',
'MDM'  =>  'MEDICAL MANAGEMENT                            ',
'MFM'  =>  'MATERNAL FETAL MEDICINE                       ',
'MG'  =>  'MEDICAL GENETICS                              ',
'MM'  =>  'MEDICAL MICROBIOLOGY                          ',
'MPD'  =>  'INTERNAL MEDICINE/PEDIATRICS                  ',
'N'  =>  'NEUROLOGY                                     ',
'NCC'  =>  'CRITICAL CARE MEDICINE (NEUROLOGICAL SURGERY) ',
'NEO'  =>  'NEO-NATAL                                     ',
'NEP'  =>  'NEPHROLOGY                                    ',
'NM'  =>  'NUCLEAR MEDICINE                              ',
'NP'  =>  'NEUROPATHOLOGY                                ',
'NPM'  =>  'NEONATAL-PERINATAL MEDICINE                   ',
'NR'  =>  'NUCLEAR RADIOLOGY                             ',
'NS'  =>  'NEUROLOGICAL SURGERY                          ',
'NSP'  =>  'PEDIATRIC SURGERY (NEUROLOGY)                 ',
'NTR'  =>  'NUTRITION                                     ',
'O'  =>  'OTHER SURGERY                                 ',
'OAR'  =>  'ADULT RECONSTRUCTIVE ORTHOPEDICS              ',
'OBG'  =>  'OBSTETRICS AND GYNECOLOGY                     ',
'OBS'  =>  'OBSTETRICS                                    ',
'OCC'  =>  'CRITICAL CARE MEDICINE (OBSTETRICS GYNECOLOGY)',
'OM'  =>  'OCCUPATIONAL MEDICINE                         ',
'OMO'  =>  'MUSCULOSKELETAL ONCOLOGY                      ',
'ON'  =>  'MEDICAL ONCOLOGY                              ',
'OP'  =>  'PEDIATRIC ORTHOPEDICS                         ',
'OPH'  =>  'OPHTHALMOLOGY                                 ',
'ORS'  =>  'ORTHOPEDIC SURGERY                            ',
'OS'  =>  'OTHER SPECIALTY (PHYSICIAN DESIGNATED A SPECIALTY',
'OSM'  =>  'SPORTS MEDICINE (ORTHOPEDIC SURGERY)          ',
'OSS'  =>  'ORTHOPEDIC SURGERY OF THR SPINE               ',
'OT'  =>  'OTOLOGY                                       ',
'OTO'  =>  'OTOLARYNGOLOGY                                ',
'OTR'  =>  'ORTHOPEDIC TRAUMA                             ',
'P'  =>  'PSYCHIATRY                                    ',
'PA'  =>  'CLINICAL PHARMACOLOGY                         ',
'PCC'  =>  'PULMONARY CRITICAL CARE MEDICINE              ',
'PCH'  =>  'CHEMICAL PATHOLOGY                            ',
'PCP'  =>  'CYTOPATHOLOGY                                 ',
'PD'  =>  'PEDIATRICS                                    ',
'PDA'  =>  'PEDIATRIC ALLERGY                             ',
'PDC'  =>  'PEDIATRIC CARDIOLOGY                          ',
'PDE'  =>  'PEDIATRIC ENDOCRINOLOGY                       ',
'PDI'  =>  'PEDIATRIC INFECTIOUS DISEASE                  ',
'PDO'  =>  'PEDIATRIC OTOLARYNGOLOGY                      ',
'PDP'  =>  'PEDIATRIC PULMONOLOGY                         ',
'PDR'  =>  'PEDIATRIC RADIOLOGY                           ',
'PDS'  =>  'PEDIATRIC SURGERY                             ',
'PDT'  =>  'MEDICAL TOXICOLOGY (PEDIATRICS)               ',
'PE'  =>  'PEDIATRIC EMERGENCY MED (EMERGENCY MEDICINE)  ',
'PEM'  =>  'PEDIATRIC EMERGENCY MEDICINE (PEDIATRICS)     ',
'PFP'  =>  'FORENSIC PSYCHIATRY                           ',
'PG'  =>  'PEDIATRIC GASTROENTERLOGOY                    ',
'PH'  =>  'PUBLIC HEALTH AND GENERAL PREVENTIVE MEDICINE ',
'PHO'  =>  'PEDIATRIC HEMATOLOGY/ONCOLOGY                 ',
'PHS'  =>  'U.S. PUBLIC HEALTH SERVICE                    ',
'PIP'  =>  'IMMUNOPATHOLOGY                               ',
'PLI'  =>  'CLINICAL LABORATORY IMMUNOLOGY (PEDIATRICS)   ',
'PLM'  =>  'PALLIATIVE MEDICINE                           ',
'PM'  =>  'PHYSICAL MEDICINE AND REHABILITATION          ',
'PMD'  =>  'PAIN MEDICINE                                 ',
'PN'  =>  'PEDIATRIC NEPHROLOGY                          ',
'PND'  =>  'NEURODEVELOPMENTAL DISABILITIES               ',
'PO'  =>  'PEDIATRIC OPHTHALMOLOGY                       ',
'PP'  =>  'PEDIATRIC PATHOLOGY                           ',
'PPR'  =>  'PEDIATRIC RHEUMATOLOGY                        ',
'PS'  =>  'PLASTIC SURGERY                               ',
'PSM'  =>  'SPORTS MEDICINE (PEDIATRICS)                  ',
'PTH'  =>  'ANATOMIC|CLINICAL PATHOLOGY                   ',
'PTX'  =>  'MEDICAL TOXICOLOGY (PREVENTIVE MEDICINE)      ',
'PUD'  =>  'PULMONARY DISEASES                            ',
'PYA'  =>  'PSYCHOANALYSIS                                ',
'PYG'  =>  'GERIATRIC PSYCHIATRY                          ',
'R'  =>  'RADIOLOGY                                     ',
'REN'  =>  'REPRODUCTIVE ENDOCRINOLOGY                    ',
'RHU'  =>  'RHEUMATOLOGY                                  ',
'RIP'  =>  'RADIOISOTOPIC PATHOLOGY                       ',
'RNR'  =>  'NEURORADIOLOGY                                ',
'RO'  =>  'RADIATION ONCOLOGY                            ',
'RP'  =>  'RADIOLOGICAL PHYSICS                          ',
'SCI'  =>  'SPINAL CORD INJURY                            ',
'SH'  =>  'STUDENT HEALTH                                ',
'SM'  =>  'SLEEP MEDICINE                                ',
'SO'  =>  'SURGICAL ONCOLOGY                             ',
'SP'  =>  'SELECTIVE PATHOLOGY                           ',
'TR'  =>  'THERAPEUTIC RADIATION                         ',
'TRS'  =>  'TRAUMATIC SURGERY                             ',
'TS'  =>  'THORACIC SURGERY                              ',
'TTS'  =>  'TRANSPLANT SURGERY                            ',
'U'  =>  'UROLOGY                                       ',
'UM'  =>  'UNDERSEA MEDICINE                             ',
'UP'  =>  'PEDIATRIC UROLOGY                             ',
'USA'  =>  'U.S. ARMY                                     ',
'USN'  =>  'U.S. NAVY                                     ',
'VIR'  =>  'VASCULAR AND INTERVENTIONAL RADIOLOGY         ',
'VS'  =>  'GENERAL VASCULAR SURGERY                      ','');

 self.business_flag     := 'N';
  self.source_st         := 'SC';
  self.profession_or_board        := 'Medical';
  self.license_type      := case(trim(l.CODE), 
                           '8' => 'Occupational Therapist Assistant',
                           '10' => 'Pharmacist',
                           '12' => 'Pharmacy Technician',
                           '11' => 'Physical Therapist',
                           '16' => 'Physical Therapist Assistant',
                           '2' => 'Dental Hygienist',
                           '3' => 'Dentist',
                           '14' => 'Dental Technician',
                           '22' => 'Occupational Therapist',
                           '24' => 'Orthodontic Technician',
                           '4' => 'Allopathic Physician',
                           '5' => 'Osteopathic Physician',
                           '21' => 'Respiratory Care Practitioner',
                           '9' => 'Optometrist',
                           '18' => 'Physician Assistant',if ( l.TYPES <> '',l.TYPES,''));
  self.license_number    := l.LICNO;
  self.orig_name         := l.NAME;
  self.orig_addr_1       := l.MAILADD1;
  self.orig_addr_2       := l.MAILADD2;
  self.orig_addr_3       := l.MAILADD3;
  self.orig_city         := l.MCITY;
  self.orig_former_name  := ' ';
  self.company_name := ' ';
  self.orig_st           := l.MSTATE[1..2];
  self.orig_zip          := StringLib.Stringfilter(l.MZIP, '1234567890')[1..9];
  self.country_str       := ' ';
  self.last_renewal_date := ' ';
  self.license_obtained_by := ' ';
  self.name_order         := 'FML';
  self.vendor             := 'South Carolina State Treasurer';
  self.sex                := ' ';
  self.date_first_seen    := infile(ftype = 'medical')[1].fdate;;
  self.date_last_seen     := infile(ftype = 'medical')[1].fdate;;
  self.additional_name_addr_type := if ( l.FNAME +  l.LNAME <> '', 'Name' , '' ) ;
  self.additional_orig_name :=  l.FNAME +  ' ' +  l.LNAME ;
  self.additional_name_order := if (l.FNAME +  l.LNAME <> '',  'FML' , '' ) ;
  self.misc_practice_type := trim(get_licdesc(StringLib.stringfilterout(trim(l.PRACTYP1), '*')))[1..50];
	self.issue_date            := dateconv(trim(l.ISSUEDT));
  self.expiration_date       := dateconv(trim(l.EXPDATE));
	self := [];
end;                                                                                                                                                                                                                                                                                        
                                                             
dWithMed:= project( inmed, map2medical(left))( regexfind('[0-9]',license_number) = true) ;

dMedicalSF := Sequential(   
                            FileServices.ClearSuperfile( '~thor_data400::in::prolic::sc::medical'),

                             Output( dWithMed,,'~thor_data400::in::prolic::sc::medical::'+ut.GetDate,overwrite),
														FileServices.AddSuperfile( '~thor_data400::in::prolic::sc::medical','~thor_data400::in::prolic::sc::medical::'+ut.GetDate)
															 ) ; 
// Social Workers

insocial := File_SC.social;
Prof_License.Layout_proLic_in map2social( insocial l ) := transform

  self.date_first_seen       := infile(ftype = 'social_worker')[1].fdate;
  self.date_last_seen        := infile(ftype = 'social_worker')[1].fdate;
  self.license_type          := l.Description;
  self.orig_name             := trim(l.FirstName) +  ' ' + trim(l.middleName) + ' ' + trim(l.LastName);
  self.name_order            := 'FML';
  self.orig_addr_1           := l.Address1;
  self.orig_addr_2           := l.Address2;
  self.orig_city             := StringLib.StringToUpperCase(l.City);
  self.orig_st               := StringLib.StringToUpperCase(l.StateCode[1..2]);
  self.orig_zip              := StringLib.stringfilter(l.Zipcode, '0123456789')[1..9];
  self.phone                 :=  '';//StringLib.stringfilter(l.Business_Phone, '0123456789')[1..10];
  self.license_number        := if ( l.CredentialNumber <> '', (string)intformat((integer)trim(l.CredentialNumber),6,1) , '' ) ;
  self.issue_date            :=  dateconv(trim(l.FirstEffectiveDate));
  self.expiration_date       := dateconv(trim(l.ExpirationDate));
  self.source_st             := 'SC';
  self.vendor                := 'South Carolina Board of Social Work Exam';
  self.profession_or_board            := 'Social Workers';
  self.status                := l.Status;
  self.company_name     := trim(l.company);
	self := [];
	end;

dWithSocial:= project( insocial, map2social(left))( regexfind('[0-9]',license_number) = true);

dSocialSF := Sequential(   
                            FileServices.ClearSuperfile( '~thor_data400::in::prolic::sc::social_worker'),

                             Output( dWithSocial,,'~thor_data400::in::prolic::sc::social_worker::'+ut.GetDate,overwrite),
														FileServices.AddSuperfile( '~thor_data400::in::prolic::sc::social_worker','~thor_data400::in::prolic::sc::social_worker::'+ut.GetDate)
															 ) ; 

//Pyshology

inpsy := File_SC.psychology;
Prof_License.Layout_proLic_in map2psy( inpsy l ) := transform

  self.date_first_seen       := infile(ftype = 'psychology')[1].fdate;
  self.date_last_seen        := infile(ftype = 'psychology')[1].fdate;
  self.license_type          := l.Description;
  self.orig_name             := trim(l.FirstName) +  ' ' + trim(l.middleName) + ' ' + trim(l.LastName);
  self.name_order            := 'FML';
  self.orig_addr_1           := l.Address1;
  self.orig_addr_2           := l.Address2;
  self.orig_city             := StringLib.StringToUpperCase(l.City);
  self.orig_st               := StringLib.StringToUpperCase(l.StateCode[1..2]);
  self.orig_zip              := StringLib.stringfilter(l.Zipcode, '0123456789')[1..9];
  self.phone                 :=  '';//StringLib.stringfilter(l.Business_Phone, '0123456789')[1..10];
  self.license_number        := if ( l.CredentialNumber <> '', (string)intformat((integer)trim(l.CredentialNumber),6,1) , '' ) ;
  self.issue_date            := dateconv(trim(l.FirstEffectiveDate));
  self.expiration_date       :=dateconv(trim(l.ExpirationDate));
  self.source_st             := 'SC';
  self.vendor                := 'South Carolina Board of Examiners in Psychologists';
  self.profession_or_board            := 'Psychology';
  self.status                := l.Status;
	self := [];
	end;

dWithpsy:= project( inpsy, map2psy(left))( regexfind('[0-9]',license_number) = true);

dPsySF := Sequential(   
                            FileServices.ClearSuperfile( '~thor_data400::in::prolic::sc::psychology'),

                             Output( dWithpsy,,'~thor_data400::in::prolic::sc::psychology::'+ut.GetDate,overwrite),
														FileServices.AddSuperfile( '~thor_data400::in::prolic::sc::psychology','~thor_data400::in::prolic::sc::psychology::'+ut.GetDate)
															 ) ; 

 
 
 prep :=  map ( count(infile(ftype = 'medical')) = 1 and count(infile) = 1 => dMedicalSF, 
                     count(infile(ftype = 'social_worker')) = 1 and count(infile) = 1 => dSocialSF,
									count(infile(ftype =	'psychology')) = 1 and count(infile) = 1 =>  dPsySF,
									count(infile(ftype in ['medical','social_worker'])) = 2 and count(infile) = 2 =>  Sequential( dMedicalSF, dSocialSF),
									 count(infile(ftype in ['medical','psychology'])) = 2 and count(infile) = 2 => Sequential(dMedicalSF, dPsySF),
									 count(infile(ftype in ['psychology','social_worker'])) = 2 and count(infile) = 2 => Sequential(dPsySF,dSocialSF),
									 Sequential( dMedicalSF, dPsySF,dSocialSF) ) ;
                                      
//call macro

input :=  map ( count(infile(ftype = 'medical')) = 1 and count(infile) = 1 => dWithMed, 
                     count(infile(ftype = 'social_worker')) = 1 and count(infile) = 1 => dWithSocial,
									count(infile(ftype =	'psychology')) = 1 and count(infile) = 1 =>  dWithpsy,
									count(infile(ftype in ['medical','social_worker'])) = 2 and count(infile) = 2 =>  dWithMed + dWithSocial ,
									 count(infile(ftype in ['medical','psychology'])) = 2 and count(infile) = 2 => dWithMed + dWithpsy ,
									 count(infile(ftype in ['psychology','social_worker'])) = 2 and count(infile) = 2 => dWithpsy + dWithSocial ,
									  dWithMed + dWithSocial + dWithpsy
									) ;

outfile := proc_clean_all(input,'SC').cleanout;

export buildprep := Sequential(prep, 
                 FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_sc'),
                        if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_sc_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_sc_old')),
								        if ( FileServices.FileExists( '~thor_data400::in::prolic_sc_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_sc_old')),
                        FileServices.RenameLogicalfile( '~thor_data400::in::prolic_sc','~thor_data400::in::prolic_sc_old'),   
                         
											output( outfile,,'~thor_data400::in::prolic_sc',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
								
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_sc'),
		           FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_sc_old'),

											   FileServices.FinishSuperfiletransaction()
											 );




end;
