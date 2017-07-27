IMPORT Business_Header;

//*************************************************************************
// Translate YellowPages to Common Business Header Format
//*************************************************************************

YellowPages_Init := File_YellowPages_Base(source='Y');

Business_Header.Layout_Business_Header  Translate_YellowPages_to_BHF(Layout_YellowPages_Base L) := TRANSFORM
SELF.company_name := L.business_name;
SELF.vendor_id := (QSTRING34)((STRING34)L.primary_key);
SELF.phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
SELF.phone_score := IF((UNSIGNED8)L.phone10 = 0, 0, 2);  // Non-zero score if phone is not blank
SELF.addr_suffix := L.suffix;
SELF.city := L.p_city_name;
SELF.state := L.st;
SELF.zip := (UNSIGNED3)L.zip;
SELF.zip4 := (UNSIGNED2)L.zip4;
SELF.source := 'Y';
SELF.dt_first_seen := (UNSIGNED4)(L.pub_date[3..6]+L.pub_date[1..2]+'00');
SELF.dt_last_seen := (UNSIGNED4)(L.pub_date[3..6]+L.pub_date[1..2]+'00');
SELF.dt_vendor_first_reported := (UNSIGNED4)(L.pub_date[3..6]+L.pub_date[1..2]+'00');
SELF.dt_vendor_last_reported := (UNSIGNED4)(L.pub_date[3..6]+L.pub_date[1..2]+'00');
SELF.current := TRUE;
SELF := L;
END;

EXPORT YellowPages_As_Business_Header := PROJECT(YellowPages_Init, Translate_YellowPages_to_BHF(LEFT));