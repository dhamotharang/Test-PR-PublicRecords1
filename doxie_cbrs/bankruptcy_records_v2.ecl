import bankruptcyv2_services,doxie;

doxie_cbrs.mac_Selection_Declare()

export bankruptcy_records_v2(dataset(doxie_cbrs.layout_references) bdids, unsigned in_limit = 0, STRING6 SSNMask='NONE') := module
  
	export all_recs := bankruptcyv2_services.bankruptcy_raw().report_view(in_bdids := bdids,in_limit := in_limit,in_ssn_mask:=SSNMask,in_party_type := 'D');
  export report_view(unsigned in_limit = 0) := choosen(if(BankruptcyVersion in [0,2],all_recs),in_limit); 
	export source_view(unsigned in_limit = 0) := if(BankruptcyVersion in [0,2],bankruptcyv2_services.bankruptcy_raw().source_view(in_bdids := bdids,in_limit := in_limit,in_ssn_mask:=SSNMask,in_party_type := 'D'));
	
	export report_count(boolean in_display) := count(bankruptcyv2_services.bankruptcy_raw().report_view(in_bdids := bdids,in_party_type := 'D')(in_display AND BankruptcyVersion in [0,2]));																																							
end;
