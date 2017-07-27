/*--SOAP--
<message name="EAHBatchService">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>  
  <part name="MarketRestriction" type="xsd:boolean"/>
  <part name="PremiumEAH" type="xsd:boolean"/>
  <part name="StandardBDA" type="xsd:boolean"/>
  <part name="PremiumBDA" type="xsd:boolean"/>
  <part name="DPPAPurpose" type="xsd:unsignedInt"/>
  <part name="GLBPurpose" type="xsd:unsignedInt"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
</message>
*/
/*--INFO-- This service returns comprehensive information of executives for input business.*/

import business_header, business_header_ss, doxie, doxie_files, execathomev2, marketing_best, paw, ut, address, Royalty;

export eah_batch_service := macro

bdid_thresh_value := 0;
f_in := dataset([],execathomev2.layout_batch_in) : stored('batch_in',few);
boolean market_rstr := false : stored ('MarketRestriction');
unsigned1 dppa_purpose := 0 : stored ('DPPAPurpose');
unsigned1 glb_purpose := 8 : stored ('GLBPurpose');
boolean glb := ut.glb_ok(glb_purpose);
boolean dppa := dppa_purpose > 0 and dppa_purpose < 8;
boolean prm_eah_value := false : stored('PremiumEAH');
boolean std_bda_value := false : stored('StandardBDA');
boolean prm_bda_value := false : stored('PremiumBDA');

//append sequence number
w_seq_rec := record
	unsigned4 seq,
	execathomev2.layout_batch_in,
end;	

f_in_seq_ready := project(f_in, transform({w_seq_rec},self.seq :=0,self:=left));

ut.MAC_Sequence_Records(f_in_seq_ready, seq, f_in_seq);

business_header_ss.Layout_BDID_InBatch clean_bus_addr(f_in_seq l) := transform
      clean_addr := address.CleanAddress182(l.business_address,
	                                            l.city + ',' + l.st + ' ' + l.zip);
	 self.prim_range := clean_addr[1..10];
	 self.predir := clean_addr[11..12];
	 self.prim_name := clean_addr[13..40];
	 self.addr_suffix := clean_addr[41..44];
	 self.postdir := clean_addr[45..46];
	 self.unit_desig := clean_addr[47..56];
	 self.sec_range := clean_addr[57..64];
	 self.p_city_name := clean_addr[65..89];
	 self.st := clean_addr[115..116];
	 self.z5 := clean_addr[117..121];
	 self.zip4 := clean_addr[122..125];
	 self.phone10 := l.phone;
	 self.company_name := l.business_name;
	 self.seq := l.seq;
	 self.fein := l.fein;
end;

f_in_clean := project(f_in_seq, clean_bus_addr(left));

Business_Header_SS.MAC_BDID_Append(f_in_clean, f_w_bdid_raw, bdid_thresh_value);

f_w_bdid := group(sort(f_w_bdid_raw, seq), seq);

f_w_paw_raw0 := join(f_w_bdid, paw.key_bdid,
                    keyed(left.bdid<>0 AND left.bdid = right.bdid),
										atmost(keyed(left.bdid<>0 AND left.bdid = right.bdid),50000));

//get dids from the people at work file
execathomev2.layout_eah_title get_paw(f_w_paw_raw0 l, PAW.Key_contactID r) := transform
	self := l;
	self.did := if(r.did=0 and r.bdid<>0, skip, r.did);
	self.confidence_code := map((unsigned)r.score > 6 => 'H', 
						   'M');
	self := [];
end;

f_w_paw_raw := join(f_w_paw_raw0, paw.Key_contactID,
                    keyed(left.contact_id<>0 AND left.contact_id = right.contact_id) AND RIGHT.did<>0,
				get_paw(left, right),
				left outer,
				atmost(ut.limits.PAW_PER_CONTACTID));
				
//group, sort and dedup			
f_w_paw := dedup(sort(f_w_paw_raw, bdid,did), bdid,did);			

//get tilte from title file 
execathomev2.layout_eah_title get_title_norstr(f_w_paw l, marketing_best.Key_Best_MrkTitle_BDID_DID r) := transform
	self.seq := l.seq;
	self.customer_id := l.customer_id;
	self.acctno := l.acctno;
	self.bdid := l.bdid;
	self.did := l.did;
	self.confidence_code := l.confidence_code;
	self.hhid := 0;
	self.company_title := r.company_title;
	self.business_decision_maker_flag := if(r.decision_maker_flag='B', 'Y', '');
	self.business_owner_flag := if(r.decision_maker_flag='O', 'Y', '');
end;

f_w_title_norstr := join(f_w_paw, marketing_best.Key_Best_MrkTitle_BDID_DID, 
                         left.bdid = right.l_bdid and left.did = right.l_did, 
			          get_title_norstr(left, right), KEEP(1));

execathomev2.layout_eah_title get_title_rstr(f_w_paw l, Marketing_Best.Key_Best_MrkTitle_BDID_DID_MrktRes r) := transform
	self.seq := l.seq;
	self.customer_id := l.customer_id;
	self.acctno := l.acctno;
	self.bdid := l.bdid;
	self.did := l.did;
	self.confidence_code := l.confidence_code;
	self.hhid := 0;
	self.company_title := r.company_title;
	self.business_decision_maker_flag := if(r.decision_maker_flag='B', 'Y', '');
	self.business_owner_flag := if(r.decision_maker_flag='O', 'Y', '');
end;

f_w_title_rstr := join(f_w_paw, Marketing_Best.Key_Best_MrkTitle_BDID_DID_MrktRes, 
                       left.bdid = right.l_bdid and left.did = right.l_did, 
			        get_title_rstr(left, right), KEEP(1));
		    
f_w_title := if(market_rstr, f_w_title_rstr, f_w_title_norstr);	

f_w_phone := execathomev2.get_eah_bestphone(f_w_title);			    
f_w_person_ready := execathomev2.get_eah_bestinfo(f_w_phone, glb, dppa, market_rstr);
f_w_person_best := execathomev2.suppress_address_phone(f_w_person_ready);

execathomev2.layout_eah_premium get_eah_detail(f_w_person_best l, marketing_best.key_equifax_DID r) := transform
   self.age := r.age_1;
   self.gender := r.primary_gender;
   self := l;
   self := r;
end; 

f_eah_premium_ready := join(f_w_person_best, marketing_best.key_equifax_DID,
                      left.did = right.l_did, get_eah_detail(left, right), left outer, keep(1));

f_eah_premium := join(f_eah_premium_ready, f_in_seq, left.seq=right.seq,
                      transform({execathomev2.layout_eah_premium}, 
			                  self.customer_id := right.customer_id,
						   self.acctno := right.acctno,
				      	   self := left), lookup);
					   						   						   
execathomev2.layout_bda_premium get_bda_detail_norstr(f_eah_premium l, marketing_best.Key_Marketing_Best_BDID r) := transform
	self := l;
	self := r;
end;				  

f_bda_premium_norstr := join(f_eah_premium, marketing_best.Key_Marketing_Best_BDID,
                             left.bdid=right.l_bdid, get_bda_detail_norstr(left, right), left outer, keep(1));
			   
execathomev2.layout_bda_premium get_bda_detail_rstr(f_eah_premium l, Marketing_Best.Key_Marketing_Best_BDID_MrktRes r) := transform
	self := l;
	self := r;
end;				  

f_bda_premium_rstr := join(f_eah_premium, Marketing_Best.Key_Marketing_Best_BDID_MrktRes ,
                           left.bdid=right.l_bdid, get_bda_detail_rstr(left, right), left outer, keep(1));
			   
f_bda_premium := if(market_rstr, f_bda_premium_rstr, f_bda_premium_norstr);			      

f_final := execathomev2.get_output_by_choice(f_bda_premium, prm_eah_value, std_bda_value, prm_bda_value);

// -- Royalties (begin) --------------------------------------

Royalty.Layouts.RoyaltyForBatch normRoyalties(f_final l, integer c) := transform
	_EQ				:= l.dwelling_type<>'' or l.estimated_home_income_predictor<>'' or l.number_of_persons_in_household<>'';
	_DBSales	:= l.salesMax<>'' or l.salesMin<>'' or l.exactSales<>'';
	_DBEmps		:= l.emplCntMax<>'' or l.emplCntMin<>'' or l.exactEmplCnt<>'';
	
	_rTypeCode	:= 
		map(c=3 and _DBEmps  => Royalty.Constants.RoyaltyCode.EAH_DB_EMPS,
				c=2 and _DBSales => Royalty.Constants.RoyaltyCode.EAH_DB_SALES,
				c=1 and _EQ 		 => Royalty.Constants.RoyaltyCode.EAH_EQ,
				0);
								 
	self.acctno 						:= l.acctno;										
	self.royalty_type_code	:= if(_rTypeCode <> 0, _rTypeCode, skip);
	self.royalty_type 			:= Royalty.Functions.GetRoyaltyType(_rTypeCode);
	self.royalty_count 			:= 1;
	self.non_royalty_count 	:= 0;	
end;

ROYALTY_TYPE_CNT			:= 3; // because we have 3 types of EAH royalties
detailedRoyalties 		:= false : stored('ReturnDetailedRoyalties');
dRoyaltiesByAcctno 		:= normalize(f_final, ROYALTY_TYPE_CNT, normRoyalties(left, counter)); 
dRoyalties 						:= Royalty.GetBatchRoyalties(ungroup(dRoyaltiesByAcctno), detailedRoyalties);

// -- Royalties (end) ----------------------------------------


output(sort(f_final, customer_id), NAMED('Results'));
output(dRoyalties, NAMED('RoyaltySet'));

endmacro;