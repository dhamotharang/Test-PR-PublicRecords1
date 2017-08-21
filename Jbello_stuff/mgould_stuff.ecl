IMPORT address, Riskwise;

d:= Riskwise.File_CityStateZip(prefctystname='FORT LAUDERDALE');
// d:= CHOOSEN(d0,1000,5000);

 Olayout := RECORD
		 address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.rec_type
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.err_stat
	END;
	 
// Run all addresses from Riskwise.File_CityStteZip through the address cleaner and transform
Olayout tr (d l) := transform
  address1 := l.city + ', ' + l.state + ' ' + l.zip5;
	Clean_Address := address.CleanAddress182('General Delivery',address1);
	STRING5   v_zip    		:= Clean_Address[117..121];
	SELF.p_city_name 			:= Clean_Address[ 65.. 89];
	SELF.v_city_name 			:= Clean_Address[ 90..114];
	SELF.st          			:= Clean_Address[115..116];
	SELF.zip         			:= if(v_zip='00000','',v_zip);
	SELF.rec_type    			:= if(SELF.p_city_name = SELF.v_city_name,'1',' ');
	SELF.geo_lat     			:= Clean_Address[146..155];
	SELF.geo_long    			:= Clean_Address[156..166];
	SELF.err_stat    			:= Clean_Address[179..182];
	SELF := l;
END;

p0:=project(d,tr(left));

p1 := distribute(p0,hash(p_city_name,v_city_name,st,zip,rec_type,geo_lat,geo_long,err_stat[1]));
p2 := sort(p1,p_city_name,v_city_name,st,zip,rec_type,geo_lat,geo_long,-err_stat[1],local);
p := dedup(p2,p_city_name,v_city_name,st,zip,rec_type,geo_lat,geo_long,err_stat[1],local);

output(p,,'~thor400_data::out::ziplib_cityzip_lo',compressed,overwrite );