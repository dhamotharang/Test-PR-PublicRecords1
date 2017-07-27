export Addr2FromComponentsWithZip4(string city_name, string st, string zip, string zip4) :=
IF(city_name<>'',trim(city_name)+', ','') +
IF(st<>'',trim(st)+' ','') +
IF(zip<>'',trim(zip),'') +
IF(zip4<>'','-'+ trim(zip4),'');