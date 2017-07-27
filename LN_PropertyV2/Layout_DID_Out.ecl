import BIPV2;
 
export Layout_Did_Out := record
  LN_Propertyv2.Layout_Deed_Mortgage_Property_Search;
  unsigned6 did := 0;
  unsigned6 bdid := 0;
  string9   app_SSN := ''; 
  string9   app_tax_id := '';
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned8	source_rec_id := 0;
	
	string2		ln_party_status:= '';
  string6		ln_percentage_ownership:= '';
  string2		ln_entity_type:= '';
  string8		ln_estate_trust_date:= '';
  string1		ln_goverment_type:= '';
	unsigned8	nid :=0;
	integer2	xadl2_weight :=0;
	
	// Header address hierarchy
	string2 	Addr_ind 				:= '';
	string1 	Best_addr_ind 	:= '';
	// Salt linking for property transaction
  unsigned6 addr_tx_id 			:= 0;
  string1   best_addr_tx_id := '';
	// Location id (In development)
	unsigned8	Location_id 		:= 0;
  string1   best_locid 			:= '';
	
end;
