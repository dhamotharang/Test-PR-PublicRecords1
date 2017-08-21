import ut,dma,doxie,address;

export fn_suppress_dnm := module

	shared search_ln		:= LN_PropertyV2.file_search_building(ln_fares_id[1] != 'R') ; 
			
	export deed(dataset(recordof(ln_propertyv2.layout_clickdata.l_tmp_d)) in_deed) := function

	//Supress Do not call 

	deed_datep := in_deed(phone_number <>''); 
	deed_nophone := in_deed(phone_number =''); 

	deed_datep  doJoind(deed_datep l, dma.file_suppressionTPS.Building r) := TRANSFORM

	self.phone_number := if(L.phone_number = R.phonenumber , '',L.phone_number); 
	SELF := l;

	END;

	d_dsupp_phone:=JOIN(distribute(deed_datep,hash(phone_number)), distribute(dma.file_suppressionTPS.Building,hash(phonenumber)),LEFT.phone_number = RIGHT.phonenumber,
						 doJoind(LEFT,right),LEFT outer,local) ; 

	deed_w_supp := deed_nophone + d_dsupp_phone  ; 

	ln_propertyv2.layout_clickdata.add_cleandeed_rec populate_clean_addressd(deed_w_supp l, search_ln r) := transform
			self.prim_range := r.prim_range;
			self.predir := r.predir;
			self.prim_name:= r.prim_name;
			self.suffix:= r.suffix;
			self.postdir:= r.postdir;
			self.unit_desig:= r.unit_desig;
			self.sec_range:= r.sec_range;
			self.p_city_name:= r.p_city_name;
			self.v_city_name:= r.v_city_name;
			self.st:= r.st;
			self.zip:= r.zip;
			self.zip4:= r.zip4;
			self.cart:= r.cart;
			self.cr_sort_sz:= r.cr_sort_sz;
			self.lot:= r.lot;
			self.lot_order:= r.lot_order;
			self.dbpc:= r.dbpc;
			self.chk_digit:= r.chk_digit;
			self.rec_type := r.rec_type;
			self.county := r.county;
			self.geo_lat := r.geo_lat;
			self.geo_long := r.geo_long;
			self.msa := r.msa;
			self.geo_blk := r.geo_blk;
			self.geo_match := r.geo_match;
			self.err_stat := r.err_stat;
			self.source_code := r.source_code ;
			self.source_code_order := if(r.source_code[2] = 'P', '1', '2'); 
			self.fname := r.fname ; 
			self.lname := r.lname ; 
					self.click_hhid := ut.fn_create_click_id(trim(r.prim_range,left,right)+' '+trim(r.predir,left,right)+' '+trim(r.prim_name,left,right)+' '+trim(r.suffix,left,right)+' '+trim(r.postdir,left,right)+' '+trim(r.unit_desig,left,right)+' '+trim(r.sec_range,left,right),r.zip,'','','','');
				 
			 self := l;
		end;
					
		deed_wcaddr := join(distribute(deed_w_supp,hash(ln_fares_id)),distribute(search_ln(ln_fares_id[2]!= 'A'),hash(ln_fares_id)),
												 left.ln_fares_id = right.ln_fares_id,
												 populate_clean_addressd(left,right),
												 left outer , local);
												 
		deed_wcaddrf:= deed_wcaddr(~(source_code[2] = 'P' and prop_addr_propagated_ind ='P' and err_stat[1] != 'S')); // these should be fixed in search file 
		 
	// Supress do not mail 

	file_supp := distribute(dma.file_suppressionMPS,hash(prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname)); 
	file_supps := sort(file_supp,prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname,local);  
	file_suppd := dedup(file_supps,prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname,local) ;
											 
	deed_wcaddr  doJoin1(deed_wcaddrf l, file_suppd r) := TRANSFORM

	boolean is_true :=  if(L.prim_name = ut.StripOrdinal(r.prim_name) AND
							l.prim_range = TRIM(ut.CleanPrimRange(r.prim_range),LEFT) AND 
					 L.st = R.st AND
									 doxie.Make_CityCode(L.p_city_name) =  doxie.Make_CityCode(r.p_city_name) AND
							 L.zip = R.zip AND 
							 L.sec_range = R.sec_range AND 
							 L.lname = R.lname AND
							 L.fname = R.fname ,true,false); 

	self.mailing_street := if(is_true and l.source_code[2] ='O' , '',l.mailing_street); 
	self.mailing_unit_number       := if( is_true and  l.source_code[2] ='O' , '',l.mailing_unit_number); 
	self.mailing_csz    := if( is_true and  l.source_code[2] ='O' , '',l.mailing_csz); 
	self.property_full_street_address  := if( is_true and  l.source_code[2] ='P' , '',l.property_full_street_address); 
	self.property_address_unit_number   := if( is_true and  l.source_code[2] ='P' , '',l.property_address_unit_number); 
	self.property_address_citystatezip  := if(is_true and  l.source_code[2] ='P' , '',l.property_address_citystatezip);  

	self.seller_mailing_full_street_address := if( is_true and  l.source_code[2] ='S' , '',l.seller_mailing_full_street_address); 
	self.seller_mailing_address_unit_number := if( is_true and  l.source_code[2] ='S' , '',l.seller_mailing_address_unit_number); 
	self.seller_mailing_address_citystatezip := if( is_true and  l.source_code[2] ='S' , '',l.seller_mailing_address_citystatezip); 

	self.prim_range := if( is_true and  l.source_code[2] ='P' , '',l.prim_range);
	self.predir    := if( is_true and  l.source_code[2] ='P' , '', l.predir);
	self.prim_name  := if( is_true and  l.source_code[2] ='P' , '', l.prim_name);
	self.suffix    := if( is_true and  l.source_code[2] ='P' , '', l.suffix);
	self.postdir   := if( is_true and  l.source_code[2] ='P' , '',l.postdir);
	self.unit_desig  := if( is_true and  l.source_code[2] ='P' , '',l.unit_desig);
	self.sec_range  := if( is_true and  l.source_code[2] ='P' , '',l.sec_range);
	self.p_city_name  := if( is_true and  l.source_code[2] ='P' , '',l.p_city_name);
	self.v_city_name  := if( is_true and  l.source_code[2] ='P' , '',l.v_city_name);
	self.st  := if( is_true and  l.source_code[2] ='P' , '',l.st);
	self.zip  := if( is_true and  l.source_code[2] ='P' , '',l.zip);
	self.zip4  := if( is_true and  l.source_code[2] ='P' , '',l.zip4);
	self.cart  := if( is_true and  l.source_code[2] ='P' , '',l.cart);
	self.cr_sort_sz  := if( is_true and  l.source_code[2] ='P' , '',l.cr_sort_sz);
	self.lot   := if( is_true and  l.source_code[2] ='P' , '', l.lot);
	self.lot_order   := if( is_true and  l.source_code[2] ='P' , '',l.lot_order);
	self.dbpc   := if( is_true and  l.source_code[2] ='P' , '',l.dbpc);
	self.chk_digit  := if( is_true and  l.source_code[2] ='P' , '',l.chk_digit);
	self.rec_type  := if( is_true and  l.source_code[2] ='P' , '',l.rec_type);
	self.county   := if( is_true and  l.source_code[2] ='P' , '',l.county);
	self.geo_lat   := if( is_true and  l.source_code[2] ='P' , '',l.geo_lat);
	self.geo_long   := if( is_true and  l.source_code[2] ='P' , '', l.geo_long);
	self.msa         := if( is_true and  l.source_code[2] ='P' , '', l.msa);
	self.geo_blk    := if( is_true and  l.source_code[2] ='P' , '', l.geo_blk);
	self.geo_match   := if( is_true and  l.source_code[2] ='P' , '',l.geo_match );
	self.err_stat  := if( is_true and  l.source_code[2] ='P' , '',l.err_stat); 
			

	sELF := l;
	END;

	deed_supp_addr := JOIN(distribute(deed_wcaddrf,hash(prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname)) ,file_suppd, 
												 LEFT.prim_name = ut.StripOrdinal(right.prim_name) AND
							 LEFT.prim_range =TRIM(ut.CleanPrimRange(right.prim_range),LEFT)  AND 
							 LEFT.st = RIGHT.st AND
							 doxie.Make_CityCode(LEFT.p_city_name) = doxie.Make_CityCode(right.p_city_name) AND  
							 LEFT.zip = RIGHT.zip AND 
							 LEFT.sec_range = RIGHT.sec_range AND 
							 LEFT.lname = RIGHT.lname AND
							 LEFT.fname = RIGHT.fname,
							 doJoin1(LEFT,right),left outer,local) ;

	// roll records to leave one property address records after dnm,dnc suppression 

	deed_supp_addr_dist := distribute(deed_supp_addr, hash(ln_fares_id)); 
	deed_property := sort(deed_supp_addr_dist, ln_fares_id,source_code_order,local); 

	deed_property trans(deed_property l,deed_property r) := transform

	boolean is_true_p := if(trim(l.prim_name,all)+trim(l.prim_range,all)+trim(l.sec_range,all)+trim(l.zip,all) ='' or trim(r.prim_name,all)+trim(r.prim_range,all)+trim(r.sec_range,all)+trim(r.zip,all) ='' , true,false);  

	self.mailing_street :=  if( trim(l.mailing_street,all)+trim(l.mailing_unit_number,all)+trim(l.mailing_csz,all) ='' or trim(r.mailing_street,all)+trim(r.mailing_unit_number,all)+trim(r.mailing_csz,all) ='','', l.mailing_street); 
	self.mailing_unit_number := if( trim(l.mailing_street,all)+trim(l.mailing_unit_number,all)+trim(l.mailing_csz,all) ='' or trim(r.mailing_street,all)+trim(r.mailing_unit_number,all)+trim(r.mailing_csz,all) ='','', l.mailing_unit_number); 
	self.mailing_csz    := if( trim(l.mailing_street,all)+trim(l.mailing_unit_number,all)+trim(l.mailing_csz,all) ='' or trim(r.mailing_street,all)+trim(r.mailing_unit_number,all)+trim(r.mailing_csz,all) ='','', l.mailing_csz); 


	self.property_full_street_address  := if( trim(l.property_full_street_address,all)+trim(l.property_address_unit_number,all)+trim(l.property_address_citystatezip,all) =''  or trim(r.property_full_street_address,all)+trim(r.property_address_unit_number,all)+trim(r.property_address_citystatezip,all) ='','', l.property_full_street_address); 
	self.property_address_unit_number   := if( trim(l.property_full_street_address,all)+trim(l.property_address_unit_number,all)+trim(l.property_address_citystatezip,all) ='' or trim(r.property_full_street_address,all)+trim(r.property_address_unit_number,all)+trim(r.property_address_citystatezip,all) ='','', l.property_address_unit_number); 
	self.property_address_citystatezip  := if( trim(l.property_full_street_address,all)+trim(l.property_address_unit_number,all)+trim(l.property_address_citystatezip,all) ='' or trim(r.property_full_street_address,all)+trim(r.property_address_unit_number,all)+trim(r.property_address_citystatezip,all) ='','',l.property_address_citystatezip); 


	self.seller_mailing_full_street_address :=if( trim(l.seller_mailing_full_street_address,all)+trim(l.seller_mailing_address_unit_number,all)+trim(l.seller_mailing_address_citystatezip,all) =''or trim(r.seller_mailing_full_street_address,all)+trim(r.seller_mailing_address_unit_number,all)+trim(r.seller_mailing_address_citystatezip,all) ='', '' , l.seller_mailing_full_street_address); 
	self.seller_mailing_address_unit_number := if( trim(l.seller_mailing_full_street_address,all)+trim(l.seller_mailing_address_unit_number,all)+trim(l.seller_mailing_address_citystatezip,all) ='' or trim(r.seller_mailing_full_street_address,all)+trim(r.seller_mailing_address_unit_number,all)+trim(r.seller_mailing_address_citystatezip,all) ='', '' , l.seller_mailing_address_unit_number);
	self.seller_mailing_address_citystatezip := if( trim(l.seller_mailing_full_street_address,all)+trim(l.seller_mailing_address_unit_number,all)+trim(l.seller_mailing_address_citystatezip,all) ='' or trim(r.seller_mailing_full_street_address,all)+trim(r.seller_mailing_address_unit_number,all)+trim(r.seller_mailing_address_citystatezip,all) ='', '' , l.seller_mailing_address_citystatezip);

	self.prim_range := if(( l.source_code[2] ='P'and r.source_code[2]='P') and is_true_p, '',l.prim_range);
	self.predir    := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p , '', l.predir);
	self.prim_name  := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '', l.prim_name);
	self.suffix    := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '', l.suffix);
	self.postdir   := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '',l.postdir);
	self.unit_desig  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.unit_desig);
	self.sec_range  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p, '',l.sec_range);
	self.p_city_name  := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '',l.p_city_name);
	self.v_city_name  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.v_city_name);
	self.st  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.st);
	self.zip  := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p, '',l.zip);
	self.zip4  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.zip4);
	self.cart  := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p, '',l.cart);
	self.cr_sort_sz  := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '',l.cr_sort_sz);
	self.lot   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '', l.lot);
	self.lot_order   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.lot_order);
	self.dbpc   := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p , '',l.dbpc);
	self.chk_digit  := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p , '',l.chk_digit);
	self.rec_type  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.rec_type);
	self.county   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.county);
	self.geo_lat   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.geo_lat);
	self.geo_long   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '', l.geo_long);
	self.msa         := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p , '', l.msa);
	self.geo_blk    := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '', l.geo_blk);
	self.geo_match   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.geo_match );
	self.err_stat  := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '',l.err_stat); 

	self := l;
	end;

	deed_supp := rollup(deed_property,trans(left,right),ln_fares_id,local) ;
	deed_supp0 := deed_supp(~(source_code[2] != 'P'  and property_full_street_address <>'' and property_address_citystatezip <>'' and prop_addr_propagated_ind ='P')); 
	deed_suppc:= deed_supp(source_code[2] != 'P'  and property_full_street_address <>'' and property_address_citystatezip <>'' and prop_addr_propagated_ind ='P'); 

	// there are small % propagated records after cleaning there error_st[1]!= 'S' - count 1050 as of 20080828

	deed_suppc t_clean(deed_suppc le) := transform
	 
	 string182 v_clean_addr := address.cleanaddress182(le.property_full_street_address,le.property_address_citystatezip);
	 
	 self.prim_range  := v_clean_addr[ 1..  10];
	 self.predir      := v_clean_addr[ 11.. 12];
	 self.prim_name   := v_clean_addr[ 13.. 40];
	 self.suffix      := v_clean_addr[ 41.. 44];
	 self.postdir     := v_clean_addr[ 45.. 46];
	 self.unit_desig  := v_clean_addr[ 47.. 56];
	 self.sec_range   := v_clean_addr[ 57.. 64];
	 self.p_city_name := v_clean_addr[ 65.. 89];
	 self.v_city_name := v_clean_addr[ 90..114];
	 self.st          := v_clean_addr[115..116];
	 self.zip         := v_clean_addr[117..121];
	 self.zip4        := v_clean_addr[122..125];
	 self.cart        := v_clean_addr[126..129];
	 self.cr_sort_sz  := v_clean_addr[130..130];
	 self.lot         := v_clean_addr[131..134];
	 self.lot_order   := v_clean_addr[135..135];
	 self.dbpc        := v_clean_addr[136..137];
	 self.chk_digit   := v_clean_addr[138..138];
	 self.rec_type    := v_clean_addr[139..140];
	 self.county      := v_clean_addr[141..145];
	 self.geo_lat     := v_clean_addr[146..155];
	 self.geo_long    := v_clean_addr[156..166];
	 self.msa         := v_clean_addr[167..170];
	 self.geo_blk     := v_clean_addr[171..177];
	 self.geo_match   := v_clean_addr[178..178];
	 self.err_stat    := v_clean_addr[179..182];
	 self.source_code := le.source_code[1]+'P';
	 self.source_code_order := '1'; 

	 self             := le;
	end;

	deed_supp_clean := project(nofold(deed_suppc),t_clean(left));

	deed_suppc t_clean1(deed_supp_clean l) := transform
	 
	 self.click_hhid := ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,'','','','');

	 self             := l;
	end;

	deed_supp_clean1 := project(nofold(deed_supp_clean),t_clean1(left));

	deed_supp_out0:= nofold(deed_supp_clean1 + deed_supp0) ;

	// map to deed to final layout 

	layout_clickdata.deed reformat(deed_supp_out0 l ) := transform 

	self := l ; 

	end; 

	deed_out := project(deed_supp_out0, reformat(left)) ;

	return  deed_out; 

	end; 

	export assess(dataset(recordof(layout_clickdata.l_tmp))asse_date) := function

	//Supress Do not call 
	asse_datep := asse_date(assessee_phone_number <>''); 
	asse_nophone := asse_date(assessee_phone_number =''); 

	asse_datep  doJoina(asse_datep l, dma.file_suppressionTPS.Building r) := TRANSFORM

	self.assessee_phone_number := if(L.assessee_phone_number = R.phonenumber , '',L.assessee_phone_number); 
	SELF := l;

	END;

	d_asupp_phone:=JOIN(distribute(asse_datep,hash(assessee_phone_number)), distribute(dma.file_suppressionTPS.Building,hash(phonenumber)),LEFT.assessee_phone_number = RIGHT.phonenumber,
						 doJoina(LEFT,right),LEFT outer,local) ; 

	asse_w_supp := asse_nophone + d_asupp_phone  ;

		ln_propertyv2.layout_clickdata.add_cleanasses_rec populate_clean_address(d_asupp_phone l, search_ln r) := transform
			self.prim_range := r.prim_range;
			self.predir := r.predir;
			self.prim_name:= r.prim_name;
			self.suffix:= r.suffix;
			self.postdir:= r.postdir;
			self.unit_desig:= r.unit_desig;
			self.sec_range:= r.sec_range;
			self.p_city_name:= r.p_city_name;
			self.v_city_name:= r.v_city_name;
			self.st:= r.st;
			self.zip:= r.zip;
			self.zip4:= r.zip4;
			self.cart:= r.cart;
			self.cr_sort_sz:= r.cr_sort_sz;
			self.lot:= r.lot;
			self.lot_order:= r.lot_order;
			self.dbpc:= r.dbpc;
			self.chk_digit:= r.chk_digit;
			self.rec_type := r.rec_type;
			self.county := r.county;
			self.geo_lat := r.geo_lat;
			self.geo_long := r.geo_long;
			self.msa := r.msa;
			self.geo_blk := r.geo_blk;
			self.geo_match := r.geo_match;
			self.err_stat := r.err_stat;
			self.source_code := r.source_code ;
			self.source_code_order := if(r.source_code[2] = 'P', '1', '2'); 
			self.fname := r.fname ; 
			self.lname := r.lname ; 
					self.click_hhid := ut.fn_create_click_id(trim(r.prim_range,left,right)+' '+trim(r.predir,left,right)+' '+trim(r.prim_name,left,right)+' '+trim(r.suffix,left,right)+' '+trim(r.postdir,left,right)+' '+trim(r.unit_desig,left,right)+' '+trim(r.sec_range,left,right),r.zip,'','','','');
					self := l;
		end;
					
		asses_wcaddr := join(distribute(asse_w_supp,hash(ln_fares_id)),distribute(search_ln(ln_fares_id[2]='A'), hash(ln_fares_id)),
												 left.ln_fares_id = right.ln_fares_id,
												 populate_clean_address(left,right),
												 left outer , local);



	asses_wcaddrf:= asses_wcaddr(~(source_code[2] = 'P' and prop_addr_propagated_ind ='P' and err_stat[1] != 'S')); 


	// Supress do not mail 

	file_supp := distribute(dma.file_suppressionMPS,hash(prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname)); 
	file_supps := sort(file_supp,prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname,local);  
	file_suppd := dedup(file_supps,prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname,local) ;

	asses_wcaddr  doJoin1(asses_wcaddrf l, file_suppd r) := TRANSFORM

	boolean is_true :=  if(L.prim_name = ut.StripOrdinal(r.prim_name) AND
							l.prim_range = TRIM(ut.CleanPrimRange(r.prim_range),LEFT) AND 
							 L.st = R.st AND
							 doxie.Make_CityCode(L.p_city_name) =  doxie.Make_CityCode(r.p_city_name) AND
							 L.zip = R.zip AND 
							 L.sec_range = R.sec_range AND 
							 L.lname = R.lname AND
							 L.fname = R.fname ,true,false); 

	self.mailing_full_street_address := if(is_true and l.source_code[2] ='O' , '',l.mailing_full_street_address); 
	self.mailing_unit_number       := if( is_true and  l.source_code[2] ='O' , '',l.mailing_unit_number); 
	self.mailing_city_state_zip    := if( is_true and  l.source_code[2] ='O' , '',l.mailing_city_state_zip); 

	self.property_full_street_address  := if( is_true and  l.source_code[2] ='P' , '',l.property_full_street_address); 
	self.property_unit_number   := if( is_true and  l.source_code[2] ='P' , '',l.property_unit_number); 
	self.property_city_state_zip  := if(is_true and  l.source_code[2] ='P' , '',l.property_city_state_zip);  

	self.prim_range := if( is_true and  l.source_code[2] ='P' , '',l.prim_range);
	self.predir    := if( is_true and  l.source_code[2] ='P' , '', l.predir);
	self.prim_name  := if( is_true and  l.source_code[2] ='P' , '', l.prim_name);
	self.suffix    := if( is_true and  l.source_code[2] ='P' , '', l.suffix);
	self.postdir   := if( is_true and  l.source_code[2] ='P' , '',l.postdir);
	self.unit_desig  := if( is_true and  l.source_code[2] ='P' , '',l.unit_desig);
	self.sec_range  := if( is_true and  l.source_code[2] ='P' , '',l.sec_range);
	self.p_city_name  := if( is_true and  l.source_code[2] ='P' , '',l.p_city_name);
	self.v_city_name  := if( is_true and  l.source_code[2] ='P' , '',l.v_city_name);
	self.st  := if( is_true and  l.source_code[2] ='P' , '',l.st);
	self.zip  := if( is_true and  l.source_code[2] ='P' , '',l.zip);
	self.zip4  := if( is_true and  l.source_code[2] ='P' , '',l.zip4);
	self.cart  := if( is_true and  l.source_code[2] ='P' , '',l.cart);
	self.cr_sort_sz  := if( is_true and  l.source_code[2] ='P' , '',l.cr_sort_sz);
	self.lot   := if( is_true and  l.source_code[2] ='P' , '', l.lot);
	self.lot_order   := if( is_true and  l.source_code[2] ='P' , '',l.lot_order);
	self.dbpc   := if( is_true and  l.source_code[2] ='P' , '',l.dbpc);
	self.chk_digit  := if( is_true and  l.source_code[2] ='P' , '',l.chk_digit);
	self.rec_type  := if( is_true and  l.source_code[2] ='P' , '',l.rec_type);
	self.county   := if( is_true and  l.source_code[2] ='P' , '',l.county);
	self.geo_lat   := if( is_true and  l.source_code[2] ='P' , '',l.geo_lat);
	self.geo_long   := if( is_true and  l.source_code[2] ='P' , '', l.geo_long);
	self.msa         := if( is_true and  l.source_code[2] ='P' , '', l.msa);
	self.geo_blk    := if( is_true and  l.source_code[2] ='P' , '', l.geo_blk);
	self.geo_match   := if( is_true and  l.source_code[2] ='P' , '',l.geo_match );
	self.err_stat  := if( is_true and  l.source_code[2] ='P' , '',l.err_stat); 

	sELF := l;
	END;

	d_supp_addr := JOIN(distribute(asses_wcaddrf,hash(ln_fares_id,prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname)), file_suppd, 
												 LEFT.prim_name = ut.StripOrdinal(right.prim_name) AND
							 LEFT.prim_range =TRIM(ut.CleanPrimRange(right.prim_range),LEFT)  AND 
							 LEFT.st = RIGHT.st AND
							 doxie.Make_CityCode(LEFT.p_city_name) = doxie.Make_CityCode(right.p_city_name) AND  
							 LEFT.zip = RIGHT.zip AND 
							 LEFT.sec_range = RIGHT.sec_range AND 
							 LEFT.lname = RIGHT.lname AND
							 LEFT.fname = RIGHT.fname,
							 doJoin1(LEFT,right),LEFT outer,local) ; 
							 
					 
	asse_supp_addr_dist := distribute(d_supp_addr, hash(ln_fares_id)); 
	asse_property := sort(asse_supp_addr_dist, ln_fares_id,source_code_order,local); 

	// roll up to get one record with property address and with dnm suppress info 
	asse_property trans(asse_property l,asse_property r) := transform

	boolean is_true_p := if(trim(l.prim_name,all)+trim(l.prim_range,all)+trim(l.sec_range,all)+trim(l.zip,all) ='' or trim(r.prim_name,all)+trim(r.prim_range,all)+trim(r.sec_range,all)+trim(r.zip,all) ='' , true,false);  

	self.mailing_full_street_address :=  if( trim(l.mailing_full_street_address,all)+trim(l.mailing_unit_number,all)+trim(l.mailing_city_state_zip,all) ='' or trim(r.mailing_full_street_address,all)+trim(r.mailing_unit_number,all)+trim(r.mailing_city_state_zip,all) ='','', l.mailing_full_street_address); 
	self.mailing_unit_number       := if( trim(l.mailing_full_street_address,all)+trim(l.mailing_unit_number,all)+trim(l.mailing_city_state_zip,all) ='' or trim(r.mailing_full_street_address,all)+trim(r.mailing_unit_number,all)+trim(r.mailing_city_state_zip,all) ='','', l.mailing_unit_number); 
	self.mailing_city_state_zip    := if( trim(l.mailing_full_street_address,all)+trim(l.mailing_unit_number,all)+trim(l.mailing_city_state_zip,all) ='' or trim(r.mailing_full_street_address,all)+trim(r.mailing_unit_number,all)+trim(r.mailing_city_state_zip,all) ='','', l.mailing_city_state_zip); 

	self.property_full_street_address  := if( trim(l.property_full_street_address,all)+trim(l.property_unit_number,all)+trim(l.property_city_state_zip,all) =''  or trim(r.property_full_street_address,all)+trim(r.property_unit_number,all)+trim(r.property_city_state_zip,all) ='','', l.property_full_street_address); 
	self.property_unit_number   := if( trim(l.property_full_street_address,all)+trim(l.property_unit_number,all)+trim(l.property_city_state_zip,all) ='' or trim(r.property_full_street_address,all)+trim(r.property_unit_number,all)+trim(r.property_city_state_zip,all) ='','', l.property_unit_number); 
	self.property_city_state_zip  := if( trim(l.property_full_street_address,all)+trim(l.property_unit_number,all)+trim(l.property_city_state_zip,all) ='' or trim(r.property_full_street_address,all)+trim(r.property_unit_number,all)+trim(r.property_city_state_zip,all) ='','',l.property_city_state_zip); 

	self.prim_range := if(( l.source_code[2] ='P'and r.source_code[2]='P') and is_true_p, '',l.prim_range);
	self.predir    := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p , '', l.predir);
	self.prim_name  := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '', l.prim_name);
	self.suffix    := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '', l.suffix);
	self.postdir   := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '',l.postdir);
	self.unit_desig  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.unit_desig);
	self.sec_range  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p, '',l.sec_range);
	self.p_city_name  := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '',l.p_city_name);
	self.v_city_name  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.v_city_name);
	self.st  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.st);
	self.zip  := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p, '',l.zip);
	self.zip4  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.zip4);
	self.cart  := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p, '',l.cart);
	self.cr_sort_sz  := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '',l.cr_sort_sz);
	self.lot   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '', l.lot);
	self.lot_order   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.lot_order);
	self.dbpc   := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p , '',l.dbpc);
	self.chk_digit  := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p , '',l.chk_digit);
	self.rec_type  := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.rec_type);
	self.county   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.county);
	self.geo_lat   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.geo_lat);
	self.geo_long   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '', l.geo_long);
	self.msa         := if(( l.source_code[2] ='P' and r.source_code[2]='P')and is_true_p , '', l.msa);
	self.geo_blk    := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '', l.geo_blk);
	self.geo_match   := if(( l.source_code[2] ='P' and r.source_code[2]='P') and is_true_p , '',l.geo_match );
	self.err_stat  := if(( l.source_code[2] ='P' and r.source_code[2]='P')  and is_true_p, '',l.err_stat); 

	self := l;
	end;

	assess_supp := rollup(asse_property,trans(left,right),ln_fares_id,local) ;

	assess_supp0 := assess_supp(~(source_code[2] != 'P'  and property_full_street_address <>'' and property_city_state_zip <>'' and prop_addr_propagated_ind ='P')); 
	assess_suppc:= assess_supp(source_code[2] != 'P'  and property_full_street_address <>'' and property_city_state_zip <>'' and prop_addr_propagated_ind ='P'); 

	// there are small % propagated records after cleaning there error_st[1]!= 'S' - count 398 as of 20080828

	assess_suppc t_clean(assess_suppc le) := transform
	 
	 string182 v_clean_addr := address.cleanaddress182(le.property_full_street_address,le.property_city_state_zip);
	 
	 self.prim_range  := v_clean_addr[ 1..  10];
	 self.predir      := v_clean_addr[ 11.. 12];
	 self.prim_name   := v_clean_addr[ 13.. 40];
	 self.suffix      := v_clean_addr[ 41.. 44];
	 self.postdir     := v_clean_addr[ 45.. 46];
	 self.unit_desig  := v_clean_addr[ 47.. 56];
	 self.sec_range   := v_clean_addr[ 57.. 64];
	 self.p_city_name := v_clean_addr[ 65.. 89];
	 self.v_city_name := v_clean_addr[ 90..114];
	 self.st          := v_clean_addr[115..116];
	 self.zip         := v_clean_addr[117..121];
	 self.zip4        := v_clean_addr[122..125];
	 self.cart        := v_clean_addr[126..129];
	 self.cr_sort_sz  := v_clean_addr[130..130];
	 self.lot         := v_clean_addr[131..134];
	 self.lot_order   := v_clean_addr[135..135];
	 self.dbpc        := v_clean_addr[136..137];
	 self.chk_digit   := v_clean_addr[138..138];
	 self.rec_type    := v_clean_addr[139..140];
	 self.county      := v_clean_addr[141..145];
	 self.geo_lat     := v_clean_addr[146..155];
	 self.geo_long    := v_clean_addr[156..166];
	 self.msa         := v_clean_addr[167..170];
	 self.geo_blk     := v_clean_addr[171..177];
	 self.geo_match   := v_clean_addr[178..178];
	 self.err_stat    := v_clean_addr[179..182];
	 self.source_code := le.source_code[1]+'P';
	 self.source_code_order := '1'; 
	 self             := le;
	end;

	assess_supp_clean := project(nofold(assess_suppc),t_clean(left));

	assess_supp_clean t_clean1(assess_supp_clean l) := transform
	 
	 self.click_hhid := ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,'','','','');

	 self             := l;
	end;

	assess_supp_clean1 := project(nofold(assess_supp_clean),t_clean1(left));

	assess_supp_out0:= nofold(assess_supp_clean1 + assess_supp0) ;

	// map to tax final layout 

	ln_propertyv2.layout_clickdata.tax reformat(assess_supp_out0 l ) := transform 

	self := l ; 

	end; 

	assess_out := project(assess_supp_out0, reformat(left)) ;	

	return assess_out ; 

	end ;

end ;