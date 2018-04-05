EXPORT Map_WI_All_Available(string fdate) := module

import NID,Prof_License; 

  Prof_License.Layout_proLic_in map2common( File_WI_All_Available.raw  l ) := transform
	
	
  self.orig_name    := if(l.OWNER = '',trim(l.FULL_NAME)[1..80] ,'');                                                                                                           
  self.name_order   := '';                                                                                                          
  self.orig_addr_1  := trim(l.STREET_1)[1..80];                                                                                
  self.orig_city    := trim(l.CITY_NAME)[1..40];                                                                                     
  self.orig_st      := l.STATE_CODE[1..2];                                                                                                                            
  self.orig_zip     := l.ZIP_CODE[1..9];                                                                                                                             
  self.country_str  := l.COUNTRY_NAME[1..35];                                                                                             
  self.profession_or_board   :=  L.PROFESSION_NAME[1..60];                               
  self.license_number := l.LICENSE_NUMBER;                                                                                                                
  self.issue_date    := if ( l.GRANTED_DATE <> '',fSlashedMDYtoCYMD(l.GRANTED_DATE),'');                                                                                                
  self.sex           := trim(l.GENDER);                                                                                                                
  self.dob      := '';                                                                                                                                 
  self.status        := l.STATUS;                                                                                                                       
  self.company_name := if(l.OWNER <> '', trim(l.FULL_NAME),'');                                          
  self.license_type :=  L.PROFESSION_NAME[1..60];                                                               
  self.orig_former_name := ' ';                                                                                                                        
  self.orig_addr_2 := ' ';                                                                                                                             
  self.county_str := l.COUNTY;                                                                                                                              
  self.business_flag := if (l.OWNER <> '' ,'Y' , 'N');                                                                                           
  self.license_obtained_by := ' ';                                                                                                                     
  self.source_st := 'WI';                                                                                                                              
  self.vendor := 'Department of Regulation & Licensing - WI';                                                                                          
  self.date_first_seen := fdate;                                                                                                             
  self.date_last_seen := fdate;                                                                                                              
  self.personal_race_cd := '';                                                                                   
  self.personal_race_desc := trim(l.ETHNIC)[1..25];
	
	                                                                                                                    
  self.additional_name_addr_type := '';                                                                        
  self.additional_orig_name := '';                                                                                  
  self.misc_practice_type := trim(l.SPECIALTY)[1..50];                                                                  
  self.expiration_date := if ( l.RENEWAL_BY_DATE <> '' , fSlashedMDYtoCYMD(l.RENEWAL_BY_DATE) ,'');
	self.misc_email := trim(l.EMAIL)[1..50];
	self.phone := l.PHONE;
self := [];
  end;             	
	
	 dWIAllout := project( File_WI_All_Available.raw, map2common(left));

	dout := Sequential( Output( dWIAllout,,'~thor_data400::in::prolic::wi::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::wi::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::wi::all_available','~thor_data400::in::prolic::wi::all_available_'+fdate)
															 );
															 
outfile := proc_clean_all(dWIAllout,'WI').cleanout;

export buildprep := Sequential(dout, 
                        FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_wi'),
                              if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_wi_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_wi_old')),
							        	       if ( FileServices.FileExists( '~thor_data400::in::prolic_wi_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_wi_old')),
                              FileServices.RenameLogicalfile( '~thor_data400::in::prolic_wi','~thor_data400::in::prolic_wi_old'),                         
												 
                         
											output( outfile,,'~thor_data400::in::prolic_wi',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
											 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_wi'),
											    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_wi_old'),

											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
                                                                                                                                                 