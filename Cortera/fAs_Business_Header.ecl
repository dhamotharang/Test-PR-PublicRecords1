import Business_Header, MDR;
EXPORT fAs_Business_Header(dataset(Cortera.Layout_Header_Out) hdr) := FUNCTION

	Business_Header.Layout_Business_Header_New xBiz(Cortera.Layout_Header_Out hdr) := TRANSFORM

		self.source := Mdr.sourceTools.src_Cortera;
		self.current := true;
		SELF.dt_first_seen						:= hdr.dt_first_seen;
		SELF.dt_last_seen							:= hdr.dt_last_seen;
		SELF.dt_vendor_first_reported := hdr.dt_first_seen;
		SELF.dt_vendor_last_reported	:= hdr.dt_last_seen;
		
		self.company_name	:= hdr.name;
		
		SELF.zip											:= (UNSIGNED3)hdr.zip;
		SELF.zip4											:= (UNSIGNED2)hdr.zip4;
		SELF.addr_suffix							:= hdr.addr_suffix;
		SELF.city											:= hdr.v_city_name;
		SELF.state										:= hdr.st;
		SELF.county										:= hdr.county[3..5];
		
		self.fein := (unsigned4)	hdr.fein;
		SELF.phone	:= (unsigned6)hdr.clean_phone;
		self.phone_score := IF(hdr.clean_phone = '', 0, 1);
		self := hdr;
	END;

	biz := PROJECT(hdr, xBiz(Left));
	
	return biz;

END;