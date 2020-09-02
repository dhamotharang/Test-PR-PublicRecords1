import Prof_License;

EXPORT Map_CT_All_Available( string fdate) := module

fin_ct := File_CT_All_Available.raw ;

get_license( string License_Type) := case ( License_Type,
'1'=> 'PHYSICIANS /SURGEONS/OSTEOPATHS ', 
'10'=> 'REGISTERED NURSE ', 
'11'=> 'LICENSED PRACTICAL NURSE ', 
'12'=> 'ADVANCED PRAC. REG. NURSE ', 
'13'=> 'DENTAL HYGENIST ', 
'14'=> 'PHYSICAL THERAPIST ', 
'15'=> 'ELECTROLOGISTS', 
'16'=> 'NURSE MIDWIFE ', 
'17'=> 'AUDIOLOGIST ', 
'18'=> 'SPEECH & LANGUAGE PATHOLOGIST ', 
'19'=> 'PODIATRIST ', 
'2'=> 'DENTIST ', 
'20'=> 'HAIRDRESSER /COSMETICIAN ', 
'21'=> 'DENTAL CONSCIOUS SEDATION PMTE ', 
'22'=> 'DENTAL GEN ANES/CONS SEDAT PMTE ', 
'23'=> 'PHYSICIAN ASSISTANT ', 
'25'=> 'BARBERS', 
'26'=> 'RESPIRATORY CARE PRAC ', 
'27'=> 'MARRIAGE & FAMILY THERAPIST ', 
'28'=> 'RADIOGRAPHY TECHNICIAN', 
'29'=> 'MASSAGE THERAPIST ', 
'3'=> 'OPTOMETRIST ', 
'30'=> 'EMBALMER', 
'31'=> 'FUNERAL DIRECTOR', 
'32'=> 'SUB-SURFACE SEWER CLEANER', 
'33'=> 'SUB-SURFACE SEWER INSTALLER', 
'35'=> 'REGISTERED SANITARIAN', 
'36'=> 'NURSING HOME ADMINISTRATOR', 
'37'=> 'HEARING INSTRUMENT SPECIALIST', 
'38'=> 'OPTICIAN ', 
'39'=> 'ASBESTOS CONSULT.-INSPECTOR', 
'40'=> 'ASBESTOS CONSULT.-INSP MGMT PLNR', 
'41'=> 'ASBESTOS CONSULT.-PROJ. DESIGNER', 
'42'=> 'ASBESTOS CONSULT.-PROJ. MONITOR', 
'43'=> 'ACUPUNCTURIST ','');                       



Prof_License.Layout_proLic_in map2comm( fin_ct l) := transform

  self.profession_or_board    :=  get_license(trim(l.License_Type)) ;                                                                                                                             
  self.source_st                        := 'CT';                                                                                                                                                                                                                                               
  self.orig_name                       :=trim(l.First_Name) + ' '+ trim(l.Middle_Name) + '' + trim(l.Last_Name); 
  self.company_name              := trim(l.Business_Name);
  self.orig_city                          := StringLib.StringToUpperCase(trim(l.City));                                                                                                                                                                                                                        
  self.orig_st                             := trim(l.State);                                                                                                                                                                                                                                        
  self.orig_zip                           := if (trim(StringLib.StringFilterout((StringLib.stringfilter(l.Zip_Code,'0123456789')[1..9]), '0')) <> '' , StringLib.stringfilter(l.Zip_Code,'0123456789')[1..9], '' );                                                                                  
                                                                                                                                                                                                                                                                                                      
  self.vendor                            := 'Connecticut Department of Public Health';                                                                                                                                                                                                                
  self.status                              := l.Status;                                                                                                                                                                                                                                              
  self.license_number             := l.License_Number;                                                                                                                                                                                                   
  self.phone                              := trim(l.Phone);
  self.misc_email                      := trim(l.Email);
  self.misc_fax                          := trim(l.Fax);
  self.misc_occupation            := trim(l.Title);
  self.education_1_school_attended := trim(l.School);
 self.education_1_degree       := trim(l.Speciality);
 self.education_1_dates_attended := trim(l.Graduation_Date);
  self.business_flag                := if (self.orig_name <> '', 'N','Y');                                                                                                                                                                                                                                           
  self.license_type                  :=  get_license(trim(l.License_Type)) ;                                                                                                          
  self.date_first_seen             := fdate;                                                                                                                                                                                                                               
  self.date_last_seen              := fdate;                                                                                                                                                                                                                                
  self.name_order                    := 'FML';                                                                                                                                                                                                                                      
  self.issue_date                      := Prof_License_preprocess.dateconv(trim(l.Issue_Date));                                                                                                                                                                                                                     
  self.expiration_date               :=  Prof_License_preprocess.dateconv(trim(l.Expiration_Date));  
  self.last_renewal_date         :=  Prof_License_preprocess.dateconv(trim( l.Reinstate_Date));
  self.dob                                  :=  Prof_License_preprocess.dateconv(trim(l.Date_Of_Birth));
  self.county_str                     := trim(l.County);                                                                                                                                                                                                                                          
  self.orig_addr_1                   := trim(l.Address_Line1);                                                                                                                                                                                                                                  
  self.orig_addr_2                    :=trim( l.Address_Line2);                                                                                                                                                                                                                                  
  self := [];
end;                                                                

fout_ct := project ( fin_ct , map2comm (left));

 dout := Sequential( Output( fout_ct,,'~thor_data400::in::prolic::ct::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::ct::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::ct::all_available','~thor_data400::in::prolic::ct::all_available_'+fdate)
															 );
															 
outfile := proc_clean_all(fout_ct,'CT').cleanout;

export buildprep := Sequential(dout, 
                                  FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ct'),
																	   if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_CT_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_CT_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_CT_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_CT_old')),
                       FileServices.RenameLogicalfile( '~thor_data400::in::prolic_ct','~thor_data400::in::prolic_CT_old'),
			
               
                         
											output( outfile,,'~thor_data400::in::prolic_ct',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
										    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_CT_old'),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ct'),
	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		


