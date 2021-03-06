import	header,ln_property,ln_mortgage,ut,_control,mdr, std;

export	ln_propertyv2_as_source(boolean pFastHeader = false)	:=	module
						
//same filter used in v1						
shared dLNPropertySearch		:=	if(pFastHeader
																				,LN_PropertyV2.File_Search_DID(ut.DaysApart((STRING8)Std.Date.Today(), ((STRING)dt_vendor_last_reported)[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep)
																				,dataset('~thor_data400::base::ln_propv2srchheader_building',ln_propertyv2.Layout_DID_Out,flat)
																				)
																				(did < (unsigned6)ln_property.irs_dummy_cutoff and source_code not in ['SO','OS'])
																				;
shared dLNPropertyDeed			:= if(pFastHeader
																				,LN_PropertyV2.File_Deed
																				,dataset('~thor_data400::base::ln_propv2deedheader_building',ln_propertyv2.layout_deed_mortgage_common_model_base,flat)
																				);
shared dLNPropertyTax				:= if(pFastHeader
																				,LN_PropertyV2.File_Assessment
																				,dataset('~thor_data400::base::ln_propv2assessheader_building',ln_propertyv2.layout_property_common_model_base,flat)
																				);
shared dLNPropertyAddlDeed	:= if(pFastHeader
																				,LN_PropertyV2.File_addl_fares_deed
																				,dataset('~thor_data400::base::ln_propv2addldeedheader_building',ln_propertyv2.layout_addl_fares_deed,flat)
																				);
shared dLNPropertyAddlTax		:= if(pFastHeader
																				,LN_PropertyV2.File_addl_Fares_tax
																				,dataset('~thor_data400::base::ln_propv2addlassessheader_building',ln_propertyv2.layout_addl_fares_tax,flat)
																				);
						
//temporarily map to v1 layout - no substantial content gained in v2
ds1	:=	distribute(dLNPropertyTax,hash(ln_fares_id));
ds2	:=	distribute(dLNPropertyAddlTax,hash(ln_fares_id));

ln_property.Layout_Property_Common_Model_BASE t1(ds1 le, ds2 ri)	:=	transform
 self.dummy_seg	:=	le.prop_addr_propagated_ind;
 self          	:=	le;
 self          	:=	ri;
 self          	:=	[];
end;

in_file_tax	:=	join(	ds1,ds2,
											left.ln_fares_id=right.ln_fares_id,
											t1(left,right),
											left outer,
											local
										);

src_rec_tax	:=	record 
	header.Layout_Source_ID;
	LN_Property.Layout_Property_Common_Model_BASE;
end;

seed:=if(pFastHeader,999999999999,1);
header.Mac_Set_Header_Source(in_file_tax(ln_fares_id[1] ='R'),LN_Property.Layout_Property_Common_Model_BASE,src_rec_tax,mdr.sourceTools.src_LnPropV2_Fares_Asrs,withUID1,seed)
header.Mac_Set_Header_Source(in_file_tax(ln_fares_id[1]!='R'),LN_Property.Layout_Property_Common_Model_BASE,src_rec_tax,mdr.sourceTools.src_LnPropV2_Lexis_Asrs,withUID2,seed) 
                                                                                                           
export	ln_propertyv2_tax_as_source	:=	distribute(withUID1 + withUID2,hash(uid))	:	persist('~thor_data400::persist::ln_propertyv2::headerbuild_ln_asses_src');

ds3	:=	distribute(dLNPropertyDeed,hash(ln_fares_id));
ds4	:=	distribute(dLNPropertyAddlDeed,hash(ln_fares_id));

//dummy_seg field was originally used to store the propagated indicator
//logic was only applied to deed data in v1, no tax
ln_mortgage.Layout_Deed_Mortgage_Common_Model_BASE t2(ds3 le, ds4 ri)	:=	transform
 self.dummy_seg	:=	le.prop_addr_propagated_ind;
 self          	:=	le;
 self          	:=	ri;
 self          	:=	[];
end;

in_file_deed	:=	join(	ds3,ds4,
												left.ln_fares_id=right.ln_fares_id,
												t2(left,right),
												left outer,
												local
											);

src_rec_deed	:=	record 
	header.Layout_Source_ID;
	LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE;
end;

seed:=if(pFastHeader,999999999999,1);
header.Mac_Set_Header_Source(in_file_deed(ln_fares_id[1] ='R'),LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE,src_rec_deed,mdr.sourceTools.src_LnPropV2_Fares_Deeds			,withUID3,seed)
header.Mac_Set_Header_Source(in_file_deed(ln_fares_id[1]!='R'),LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE,src_rec_deed,mdr.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs,withUID4,seed)
                                                                                                                 
export ln_propertyv2_deed_as_source	:=	distribute(withUID3 + withUID4,hash(uid))	:	persist('~thor_data400::persist::ln_propertyv2::headerbuild_ln_deed_src');

r1	:=	record
	unsigned6 uid;
	string12  ln_fares_id;
	string2   src;
	string1   dummy_seg;
end;

r1 t1(ln_propertyv2_deed_as_source le)	:=	transform
	self          	:=	le;
end;

r1 t2(ln_propertyv2_tax_as_source le)	:=	transform
	self          	:=	le;
end;

p1	:=	project(ln_propertyv2_deed_as_source,t1(left));
p2	:=	project(ln_propertyv2_tax_as_source, t2(left));

concat     	:=	p1+p2;
concat_dist	:=	distribute(concat,hash(ln_fares_id));
concat_sort	:=	sort      (concat_dist,ln_fares_id,uid,src,-dummy_seg,local);
concat_dupd	:=	dedup     (concat_sort,ln_fares_id,uid,src,local);

search_dist	:=	distribute(dLNPropertySearch,hash(ln_fares_id));

r2	:=	record
	boolean is_true;
	concat_dupd.uid;
	concat_dupd.src;
	concat_dupd.dummy_seg;
	dLNPropertySearch; 
end;

//is_true denotes a propagated property address record
//we want to exclude those from the header
r2 t3(search_dist le, concat_dupd ri)	:=	transform
	self.is_true	:=	if(le.ln_fares_id=ri.ln_fares_id and le.source_code[2]='P' and ri.dummy_seg='P',true,false);
	self        	:=	le;
	self        	:=	ri;
end;

export p3	:=	join(	search_dist,concat_dupd,
										left.ln_fares_id=right.ln_fares_id,
										t3(left,right),
										local
									);

//flip_name filter can be lifted once there's some assurance that it's working properly
//for now let's prevent them from getting into the header
shared p3_filt	:=	p3(~(is_true));

//not the exact header layout -> source_code field added from property
r_layout_new_records_strings	:=	record
	unsigned8 uid    	:=	0;
	unsigned6 did;
	unsigned6 rid;
	string1   pflag1 	:=	'';
	string1   pflag2 	:=	'';
	string1   pflag3 	:=	'';
	string2   src;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	unsigned3 dt_vendor_last_reported;
	unsigned3 dt_vendor_first_reported;
	unsigned3 dt_nonglb_last_seen;
	string1   rec_type;
	string18  vendor_id;
	string2   source_code ; 
	string10  phone;
	string9   ssn;
	integer4  dob;
	string5   title;
	string20  fname;
	string20  mname;
	string20  lname;
	string5   name_suffix;
	string10  prim_range;
	string2   predir;
	string28  prim_name;
	string4   suffix;
	string2   postdir;
	string10  unit_desig;
	string8   sec_range;
	string25  city_name;
	string2   st;
	string5   zip;
	string4   zip4;
	string3   county;
	string7   geo_blk;
	string5   cbsa     	:=	'';
	string1   tnt      	:=	'';
	string1   valid_SSN	:=	'';
	string1   jflag1   	:=	'';
	string1   jflag2   	:=	'';
	string1   jflag3   	:=	'';
end;

r_layout_new_records_strings t4(p3_filt le)	:=	transform
	self.dt_nonglb_last_seen	:=	le.dt_last_seen;
	self.rec_type           	:=	if(le.source_code[1] in ['O','B'], '1', '2');   //buying = 1, selling = 2
	self.vendor_id          	:=	le.ln_fares_id+'FA'+((string)(hash(le.fname,le.lname,le.prim_name)))[1..4];
	self.ssn                	:=	'';
	self.dob                	:=	0;
	self.phone              	:=	le.phone_number;
	self.prim_range         	:=	header.fixPrimRange(le.prim_range);
	self.city_name          	:=	le.v_city_name;
	self.county             	:=	le.county[3..5];
	self.rid                	:=	0;
	self.uid                	:=	le.uid;
	self.src                	:=	le.src;
	self                    	:=	le;
end;

p4	:=	project(p3_filt,t4(left));

p4_dist	:=	distribute(p4,hash(	src,
																vendor_id,
																fname,
																mname,
																lname,
																name_suffix,
																prim_range,
																predir,
																prim_name,
																suffix,
																postdir,
																unit_desig,
																sec_range,
																city_name,
																st,
																zip,
																zip4,
																county,
																phone,
																rec_type
															)
											);
p4_sort	:=	sort(p4_dist,src,vendor_id,fname,mname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,phone,rec_type,-source_code[2],local);

r_layout_new_records_strings t_rollup(p4_sort le, p4_dist ri)	:=	transform
 self.dt_first_seen           	:=	ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen            	:=	Max(le.dt_first_seen,ri.dt_first_seen);
 self.dt_vendor_first_reported	:=	ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_vendor_last_reported 	:=	self.dt_last_seen;
 self.dt_nonglb_last_seen     	:=	self.dt_last_seen;
 self                         	:=	le;
end;

shared p_rollup	:=	rollup(	p4_sort,
														left.src         = right.src         and 
														left.vendor_id   = right.vendor_id   and
														left.fname       = right.fname       and 
														left.mname       = right.mname       and 
														left.lname       = right.lname       and 
														left.name_suffix = right.name_suffix and
														left.prim_range  = right.prim_range  and 
														left.predir      = right.predir      and
														left.prim_name   = right.prim_name   and
														left.suffix      = right.suffix      and
														left.postdir     = right.postdir     and
														left.unit_desig  = right.unit_desig  and
														left.sec_range   = right.sec_range   and 
														left.city_name   = right.city_name   and
														left.st          = right.st          and
														left.zip         = right.zip         and
														left.zip4        = right.zip4        and
														left.county      = right.county      and
														left.phone       = right.phone       and
														left.rec_type    = right.rec_type,
														t_rollup(left,right),
														local
													);
	  

header.Layout_New_Records t_map_to_new_records(p_rollup le)	:=	transform
	self.did	:=	0;
	self	:=	le;
end;

p_rollup_new_records	:=	project(p_rollup,t_map_to_new_records(left));
				  
p_rollup_filt	:=	p_rollup_new_records	:	persist('~thor_data400::persist::ln_propertyv2::headerbuild_ln_property_as_header');
				  
export ln_propertyv2_as_header	:=	p_rollup_filt
                                   (
																		fname <> '',
																		lname <> '', 
																		length(trim(fname)) > 1,
																		prim_name <> '',
																		~(prim_range='' and zip4=''),
																		length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' ')),
																		//a lot of SG's in the fares data throwing off the name cleaner
																		trim(title)<>'SGT',
																		trim(lname)<>'SG'
																	);

header.Layout_New_Records t_map_to_newf_records(p_rollup le)	:=	transform
	self.did	:=	le.did;
	self	:=	le;
end;

fp_rollup_new_records	:=	project(p_rollup,t_map_to_newf_records(left));
				  
fp_rollup_filt	:=	fp_rollup_new_records(ut.DaysApart((STRING8)Std.Date.Today(), ((STRING)dt_vendor_last_reported)[..6] + '01') <= Header.Sourcedata_month.v_fheader_days_to_keep)	:	persist('~thor_data400::persist::ln_propertyv2::headerbuild_ln_property_as_header');
	
export ln_propertyv2_as_fheader	:=	fp_rollup_filt
                                   (
																		fname <> '',
																		lname <> '', 
																		length(trim(fname)) > 1,
																		prim_name <> '',
																		~(prim_range='' and zip4=''),
																		length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' ')),
																		//a lot of SG's in the fares data throwing off the name cleaner
																		trim(title)<>'SGT',
																		trim(lname)<>'SG'
																	);

export pwatchdog	:=	p_rollup(vendor_id[1]= 'R')	:	persist('~thor_data400::persist::ln_propertyv2::watchdog_prop_did'); //Watchdog taking only fares data

// reformat watchdog to header layout 
header.Layout_New_Records  reformat( pwatchdog l)	:=	transform 
	self	:=	l ; 
end; 
export watchdog_prop_didv2	:=	project(pwatchdog,reformat(left)) ;  									   
end;