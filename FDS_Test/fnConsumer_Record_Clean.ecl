import address, did_add, Business_Header_SS, header_slimsort, business_header, watchdog;

export fnConsumer_Record_Clean := function

inputConsumerRec := files.input.ConsumerRec;

clean_layout := record
	recordof(files.input.ConsumerRec);
	address.Layout_Clean_Name;
	address.Layout_Clean182;
end;

clean_layout tcleaninput(inputConsumerRec le) := transform
//// Functions
 	  string73 temp_name := if(le.name <> '', address.CleanPersonLFM73(le.name), '');
	  clean_addr := Address.CleanAddress182(le.address + ' ' + le.secondary_address, le.city + ' ' + le.state + ' ' + le.zip_code);
	 clean_name := Address.CleanNameFields(temp_Name);
//// Mapping
    self.ssn := (string9)intformat((unsigned8)le.ssn, 9, 1);
	self.title := clean_name.title;
	self.fname := datalib.PreferredFirstNew(clean_name.fname,true);
	self.lname := clean_name.lname;
	self.mname := datalib.PreferredFirstNew(clean_name.mname,true);
	self.name_suffix := clean_name.name_suffix;
	self.name_score := clean_name.name_score;
	
	self.prim_range	:=  clean_addr[1..10];
	self.predir	:= 	clean_addr[11..12];
	self.prim_name	:= 	clean_addr[13..40];
	self.addr_suffix	:=  clean_addr[41..44];
	self.postdir	:= 	clean_addr[45..46];
	self.unit_desig	:= 	clean_addr[47..56];
	self.sec_range	:= 	clean_addr[57..64];
	self.p_city_name	:= 	clean_addr[65..89];
	self.v_city_name	:=  clean_addr[90..114];
	self.st	:= 	clean_addr[115..116];
	self.zip	:= 	clean_addr[117..121];
	self.zip4	:= 	clean_addr[122..125];
	self.cart	:= 	clean_addr[126..129];
	self.cr_sort_sz	:= 	clean_addr[130];
	self.lot	:= 	clean_addr[131..134];
	self.lot_order	:= 	clean_addr[135];
	self.dbpc	:= 	clean_addr[136..137];
	self.chk_digit	:= 	clean_addr[138];
	self.rec_type	:= 	clean_addr[139..140];
	self.county	:= 	clean_addr[141..145];
	self.geo_lat	:= 	clean_addr[146..155];
	self.geo_long	:= 	clean_addr[156..166];
	self.msa	:= 	clean_addr[167..170];
	self.geo_blk	:= 	clean_addr[171..177];
	self.geo_match	:= 	clean_addr[178];
	self.err_stat	:= 	clean_addr[179..182];									       

self := le;
end;

cleaned_inputConsumerRec := project(inputConsumerRec, tcleaninput(left)) : persist('persist::fds::consumer_rec::cleaned');

outrec_layout := record
	clean_layout;
	unsigned8 did := 0;
	unsigned did_score := 0;
	unsigned8 bdid := 0;
	unsigned bdid_score := 0;
	string9 app_ssn := '';
	string9 app_tax_id := '';
end;

didmatchset := ['A','S','Z'];

did_add.MAC_Match_Flex(cleaned_inputConsumerRec, didmatchset,
	 ssn, '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range,zip, st, '',
	 DID,   			
	 outrec_layout, 
	 true, DID_Score,	//these should default to zero in definition
	 75,	//dids with a score below here will be dropped 
	 did_outfile) 

bdidmatchset := ['A','F','N']; 

Business_Header_SS.MAC_Add_BDID_FLEX(
          did_outfile                                // Input Dataset                 
         ,bdidmatchset                        // BDID Matchset what fields to match on           
         ,business_name                          // company_name                 
         ,prim_range                            // prim_range                   
         ,prim_name                             // prim_name                    
         ,zip                                     // zip5                            
         ,sec_range                             // sec_range                    
         ,st                                    // state                        
         ,''                                    // phone                        
         ,tax_id_number                        // fein              
         ,bdid                                             // bdid                                    
         ,outrec_layout           // Output Layout 
         ,true                                 // output layout has bdid score field?                       
         ,bdid_score                           // bdid_score                 
         ,bdid_outfile                             // Output Dataset 
			) 
			
PR_Clean_Layout := record
	outrec_layout;
end;

did_add.MAC_Add_SSN_By_DID(bdid_outfile, did, app_ssn, ssn_outfile, false)

Business_Header_SS.MAC_Add_FEIN_By_BDID(ssn_outfile, bdid, app_tax_id, fein_outfile)

outfile := fein_outfile : persist('persist::fds::consumer_rec::did_bdid_ssn_fein');

return outfile;
end;