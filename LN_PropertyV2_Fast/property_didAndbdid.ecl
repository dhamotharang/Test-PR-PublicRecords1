/*2014-10-24T22:31:22Z (Gabriel Marcan_prod)
Updated search layout to streamline prep to base
*/
import ln_propertyv2,property,ln_property, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address, watchdog,mdr,header, BIPV2;

export property_didAndbdid(dataset(ln_propertyv2.Layout_DID_Out) in_srch,
														boolean isFast) := function

preFix := IF(isFast,'property_fast','ln_propertyv2');

ln_propertyv2.Layout_DID_Out roll_dates(ln_propertyv2.Layout_DID_Out l) := transform
	self.dt_first_seen            := if(l.dt_last_seen > l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
	self.dt_last_seen             := if(l.dt_last_seen < l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
	self.dt_vendor_last_reported  := (integer)l.process_date[1..6];
	self.dt_vendor_first_reported := (integer)l.process_date[1..6];
	self.mname                    := stringlib.stringfindreplace(l.mname,',ETAL','');
	self.nameasis                 := ln_property.fn_patch_name_field(l.nameasis);
	self                          := l;
end;

file_dedup := dedup(project(distribute(in_srch,hash(ln_fares_id)), roll_dates(left)),all,local);

PreDID_Rec
 :=
  record
    
	qstring34  source_group := '';
	qstring34  vendor_id := '';
	ln_propertyv2.Layout_DID_Out; 
	integer8	temp_DID		    := 0;
	integer8	temp_BDID 	    := 0;
	string9 appended_SSN := '';
  string9 appended_tax_id := '';
	//BIPV2.IDlayouts.l_xlink_ids;
	//unsigned8 source_rec_id := 0;
	string2 source := '';
	//integer2	xadl2_weight		:= 0;		
	integer3 DID_Score := 0;
	integer3 BDID_Score := 0;
	
  end;
  
PreDID_Rec taddDID(file_dedup L)
 :=
  transform // CHANGE1	
	self.vendor_id	:=  l.ln_fares_id + 'FA' + ((string)(hash(l.fname, l.lname, l.prim_name)))[1..4];

																	
	self.source 		:= MDR.sourceTools.fProperty(l.ln_fares_id);
	self						:= L;
	
  end
 ;

Prefile	:= project(file_dedup,taddDID(left)); 

//append SRC 

preDID  := prefile(cname  = '');
preBDID := prefile(cname <> '');

src_rec := record

header_slimsort.Layout_Source;
PreDID_Rec;
end;

DID_ADD.Mac_Set_Source_Code(preDID, src_rec, MDR.sourceTools.str_convert_property, preDID_src)

//append DID

matchset := ['A', 'P', 'Z'];

did_add.MAC_Match_Flex
	(preDID_src, matchset,					
	 '', '', fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone_number, 
	 temp_did, Src_Rec, true, DID_Score,
	 75, postDID_src, true, src)

//remove SRC

postDID := project(postDID_src, transform(PreDID_Rec, self := left)); 

// added V1 logic bug#28584 


with_did := dedup(sort(distribute(postDID(temp_did>0),hash((STRING12)ln_fares_id)),ln_fares_id,fname,lname,-did_score,local),ln_fares_id,fname,lname,local);
no_did := distribute(postDID(temp_did=0),hash((STRING12)(ln_fares_id)));

PreDID_Rec propDIDs(no_did L, with_did R) := transform
 self.temp_did := r.temp_did;
  self.xadl2_weight := r.xadl2_weight;
 self := l;
end;

added_dids1 := join(no_did,with_did,
										left.ln_fares_id=right.ln_fares_id
										and left.fname=right.fname
										and left.lname=right.lname,
										propDIDs(left,right),
										left outer,local) + postDID(temp_did > 0) ;

added_dids2 := distribute(added_dids1, 
												 hash(vendor_source_flag, ln_fares_id, process_date, source_code, title, fname, mname, lname, 
												 name_suffix, cname, nameasis, prim_range, predir, prim_name, suffix, postdir, unit_desig, 
												 sec_range, p_city_name, v_city_name, st, zip, zip4, cart, cr_sort_sz, lot, lot_order, dbpc, 
												 chk_digit, rec_type, county, geo_lat, geo_long, msa, geo_blk, geo_match, err_stat)
												 );
									
added_dids3 := sort(added_dids2, vendor_source_flag, ln_fares_id, process_date, source_code, title, fname, mname, lname, 
										 name_suffix, cname, nameasis, prim_range, predir, prim_name, suffix, postdir, unit_desig, 
										 sec_range, p_city_name, v_city_name, st, zip, zip4, cart, cr_sort_sz, lot, lot_order, dbpc, 
										 chk_digit, rec_type, county, geo_lat, geo_long, msa, geo_blk, geo_match, err_stat, 
										 -temp_did, local);
					 
added_dids := dedup(added_dids3, record, except temp_did, local);
	 
//append BDID
business_header.MAC_Source_Match(preBDID,dPostSourceMatch,
																false,temp_BDID,
																true,source,
																false,foo,
																cname,
																prim_Range,Prim_name,sec_range,zip,
																true,phone_number,
																false,foo,
																false,vendor_id);	 

myset := ['A'];

//append BDID's and  BIPv2 xlinkids.
Business_header_ss.MAC_Match_Flex(dPostSourceMatch
																	,myset
																	,cname
																	,prim_range
																	,prim_name
																	,zip
																	,sec_range
																	,st
																	,phone_number
																	,foo
																	,temp_bdid
																	,PreDID_Rec
																	,true
																	,BDID_Score
																	,postbdid
																	,
																	,															// deafult threscold
																	,													 		// use prod version of superfiles
																	,															// default is to hit prod from dataland, and on prod hit prod.
																	,BIPV2.xlink_version_set 			// Create BIP Keys only
																	,           								 	// Url
																	,								            	// Email
																	,p_city_name							 		// City
																	,fname							      		// fname
																	,mname												// mname
																	,lname						 						// lname
																	,															// contact_ssn
																	,source												// source
																	,source_rec_id								// source_rec_id
																	,true
																	);
						
post_DID_BDID := postbdid +  added_dids;

//Append SSN 

did_add.MAC_Add_SSN_By_DID(post_DID_BDID, temp_did, appended_SSN, file_search_ssn, false);

// Append Fein

Business_Header_SS.MAC_Add_FEIN_By_BDID(file_search_ssn, temp_bdid, appended_tax_id, file_search_fein);

LN_PropertyV2.Layout_DID_Out reformattemp(file_search_fein L)
 :=
  transform
    self.DID		   							:= L.temp_DID;
    self.BDID		    						:= L.temp_BDID;
		self.app_SSN    						:= l.appended_SSN ;
    self.app_tax_id 						:= l.appended_tax_id ;
		self.source_rec_id 					:= l.source_rec_id;
		
		self.ln_party_status				  := LN_PropertyV2_Fast.Functions_LN_Owner_Fields.ExtractPartyStatus(l.nameasis);
		self.ln_percentage_ownership	:= LN_PropertyV2_Fast.Functions_LN_Owner_Fields.extractinterest(l.nameasis);
		self.ln_entity_type						:= if(L.ln_entity_type='D','P',L.ln_entity_type);
		self.ln_estate_trust_date			:= LN_PropertyV2_Fast.Functions_LN_Owner_Fields.getValidDate(l.nameasis);
		self.ln_goverment_type				:= LN_PropertyV2_Fast.Functions_LN_Owner_Fields.setgovtype(l.nameasis);
		//self.nid										:= 0;
		self 													:= L;
		
	end;

// CHANGE2
outfinal_pre_app_addr_ind	 := project(file_search_fein, reformattemp(left));

outfinal_pre_patch_linkIds := LN_PropertyV2_Fast.fn_append_addr_ind(outfinal_pre_app_addr_ind);

outfinal := ln_propertyV2_fast.fn_base_search_patch.linkids(outfinal_pre_patch_linkIds);

// Jira DF-11862 - added isfast to persist name file in order to run continuous delta
search_final := distribute(outfinal,hash(ln_fares_id)) : persist('~thor_data400::persist::'+preFix+'::property_did'+if(isFast,'_d','f')); /*+ ln_property.irs_dummy_recs_search */

return search_final;

end;