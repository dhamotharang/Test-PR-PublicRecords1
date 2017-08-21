import Prof_License,lib_stringlib;

EXPORT Map_MS_All_Available( string fdate) := module

fin_ms := File_MS_All_Available.raw ;



Prof_License.Layout_proLic_in map2comm( fin_ms l) := transform

Issued_Date := map ( length(trim(l.Original_Issued_Date)) = 6 and trim(l.Original_Issued_Date)[4] = '-'  =>  (string)intformat((integer)trim(l.Original_Issued_Date)[1],2,0) + '-' + (string)intformat((integer)trim(l.Original_Issued_Date)[3],2,0) + '-' + if  (l.Original_Issued_Date[5] = '0' or l.Original_Issued_Date[5] = '1'  , '20' , '19' ) + l.Original_Issued_Date[5..6] ,                                                                                       
     length(trim(l.Original_Issued_Date)) = 7 and trim(l.Original_Issued_Date)[3]  = '-' =>  trim(l.Original_Issued_Date)[1..2] + '-' + (string)intformat((integer)trim(l.Original_Issued_Date)[4],2,0) + '-' + if (l.Original_Issued_Date[6] = '0'  or  l.Original_Issued_Date[6] = '1'  , '20' , '19') + l.Original_Issued_Date[6..7] ,                                                                                                    
     length(trim(l.Original_Issued_Date)) = 7 and trim(l.Original_Issued_Date)[2]  = '-' =>  (string)intformat((integer)trim(l.Original_Issued_Date)[1],2,0) + '-' + trim(l.Original_Issued_Date)[3..4] + '-' + if ( l.Original_Issued_Date[6] = '0' or l.Original_Issued_Date[6] = '1'  , '20' , '19') + l.Original_Issued_Date[6..7] ,                                                                                                    
     length(trim(l.Original_Issued_Date)) = 8 and trim(l.Original_Issued_Date)[3]  = '-' =>  l.Original_Issued_Date[1..6] + if ( l.Original_Issued_Date[7] = '0' or l.Original_Issued_Date[7] = '1'  , '20' , '19' ) + l.Original_Issued_Date[7..8] ,                                                                                                                                                                        
     length(trim(l.Original_Issued_Date)) = 8 and trim(l.Original_Issued_Date)[2]  = '-' =>  (string)intformat((integer)trim(l.Original_Issued_Date)[1],2,0) + '-' + (string)intformat((integer)trim(l.Original_Issued_Date)[3],2,0) + '-' + l.Original_Issued_Date[5..8]  , l.Original_Issued_Date );                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                 
 Expire_Date  :=  map ( length(trim(l.License_Expires)) = 6 and trim(l.License_Expires)[4] = '-'  =>  (string)intformat((integer)trim(l.License_Expires)[1],2,0) + '-' + (string)intformat((integer)trim(l.License_Expires)[3],2,0) + '-' + if  (l.License_Expires[5] = '0' or l.License_Expires[5] = '1'  , '20' , '19' ) + l.License_Expires[5..6] ,                                                                                                               
     length(trim(l.License_Expires)) = 7 and trim(l.License_Expires)[3]  = '-' =>  trim(l.License_Expires)[1..2] + '-' + (string)intformat((integer)trim(l.License_Expires)[4],2,0) + '-' + if (l.License_Expires[6] = '0'  or  l.License_Expires[6] = '1'  , '20' , '19') + l.License_Expires[6..7] ,                                                                                                                            
     length(trim(l.License_Expires)) = 7 and trim(l.License_Expires)[2]  = '-' =>  (string)intformat((integer)trim(l.License_Expires)[1],2,0) + '-' + trim(l.License_Expires)[3..4] + '-' + if ( l.License_Expires[6] = '0' or l.License_Expires[6] = '1'  , '20' , '19') + l.License_Expires[6..7] ,                                                                                                                            
     length(trim(l.License_Expires)) = 8 and trim(l.License_Expires)[3]  = '-' =>  l.License_Expires[1..6] + if ( l.License_Expires[7] = '0' or l.License_Expires[7] = '1'  , '20' , '19' ) + l.License_Expires[7..8] ,                                                                                                                                                                                           
     length(trim(l.License_Expires)) = 8 and trim(l.License_Expires)[2]  = '-' =>  (string)intformat((integer)trim(l.License_Expires)[1],2,0) + '-' + (string)intformat((integer)trim(l.License_Expires)[3],2,0) + '-' + l.License_Expires[5..8]  , l.License_Expires );                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                


  self.date_first_seen      := fdate;                                                   
  self.date_last_seen       := fdate;                                                    
  self.profession_or_board           := 'Respiratory Care Practitioner';                                       
  self.license_type         := l.License_Type;                                                      
  self.business_flag       := 'N';                                                               
  self.orig_name            := l.First_Name +  ' ' +   l.Last_Name;   
  self.name_order           := 'FML';                                                                 
  self.orig_addr_1          := l.Home_Address_1;                                                          
  self.orig_city            := l.Home_City;                                                                 
  self.orig_st              := trim(l.Home_State);                                                   
  self.orig_zip             := Stringlib.stringfilter(l.Home_Zip, '0123456789');                                      
  self.dob                 := '';                                       
  self.expiration_date      := if ( fSlashedMDYtoCYMD(Expire_Date) = '00000000' ,'',fSlashedMDYtoCYMD(Expire_Date));                              
  self.issue_date           := if ( fSlashedMDYtoCYMD(Issued_Date) = '00000000','',fSlashedMDYtoCYMD(Issued_Date));                              
  self.source_st            := 'MS';                                                                   
  self.vendor               := 'Mississippi State Department of Health';                                  
  self.license_number       := l.Whole_License_Number;                                                  
  self.status               := l.License_Status;                                                          
                                                                                                                                                                                                       
  self := [];
end;                                                                

fout_MS := project ( fin_ms , map2comm (left));

 dout := Sequential( Output( fout_MS,,'~thor_data400::in::prolic::ms::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::ms::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::ms::all_available','~thor_data400::in::prolic::ms::all_available_'+fdate)
															 );
															 
outfile := proc_clean_all(fout_ms,'MS').cleanout;

export buildprep := Sequential(dout, 
                    FileServices.StartSuperfiletransaction(),
                        FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ms'),
                if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ms_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ms_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_ms_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_ms_old')),
                 			   FileServices.RenameLogicalfile( '~thor_data400::in::prolic_ms','~thor_data400::in::prolic_ms_old'),
										    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ms_old'),    
										FileServices.FinishSuperfiletransaction(),
                         
											output( outfile,,'~thor_data400::in::prolic_ms',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
								
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ms'),
	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		


