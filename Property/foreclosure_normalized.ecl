/*2011-03-01T14:40:32Z (david lenz)

*/
/*
Normalizing by Name, Company name and address. The normalized file is used for did, bdid and ssn append.
This file is used for building autokeys
*/
import bipv2, property, ut, header_slimsort, DID_Add, Business_Header_SS, MDR, Business_header, Address, Header, Watchdog, lib_stringlib, BKForeclosure, STD;

foreclosureIn := property.File_Foreclosure_In;

// NORMALIZE: The result of it will be used for DIDing and for building autokeys as well
// by name (autokeys also will use normalization by company name) 
Layout_Foreclosure_Base_Normalized normalizeRecords (foreclosureIn l, unsigned1 nameCounter) := transform
	self.name_first := choose(nameCounter,l.name1_first,l.name2_first,l.name3_first,l.name4_first,l.name5_first,l.name6_first,l.name7_first,l.name8_first);
	self.name_middle := choose(nameCounter,l.name1_middle,l.name2_middle,l.name3_middle,l.name4_middle,l.name5_middle,l.name6_middle,l.name7_middle,l.name8_middle);
	self.name_last := choose(nameCounter,l.name1_last,l.name2_last,l.name3_last,l.name4_last,l.name5_last,l.name6_last,l.name7_last,l.name8_last);
	self.name_suffix := choose(nameCounter,l.name1_suffix,l.name2_suffix,l.name3_suffix,l.name4_suffix,l.name5_suffix,l.name6_suffix,l.name7_suffix,l.name8_suffix);
	self.name_Company := choose(nameCounter,l.name1_company,l.name2_company,l.name3_company,l.name4_company,l.name5_company,l.name6_company,l.name7_company,l.name8_company);	
	self.ssn	:= choose(nameCounter,l.name1_ssn,l.name2_ssn,l.name3_ssn,l.name4_ssn,l.name5_ssn,l.name6_ssn,l.name7_ssn,l.name8_ssn);	
	self.site_prim_range :=l.situs1_prim_range;
	self.site_predir :=l.situs1_predir;
	self.site_prim_name :=l.situs1_prim_name;
	self.site_addr_suffix:=l.situs1_addr_suffix;
	self.site_postdir:=l.situs1_postdir;
	self.site_unit_desig:=l.situs1_unit_desig;
	self.site_sec_range:=l.situs1_sec_range;
	self.site_p_city_name:=l.situs1_p_city_name;
	self.site_v_city_name:=l.situs1_v_city_name;
	self.site_st:=l.situs1_st;
	self.site_zip:=l.situs1_zip;
	self.site_zip4:=l.situs1_zip4;
	self.name_indicator := nameCounter;
	self.source := IF(TRIM(l.source) IN ['B7','I5'],l.source,MDR.sourceTools.src_Foreclosures); //Probably not needed but ensures setting source code currectly
	self := l;
end;
ds_name_normalized := normalize (foreclosureIn,8,normalizeRecords(left,counter));


// by address
Layout_Foreclosure_Base_Normalized normalize_Addr_Records(Layout_Foreclosure_Base_Normalized l, unsigned1 c) := transform
		self.site_prim_range :=choose(c,l.site_prim_range,l.situs2_prim_range);
		self.site_predir :=choose(c,l.site_predir,l.situs2_predir);
		self.site_prim_name :=choose(c,l.site_prim_name,l.situs2_prim_name);
		self.site_addr_suffix:=choose(c,l.site_addr_suffix,l.situs2_addr_suffix);
		self.site_postdir:=choose(c,l.site_postdir,l.situs2_postdir);
		self.site_unit_desig:=choose(c,l.site_unit_desig,l.situs2_unit_desig);
		self.site_sec_range:=choose(c,l.site_sec_range,l.situs2_sec_range);
		self.site_p_city_name:=choose(c,l.site_p_city_name,l.situs2_p_city_name);
		self.site_v_city_name:=choose(c,l.site_v_city_name,l.situs2_v_city_name);
		self.site_st:=choose(c,l.site_st,l.situs2_st);
		self.site_zip:=choose(c,l.site_zip,l.situs2_zip);
		self.site_zip4:=choose(c,l.site_zip4,l.situs2_zip4);
		self := l;
end;

ds_normalized := normalize(ds_name_normalized(name_first != '' OR name_last != '' OR name_company != ''), if((left.situs2_prim_name='' and left.situs2_zip=''),1,2),normalize_Addr_Records(left,counter));

src_rec := record
header_slimsort.Layout_Source;
Layout_Foreclosure_Base_Normalized;
end;

DID_Add.Mac_Set_Source_Code (ds_normalized, src_rec, 'FR', foreclosureBaseNormalized_src)

matchset := ['A','Z'];

did_add.MAC_Match_Flex(foreclosureBaseNormalized_src,matchset,
											 foo,foo,name_first,name_middle,name_last,name_suffix,
											 site_prim_range,site_prim_name,site_sec_range,site_zip,site_st,foo,
											 did,src_rec,
											 true,did_score,75,foreclosureDID_src,true,src);
//remove src 
foreclosureDID := project(foreclosureDID_src, transform(Layout_Foreclosure_Base_Normalized, self := left));

matchset_bdid := ['A'];

Business_Header_SS.MAC_Match_Flex(
			 foreclosureDID												// input dataset						
			,matchset_bdid				                // bdid matchset what fields to match on           
			,name_company	                        // company_name	              
			,site_prim_range		                  // prim_range		              
			,site_prim_name		                    // prim_name		              
			,site_zip					                    // zip5					              
			,site_sec_range		                    // sec_range		              
			,site_st				        		          // state				              
			,foo						                    	// phone				              
			,foo            			           	  	// fein              
			,bdid										        			// bdid												
			,Layout_Foreclosure_Base_Normalized		// output layout 
			,true                                	// output layout has bdid score field? 																	
			,bdid_score                     			// bdid_score                 
			,foreclosureDID_BDID				          // output dataset
			,																			// keep count
			,																			// default threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// create BIP keys only
			,																			// url
			,																			// email 
			,site_p_city_name											// city
			,name_first														// fname
			,name_middle													// mname
			,name_last														// lname
			,ssn																	// contact ssn
			,source																// source
			,source_rec_id												// source_record_id
			,false																// if mac_Source_Match appears exists before flex macro
		);										 

DID_Add.MAC_Add_SSN_By_DID(foreclosureDID_BDID,did,ssn,appendSSN);

appendSSNSortDist	:=	SORT(DISTRIBUTE(appendSSN, HASH(foreclosure_id)), RECORD, -process_date, LOCAL);

//Normalize BKL file prior to append
BKforeclosureIn	:= BKForeclosure.Fn_Map_BK2Foreclosure;

Layout_Foreclosure_Base_Normalized normalizeBK(BKforeclosureIn l, unsigned1 nameCounter) := TRANSFORM
	self.name_first := choose(nameCounter,l.name1_first,l.name2_first,l.name3_first,l.name4_first,l.name5_first,l.name6_first,l.name7_first,l.name8_first);
	self.name_middle := choose(nameCounter,l.name1_middle,l.name2_middle,l.name3_middle,l.name4_middle,l.name5_middle,l.name6_middle,l.name7_middle,l.name8_middle);
	self.name_last := choose(nameCounter,l.name1_last,l.name2_last,l.name3_last,l.name4_last,l.name5_last,l.name6_last,l.name7_last,l.name8_last);
	self.name_suffix := choose(nameCounter,l.name1_suffix,l.name2_suffix,l.name3_suffix,l.name4_suffix,l.name5_suffix,l.name6_suffix,l.name7_suffix,l.name8_suffix);
	self.name_Company := choose(nameCounter,l.name1_company,l.name2_company,l.name3_company,l.name4_company,l.name5_company,l.name6_company,l.name7_company,l.name8_company);
	self.did := choose(nameCounter,(integer)l.name1_did,(integer)l.name2_did,(integer)l.name3_did,(integer)l.name4_did,(integer)l.name5_did,(integer)l.name6_did,(integer)l.name7_did,(integer)l.name8_did);
	self.did_score := choose(nameCounter,(integer)l.name1_did_score,(integer)l.name2_did_score,(integer)l.name3_did_score,(integer)l.name4_did_score,(integer)l.name5_did_score,(integer)l.name6_did_score,(integer)l.name7_did_score,(integer)l.name8_did_score);
	self.ssn	:= choose(nameCounter,l.name1_ssn,l.name2_ssn,l.name3_ssn,l.name4_ssn,l.name5_ssn,l.name6_ssn,l.name7_ssn,l.name8_ssn);
	self.bdid := choose(nameCounter,(integer)l.name1_bdid,(integer)l.name2_bdid,(integer)l.name3_bdid,(integer)l.name4_bdid,(integer)l.name5_bdid,(integer)l.name6_bdid,(integer)l.name7_bdid,(integer)l.name8_bdid);
	self.bdid_score := choose(nameCounter,(integer)l.name1_bdid_score,(integer)l.name2_bdid_score,(integer)l.name3_bdid_score,(integer)l.name4_bdid_score,(integer)l.name5_bdid_score,(integer)l.name6_bdid_score,(integer)l.name7_bdid_score,(integer)l.name8_bdid_score);
	self.site_prim_range :=l.situs1_prim_range;
	self.site_predir :=l.situs1_predir;
	self.site_prim_name :=l.situs1_prim_name;
	self.site_addr_suffix:=l.situs1_addr_suffix;
	self.site_postdir:=l.situs1_postdir;
	self.site_unit_desig:=l.situs1_unit_desig;
	self.site_sec_range:=l.situs1_sec_range;
	self.site_p_city_name:=l.situs1_p_city_name;
	self.site_v_city_name:=l.situs1_v_city_name;
	self.site_st:=l.situs1_st;
	self.site_zip:=l.situs1_zip;
	self.site_zip4:=l.situs1_zip4;
	self.name_indicator := nameCounter;
	self.sequence := L.source_rec_id;
	self.source := L.source;
	self := l;
end;

ds_BK_normalized := NORMALIZE(BKforeclosureIn,8,normalizeBK(LEFT,COUNTER));

SrtBKNorm	:= SORT(DISTRIBUTE(ds_BK_normalized(name_first != '' OR name_last != '' OR name_company != ''), HASH(foreclosure_id)), RECORD, -process_date, LOCAL);

CombineAll	:= appendSSNSortDist + SrtBKNorm;

EXPORT foreclosure_normalized := dedup(CombineAll,ALL,EXCEPT process_date,LOCAL);

//EXPORT foreclosure_normalized := dedup(appendSSNSortDist,RECORD,LOCAL);	//: persist('~thor_data400::persist::file_foreclosure_normalized'); // use persist here, if needed