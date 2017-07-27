import ebr_services,doxie;

export experian_business_reports_raw(
	dataset(doxie_cbrs.layout_references) bdids,
	boolean in_include,
	unsigned in_max) :=
	module
		shared temp_file_numbers :=
			if(NOT doxie.DataRestriction.EBR,ebr_services.ebr_raw.get_file_number_from_bdids(bdids)(in_include));
			
		export record_count :=
			count(
				temp_file_numbers);
		
		export records :=
			ebr_services.ebr_raw.report_view.by_file_number(
				choosen(
					temp_file_numbers,
					in_max));
	end;
