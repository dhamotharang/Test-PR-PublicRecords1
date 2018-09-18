/*2015-10-26T18:54:10Z (Janielle Goolgar)
Govt AddrBest ranking implementation
*/
// This function finds latest 2 addressess after filtering out addresses that are in a detention center key and filtering out any 
// addressses that match input dedup addresses (up to 2).
// NOTE: these filters can remove more than 2 addressess since matches are on prim_name, prim_range and zip.
// Specific HRI for the addresses are looked up as well
				// An assumption is made that 1 address can only be 1 of these.
				
 import Address,BatchShare,doxie,ERO,Risk_Indicators, ut; 

 export fn_add2Addrs( dataset(ERO_Services.Layouts.LookupId) in_ids = dataset([],ERO_Services.Layouts.LookupId),
                              // unsigned1 inGLBPurpose =0,
															// unsigned1 inDPPAPurpose=0) :=
															doxie.IDataAccess modAccess) :=
		function
		   ids := record
			    ERO_Services.Layouts.LookupId;
					integer3 match1_seq_no;
					integer3 match2_seq_no;
					integer3 matchDC_seq_no;
			 end;
			 address_dc := record
			   string acctno;
				 boolean isDetentionCenter;
				 string60 hri_code;
		 	   doxie.Layout_Comp_Addresses; 
			 end;
			 hri_rec := record
		     integer3    address_seq_no;
		     string60     hri_code;
       end;
			 addr2dedup_rec := record
			    string acctno;
					unsigned6 did;
					string prim_range1;
					string prim_name1;
					string zip1;
					string prim_range2;
					string prim_name2;
					string zip2;
			 end;
			 
			 header2dedup_rec := record
			    string acctno;
					unsigned6 did;
					integer3 address_seq_no;
					boolean goodAddress;
					string prim_range1;
					string prim_name1;
					string zip1;
					unsigned dt_last_seen1;
					unsigned dt_last_seen2;
					boolean addr1match;
					boolean addr2match;
					boolean isDetentionCenter;
					integer3 match1_seq_no;
					integer3 match2_seq_no;
					integer3 matchDC_seq_no;
			 end;	
			 addr2dedup_rec fill2dedup(ERO_Services.Layouts.LookupId l) := transform
			   self.acctno := l.acctno;
				 self.did := l.did;
				 self.prim_range1 := l.dedupprim_range1;
				 self.prim_name1 := l.dedupprim_name1;
				 self.zip1 := l.dedupzip1;
				 self.prim_range2 := l.dedupprim_range2;
				 self.prim_name2 := l.dedupprim_name2;
				 self.zip2 := l.dedupzip2;
			 end;
			 addrs2dedup := project(in_ids, fill2dedup(left));
			 
		   //get list of unique DIDs then get all addresses from header
			 //sort by dt_last_seen so the first 2 are the latest 2 addresses.
			 //then use denormalize to join them back to original records with acctno and did.
		   dids_all := project(in_ids, doxie.layout_references);
			 dids := dedup(sort(dids_all, did),did);
			 //TODO: Why do we hardcode these values?
       mod_access_local := MODULE (PROJECT (modAccess, doxie.IDataAccess))
         EXPORT boolean ln_branded := FALSE;
         EXPORT boolean probation_override := TRUE;
         EXPORT boolean no_scrub := FALSE;
         EXPORT string5 industry_class := '';
       END;
		   //addresses_all := doxie.Comp_Subject_Addresses(dids,,inDPPAPurpose,inGLBPurpose,,,true,'',,).addresses;			 
		   addresses_all := doxie.Comp_Subject_Addresses(dids,,,,mod_access_local).addresses;			 
			 ranked_bestAddr := ERO_Services.fn_getRankedBestAddr(addresses_all);
			 
			 maxHriPer_value := 5;
			 doxie.mac_AddHRIAddress(ranked_bestAddr, address_all_hri);
			  // 2210,7011 hotel or motel
				// 2345,8211 Elementary or secondary school  
				// 2270,8221 College or university
				// 2350,8222 Junior college or technical institute  
				// 2225,9223 Correctional institution
			hri_rec makeChildren(address_all_hri L, Risk_Indicators.Layout_Desc R) := transform
					self.address_seq_no := l.address_seq_no;
					hri_code := if (r.hri in  ERO_Services.Constants.Defaults.HRISET, r.hri, '');
					hri_output := map(hri_code = ERO_Services.Constants.Defaults.HRIHOTELS => 'HOTELS AND MOTELS',
														hri_code = ERO_Services.Constants.Defaults.HRIELEMENTARY => 'ELEMENTARY AND SECONDARY SCHOOLS',
														hri_code = ERO_Services.Constants.Defaults.HRICOLLEGE => 'COLLEGES, UNIVERSITIES, AND PROFESSIONAL SCHOOLS',
														hri_code = ERO_Services.Constants.Defaults.HRIJUNIOR => 'JUNIOR COLLEGES AND TECHNICAL INSTITUTES',
														hri_code = ERO_Services.Constants.Defaults.HRICORRECTIONAL => 'CORRECTIONAL INSTITUTIONS',
														'');
					self.hri_code := hri_output;
			end;
			hriRecs := NORMALIZE(address_all_hri,left.hri_address, makeChildren(left, right));
			hriRecsDeduped := dedup(sort(hriRecs(hri_code <>''), address_seq_no, hri_code), address_seq_no);
			//HRI code set for each address
			address_dc fillHriCode(address_all_hri l,hriRecsDeduped r) := transform
				  self.hri_code := r.hri_code;
					self.isDetentionCenter := false;//set below
					self.acctno := '';//set below
				  self := l;
			end;
      address_hri := join(address_all_hri, hriRecsDeduped, left.address_seq_no = right.address_seq_no, fillHriCode(left,right),keep(1),left outer);
	  		 
			 //Detention Center flag set for each address 
			 address_dc fillDCMatch(address_hri l, ERO.Key_address dc) := transform
			    self.isDetentionCenter := trim(dc.zip + dc.prim_range + dc.prim_name,all) <> ''; 
			    self := l;
			 end;
			 addresses := join(address_hri,ERO.Key_address, keyed(left.prim_range = right.prim_range and
																					  										 left.prim_name = right.prim_name and
																																 left.zip = right.zip 
			                                                            ), fillDCMatch(left,right), left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT), keep(1));
       //included code to make po box addresses match but only those can have missing prim_range values.
			 header2dedup_rec fillHeader(addr2dedup_rec l,addresses r):= transform
			    bothPOBOX1 := l.prim_name1[1..6] = 'PO BOX' and r.prim_name[1..6] = 'PO BOX';
			    bothPOBOX2 := l.prim_name2[1..6] = 'PO BOX' and r.prim_name[1..6] = 'PO BOX';
			    addr1matched := (bothPOBOX1 or ut.NBEQ(l.prim_range1,r.prim_range)) and ut.NBEQ(l.prim_name1,r.prim_name) and ut.NBEQ(l.zip1,r.zip);  
					addr2matched := (bothPOBOX2 or ut.NBEQ(l.prim_range2,r.prim_range)) and ut.NBEQ(l.prim_name2,r.prim_name) and ut.NBEQ(l.zip2,r.zip);
					dcmatched := r.isDetentionCenter;
			    self.acctno := l.acctno;
					self.did := l.did;
					self.address_seq_no := r.address_seq_no;
					self.prim_range1 := r.prim_range;
					self.prim_name1 := r.prim_name;
					self.zip1 := r.zip;
					self.dt_last_seen1 := if (addr1matched ,r.dt_last_seen,0);
					self.dt_last_seen2 := if (addr2matched ,r.dt_last_seen,0);
					self.addr1match := addr1matched;
					self.addr2match := addr2matched;
					self.isDetentionCenter := r.isDetentionCenter;
					self.goodAddress := ~(addr1Matched or addr2matched or dcmatched);//If its not a dedup address or detention center its good to use.
					self.match1_seq_no := if (addr1Matched,r.address_seq_no,0);
					self.match2_seq_no := if (addr2Matched,r.address_seq_no,0);
					self.matchDC_seq_no := if (dcMatched,r.address_seq_no,0);
			 end;
			 matchedAddrsAll := join(addrs2dedup,addresses, left.did = right.did, fillHeader(left, right), left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
		

			 header2dedup_rec rollupAddrs(header2dedup_rec l, header2dedup_rec r) := transform
			    self.dt_last_seen1 := MAX (l.dt_last_seen1, r.dt_last_seen1);
					self.dt_last_seen2 := MAX (l.dt_last_seen2, r.dt_last_seen2);
					self.addr1match := if (l.addr1match,l.addr1match,r.addr1match);
					self.addr2match := if (l.addr2match,l.addr2match,r.addr2match);
					self.isDetentionCenter := if (l.isDetentionCenter,l.isDetentionCenter,r.isDetentionCenter); 
					self.match1_seq_no := ut.min2(l.match1_seq_no,r.match1_seq_no);
					self.match2_seq_no := ut.min2(l.match2_seq_no,r.match2_seq_no);
					self.matchDC_seq_no := ut.min2(l.matchDC_seq_no,r.matchDC_seq_no);
					self := l;
			 end;
       matchedAddrs := rollup(matchedAddrsALL, left.acctno = right.acctno, rollupAddrs(left,right));
			 ids fillMatched(in_ids l, header2dedup_rec r) := transform
			    self.addr_Detention_Center_Match := if (r.isDetentionCenter,'Y','');
					self.addr_Dedupe_Addr_1_Match := if (r.addr1match,'Y','');
					self.addr_Dedupe_Addr_1_Most_Recent_Rptd_Date := if (r.dt_last_seen1 > 0, (string)r.dt_last_seen1,'');//ut.ConvertDate((string)r.dt_last_seen1,'%Y%m%d','%m/%d/%Y'); //YYYYMMDD t0 subject dob mm/dd/yyyy
					self.addr_Dedupe_Addr_2_Match := if (r.addr2match,'Y','');
					self.addr_Dedupe_Addr_2_Most_Recent_Rptd_Date := if (r.dt_last_seen2 > 0,(string)r.dt_last_seen2,'');//ut.ConvertDate((string)r.dt_last_seen2,'%Y%m%d','%m/%d/%Y'); //YYYYMMDD t0 subject dob mm/dd/yyyy
          self.match1_seq_no := r.match1_seq_no;
					self.match2_seq_no := r.match2_seq_no;
					self.matchDC_seq_no := r.matchDC_seq_no; 					
					self := l;
			 end;
		   matchFlags := join(in_ids, matchedAddrs, left.acctno=right.acctno, fillMatched(left, right), left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
			 
			 //create list of acctno, did, addresses
		
			 address_dc  loadAddress(header2dedup_rec l, address_dc r) := transform
			    self.acctno := l.acctno;
					self.isDetentionCenter := r.isDetentionCenter;  //this field is not used
					self.hri_code := r.hri_code;
			    self := r;
			 end;
			 goodAddrs := join(matchedAddrsALL(goodAddress), addresses, left.did = right.did and left.address_seq_no = right.address_seq_no, 
			                   loadAddress(left, right), left outer);

			 BatchShare.Layouts.ShareAddress formatAddress(address_dc ca) := transform
			   self.addr := '';//fulladdress
				 self.prim_range 		:= ca.prim_range;
		     self.predir     		:= ca.predir;
		     self.prim_name  		:= ca.prim_name;
			   self.addr_suffix 	:= ca.suffix;
			   self.postdir     	:= ca.postdir;
			   self.unit_desig  	:= ca.unit_desig;
			   self.sec_range  	 	:= ca.sec_range;
			   self.p_city_name		:= ca.city_name;
			   self.st          	:= ca.st;
			   self.z5      		  := ca.zip;
		     self.zip4        	:= ca.zip4;
			   self.county_name   := ca.county_name;
			 end;
       
			 ERO_Services.Layouts.LookupId denormAddrs(ids l, dataset(address_dc) addrs) := transform
			 	//parsed streets are needed as well as normal output with is not parsed street.
				bothPOBOX1 := l.input_addr.prim_name[1..6] = 'PO BOX' and addrs[1].prim_name[1..6] = 'PO BOX';
			  bothPOBOX2 := l.input_addr.prim_name[1..6] = 'PO BOX' and addrs[2].prim_name[1..6] = 'PO BOX';
				addr2_seq_no := if (addrs[2].address_seq_no > 0,addrs[2].address_seq_no ,if (addrs[1].address_seq_no > 0,addrs[1].address_seq_no,999999));
				streetMatch1 := if ((bothPOBOX1 or ut.NBEQ(l.input_addr.prim_range,addrs[1].prim_range)) and ut.NBEQ(l.input_addr.prim_name,addrs[1].prim_name), 'A',''); 
	      cityMatch1 := if (ut.NBEQ(l.input_raw_City,addrs[1].city_name) ,'C','');
	      stateMatch1 := if (ut.NBEQ(l.input_raw_st,addrs[1].st) ,'T','');
	      zipMatch1 := if(ut.NBEQ(l.input_raw_zip,addrs[1].zip),'Z','');
				streetMatch2 := if ((bothPOBOX2 or ut.NBEQ(l.input_addr.prim_range,addrs[2].prim_range)) and ut.NBEQ(l.input_addr.prim_name,addrs[2].prim_name), 'A',''); 
	      cityMatch2 := if (ut.NBEQ(l.input_raw_City,addrs[2].city_name) ,'C','');
	      stateMatch2 := if (ut.NBEQ(l.input_raw_st,addrs[2].st) ,'T','');
	      zipMatch2 := if(ut.NBEQ(l.input_raw_zip,addrs[2].zip),'Z','');

			  self.addr1 := project(addrs[1], formatAddress(left));
			  self.addr2 := project(addrs[2], formatAddress(left));
				self.addr_Detention_Center_Match := if (l.matchDC_seq_no < addr2_seq_no, l.addr_Detention_Center_Match,'');
				self.addr_Dedupe_Addr_1_Match := if (l.match1_seq_no < addr2_seq_no, l.addr_Dedupe_Addr_1_Match,'');
				self.addr_Dedupe_Addr_1_Most_Recent_Rptd_Date := if (l.match1_seq_no < addr2_seq_no,ut.ConvertDate(l.addr_Dedupe_Addr_1_Most_Recent_Rptd_Date,'%Y%m','%m/%d/%Y'),'');
				self.addr_Dedupe_Addr_2_Match := if (l.match2_seq_no < addr2_seq_no,l.addr_Dedupe_Addr_2_Match,'');
				self.addr_Dedupe_Addr_2_Most_Recent_Rptd_Date := if (l.match2_seq_no < addr2_seq_no,ut.ConvertDate(l.addr_Dedupe_Addr_2_Most_Recent_Rptd_Date,'%Y%m','%m/%d/%Y'),'');
        self.subject_ADDR1_MATCH := streetMatch1+cityMatch1+stateMatch1+zipMatch1;
				self.addr_Address_1 := Address.Addr1FromComponents(addrs[1].prim_range,addrs[1].predir,addrs[1].prim_name,addrs[1].suffix,addrs[1].postdir,addrs[1].unit_desig,addrs[1].sec_range); 
				self.addr_City_1 :=addrs[1].city_name;
				self.addr_State_1 :=addrs[1].st;
				self.addr_Zip_1 :=addrs[1].zip;
				self.addr_County_1 :=addrs[1].county_name;
				self.addr_Phone_1 :=addrs[1].phone ;
			  self.addr_Last_Date_Reported_1 := ERO_services.functions.fixdate(addrs[1].dt_last_seen);
				self.addr_First_Date_Reported_1 := ERO_services.functions.fixdate(addrs[1].dt_first_seen);
				self.addr_Delivery_Type_Indicator_1 :='' ;
				self.addr_POBox_Indicator_1 :='';
				self.addr_HRI_1 := addrs[1].hri_code ;
	      self.subject_ADDR2_MATCH := streetMatch2+cityMatch2+stateMatch2+zipMatch2;
				self.addr_Address_2 := Address.Addr1FromComponents(addrs[2].prim_range,addrs[2].predir,addrs[2].prim_name,addrs[2].suffix,addrs[2].postdir,addrs[2].unit_desig,addrs[2].sec_range); 
				self.addr_City_2 := addrs[2].city_name;
				self.addr_State_2 :=addrs[2].st;
				self.addr_Zip_2 :=addrs[2].zip;
				self.addr_County_2 :=addrs[2].county_name;
				self.addr_Phone_2 :=addrs[2].phone;
				self.addr_Last_Date_Reported_2 := ERO_services.functions.fixdate(addrs[2].dt_last_seen);
				self.addr_First_Date_Reported_2 := ERO_services.functions.fixdate(addrs[2].dt_first_seen);
				self.addr_Delivery_Type_Indicator_2 :='';
				self.addr_POBox_Indicator_2 :='';
				self.addr_HRI_2 := addrs[2].hri_code ;
				self := l;
			 end;
	     ids_addrs_recs := DENORMALIZE(matchFlags, goodAddrs, left.acctno = right.acctno and left.did = right.did, GROUP, denormAddrs(left,ROWS(right)));
	     
			 return ids_addrs_recs;			 
	  end;
