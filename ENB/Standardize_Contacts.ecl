import Address, Ut, lib_stringlib, _Control, business_header,_Validate;
// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates
export Standardize_Contacts :=
module
   //////////////////////////////////////////////////////////////////////////////////////
   // -- fPreProcess
   // -- Get address ready for cleaning
   // -- add unique id
   // -- add proprietary dates
   //////////////////////////////////////////////////////////////////////////////////////
   export fPreProcess(dataset(layouts.input.contacts) pRawFileInput, string pversion) :=
   function
   
      Layouts.Temporary.StandardizeContacts tPreProcessIndividuals(layouts.input.contacts l, unsigned8 cnt) :=
      transform
         //////////////////////////////////////////////////////////////////////////////////////
         // -- Prepare Addresses for Cleaning using macro
         //////////////////////////////////////////////////////////////////////////////////////
         address1 := 
                  trim(l.BUSINESS_ADDRESS       )
               ;        
         address2 := 
                          trim(l.CITY       )
               + ', '   + trim(l.STATE      )
               + ' '    + trim(l.ZIP      	)
               ;                 
                                
         //////////////////////////////////////////////////////////////////////////////////////
         // -- Map Fields
         //////////////////////////////////////////////////////////////////////////////////////
                                                                                                                                     
         self.address1                                         := address1                         ;
         self.address2                                         := address2                         ;
                                          
         self.unique_id                                     := cnt                                 ;
         
         self.dt_first_seen                                 := 0                                   ;  
         self.dt_last_seen                                  := 0                                   ;
         self.dt_vendor_first_reported                := (unsigned4)pversion        ;
         self.dt_vendor_last_reported                 := (unsigned4)pversion        ;
         self.Clean_Company_address                   := []                                  ;
         self.clean_contact_name											:= [];
         self.rawfields                                     := l                                   ;
      end;
      
      dPreProcess := project(pRawFileInput, tPreProcessIndividuals(left,counter));
   
      return dPreProcess;
   end;

   //////////////////////////////////////////////////////////////////////////////////////
   // -- function: fStandardizeName
   // -- Standardizes names
   //////////////////////////////////////////////////////////////////////////////////////
   export fStandardizeName(dataset(Layouts.Temporary.StandardizeContacts) pPreProcessInput) :=
   function
      
			Layouts.Temporary.StandardizeContacts tStandardizeName(Layouts.Temporary.StandardizeContacts l) :=
      transform
         //////////////////////////////////////////////////////////////////////////////////////
         // -- Clean Name, determine if it is a person
         //////////////////////////////////////////////////////////////////////////////////////
         assembled_name                :=             			trim(l.rawfields.CON_NAME_LAST_NAME    )
                                                + ', '   +  trim(l.rawfields.CON_NAME_FIRST_NAME   )
                                                + ', '   +  trim(l.rawfields.CON_NAME_MID_NAME   )
                                                ;                
         clean_contact_name         := Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;
                                                                         
         //////////////////////////////////////////////////////////////////////////////////////
         // -- Map Fields
         //////////////////////////////////////////////////////////////////////////////////////
         self.clean_contact_name                            := clean_contact_name   ;
         self                                                        := l                          ;
      end;
      
      dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
      
      return dStandardizedName;
   end;


   //////////////////////////////////////////////////////////////////////////////////////
   // -- function: fStandardizeAddresses
   // -- Standardizes addresses
   //////////////////////////////////////////////////////////////////////////////////////
   export fStandardizeAddresses(dataset(Layouts.Temporary.StandardizeContacts) pStandardizeNameInput) :=
   function
      //////////////////////////////////////////////////////////////////////////////////////
      // -- Second, pass addresses to macro for cleaning
      // -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
      //////////////////////////////////////////////////////////////////////////////////////
      addresslayout :=
      record
         unsigned8                           unique_id      ;  //to tie back to original record
         string100                           address1       ;
         string50                            address2       ;
      end;
      
      addresslayout tProjectAddress(Layouts.Temporary.StandardizeContacts l) :=
      transform
         self.unique_id                   := l.unique_id ;
         self.address1                       := l.address1     ;
         self.address2                       := l.address2     ;
         
      end;
      
      dAddressPrep   := project(pStandardizeNameInput, tProjectAddress(left));
      HasAddress     :=       trim(dAddressPrep.address1, left,right) != ''
                              and trim(dAddressPrep.address2, left,right) != '';
                              
      dWith_address        := dAddressPrep(HasAddress);
      dWithout_address  := dAddressPrep(not(HasAddress));
      // -- Standardize the address 
      address.mac_address_clean( dWith_address
                                             ,address1
                                             ,address2
                                             ,true
                                             ,dAddressStandardized
                                          );
                                          
      // -- match back to dStandardizedFirstPass and append address
      dStandardizeNameInput_dist    := distribute(pStandardizeNameInput ,unique_id);
      dAddressStandardized_dist     := distribute(dAddressStandardized  ,unique_id);
      Layouts.base.Contacts tGetStandardizedAddress(Layouts.Temporary.StandardizeContacts l ,dAddressStandardized_dist r) :=
      transform
         Clean_Company_address   := Address.CleanAddressFieldsFips(r.clean).addressrecord;
         self.Clean_Company_address := Clean_Company_address;
         self                             := l                 ;
      
      end;
      
      dCleancontactAddressAppended  := join(
                                                 dStandardizeNameInput_dist
                                                ,dAddressStandardized_dist
                                                ,left.unique_id = right.unique_id
                                                ,tGetStandardizedAddress(left,right)
                                                ,local
                                                ,left outer
                                             );
      return dCleancontactAddressAppended;
      
   end;
   
   export fAll( dataset(Layouts.Input.Contacts   )  pRawFileInput
                     ,string                                         pversion
   ) :=
   function
   
      dPreprocess          := fPreProcess             (pRawFileInput,pversion );
      dStandardizeName     := fStandardizeName        (dPreprocess                  );
      
      #if(_flags.UseStandardizePersists)
				 dStandardizeAddress  := fStandardizeAddresses(dStandardizeName    )  : persist(Persistnames.standardizeContacts);
      #else
         dStandardizeAddress  := fStandardizeAddresses(dStandardizeName    );
      #end
      
      return dStandardizeAddress;
   
   end;

end;
