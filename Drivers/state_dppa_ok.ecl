import codes,ut;

export state_dppa_ok(string2 st,unsigned1 d,string2 header_source='', string2 vehicleOrBusiness_source='') := 
FUNCTION

return ut.PermissionTools .dppa.state_ok(st,d,header_source,vehicleOrBusiness_source);

END;														


/*

   NOT (d=1 and st IN ['CT','NH','NM','OR']) and
   NOT (d=2 and st IN ['CT','OK','OR']) and
   NOT (d=3 and st IN ['NH','NV','NM','TX','OR']) and
   NOT (d=4 and st IN ['CT','NM','ND','WV','OR']) and
   NOT (d=5 and st IN ['CT','KY','MT','NV','OK','OR']) and
   NOT (d=6 and st IN ['ID','NH','OR']) and
   NOT (d=7 and st IN ['AK','CT','IL','MD','MA','MI','NE','NH','NV','NM','SC','UT','WY','OR']);
*/