// [12/11/2012] NOTE: Information hasn't been going through this attribute since 2008.  If we start
// getting input for this again, the code needs to undergo the AID changes and the NID name cleaner
// changes.  Refer to the other attributes listed in Make_Party_Base, where this attribute is called,
// for example code of how to go about this. 
import address, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS,watchdog;

dParty   := File_Harris_TX_in;
layout_party
         :=record
		    string8     process_date;
			string3     JobCode; 
			string7     FileNumber; 
			string7     UCCNumber; 
			string120 	Orig_name:='';
			string60 	Orig_address1:='';
			string60 	Orig_address2:='';
			/*string14 	Orig_city:='';
			string14  	Orig_state:='';
			string5  	Orig_zip5:='';
			string4  	Orig_zip4:='';*/
			string30	Orig_country:='';
			string30 	Orig_province:='';
			string9  	Orig_postal_code:='';
			string1  	foreign_indc:='';
			string1  	Party_type:='';
			string300   company_name:='';
			string182   clean_address;
			string73    clean_name:='';
			string14    cityzip;
			string14    statezip;
		 end;
		 

layout_party tNormalizeName(dParty pInput, unsigned1 pCounter)
 :=
  transform
    self.Orig_name		:=  choose(pCounter,pInput.NameofMortgagee,pInput.NameofDebtor );
	self.Orig_address1  :=  choose(pCounter,pInput.MortgageeStrAddr,pInput.DebtorStreetAddr);
	self.cityzip		:=  choose(pCounter,pInput.Mortgageecityzip,pInput.DebtorCityZip );
	Self.statezip		:=  choose(pCounter,pInput.Mortgageestatezip,pInput.DebtorStateZip);
	self.party_type     :=  choose(pCounter,'S','D');
	self.clean_name	    :=	choose(pCounter,pInput.Sec_pname,pInput.Debtor_pname);
	self.clean_address  :=  choose(pCounter,pInput.clean_Sec_address,pInput.clean_Debtor_address);
	self 				:=	pInput;
end;


dNormalize 				:=	normalize(dParty,2,tNormalizeNAme(left,counter));
   
Layout_UCC_Common.Layout_Party tProjParty(dNormalize   pInput) 
   := 
   TRANSFORM
     string6     Foreign                := if(REGEXFIND('CN|BC',pInput.statezip),'CANADA',
	                                         if(REGEXFIND('MX',pInput.statezip),'MEXICO',
											 ''));
	
     string orig_number  :=  (string) if(stringlib.stringfilterout(pInput.UCCNumber,'012356789')>'a' or stringlib.stringfilterout(pInput.UCCNumber,'012356789')='', 
			                             (integer) (pInput.FileNumber),(integer) (pInput.UCCNumber));
			
	 self.tmsid 				       := 'TXH'+orig_number;
	 self.rmsid 				       := 'TXH'+(integer) pInput.fileNumber;
	 
		
	 self.Orig_country					:= Foreign;
	 self.foreign_indc				    := if(Foreign  <>'','Y','N');
	 self.dt_first_seen					:=   (unsigned6)(pInput.process_date[1..6]);
     self.dt_last_seen					:=   (unsigned6)(pInput.process_date[1..6]);
     self.dt_vendor_first_reported		:=   (unsigned6) pInput.process_date;
     self.dt_vendor_last_reported		  :=   (unsigned6) pInput.process_date;
	 self.orig_city                     :=  stringlib.stringfilterout(pInput.cityzip,'0123456789');  
	 self.orig_state                    :=  if(pInput.statezip[3]='',pInput.statezip[1..2],
	                                          if(REGEXFIND('TEXAS',pInput.statezip),'TX',''));
	 self.orig_zip5                     :=  if(length(stringlib.stringfilter(pInput.cityzip,'0123456789'))=5,
	                                           stringlib.stringfilter(pInput.cityzip,'0123456789'),
	                                           if(length(stringlib.stringfilter(pInput.statezip,'0123456789'))=5,
											       stringlib.stringfilter(pInput.statezip,'0123456789'),
											       ''));
	 self.company_name                  :=  if (pInput.clean_name='',pInput.Orig_name,'');
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
	self.dt_last_seen 			    	:= max(pLeft.dt_last_seen,pRight.dt_last_seen);
	self.dt_vendor_last_reported	:= max(pLeft.dt_vendor_last_reported,	pRight.dt_vendor_last_reported);
	self.dt_vendor_first_reported	:= ut.EarliestDate(pLeft.dt_vendor_first_reported,pRight.dt_vendor_first_reported);
	SELF.process_date							:= if(pleft.process_date > pright.process_date, pleft.process_date, pRight.process_date);
	self													:= pLeft;
   END;
 
dNameProj   						:= project(dNormalize(clean_name<>''), tProjParty(Left));
dNameDist		        			:= distribute(dNameProj,  hash(rmsid,tmsid,fname, mname,lname,trim(prim_range)));
dNameSort 			    			:= sort(dNamedist, rmsid,tmsid,fname, mname,lname,trim(prim_range),party_type,
							                 dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
dNameDedup              			:= rollup(dNameSort ,
											  left.rmsid    = right.rmsid 	and
											  left.tmsid    = right.tmsid 	and
											  left.fname    = right.fname 	and
											  left.mname    = right.mname   and
											  left.lname  	= right.lname   and
											  left.party_type  	= right.party_type   and
											  left.prim_range  	= right.prim_range,
											  Rollupp(left, right),  local);

dCnameProj   						:= project(dNormalize(clean_name=''),tProjParty(Left));
dCnameDist							:=  distribute(dCnameProj ,hash(rmsid,tmsid,zip5, trim(prim_name), trim(prim_range), trim(company_name)));
dCnameSort 							:=  sort(dCnamedist, rmsid,tmsid,zip5, prim_range, prim_name, company_name,sec_range,fein,party_type,
							                 dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
dCnameDedup    						:=  rollup(dCnameSort  ,
												left.rmsid          = right.rmsid 			and
												left.tmsid          = right.tmsid 	and
												left.zip5           = right.zip5 			and
												left.prim_name      = right.prim_name 		and
												left.prim_range 	= right.prim_range 		and
												left.company_name   = right.company_name 	and
												left.party_type  	= right.party_type      and
											 	(right.sec_range    = '' or left.sec_range 	= right.sec_range) 	and
												(right.fein         = '' or left.fein 		= right.fein),
												Rollupp(left, right),
												local);

dPartyout							:=dCnameDedup   +dnameDedup  ;

OutParty                :=  output(dPartyout ,,UCCV2.cluster.cluster_out+'base::UCC::Party::th',overwrite,__compressed__);
AddSuperfile            :=  FileServices.AddSuperFile(UCCV2.cluster.cluster_out+'base::UCC::Party_Name',UCCV2.cluster.cluster_out+'base::UCC::Party::th');

export proc_build_harris_Tx_party_base    :=sequential(OutParty,AddSuperfile); 