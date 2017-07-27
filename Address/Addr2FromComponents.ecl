export Addr2FromComponents(string city_name, string st, string zip) :=
IF(city_name<>'',trim(city_name)+', ','') +
IF(st<>'',trim(st)+' ','') +
IF(zip<>'',trim(zip),'');