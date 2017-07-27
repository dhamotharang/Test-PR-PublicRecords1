
IMPORT doxie, Autokey_batch, BatchServices;

ds_sample :=
	DATASET(
		// [
			// acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did, bdid
			// {'1','AGUIRRE','','','','','GIBSON TRUCK','','','','','','','',1626526759,0},
			// {'3','','','','','','GIBSON TRUCK','','','','','','','',0,2632761}
		// ]
		[{'2','','747 4th St Ste 201','33139','Miami Beach','FL','Total Support Inc','','','','','','','',0,1000763984},
		{'3','','714 W Jefferson Blvd','75208','Dallas','TX','Carmen Floral Shop','','','','','','','',0,70299813},
		{'4','','501 E Franklin St Ste 724','23219','Richmond','VA','Bran Core Technologies Inc','','','','','','','',0,1013182076},
		{'5','','501 E Franklin St Ste 724','23219','Richmond','VA','Brancore Technologies Inc','','','','','','','',0,14665223},
		{'6','','475 E Rivera Ave Ste 18','92231','Calexico','CA','All American Distributing Co Inc','','','','','','','',0,103002366},
		{'7','','317 W Main St','88210','Artesia','NM','Karla Discoteca','','','','','','','',0,132148073},
		{'8','','2551 Mallard Ln','75006','Carrollton','TX','Serenity Forever','','','','','','','',0,72125034},
		{'9','','1200 NW Garden Valley Blv','97471','Roseburg','OR','Tequilas Family Restraunt','','','','','','','',0,145098928},
		{'10','','103 E 4th St','65459','Dixon','MO','Dolgencorp Inc','','','','','','','',0,134611588},
		{'11','','3957 Lord Byron Cir','78664','Round Rock','TX','Preferred Staffing Solutions','','','','','','','',0,88635467},
		{'12','','7432 Charlotte St','64131','Kansas City','MO','Taliaferro Consulting Group','','','','','','','',0,109032406},
		{'13','','25630 Andover Dr','48125','Dearborn Heights','MI','Dolores Cassar','','','','','','','',0,45539648},
		{'14','','','77242','Houston','TX','Cindy Chao','','','','','','','',0,131867600},
		{'15','','652 Oakwood Ave','61101','West Hartford','CT','Industrial Spraying Inc','','','','','','','',0,3945661},
		{'16','','360 Cowden Rd','95023','Hollister','CA','Mannys Tractor & Gardening SE','','','','','','','',0,130467020},
		{'17','','20940 Frederick Rd Ste A','20876','Germantown','MD','Carpet N Things Inc.','','','','','','',0,19305605},
		{'18','','417 Douglas Pike','29172','Smithfield','RI','Putnam Holdings Inc','','','','','','','',0,9923842},
		{'19','','91 Hartford Ave','29093','Providence','RI','Parisi Tool Corporation','','','','','','','',0,26511300},
		{'20','','196 Lexington Rd','11967','Shirley','NY','Tata Taping Corp','','','','','','','',0,7405064},
		{'21','','10 W 46th St FL 5','10036','New York','NY','Suna Bros Inc','','','','','','','',0,4599956},
		{'22','','231 Market Pl Ste 318','94583','San Ramon','CA','Bariki Corporation','','','','','','','',0,687437485},
		{'23','','1230 Highway 28','45150','Milford','OH','Certified Carpet Outlet Inc','','','','','','','',0,54002594},
		{'24','','3001 Halton Dr','95350','Modesto','CA','Rangel Olmedo Inc','','','','','','','',0,986898927},
		{'25','','87 Beaver Brook Rd','68106','Danbury','CT','Danbury Plastics Inc.','','','','','','','',0,911821},
		{'26','','135 Bell Dr','31513','Baxley','GA','Russells Florist','','','','','','','',0,37003901},
		{'27','','44 17th Ave NW','55901','Rochester','MN','Miracle Nails','','','','','','','',0,108531758},
		{'28','','906 Ne 122nd Ave','97230','Portland','OR','4 Seasons Hair & Nails','','','','','','','',0,141139488},
		{'29','','2222 Southmore Ave Ste H','77502','Pasadena','TX','Time Pipe & Tobacco','','','','','','','',0,94518673},
		{'30','','956 E Little Creek Rd','23518','Norfolk','VA','Fair Price Variety Shop LLC','','','','','','','',0,22284844},
		{'31','','176 Madison Ave FL 3','10016','New York','NY','Randolph Rand Corp of New York','','','','','','','',0,411854},
		{'32','','8227 Woodman Ave','91402','Panorama City','CA','New Century Pharmacy','','','','','','','',0,107096290},
		{'33','','97 Cove St','27442','New Bedford','MA','Mates Inc','','','','','','','',0,39794404},
		{'34','','3214 High St','23707','Portsmouth','VA','M S P Tailoring','','','','','','','',0,39672150},
		{'35','','3214 High St','23707','Portsmouth','VA','M S P Tailoring','','','','','','','',0,39672150},
		{'36','','29 S Route 9w','10993','West Haverstraw','NY','Nail Tek Inc','','','','','','','',0,38671279},
		{'37','','3701 N Central Ave','33603','Tampa','FL','Susans Meat Market Inc','','','','','','','',0,23324463},
		{'38','','579 Fairview Ave','70221','Fairview','NJ','Mike Santos Iron Works Corp','','','','','','','',0,15909702},
		{'39','','16139 Cantlay St','91406','Van Nuys','CA','Porcelain Treasures Inc','','','','','','','',0,104501115},
		{'40','','350 Hudson Rd','30224','Griffin','GA','Harbor Linen LLC','','','','','','','',0,759805629},
		{'41','','10120 Epsilon Rd','23235','Richmond','VA','Harry & Denise Duncan','','','','','','','',0,150974514},
		{'42','','1001 S Marshall St','27101','Winston Salem','NC','Hymes Appraisal & Realty Group LLC','','','','','','','',0,2634595},
		{'43','','956 Reeves Ave','81054','Camden','NJ','Prompt Printing Press Inc','','','','','','','',0,1948712},
		{'44','','20 Amherst Dr','62702','Springfield','IL','P & T Technologies','','','','','','','',0,89111609},
		{'45','','1 Reuten Dr','76242','Closter','NJ','American Key Products Inc','','','','','','','',0,10437796},
		{'46','','20 Covington Dr','85205','Hightstown','NJ','Unlimited Cleaning','','','','','','','',0,106739864},
		{'47','','11200 Harry Hines Blvd','75229','Dallas','TX','Roy Lafuente','','','','','','','',0,121433659},
		{'48','','916 Majestic Oak St','89145','Las Vegas','NV','JRL LLC','','','','','','','',0,1955547030},
		{'49','','15380 SE 140th Avenue Rd','32195','Weirsdale','FL','Judy Saunders','','','','','','','',0,23440945},
		{'50','','4120 Hampshire St','75093','Plano','TX','Valley Plaza Car Wash','','','','','','','',0,165752814},
		{'51','','4124 Squire Hill CT','23234','Richmond','VA','Brs Modular Installers Inc','','','','','','','',0,26631895},
		{'52','','5 Haul Rd','74706','Wayne','NJ','Metro Packaging & Imaging Inc','','','','','','','',0,17078751},
		{'53','','55 Webster Ave Ste 2','10801','New Rochelle','NY','K & R Spraycraft Inc','','','','','','','',0,962000},
		{'54','','2903 Bunker Hill Ln','95054','Santa Clara','CA','Trianz','','','','','','','',0,110275397},
		{'55','','2 Taylor Rd Nas Bldg 3900','32508','Pensacola','FL','D.E.W. Management Services Inc','','','','','','',0,1910708031},
		{'56','','2110 Cupples Rd','78226','San Antonio','TX','Kelly Island Bar and Cafe','','','','','','','',0,89674677},
		{'57','','','77522','Baytown','TX','Aguila Francia MD PA','','','','','','','',0,2470594870},
		{'58','','18387 Ne 4th CT','33179','Miami','FL','Las Americas News Inc','','','','','','','',0,610432513},
		{'59','','360 S Alvarado St Ste 1','90057','Los Angeles','CA','El Rayo Express','','','','','','','',0,134017872},
		{'60','','2810 37th Ave','11101','Long Island City','NY','Carter Milchman & Frank Inc.','','','','','','',0,3806525},
		{'61','','11118 Liberty Ave','11419','South Richmond Hill','NY','Jpmorgan Chase Bank National Association','','','','','','','',0,60694543},
		{'62','','3647 Cedar Ave S','55407','Minneapolis','MN','Rivera Chiropractic Center','','','','','','','',0,74899596},
		{'63','','1027 Oneill Hwy','18512','Scranton','PA','Super 8 Motel','','','','','','','',0,11603330},
		{'64','','15725 S Vermont Ave','90247','Gardena','CA','Econo Wash & Water','','','','','','','',0,96041897},
		{'65','','95 Paxton Ave Ste 1','60409','Calumet City','IL','Blockson & Associates Real Estate Inc','','','','','','','',0,714205970},
		{'66','','6710 Dorchester Rd','29418','North Charleston','SC','Ramkrishna Inc','','','','','','','',0,43570868},
		{'67','','1060 Sanford Ave','90744','Wilmington','CA','Sams Market','','','','','','','',0,108356830},
		{'68','','131 3rd St','11231','Brooklyn','NY','Statewide Fireproof Door Co Inc','','','','','','','',0,954609},
		{'69','','','94125','San Francisco','CA','Airline Coach Service Inc.','','','','','','','',0,149435410},
		{'70','','4751 Wilshire Blvd','90010','Los Angeles','CA','C & H Travel & Tours Inc.','','','','','','','',0,103799427},
		{'71','','335 Crooked Hill Rd','11717','Brentwood','NY','American Scholar Inc.','','','','','','','',0,332715436},
		{'72','','4745 Clifton Rd','20748','Temple Hills','MD','S & H Auto Repair Inc','','','','','','','',0,21904754},
		{'73','','5318 W IRLO BRONSON MEMOR','34746','Kissimmee','FL','Augusta Doughnut Company Inc','','','','','','','',0,159035738},
		{'74','','10225 Woodway Dr','79925','El Paso','TX','Heist Disposal Inc','','','','','','','',0,86887225},
		{'75','','1840 S Arizona Blvd','85128','Coolidge','AZ','Kids Klub Inc','','','','','','','',0,134653887},
		{'76','','60 Kingsbridge Rd','88543','Piscataway','NJ','Gaffney-Kroese Electrical Supply Corporation','','','','','','','',0,17914373},
		{'77','','4714 W Fulton St FL 1','60644','Chicago','IL','Direct Sales','','','','','','','',0,138839298},
		{'78','','1301 N Houston St','76164','Fort Worth','TX','Law Offices of Tijerina Juan','','','','','','','',0,73506477},
		{'79','','7018 N Independence Ave','73116','Oklahoma City','OK','Weekly Debbie Graphic Design Artist','','','','','','','',0,120123397},
		{'80','','3002 Dow Ave Ste 318','92780','Tustin','CA','Sequi Incorporated','','','','','','','',0,108534377},
		{'81','','5240 SE 49th St','66409','Berryton','KS','Country Gardens','','','','','','','',0,114283122},
		{'82','','286 Grand St','10002','New York','NY','Tai Jiang Market Co Inc','','','','','','','',0,4407195},
		{'83','','4010 Barranca Pkwy','92604','Irvine','CA','Yang Sophia CPA Company','','','','','','','',0,158465356},
		{'84','','1680 Langport Dr','94087','Sunnyvale','CA','Pal Consultants Inc','','','','','','','',0,158354096},
		{'85','','3019 48th Ave','11101','Long Island City','NY','Star Bright Books Inc','','','','','','','',0,957426707},
		{'86','','20 Sunhill Ln','24592','Newton','MA','Sally Sveda MD','','','','','','','',0,23392081},
		{'87','','1825 E Furr A','93221','Exeter','CA','Sitting Duck Productions','','','','','','','',0,114162517},
		{'88','','1520 Knowles Ave','90063','Los Angeles','CA','La Chapalita Inc.','','','','','','','',0,430763466},
		{'89','','447 S Indiana Ave Ste 511','78521','Brownsville','TX','Little Care Bears Nursery','','','','','','','',0,133867127},
		{'90','','5563 N Fleetwell Ave','91702','Azusa','CA','Dominguez Construction Inc','','','','','','','',0,102513457},
		{'91','','4452 Mission St','94112','San Francisco','CA','Marios Store','','','','','','','',0,129401778},
		{'92','','1981 N Broadway Ste 435','94596','Walnut Creek','CA','The Chen Sean Law Offices of','','','','','','','',0,2701700200},
		{'93','','1536 Hutton Dr','75006','Carrollton','TX','Food Service Parts Inc','','','','','','','',0,80973899},
		{'94','','8608 Market Place Ln','45242','Cincinnati','OH','MEI Japanese Restaurant','','','','','','','',0,55058648},
		{'95','','101 W CENTRAL TX EXPY','76548','KILLEEN','TX','Sys Friendly Inc','','','','','','','',0,85980117},
		{'96','','102 Colorado','78583','Rio Hondo','TX','Adames Tire Service','','','','','','','',0,118680079},
		{'97','','615 N Upper Brdwy St 18','78477','Corpus Christi','TX','Idea Innovation Center Inc','','','','','','','',0,795559929},
		{'98','','4910 N Fairhill St','19120','Philadelphia','PA','Precision Electric Incorporated','','','','','','','',0,474331951},
		{'99','','505 8th Ave Rm 201','10018','New York','NY','Curtis Partition Corporation','','','','','','','',0,4583397},
		{'100','','28 Bealton CT','22406','Fredericksburg','VA','RM&j Trucking Inc','','','','','','','',0,992264758},
		{'101','','10 Baekeland Ave','88462','Middlesex','NJ','Peterson Brothers Mfg Co','','','','','','','',0,7109312}],
		BatchServices._Sample_layout_input_raw
	);

records := 
	PROJECT(
		ds_sample,
		TRANSFORM( Autokey_batch.Layouts.rec_inBatchMaster,
			clean_address := doxie.cleanaddress182( LEFT.addr, TRIM(LEFT.city) + ' ' + TRIM(LEFT.state) + ' ' + TRIM(LEFT.zip) );
			SELF.prim_range  := clean_address[1..10],
			SELF.predir      := clean_address[11..12],
			SELF.prim_name   := clean_address[13..40],
			SELF.addr_suffix := clean_address[41..44],
			SELF.postdir     := clean_address[45..46],
			SELF.sec_range   := clean_address[57..64],
			SELF.p_city_name := clean_address[90..114],
			SELF.st          := clean_address[115..116],
			SELF.z5          := clean_address[117..121],
			SELF.DOB				 := (String8)LEFT.DOB;
			SELF             := LEFT
		)
	);
	
EXPORT _canned_records := records;
