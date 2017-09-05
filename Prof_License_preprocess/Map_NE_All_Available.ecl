import Prof_License;

EXPORT Map_NE_All_Available( string fdate) := module

// Filter out other than 21
fin_ne := File_NE_All_Available.raw ( continuation = '0' ) ; 


Prof_License.Layout_proLic_in map2comm( fin_ne l) := transform

 self.license_type          := l.License_Type;                                                            
 self.business_flag        := 'N';                                                                     
 self.source_st             := 'NE';                                                                         
 self.orig_name             := if ( l.Full_Name <> '', trim(l.Full_Name)[1..80 ] , trim(l.First_Name) + ' ' + trim(l.Middle_Name) + ' ' + trim(l.Last_Name));                                                                                                                                                                   
 self.company_name     := ' ';                                                                  
 self.orig_addr_1           := l.Address_line_1;                                                           
 self.orig_addr_2           := l.Add_Line_2;                                                               
 self.orig_city             := l.City;                                                                       
 self.orig_st               := l.State[1..2];                                                
 self.orig_zip              := StringLib.stringfilter(l.Zip, '0123456789');                                            
 self.sex                   := ' ';                                                                                
 self.license_obtained_by   := ' ';                                                                
 self.county_str            := l.County;                                                                    
 self.country_str           := '';                                                                         
 self.status                := trim(l.Status);                                                                  
 self.expiration_date       := if ( fSlashedMDYtoCYMD(l.Expiration_Date) = '00000000' , '',fSlashedMDYtoCYMD(l.Expiration_Date));                                    
 self.issue_date            := if ( fSlashedMDYtoCYMD(l.Issue_Date) = '00000000' , '', fSlashedMDYtoCYMD(l.Issue_Date));                                              
 self.last_renewal_date     := ' ';                                                                  
 self.name_order            := 'FML';                                                                       
 self.vendor                := 'Nebraska Interactive';                                                          
 self.orig_former_name      := ' ';                                                                   
 self.license_number        := trim(l.License_No);                                                      
 self.phone                 := ' ';                                                                              
 self.orig_addr_3           := l.Add_Line_3;                                                               
 self.dob                   := ' ';                                                                           
 self.date_first_seen       := fdate;                                                         
 self.date_last_seen        := fdate;                                                          
 self.additional_orig_name  := '';                                                                
 self.additional_name_order  := '';                                                               
 self.additional_licensing_specifics := '';                                                      
 self.board_action_indicator    := ' ';                                                             
 self.action_effective_dt       := ' ';                                                                
 self.action_desc               := ' ';                                                                        
 self.orig_addr_4               := ' ';                                                                        
 self.profession_or_board       := l.Profession;                                                                
 self := [];
 end;

fout_ne := project ( fin_ne ( Profession <> '')  , map2comm (left));

 dout := Sequential( Output( fout_ne,,'~thor_data400::in::prolic::ne::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::ne::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::ne::all_available','~thor_data400::in::prolic::ne::all_available_'+fdate)
															 );
															 
outfile := proc_clean_all(fout_ne,'NE').cleanout;

export buildprep := Sequential(dout, 
                        FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ne'),
                        if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ne_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ne_old')),
								        if ( FileServices.FileExists( '~thor_data400::in::prolic_ne_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_ne_old')),
                        FileServices.RenameLogicalfile( '~thor_data400::in::prolic_ne','~thor_data400::in::prolic_ne_old'),            
												   
										FileServices.FinishSuperfiletransaction(),
                        
											output( outfile,,'~thor_data400::in::prolic_ne',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
						
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ne'),
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old::cmp','~thor_data400::in::prolic_ne_old'),
	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		


