import header, utilfile,address;

export map_util_canadian(dataset(utilfile.Layout_Util.base) util_daily_canadian_in) := function

header.MAC_555_phones(util_daily_canadian_in, work_phone, daily_utils_clean_workphone);
header.MAC_555_phones(daily_utils_clean_workphone, phone, daily_utils_clean_phone);

utilfile.Layout_Util_canadian_base tformat(daily_utils_clean_phone le) := transform

//clean raw address

searchpattern_can :='(.*),(.*)';

fix_leading_zero(string addr) := stringlib.stringcleanspaces(regexreplace('^[^A-Z1-9]+',addr, ''));
address_street_name_temp := fix_leading_zero(le.Address_Street_Name);

address_line1 := if(regexfind(searchpattern_can, address_street_name_temp), regexfind(searchpattern_can, address_street_name_temp, 1), '');
address_line2 := if(regexfind(searchpattern_can, address_street_name_temp), regexfind(searchpattern_can, address_street_name_temp, 2),'');
cleanaddress := Address.CleanCanadaAddress109(address_line1, address_line2);
canadian_st :=  ['ON','BC','QC','NS','NB','MB','PE','SK','AB','NL','NT','YT','NU'];
boolean is_canadian_addr := length(trim(CleanAddress[95..100],left,right)) = 6 or CleanAddress[93..94] in canadian_st;
self.prim_range 	:= if(is_canadian_addr, CleanAddress[1..10], ''); 
self.predir 		:= if(is_canadian_addr, CleanAddress[11..12],'');					   
self.prim_name 		:= if(is_canadian_addr, CleanAddress[13..40],'');
self.addr_suffix 	:= if(is_canadian_addr, CleanAddress[41..44],'');
self.unit_desig 	:= if(is_canadian_addr, CleanAddress[45..54],'');
self.sec_range 		:= if(is_canadian_addr, CleanAddress[55..62],'');
self.p_city_name 	:= if(is_canadian_addr, CleanAddress[63..92],'');
self.st			:= if(is_canadian_addr, CleanAddress[93..94],'');
self.zip			:= if(is_canadian_addr, CleanAddress[95..100],'');
self.rec_type   	:= if(is_canadian_addr, CleanAddress[101..102],'');
self.language 		:= if(is_canadian_addr, CleanAddress[103], '');
self.err_stat 		:= if(is_canadian_addr, CleanAddress[104..109],'');
self := Le;
self := [];
end;

map_canadian_addr := project(daily_utils_clean_phone,tformat(left)) ;

return map_canadian_addr;
end;
