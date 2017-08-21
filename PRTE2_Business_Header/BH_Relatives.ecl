import Business_Header, ut, PRTE2;

export BH_Relatives(

	dataset(Layouts.Temporary.Layout_Relatives	)				pBH_Rel_Types		= PRTE2_Business_Header.BH_Rel_Types()
	
) :=
function
	
										 
	//*** Map to final Business relatives layout
	Business_Header.Layout_Business_Relative tMapBH_rel_recs(pBH_Rel_Types l) := transform
			self.corp_charter_number		:= if(trim(l.rel1_type) = 'C' or 
																				trim(l.rel2_type) = 'C' or
																				trim(l.rel3_type) = 'C' or
																				trim(l.rel4_type) = 'C' or
																				trim(l.rel5_type) = 'C' or
																				trim(l.rel6_type) = 'C' or
																				trim(l.rel7_type) = 'C' or
																				trim(l.rel8_type) = 'C' or
																				trim(l.rel9_type) = 'C' or
																				trim(l.rel10_type) = 'C' or
																				trim(l.rel11_type) = 'C', true, false);
			self.business_registration 	:= if(trim(l.rel1_type) = 'BR' or 
																				trim(l.rel2_type) = 'BR' or
																				trim(l.rel3_type) = 'BR' or
																				trim(l.rel4_type) = 'BR' or
																				trim(l.rel5_type) = 'BR' or
																				trim(l.rel6_type) = 'BR' or
																				trim(l.rel7_type) = 'BR' or
																				trim(l.rel8_type) = 'BR' or
																				trim(l.rel9_type) = 'BR' or
																				trim(l.rel10_type) = 'BR' or
																				trim(l.rel11_type) = 'BR', true, false);
			self.bankruptcy_filing 			:= if(trim(l.rel1_type) = 'B' or 
																				trim(l.rel2_type) = 'B' or
																				trim(l.rel3_type) = 'B' or
																				trim(l.rel4_type) = 'B' or
																				trim(l.rel5_type) = 'B' or
																				trim(l.rel6_type) = 'B' or
																				trim(l.rel7_type) = 'B' or
																				trim(l.rel8_type) = 'B' or
																				trim(l.rel9_type) = 'B' or
																				trim(l.rel10_type) = 'B' or
																				trim(l.rel11_type) = 'B', true, false);
			self.duns_number 						:= if(trim(l.rel1_type) = 'D' or 
																				trim(l.rel2_type) = 'D' or
																				trim(l.rel3_type) = 'D' or
																				trim(l.rel4_type) = 'D' or
																				trim(l.rel5_type) = 'D' or
																				trim(l.rel6_type) = 'D' or
																				trim(l.rel7_type) = 'D' or
																				trim(l.rel8_type) = 'D' or
																				trim(l.rel9_type) = 'D' or
																				trim(l.rel10_type) = 'D' or
																				trim(l.rel11_type) = 'D', true, false);
			self.duns_tree 							:= if(trim(l.rel1_type) = 'DT' or 
																				trim(l.rel2_type) = 'DT' or
																				trim(l.rel3_type) = 'DT' or
																				trim(l.rel4_type) = 'DT' or
																				trim(l.rel5_type) = 'DT' or
																				trim(l.rel6_type) = 'DT' or
																				trim(l.rel7_type) = 'DT' or
																				trim(l.rel8_type) = 'DT' or
																				trim(l.rel9_type) = 'DT' or
																				trim(l.rel10_type) = 'DT' or
																				trim(l.rel11_type) = 'DT', true, false);
			self.edgar_cik 							:= if(trim(l.rel1_type) = 'E' or 
																				trim(l.rel2_type) = 'E' or
																				trim(l.rel3_type) = 'E' or
																				trim(l.rel4_type) = 'E' or
																				trim(l.rel5_type) = 'E' or
																				trim(l.rel6_type) = 'E' or
																				trim(l.rel7_type) = 'E' or
																				trim(l.rel8_type) = 'E' or
																				trim(l.rel9_type) = 'E' or
																				trim(l.rel10_type) = 'E' or
																				trim(l.rel11_type) = 'E', true, false);
			self.name 									:= if(trim(l.rel1_type) = 'NM' or 
																				trim(l.rel2_type) = 'NM' or
																				trim(l.rel3_type) = 'NM' or
																				trim(l.rel4_type) = 'NM' or
																				trim(l.rel5_type) = 'NM' or
																				trim(l.rel6_type) = 'NM' or
																				trim(l.rel7_type) = 'NM' or
																				trim(l.rel8_type) = 'NM' or
																				trim(l.rel9_type) = 'NM' or
																				trim(l.rel10_type) = 'NM' or
																				trim(l.rel11_type) = 'NM', true, false); // might point to a group
			self.name_address 					:= if(trim(l.rel1_type) = 'NA' or 
																				trim(l.rel2_type) = 'NA' or
																				trim(l.rel3_type) = 'NA' or
																				trim(l.rel4_type) = 'NA' or
																				trim(l.rel5_type) = 'NA' or
																				trim(l.rel6_type) = 'NA' or
																				trim(l.rel7_type) = 'NA' or
																				trim(l.rel8_type) = 'NA' or
																				trim(l.rel9_type) = 'NA' or
																				trim(l.rel10_type) = 'NA' or
																				trim(l.rel11_type) = 'NA', true, false);
			self.name_phone 						:= if(trim(l.rel1_type) = 'NP' or 
																				trim(l.rel2_type) = 'NP' or
																				trim(l.rel3_type) = 'NP' or
																				trim(l.rel4_type) = 'NP' or
																				trim(l.rel5_type) = 'NP' or
																				trim(l.rel6_type) = 'NP' or
																				trim(l.rel7_type) = 'NP' or
																				trim(l.rel8_type) = 'NP' or
																				trim(l.rel9_type) = 'NP' or
																				trim(l.rel10_type) = 'NP' or
																				trim(l.rel11_type) = 'NP', true, false);
			self.gong_group 						:= if(trim(l.rel1_type) in ['GB','CG'] or 
																				trim(l.rel2_type) in ['GB','CG'] or
																				trim(l.rel3_type) in ['GB','CG'] or
																				trim(l.rel4_type) in ['GB','CG'] or
																				trim(l.rel5_type) in ['GB','CG'] or
																				trim(l.rel6_type) in ['GB','CG'] or
																				trim(l.rel7_type) in ['GB','CG'] or
																				trim(l.rel8_type) in ['GB','CG'] or
																				trim(l.rel9_type) in ['GB','CG'] or
																				trim(l.rel10_type) in ['GB','CG'] or
																				trim(l.rel11_type) in ['GB','CG'], true, false);
			self.ucc_filing 						:= if(trim(l.rel1_type) = 'U' or 
																				trim(l.rel2_type) = 'U' or
																				trim(l.rel3_type) = 'U' or
																				trim(l.rel4_type) = 'U' or
																				trim(l.rel5_type) = 'U' or
																				trim(l.rel6_type) = 'U' or
																				trim(l.rel7_type) = 'U' or
																				trim(l.rel8_type) = 'U' or
																				trim(l.rel9_type) = 'U' or
																				trim(l.rel10_type) = 'U' or
																				trim(l.rel11_type) = 'U', true, false);
			self.fbn_filing 						:= if(trim(l.rel1_type) = 'F' or 
																				trim(l.rel2_type) = 'F' or
																				trim(l.rel3_type) = 'F' or
																				trim(l.rel4_type) = 'F' or
																				trim(l.rel5_type) = 'F' or
																				trim(l.rel6_type) = 'F' or
																				trim(l.rel7_type) = 'F' or
																				trim(l.rel8_type) = 'F' or
																				trim(l.rel9_type) = 'F' or
																				trim(l.rel10_type) = 'F' or
																				trim(l.rel11_type) = 'F', true, false);
			self.fein 									:= if(trim(l.rel1_type) = 'FE' or 
																				trim(l.rel2_type) = 'FE' or
																				trim(l.rel3_type) = 'FE' or
																				trim(l.rel4_type) = 'FE' or
																				trim(l.rel5_type) = 'FE' or
																				trim(l.rel6_type) = 'FE' or
																				trim(l.rel7_type) = 'FE' or
																				trim(l.rel8_type) = 'FE' or
																				trim(l.rel9_type) = 'FE' or
																				trim(l.rel10_type) = 'FE' or
																				trim(l.rel11_type) = 'FE', true, false);
			self.phone 									:= if(trim(l.rel1_type) = 'PH' or 
																				trim(l.rel2_type) = 'PH' or
																				trim(l.rel3_type) = 'PH' or
																				trim(l.rel4_type) = 'PH' or
																				trim(l.rel5_type) = 'PH' or
																				trim(l.rel6_type) = 'PH' or
																				trim(l.rel7_type) = 'PH' or
																				trim(l.rel8_type) = 'PH' or
																				trim(l.rel9_type) = 'PH' or
																				trim(l.rel10_type) = 'PH' or
																				trim(l.rel11_type) = 'PH', true, false);
			self.addr 									:= if(trim(l.rel1_type) = 'AD' or 
																				trim(l.rel2_type) = 'AD' or
																				trim(l.rel3_type) = 'AD' or
																				trim(l.rel4_type) = 'AD' or
																				trim(l.rel5_type) = 'AD' or
																				trim(l.rel6_type) = 'AD' or
																				trim(l.rel7_type) = 'AD' or
																				trim(l.rel8_type) = 'AD' or
																				trim(l.rel9_type) = 'AD' or
																				trim(l.rel10_type) = 'AD' or
																				trim(l.rel11_type) = 'AD', true, false);
			self.mail_addr 							:= if(trim(l.rel1_type) = 'MA' or 
																				trim(l.rel2_type) = 'MA' or
																				trim(l.rel3_type) = 'MA' or
																				trim(l.rel4_type) = 'MA' or
																				trim(l.rel5_type) = 'MA' or
																				trim(l.rel6_type) = 'MA' or
																				trim(l.rel7_type) = 'MA' or
																				trim(l.rel8_type) = 'MA' or
																				trim(l.rel9_type) = 'MA' or
																				trim(l.rel10_type) = 'MA' or
																				trim(l.rel11_type) = 'MA', true, false);
			self.dca_company_number 		:= if(trim(l.rel1_type) = 'DC' or 
																				trim(l.rel2_type) = 'DC' or
																				trim(l.rel3_type) = 'DC' or
																				trim(l.rel4_type) = 'DC' or
																				trim(l.rel5_type) = 'DC' or
																				trim(l.rel6_type) = 'DC' or
																				trim(l.rel7_type) = 'DC' or
																				trim(l.rel8_type) = 'DC' or
																				trim(l.rel9_type) = 'DC' or
																				trim(l.rel10_type) = 'DC' or
																				trim(l.rel11_type) = 'DC', true, false); // Directory of Corporate Affilications Company Number (Root and Sub)
			self.dca_hierarchy 					:= if(trim(l.rel1_type) = 'DH' or 
																				trim(l.rel2_type) = 'DH' or
																				trim(l.rel3_type) = 'DH' or
																				trim(l.rel4_type) = 'DH' or
																				trim(l.rel5_type) = 'DH' or
																				trim(l.rel6_type) = 'DH' or
																				trim(l.rel7_type) = 'DH' or
																				trim(l.rel8_type) = 'DH' or
																				trim(l.rel9_type) = 'DH' or
																				trim(l.rel10_type) = 'DH' or
																				trim(l.rel11_type) = 'DH', true, false);
			self.abi_number 						:= if(trim(l.rel1_type) in ['IA','ID'] or 
																				trim(l.rel2_type) in ['IA','ID'] or
																				trim(l.rel3_type) in ['IA','ID'] or
																				trim(l.rel4_type) in ['IA','ID'] or
																				trim(l.rel5_type) in ['IA','ID'] or
																				trim(l.rel6_type) in ['IA','ID'] or
																				trim(l.rel7_type) in ['IA','ID'] or
																				trim(l.rel8_type) in ['IA','ID'] or
																				trim(l.rel9_type) in ['IA','ID'] or
																				trim(l.rel10_type) in ['IA','ID'] or
																				trim(l.rel11_type) in ['IA','ID'], true, false);     // InfoUSA - American Business ID Company Number
			self.abi_hierarchy 					:= if(trim(l.rel1_type) = 'IH' or 
																				trim(l.rel2_type) = 'IH' or
																				trim(l.rel3_type) = 'IH' or
																				trim(l.rel4_type) = 'IH' or
																				trim(l.rel5_type) = 'IH' or
																				trim(l.rel6_type) = 'IH' or
																				trim(l.rel7_type) = 'IH' or
																				trim(l.rel8_type) = 'IH' or
																				trim(l.rel9_type) = 'IH' or
																				trim(l.rel10_type) = 'IH' or
																				trim(l.rel11_type) = 'IH', true, false);
			self.lien_properties 				:= if(trim(l.rel1_type) = 'LP' or 
																				trim(l.rel2_type) = 'LP' or
																				trim(l.rel3_type) = 'LP' or
																				trim(l.rel4_type) = 'LP' or
																				trim(l.rel5_type) = 'LP' or
																				trim(l.rel6_type) = 'LP' or
																				trim(l.rel7_type) = 'LP' or
																				trim(l.rel8_type) = 'LP' or
																				trim(l.rel9_type) = 'LP' or
																				trim(l.rel10_type) = 'LP' or
																				trim(l.rel11_type) = 'LP', true, false);
			self.liens_v2 							:= if(trim(l.rel1_type) = 'L2' or 
																				trim(l.rel2_type) = 'L2' or
																				trim(l.rel3_type) = 'L2' or
																				trim(l.rel4_type) = 'L2' or
																				trim(l.rel5_type) = 'L2' or
																				trim(l.rel6_type) = 'L2' or
																				trim(l.rel7_type) = 'L2' or
																				trim(l.rel8_type) = 'L2' or
																				trim(l.rel9_type) = 'L2' or
																				trim(l.rel10_type) = 'L2' or
																				trim(l.rel11_type) = 'L2', true, false);
			//self.shared_contacts 				:= trim(l.rel_type) = 'SC';
			self.rel_group 							:= if(trim(l.rel1_type) = 'RG' or 
																				trim(l.rel2_type) = 'RG' or
																				trim(l.rel3_type) = 'RG' or
																				trim(l.rel4_type) = 'RG' or
																				trim(l.rel5_type) = 'RG' or
																				trim(l.rel6_type) = 'RG' or
																				trim(l.rel7_type) = 'RG' or
																				trim(l.rel8_type) = 'RG' or
																				trim(l.rel9_type) = 'RG' or
																				trim(l.rel10_type) = 'RG' or
																				trim(l.rel11_type) = 'RG', true, false);
			self 												:= l;
	end;
	
	dBh_Rel_matches := project(pBH_Rel_Types, tMapBH_rel_recs(left));
	
	// Reverse BDIDs
	Business_Header.Layout_Business_Relative tReverse_BDIDs(Business_Header.Layout_Business_Relative L) := transform
		self.bdid1 := L.bdid2;
		self.bdid2 := L.bdid1;
		self := L;
	end;

	dBH_Rel_Out := project(dBh_Rel_matches, tReverse_BDIDs(left));
	
	return dBh_Rel_Out;
	
end;