import address, did_add, Business_Header_SS, header_slimsort, business_header, watchdog;

export fnAssetLic_Record_Clean := function

inputAssetLic := files.input.AssetLic;

clean_layout := record
	recordof(files.input.AssetLic);
	address.Layout_Clean_Name;
	address.Layout_Clean182;
end;

clean_layout tcleaninput(inputAssetLic le) := transform
	string73 temp_name := if(le.name <> '', address.CleanPerson73(le.name), '');
	temp_addr := address.CleanAddressParsed(le.address + ' ' + le.secondary_address, le.city + ' ' + le.state + ' ' + le.zip_code);
	clean_name := Address.CleanNameFields(temp_Name);
	clean_addr := temp_addr.addressrecord;
    // self.ssn := trim(le.ssn,left,right);
	self.title := clean_name.title;
	self.fname := clean_name.fname;
	self.lname := clean_name.lname;
	self.mname := clean_name.mname;
	self.name_suffix := clean_name.name_suffix;
	self.name_score := clean_name.name_score;
	
	self.prim_range := clean_addr.prim_range;	
	self.predir := clean_addr.predir;	
	self.prim_name := clean_addr.prim_name;
	self.addr_suffix := clean_addr.addr_suffix;	
	self.postdir := clean_addr.postdir;	
	self.unit_desig := clean_addr.unit_desig;
	self.sec_range := clean_addr.sec_range;
	self.p_city_name := clean_addr.p_city_name;
	self.v_city_name := clean_addr.v_city_name;
	self.st := clean_addr.st;
	self.zip := clean_addr.zip;
	self.zip4 := clean_addr.zip4;
	self.cart := clean_addr.cart;
	self.cr_sort_sz := clean_addr.cr_sort_sz;
	self.lot := clean_addr.lot;
	self.lot_order := clean_addr.lot_order;
	self.dbpc := clean_addr.dbpc;
	self.chk_digit := clean_addr.chk_digit;
	self.rec_type := clean_addr.rec_type;
	self.county := clean_addr.fips_state + clean_addr.fips_county;
	self.geo_lat := clean_addr.geo_lat;
	self.geo_long := clean_addr.geo_long;
	self.msa := clean_addr.msa;
	self.geo_blk := clean_addr.geo_blk;
	self.geo_match := clean_addr.geo_match;
	self.err_stat := clean_addr.err_stat;
	self := le;
end;

cleaned_inputAssetLic := project(inputAssetLic, tcleaninput(left)) : persist('persist::fds::AssetLic_rec::cleaned');

outrec_layout := record
	clean_layout;
	unsigned6 did := 0;
	unsigned did_score := 0;
	unsigned6 bdid := 0;
	unsigned bdid_score := 0;
	string9 app_ssn := '';
	string9 app_tax_id := '';
end;

didmatchset := ['A','S','Z'];

did_add.MAC_Match_Flex(cleaned_inputAssetLic, didmatchset,
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
			
AssetLic_Clean_Layout := record
	outrec_layout;
end;

did_add.MAC_Add_SSN_By_DID(bdid_outfile, did, app_ssn, ssn_outfile, false)

Business_Header_SS.MAC_Add_FEIN_By_BDID(ssn_outfile, bdid, app_tax_id, fein_outfile)

// outfile := fein_outfile : persist('persist::fds::AssetLic_rec::did_bdid_ssn_fein');

return output(fein_outfile,,'~thor_data400::input::fds::AssetLic_rec::cleaned',overwrite);
end;