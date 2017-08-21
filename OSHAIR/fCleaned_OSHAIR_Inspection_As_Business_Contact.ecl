IMPORT Business_Header, ut;

export fCleaned_OSHAIR_Inspection_As_Business_Contact(dataset(Layout_OSHAIR_Inspection_Base) pOSIBase)
 :=
  function

	Layout_Cleaned_OSI_Base := OSHAIR.Layout_OSHAIR_Inspection_Base;

	Cleaned_OSI_Base := pOSIBase;

	Business_Header.Layout_Business_Contact_Full_New Translate_To_BCF(Layout_Cleaned_OSI_Base l) := transform
	  self.source           := 'SO';
		self.vl_id            := (string34)l.activity_number;
	  self.vendor_id        := (qstring34)l.activity_number; 
	  self.dt_first_seen    := 0;
	  self.dt_last_seen     := 0;
	  self.prim_range       := l.prim_range;
	  self.predir           := l.predir;
	  self.prim_name        := l.prim_name;
	  self.addr_suffix      := l.addr_suffix;
	  self.postdir          := l.postdir;
	  self.unit_desig       := l.unit_desig;
	  self.sec_range        := l.sec_range;
	  self.city             := l.v_city_name;
	  self.state            := l.st;
	  self.zip              := (unsigned3)l.zip5;
	  self.zip4             := (unsigned3)l.zip4;
	  self.county           := l.fips_county;
	  self.geo_lat          := l.geo_lat;
	  self.geo_long         := l.geo_long;
	  self.ssn              := 0;
	  self.company_title        := l.own_type_desc;
	  self.company_name         := l.cname;
	  self.company_source_group := (qstring34)l.activity_number;
	  
	  self.company_prim_range   := l.prim_range;
	  self.company_predir       := l.predir;
	  self.company_prim_name    := l.prim_name;
	  self.company_addr_suffix  := l.addr_suffix;
	  self.company_postdir      := l.postdir;
	  self.company_unit_desig   := l.unit_desig;
	  self.company_sec_range    := l.sec_range;
	  self.company_city         := l.v_city_name;
	  self.company_state        := l.st;
	  self.company_zip          := (unsigned3)l.zip5;
	  self.company_zip4         := (unsigned3)l.zip4;
	  self.company_fein         := 0;
	  self.record_type          := 'C';
	  self                      := l;
	  self                      := [];
	end; 


	Cleaned_OSI_Contact_BH := PROJECT(Cleaned_OSI_Base,
									  Translate_To_BCF(left));

	Cleaned_OSI_Contact_BH_Init := Cleaned_OSI_Contact_BH( company_name <> '');

	/*Cleaned_OSI_Contact_BH_Init_Filtered :=	Cleaned_OSI_Contact_BH_Init((integer)name_score < 3,
																		  Business_Header.CheckPersonName(fname, mname,lname,name_suffix)
																					 );*/

	return Cleaned_OSI_Contact_BH_Init; 
	
 end;
