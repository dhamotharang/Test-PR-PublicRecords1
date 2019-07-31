import BIPV2, vehicleV2,did_add,ut,header_slimsort,didville,business_header,business_header_ss,address,doxie_files,watchdog,mdr,header;

party_in			:=	VehicleV2.Map_Experian_Party	     +	
                  VehicleV2.Mapping_NC_party	       +	
									VehicleV2.Mapping_Vehicle_Party	   +	
									VehicleV2.mapping_OH_party         +
									VehicleV2.Mapping_Infutor_Motorcycle_Party +
									VehicleV2.Mapping_Infutor_Vin_Party;
 
party_in_dist	:=	distribute(party_in,hash(vehicle_key,iteration_key,sequence_key));

//add src
src_rec	:=
record
	header_slimsort.Layout_Source;
	VehicleV2.Layout_Base.Party_CCPA;
end;

party_in_proj		:=	project(party_in_dist,transform(src_rec,self := left,self := []));

//append DID
preDID		:=	party_in_proj(append_clean_cname	=		'');
preBDID  	:=	party_in_proj(append_clean_cname	<>	'');

DID_Add.Mac_Set_Source_Code(preDID,src_rec,MDR.sourceTools.str_convert_vehicle,preDID_src)

matchset	:=	['A','D','S'];

did_Add.MAC_Match_Flex(	preDID_src,matchset,						
												Orig_SSN,orig_dob,fname,mname,lname,name_suffix,
												ace_prim_range,ace_prim_name,ace_sec_range,ace_zip5,ace_st,foo,
												append_DID,
												src_rec,
												false,DID_Score_field,	//these should default to zero in definition
												75,
												postDID_src,true,src
											);

// Bug 85882 - Blank the DID's as the father and son are sharing the same DID's
// Dataset containing the vehicle, iteration and sequence keys for which the DID's need to be blank
dVehicleBlankDID	:=	dataset(	[	{'14011729971804357981','20071017NYAE','20071017200902R'},
																	{'14011729971804357981','20071017NYAE','20071114200902O'},
																	{'14011729971804357981','20090224NYAE','20071017200711R'},
																	{'14011729971804357981','20090224NYAE','20071114201101O'},
																	{'14011729971804357981','20090224NYAE','20090224201101R'},
																	{'14398494397303131850','20030930NYAE','20030930200502R'},
																	{'14398494397303131850','20050906NYAE','20031126201101O'},
																	{'14398494397303131850','20050906NYAE','20050906201101R'},
																	{'5858304443096139249','20100609NYAE','20100609201101R'},
																	{'5858304443096139249','20100609NYAE','20100630201101O'},
																	{'5858304443096139249','20100630NYAE','20100609201109R'},
																	{'5858304443096139249','20100630NYAE','20100630201109O'},
																	{'7120536221545954723','20091006NYAE','20091006200911R'},
																	{'7120536221545954723','20091006NYAE','20091027200911O'},
																	{'7120536221545954723','20091103NYAE','20091006200910R'},
																	{'7120536221545954723','20091103NYAE','20091027201109O'},
																	{'7120536221545954723','20091103NYAE','20091103201109R'},
																	{'9780296747397872560','20060817NYAE','20060817200701R'},
																	{'9780296747397872560','20060817NYAE','20060914200701O'},
																	{'9780296747397872560','20100115NYAE','20060817201101R'},
																	{'9780296747397872560','20100115NYAE','20060914201101O'}
																],
																{VehicleV2.Layout_Base.Party_CCPA.vehicle_key,VehicleV2.Layout_Base.Party_CCPA.iteration_key,VehicleV2.Layout_Base.Party_CCPA.sequence_key}
															);

// Reformat to the party layout
VehicleV2.Layout_Base.Party_CCPA	tBlankDIDs(postDID_src	le,dVehicleBlankDID	ri)	:=
transform
	self.Append_DID				:=	if(	le.vehicle_key		=	ri.vehicle_key		and
																le.iteration_key	=	ri.iteration_key	and
																le.sequence_key		=	ri.sequence_key,
																0,
																le.Append_DID
															);
	self.Append_DID_Score	:=	if(	le.vehicle_key		=	ri.vehicle_key		and
																le.iteration_key	=	ri.iteration_key	and
																le.sequence_key		=	ri.sequence_key,
																0,
																le.Append_DID_Score
															);
	self									:=	le;
end;

postDID 	:=	join(	postDID_src,
									dVehicleBlankDID,
									left.vehicle_key		=	right.vehicle_key		and
									left.iteration_key	=	right.iteration_key	and
									left.sequence_key		=	right.sequence_key,
									tBlankDIDs(left,right),
									left outer,
									lookup
								);

postdid_dist	:=	distribute(postDID,random()):	persist('~thor_data400::persist::vehreg_postdid');

preBDID_source	:=	table(preBDID,{preBDID,string source	:=	mdr.sourceTools.fVehicles(State_Origin,Source_code)});

mac_src_match_rec	:=
record
	VehicleV2.Layout_Base.Party_CCPA;
	unsigned6				BDID;
	string 					source;
end;

mac_src_match_rec  	populate_BDID(preBDID_source l) := transform
		self.bdid := l.Append_BDID;
		self			:= l;
end;

mac_src_match_proj		:=	project(preBDID_source,populate_BDID(left));

business_header.MAC_Source_Match(
		 mac_src_match_proj							// infile
		,postsourcematch								// outfile
		,false													// bool_bdid_field_is_string12
		,bdid														// bdid_field
    ,true														// bool_infile_has_source_field
		,source													// source_type_or_field
    ,false													// bool_infile_has_source_group
		,foo														// source_group_field
		,append_clean_cname							// company_name_field
		,ace_prim_range									// prim_range_field
		,ace_prim_name									// prim_name_field
		,ace_sec_range									// sec_range_field
		,ace_zip5												// zip_field
		,false													// bool_infile_has_phone
		,foo														// phone_field
		,true														// bool_infile_has_fein
		,orig_fein											// fein_field
		,false													// bool_infile_has_vendor_id = 'false'
		,foo														// vendor_id field					 = 'vendor_id'
		);

bmatch	:=	['A','F'];

business_header_ss.MAC_Match_Flex(
			 postsourcematch											// input dataset						
			,bmatch				                				// bdid matchset what fields to match on           
			,append_clean_cname	                  // company_name	              
			,prim_range		                  			// prim_range		              
			,prim_name		                    		// prim_name		              
			,zip5					                    		// zip5					              
			,sec_range		                    		// sec_range		              
			,st				        		          			// state				              
			,foo						                    	// phone				              
			,orig_fein            			          // fein              
			,bdid														      // bdid												
			,recordof(postsourcematch)				    // output layout 
			,false                                // output layout has bdid score field? 																	
			,foo                     							// bdid_score                 
			,postBDID				          						// output dataset
			,																			// keep count
			,																			// default threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// create BIP keys only
			,																			// url
			,																			// email 
			,v_city_name													// city
			,fname																// fname
			,mname																// mname
			,lname																// lname
			,orig_ssn															// contact ssn
			,source																// source
			,source_rec_id												// source_record_id
			,true
		);																																								

VehicleV2.Layout_Base.Party_CCPA x2PartyBIP(mac_src_match_rec l) := transform
	self.append_bdid := l.bdid;
	self := l;
end;

postbdid_all  := 	project(postBDID,x2PartyBIP(left));
postbdid_dist	:=	distribute(postbdid_all,random())	:	persist('~thor_data400::persist::vehreg_postbdid');
//Infutor data are dppa. Do not populate SSN and FEIN
post_DID_BDID	:=	postdid_dist(TRIM(Source_Code) NOT IN ['1V','2V']) + postbdid_dist(TRIM(Source_Code) NOT IN ['1V','2V']);

//****** Get SSN and FEIN from headers where we don't have it
//append SSN by DID
did_add.MAC_Add_SSN_By_DID(post_DID_BDID,append_did,append_ssn,postSSN)

//append FEIN by bdid
Business_Header_SS.MAC_Add_FEIN_By_BDID(postSSN,append_bdid,append_fein,postFEIN)

vehicle_party_out := postFEIN + postdid_dist(TRIM(Source_Code) IN ['1V','2V']) +
                     postbdid_dist(TRIM(Source_Code) IN ['1V','2V']);

//Bug 148899 - set decal number to blank if it is all zeros
VehicleV2.Layout_Base.Party_CCPA	tBlankRegDecalNumber(vehicle_party_out	le)	:=
transform
	self.reg_decal_number	:=	if(regexfind('^0+$',trim(le.reg_decal_number)),'',le.reg_decal_number);
	self									:=	le;
end;

vehicle_party_out_fix_decal	:=	project(vehicle_party_out, tBlankRegDecalNumber(LEFT));

vehicle_party_dist:= distribute(vehicle_party_out_fix_decal,hash(vehicle_key,iteration_key,sequence_key));
vehicle_party_sort:= sort(vehicle_party_dist,vehicle_key,iteration_key,sequence_key,local);

export	VehicleV2_did	:=	vehicle_party_sort;