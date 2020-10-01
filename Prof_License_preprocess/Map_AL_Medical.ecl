EXPORT Map_AL_Medical(string fdate) := module

 import Prof_License,Lib_StringLib,ut;

  Prof_License.Layout_proLic_in map2pa( File_AL_Medical.phya l ) := transform   
      self.misc_occupation                 :=   l.License_Type;
      self.business_flag                   :=   'N';
      self.source_st                      :=  'AL';
      self.orig_name                      := trim(l.Last_Name)+' '+trim(l.First_Name)+' '+trim(l.Middle_Name)+' '+trim(l.Suffix);
      self.company_name                   := ' ';
      self.orig_addr_1                     :=  l.Address_1;
      self.orig_addr_2                     :=  l.Address_2;
      self.orig_city                       :=  l.City;
      self.orig_st                        := l.State;
      self.issue_date                     :=  fSlashedMDYtoCYMD(l.Date_Issued);
      self.dob                           := '';
      self.expiration_date                   :=    fSlashedMDYtoCYMD(l.Expiration_Date);
      self.name_order                     := 'LFM';
      self.vendor                        := 'Alabama State Board of Medical Examiners';
      self.license_number                  :=    trim((string) intformat((integer) l.license_number,20,0),left,right);
      self.profession_or_board              :=    'Medical and PA';
      self.date_first_seen                  :=    fdate;
      self.date_last_seen                  :=   fdate;
      self.education_1_school_attended        :=      '';
      self.education_1_dates_attended         :=      '';
      self.additional_licensing_specifics        :=      '';
      self.license_type                   :=   'Physician Assistant';
      self.orig_addr_3                   :=  l.Address_3;
      self.phone                       :=    StringLib.stringfilter(l.Telephone,'0123456789')[1..10];
      self.orig_zip                      :=    StringLib.stringfilter(l.Zip,'0123456789')[1..9];
      self.personal_pob_desc              :=    '';                                                                                                                                                            
     self.status                       :=    l.QACSC_Status;
      self.county_str                    :=    '';
      self  := l;
      self  := [];
                                                                                                                                                                                                                                                                                                  
 
    end;

dWithPA := project( File_AL_Medical.phya, map2pa(left));


 
  Prof_License.Layout_proLic_in map2phy( File_AL_Medical.phys l ) := transform
 
   self.license_type                            := l.License_Type;                                                                                                                                                                                                                                                           
   self.business_flag                           := 'N';                                                                                                                                                                                                                                                                    
   self.source_st                              := 'AL';                                                                                                                                                                                                                                                                        
   self.vendor                                := 'Alabama State Board of Medical Examiners';                                                                                                                                                                                                                                     
   self.orig_name                              := trim(l.Last_Name)+' '+trim(l.First_Name)+' '+trim(l.Middle_Name)+' '+trim(l.Suffix);                                                                                                                       
   self.company_name                           := ' ';                                                                                                                                                                                                                                                                 
   self.status                                 := l.QACSC_Status;                                                                                                                                                                                                                                                                       
   self.orig_addr_1                             := trim(l.Address_1)[1..80];                                                                                                                                                                                                                         
   self.orig_addr_2                             := l.Address_2;                                                                                                                                                                                                                                                               
   self.orig_addr_3                             := trim(l.Address_3)[1..80];                                                                                                                                                                                                                         
   self.orig_city                               := trim(l.City)[1..40];                                                                                                                                                                                                                                
   self.orig_st                                := trim(l.State);                                                                                                                                                                                                                                                        
   self.orig_zip                               := StringLib.stringfilter(l.Zip,'0123456789')[1..9];                                                                                                                                                                                                                      
   self.issue_date                             := fSlashedMDYtoCYMD(l.Date_Issued);                                                                                                                                                                                                                                            
   self.expiration_date                          := fSlashedMDYtoCYMD(l.Expiration_Date);                                                                                                                                                                                                                                   
   self.dob                                  := '';                                                                                                                                                                                                                                            
   self.name_order                             := 'LFM';                                                                                                                                                                                                                                                                      
   self.license_number                          := trim((string) intformat((integer) l.license_number,20,0),left,right);                                                                                                                                                                                                                                        
   self.profession_or_board                      := 'Medical and PA';                                                                                                                                                                                                                                                           
   self.date_first_seen                          := fdate;                                                                                                                                                                                                                                                        
   self.date_last_seen                          := fdate;                                                                                                                                                                                                                                                         
   self.education_1_school_attended                := '';                                                                                                                                                                                                      
   self.education_1_dates_attended                 := '';
   self.additional_licensing_specifics                := '';                                                                                                                                  
   self.board_action_indicator                     := '';                                                                                                                                                                                                                                                             
   self.phone                                := '';                                                                                                                                                                                                             
   self.personal_pob_desc                       := '';                                                                                                                                                                 
   self.county_str                             := '';                                                                                                                                                                                                                                                           
   self.license_obtained_by                      := '';                                                                                                                                
   self := l;
   self := [];

 end;

  dWithPhy:= project( File_AL_Medical.phys, map2phy(left));

  dWithAll :=  dWithPA + dWithPhy;

  dALMedout := Sequential(  
                        FileServices.ClearSuperfile( '~thor_data400::in::prolic::al::medical'),
                        output(dWithAll,,'~thor_data400::in::prolic::al::medical_'+fdate,overwrite),
                         FileServices.StartSuperfiletransaction(),
												   if ( NOT FileServices.SuperFileExists( '~thor_data400::in::prolic::al::medical'),FileServices.CreateSuperfile('~thor_data400::in::prolic::ga::medical')),												 
												   FileServices.AddSuperfile( '~thor_data400::in::prolic::al::medical','~thor_data400::in::prolic::al::medical_'+fdate),
											   FileServices.FinishSuperfiletransaction()
											 );

  outfile := proc_clean_all(dWithAll,'AL').cleanout;

 albase := dataset('~thor_data400::in::prolic_al',Prof_License.Layout_proLic_in ,flat);

//Verifying License numbers in  base from prep file
  validate_prep := Prof_License_preprocess.fn_ValidateLicInBase (dWithAll, albase,'al').out;

  superfile_trans := Sequential(  
                            FileServices.RemoveSuperFile('~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_al'),
                            if ( FileServices.FindSuperfilesubname(  '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_al_old') <> 0,      FileServices.RemoveSuperFile(	'~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_al_old')),
								            if ( FileServices.FileExists( '~thor_data400::in::prolic_al_old'), FileServices.Deletelogicalfile('~thor_data400::in::prolic_al_old')),
                            FileServices.RenameLogicalfile( '~thor_data400::in::prolic_al','~thor_data400::in::prolic_al_old'),
				
										   );


  export buildprep := Sequential( dALMedout,
                         superfile_trans,
                         output( outfile,,'~thor_data400::in::prolic_al',compressed,overwrite),
												 validate_prep,
                         FileServices.StartSuperfiletransaction(),
					                 FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources', '~thor_data400::in::prolic_al'),
											FileServices.AddSuperfile( '~thor_data400::in::prolic::allsources::old','~thor_data400::in::prolic_al_old'), 
	                       FileServices.FinishSuperfiletransaction()
											 );

end;                                                                                                                             
		
		
