import Business_Header,mdr;

//*************************************************************************
// Translate YellowPages to Common Business Header Format
//*************************************************************************
export fYellowPages_as_Business_Header(dataset(Layout_YellowPages_Base_V2_BIP) pYellowPages)
 :=
  function

	YellowPages_Init := pYellowPages(MDR.sourceTools.sourceisYellow_Pages(source));

	Business_Header.Layout_Business_Header_New  Translate_YellowPages_to_BHF(Layout_YellowPages_Base_V2_BIP L) := TRANSFORM
	SELF.company_name := L.business_name;
	SELF.vl_id := (STRING34)L.primary_key;
	SELF.vendor_id := (QSTRING34)((STRING34)L.primary_key);
	SELF.phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
	SELF.phone_score := IF((UNSIGNED8)L.phone10 = 0, 0, 2);  // Non-zero score if phone is not blank
	SELF.addr_suffix := L.suffix;
	SELF.city := L.v_city_name;
	SELF.state := L.st;
	SELF.zip := (UNSIGNED3)L.zip;
	SELF.zip4 := (UNSIGNED2)L.zip4;
	SELF.source := MDR.sourceTools.src_Yellow_Pages;
	SELF.dt_first_seen := (UNSIGNED4)(L.pub_date);
	SELF.dt_last_seen := (UNSIGNED4)(L.pub_date);
	SELF.dt_vendor_first_reported := (UNSIGNED4)(L.pub_date);
	SELF.dt_vendor_last_reported := (UNSIGNED4)(L.pub_date);
	SELF.current := TRUE;
	SELF := L;
	END;

	dYellowPages_As_Business_Header	:=	project(YellowPages_Init, Translate_YellowPages_to_BHF(LEFT));
	
	return dYellowPages_As_Business_Header;
  end
 ;