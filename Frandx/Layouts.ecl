import Address, BIPV2;

export Layouts := module

	//shared max_size := _Dataset().max_record_size;

	export Input := module//, maxlength(max_size)
			export Sprayed_old := record
				string DOCID;
				string FRANCHISOR_NAME;
				string DBA_NAME;
				string FULL_NAME;
				string FRANCHISEE_COMPANY;
				string ADDRESS1;
				string ADDRESS2;
				string CITY;
				string STATE;
				string ZIPCODE;
				string PHONE;
				string FAX;
				string TYPE;
				string INDUSTRY;
				string SUB_INDUSTRY;
			end;
			
			export Sprayed := record
				string Franchisee_Id;
				string Fruns;
				string Brand_Name;
				string Company_Name;
				string Exec_Full_Name;
				string Address1;
				string Address2;
				string City;
				string State;
				string Zip_Code;
				string Zip_Code4;
				string Phone;
				string Phone_Extension;
				string Secondary_Phone;
				string Unit_Flag;
				string Relationship_Code;
				string F_Units;
				string Website_Url;
				string Email;
				string Industry;
				string Sector;
				string Industry_Type;
				string Sic_Code;
				string Frn_Start_Date;
				string Record_Id;
			end;
			
			export Sprayed_Fixed := record
				//UNSIGNED3 franchisee_id;
				STRING6 	franchisee_id;
				STRING60 	brand_name;
				//UNSIGNED3 fruns;
				STRING6 	fruns;
				STRING60 	company_name;
				STRING56 	exec_full_name;
				STRING50 	address1;
				STRING50 	address2;
				STRING25 	city;
				STRING2 	state;
				//UNSIGNED3 zip_code;
				//UNSIGNED2 zip_code4;
				STRING5		zip_code;
				STRING4		zip_code4;
				//UNSIGNED5 phone;
				//UNSIGNED2 phone_extension;
				//UNSIGNED5 secondary_phone;
				STRING10	phone;				
				STRING4		phone_extension;				
				STRING10	secondary_phone;
				STRING1 	unit_flag;
				STRING2 	relationship_code;
				//UNSIGNED2 f_units;
				STRING4 	f_units;
				STRING43 	website_url;
				STRING45 	email;
				STRING30 	industry;
				STRING33 	sector;
				STRING8 	industry_type;
				//UNSIGNED2 sic_code;
				//UNSIGNED4 frn_start_date;
				//UNSIGNED3 record_id;
				STRING4 	sic_code;
				STRING8 	frn_start_date;
				STRING6 	record_id;
			end;

	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;		
		unsigned6												did													:= 0;
		unsigned1												did_score										:= 0;
		unsigned4 											dt_first_seen								:= 0;
		unsigned4 											dt_last_seen								:= 0;
		unsigned4 											dt_vendor_first_reported		:= 0;
		unsigned4 											dt_vendor_last_reported			:= 0;
		string1													record_type									:='';
					
		string													Franchisee_Id;
		string													Brand_Name;
		string													Fruns;
		string													Company_Name;
		string													Exec_Full_Name;
		string													Address1;
		string													Address2;
		string													City;
		string													State;
		string													Zip_Code;
		string													Zip_Code4;
		string													Phone;
		string													Phone_Extension;
		string													Secondary_Phone;
		string													Unit_Flag;
		string													Relationship_Code;
		string													F_Units;
		string													Website_Url;
		string													Email;
		string													Industry;
		string													Sector;
		string													Industry_Type;
		string													Sic_Code;
		string													Frn_Start_Date;
		string													Record_Id;
		string20												Unit_Flag_Exp					 			:='';
		string20												Relationship_Code_Exp				:='';
		string10												clean_phone									:='';
		string10												clean_secondary_phone			 	:='';
		Address.Layout_Clean_Name					 															;
		Address.Layout_Clean182_fips       															;
		unsigned8												raw_aid											:= 0;
		unsigned8												ace_aid										 	:= 0;
		string100												prep_addr_line1						 	:='';
		string50												prep_addr_line_last				 	:='';
		unsigned8												source_rec_id								:= 0;
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layouts
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=
	record
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score							:= 0;
		unsigned6														did											:= 0;
		unsigned1														did_score								:= 0;
		unsigned4 													dt_first_seen								;
		unsigned4 													dt_last_seen								;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		string1															record_type									;
		input.Sprayed_Fixed																							;
		string20														Unit_Flag_Exp					 	:='';
		string20														Relationship_Code_Exp	 	:='';
		string10 														clean_phone						 	:='';
		string10 														clean_secondary_phone	 	:='';
		Address.Layout_Clean_Name																				;
		Address.Layout_Clean182_fips		    														;
		unsigned8							    					raw_aid									:= 0;
		unsigned8							    					ace_aid									:= 0;
		string100														prep_addr_line1					:='';
		string50														prep_addr_line_last			:='';
		unsigned8														source_rec_id						:= 0;
	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary := module
	
		export StandardizeInput :=
	  record
			unsigned8		unique_id		 				;
			//string100 	address1		;
			//string50		address2		;
			base 					 					 				;
	  end;
		
	  export DidSlim := 
	  record
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix		  ;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range			 	;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BdidSlim := 
	  record
			unsigned8		unique_id					;
			string100 	brand_name				;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string25 		p_City_name				;   		// City
			string2			state		 					;
			string10		phone		  		    ;
			string			Website_Url				;				// Url
			string			Email							;				// Email
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			BIPV2.IDlayouts.l_xlink_ids		;
	  end;
		
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base									;
		end;
	end;


	
end;