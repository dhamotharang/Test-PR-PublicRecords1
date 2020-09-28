IMPORT VotersV2, data_services, Address, ut, AID, _validate, std, Codes;
                                                                              
Layout_Voters_base := record
    unsigned6  rid;
    unsigned6  did;
    unsigned1  did_score;
    string9    ssn;
    VotersV2.Layouts_Voters.Voters_new;
    string1    name_type;
    string1    addr_type;                       
    unsigned8         raw_aid := 0;
    unsigned8         ace_aid := 0;      
END;

dBase := DATASET('~thor_data400::base::voters_reg', Layout_Voters_base, THOR);

output(dBase, named('dBase'));
output(count(dBase), named('Cnt_dBase'));

dBaseEmptyCleanAddresses := dBase(prim_range = '' and predir = '' and prim_name = '' and addr_suffix = '' and postdir = '' and unit_desig = '' and sec_range = ''
                                  and p_city_name = '' and st = '' and zip = ''	
                                  and mail_prim_range = '' and mail_predir = '' and mail_prim_name = '' and mail_addr_suffix = '' and mail_postdir = '' and mail_unit_desig = '' and mail_sec_range = ''
                                  and mail_p_city_name = '' and mail_st = '' and mail_ace_zip = ''                                                                                                                                                                                                                                                                             
                                  );
                                                                                                                                                                                                                                                                                
output(dBaseEmptyCleanAddresses, named('dBaseEmptyCleanAddresses'));
output(count(dBaseEmptyCleanAddresses), named('Cnt_dBaseEmptyCleanAddresses'));
                                                                                                                                                                                                                                                                                
VotersV2.Layouts_Voters.Layout_Voters_base_new trfBaseEmptyCleanAddresses(dBaseEmptyCleanAddresses l, unsigned c) := transform
  ,skip(c = 2 and
                     trim(l.res_city,left,right)  = trim(l.mail_city,left,right) and
                                   trim(l.res_state,left,right) = trim(l.mail_state,left,right) and
                                   trim(l.res_zip,left,right)   = trim(l.mail_zip,left,right) and 
                                   trim(l.res_city,left,right) + trim(l.res_zip,left,right) <> '')               
                self.addr_type := choose(c, '','M');  
                temp_res_addr_line_last := if((trim(l.res_city,left,right) != '' and (trim(l.res_state,left,right) != '') and Codes.St2Name(L.res_state) <> '') or (trim(l.res_zip,left,right) != '')
                                              ,Address.Addr2FromComponents(ut.CleanSpacesAndUpper(l.res_city), ut.CleanSpacesAndUpper(l.res_state), l.res_zip[1..5])                                      
                                              ,'');
                temp_mail_addr_line_last := if((trim(l.mail_city,left,right) != '' and (trim(l.mail_state,left,right) != '') and Codes.St2Name(L.mail_state) <> '') or (trim(l.mail_zip,left,right) != '')
                                                ,Address.Addr2FromComponents(ut.CleanSpacesAndUpper(l.mail_city), ut.CleanSpacesAndUpper(l.mail_state), l.mail_zip[1..5])                                 
                                                ,'');                                                                                                                                                                                                                                                                                                          
                self.prep_addr_line1:= choose(c, ut.CleanSpacesAndUpper(l.res_Addr1 + ' ' + l.res_Addr2), ut.CleanSpacesAndUpper(l.mail_Addr1 + ' ' + l.mail_Addr2));
                self.prep_addr_line_last := choose(c, temp_res_addr_line_last, temp_mail_addr_line_last);         
                // self.title := if(l.title = '',l.prefix_title,l.title);     
								//using the old name cleaner is for title population only	
								string73 clean_name:= address.CleanPersonFML73(TRIM(TRIM(l.first_name)+' '+TRIM(l.middle_name)+' '+TRIM(l.last_name)));
		            temp_title :=	clean_name[1..5];   
								self.title :=  if(l.prefix_title = '',temp_title,l.prefix_title);
                self.fname := l.first_name;
                self.mname := l.middle_name;
                temp_last_name := if(l.name_type = '2',trim(l.clean_maiden_pri,left,right),trim(l.last_name,left,right));
                self.lname := temp_last_name;
                self.name_suffix := l.name_suffix_in;
                self := l; 
END;

// Normalize the Mailing Addresses 
Infile_Addr_Norm  := NORMALIZE(dBaseEmptyCleanAddresses,
								   if((trim(left.mail_city,left,right) + trim(left.mail_state,left,right) = '' and
								       (integer)left.mail_zip = 0)  or 											 
								      (trim(left.res_addr1,left,right) = trim(left.mail_addr1,left,right) and
									     trim(left.res_addr2,left,right) = trim(left.mail_addr2,left,right) and
								       trim(left.res_city,left,right)  = trim(left.mail_city,left,right) and									   
								       trim(left.res_state,left,right) = trim(left.mail_state,left,right) and
								       trim(left.res_zip,left,right)   = trim(left.mail_zip,left,right)),1,2)								      
								   ,trfBaseEmptyCleanAddresses(left,counter));

output(Infile_Addr_Norm, named('NormEmptyCleanAddresses'));
output(count(Infile_Addr_Norm), named('Cnt_NormCleanAddresses'));
                                                                                                                                              
dBaseNonEmptyCleanAddresses := dBase(prim_range != '' or predir != '' or prim_name != '' or addr_suffix != '' or postdir != '' or unit_desig != '' or sec_range != ''
                                  or p_city_name != '' or st != '' or zip != ''
                                  or mail_prim_range != '' or mail_predir != '' or mail_prim_name != '' or mail_addr_suffix != '' or mail_postdir != '' or mail_unit_desig != '' or mail_sec_range != ''
                                  or mail_p_city_name != '' or mail_st != '' or mail_ace_zip != ''                                                                                                                                                                                                                                                                 
                                  );                       
                                                                                                                                                                                                                                                                                
output(dBaseNonEmptyCleanAddresses, named('dBaseNonEmptyCleanAddresses'));
output(count(dBaseNonEmptyCleanAddresses), named('Cnt_dBaseNonEmptyCleanAddresses'));                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                
VotersV2.Layouts_Voters.Layout_Voters_base_new trfInFile(dBaseNonEmptyCleanAddresses l) := transform
  temp_prep_addr_line1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, 
                                                      l.addr_suffix, l.postdir, l.unit_desig,
																											l.sec_range);
                temp_prep_addr_line2 := Address.Addr1FromComponents(l.mail_prim_range, l.mail_predir, l.mail_prim_name, 
                                                                    l.mail_addr_suffix, l.mail_postdir, l.mail_unit_desig,
                                                                    l.mail_sec_range);
                temp_prep_addr_line_last := if(l.p_city_name != '' and l.zip != '',Address.Addr2FromComponents(l.p_city_name, l.st, l.zip),'');
                temp_prep_addr_line_last2 := if(l.mail_p_city_name != '' and l.mail_zip != '',Address.Addr2FromComponents(l.mail_p_city_name, l.mail_st, l.mail_ace_zip),'');
                self.prep_addr_line1:= if(l.addr_type = 'M', temp_prep_addr_line2, temp_prep_addr_line1);                       
                self.prep_addr_line_last := if(l.addr_type = 'M', temp_prep_addr_line_last2, temp_prep_addr_line_last);                
                // self.title := if(l.title = '',l.prefix_title,l.title);                                      
                //using the old name cleaner is for title population only	
								string73 clean_name:= address.CleanPersonFML73(TRIM(TRIM(l.first_name)+' '+TRIM(l.middle_name)+' '+TRIM(l.last_name)));
		            temp_title :=	clean_name[1..5];   
								self.title :=  if(l.prefix_title = '',temp_title,l.prefix_title);             
								self.fname := l.first_name;
                self.mname := l.middle_name;
                temp_last_name := if(l.name_type = '2',trim(l.clean_maiden_pri,left,right),trim(l.last_name,left,right));
                self.lname := temp_last_name;
                self.name_suffix := l.name_suffix_in;
                self := l;
END;

Base_Prep_Addr := project(dBaseNonEmptyCleanAddresses,trfInFile(left));

output(Base_Prep_Addr, named('Base_Prep_Addr'));
output(count(Base_Prep_Addr), named('Cnt_Base_Prep_Addr'));

newPatchedBase := Base_Prep_Addr + Infile_Addr_Norm;

output(count(newPatchedBase), named('Cnt_newPatchedBase'));

Base_AddrNullPrepFields := newPatchedBase(prep_addr_line1 = '' and prep_addr_line_last = '');

output(Base_AddrNullPrepFields,,named('Base_AddrNullPrepFields'));
output(COUNT(Base_AddrNullPrepFields),named('Cnt_Base_AddrNullPrepFields'));

Base_AddrNotNullPrepFields := newPatchedBase(prep_addr_line1 != '' or prep_addr_line_last != '');

output(Base_AddrNotNullPrepFields,,named('Base_AddrNotNullPrepFields'));
output(COUNT(Base_AddrNotNullPrepFields),named('Cnt_Base_AddrNotNullPrepFields'));
      
                                                                                                                                                                                                                                                                
OUTPUT(newPatchedBase,,'~thor_data400::base::voters_reg_father::patched::20200923',overwrite,__compressed__,named('newPatchedBase')); 
