IMPORT UT, MDR, PromoteSupers, Address, AID, AID_Support, Targus, PRTE2_Targus, PRTE2, STD;
EXPORT Proc_build_base := FUNCTION

    //Input Files
    PRTE2.CleanFields(PRTE2_Targus.Files.Input_Boca, ds_clean_Boca);  
    PRTE2.CleanFields(PRTE2_Targus.Files.Input_INS, ds_clean_INS);
    ds_clean_all := ds_clean_Boca + ds_clean_INS;

    //Address Cleaning
    AddrClean := PRTE2.AddressCleaner(ds_clean_all,
                                      ['raw_addr1'], //address
                                      ['raw_addr2'], //address
                                      [],  //city
                                      [],  //statelog-*
                                      [],  //zip
                                      ['clean_address'], //clean_addr_out
                                      ['Temp_RawAID']);  //raw_aid_out
    
    //Layout_SAM info
    combine_files_clean := PROJECT(AddrClean,
                                       TRANSFORM(PRTE2_Targus.Layouts.Base,
                                                 SELF.prim_range  := LEFT.clean_Address.prim_range;
                                                 SELF.predir      := LEFT.Clean_Address.predir;
                                                 SELF.prim_name   := LEFT.Clean_Address.prim_name;
                                                 SELF.postdir     := LEFT.Clean_Address.postdir;
                                                 SELF.unit_desig  := LEFT.Clean_Address.unit_desig;
                                                 SELF.sec_range   := LEFT.Clean_Address.sec_range;
                                                 SELF.st          := LEFT.Clean_Address.st;
                                                 SELF.zip         := LEFT.Clean_Address.zip;
                                                 SELF.zip4        := LEFT.Clean_Address.zip4;
                                                 SELF.rec_type    := LEFT.Clean_Address.rec_type;
                                                 SELF.county      := LEFT.Clean_Address.fips_county;
                                                 SELF.geo_blk     := LEFT.Clean_Address.geo_blk;
                                                 SELF.record_sid  := 0;
                                                 
                                                 //Map Clean Addresses to Parsed Raw Addresses
                                                 SElF.house_number     := LEFT.clean_address.prim_range;
                                                 SELF.pre_direction    := LEFT.Clean_Address.predir;
                                                 SELF.street_name      := LEFT.Clean_Address.prim_name; 
                                                 SELF.street_type      := LEFT.Clean_Address.Addr_suffix;
                                                 SELF.post_direction   := LEFT.Clean_Address.postdir; 
                                                 SELF.apt_type         := LEFT.Clean_Address.unit_desig; 
                                                 SELF.apt_number       := LEFT.Clean_Address.sec_range; 
                                                 SELF.expanded_pub_city_name := LEFT.Postal_City_Name;
                                                 SELF.City_Name        := LEFT.Postal_City_Name;
                                                 SELF.Suffix           := LEFT.Clean_Address.addr_suffix;
                                                 
                                                 SELF.Cleanaddress     := LEFT.clean_address.prim_range + LEFT.Clean_Address.prim_name + LEFT.Clean_Address.predir + 
                                                                          LEFT.Clean_Address.Addr_suffix + LEFT.Clean_Address.postdir + LEFT.Clean_Address.unit_desig + 
                                                                          LEFT.Clean_Address.sec_range + LEFT.Postal_City_Name + LEFT.Clean_Address.st + 
                                                                          LEFT.Clean_Address.zip + LEFT.Clean_Address.zip4 + LEFT.Clean_Address.fips_county + 
                                                                          LEFT.Clean_Address.geo_blk;
                                                 
                                                 poBOX :=  map(regexfind('(PO BOX )([0-9]+)',LEFT.Clean_Address.prim_name) = true  
											                                           => regexreplace('(PO BOX )([0-9]+)',LEFT.Clean_Address.prim_name,'$2'),
												                                                        
                                                               regexfind('(RR )([1,2,3])',LEFT.Clean_Address.prim_name) = true  
											                                           => regexreplace('(RR )([1,2,3])',LEFT.Clean_Address.prim_name,'$2'),'');
                                                 
                                                 SELF.Box_Number := poBOX;
                                                 
                                                 //Name cleaning
                                                 v_CleanName      := Address.CleanPersonFML73_fields(LEFT.title+' '+LEFT.first_name+' '+LEFT.middle_name+' '+LEFT.last_name+' '+LEFT.last_name_suffix);
                                                 SELF.title       := v_CleanName.title;
                                                 SELF.fname       := v_CleanName.fname;
                                                 SELF.minit       := v_CleanName.mname;
                                                 SELF.lname       := v_CleanName.lname;
                                                 SELF.name_suffix := v_CleanName.name_suffix;
                                                 SELF.CleanName   := v_CleanName.fname + v_CleanName.mname + v_CleanName.lname + v_CleanName.name_suffix;
                                                 SELF.DID         := if(LEFT.did > 0, LEFT.did, PRTE2.FN_APPENDFAKEID.DID(v_CleanName.fname, v_CleanName.lname, LEFT.LINK_SSN, LEFT.LINK_DOB, LEFT.CUST_NAME));      
                                                   
    SELF := LEFT;
    SELF := [];));
    
    //Add Global_SID
    addGSFiltered := MDR.macGetGlobalSid(combine_files_clean,'Targus','','global_sid');
    
    //Build Base File
    PromoteSupers.MAC_SF_BuildProcess(addGSFiltered, Constants.Base_Prefix + 'TARGUS', bld_base_boca, ,, TRUE);
    RETURN sequential(bld_base_boca);
    END;