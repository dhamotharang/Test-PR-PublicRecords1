EXPORT fn_valid_ratio(string building_area = '', string sales_price = '') := function

return if((real)building_area = 0 or (real)sales_price = 0,1,if((((real)building_area)/((real)sales_price))>=1.0,0,1));

end;