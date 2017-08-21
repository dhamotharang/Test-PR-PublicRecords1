import Address;

Drivers.Layout_Experian_XML_Fixed	tFixedFromXML(Drivers.File_In_Experian_XML pInput)
 :=
  transform
	string73	lCleanName		:=	Address.CleanPersonFML73(pInput.full_name);
	string182	lCleanAddress	:=	Address.CleanAddress182(pInput.CurrentAddress_street_1,
																			   pInput.CurrentAddress_city + ' ' + pInput.CurrentAddress_state + ' ' + pInput.CurrentAddress_zip
																			  );
	self.title    				:=	lCleanName[01..05];
	self.fname					:=	lCleanName[06..25]; 
	self.mname					:=	lCleanName[26..45];
	self.lname					:=	lCleanName[46..65];
	self.name_suffix			:=	lCleanName[66..70];
	self.cleaning_score			:=	lCleanName[71..73];
	self.prim_range  			:=	lCleanAddress[001..010];
	self.predir      			:=	lCleanAddress[011..012];
	self.prim_name   			:=	lCleanAddress[013..040];
	self.suffix 				:=	lCleanAddress[041..044];
	self.postdir     			:=	lCleanAddress[045..046];
	self.unit_desig  			:=	lCleanAddress[047..056];
	self.sec_range   			:=	lCleanAddress[057..064];
	self.p_city_name 			:=	lCleanAddress[065..089];
	self.v_city_name 			:=	lCleanAddress[090..114];
	self.st		       			:=	lCleanAddress[115..116];
	self.zip5        			:=	lCleanAddress[117..121];
	self.zip4        			:=	lCleanAddress[122..125];
	self.cart        			:=	lCleanAddress[126..129];
	self.cr_sort_sz  			:=	lCleanAddress[130];
	self.lot         			:=	lCleanAddress[131..134];
	self.lot_order   			:=	lCleanAddress[135];
	self.dpbc        			:=	lCleanAddress[136..137];
	self.chk_digit    			:=	lCleanAddress[138];
	self.rec_type    			:=	lCleanAddress[139..140];
	self.ace_fips_st 			:=	lCleanAddress[141..142];
	self.county      			:=	lCleanAddress[143..145];
	self.geo_lat     			:=	lCleanAddress[146..155];
	self.geo_long    			:=	lCleanAddress[156..166];
	self.msa         			:=	lCleanAddress[167..170];
	self.geo_blk     			:=	lCleanAddress[171..177];
	self.geo_match   			:=	lCleanAddress[178];
	self.err_stat    			:=	lCleanAddress[179..182];
	self						:=	pInput;
  end
 ;

export Mapping_Experian_XML_Fixed
 :=	project(Drivers.File_In_Experian_XML,tFixedFromXML(left))
 :	persist(Drivers.Cluster	+	'persist::drvlic_experian_all_fixed')
 ;