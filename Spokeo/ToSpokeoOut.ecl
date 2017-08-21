import std;
/*
Sort Order
	LexID
	-Current_address_flag
	dt_last_seen
	SpokeoId

*/
EXPORT ToSpokeoOut(DATASET(Spokeo.Layout_temp) src) := FUNCTION

	Spokeo.Layout_Out xform1(Spokeo.Layout_temp src) := TRANSFORM
		self.SpokeoID := '';
		self.name := '';
		self.addr1 := '';
		self.city := '';
		self.state := '';
		self.zipcode := '';
		self.dob := '';
		self.phone := '';
		self.LexIdIn := '';
		
		self.Best_First_Name := '';
		self.Best_Middle_Name := '';
		self.Best_Last_Name := '';
		self.Best_Name_Suffix := '';
		self.Best_Birth_YearMonth := '';
		
		self := src;
		self.deceased_flag := IF(src.deceased, 'Y', '');
		self.latitude := src.geo_lat;
		self.longitude := src.geo_long;
		self.address_status := src.err_stat;
		self.address_type := src.rec_type;
		self.cln_addr1 := Std.Str.CleanSpaces(src.prim_range+' '+src.predir+' '+
															src.prim_name+' '+src.addr_suffix+' '+src.postdir+' '+src.unit_desig+' '+src.sec_range);
		self.cln_addr2 := Std.Str.CleanSpaces(TRIM(src.p_city_name)+IF(src.p_city_name='','',', ')+src.st+' '+src.zip+
															IF(trim(src.zip4)='','','-'+src.zip4));
		
	END;

	Spokeo.Layout_Out xform(Spokeo.Layout_temp src) := TRANSFORM
		self := src;
		self.deceased_flag := IF(src.deceased, 'Y', '');
		self.latitude := src.geo_lat;
		self.longitude := src.geo_long;
		self.address_status := src.err_stat;
		self.address_type := src.rec_type;
		self.cln_addr1 := Std.Str.CleanSpaces(src.prim_range+' '+src.predir+' '+
															src.prim_name+' '+src.addr_suffix+' '+src.postdir+' '+src.unit_desig+' '+src.sec_range);
		self.cln_addr2 := Std.Str.CleanSpaces(TRIM(src.p_city_name)+IF(src.p_city_name='','',', ')+src.st+' '+src.zip+
															IF(trim(src.zip4)='','','-'+src.zip4));
															
	
	END;

	ds1 := PROJECT(src(LexId<>0,address_source='S'), xform(left));
	ds2:= PROJECT(src(LexId<>0,address_source='L'), xform1(left));
	ds3 := PROJECT(src(LexId=0), xform(left));
	
	result1 := SORT(DISTRIBUTE(ds1+ds2,LexId), LexID, -Current_address_flag, dt_last_seen, SpokeoID, LOCAL);
	
	result := result1 & SORT(ds3, SpokeoID);
	
	return result;
END;
