import Prof_License,ut;

EXPORT Map_IA(dataset({string ftype,string fdate})infile) := module

filedate_md := infile(ftype = 'medical')[1].fdate;

Prof_License.Layout_proLic_in  map2common( Files_IA.Medical l ) := transform

  self.source_st := 'IA';                                                                        
  self.expiration_date := if ( fSlashedMDYtoCYMD(l.ExpirationDate) = '00000000','',fSlashedMDYtoCYMD(l.ExpirationDate)) ;                               
  self.issue_date := if ( fSlashedMDYtoCYMD(l.OriginalIssueDate) = '00000000','',fSlashedMDYtoCYMD(l.OriginalIssueDate)) ;                                 
  self.vendor := 'Iowa Board of Medical Examiners';                                          
  self.phone := StringLib.Stringfilter(l.BusinessPhone,'0123456789')[1..10];         
  self.dob := l.BirthYear;                                                             
  self.profession_or_board := 'Medical';                                                              
  self.orig_st := trim(l.State)[1..2];                             
  self.county_str := map ( l.County = '0 ' => ' Unknown, N/A',              
                      l.County = '1 ' => 'Adair        ',              
                      l.County = '2 ' => 'Adams        ',              
                      l.County = '3 ' => 'Allamakee    ',              
                      l.County = '4 ' => 'Appanoose    ',              
                      l.County = '5 ' => 'Audubon      ',              
                      l.County = '6 ' => 'Benton       ',              
                      l.County = '7 ' => 'Black Hawk   ',              
                      l.County = '8 ' => 'Boone        ',              
                      l.County = '9 ' => 'Bremer       ',              
                      l.County = '10' => 'Buchanan     ',              
                      l.County = '11' => 'Buena Vista  ',              
                      l.County = '12' => 'Butler       ',              
                      l.County = '13' => 'Calhoun      ',              
                      l.County = '14' => 'Carroll      ',              
                      l.County = '15' => 'Cass         ',              
                      l.County = '16' => 'Cedar        ',              
                      l.County = '17' => 'Cerro Gordo  ',              
                      l.County = '18' => 'Cherokee     ',              
                      l.County = '19' => 'Chickasaw    ',              
                      l.County = '20' => 'Clarke       ',              
                      l.County = '21' => 'Clay         ',              
                      l.County = '22' => 'Clayton      ',              
                      l.County = '23' => 'Clinton      ',              
                      l.County = '24' => 'Crawford     ',              
                      l.County = '25' => 'Dallas       ',              
                      l.County = '26' => 'Davis        ',              
                      l.County = '27' => 'Decatur      ',              
                      l.County = '28' => 'Delaware     ',              
                      l.County = '29' => 'Des Moines   ',              
                      l.County = '30' => 'Dickinson    ',              
                      l.County = '31' => 'Dubuque      ',              
                      l.County = '32' => 'Emmet        ',              
                      l.County = '33' => 'Fayette      ',              
                      l.County = '34' => 'Floyd        ',              
                      l.County = '35' => 'Franklin     ',              
                      l.County = '36' => 'Fremont      ',              
                      l.County = '37' => 'Greene       ',              
                      l.County = '38' => 'Grundy       ',              
                      l.County = '39' => 'Guthrie      ',              
                      l.County = '40' => 'Hamilton     ',              
                      l.County = '41' => 'Hancock      ',              
                      l.County = '42' => 'Hardin       ',              
                      l.County = '43' => 'Harrison     ',              
                      l.County = '44' => 'Henry        ',              
                      l.County = '45' => 'Howard       ',              
                      l.County = '46' => 'Humboldt     ',              
                      l.County = '47' => 'Ida          ',              
                      l.County = '48' => 'Iowa         ',              
                      l.County = '49' => 'Jackson      ',              
                      l.County = '50' => 'Jasper       ',              
                      l.County = '51' => 'Jefferson    ',              
                      l.County = '52' => 'Johnson      ',              
                      l.County = '53' => 'Jones        ',              
                      l.County = '54' => 'Keokuk       ',              
                      l.County = '55' => 'Kossuth      ',              
                      l.County = '56' => 'Lee          ',              
                      l.County = '57' => 'Linn         ',              
                      l.County = '58' => 'Louisa       ',              
                      l.County = '59' => 'Lucas        ',              
                      l.County = '60' => 'Lyon         ',              
                      l.County = '61' => 'Madison      ',              
                      l.County = '62' => 'Mahaska      ',              
                      l.County = '63' => 'Marion       ',              
                      l.County = '64' => 'Marshall     ',              
                      l.County = '65' => 'Mills        ',              
                      l.County = '66' => 'Mitchell     ',              
                      l.County = '67' => 'Monona       ',              
                      l.County = '68' => 'Monroe       ',              
                      l.County = '69' => 'Montgomery   ',              
                      l.County = '70' => 'Muscatine    ',              
                      l.County = '71' => 'OBrien      ',              
                      l.County = '72' => 'Osceola      ',              
                      l.County = '73' => 'Page         ',              
                      l.County = '74' => 'Palo Alto    ',              
                      l.County = '75' => 'Plymouth     ',              
                      l.County = '76' => 'Pocahontas   ',              
                      l.County = '77' => 'Polk         ',              
                      l.County = '78' => 'Pottawattamie',              
                      l.County = '79' => 'Poweshiek    ',              
                      l.County = '80' => 'Ringgold     ',              
                      l.County = '81' => 'Sac          ',              
                      l.County = '82' => 'Scott        ',              
                      l.County = '83' => 'Shelby       ',              
                      l.County = '84' => 'Sioux        ',              
                      l.County = '85' => 'Story        ',              
                      l.County = '86' => 'Tama         ',              
                      l.County = '87' => 'Taylor       ',              
                      l.County = '88' => 'Union        ',              
                      l.County = '89' => 'Van Buren    ',              
                      l.County = '90' => 'Wapello      ',              
                      l.County = '91' => 'Warren       ',              
                      l.County = '92' => 'Washington   ',              
                      l.County = '93' => 'Wayne        ',              
                      l.County = '94' => 'Webster      ',              
                      l.County = '95' => 'Winnebago    ',              
                      l.County = '96' => 'Winneshiek   ',              
                      l.County = '97' => 'Woodbury     ',              
                      l.County = '98' => 'Worth        ',              
                      l.County = '99' => 'Wright       ', '' );             
               
                                     
                     
                    
  self.license_number := l.LicenseNumber;                                                   
  self.license_type := trim(l.LicenseType);                                        
  self.orig_name := trim(l.FirstName) +  ' ' + trim(l.MiddleName) +  ' ' + trim(l.LastName) [1..80];        
                          
  self.name_order := 'FML';                                                                  
  self.orig_addr_1 := l.AddressLine1;                                                       
 // self.orig_addr_2 := l.AddressLine2;                                                       
  self.status :=  trim(l.LicenseStatus);                                            
  self.orig_zip := StringLib.Stringfilter(l.Zipcode, '0123456789')[1..9];          
  self.orig_city := l.City;                                                                 
  self.date_first_seen := filedate_md;                                                   
  self.date_last_seen := filedate_md;                                                    
  self.misc_practice_type := trim(l.Specialty1);                                   
  self.education_1_school_attended := trim(l.MedicalSchool)[1..30];   
  self.education_1_dates_attended := l.GraduationYear;                                      
  self.additional_licensing_specifics := if ( l.PublicDiscipline <> '' ,  'Public Info: ' +   trim(l.PublicDiscipline,left,right) , '');
	self := [];
	end;
	
	dIAMedout := project( Files_IA.Medical, map2common(left));
	
	dMedicalSF := Sequential( Output( dIAMedout,,'~thor_data400::in::prolic::ia::medical_'+filedate_md,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::ia::medical'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::ia::medical','~thor_data400::in::prolic::ia::medical_'+filedate_md)
															 );
	
	filedate_dent := infile(ftype = 'dentist')[1].fdate;
// Dentistis
Prof_License.Layout_proLic_in  map2commondt( Files_IA.Dentist l ) := transform

  self.date_first_seen         := filedate_dent;
  self.date_last_seen          := filedate_dent;
  self.profession_or_board              := 'Dentist';
  self.license_type            := l.lic_type;
  self.orig_name               := l.first_name + ' '  + l.middle_name + ' ' + l.last_name;
  self.name_order              := 'FML';
  self.orig_addr_1             := StringLib.stringfilterout(trim(l.address1),'\'')[1..80];
  self.orig_city               := l.city;
  self.orig_st                 := l.state;
  self.orig_zip                := StringLib.stringfilterout(l.zip,' -');
  self.source_st               := 'IA';
  self.vendor                  := 'IOWA Board Of Dental Examiners';
  self.license_number          := l.license_number;
  self.expiration_date         := fSlashedMDYtoCYMD(l.expires);
  self.issue_date              := fSlashedMDYtoCYMD(l.orig_issue);
  self.status                  := l.license_status;
  self.misc_practice_type      := l.specialty;
  self.county_str              := l.county;
self := [];
	end;
	
	dIADentout := project( Files_IA.Dentist, map2commondt(left));
	
	dIADentSF := Sequential( Output( dIADentout,,'~thor_data400::in::prolic::ia::dentist_'+filedate_dent,overwrite),
		                           FileServices.ClearSuperfile( '~thor_data400::in::prolic::ia::dentist'),
															 FileServices.AddSuperfile( '~thor_data400::in::prolic::ia::dentist','~thor_data400::in::prolic::ia::dentist_'+filedate_dent)
															 );
															 
doutfinal := map ( count(infile(ftype = 'dentist')) = 1 and count(infile) = 1 => dIADentout, 
               count(infile(ftype = 'medical')) = 1 and count(infile) = 1  => dIAMedout,
								  dIADentout + dIAMedout );

 
 
dout :=  map ( count(infile(ftype = 'dentist')) = 1 and count(infile) = 1 => dIADentSF,
												                                                        
								        	count(infile(ftype = 'medical')) = 1	and count(infile) = 1 =>	   dMedicalSF,
													Sequential( dIADentSF,dMedicalSF)
							);
							
doutfinal1 := dataset('~thor_data400::in::prolic::ia::medical',Prof_License.Layout_proLic_in,flat);
 
 outfile := proc_clean_all(doutfinal1,'IA').cleanout;
 
 export buildprep :=  Sequential( dout,
                                   FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ia'),
																	   if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ia_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ia_old')),
								       if ( FileServices.FileExists( '~thor_data400::in::prolic_ia_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_ia_old')),
                       FileServices.RenameLogicalfile( '~thor_data400::in::prolic_ia','~thor_data400::in::prolic_ia_old'),
                         
											output( outfile,,'~thor_data400::in::prolic_ia',compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_ia'),
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_ia_old'),

												 FileServices.FinishSuperfiletransaction()

											 );
											 
end;
