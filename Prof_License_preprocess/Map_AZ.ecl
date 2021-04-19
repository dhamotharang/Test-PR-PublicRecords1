EXPORT Map_AZ(dataset({string ftype,string fdate})infile) := module
import Prof_License, lib_StringLib, ut;

//Map to final layout
acuraw := File_AZ.acup;

Prof_License.Layout_proLic_in t_common( acuraw l) := transform
self.date_first_seen           := infile(ftype = 'acupuncturist')[1].fdate;                                                                                                                                                                                                                                                    
self.date_last_seen            := infile(ftype = 'acupuncturist')[1].fdate;                                                                                                                                                                                                                                                    
self.source_st                 := 'AZ';
self.vendor                    := 'Arizona Acupuncture Board of Examiners';
self.profession_or_board       := 'Acupuncturists';
self.license_number            := l.License_Number;
self.orig_name                 := trim(l.Last_Name)+' '+ trim(l.First_Name);
self.name_order                := 'LFM';
self.expiration_date           := Prof_License_preprocess.dateconv(l.License_Expiration_Date);
self.issue_date           := Prof_License_preprocess.dateconv(l.License_Issue_Date);

self.status                    := l.Status_of_License;
self.orig_addr_1               := l.Address1;
//self.orig_addr_2               := l.Address2;
//self.orig_city                 := l.City;
//self.orig_st                   := if ( length(trim(l.State)) > 2 , '' , trim(l.State) ) ;
//self.orig_zip                  := regexreplace('-',trim(l.ZIP),'')[1..9];
//self.company_name              := l.BusinessName;
self.license_type              := l.License_Type;                                                                                                              
self := l;                                                                                                                                                                                                                                                                                           
self := [];                                                                                                                                                                                                                                                                                          

end;

dIn_ACU := project( acuraw,t_common(left));

dIn_ACUSF := Sequential( 
                       if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::az::acupuncturist'),FileServices.CreateSuperfile('~thor_data400::in::prolic::az::acupuncturist'), 
                                                                                                              FileServices.ClearSuperfile( '~thor_data400::in::prolic::az::acupuncturist')),

                        output(dIn_ACU,,'~thor_data400::in::prolic::az::acupuncturist_'+infile(ftype = 'acupuncturist')[1].fdate,compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::az::acupuncturist','~thor_data400::in::prolic::az::acupuncturist_'+infile(ftype = 'acupuncturist')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );
											 

//RDA

osraw := File_AZ.ostp;

Prof_License.Layout_proLic_in map2ost( osraw l) := transform
  self.date_first_seen          := infile(ftype = 'osteopath')[1].fdate;                                  
  self.date_last_seen           := infile(ftype = 'osteopath')[1].fdate;                                  
  self.source_st                := 'AZ';
  self.vendor                   := 'Arizona Board of Osteopathic Examiners in Med and Surgery';
  self.profession_or_board               := 'Osteopathy';
  self.license_type             := if ( trim(l.License_Type_ID) = 'DO License' , 'Doctor of Osteopathic Medicine' , '');
  self.license_number           := l.License_Number;
  self.orig_name                := trim(l.Last_Name) + ' ' + trim(l.First_Name) + ' ' + trim(l.MI_Name);
  self.name_order               := 'LFM';
  self.issue_date               := Prof_License_preprocess.dateconv(l.Licensed_Date);
  self.expiration_date          := Prof_License_preprocess.dateconv(l.Expiration_Date);
  self.last_renewal_date        := Prof_License_preprocess.dateconv(l.Due_To_Renew_By);
  self.status                   := l.License_Status;
  self.phone                    := StringLib.stringfilterout(trim(l.Office_Phone),'.()- ')[1..10];
  self.orig_addr_1              := l.Street;
  self.orig_addr_2              := l.Street_2;
  self.orig_city                := l.Office_City;
  self.orig_st                  := l.Office_State;
  self.orig_zip                 := regexreplace('-',trim(l.Office_Zip),'')[1..9];
  self.additional_name_addr_type := 'Office Addr';
  self.education_1_school_attended := l.Medical_School[1..30];
  self.education_1_dates_attended := l.Graduation_Date;
  self.misc_practice_type         := trim(l.Area_of_Interest1)[1..50];
	self := l;                                                                                                                                                                                                                                                                                           

self := []; 
end;                                                                                

dIn_OSTP := project( osraw,map2ost(left));

dIn_OSTPSF := Sequential( 
                       if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::az::osteopath'),FileServices.CreateSuperfile('~thor_data400::in::prolic::az::osteopath'), 
                                                                                                              FileServices.ClearSuperfile( '~thor_data400::in::prolic::az::osteopath')),

                        output(dIn_OSTP,,'~thor_data400::in::prolic::az::osteopath_'+infile(ftype = 'osteopath')[1].fdate,compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::az::osteopath','~thor_data400::in::prolic::az::osteopath_'+infile(ftype = 'osteopath')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );
											 

//RDH
nurseraw := File_AZ.nurse;
Prof_License.Layout_proLic_in map2nurse( nurseraw l) := transform
self.date_first_seen         := infile(ftype = 'nurse')[1].fdate;                                  
self.date_last_seen          := infile(ftype = 'nurse')[1].fdate;                                   
self.source_st               := 'AZ';
self.vendor                  := 'Arizona State Board of Nursing';
self.profession_or_board              := 'Nurse';
self.license_number          := l.LICENSENUMBER;
self.orig_name               := trim(l.LASTNAME)+' ' + trim(l.FIRSTNAME) + ' ' + trim(l.MIDDLENAME);
self.name_order              := 'LFM';
self.expiration_date         := Prof_License_preprocess.dateconv(l.EXPIRATIONDATE);
self.issue_date              := Prof_License_preprocess.dateconv(l.ORIGINALISSUEDATE);
self.status                  := l.LICENSESTATUS;
self.orig_addr_1             := l.ADDRESS1;
self.orig_addr_2             := l.ADDRESS2;
self.orig_addr_3             := trim(l.ADDRESS3);
self.orig_city               := l.CITY;
self.orig_st                 := l.STATE;
self.orig_zip                :=  regexreplace('-',trim(l.ZIPCODE),'')[1..9];
self.license_type           := l.ADVANCEDTYPE;
self.misc_practice_type     := trim(l.ADVANCEDSPECIALTY)[1..50];
self.education_1_degree     :=  regexreplace('Asssociates',
                                                        regexreplace('Masters',
                                                                     regexreplace('Bachelors',trim(l.HIGHESTDEGREE),
                                                                                   'B.S') 
                                                                    ,'M.S'),
                                                         'A.S')[1..15];



                                            
  self.county_str := l.COUNTY;
  self.misc_other_id := l.OTHERLLICENSES;
	self := l;                                                                                                                                                                                                                                                                                           

self := [];                                                                                                                                                      
end;

dIn_NURSE := project( nurseraw,map2nurse(left));

dIn_NURSESF := Sequential( 
                       if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::az::nurse'),FileServices.CreateSuperfile('~thor_data400::in::prolic::az::nurse'), 
                                                                                                              FileServices.ClearSuperfile( '~thor_data400::in::prolic::az::nurse')),

                        output(dIn_NURSE,,'~thor_data400::in::prolic::az::nurse_'+infile(ftype = 'nurse')[1].fdate,compressed,overwrite),
                         FileServices.StartSuperfiletransaction(),
												 
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::az::nurse','~thor_data400::in::prolic::az::nurse_'+infile(ftype = 'nurse')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );


Prof_License.Layout_proLic_in pharm_common( File_AZ.pharm l) := transform

self.date_first_seen      := infile(ftype = 'pharmacy')[1].fdate;                                                 
self.date_last_seen       := infile(ftype = 'pharmacy')[1].fdate;                                                 
self.source_st            := 'AZ';
self.vendor               := 'Arizona State Board of Pharmacy';
self.profession_or_board           := 'Pharmacy';
self.license_number       := l.License_Number;
self.name_order           := '';
self.expiration_date      := Prof_License_preprocess.dateconv(l.Effective_To);
self.issue_date           := Prof_License_preprocess.dateconv(l.Original_Licensure_Date);
self.last_renewal_date    := Prof_License_preprocess.dateconv(l.Effective_From);
//self.dob                  := Prof_License_preprocess.dateconv(l.DOB);
self.status               := l.Status;
self.orig_addr_1          := l.Address;
self.orig_city            := trim(l.City)[1..40];
self.orig_st              := l.State;
self.orig_zip             := regexreplace('-',trim(l.Zip),'')[1..9];
self.license_type         := l.License_Type;
//self.county_str            := l.County;
self.company_name     := '';
self := l;                                                                                                                                                                                                                                                                                           

self := [];                                              
end;                                                                                           

dIn_PHARM := project( File_AZ.pharm,pharm_common(left));

dIn_PHARMSF := Sequential(   
	                         if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::az::pharmacy'),
												                                                              FileServices.CreateSuperfile('~thor_data400::in::prolic::ar::pharmacy'),
                                                                                      FileServices.ClearSuperfile( '~thor_data400::in::prolic::az::pharmacy')
															 ),
                        output(dIn_PHARM,,'~thor_data400::in::prolic::az::pharmacy_'+infile(ftype = 'pharmacy')[1].fdate,compressed,overwrite);
                         FileServices.StartSuperfiletransaction(),
								
												 FileServices.AddSuperfile( '~thor_data400::in::prolic::az::pharmacy','~thor_data400::in::prolic::az::pharmacy_'+infile(ftype = 'pharmacy')[1].fdate),
											   FileServices.FinishSuperfiletransaction()
											 );



prep :=  Sequential( if ( count(infile(ftype = 'acupuncturist')) = 1 , dIn_ACUSF ), 
                     if (  count(infile(ftype = 'osteopath')) = 1  , dIn_OSTPSF ),
								      if (  count(infile(ftype =	'pharmacy')) = 1  , dIn_PHARMSF ),
											if (		 count(infile(ftype =	'nurse')) = 1  , dIn_NURSESF ),
							              Output('All_Inputs_added')
												 
								)  ;
 

input :=   map ( count(infile(ftype = 'acupuncturist')) = 1 and count(infile) = 1  => dIn_ACU , 
                            count(infile(ftype = 'osteopath')) = 1 and count(infile) = 1    => dIn_OSTP , 
								            count(infile(ftype =	'pharmacy')) = 1 	and count(infile) = 1 => dIn_PHARM ,
								             count(infile(ftype =	'nurse')) = 1 and count(infile) = 1	 => dIn_NURSE,
														 count(infile(ftype in [ 'acupuncturist','osteopath'])) = 2 and count(infile) = 2 => dIn_ACU + dIn_OSTP ,
														 count(infile(ftype in [ 'acupuncturist','pharmacy'])) = 2 and count(infile) = 2 => dIn_ACU + dIn_PHARM ,
														 count(infile(ftype in [ 'osteopath','pharmacy'])) = 2 and count(infile) = 2 => dIn_OSTP + dIn_PHARM ,
														 count(infile(ftype in [ 'nurse','pharmacy'])) = 2 and count(infile) = 2 => dIn_NURSE + dIn_PHARM ,
														 count(infile(ftype in [ 'nurse','acupuncturist'])) = 2 and count(infile) = 2 => dIn_NURSE + dIn_ACU ,
														 count(infile(ftype in [ 'nurse','osteopath'])) = 2 and count(infile) = 2 => dIn_NURSE + dIn_OSTP ,
														 count(infile(ftype in ['acupuncturist', 'nurse','osteopath'])) = 3 and count(infile) = 3 => dIn_ACU + dIn_NURSE + dIn_OSTP ,
														 count(infile(ftype in [ 'acupuncturist','osteopath','pharmacy'])) = 3 and count(infile) = 3 => dIn_ACU + dIn_OSTP + dIn_PHARM ,
														 count(infile(ftype in ['osteopath', 'nurse','pharmacy'])) = 3 and count(infile) = 3 => dIn_OSTP + dIn_NURSE + dIn_PHARM ,
														 dIn_ACU + dIn_OSTP + dIn_NURSE + dIn_PHARM

														);
											
							


outfile := proc_clean_all(input,'AZ').cleanout;

azbase := dataset('~thor_data400::in::prolic_az',Prof_License.Layout_proLic_in ,flat);


//Verifying License numbers in  base from prep file
validate_prep := Prof_License_preprocess.fn_ValidateLicInBase (input, azbase,'az').out;

 superfile_trans := Sequential(    FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_az'),
                        if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_az_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_az_old')),
								        if ( FileServices.FileExists( '~thor_data400::in::prolic_az_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_az_old')),
                        FileServices.RenameLogicalfile( '~thor_data400::in::prolic_az','~thor_data400::in::prolic_az_old'),
										 );
										 
										 
export buildprep := Sequential( prep,
                        superfile_trans,
                        output( outfile,,'~thor_data400::in::prolic_az',compressed,overwrite),
												validate_prep,
                         FileServices.StartSuperfiletransaction(),
					         					FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_az'),
													 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_az_old'), 
											   FileServices.FinishSuperfiletransaction()
											       );

end;                                                                
