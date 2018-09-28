import bipv2,fieldstats,business_header,business_header_ss,did_add,didville,fair_isaac,ut,census_data,STRATA,address,header_slimsort,mdr,tools,PromoteSupers;

export proc_build_base(string filedate) := function

  df := proc_prebuild_clean_records(filedate);

  //Bringing in the base file in order to get the source_rec_Id's.
  base_ds := File_FCC_base_bip_AID;  

  Layout_FCC_base_bip_AID Persist_SRCRecID(df L, base_ds R) := transform
    self.source_rec_id := r.source_rec_id;
    self := l;
  end;

  //Join the update file with the base file for source_rec_id persistence 
  ds_with_srcid := join(distribute(df,hash(unique_key)),
								        distribute(base_ds,hash(unique_key)),
								        left.unique_key=right.unique_key,
								        Persist_SRCRecID(left,right),
								        left outer,
								        local);

  //normalize to feed through bdid and did macros
  ut.MAC_Sequence_Records(ds_with_srcid,fcc_seq,with_seq);

  pre_layout := record
    unsigned6 fcc_seq;
    string1		name_type;
    unsigned6	BDID_DID;
    string50 	cname;
    string10  prim_range;
    string28  prim_name;
    string8   sec_range;
    string25  v_city_name;
    string2   st;
    string5   zip5;
    string20  fname;
    string20  mname;
    string20  lname;
    string5   suffix;
    string10  phone;
    string2		source := MDR.sourceTools.src_FCC_Radio_Licenses;
    BIPV2.IDlayouts.l_xlink_ids;
    unsigned8	source_rec_id;
  end;

  pre_layout norm_data(with_seq L, integer cnt) := transform
    self.name_type := map(cnt=1 => 'L',
                          cnt=2 => 'D',
				    							cnt=3=>  'A',
											    'F');
    self.BDID_DID :=0;
    self.cname := map(cnt=1 =>l.clean_licensees_name,
				              cnt=2 => l.clean_dba_name,
									    cnt=4 => l.clean_firm_name,
									    '');
    self.fname := if(cnt=3,l.attention_fname,'');
    self.mname := if(cnt=3,l.attention_mname,'');
    self.lname := if(cnt=3,l.attention_lname,'');
    self.suffix := if(cnt=3,l.attention_name_suffix,'');
    self.prim_range := if(cnt=4, l.firm.prim_range,l.prim_range);
    self.prim_name := if(cnt=4, l.firm.prim_name,l.prim_name);
    self.sec_range := if(cnt=4, l.firm.sec_range,l.sec_range);
    self.v_city_name := if(cnt=4,l.firm.v_city_name, l.v_city_name);
    self.st := if(cnt=4,l.firm.st,l.st);
    self.zip5 := if(cnt=4,l.firm.zip5,l.zip5);
    self.phone := if(cnt=4,l.contact_firms_phone_number,l.licensees_phone);
    self := l;
  end;

  ready4id := normalize(with_seq,4,norm_data(left,counter));

  to_bdid := ready4id(cname!='');
  to_did := ready4id(cname='');

  myset := ['A','P'];

  business_header_ss.MAC_Match_Flex(
			 to_bdid															// input dataset						
			,myset				                				// bdid matchset what fields to match on           
			,cname	                  						// company_name	              
			,prim_range		                  			// prim_range		              
			,prim_name		                    		// prim_name		              
			,zip5					                    		// zip5					              
			,sec_range		                    		// sec_range		              
			,st				        		          			// state				              
			,phone						                    // phone				              
			,foo            			          			// fein              
			,bdid_did														  // bdid												
			,pre_layout			    									// output layout 
			,false                                // output layout has bdid score field? 																	
			,foo                     							// bdid_score                 
			,bdid_1				          							// output dataset
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
			,																			// contact ssn
			,source																// source
			,source_rec_id												// source_record_id
			,false
	);					
					
  no_bdid := bdid_1(bdid_did=0);
  wbdid_1 := bdid_1(bdid_did>0);

  business_header.MAC_Source_Match(
		 no_bdid												// infile
		,bdid_2													// outfile
		,false													// bool_bdid_field_is_string12
		,bdid_did												// bdid_field
    ,false													// bool_infile_has_source_field
		,MDR.sourceTools.src_FCC_Radio_Licenses		// source_type_or_field
    ,false													// bool_infile_has_source_group
		,foo														// source_group_field
		,cname													// company_name_field
		,prim_range											// prim_range_field
		,prim_name											// prim_name_field
		,sec_range											// sec_range_field
		,zip5														// zip_field
		,true														// bool_infile_has_phone
		,phone													// phone_field
		,false													// bool_infile_has_fein
		,foo														// fein_field
		,																// bool_infile_has_vendor_id = 'false'
		,																// vendor_id field					 = 'vendor_id'
	);

  //all records that went through the BDID process
  all_bdids := bdid_2 + wbdid_1;

  //append DID
  matchset :=['A', 'z', 'P'];

  did_Add.MAC_Match_Flex(to_did, matchset,
	                       ssn, '', fname, mname,lname, suffix, 
	                       prim_range, prim_name, sec_range, zip5, st,phone,
	                       bdid_did,   			
	                       pre_layout, 
	                       false, did_score_field,	//these should default to zero in definition
	                       75,	  //dids with a score below here will be dropped 	
	                       wDID)

  //all records with an ID to be joined to main file
  all_rec := wDID + all_bdids;

  fcc.Layout_FCC_base_bip_AID getIDs(with_seq L, all_rec R) := transform
    self.licensee_bdid  := if(r.name_type = 'L', r.bdid_did,   0);
    self.dba_bdid 			:= if(r.name_type = 'D', r.bdid_did,   0);
    self.firm_bdid 		  := if(r.name_type = 'F', r.bdid_did,   0);
    self.attention_did  := if(r.name_type = 'A', r.bdid_did,   0);
    self.source_rec_id  := r.source_rec_id;
    self.DotID					:= IF(r.name_type	= 'L', r.DotID,      0);
    self.DotScore			  := IF(r.name_type	= 'L', r.DotScore,   0);
    self.DotWeight			:= IF(r.name_type	= 'L', r.DotWeight,  0);
    self.EmpID					:= IF(r.name_type	= 'L', r.EmpID,      0);
    self.EmpScore			  := IF(r.name_type	= 'L', r.EmpScore,   0);
    self.EmpWeight			:= IF(r.name_type	= 'L', r.EmpWeight,  0);
    self.POWID					:= IF(r.name_type	= 'L', r.POWID,      0);
    self.POWScore			  := IF(r.name_type	= 'L', r.POWScore,   0);
    self.POWWeight			:= IF(r.name_type	= 'L', r.POWWeight,  0);
    self.ProxID				  := IF(r.name_type	= 'L', r.ProxID,     0);
    self.ProxScore			:= IF(r.name_type	= 'L', r.ProxScore,  0);
    self.ProxWeight		  := IF(r.name_type	= 'L', r.ProxWeight, 0);
    self.SELEID				  := IF(r.name_type	= 'L', r.SELEID,     0);
    self.SELEScore			:= IF(r.name_type	= 'L', r.SELEScore,  0);
    self.SELEWeight		  := IF(r.name_type	= 'L', r.SELEWeight, 0);
    self.OrgID					:= IF(r.name_type	= 'L', r.OrgID,      0);
    self.OrgScore			  := IF(r.name_type	= 'L', r.OrgScore,   0);
    self.OrgWeight			:= IF(r.name_type	= 'L', r.OrgWeight,  0);
    self.UltID					:= IF(r.name_type	= 'L', r.UltID,      0);
    self.UltScore			  := IF(r.name_type	= 'L', r.UltScore,   0);
    self.UltWeight			:= IF(r.name_type	= 'L', r.UltWeight,  0);
    self := l;
  end;

  full_recs := join(distribute(with_seq,hash(fcc_seq)),
	                  distribute(all_rec,hash(fcc_seq)),
				            left.fcc_seq=right.fcc_seq,
										getIDs(left,right),local);

  pre_roll_sort := sort(full_recs,fcc_seq,local);
				
  fcc.Layout_FCC_base_bip_AID final_trans(fcc.Layout_FCC_base_bip_AID L, fcc.Layout_FCC_base_bip_AID R) := transform
    self.licensee_bdid  := if(l.licensee_bdid = 0, r.licensee_bdid,  l.licensee_bdid);
    self.dba_bdid       := if(l.dba_bdid      = 0, r.dba_bdid,       l.dba_bdid);
    self.firm_bdid      := if(l.firm_bdid     = 0, r.firm_bdid,      l.firm_bdid);
    self.attention_did  := if(l.attention_did = 0, r.attention_did,  l.attention_did);
    self.DotID				  := IF(l.DotID			    = 0, r.DotID,			     l.DotID);
    self.DotScore		    := IF(l.DotScore	    = 0, r.DotScore,	     l.DotScore);
    self.DotWeight		  := IF(l.DotWeight	    = 0, r.DotWeight,	     l.DotWeight);
    self.EmpID				  := IF(l.EmpID			    = 0, r.EmpID,			     l.EmpID);
    self.EmpScore		    := IF(l.EmpScore	    = 0, r.EmpScore,		   l.EmpScore);
    self.EmpWeight		  := IF(l.EmpWeight	    = 0, r.EmpWeight,	     l.EmpWeight);
    self.POWID				  := IF(l.POWID			    = 0, r.POWID,			     l.POWID);
    self.POWScore		    := IF(l.POWScore	    = 0, r.POWScore,		   l.POWScore);
    self.POWWeight		  := IF(l.POWWeight	    = 0, r.POWWeight,	     l.POWWeight);
    self.ProxID			    := IF(l.ProxID		    = 0, r.ProxID,			   l.ProxID);
    self.ProxScore		  := IF(l.ProxScore	    = 0, r.ProxScore,	     l.ProxScore);
    self.ProxWeight	    := IF(l.ProxWeight    = 0, r.ProxWeight,	   l.ProxWeight);
    self.SELEID			    := IF(l.SELEID		    = 0, r.SELEID,			   l.SELEID);
    self.SELEScore		  := IF(l.SELEScore	    = 0, r.SELEScore,	     l.SELEScore);
    self.SELEWeight	    := IF(l.SELEWeight    = 0, r.SELEWeight,	   l.SELEWeight);
    self.OrgID				  := IF(l.OrgID			    = 0, r.OrgID,			     l.OrgID);
    self.OrgScore		    := IF(l.OrgScore	    = 0, r.OrgScore,		   l.OrgScore);
    self.OrgWeight		  := IF(l.OrgWeight	    = 0, r.OrgWeight,	     l.OrgWeight);
    self.UltID				  := IF(l.UltID			    = 0, r.UltID,			     l.UltID);
    self.UltScore		    := IF(l.UltScore	    = 0, r.UltScore,		   l.UltScore);
    self.UltWeight		  := IF(l.UltWeight	    = 0, r.UltWeight,	     l.UltWeight);
    self                := l;
  end;
 
  final_update_ds := rollup(pre_roll_sort,fcc_seq,final_trans(left,right),local);
				
  //Add the source_rec_id
  UT.MAC_Append_Rcid(final_update_ds, source_rec_id, full_file_recid);
				
  PromoteSupers.MAC_SF_BuildProcess(full_file_recid,'~thor_data400::base::fcc',out_base,pCompress:=true);

  return sequential(out_base);

end;