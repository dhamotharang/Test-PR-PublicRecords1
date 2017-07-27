import Address, AID, BIPV2, SAM, Standard;

export Layouts_GSA := module		 
	
	export layout_Address := RECORD,maxlength(10000)
				string Street1						{xpath('Street1')};
				string Street2						{xpath('Street2')};
				string Street3						{xpath('Street3')};
				string City								{xpath('City')};
				string ZIP								{xpath('ZIP')};
				string Province						{xpath('Province')};
				string State							{xpath('State')};
				string Country						{xpath('Country')};
				string DUNS								{xpath('DUNS')};
				end;

	export layout_Reference	:= RECORD,maxlength(10000)	    
				string Reference					{xpath('[.]')};
				end;

	export layout_Action := RECORD,maxlength(10000)
				string ActionDate					{xpath('ActionDate')};
				string TermDate						{xpath('TermDate')};
				string TermType						{xpath('TermType')};
				string CTCode							{xpath('CTCode')};
				string AgencyComponent		{xpath('AgencyComponent')};
				string oldCTCode					{xpath('oldCTCode')};
				string oldAgencyComponent	{xpath('oldAgencyComponent')};
				string ActionStatus				{xpath('ActionStatus')};
				string EPLSCreateDate			{xpath('EPLSCreateDate')};
				string EPLSModDate				{xpath('EPLSModDate')};
				end;
				
	export layout_AgencyIdentifier := RECORD,maxlength(10000)
				string dType							{xpath('Type')};
				string dValue							{xpath('Value')};				
				end;
				
	export layout_Record := record,maxlength(10000)
				string inputName  				{xpath('Name')};
				string Prefix							{xpath('Prefix')};
				string FirstName       		{xpath('First')};
				string MiddleName         {xpath('Middle')};
				string LastName						{xpath('Last')};
				string Suffix							{xpath('Suffix')};
				string Classification			{xpath('Classification')};          
				string CTType							{xpath('CTType')}; 
				dataset (layout_Address)   Addresses 	{xpath('Addresses/Address')};
				dataset (layout_Reference) References {xpath('References/Reference')};
				dataset (layout_Action)    Actions  	{xpath('Actions/Action')};
				string Description				{xpath('Description')};
				dataset (layout_AgencyIdentifier) AgencyIdentifiers {xpath('AgencyIdentifiers/AgencyIdentifier')};
				unsigned8 gsa_id{virtual(fileposition)};
				end;
				
	export layout_Base_Old := record,maxlength(10000)
	      unsigned8 gsa_id;
				unsigned6 bdid;
				unsigned6 did;		
				string8   dt_last_seen;  //process date           
				string1 primary_aka_name;
				string Name;  							 
				string Classification;					         
				string CTType;							 				 
				string Description;				  	 				 				
				string Street1;					
				string Street2;					
				string Street3;					
				string City;					
				string ZIP;						
				string Province;				
				string State;					
				string Country;					
				string DUNS;										
				string dType;					 
				string dValue;															
				string ActionDate;				 
				string TermDate;
				string1 TermDateIndefinite;
				string1 TermDatePermanent;
				string TermType;					 
				string CTCode;					 
				string AgencyComponent;			 
				string oldCTCode;				 
				string oldAgencyComponent;		 
				string ActionStatus;				 
				string EPLSCreateDate;			 
				string EPLSModDate;		
				string5  title;
				string20 fname;
				string20 mname;
				string20 lname;
				string5  name_suffix;
				string3  name_score;
				string10 prim_range; 	 
				string2  predir;		 
				string28 prim_name;	 
				string4  addr_suffix;   
				string2  postdir;		 
				string10 unit_desig;	 
				string8  sec_range;	 
				string25 p_city_name;	 
				string25 v_city_name;   
				string2  st;			 
				string5  zip5;		 
				string4  zip4;		 
				string4  cart;		 
				string1  cr_sort_sz;	 
				string4  lot;		 
				string1  lot_order;	 
				string2  dbpc;		 
				string1  chk_digit;	 
				string2  rec_type;	 
				string5  county;		 
				string10 geo_lat;		 
				string11 geo_long;	 
				string4  msa;		 
				string7  geo_blk;		 
				string1  geo_match;	 
				string4  err_stat;	 
				end;
				
	export layout_Base := record,maxlength(10000)
				BIPV2.IDlayouts.l_xlink_ids;
	      layout_Base_Old;
				string ExclusionType;
        string SAM_number;
        string SAM_record_status;
				AID.Common.xAID	Append_RawAID;
				AID.Common.xAID	Append_ACEAID;
				UNSIGNED8	 lnpid:=0;
				end;

	export layout_Keybuild := record
				BIPV2.IDlayouts.l_xlink_ids;
	      unsigned8  gsa_id;
				unsigned6  bdid;
				unsigned6  did;		
				string8    dt_last_seen;  //process date           
				string1 	 primary_aka_name;
				string160	 Name;  							 
				string10	 Classification;					         
				string30	 CTType;							 				 
				string2200 Description;				  	 				 				
				string130  Street1;					
				string80	 Street2;					
				string10	 Street3;					
				string80	 City;					
				string11	 ZIP;						
				string25	 Province;				
				string2		 State;					
				string3		 Country;					
				string9		 DUNS;										
				string10	 dType;					 
				string10	 dValue;															
				string8		 ActionDate;				 
				string8 	 TermDate;
				string1 	 TermDateIndefinite;
				string1 	 TermDatePermanent;
				string10	 TermType;					 
				string40	 CTCode;					 
				string10	 AgencyComponent;			 
				string40	 oldCTCode;				 
				string10 	 oldAgencyComponent;		 
				string10 	 ActionStatus;				 
				string8 	 EPLSCreateDate;			 
				string8 	 EPLSModDate;		
				string5  	 title;
				string20 	 fname;
				string20 	 mname;
				string20 	 lname;
				string5  	 name_suffix;
				string3  	 name_score;
				string10 	 prim_range; 	 
				string2  	 predir;		 
				string28 	 prim_name;	 
				string4  	 addr_suffix;   
				string2  	 postdir;		 
				string10 	 unit_desig;	 
				string8  	 sec_range;	 
				string25 	 p_city_name;	 
				string25 	 v_city_name;   
				string2  	 st;			 
				string5  	 zip5;		 
				string4  	 zip4;		 
				string4  	 cart;		 
				string1  	 cr_sort_sz;	 
				string4  	 lot;		 
				string1  	 lot_order;	 
				string2  	 dbpc;		 
				string1  	 chk_digit;	 
				string2  	 rec_type;	 
				string5  	 county;		 
				string10 	 geo_lat;		 
				string11 	 geo_long;	 
				string4  	 msa;		 
				string7  	 geo_blk;		 
				string1  	 geo_match;	 
				string4  	 err_stat;	 
				string80	 ExclusionType;
        string9		 SAM_number;
        string10	 SAM_record_status;
				AID.Common.xAID	Append_RawAID;
				AID.Common.xAID	Append_ACEAID;
				end;
				
  export layout_AutoKeys_Old := record
				unsigned8 gsa_id;
				unsigned6 bdid;
				unsigned6 did;
				string100 Name;
				string5  title;
				string20 fname;
				string20 mname;
				string20 lname;
				string5  name_suffix;
				string3  name_score;
				string10 prim_range; 	 
				string2  predir;		 
				string28 prim_name;	 
				string4  addr_suffix;   
				string2  postdir;		 
				string10 unit_desig;	 
				string8  sec_range;	 
				string25 p_city_name;	 
				string25 v_city_name;   
				string2  st;			 
				string5  zip5;		 
				string4  zip4;		 
				string4  cart;		 
				string1  cr_sort_sz;	 
				string4  lot;		 
				string1  lot_order;	 
				string2  dbpc;		 
				string1  chk_digit;	 
				string2  rec_type;	 
				string5  county;		 
				string10 geo_lat;		 
				string11 geo_long;	 
				string4  msa;		 
				string7  geo_blk;		 
				string1  geo_match;	 
				string4  err_stat;	
				string1		blank 	:= '';
				unsigned6	zero 	:= 0;
				end;
				
  export layout_AutoKeys := record
				layout_AutoKeys_Old;
	end;
						
  export layout_GSA_ID := RECORD
				SAM.Layout_Bridger;
				UNSIGNED8 gsa_id := 0;
	end;		
		
  export slim_main_lo := record,maxlength(10000)
				unsigned8 gsa_id;
				string1   primary_aka_name;
				string    Name;
				string    Classification;
				string    SAM_number;
		end;
						
  export main_addrs_lo := record,maxlength(10000)
				slim_main_lo;
				string Street1;
				string Street2;
				string Street3;
				string City;
				string ZIP;
				string Province;
				string State;
				string Country;
		end;
						
  export main_addrs_info_id_lo := record,maxlength(10000)
				main_addrs_lo;
				string  ActionDate;
				string  TermDate;
				string1 TermDateIndefinite;
				string1 TermDatePermanent;
				string  TermType;
				string  CTCode;
				string  CTType;
				string  AgencyComponent;
				string  Description;
				string  DUNS;
				string  ExclusionType;
				string  SAM_record_status;
				string  oldCTCode;
				string  oldAgencyComponent;
				string  ActionStatus;
				string  EPLSCreateDate;
				string  EPLSModDate;
		end;

  export clean_gsa := record,maxlength(10000)
				unsigned8				uniqueid;		
				string1   			business_person := '';
				layout_Base;
	end;

  export slim_clean_gsa := record,maxlength(10000)
				unsigned8				uniqueid;					
				integer8  			gsa_id;			
				unsigned6 			bdid := 0;	
				unsigned6 			did := 0;
				BIPV2.IDlayouts.l_xlink_ids;	
				string 					Name;
				standard.Name.fname;
				standard.Name.mname;
				standard.Name.lname;
				standard.Name.name_suffix;
				standard.Name.name_score;				
				Address.Layout_Clean182.prim_range;
				Address.Layout_Clean182.prim_name;
				Address.Layout_Clean182.sec_range;
				Address.Layout_Clean182.p_city_name;				
				Address.Layout_Clean182.v_city_name;
				Address.Layout_Clean182.st;
				Address.Layout_Clean182.zip;
	end;
		
end;                