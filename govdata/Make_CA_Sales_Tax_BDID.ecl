import business_header,business_header_ss,did_add,PromoteSupers,mdr;

df := govdata.file_ca_sales_tax_in;

local_layout_ca_sales_tax := record
	string2		source;
	govdata.layout_ca_sales_tax;
end;

local_layout_ca_sales_tax into_fullrec(df L) := transform
	self.name_prefix   := '';
	self.name_first	   := '';
	self.name_middle   := '';
	self.name_last	   := '';
	self.name_suffix   := '';
	self.score	       := '';	
	self.bdid 		   := 0;
	self.source_rec_id := (unsigned8) (hash64(l.account_number, l.sub_account_number));			
	self.source   	   := MDR.sourceTools.src_CA_Sales_Tax;	
	self 			   := L;
end;

df2 := project(df,into_fullrec(LEFT));

without_firmname	:= df2(firm_name = '');
with_firmname  		:= df2(firm_name <> '');

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records First Pass
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header.MAC_Source_Match(
		 with_firmname									// infile
		,dSourceMatchOut								// outfile
		,false													// bool_bdid_field_is_string12
		,bdid														// bdid_field
		,false													// bool_infile_has_source_field
		,MDR.sourceTools.src_CA_Sales_Tax	// source_type_or_field
		,false													// bool_infile_has_source_group
		,foo														// source_group_field
		,firm_name											// company_name_field
		,prim_range											// prim_range_field
		,prim_name											// prim_name_field
		,sec_range											// sec_range_field
		,zip														// zip_field
		,false													// bool_infile_has_phone
		,phone													// phone_field
		,false													// bool_infile_has_fein
		,fein														// fein_field
		,																// bool_infile_has_vendor_id = 'false'
		,																// vendor_id field					 = 'vendor_id'
		);

myset := ['A'];
				
Business_Header_SS.MAC_Match_Flex(
			 dSourceMatchOut										// input dataset						
			,myset				                			// bdid matchset what fields to match on           
			,firm_name	                        // company_name	              
			,prim_range		                  		// prim_range		              
			,prim_name		                    	// prim_name		              
			,zip					                    	// zip5					              
			,sec_range		                    	// sec_range		              
			,st				        		          		// state				              
			,phone						                  // phone				              
			,fein            			           	  // fein              
			,bdid										        		// bdid												
			,local_layout_ca_sales_tax					// output layout 
			,false                              // output layout has bdid score field? 																	
			,score                     					// bdid_score                 
			,outf2				          						// output dataset
			,																		// keep count
			,																		// default threshold
			,																		// use prod version of superfiles
			,																		// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set						// create BIP keys only
			,																		// url
			,																		// email 
			,p_city_name												// city
			,name_first													// fname
			,name_middle												// mname
			,name_last													// lname
			,																		// contact ssn
			,source															// source
			,source_rec_id											// source_record_id
			,true																// does MAC_Source_Match exist before Flex macro
		);						

o2 := outf2 + without_firmname;

//project back to layout_ca_sales_tax
o3 := project(o2,transform(govdata.Layout_CA_Sales_Tax,self := left));

PromoteSupers.MAC_SF_BuildProcess(o3,'~thor_data400::base::ca_sales_tax_bdid',do1,2);

export make_ca_sales_tax_bdid := do1;

