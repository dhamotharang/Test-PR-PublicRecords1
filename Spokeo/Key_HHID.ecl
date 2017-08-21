import	std;
lfn := '~thor::spokeo::processed::201701';
//lfn := '~thor::spokeo::out::processed::201701a';
//tmp := dataset(lfn, Spokeo.Layout_Temp, thor);
tmp := Spokeo.File_Processed;

r1 := RECORD
		unsigned8			hhid;
		unsigned6			LexId;
		string3				score;
		string50			name;
		string50			cln_name;
		string60			addr1;
		string40			addr2;
		string60			cln_addr1;
		string40			cln_addr2;
		string1				address_source;
		string1				current_address_flag;
		string1				confirmed_address_flag;
		string1				better_address_flag;
		unsigned3 		dt_first_seen;
		unsigned3 		dt_last_seen;
		string4				err_stat;
		string2				rec_type;
		boolean				deceased;
		string10			phone;
		string8				dob;
		string10      geo_lat;
		string11      geo_long;
		string64			SpokeoID;
END;

ds := PROJECT(tmp(hhid<>0), TRANSFORM(r1,
					self.score := left.lexid_score;
					self.name := left.prepped_name;
					self.cln_name := Std.Str.CleanSpaces(left.fname+' '+left.mname+' '+left.lname+' '+left.name_suffix);
					self.addr1 := left.prepped_addr1;
					self.addr2 := left.prepped_addr2;
					self.cln_addr1 := Std.Str.CleanSpaces(left.prim_range+' '+left.predir+' '+
																		left.prim_name+' '+left.addr_suffix+' '+left.postdir+' '+left.unit_desig+' '+left.sec_range);
					self.cln_addr2 := Std.Str.CleanSpaces(TRIM(left.p_city_name)+IF(left.p_city_name='','',', ')+left.st+' '+left.zip+
																		IF(trim(left.zip4)='','','-'+left.zip4));
					self := left;));

EXPORT Key_HHID := index(ds,
                             {hhid},{ds},
                             '~thor::spokeo::key::hhid');
