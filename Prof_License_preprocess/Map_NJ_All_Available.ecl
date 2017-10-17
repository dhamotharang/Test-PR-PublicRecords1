EXPORT Map_NJ_All_Available(string fdate) := module

Import Prof_License,ut;

Prof_License.Layout_proLic_in map2all( File_NJ_All_Available.raw l) := transform
 
  self.profession_or_board                  := l.PN_PROFESSION_NAME;
  self.license_type                := l.CIL_ITEM_TEXT;
  self.status                      := l.CI_ITEM_TEXT;
  self.license_number              := l.L_LICENSE_NO;
  self.company_name           := if ( trim(l.P_IS_ORGANIZATION) = 'Y',trim(l.ORG_NAME)[1..100],'');
  self.orig_addr_1                 := l.ADDR_1[1..80];
  self.orig_addr_2                 := l.ADDR_2;
  self.orig_addr_3                 := l.ADDR_3;
  self.orig_addr_4                 := l.ADDR_4;
  self.county_str                  := trim(l.COUNTY);
  self.dob                    := '';
  self.orig_former_name            := '';
  //self.license_obtained_by         := l.orig_obtained_by;
  self.business_flag              := l.P_IS_ORGANIZATION;
  self.issue_date                  := if ( l.L_ISSUE_DATE <> '', if  ( l.L_ISSUE_DATE[8..9]  > '50' , '19' ,'20') + 
                                            l.L_ISSUE_DATE[8..9] + 
                                         case( l.L_ISSUE_DATE[4..6],
                                              'JAN' => '01' ,
                                              'FEB' => '02' ,
                                              'MAR' => '03' ,
                                              'APR' => '04' ,
                                              'MAY' => '05' ,
                                              'JUN' => '06' ,
                                              'JUL' => '07' ,
                                              'AUG' => '08' ,
                                              'SEP' => '09' ,
                                              'OCT' => '10' ,
                                              'NOV' => '11' ,

                                              '12' )+ l.L_ISSUE_DATE[1..2],'');
  self.expiration_date             := if ( l.L_EXPIRATION_DATE <> '', if  ( l.L_EXPIRATION_DATE[8..9]  > '50' , '19' ,'20') + 
                                            l.L_EXPIRATION_DATE[8..9] + 
                                         case( l.L_EXPIRATION_DATE[4..6],
                                              'JAN' => '01' ,
                                              'FEB' => '02' ,
                                              'MAR' => '03' ,
                                              'APR' => '04' ,
                                              'MAY' => '05' ,
                                              'JUN' => '06' ,
                                              'JUL' => '07' ,
                                              'AUG' => '08' ,
                                              'SEP' => '09' ,
                                              'OCT' => '10' ,
                                              'NOV' => '11' ,

                                              '12' )+ l.L_EXPIRATION_DATE[1..2],'');
  self.last_renewal_date           := if ( l.L_DATE_LAST_RENEWAL <> '',if  ( l.L_DATE_LAST_RENEWAL[8..9]  > '50' , '19' ,'20') + 
                                            l.L_DATE_LAST_RENEWAL[8..9] + 
                                         case( l.L_DATE_LAST_RENEWAL[4..6],
                                              'JAN' => '01' ,
                                              'FEB' => '02' ,
                                              'MAR' => '03' ,
                                              'APR' => '04' ,
                                              'MAY' => '05' ,
                                              'JUN' => '06' ,
                                              'JUL' => '07' ,
                                              'AUG' => '08' ,
                                              'SEP' => '09' ,
                                              'OCT' => '10' ,
                                              'NOV' => '11' ,

                                              '12' )+ l.L_DATE_LAST_RENEWAL[1..2],'');
	self.orig_name                   :=  trim(l.P_FIRST_NAME)+ ' '+ trim(l.P_MIDDLE_NAME)+' ' + trim(l.P_LAST_NAME) [1..80];

  self.source_st                   := 'NJ';
  self.name_order                  := if ( trim(l.P_FIRST_NAME) + ' ' + trim(l.P_MIDDLE_NAME) + ' '+ trim(l.P_LAST_NAME)   <> '','FML','');
  self.former_name_order           := '';
  self.date_first_seen             := fdate;
  self.date_last_seen              := fdate;
	self.vendor                      := 'New Jersey Division of Consumer Affairs'; 
  self.additional_orig_city        := l.CITY;                 
  self.orig_city                   := l.CITY;                            
  self.orig_st                     := trim(l.STATE);                          
  self.orig_zip                    := l.ZIP;                              
  self.country_str                 := l.COUNTRY; 
	self := [];
	end;
	
	dNJAll := project( File_NJ_All_Available.raw ( PN_PROFESSION_NAME <>  'PN.PROFESSION_NAME||\'' ) ,map2all(left));
	
	dout := Sequential( Output( dNJAll,,'~thor_data400::in::prolic::nj::all_available_'+fdate,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::nj::all_available'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::nj::all_available','~thor_data400::in::prolic::nj::all_available_'+fdate)
															 );
															 
outfile := proc_clean_all(dNJAll,'NJ').cleanout;

export buildprep := Sequential(dout, 
                        FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_nj'),
                 if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_nj_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_nj_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_nj_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_nj_old')),
                     			   FileServices.RenameLogicalfile( '~thor_data400::in::prolic_nj','~thor_data400::in::prolic_nj_old'),
                         
											output( outfile,,'~thor_data400::in::prolic_nj',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
								
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_nj'),
	 										    FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_nj_old'),

	
											   FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		

