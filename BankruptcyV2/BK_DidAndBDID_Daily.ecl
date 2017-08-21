//////////////////////////////////////////////////////////////////////////////////////////
// DEPENDENT ON : BankruptcyV2.layout_bankruptcy_search,
//                Bankruptcyv2.Mapping_BK_Search
//				  				  
// PURPOSE	 	: Distribute,sort and maps main daily bankruptcy/okc file to search layout, 
//                refresh full base file with update file and rolls up full file.  
//                {RMSID created to link main and search file if debtors are disposed speparately 
//                on same case. This will be addressed in MOAB rewrite.} 
//						: Revised (Ananth) - In addition to the did of daily file. This code also
//							checks to see if there is a new production data and re-DID's the full file
//	
//////////////////////////////////////////////////////////////////////////////////////////


import bipv2, census_data,bankruptcyv2, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address, watchdog,mdr,header,lib_stringlib;

export BK_DidAndBdid_Daily(boolean boolean_value,boolean useaid = true) := function

formatearliestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0, rDate,if((unsigned8)rDate = 0,lDate,if(lDate <= rDate,lDate, rDate)));

return out_date ;
end ;

formatlatestdates(string8 ldate ,string8 rdate) := function

out_date := if((unsigned8)lDate = 0,rDate,if((unsigned8)rDate = 0,lDate,if(lDate >= rDate, lDate, rDate )));
return out_date ;
end ;


search_daily_noAID := distribute(Bankruptcyv2.Mapping_BK_Search,hash(tmsid));

// Add first and last address lines

addrawaddress := record
	BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip;
	string100 address_line_1;
	string50 address_line_last;
end;	

// Populate values for first and last address line

addrawaddress trfToBaseLayout(Bankruptcyv2.Mapping_BK_Search input)	:=	transform
	self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(input.orig_Addr1,left,right));
	self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(input.orig_city,left,right) + if(input.orig_city <> '',', ',''),left)
									+ trim(input.orig_st,left,right) + ' ' + trim(input.orig_zip5,left,right));

	self	:=	input;
end;

search_daily_preAID	:=	distribute(project(Bankruptcyv2.Mapping_BK_Search, trfToBaseLayout(left)),hash(tmsid));

AID_base_file := distribute(bankruptcyv2.file_bk_AID,hash(tmsid));

// Join AID base file and search file to populate values for clean address fields
// from AID clean address fields.

BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip getaidaddress(addrawaddress l,AID_base_file r) := transform
self.prim_range := r.AID_Clean_Address.prim_range;
self.predir := r.AID_Clean_Address.predir;
self.prim_name := r.AID_Clean_Address.prim_name;
self.addr_suffix := r.AID_Clean_Address.addr_suffix;
self.postdir := r.AID_Clean_Address.postdir;
self.unit_desig := r.AID_Clean_Address.unit_desig;
self.sec_range := r.AID_Clean_Address.sec_range;
self.p_city_name := r.AID_Clean_Address.p_city_name;
self.v_city_name := r.AID_Clean_Address.v_city_name;
self.st := r.AID_Clean_Address.st;
self.zip := r.AID_Clean_Address.zip;
self.zip4 := r.AID_Clean_Address.zip4;
self.cart := r.AID_Clean_Address.cart;
self.cr_sort_sz := r.AID_Clean_Address.cr_sort_sz;
self.lot := r.AID_Clean_Address.lot;
self.lot_order := r.AID_Clean_Address.lot_order;
self.dbpc := r.AID_Clean_Address.dbpc;
self.chk_digit := r.AID_Clean_Address.chk_digit;
self.rec_type := r.AID_Clean_Address.rec_type;
self.county := r.AID_Clean_Address.county;
self.geo_lat := r.AID_Clean_Address.geo_lat;
self.geo_long := r.AID_Clean_Address.geo_long;
self.msa := r.AID_Clean_Address.msa;
self.geo_blk := r.AID_Clean_Address.geo_blk;
self.geo_match := r.AID_Clean_Address.geo_match;
self.err_stat := r.AID_Clean_Address.err_stat;
self := l;
end;


search_daily_with_address := dedup(sort(join(search_daily_preAID(address_line_1 <> '' or address_line_last <> ''),AID_base_file(file_flag = 'S'),
					left.tmsid = right.tmsid and left.process_date = right.process_date and
					left.address_line_1 = right.address_line_1 and 
					left.address_line_last = right.address_line_last,
					getaidaddress(left,right),
					left outer,
					local),record,local),record,local);

// There might be records in AID base file which has
// clean address fields in old records and no clean address fields
// in the new daily file.

BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip getrecordswithnoaddress(addrawaddress l) := transform
	self := l;
end;

search_daily_with_no_address := project(search_daily_preAID(address_line_1 = '' and address_line_last = ''),
										getrecordswithnoaddress(left));

// no aid

BankruptcyV2.Layout_bankruptcy_search_v3_supp_bip getrecordswithnoaid(search_daily_noAID l) := transform
	self := l;
end;

search_daily_with_no_aid := project(search_daily_noAID,
										getrecordswithnoaid(left));


search_daily := if(useaid,search_daily_with_address + search_daily_with_no_address,search_daily_with_no_aid);



getcountyds_rec := record
BankruptcyV2.layout_bankruptcy_search_v3_supp_bip;
string fips_county := '';
string new_county_name := '';
end;

getcountyds_rec getcty(search_daily l) := transform
	self.fips_county := l.county[3..5];
	self := l;
end;

getcountyds := project(search_daily,getcty(left));

census_data.MAC_Fips2County(getcountyds,st,fips_county,new_county_name,countyretds);

Bankruptcyv2.layout_bankruptcy_search_v3_supp_bip getcty_recs(countyretds l) := transform
self.orig_county := if (l.orig_county <> '',l.orig_county,l.new_county_name);
self := l;
end;

search_daily_after_cty := distribute(project(countyretds,getcty_recs(left)),hash(tmsid));

// If new production header is available and if the current day is
// saturday or sunday DID full file, if not daily

file_in := 	search_daily_after_cty; 

PreDID_Rec
 :=
  record
    
	qstring34 source_group 		:= '';
	qstring34 vendor_id 			:= '';
	BankruptcyV2.layout_bankruptcy_search_v3_supp_bip;
	integer8	temp_DID		    := 0;
	integer8	temp_BDID    	  := 0;
	string9 	appended_SSN 		:= '';
  string9 	appended_tax_id := '';
  string2 	source				  := MDR.sourceTools.src_Bankruptcy;
	
  end
 ;

PreDID_Rec taddDID(file_in L)
 :=
  transform
    self.source_group 	:=  l.court_code + l.case_number; 
		self.vendor_id    	:=  l.court_code + l.case_number + l.debtor_type + l.name_type;
		self								:=	L;
	
  end
 ;

Prefile	:= project(file_in,taddDID(left));

Prefile_a:= Prefile(fname ='' and lname ='') ;
Prefile_b:= Prefile(fname !='' and lname ='') ;
Prefile_c:= Prefile(fname ='' and lname !='') ;
Prefile_d:= Prefile(fname !='' and lname !='') ;

prefile_did := Prefile_b + Prefile_c + Prefile_d ;

//append src
src_rec := record
header_slimsort.Layout_Source;
PreDID_Rec;
end;

DID_ADD.Mac_Set_Source_Code(prefile_did, src_rec, MDR.sourceTools.src_Bankruptcy, prefile_did_src)

//append DID
temp_layout := record
string either_ssn := '';
prefile_did_src;
end;

temp_layout trecs(prefile_did_src L) := transform
self.either_ssn := if((unsigned)L.ssnMatch = 0, L.ssn,L.ssnMatch);
self := L;
end;

prefile_did_eitherssn := project(prefile_did_src,trecs(left));

matchset :=['A', 'Z', 'S', 'P','4'];

ut.mac_flipnames(prefile_did_eitherssn,fname,mname,lname,DIDFile);

did_Add.MAC_Match_Flex_v2(DIDFile, matchset,
	 either_ssn, '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone,
	 temp_did,   			
	 prefile_did_eitherssn, 
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 	
	 postDID_src,true,src,,,,,,,,,,true);

//remove src 
postDID := project(postDID_src, transform(PreDID_Rec, self := left));

full_update_DID := Prefile_a + postDID ;

preBDID_no_company  := full_update_DID(cname  = '');
preBDID := full_update_DID(cname <> '');

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records - does a direct source match to the current Business Headers
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header.MAC_Source_Match(
		 preBDID												// infile
		,dPostSourceMatch								// outfile
		,false													// bool_bdid_field_is_string12
		,temp_BDID											// bdid_field
    ,false													// bool_infile_has_source_field
		,MDR.sourceTools.src_Bankruptcy	// source_type_or_field
    ,true														// bool_infile_has_source_group
		,source_group										// source_group_field
		,cname													// company_name_field
		,prim_range											// prim_range_field
		,prim_name											// prim_name_field
		,sec_range											// sec_range_field
		,zip														// zip_field
		,true														// bool_infile_has_phone
		,phone													// phone_field
		,true														// bool_infile_has_fein
		,tax_id													// fein_field
		,true														// bool_infile_has_vendor_id = 'false'
		,vendor_id											// vendor_id field					 = 'vendor_id'
		);
			
myset := ['A', 'N', 'F', 'P'];
														
//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records
//////////////////////////////////////////////////////////////////////////////////////////////																	
Business_Header_SS.MAC_Add_BDID_FLEX(
			 dPostSourceMatch											// input dataset						
			,myset				                        // bdid matchset what fields to match on           
			,cname	                        			// company_name	              
			,prim_range		                        // prim_range		              
			,prim_name		                        // prim_name		              
			,zip					                        // zip5					              
			,sec_range		                        // sec_range		              
			,st				        		                // state				              
			,phone						                    // phone				              
			,tax_id            			           	  // fein              
			,temp_bdid										        // bdid												
			,PreDID_Rec					           				// output layout 
			,false                                // output layout has bdid score field? 																	
			,BDID_Score_field                     // bdid_score                 
			,postbdid                             // output dataset   
			,																			// deafult threscold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,bipv2.xlink_version_set							// boolean indicator set to create bdid's & xlinkids
			,																			// url
			,																			// email 
			,p_city_name													// city
			,fname																// fname
			,mname																// mname
			,lname																// lname
			,																			// contact ssn
			,source																// source
			,source_rec_id												// source_record_id
			,true		 															// does MAC_Source_Match exist before Flex macro					
		);		

post_DID_BDID := preBDID_no_company + postbdid;  //format DID and BDID
					
//Append SSN 

did_add.MAC_Add_SSN_By_DID(post_DID_BDID, temp_did, appended_SSN, file_search_ssn, false);

// Append Fein


Business_Header_SS.MAC_Add_FEIN_By_BDID(file_search_ssn, temp_bdid, appended_tax_id, file_search_fein);



BankruptcyV2.layout_bankruptcy_search_v3_supp_bip reformattemp(file_search_fein L)
 :=
  transform
    self.DID		    :=	intformat(L.temp_DID,12,1);
    self.BDID		    :=	intformat(L.temp_BDID,12,1);
	self.app_SSN        := l.appended_SSN ;
    self.app_tax_id     := l.appended_tax_id ;
	self := L;
	end;

file_daily := project(file_search_fein, reformattemp(left));


	return file_daily;
	
end;