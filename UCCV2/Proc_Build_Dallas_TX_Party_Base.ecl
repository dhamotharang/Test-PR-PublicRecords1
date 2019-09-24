import address, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS,watchdog;  

dParty   := File_Dallas_TX_in;
layout_party
         :=record
		    string7     BLACK_NUM;
			string8     FILE_DATE;
			string8		process_date;
			string120 	Orig_name:='';
			string60 	Orig_address1:='';
			string60 	Orig_address2:='';
			string30 	Orig_city:='';
			string2  	Orig_state:='';
			string5  	Orig_zip5:='';
			string4  	Orig_zip4:='';
			string30	Orig_country:='';
			string30 	Orig_province:='';
			string9  	Orig_postal_code:='';
			string1  	foreign_indc:='';
			string1  	Party_type:='';
			string300   company_name;
			string182   clean_address;
			string73    clean_name:='';
		 end;
layout_party tNormalizeName(dParty pInput, unsigned1 pCounter)
 :=
  transform
    self.Orig_name		:=  choose(pCounter,pInput.SECURED_NAME,pInput.DEBTOR_NAME ,pInput.DEBTOR_NAME ,pInput.DEBTOR_NAME ,pInput.DEBTOR_NAME ,pInput.DEBTOR_NAME );
	self.Orig_address1  :=  choose(pCounter,'',pInput.DEBT_ADDR1 ,pInput.DEBT_ADDR1 ,pInput.DEBT_ADDR1 ,pInput.DEBT_ADDR1 ,pInput.DEBT_ADDR1 );
	self.Orig_address2  :=  choose(pCounter,'',pInput.DEBT_ADDR2 ,pInput.DEBT_ADDR2 ,pInput.DEBT_ADDR2 ,pInput.DEBT_ADDR2 ,pInput.DEBT_ADDR2 );
	self.Orig_city		:=  choose(pCounter,pInput.SEC_CITY,pInput.DEBT_CITY ,pInput.DEBT_CITY ,pInput.DEBT_CITY ,pInput.DEBT_CITY ,pInput.DEBT_CITY );
	Self.Orig_state		:=  choose(pCounter,pInput.SEC_STATE,pInput.DEBT_STATE ,pInput.DEBT_STATE ,pInput.DEBT_STATE ,pInput.DEBT_STATE ,pInput.DEBT_STATE);
	self.Orig_zip5      :=  choose(pCounter,pInput.SEC_ZIP,pInput.DEBT_ZIP ,pInput.DEBT_ZIP ,pInput.DEBT_ZIP ,pInput.DEBT_ZIP ,pInput.DEBT_ZIP);
	self.party_type     :=  choose(pCounter,'S','D','D','D','D','D');
	self.clean_name	    :=	choose(pCounter,pInput.SEC_clean_name,pInput.CleanName1,pInput.CleanName2,pInput.CleanName3,pInput.CleanName4,pInput.CleanName5);
	self.Company_Name	:=	choose(pCounter,pInput.SECURED_NAME,pInput.CName1,pInput.CName2,pInput.CName3,pInput.CName4,pInput.CName5);
	self.clean_address  :=  choose(pCounter,pInput.SEC_clean_addr,pInput.clean_address);
	self 				:=	pInput;
end;


dNormalize 				        :=	normalize(dParty,6,tNormalizeNAme(left,counter));
   
Layout_UCC_Common.Layout_Party tProjParty(dNormalize   pInput) 
   := 
   TRANSFORM
     string6     Foreign                := if(pInput.Orig_state='OT' or pInput.Orig_state='BC','CANADA',
	                                          if(pInput.Orig_state='MX', 'MEXICO',''));
	 self.tmsid 				 		:= 'TXD'+pInput.BLACK_NUM+pInput.FILE_DATE;
	 self.rmsid 				 		:= 'TXD'+pInput.BLACK_NUM+pInput.FILE_DATE;
	 self.Orig_country					:= Foreign;
	 self.Orig_postal_code				:= if(Foreign  <>'',pInput.Orig_ZIP5,'');
	 Self.Orig_province					:= if(Foreign  <>'',pInput.Orig_state,'');
	 self.foreign_indc				    := if(Foreign  <>'','Y','N');
	 self.dt_first_seen					:=   (unsigned6)(pInput.process_date[1..6]);
     self.dt_last_seen					:=   (unsigned6)(pInput.process_date[1..6]);
     self.dt_vendor_first_reported		:=   (unsigned6) pInput.process_date; 
     self.dt_vendor_last_reported		:=   (unsigned6) pInput.process_date; 
	 self.title							:=	pInput.clean_name[1..5];
	 self.fname							:=	pInput.clean_name[6..25];
	 self.mname							:=	pInput.clean_name[26..45];
	 self.lname					        :=	pInput.clean_name[46..65];
	 self.name_suffix					:=	pInput.clean_name[66..70];
	 self.name_score					:=	pInput.clean_name[71..73];
	 self.prim_range 					:=	pInput.clean_address[1..10];
	 self.predir 						:=	pInput.clean_address[11..12];
	 self.prim_name 					:=	pInput.clean_address[13..40];
	 self.suffix 						:=	pInput.clean_address[41..44];
	 self.postdir 						:=	pInput.clean_address[45..46];
	 self.unit_desig 					:=	pInput.clean_address[47..56];
	 self.sec_range 					:=	pInput.clean_address[57..64];
	 self.p_city_name 					:=	pInput.clean_address[65..89];
	 self.v_city_name 					:=	pInput.clean_address[90..114];
	 self.st 							:=	pInput.clean_address[115..116];
	 self.zip5 							:=	pInput.clean_address[117..121];
	 self.zip4 							:=	pInput.clean_address[122..125];
	 self.cart 							:=	pInput.clean_address[126..129];
	 self.cr_sort_sz 					:=	pInput.clean_address[130];
	 self.lot 							:=	pInput.clean_address[131..134];
	 self.lot_order 					:=	pInput.clean_address[135];
	 self.dpbc 							:=	pInput.clean_address[136..137];
	 self.chk_digit 					:=	pInput.clean_address[138];
	 self.rec_type						:=	pInput.clean_address[139..140];
	 self.ace_fips_st 					:=	pInput.clean_address[141..142];
	 self.ace_fips_county				:=	pInput.clean_address[143..145];
	 self.geo_lat 						:=	pInput.clean_address[146..155];
	 self.geo_long 						:=	pInput.clean_address[156..166];
	 self.msa 							:=	pInput.clean_address[167..170];
	 self.geo_blk 						:=	pInput.clean_address[171..177];
	 self.geo_match 					:=	pInput.clean_address[178];
	 self.err_stat 						:=	pInput.clean_address[179..182];
	 self.county						:=	pInput.clean_address[143..145];
	 self								:=	pInput;
  
END;
Layout_UCC_Common.Layout_Party RollupP(Layout_UCC_Common.Layout_Party  pLeft,Layout_UCC_Common.Layout_Party pRight) 
   := 
   TRANSFORM
    self.dt_first_seen 			    := ut.EarliestDate(ut.EarliestDate(pLeft.dt_first_seen,pRight.dt_first_seen),
	                                   ut.EarliestDate(pLeft.dt_last_seen,pRight.dt_last_seen));
	self.dt_last_seen 			    := ut.LatestDate(pLeft.dt_last_seen,pRight.dt_last_seen);
	self.dt_vendor_last_reported	:= ut.LatestDate(pLeft.dt_vendor_last_reported,	pRight.dt_vendor_last_reported);
	self.dt_vendor_first_reported   := ut.EarliestDate(pLeft.dt_vendor_first_reported,pRight.dt_vendor_first_reported);
	SELF.process_date 			    := if(pleft.process_date > pright.process_date, pleft.process_date, pRight.process_date);
	self                            := pLeft;
   END;
 
dNameProj   						:= project(dNormalize(clean_name<>''), tProjParty(Left));
dNameDist		        			:=  distribute(dNameProj,  hash(rmsid,fname, mname,lname,trim(prim_range)));
dNameSort 			    			:=  sort(dNamedist, rmsid,fname, mname,lname,trim(prim_range),
							                 dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
dNameDedup              			:= rollup(dNameSort ,
											  left.rmsid    = right.rmsid 	and
											  left.fname    = right.fname 	and
											  left.mname    = right.mname   and
											  left.lname  	= right.lname   and
											  left.prim_range  	= right.prim_range,
											  Rollupp(left, right),  local);

dCnameProj   						:= project(dNormalize(company_name<>''),tProjParty(Left));
dCnameDist							:=  distribute(dCnameProj ,hash(rmsid,zip5, trim(prim_name), trim(prim_range), trim(company_name)));
dCnameSort 							:=  sort(dCnamedist, rmsid,zip5, prim_range, prim_name, company_name,sec_range,fein,
							                 dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
dCnameDedup    						:=  rollup(dCnameSort  ,
												left.rmsid          = right.rmsid 			and
												left.zip5           = right.zip5 			and
												left.prim_name      = right.prim_name 		and
												left.prim_range 	= right.prim_range 		and
												left.company_name   = right.company_name 	and
												(right.sec_range    = '' or left.sec_range 	= right.sec_range) 	and
												(right.fein         = '' or left.fein 		= right.fein),
												Rollupp(left, right),
												local);

dPartyOut                           := dCnameDedup + dNameDedup:persist('base::UCC::Party::TD');
                                       
//ut.MAC_SF_BuildProcess(dPartyOut ,cluster.cluster_out+,OutParty, 2);

export Proc_Build_Dallas_TX_Party_Base     :=	dPartyOut  ;