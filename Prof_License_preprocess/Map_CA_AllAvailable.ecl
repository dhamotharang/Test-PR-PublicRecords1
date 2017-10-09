import Prof_License,ut,lib_StringLib;

EXPORT Map_CA_AllAvailable ( string fdate) := module

infilebrz := File_CA_All_Available.brz00_raw  ;


Prof_License.Layout_proLic_in map2brz( infilebrz l) := transform
self.source_st                 := 'CA';                                                                                                                                                                                                                                           
self.expiration_date           := fSlashedMDYtoCYMD(l.Expiration_Date);                                                                                                                                                                                                      
self.issue_date                := fSlashedMDYtoCYMD(l.Original_Issue_Date);                                                                                                                                                                                                       
self.country_str               := l.Country;                                                                                                                                                                                                                                    
self.orig_zip                  := trim(l.Zip)[1..9];                                                                                                                                                                                                                               
self.orig_st                   := trim(l.State)[1..2];                                                                                                                                                                                                                              
self.orig_addr_1               := trim(l.Address_Line_1)[1..80];                                                                                                                                                                                                                
self.orig_addr_2               := trim(l.Address_Line_2)[1..80];                                                                                                                                                                                                                
self.orig_name                 := if ( ut.CleanSpacesAndUpper( trim(l.Indiv_Org)) = 'I' , trim(l.First_Name)+ ' ' + trim(l.Middle_Name) + '  ' + trim(l.Org_Last_Name)[1..80] , '' );                                                                                                                      
self.company_name         := if ( ut.CleanSpacesAndUpper(trim(l.Indiv_Org)) <> 'I' , trim(l.First_Name)+ ' ' + trim(l.Middle_Name) + '  ' + trim(l.Org_Last_Name)[1..100] , '' );                                                                                                            
self.license_number            := trim(l.License_Number);                                                                                                                                                                                                                    
self.orig_former_name          := '';                                                                                                                                                                                                                                      
self.business_flag            := if ( ut.CleanSpacesAndUpper(trim(l.Indiv_Org)) = 'I' , 'N' , 'Y' );                                                                                                                                                                                                
self.orig_city                 := trim(l.City);                                                                                                                                                                                                                                   
self.county_str                := trim(l.County);                                                                                                                                                                                                                                
self.license_obtained_by       := '';                                                                                                                                                                                                                                   
self.profession_or_board                := l.Agency_Name;                                                                                                                                                                                                                                 
self.license_type              := trim(l.License_Type)[1..60];                                                                                                                                                                                                                 
self.status                    := l.License_Status;                                                                                                                                                                                                                                  
self.former_name_order        := '';                                                                                                                                                                                                                                     
self.name_order               := 'FML';                                                                                                                                                                                                                                         
self.vendor                   := 'CALIFORNIA DEPARTMENT OF CONSUMER AFFAIRS';                                                                                                                                                                                                       
self.date_first_seen          := fdate;                                                                                                                                                                                                                           
self.date_last_seen           := fdate;                                                                                                                                                                                                                            
self.education_1_school_attended := '';                                                                                                                                                                                                        
self.education_1_dates_attended := '';                                                                                                                                                                                                              
self.education_1_degree     := '';  
self := [];                                                                                                                                                                                                               
end;

d_Brzout := project ( infilebrz , map2brz (left));




Inlegacyfile := File_CA_All_Available.lgc00_raw  ;

Prof_License.Layout_proLic_in map2lgc( Inlegacyfile l) := transform
self.source_st                 := 'CA';                                                                                                                                                                                                                                           
self.expiration_date           := fSlashedMDYtoCYMD(l.Expiration_Date);                                                                                                                                                                                                      
self.issue_date                := fSlashedMDYtoCYMD(l.Original_Issue_Date);                                                                                                                                                                                                       
self.country_str               := l.Country;                                                                                                                                                                                                                                    
self.orig_zip                  := trim(l.Zip)[1..9];                                                                                                                                                                                                                               
self.orig_st                   := trim(l.State)[1..2];                                                                                                                                                                                                                              
self.orig_addr_1               := trim(l.Address_Line_1)[1..80];                                                                                                                                                                                                                
self.orig_addr_2               := trim(l.Address_Line_2)[1..80];                                                                                                                                                                                                                
self.orig_name                 := if ( ut.CleanSpacesAndUpper(trim(l.Indiv_Org)) = 'I' , trim(l.First_Name)+ ' ' + trim(l.Middle_Name) + '  ' + trim(l.Org_Last_Name)[1..80] , '' );                                                                                                                      
self.company_name         := if ( ut.CleanSpacesAndUpper(trim(l.Indiv_Org)) <> 'I' , trim(l.First_Name)+ ' ' + trim(l.Middle_Name) + '  ' + trim(l.Org_Last_Name)[1..100] , '' );                                                                                                            
self.license_number            := trim(l.License_Number);                                                                                                                                                                                                                    
self.orig_former_name          := '';                                                                                                                                                                                                                                      
self.business_flag            := if ( ut.CleanSpacesAndUpper(trim(l.Indiv_Org)) = 'I' , 'N' , 'Y' );                                                                                                                                                                                                
self.orig_city                 := trim(l.City);                                                                                                                                                                                                                                   
self.county_str                := trim(l.County);                                                                                                                                                                                                                                
self.license_obtained_by       := '';                                                                                                                                                                                                                                   
self.profession_or_board                := l.Agency_Name;                                                                                                                                                                                                                                 
self.license_type              := trim(l.License_Type)[1..60];                                                                                                                                                                                                                 
self.status                    := l.License_Status;                                                                                                                                                                                                                                  
self.former_name_order        := '';                                                                                                                                                                                                                                     
self.name_order               := 'FML';                                                                                                                                                                                                                                         
self.vendor                   := 'CALIFORNIA DEPARTMENT OF CONSUMER AFFAIRS';                                                                                                                                                                                                       
self.date_first_seen          := fdate;                                                                                                                                                                                                                           
self.date_last_seen           := fdate;                                                                                                                                                                                                                            
self.education_1_school_attended := trim(l.School)[1..30];                                                                                                                                                                                                        
self.education_1_dates_attended := l.Year_Graduated;                                                                                                                                                                                                              
self.education_1_degree     := trim(l.Degree)[1..15];
self := [];                                                                                                                                                                                                               
                                                                                                                                                                                                                 
end;

d_Legout := project ( Inlegacyfile , map2lgc (left));


dCAAll :=  dedup(sort( d_Brzout + d_Legout ,profession_or_board, license_type, status, orig_license_number, license_number, previous_license_number, previous_license_type, 
                      company_name, orig_name, name_order, orig_former_name, former_name_order, orig_addr_1, orig_addr_2, orig_addr_3,orig_addr_4, orig_city, 
											orig_st, orig_zip, county_str, country_str, business_flag, phone, sex, dob, issue_date, expiration_date, last_renewal_date, license_obtained_by, board_action_indicator, source_st, vendor),
											profession_or_board, license_type, status, orig_license_number, license_number, previous_license_number, previous_license_type, 
                      company_name, orig_name, name_order, orig_former_name, former_name_order, orig_addr_1, orig_addr_2, orig_addr_3,orig_addr_4, orig_city, 
											orig_st, orig_zip, county_str, country_str, business_flag, phone, sex, dob, issue_date, expiration_date, last_renewal_date, license_obtained_by, board_action_indicator, source_st, vendor);
											

d_filterlic := 		dCAAll ( Stringlib.StringFind( license_number,'<|=',1) = 0 and profession_or_board <> '' );

//Validate Issue and Expiration dates

Prof_License.Layout_proLic_in valid_date( d_filterlic l ) := transform
self.issue_date := map ( Stringlib.StringFind( l.issue_date,'<|=',1) <> 0 => ' ',
                         l.issue_date[1..2] in ['59','60'] => '',
												 l.issue_date < '19020101' => '', l.issue_date );
											
self.expiration_date := map ( Stringlib.StringFind( l.expiration_date,'<|=',1) <> 0 => ' ',
                         l.expiration_date[1..2] in ['59','60'] => '',
												 l.expiration_date > '20221231' => '', l.expiration_date );
												 
self.status      := map ( Stringlib.StringFind( l.expiration_date,'<|=',1) <> 0 => ' ',
                         l.expiration_date[1..2] in ['59','60'] => '',
												 l.expiration_date > '20221231' => '',
												 l.expiration_date <> '' => 'VALID UNTIL ' + l.expiration_date[5..6] + '/' + l.expiration_date[7..8] + '/' + l.expiration_date[1..4], '');
												 
self.profession_or_board  := if ( trim(l.profession_or_board) = 'BOARD OF LANDSCAPE ARCHITCTS' ,'BOARD OF LANDSCAPE ARCHITECTS',trim(l.profession_or_board));

self := l;

end;

doutfinal := project ( d_filterlic, valid_date(left));
                         

		
		 dout := Sequential( Output( doutfinal,,'~thor_data400::in::prolic::ca::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::ca::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::ca::all_available','~thor_data400::in::prolic::ca::all_available_'+fdate)
															 );
															 
outfile := proc_clean_all(doutfinal,'CA').cleanout;

export buildprep := Sequential(dout, 
                               FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ca'),
												       if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ca_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ca_old')),
								               if ( FileServices.FileExists( '~thor_data400::in::prolic_ca_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_ca_old')),
                               FileServices.RenameLogicalfile( '~thor_data400::in::prolic_ca','~thor_data400::in::prolic_ca_old'),
   										         output( outfile,,'~thor_data400::in::prolic_ca',compressed,overwrite),
                               FileServices.StartSuperfiletransaction(),
												         FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ca'),
															   FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old::cmp','~thor_data400::in::prolic_ca_old'),
											         FileServices.FinishSuperfiletransaction()
											       );

end;                                                                                                                             
		
		

