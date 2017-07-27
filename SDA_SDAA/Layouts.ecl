import address, business_header, BIPV2;

export Layouts := module

	
	export Layout_map	:= record
			unsigned8 	id			:=0;
			unsigned8 	seq			:=0;
			unsigned4 	dt_first_seen ;
			string1   	level;
			string4   	RecordID		:='';
			qstring120 	company_name;
			qstring35 	company_title;
			qstring35 	company_department;
			//string182 	clean;
			string120 	email_Address;
			string73  	clean_name;
			string10  	Company_phone;
			string10  	Company_phone1;
			string10  	Company_phone2;
			qstring34 	vendor_id;
	end;
	
	export Layout_AID := record
			string100		prep_addr_line1				:= '';
			string50		prep_addr_line_last		:= '';
			Layout_map;
	end;
	
	export Base := record
		business_header.Layout_Business_Contact_FULL_New;
		unsigned8		ace_aid								:=  0;
		string100		prep_addr_line1				:= '';
		string50		prep_addr_line_last		:= '';
		BIPV2.IDlayouts.l_xlink_ids;
	end;



		
end;