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
Property.Layout_Foreclosure_Base_Normalized normalizeRecords (foreclosureIn l, unsigned1 nameCounter) := transform
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
Property.Layout_Foreclosure_Base_Normalized normalize_Addr_Records(Property.Layout_Foreclosure_Base_Normalized l, unsigned1 c) := transform
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
Property.Layout_Foreclosure_Base_Normalized;
end;

DID_Add.Mac_Set_Source_Code (ds_normalized, src_rec, 'FR', foreclosureBaseNormalized_src)

matchset := ['A','Z'];

did_add.MAC_Match_Flex(foreclosureBaseNormalized_src,matchset,
											 foo,foo,name_first,name_middle,name_last,name_suffix,
											 site_prim_range,site_prim_name,site_sec_range,site_zip,site_st,foo,
											 did,src_rec,
											 true,did_score,75,foreclosureDID_src,true,src);
//remove src 
foreclosureDID := project(foreclosureDID_src, transform(Property.Layout_Foreclosure_Base_Normalized, self := left));

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
			,Property.Layout_Foreclosure_Base_Normalized		// output layout 
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

Property.Layout_Foreclosure_Base_Normalized normalizeBK(BKforeclosureIn l, unsigned1 nameCounter) := TRANSFORM
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
	self.DotID		  := choose(nameCounter,l.name1.DotID,l.name2.DotID,l.name3.DotID,l.name4.DotID,l.name5.DotID,l.name6.DotID,l.name7.DotID,l.name8.DotID);
	self.DotScore		:= choose(nameCounter,l.name1.DotScore,l.name2.DotScore,l.name3.DotScore,l.name4.DotScore,l.name5.DotScore,l.name6.DotScore,l.name7.DotScore,l.name8.DotScore);
	self.DotWeight	:= choose(nameCounter,l.name1.DotWeight,l.name2.DotWeight,l.name3.DotWeight,l.name4.DotWeight,l.name5.DotWeight,l.name6.DotWeight,l.name7.DotWeight,l.name8.DotWeight);
	self.EmpID		  := choose(nameCounter,l.name1.EmpID,l.name2.EmpID,l.name3.EmpID,l.name4.EmpID,l.name5.EmpID,l.name6.EmpID,l.name7.EmpID,l.name8.EmpID);
	self.EmpScore		:= choose(nameCounter,l.name1.EmpScore,l.name2.EmpScore,l.name3.EmpScore,l.name4.EmpScore,l.name5.EmpScore,l.name6.EmpScore,l.name7.EmpScore,l.name8.EmpScore);
	self.EmpWeight	:= choose(nameCounter,l.name1.EmpWeight,l.name2.EmpWeight,l.name3.EmpWeight,l.name4.EmpWeight,l.name5.EmpWeight,l.name6.EmpWeight,l.name7.EmpWeight,l.name8.EmpWeight);
	self.POWID		  := choose(nameCounter,l.name1.POWID,l.name2.POWID,l.name3.POWID,l.name4.POWID,l.name5.POWID,l.name6.POWID,l.name7.POWID,l.name8.POWID);
	self.POWScore		:= choose(nameCounter,l.name1.POWScore,l.name2.POWScore,l.name3.POWScore,l.name4.POWScore,l.name5.POWScore,l.name6.POWScore,l.name7.POWScore,l.name8.POWScore);
	self.POWWeight	:= choose(nameCounter,l.name1.POWWeight,l.name2.POWWeight,l.name3.POWWeight,l.name4.POWWeight,l.name5.POWWeight,l.name6.POWWeight,l.name7.POWWeight,l.name8.POWWeight);
	self.ProxID		  := choose(nameCounter,l.name1.ProxID,l.name2.ProxID,l.name3.ProxID,l.name4.ProxID,l.name5.ProxID,l.name6.ProxID,l.name7.ProxID,l.name8.ProxID);
	self.ProxScore	:= choose(nameCounter,l.name1.ProxScore,l.name2.ProxScore,l.name3.ProxScore,l.name4.ProxScore,l.name5.ProxScore,l.name6.ProxScore,l.name7.ProxScore,l.name8.ProxScore);
	self.ProxWeight	:= choose(nameCounter,l.name1.ProxWeight,l.name2.ProxWeight,l.name3.ProxWeight,l.name4.ProxWeight,l.name5.ProxWeight,l.name6.ProxWeight,l.name7.ProxWeight,l.name8.ProxWeight);
	self.SeleID		  := choose(nameCounter,l.name1.SeleID,l.name2.SeleID,l.name3.SeleID,l.name4.SeleID,l.name5.SeleID,l.name6.SeleID,l.name7.SeleID,l.name8.SeleID);
	self.SeleScore	:= choose(nameCounter,l.name1.SeleScore,l.name2.SeleScore,l.name3.SeleScore,l.name4.SeleScore,l.name5.SeleScore,l.name6.SeleScore,l.name7.SeleScore,l.name8.SeleScore);
	self.SeleWeight	:= choose(nameCounter,l.name1.SeleWeight,l.name2.SeleWeight,l.name3.SeleWeight,l.name4.SeleWeight,l.name5.SeleWeight,l.name6.SeleWeight,l.name7.SeleWeight,l.name8.SeleWeight);	
	self.OrgID		  := choose(nameCounter,l.name1.OrgID,l.name2.OrgID,l.name3.OrgID,l.name4.OrgID,l.name5.OrgID,l.name6.OrgID,l.name7.OrgID,l.name8.OrgID);
	self.OrgScore		:= choose(nameCounter,l.name1.OrgScore,l.name2.OrgScore,l.name3.OrgScore,l.name4.OrgScore,l.name5.OrgScore,l.name6.OrgScore,l.name7.OrgScore,l.name8.OrgScore);
	self.OrgWeight	:= choose(nameCounter,l.name1.OrgWeight,l.name2.OrgWeight,l.name3.OrgWeight,l.name4.OrgWeight,l.name5.OrgWeight,l.name6.OrgWeight,l.name7.OrgWeight,l.name8.OrgWeight);
	self.UltID		  := choose(nameCounter,l.name1.UltID,l.name2.UltID,l.name3.UltID,l.name4.UltID,l.name5.UltID,l.name6.UltID,l.name7.UltID,l.name8.UltID);
	self.UltScore		:= choose(nameCounter,l.name1.UltScore,l.name2.UltScore,l.name3.UltScore,l.name4.UltScore,l.name5.UltScore,l.name6.UltScore,l.name7.UltScore,l.name8.UltScore);
	self.UltWeight	:= choose(nameCounter,l.name1.UltWeight,l.name2.UltWeight,l.name3.UltWeight,l.name4.UltWeight,l.name5.UltWeight,l.name6.UltWeight,l.name7.UltWeight,l.name8.UltWeight);
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