/***

Manage domestic violence shelters
The followint processes are required

Spray		-- spray csv file of shelters (this is updated on an ad hoc basis)
Build	  -- build the file of shelters
Filter  -- filter records with the address of a shelter

***/
import Mdr, Std, _Control, address;
srcdir := '/data/projects/domesticviolence/';
filename := 'adminoffices.csv';

ip := _control.IPAddress.bctlpedata12;

destinationgroup := IF(_Control.ThisEnvironment.Name = 'Dataland', 'thor400_dev01','thor400_44');

lfnOffices := '~thor::in::domesticviolence::adminoffices.csv';
lfnShelters := '~thor::in::domesticviolence::adminoffices_cln';

rOffices := RECORD
	string80		name;
	string50		rawaddr1;
	string35		city;
	string2			state;
	string5			zipcode;
	string15		phone;
	string15		fax;
END;

rShelters := RECORD
		rOffices;
		string60	addr1;
		string60	addr2;
		address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,address.Layout_Clean182.county
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat;
END;

			offices := DISTRIBUTE(DATASET(lfnOffices, rOffices, CSV(HEADING(1)))(name<>''));
			cleanShelters := PROJECT(offices, TRANSFORM(rShelters,
					self.addr1 := Std.Str.ToUpperCase(left.rawaddr1);
					csz := Std.Str.ToUpperCase(TRIM(left.city)) + IF(left.city=' ','',', ') + left.state + ' ' + left.zipcode; 
					self.addr2 := Std.Str.CleanSpaces(csz);
					self := left;
					Clean_Address := address.CleanAddress182(self.addr1, self.addr2);
					STRING28  v_prim_name 		:= Clean_Address[13..40];
					STRING5   v_zip       		:= Clean_Address[117..121];
					STRING4   v_zip4      		:= Clean_Address[122..125];
					SELF.prim_range  			:= Clean_Address[ 1..  10];
					SELF.predir      			:= Clean_Address[ 11.. 12];
					SELF.prim_name   			:= v_prim_name;
					SELF.addr_suffix 			:= Clean_Address[ 41.. 44];
					SELF.postdir     			:= Clean_Address[ 45.. 46];
					SELF.unit_desig  			:= Clean_Address[ 47.. 56];
					SELF.sec_range   			:= Clean_Address[ 57.. 64];
					SELF.p_city_name 			:= Clean_Address[ 65.. 89];
					SELF.v_city_name 			:= Clean_Address[ 90..114];
					SELF.st          			:= Clean_Address[115..116];
					SELF.zip         			:= if(v_zip='00000','',v_zip);
					SELF.zip4       	 		:= if(v_zip4='0000','',v_zip4);
					SELF.cart        			:= Clean_Address[126..129];
					SELF.cr_sort_sz  			:= Clean_Address[130..130];
					SELF.lot         			:= Clean_Address[131..134];
					SELF.lot_order   			:= Clean_Address[135..135];
					SELF.dbpc        			:= Clean_Address[136..137];
					SELF.chk_digit   			:= Clean_Address[138..138];
					SELF.rec_type    			:= Clean_Address[139..140];
					SELF.county			 			:= Clean_Address[141..145];
					SELF.geo_lat     			:= Clean_Address[146..155];
					SELF.geo_long    			:= Clean_Address[156..166];
					SELF.msa         			:= Clean_Address[167..170];
					SELF.geo_blk     			:= Clean_Address[171..177];
					SELF.geo_match   			:= Clean_Address[178..178];
					SELF.err_stat    			:= Clean_Address[179..182];
				));	
				
rHeader := RECORD
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
	//CCPA-17 new fields for CCPA
	 unsigned4 global_sid:=0;
  unsigned8 record_sid:=0;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;				



EXPORT DomesticViolence := MODULE

	export Filter(dataset(rHeader) hdrin) := FUNCTION
		addresses := DISTRIBUTE(DATASET(lfnShelters, rShelters, THOR)(err_stat[1]='S'), 
									HASH32(zip, st, predir, prim_name, prim_range, sec_range));
		hdr := DISTRIBUTE(hdrin, HASH32(zip, st, predir, prim_name, prim_range, sec_range));
		unfiltered := JOIN(hdr, addresses, left.zip=right.zip AND left.st=right.st AND left.predir=right.predir AND left.prim_name=right.prim_name
															and left.prim_range=right.prim_range AND left.sec_range=right.sec_range,
										TRANSFORM(recordof(hdr), self := left;), LEFT ONLY, LOCAL, LOOKUP);
		addGlobalSID := mdr.macGetGlobalSID(unfiltered,'Infutor','','global_sid'); //DF-26401: Populate Global_SID Field
		return addGlobalSID;
	END;
				
	export Shelters := dataset(lfnShelters, rShelters, thor);
				
	export BuildShelters := OUTPUT(cleanShelters,,lfnShelters, COMPRESSED, OVERWRITE);


	export sprayOffices := 
		Std.File.SprayVariable(ip,
							srcdir + filename,
							512,',',,,
							destinationgroup,
							lfnOffices,
							,,,true,false,true
						);


END;