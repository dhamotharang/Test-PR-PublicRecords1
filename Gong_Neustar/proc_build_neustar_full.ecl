IMPORT STD, Nid, Address, AID, DID_add, didville, Risk_Indicators, CellPhone, Gong;

Layout_Captions := RECORD
	 Layout_Neustar;
	 string	  temp_cap1    :='';
	 string   temp_cap2    :='';
	 string   temp_cap3    :='';
	 string   temp_cap4    :='';
	 string   temp_cap5    :='';
	 string   temp_cap6    :='';
	 string   temp_cap7    :='';
	 string	  temp_hseno   :='';
	 string	  temp_hsesx   :='';
	 string	  temp_strt    :='';
	 string   temp_address1:='';
	 string   temp_address2:='';
END;

proc_AddIndents(dataset(Layout_Neustar) infile) := FUNCTION
		Layout_Captions  concatCaps(Layout_Captions L,Layout_Captions R ) := transform

			 self.temp_cap1 := if(r.indent = 1,r.business_captions,if(r.indent > 1,l.temp_cap1,''));
			 self.temp_cap2 := if(r.indent = 2,r.business_captions,if(r.indent > 2,l.temp_cap2,''));
			 self.temp_cap3 := if(r.indent = 3,r.business_captions,if(r.indent > 3,l.temp_cap3,''));
			 self.temp_cap4 := if(r.indent = 4,r.business_captions,if(r.indent > 4,l.temp_cap4,''));
			 self.temp_cap5 := if(r.indent = 5,r.business_captions,if(r.indent > 5,l.temp_cap5,''));
			 self.temp_cap6 := if(r.indent = 6,r.business_captions,if(r.indent > 6,l.temp_cap6,''));
			 self.temp_cap7 := if(r.indent = 7,r.business_captions,if(r.indent > 7,l.temp_cap7,''));
			 
			 //Propogate SubHd2 detail records that have addresses
			 //self.temp_hseno := map(R.temp_hseno != '' and R.lststy = '2' and R.indent > '1'  => R.temp_hseno, L.hseno);
			 //self.temp_hsesx := map(R.temp_hsesx != '' and R.lststy = '2' and R.indent > '1'  => R.temp_hsesx, L.hsesx);
			 //self.temp_strt  := map(R.temp_strt  != '' and R.lststy = '2' and R.indent > '1'  => R.temp_strt , L.strt );
			 self := R;
	end;

	iCaps := iterate(PROJECT(infile,Layout_Captions),concatCaps(left,right));
	return iCaps;

end;

proc_AddDid(dataset(layout_gongMaster) infile) := FUNCTION
	matchset := ['A', 'P', 'Z'];

	did_add.MAC_Match_Flex(infile,matchset,
                       foo,foo,cln_fname,cln_mname,cln_lname,cln_suffix,
				   prim_range,prim_name,sec_range,z5,st,phone10,
				   did,layout_gongMaster,false,foo,75,with_did);
					 
/*	history_did_dist := distribute(with_did, hash(cln_lname,prim_name));		

	didville.MAC_HHID_Append_By_Address(
		history_did_dist, history_hhid, hhid, cln_lname,
		prim_range, prim_name, sec_range, st, z5);
	*/	
	return with_did;
END;

proc_LinkUp(dataset(layout_gongMaster) infile) := FUNCTION

		history_did_hhid := fn_did_bdid_hhid_trg(infile);

		mac_add_disc_cnt(history_did_hhid,cmplt_history);
		
		return cmplt_history;

END;


proc_CleanAddresses(dataset(layout_gongMaster) infile) := FUNCTION
	master2 := DISTRIBUTE(infile);

	raid := RECORD
		layout_gongMaster;
		string	line1;
		string	line2;
	END;
	
	master3 := PROJECT(master2, TRANSFORM(raid,
						self.line1 := TRIM(STD.str.cleanspaces(ToUpper( 
							left.PRIMARY_STREET_NUMBER + ' ' +
							left.PRE_DIR + ' ' +
							left.PRIMARY_STREET_NAME + ' ' +
							left.PRIMARY_STREET_SUFFIX + ' ' +
							left.POST_DIR + ' ' +
							left.SECONDARY_ADDRESS_TYPE + ' ' +
							left.SECONDARY_RANGE)));
						self.line2 := TRIM(STD.str.cleanspaces(ToUpper(
							IF(left.CITY='','',trim(left.CITY, left, right) + ', ') + left.STATE + ' ' + left.ZIP_CODE)));
						self := LEFT;
						));

	aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;

	masterAID := master3(line1<>'',line2<>'');
		masterNoAID := project(master3(line1='' OR line2=''), transform(Gong_Neustar.layout_gongmaster,
				clnaddr 	  := Address.CleanAddress182(left.line1, left.line2);
				string pickone(string raw, string cleaned) := TRIM(IF(cleaned='',ToUpper(raw),cleaned));
				
				self.rawaid := 0;
				self.prim_range := pickone(left.PRIMARY_STREET_NUMBER,clnaddr[1..10]);
				self.predir :=  pickone(left.PRE_DIR,clnaddr[11..12]);
				self.prim_name := pickone(left.PRIMARY_STREET_NAME,clnaddr[13..40]);
				self.suffix := pickone(left.PRIMARY_STREET_SUFFIX,clnaddr[41..44]);
				self.postdir := pickone(left.POST_DIR,clnaddr[45..46]);
				self.unit_desig := pickone(left.SECONDARY_ADDRESS_TYPE,clnaddr[47..56]);
				self.sec_range := pickone(left.SECONDARY_RANGE,clnaddr[57..64]);
				self.p_city_name := pickone(left.city,clnaddr[65..89]);
				self.v_city_name := pickone(left.city,clnaddr[90..114]);
				self.st := pickone(left.state,clnaddr[115..116]);
				self.z5 := pickone(left.ZIP_CODE,clnaddr[117..121]);
				self.z4 := pickone(left.ZIP_PLUS4,clnaddr[122..125]);
				self.cart := clnaddr[126..129];
				self.cr_sort_sz := clnaddr[130];
				self.lot := clnaddr[131..134];
				self.lot_order := clnaddr[135];
				self.dpbc := clnaddr[136..137];
				self.chk_digit := clnaddr[138];
				self.rec_type := clnaddr[139..140];
				self.county_code := clnaddr[141..142] + clnaddr[143..145];
				self.geo_lat := pickone(left.LATITUDE,clnaddr[146..155]);
				self.geo_long := pickone(left.LONGITUDE,clnaddr[156..166]);
				self.msa := clnaddr[167..170];
				self.geo_blk := clnaddr[171..177];
				self.geo_match := pickone(left.LAT_LONG_MATCH_LEVEL,clnaddr[178]);
				self.err_stat := clnaddr[179..182];
				self:=left));	
		
	aid.MacAppendFromRaw_2Line(masterAID, line1, line2, rawaid , master4, laidappendflags);

	master5 := normalize(master4, 1, transform(Gong_Neustar.layout_gongmaster,
				choose_field(string old, string new) := function
					S := left.err_stat[..1] = 'S';
					prim_range := left.PRIMARY_STREET_NUMBER <> '' and left.aidwork_acecache.prim_range = '';
					prim_name := left.PRIMARY_STREET_NAME <> '' and left.aidwork_acecache.prim_name = '';
					sec_range := left.SECONDARY_RANGE <> '' and left.aidwork_acecache.sec_range = '';
					return if(prim_range or s or prim_name or sec_range, old, new);
				end;
				
				upper(string s) := Std.Str.ToUpperCase(s);
				
				self.rawaid := left.aidwork_rawaid;
				self.prim_range := choose_field(upper(left.PRIMARY_STREET_NUMBER), left.aidwork_acecache.prim_range);
				self.predir := choose_field(upper(left.PRE_DIR), left.aidwork_acecache.predir);
				self.prim_name := choose_field(upper(left.PRIMARY_STREET_NAME), left.aidwork_acecache.prim_name);
				self.suffix := choose_field(upper(left.PRIMARY_STREET_SUFFIX), left.aidwork_acecache.addr_suffix);
				self.postdir := choose_field(upper(left.POST_DIR), left.aidwork_acecache.postdir);
				self.unit_desig := choose_field(upper(left.SECONDARY_ADDRESS_TYPE), left.aidwork_acecache.unit_desig);
				self.sec_range := choose_field(upper(left.SECONDARY_RANGE), left.aidwork_acecache.sec_range);
				self.p_city_name := choose_field(upper(left.city), left.aidwork_acecache.p_city_name);
				self.v_city_name := choose_field(upper(left.city), left.aidwork_acecache.v_city_name);
				self.st := choose_field(upper(left.state), left.aidwork_acecache.st);
				self.z5 := choose_field(upper(left.ZIP_CODE), left.aidwork_acecache.zip5);
				self.z4 := choose_field(upper(left.ZIP_PLUS4), left.aidwork_acecache.zip4);
				self.cart := left.aidwork_acecache.cart;
				self.cr_sort_sz := left.aidwork_acecache.cr_sort_sz;
				self.lot := choose_field(left.lot, left.aidwork_acecache.lot);
				self.lot_order := left.aidwork_acecache.lot_order;
				self.dpbc := left.aidwork_acecache.dbpc;
				self.chk_digit := left.aidwork_acecache.chk_digit;
				self.rec_type := left.aidwork_acecache.rec_type;
				self.county_code := left.aidwork_acecache.county;
				self.geo_lat := choose_field(left.LATITUDE, left.aidwork_acecache.geo_lat);
				self.geo_long := choose_field(left.LONGITUDE, left.aidwork_acecache.geo_long);
				self.msa := left.aidwork_acecache.msa;
				self.geo_blk := left.aidwork_acecache.geo_blk;
				self.geo_match := choose_field(left.LAT_LONG_MATCH_LEVEL, left.aidwork_acecache.geo_match);
				self.err_stat := left.aidwork_acecache.err_stat;
				self:=left));

	master6 := 			
		master5 & masterNoAID;		// : PERSIST('~thor::persist::gong::neustar::cleanaddr');
	return master6;
	
END;

rgx1 := '/.*$';
rgx2 := '(ARCHITECT|ARCHT|ATTY AT LAW|ATTY OFC|ATTY|CERT PUB ACCT|CHRPRCTR|OFC|FAX LINE|FAX LI|FCCP|INS|ATTORNEY AT LAW|DENTIST|LWYR|OPTMTRST|ORAL SURGN|ORTHDNTST|PHY & SUR|PODIATRST|RL EST|REAL ESTATE|REALTOR|RES|RLT|RLTR|RVT|SURG)$';
string FixupName(string s) := TRIM(MAP(
		REGEXFIND(rgx1, s, NOCASE) => REGEXREPLACE(rgx1, s, '', NOCASE),
		REGEXFIND(rgx2, s, NOCASE) => REGEXREPLACE(rgx2, s, '', NOCASE),
		s));

LayoutTemp := RECORD
	layout_gongMaster;
	string80		preppedname;
END;

string MakeListedName(string fname, string mname, string lname, string sfx) :=
					TRIM(STD.Str.CleanSpaces(STD.Str.ToUpperCase(lname + ' ' + fname + ' ' + mname + ' ' + sfx)),LEFT,RIGHT);

layout_gongMaster xDualNames(layout_gongMaster L, integer n) := TRANSFORM
 self.name_prefix			:= if(n=1,L.cln_title, L.cln_title2);
 self.name_first			:= if(n=1,L.cln_fname, L.cln_fname2);
 self.name_middle			:= if(n=1,L.cln_mname, L.cln_mname2);
 self.name_last				:= if(n=1,L.cln_lname, L.cln_lname2);
 self.name_suffix 		:= if(n=1,L.cln_suffix, L.cln_suffix2);
 self.dual_name_flag := 'Y';
 self.company_name := if(L.Business_name='',MakeListedName(L.first_name,L.middle_name,L.last_name,L.suffix_name),
															STD.Str.ToUpperCase(L.Business_name));
 self := L;
END;	


layout_gongMaster xNames(layout_gongMaster L) := TRANSFORM
 self.name_prefix			:= L.cln_title;
 self.name_first			:= if(L.cln_fname='',L.name_first, L.cln_fname);
 self.name_middle			:= if(L.cln_mname='',L.name_middle, L.cln_mname);
 self.name_last				:= if(L.cln_lname='',L.name_last, L.cln_lname);
 self.name_suffix 		:= if(L.cln_suffix='',L.name_suffix, L.cln_suffix);
 self.dual_name_flag := 'N';
 self.company_name := if(L.Business_name='',MakeListedName(L.first_name,L.middle_name,L.last_name,L.suffix_name),
															STD.Str.ToUpperCase(L.Business_name));
 self := L;
END;	

proc_CleanNames(dataset(layout_gongMaster) infile) := FUNCTION

	master1a := PROJECT(infile(RECORD_TYPE in ['P']), TRANSFORM(LayoutTemp,		// try to extract names from professional
									self.preppedname := fixupName(LEFT.Business_name);
									self := LEFT;));
	master1b := infile(RECORD_TYPE = 'R');
	CleanNames_full := Nid.fn_CleanFullNames(master1a, preppedname, useV2 := true);
	CleanNames_parsed := Nid.fn_CleanParsedNames(master1b, First_name, Middle_Name, Last_name, Suffix_name, useV2 := true);

	clnnames := PROJECT(CleanNames_full,layout_gongMaster) & PROJECT(CleanNames_parsed,layout_gongMaster);	// 
	clnnames1 := PROJECT(clnnames(nametype<>'D'), xNames(LEFT));
	clnnames2 := NORMALIZE(clnnames(nametype='D'), 2, xDualNames(LEFT,COUNTER));
	clnnames3 := PROJECT(infile(RECORD_TYPE in ['B','G']), TRANSFORM(layout_gongMaster,
													self.dual_name_flag := 'N';
													self := LEFT;));
	clnnames4 := clnnames1 & clnnames2 & clnnames3;

	return clnnames4;	// : PERSIST('~thor::persist::gong::neustar::cleannames');
end;

proc_AddPriorAreaCodes(dataset(layout_gongMaster) infile) := FUNCTION
	acChange := Risk_Indicators.File_AreaCode_Change;
	layout_gongMaster tChange(infile L, acChange R) := transform
				self.prior_area_code 	:= map(L.phone10[1..6] = R.new_npa+R.new_nxx
								and ut.GetDate < 
								if(R.permissive_end[5]='9','19'+R.permissive_end[5..6]+R.permissive_end[1..4],'20'+R.permissive_end[5..6]+R.permissive_end[1..4])
								=> R.old_npa,'');								
			self 					:= L;
		end;

		j_acChange := join(infile,acChange,left.phone10[1..6]=right.new_npa+right.new_nxx,tChange(left,right),left outer,lookup);
		return j_acChange;
END;

//Group and Propogate group id 
proc_addGroup(dataset(layout_gongMaster) infile) := FUNCTION
		cleanUpdate := SORT(DISTRIBUTE(infile, (integer)seisintid), seisintid, LOCAL);

		//Group and Propogate group id 
		g_cleanUpdate:= group(cleanUpdate,seisintid,LOCAL);

		g_cleanUpdate t_propseq(g_cleanUpdate L, g_cleanUpdate R, integer c) := transform
		 self.group_seq	:= (string10)c;
		 self           := R;
		end;

		i_cleanUpdate := iterate(g_cleanUpdate,t_propseq(left,right,counter));
		u_cleanUpdate := ungroup(i_cleanUpdate);
		return u_cleanUpdate;
END;



EXPORT proc_build_neustar_full(string rundate) := function

	// there are only adds in the full file
	//adds := distribute(File_Full(Action_code='A'), HASH32(record_id));
	adds := File_Full_Refresh(Action_code in ['A','I']);
	addsWithCaps := proc_AddIndents(adds);
	
	master1 := PROJECT(addsWithCaps(record_type<>'R' OR Listing_Type='P' OR Original_Last_Name<>'' OR Original_First_Name<>'' OR Original_Middle_Name<>''
														OR Original_Suffix <>'' OR Original_Address<>'' OR Original_Last_Line<>''
																						), TRANSFORM(Layout_gongMaster,
			
				self.dt_first_seen:= Left.add_date;
				self.dt_last_seen:= rundate;
				self.current_record_flag:= 'Y';  
				self.deletion_date:= '';
				self.filedate := rundate + '_1';
				self.bell_id := 'NEU';
				self.sequence_number := COUNTER;
				self.SeisintID  		:= NeustarToSeisintId(left.Record_ID);
				self.group_id				:= self.SeisintID;
				self.listing_type_bus	:= IF(Left.RECORD_TYPE in ['B','P'],'B',' ');
				self.listing_type_res := IF(Left.RECORD_TYPE in ['R','P'],'R',' ');
				self.listing_type_gov := IF(Left.RECORD_TYPE = 'G','G',' ');

				self.prior_area_code:= '';
				self.company_name := Std.str.touppercase(left.Business_name);
				self.caption_text	    	:= Std.str.touppercase(
							   if(Left.temp_cap1 = '','',Left.temp_cap1)+
							   if(Left.temp_cap2 = '','','|'+Left.temp_cap2)+
							   if(Left.temp_cap3 = '','','|'+Left.temp_cap3)+
							   if(Left.temp_cap4 = '','','|'+Left.temp_cap4)+
							   if(Left.temp_cap5 = '','','|'+Left.temp_cap5)+
							   if(Left.temp_cap6 = '','','|'+Left.temp_cap6)+
							   if(Left.temp_cap7 = '','','|'+Left.temp_cap7));

				self.publish_code			:= case(left.LISTING_TYPE,
											'L' => 'P',				// listed
											'U' => 'U',				// unlisted
											'P' => 'N',				// private
											' ');
				self.style_code			:= 'X';		// default ... no comparable Neustar field							   
				self.indent_code			:= (string)left.indent;
				self.omit_address  := left.omit_address;
				self.omit_phone    := 'N';
				self.omit_locality := 'N';
				self.privacy_flag 	:= 'N';		// no equivalent in Neustar	

				CleanPhone					:= CellPhone.CleanPhones(LEFT.TELEPHONE);	
				self.phone10				:= if(self.publish_code = 'N' or cleanphone[4..10]='0000000','',cleanphone);

//				self.caption_text	:= Left.BUSINESS_CAPTIONS;
				self := left;)
	);
  master1a :=  proc_AddPriorAreaCodes(master1);
	master2 := proc_CleanNames(master1a);
	master3 := proc_CleanAddresses(master2);
	//master4 := proc_AddDid(master3(cln_lname<>''));
	//master5 := master3(cln_lname='') & master4;
	master6 := proc_LinkUp(master3);
	master7 := proc_addGroup(master6);
		
	return master7;
END;