EXPORT files := MODULE
import ut,Data_Services;
  EXPORT xlink:=dataset(Data_Services.foreign_dataland + 'thor_data400::bipv2::xlink::allv7', BIPV2_Testing.layouts.xlink, flat);
  EXPORT xlink6:=dataset('~thor_data400::bipv2::xlink::allv6', BIPV2_Testing.layouts.xlink6, flat);
  
  EXPORT regression:=DATASET([
    {1,'122218','LEXISNEXIS RISK SOLUTIONS INC. - DAYTON','','','','Miamisburg','OH','45342','','','www.lexisnexis.com','','','','match_company_url is -2 and it should be 2'},
    {2,'123583','Sup Enterprises','','','','','CA','','','','','','','','Expecting "Superior Enterprises" but that is not returned'},
    {3,'123596','','','','','','','','','9498257000','','','','','Area code as optionl vs. extra credit'},
    {4,'123805','4 Hearts Trading Company','','','','Ft. Worth','TX','76110','','','','','','','No results, but there should be as there are when the street address is added in.'},
    {5,'123805','4 Hearts Trading Company','2100','Fairmont','','Ft. Worth','TX','76110','','','','','','','Results found'},
    {6,'124533','HERITAGE FOREST PRODUCTS INC','1990','Industrial','','Deland','FL','32724','','','','','','',''},
    {7,'124533','AVISTA PROPERTIES INC','3000','Maingate','','Kissimmee','FL','34747','','','','','','',''},
    {8,'124533','UNITED SUBCONTRACTORS, INC','895','2600','','Salt Lake City','UT','84119','','','','','','',''},
    {9,'124601','NUGENT SAND COMPANY','','PO Box 6072','','Louisville','KY','40206','','','','','','','Should have 12 watercraft records'},
    {10,'124742','BILALS INC','1816','Reed','','Philadelphia','PA','19146','','','','','','','Missing LN Fares IDs (e.g. OA0163181510,OA0163181511,OA0163181592)'},
    {11,'124742','JESCO CONSTRUCTION CORPORATION','15312','DEDEAUX','','GULFPORT','MS','39503','','','','','','','Missing LN Fares IDs (e.g. DA0074541419,DA0206412561,RA0267290715)'},
    {12,'124742','NOVAGRAPHICS CORP','8119','NW 29TH','','DORAL','FL','33122','','','','','','','Missing LN Fares IDs (e.g. RA1399402136,RA1580722716,RA1736661148)'},
    {13,'125285','NCO YOUTH & FAMILY SERVICES','1305','Oswego','','Naperville','IL','60540','','','','','','','missing vehicle_key 12480921586999737456 '},
    {14,'125285','USA LAWN & LANDSCAPING, INC.','11304','Township Road 67','','Findlay','OH','45840','','','','','','','Missing vehicle_key 18355738227963920890 '},
    {15,'125285','CREATIVE COUNTERTOP SOLUTIONS INC','300','Peabody','','Nashville','TN','37210','','','','','','','Missing vehicle key 10350192553926162240 (among others)'},
    {16,'125285','GALATI BUILDING CLEANING CO','1136','Chavaniac','','Ballwin','MO','63011','','','','','','','Missing vehicle key 10459971710085127093 (among others)'},
    {17,'125291','SUN CAPITAL','929','Clint Moore','','Boca Raton','FL','33487','','','','','','','Missing TMSID CA057051938836 '},
    {18,'125291','PACIFIC EXCHANGE MORTGAGE LENDER A CORPORATION','15456','Ventura','408','Sherman Oaks','CA','91403','','','','','','','Missing TMSID CA107252787635'},
    {19,'125291','RUGBY NORTH AMERICA, INC.','115','Morcor','','New York','NY','10012','','','','','','','Missing TMSID DNB982831919980624'},
    {20,'126689','MCSI Inc','','','','Cincinnati','OH','','','','','','','','Only seeing dayton in BIP -- prod shows E Kemper, Vine, Walnut, etc.'},
    {21,'127862','Lowes','','','','Dayton','oh','','','','','','','','getting "too may subects found"'},
    {22,'127862','Lowes','','','','West Carrolton','OH','','','','','','','','getting "too may subects found"'},
    {23,'128707','Alyeska','','','','Girdwood','AK','','30','','','','','','"Alyeska" and "Alyeska Accommodation" should get the same results'},
    {24,'128707','Alyeska Accommodation','','','','Girdwood','AK','','30','','','','','','"Alyeska" and "Alyeska Accommodation" should get the same results'},
    {25,'128742','mcdonalds','','','','centerville','oh','45458','','','','','','','Too many results.  Should show results'},
    {26,'128742','taco bell','','','','centerville','oh','45458','','','','','','','Control.  This shows correct results'},
    {27,'128742','lexisnexis','','','','miamisburg','oh','','100','','','','','','Too many results (should not be)'},
    {28,'128742','morton','','','','dayton','oh','','30','','','','','','Too many results (should not be)'},
    {29,'129752','Chesapeake Bay Opticians, Inc','3819','Harbor','104','Chesapeake Beach','MD','20732','','','','','','','Missing DUNs number 174219600'},
    {30,'129752','Dr. Regis Acosta','','Independence','','Sicklerville','NJ','8081','','','','','','','Missing DUNs number 035035473'},
    {31,'129752','Haro Electric Inc','8293','285th','','Zimmerman','MN','55398','','','','','','','Missing DUNs number 106872737'},
    {32,'129752','Siringoringo Law Firm','','9th','','Upland','CA','91786','','','','','','','Missing DUNs number 066722160'},
    {33,'120943','tomorrows seafood','','','','dallas','tx','','','','','','','','"tomorrows" and "tomorrow" should produce the same results'},
    {34,'120943','tomorrow seafood','','','','dallas','tx','','','','','','','','"tomorrows" and "tomorrow" should produce the same results'},
    {35,'120943','smith brothers\' printing','','','','','','','','','','','','','"brother" and "brothers" should produce the same results'},
    {36,'120943','smith brother printing','','','','','','','','','','','','','"brother" and "brothers" should produce the same results'},
    {37,'120943','Burrito Brothers','','','','','fl','','','','','','','','16 results.  "Brothers", "Brother", "Bro" and "bros" should all be the same'},
    {38,'120943','Burrito Brother','','','','','fl','','','','','','','','no results.  "Brothers", "Brother", "Bro" and "bros" should all be the same'},
    {39,'120943','Burrito Bros','','','','','fl','','','','','','','','3 results.  "Brothers", "Brother", "Bro" and "bros" should all be the same'},
    {40,'120943','Burrito Bro','','','','','fl','','','','','','','','no results.  "Brothers", "Brother", "Bro" and "bros" should all be the same'},
    {41,'125281','Fine Line Medical Group','5995','71st','3A','','FL','33143','','','','','','','Missing corp key 12-P02000005906'},
    {42,'125281','Sidus Investment Management LLC','767','3rd','','New York','NY','10017','','','','','','','Missing corp keys 25-00DTYN and 36-2476428'},
    {43,'125292','Tonawanda Housing Authority','200','Gibson','','Tonawanda','NY','14150','','','','','','','Missing Fares ID DM0003384119'},
    {44,'125292','Tonawanda II, LP','1600','Riverview Tower 900 SOUT','','Knoxville','TN','37902','','','','','','','Missing Fares ID RA1224455978'},
    {45,'125292','Trailco','8721','Greenwell Springs','','Baton Rouge','LA','70814','','','','','','','Missing Fares ID 149020926 '},
    {46,'125294','Jesco Construction Corporation','638','Bayou','','Belle Chasse','LA','70037','','','','','','','Missing watercraft keys 104-ADMNRK1963'},
    {47,'116416','LIQUOR SERVICES INC','16500','Hedgecroft','','','TX','','','','','','','','Memory error?'},
    {48,'116416','Elfreth Properties','3608','Richmond','','Philadelphia','PA','','','','','','','','Memory error?'},
    {49,'117515','','123','Main','','','OH','45342','','','','','','','As radius for 123 main st expands, all items in the lower radii need to exist in the higher one'},
    {50,'117515','','123','Main','','','OH','45342','5','','','','','','As radius for 123 main st expands, all items in the lower radii need to exist in the higher one'},
    {51,'117515','','123','Main','','','OH','45342','10','','','','','','As radius for 123 main st expands, all items in the lower radii need to exist in the higher one'},
    {52,'117515','','123','Main','','','OH','45342','20','','','','','','As radius for 123 main st expands, all items in the lower radii need to exist in the higher one'},
    {53,'117515','','123','Main','','','OH','45342','30','','','','','','As radius for 123 main st expands, all items in the lower radii need to exist in the higher one'},
    {54,'117775','University of Dayton','','','','Dayton','OH','','','','','','','','was getting errors'},
    {55,'117775','University of Pittsburgh','','','','Pittsburgh','PA','','','','','','','','was getting errors'},
    {56,'117775','Nature Coast Equipment LLC','13410','NW 49th','','Gainesville','FL','32606','','','','','','','was getting errors'},
    {57,'117775','Ohio State University','','','','Columbus','OH','','','','','','','','was getting errors'},
    {58,'117775','Western Michigan University','','','','Kalamazoo','MI','','','','','','','','was getting errors'},
    {59,'117775','State Farm Insurance','','','','Dayton','OH','','','','','','','','was getting errors'},
    {60,'122987','D','','','','','','','','','','','','','Was memory error.  Should be LAFN'},
    {61,'124219','AT&T','2716','US Highway 68','','Wilmington','OH','45177','','','','','','','No results coming back?'},
    {62,'129380','lexisnexis','','','','','','','','','','jim','','peck','"jim" and "James" should return the same results'},
    {63,'129380','lexisnexis','','','','','','','','','','james','','peck','"jim" and "James" should return the same results'},
    {64,'117429','St Christophers Childrens Hospital','','','','','','','','','','','','','"Christophers" with or without the apostrophe should yield the same results'},
    {65,'117429','St Christopher\'s Childrens Hospital','','','','','','','','','','','','','"Christophers" with or without the apostrophe should yield the same results'},
    {66,'117429','Mikesells','333','Leo','','Dayton','OH','','','','','','','','"mikesells" with hyphen or apostrophe should yield same results'},
    {67,'117429','Mike-sells potato chip co','333','Leo','','Dayton','OH','45404','','','','','','','"mikesells" with hyphen or apostrophe should yield same results'},
    {68,'117429','mike-sells\'s potato chip co','333','Leo','','Dayton','OH','45404','','','','','','','"mikesells" with hyphen or apostrophe should yield same results'},
    {69,'117429','IGS GPS Surveying Services Inc','607','Las Vegas','','Fort Worth','TX','76108','','','','','','','GIS GPS with or without the hyphen should yield the same results'},
    {70,'117429','IGS-GPS Surveying Services Inc','607','Las Vegas','','Fort Worth','TX','76108','','','','','','','GIS GPS with or without the hyphen should yield the same results'},
    {71,'118439','BILAL INC','1816','Reed Inc','','Philadelphia','PA','19146','','','','','','','Was too many results.    Bilal, Bilals, and the same with "inc" in the address should all return the same results'},
    {72,'118439','BILALS INC','1816','Reed Inc','','Philadelphia','PA','19146','','','','','','','Was No documents found.    Bilal, Bilals, and the same with "inc" in the address should all return the same results'},
    {73,'118439','BILALS INC','1816','Reed','','Philadelphia','PA','19146','','','','','','','Was 1 result.    Bilal, Bilals, and the same with "inc" in the address should all return the same results'},
    {74,'119389','Pizza Hut','','','','Atlanta','GA','','','','','','','','Returns correct results, where ATL does not'},
    {75,'119389','Pizza Hut','','','','ATL','GA','','','','','','','','"ATL" returns maxIDs results, none of which are in Atlanta'},
    {76,'119389','Target','','','','Pittsberg','PA','','','','','','','','Misspelled city should still yield results'},
    {77,'120887','','61251','Southgate','','Cambridge','OH','43725','','','','','','','Should return SHOUTHGATE CAFÉ like it does in prod'},
    {78,'120887','Northwestern Financial','4200','Brookshire','','Charlotte','NC','28216','','','','','','','Should return results'},
    {79,'120887','Elfreth Properties','3608','Richmond','','Philadelphia','PA','19134','','','','','','','Should return results'},
    {80,'120887','South Dayton Family Dentistry','6','Sycamore Creek','','Springboro','OH','45066','','','','','','','Should return results'},
    {81,'121346','','1000','Alderman','','Alpharetta','GA','','','','','','','',''},
    {82,'121346','Lexis','1000','Alderman','','Alpharetta','GA','','','','','','','',''},
    {83,'121346','LexisNexis','1000','Alderman','','Alpharetta','GA','','','','','','','',''},
    {84,'121701','PRICE/WILLIAMS, INCORPORATED','','','','','','','','','','','','','match should be the same with "/", "-" or " "'},
    {85,'121701','PRICE WILLIAMS, INCORPORATED','','','','','','','','','','','','','match should be the same with "/", "-" or " "'},
    {86,'121701','PRICE-WILLIAMS, INCORPORATED','','','','','','','','','','','','','match should be the same with "/", "-" or " "'},
    {87,'123656','Walmart','','','','Sidney','OH','','','','','','','','"Walmart" should match "Wal-mart" and "Wal mart"'},
    {88,'123656','Wal-mart','','','','Sidney','OH','','','','','','','','"Walmart" should match "Wal-mart" and "Wal mart"'},
    {89,'123656','Wal mart','','','','Sidney','OH','','','','','','','','"Walmart" should match "Wal-mart" and "Wal mart"'},
    {90,'123656','A-1 Janitorial Supply & Equipment, Inc','','','','Charlotte','NC','','','','','','','','"A-1" should match "A 1" and "A1" '},
    {91,'123656','A 1 Janitorial Supply & Equipment, Inc','','','','Charlotte','NC','','','','','','','','"A-1" should match "A 1" and "A1" '},
    {92,'123656','A1 Janitorial Supply & Equipment, Inc','','','','Charlotte','NC','','','','','','','','"A-1" should match "A 1" and "A1" '},
    {93,'123766','JJ Plumbing','','','','','','','','','','','','','Make sure this one matches the results for JJPlmbg'},
    {94,'123766','JJ Plmbg','','','','','','','','','','','','','Should match "JJ Plumbing"'},
    {95,'124995','Proctor and Gamble','','','','Cincinnati','OH','','100','','','','','',''},
    {96,'125191','Agro -Chem East','6522','E State Route 22 & 3','','Wilmington','OH','45177','30','','','','','',''},
    {97,'125547','El Dorado','1426','Rombach','','wilmingon','oh','45177','5','','','','','','Make sure all results are within radius'},
    {98,'125547','walmart','','','','centerville','oh','45458','5','','','','','','Make sure all results are within radius'},
    {99,'125547','dunkin donuts','','','','dayton','oh','','30','','','','','','Make sure all results are within radius'},
    {100,'125547','Edward Jones 04083','28','Locust','','Wilmington','oh','45177','30','','','','','','Make sure all results are within radius'},
    {101,'126003','BIRCH POINT LLC','5500','Glades','305','Boca Raton','fl','33431','30','','','','','',''},
    {102,'127728','carolina ale house','','','','weston','fl','','50','','','','','','weston items should be on top and are not'},
    {103,'127771','subway','','','','centerville','oh','','30','','','','','',''},
    {104,'127771','home depot','','','','dallas','tx','','30','','','','','',''},
    {105,'127771','subway','','','','dayton','oh','','30','','','','','',''},
    {106,'127771','city barbeque','','','','centerville','oh','45459','30','','','','','',''},
    {107,'129213','lexisnexis','6601','park of commerce','','boca raton','fl','','','','','','','',''},
    {108,'129213','lexisnexis','6601','park of commerce','','boca raton','fl','','30','','','','','','too many results found?'},
    {109,'129213','seisint','6601','park of commerce','','boca raton','fl','','30','','','','','',''},
    {110,'113325','Reynolds Reynolds','','','','Beavercreek','OH','','','','','','','','Both Reynolds examples should yield the same results'},
    {111,'113325','The Reynolds and Reynolds Company Inc','','','','Beavercreek','OH','','','','','','','','Both Reynolds examples should yield the same results'},
    {112,'114145','R.C.I. Corporation','','','','','','','','','','','','','Was getting no hits (batch)'},
    {113,'114148','OCE Printing Systems USA, IRE','','','','','','','','','','','','','Was getting no hits (batch)'},
    {114,'114658','Aucamp Dellenbeck & Whitney','','','','Boca Raton','FL','','','','','','','','Was getting no hits'},
    {115,'114658','H & H Plumbing','','','','Boca Raton','FL','','','','','','','','Was getting no hits'},
    {116,'114658','Realty','','','','Boca Raton','FL','','','','','','','','Was only getting 15 hits (seems light)'},
    {117,'114658','Admiral Plumbing','','','','Boca Raton','FL','','','','','','','','Was getting no hits'},
    {118,'114658','Empire Office Furniture','','','','Boca Raton','FL','','','','','','','','Was getting no hits'},
    {119,'114658','Funky Buddha Lounge','','','','Boca Raton','FL','','','','','','','','Was getting no hits'},
    {120,'114658','Chops Lobster Bar','','','','Boca Raton','FL','','','','','','','','Was getting no hits'},
    {121,'114658','Funky','2621','Federal','','Boca Raton','FL','33431','','','','','','','Was getting no hits'},
    {122,'114658','Admiral Plumbing','160','Camino Real','','Boca Raton','FL','33432','','','','','','','Was getting no hits'},
    {123,'114933','AAA','','','','Dayton','OH','','','','','','','','Returned records from Florida'},
    {124,'114933','AAA Club','','','','Dayton','OH','','','','','','','','Returns accurate results'},
    {125,'116325','James Morton','','','','Waco','TX','76710','','','','','','','Results too loose'},
    {126,'116792','James Morton','1215','Lake Air','','','','76710','','','','','','','Results are accurate'},
    {127,'116792','','1215','Lake Air','','','','76710','','','','','','','Just address gets no results, but it is a small building'},
    {128,'117164','West Texas University','','','','Amarillo','TX','79109','','','','','','','connection closed errors on legacy'},
    {129,'117164','North Texas State University','','','','Denton','TX','76203','','','','','','','connection closed errors on legacy'},
    {130,'117164','Circle B Enterprise Inc','305','3rd','','Ocilla','GA','31774','','','','','','','connection closed errors on legacy'},
    {131,'117164','Pennsylvania State University','','','','Happy Valley','PA','','','','','','','',''},
    {132,'117810','MCI, Inc.','515','amite','','Jackson','MS','39201','','','','','','',''},
    {133,'123138','2476 Arthur Avenue Bar, Corp','','','','Bronx','NY','','','','','','','','assert failure'},
    {134,'123138','Wells Fargo Bank, N.A.','','Montgomery','','San Francisco','CA','','','','','','','','failed to get response'},
    {135,'123138','NBC Television','','','','New York','NY','','','','','','','','failed to get response'},
    {136,'123138','ABC Television','','','','New York','NY','','','','','','','','failed to get response'},
    {137,'123991','&1','50','69th','','Upper Darby','PA','19082','','','','','','',''},
    {138,'123991','----','1919','Highland','B','Lombard','IL','60148','','','','','','',''},
    {139,'126198','#','724','Spring','10','','CA','90014','','','','','','',''},
    {140,'0','trucks trailers sales devices','','','','boca raton','fl','','','','','','','',''},
    {141,'0','trucks trailers sales devices','','','','boca raton','fl','','30','','','','','',''}
  ],{UNSIGNED uniqueid;STRING bug;STRING company_name;STRING prim_range;STRING prim_name;STRING sec_range;STRING city;STRING st;STRING zip;STRING zip_radius;STRING company_phone;STRING company_url;STRING fname;STRING mname;STRING lname;STRING notes});

	//SEARCHES FROM INQUIRIES FILE, 2011
	//INQ
	mbslayout := RECORD
		 string company_id;
		 string global_company_id;
		END;

	allowlayout := RECORD
		 unsigned8 allowflags;
		END;

	businfolayout := RECORD
		 string primary_market_code;
		 string secondary_market_code;
		 string industry_1_code;
		 string industry_2_code;
		 string sub_market;
		 string vertical;
		 string use;
		 string industry;
		END;

	persondatalayout := RECORD
		 string full_name;
		 string first_name;
		 string middle_name;
		 string last_name;
		 string address;
		 string city;
		 string state;
		 string zip;
		 string personal_phone;
		 string work_phone;
		 string dob;
		 string dl;
		 string dl_st;
		 string email_address;
		 string ssn;
		 string linkid;
		 string ipaddr;
		 string5 title;
		 string20 fname;
		 string20 mname;
		 string20 lname;
		 string5 name_suffix;
		 string10 prim_range;
		 string2 predir;
		 string28 prim_name;
		 string4 addr_suffix;
		 string2 postdir;
		 string10 unit_desig;
		 string8 sec_range;
		 string25 v_city_name;
		 string2 st;
		 string5 zip5;
		 string4 zip4;
		 string2 addr_rec_type;
		 string2 fips_state;
		 string3 fips_county;
		 string10 geo_lat;
		 string11 geo_long;
		 string4 cbsa;
		 string7 geo_blk;
		 string1 geo_match;
		 string4 err_stat;
		 string appended_ssn;
		 unsigned6 appended_adl;
		END;

	busdatalayout := RECORD
		 string cname;
		 string address;
		 string city;
		 string state;
		 string zip;
		 string company_phone;
		 string ein;
		 string charter_number;
		 string ucc_number;
		 string domain_name;
		 string10 prim_range;
		 string2 predir;
		 string28 prim_name;
		 string4 addr_suffix;
		 string2 postdir;
		 string10 unit_desig;
		 string8 sec_range;
		 string25 v_city_name;
		 string2 st;
		 string5 zip5;
		 string4 zip4;
		 string2 addr_rec_type;
		 string2 fips_state;
		 string3 fips_county;
		 string10 geo_lat;
		 string11 geo_long;
		 string4 cbsa;
		 string7 geo_blk;
		 string1 geo_match;
		 string4 err_stat;
		 unsigned6 appended_bdid;
		 string appended_ein;
		END;

	bususerdatalayout := RECORD
		 string first_name;
		 string middle_name;
		 string last_name;
		 string address;
		 string city;
		 string state;
		 string zip;
		 string personal_phone;
		 string dob;
		 string dl;
		 string dl_st;
		 string ssn;
		 string5 title;
		 string20 fname;
		 string20 mname;
		 string20 lname;
		 string5 name_suffix;
		 string10 prim_range;
		 string2 predir;
		 string28 prim_name;
		 string4 addr_suffix;
		 string2 postdir;
		 string10 unit_desig;
		 string8 sec_range;
		 string25 v_city_name;
		 string2 st;
		 string5 zip5;
		 string4 zip4;
		 string2 addr_rec_type;
		 string2 fips_state;
		 string3 fips_county;
		 string10 geo_lat;
		 string11 geo_long;
		 string4 cbsa;
		 string7 geo_blk;
		 string1 geo_match;
		 string4 err_stat;
		 string appended_ssn;
		 unsigned6 appended_adl;
		END;

	permissablelayout := RECORD
		 string glb_purpose;
		 string dppa_purpose;
		 string fcra_purpose;
		END;

	searchlayout := RECORD
		 string datetime;
		 string start_monitor;
		 string stop_monitor;
		 string login_history_id;
		 string transaction_id;
		 string sequence_number;
		 string method;
		 string product_code;
		 string transaction_type;
		 string function_description;
		 string ipaddr;
		END;

	r := RECORD
		mbslayout mbs;
		allowlayout allow_flags;
		businfolayout bus_intel;
		persondatalayout person_q;
		busdatalayout bus_q;
		bususerdatalayout bususer_q;
		permissablelayout permissions;
		searchlayout search_info;
		string source;
	 END;


	// bi := dataset(ut.foreign_prod + 'thor400_20::out::inquiry_acclogs::business_search_20121230', r, thor);
	bi :=dataset(Data_Services.foreign_prod + 'thor400_20::out::inquiry_acclogs::business_search_2012', r, thor);
	
	export INQ := 
		project(
			bi(
				bus_q.cname <> '' or bus_q.company_phone <> '' or bus_q.ein <> '' //any of these
				or ((bus_q.city <> '' or bus_q.zip <> '') and (bus_q.prim_range <> '' or bus_q.prim_name <> '')) //or some kind of locale and street info
			),
			transform(
				{busdatalayout, r},
				self := left.bus_q, //this just to make the fields i am looking for more obvious and readable
				self := left
			)
		);

END;