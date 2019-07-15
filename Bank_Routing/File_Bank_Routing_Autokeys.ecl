IMPORT Bank_Routing,Data_Services;

file_in := Bank_Routing.Files.base(seleid != 0);

BRTN_Key_Layout := RECORD
 Bank_Routing.layouts.base;
 STRING10  TELEPHONE;
 UNSIGNED1 zero := 0;
 STRING1   blank := '';
END;

brtn_base := PROJECT(file_in, TRANSFORM(BRTN_Key_Layout,
 SELF.TELEPHONE:=LEFT.phone_number_area_code+LEFT.phone_number,
 SELF:=LEFT));

EXPORT File_Bank_Routing_Autokeys := brtn_Base;