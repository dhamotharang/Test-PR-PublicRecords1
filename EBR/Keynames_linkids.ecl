import tools;

export Keynames_linkids(string filedate) :=
module

	export Templates :=
	module
		shared root := ebr_thor + 'key::'	+ dataset_name + '::@version@::';
		
		export s0010_header_linkids			                           := root + '0010_header::linkids';
		export s1000_executive_summary_linkids                 		 := root + '1000_executive_summary::linkids';		
		export s4510_ucc_filings_linkids                       		 := root + '4510_ucc_filings::linkids';				
		export s5600_demographic_data_linkids                  		 := root + '5600_demographic_data::linkids';		
		export s5610_demographic_data_linkids                  		 := root + '5610_demographic_data::linkids';				

		export dAll_templates := 
		dataset([

			 s0010_header_linkids
			,s1000_executive_summary_linkids	
			,s4510_ucc_filings_linkids	
			,s5600_demographic_data_linkids			
			,s5610_demographic_data_linkids
		], tools.Layout_Names);

	end;

	//////////////////////////////////////////////////////////////////
	// -- Member Key Filenames
	//////////////////////////////////////////////////////////////////
	export Versions	:= 
	module

		export k0010_header_linkids                            		 := tools.mod_FilenamesBuild(Templates.s0010_header_linkids,filedate);
		export k1000_executive_summary_linkids                 		 := tools.mod_FilenamesBuild(Templates.s1000_executive_summary_linkids,filedate);
		export k4510_ucc_filings_linkids                       		 := tools.mod_FilenamesBuild(Templates.s4510_ucc_filings_linkids,filedate);
		export k5600_demographic_data_linkids                  		 := tools.mod_FilenamesBuild(Templates.s5600_demographic_data_linkids,filedate);
		export k5610_demographic_data_linkids                  		 := tools.mod_FilenamesBuild(Templates.s5610_demographic_data_linkids,filedate);
	end;
	
	export dAll_superfilenames :=

			versions.k0010_header_linkids.dAll_superfilenames	
		+ versions.k1000_executive_summary_linkids.dAll_superfilenames		
		+ versions.k4510_ucc_filings_linkids.dAll_superfilenames	
		+ versions.k5600_demographic_data_linkids.dAll_superfilenames		
		+ versions.k5610_demographic_data_linkids.dAll_superfilenames		
		;

	export dNew :=

			versions.k0010_header_linkids.dNew
		+ versions.k1000_executive_summary_linkids.dNew	
		+ versions.k4510_ucc_filings_linkids.dNew			
		+ versions.k5600_demographic_data_linkids.dNew		
		+ versions.k5610_demographic_data_linkids.dNew		
		;

	export dAll_Oldsuperfilenames :=
		dataset([

			 KeyName_0010_Header_linkids
			,KeyName_1000_Executive_Summary_linkids						
			,KeyName_4510_UCC_Filings_linkids									
			,KeyName_5600_Demographic_Data_linkids				
			,KeyName_5610_Demographic_Data_linkids								
		], tools.Layout_Names);

end;