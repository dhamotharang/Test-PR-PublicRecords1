import BankruptcyV2_Services, doxie, FFD;

export Layout_BK_output_ext := record 

	doxie.Layout_BK_Output - [debtor_records];

	string10   attorney_prim_range;
	string2		 attorney_predir;
	string28   attorney_prim_name;	
	string4    attorney_addr_suffix;  
	string2    attorney_postdir;		
	string10   attorney_unit_desig;	
	string8    attorney_sec_range;		

	string10   attorney2_prim_range;
	string2		 attorney2_predir;
	string28   attorney2_prim_name;	
	string4    attorney2_addr_suffix;  
	string2    attorney2_postdir;		
	string10   attorney2_unit_desig;	
	string8    attorney2_sec_range;		

	string10   trustee_prim_range;
	string2		 trustee_predir;
	string28   trustee_prim_name;	
	string4    trustee_addr_suffix;  
	string2    trustee_postdir;		
	string10   trustee_unit_desig;	
	string8    trustee_sec_range;		
	
	dataset(doxie.layout_bk_child_ext) debtor_records {maxcount (BankruptcyV2_Services.layouts.PARTIES_PER_ROLLUP)}; // currently 20
	
	FFD.Layouts.CommonRawRecordElements;
end;
