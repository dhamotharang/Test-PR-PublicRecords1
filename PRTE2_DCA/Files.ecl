IMPORT PRTE2_DCA, PRTE2,ut,std;

EXPORT Files := MODULE
//Input Files
 export infile_boca 	:= DATASET(Constants.in_dca + '::boca', Layouts.layout_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
 export infile_alpha := DATASET(Constants.in_dca + '::alpha', Layouts.layout_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

  
	PRTE2.CleanFields(infile_boca,cln_boca);  
	PRTE2.CleanFields(infile_alpha,cln_alpha);  
	Export file_in:= cln_boca + cln_alpha;
	
	Layouts.layout_base PhysicalAddress(Layouts.layout_in L, INTEGER C) :=	TRANSFORM
						SELF.addr_1 := 	TRIM(L.street);
						SELF.addr_2 :=  TRIM(L.city) + ', ' + TRIM(L.state) + ' ' + TRIM(L.zip);
						SELF.rawaid := 0;
						SELF.physical_addr_1 	:= SELF.addr_1;
						SELF.physical_addr_2 	:= SELF.addr_2;
						SELF.mailing_addr_1	 	:= '';
						SELF.mailing_addr_2	 	:= '';
						SELF.physical_rawaid 	:= 0;
						SELF.mailing_rawaid  	:= 0;
						SELF.row_id          	:= C;
						SELF.addr_type_flag  	:= 'P';
						SELF := L;
						SELF := [];
	END;

  EXPORT file_in_physical_address := PROJECT(file_in(process_date <> ''), PhysicalAddress(LEFT,COUNTER));
	
	EXPORT file_in_mailing_address :=
		PROJECT(file_in_physical_address,
						Transform(Layouts.layout_base,
											SELF.addr_1 := 	TRIM(LEFT.streetA);
											SELF.addr_2 :=  TRIM(LEFT.city_A) + ', ' + TRIM(LEFT.state_A) + ' ' + TRIM(LEFT.zip_A);
											SELF.mailing_addr_1 	:= SELF.addr_1;
											SELF.mailing_addr_2 	:= SELF.addr_2;
											SELF.physical_addr_1 	:= '';
											SELF.physical_addr_2 	:= '';											
											SELF.rawaid := 0;											
											SELF.physical_rawaid := 0;
											SELF.mailing_rawaid := 0;
											SELF.row_id := LEFT.row_id;
											SELF.addr_type_flag := 'M';
											SELF.physical_address := [];
											SELF.mailing_address := [];	
											SELF := LEFT;
											SELF := [];
										)
						);
								
	EXPORT file_in_plus := file_in_physical_address + file_in_mailing_address;

//Base File	
	EXPORT file_base := DATASET(Constants.base_dca, Layouts.layout_base, FLAT );
	 
	EXPORT base_bdid := file_base(bdid <> 0);
	
	EXPORT file_linkids := 
		PROJECT(file_base, 
						Transform(Layouts.layout_linkids,
											SELF.rawfields	:= LEFT.companies;
           SELF := LEFT;
											SELF	:= [];
											));

                     
	EXPORT file_bdid := 
		PROJECT(base_bdid, 
						Transform(Layouts.layout_bdid,
											SELF.prim_range  	:= LEFT.physical_address.prim_range;						
											SELF.predir  			:= LEFT.physical_address.predir;				
											SELF.prim_name  	:= LEFT.physical_address.prim_name;					
											SELF.addr_suffix 	:= LEFT.physical_address.addr_suffix;						
											SELF.postdir  		:= LEFT.physical_address.postdir;				
											SELF.unit_desig  	:= LEFT.physical_address.unit_desig;						
											SELF.sec_range  	:= LEFT.physical_address.sec_range;					
											SELF.p_city_name 	:= LEFT.physical_address.p_city_name;						
											SELF.v_city_name 	:= LEFT.physical_address.v_city_name;						
											SELF.st  					:= LEFT.physical_address.st;	
											SELF.z5  				:= LEFT.physical_address.zip;		
											SELF.zip  				:= LEFT.physical_address.zip;		
											SELF.zip4  				:= LEFT.physical_address.zip4;			
											SELF.cart  				:= LEFT.physical_address.cart;			
											SELF.cr_sort_sz  	:= LEFT.physical_address.cr_sort_sz;						
											SELF.lot  				:= LEFT.physical_address.lot;		
											SELF.lot_order  	:= LEFT.physical_address.lot_order;	
											SELF.chk_digit		:= LEFT.physical_address.chk_digit;
											SELF.rec_type  		:= LEFT.physical_address.rec_type;					
											SELF.geo_lat  		:= LEFT.physical_address.geo_lat;				
											SELF.geo_long  		:= LEFT.physical_address.geo_long;					
											SELF.msa  				:= LEFT.physical_address.msa;		
											SELF.geo_blk  		:= LEFT.physical_address.geo_blk;				
											SELF.geo_match  	:= LEFT.physical_address.geo_match;					
											SELF.err_stat  		:= LEFT.physical_address.err_stat;		
											SELF.prim_rangea  := LEFT.mailing_address.prim_range;						
											SELF.predira 			:= LEFT.mailing_address.predir;				
											SELF.prim_namea  	:= LEFT.mailing_address.prim_name;					
											SELF.addr_suffixa := LEFT.mailing_address.addr_suffix;						
											SELF.postdira			:= LEFT.mailing_address.postdir;				
											SELF.unit_desiga  := LEFT.mailing_address.unit_desig;						
											SELF.sec_rangea  	:= LEFT.mailing_address.sec_range;					
											SELF.p_city_namea := LEFT.mailing_address.p_city_name;						
											SELF.v_city_namea := LEFT.mailing_address.v_city_name;						
											SELF.sta  				:= LEFT.mailing_address.st;		
											SELF.zipa  				:= LEFT.mailing_address.zip;		
											SELF.zip4a  			:= LEFT.mailing_address.zip4;			
											SELF.carta  			:= LEFT.mailing_address.cart;			
											SELF.cr_sort_sza  := LEFT.mailing_address.cr_sort_sz;						
											SELF.lota  				:= LEFT.mailing_address.lot;		
											SELF.lot_ordera  	:= LEFT.mailing_address.lot_order;	
											SELF.chk_digita		:= LEFT.mailing_address.chk_digit;											
											SELF.rec_typea  	:= LEFT.mailing_address.rec_type;					
											SELF.geo_lata  		:= LEFT.mailing_address.geo_lat;				
											SELF.geo_longa  	:= LEFT.mailing_address.geo_long;					
											SELF.msaa  				:= LEFT.mailing_address.msa;		
											SELF.geo_blka  		:= LEFT.mailing_address.geo_blk;				
											SELF.geo_matcha  	:= LEFT.mailing_address.geo_match;					
											SELF.err_stata  	:= LEFT.mailing_address.err_stat;					
										
											SELF := LEFT;
											
											//default values
											SELF.dpbc			:= [];											
											SELF.dpbca		:= [];
											SELF.county		:= [];											
											SELF.countya	:= [];	
											SELF.lf						:= [];	
											//SELF.__internal_fpos__ := [];											
											SELF.parent_enterprise_number := [];											
											SELF.ultimate_enterprise_number  := [];	
											)
						);	
	
	EXPORT file_entnum := PROJECT(file_base, Transform(Layouts.layout_entnum,	SELF:=Left;	SELF := [];));

	
	EXPORT file_hierarchy_parent_to_child_entnum := PROJECT(file_base, 
																													Transform(Layouts.layout_hierarchy_parent_to_child_entnum,	
																																		self.Parent_Enterprise_number 	:= IF( left.Parent_Number != '', 
																																																							left.Parent_Number, 
																																																									left.Enterprise_num );
																																		self.Enterprise_num := left.Enterprise_num;
																																		self.child_level 		:= left.level;	
																																		SELF :=Left;	
																																		SELF := [];
																																		));
		
	
	EXPORT file_hierarchy_bdid := PROJECT(base_bdid, 
																				Transform(Layouts.layout_hierarchy_bdid, 
																									self.bdid   := left.bdid;
																									self.level	:= left.level;
																									self.root		:= left.root;
																									self.sub		:= left.sub;
																									self.parent_root := left.parent_number[1..9];
																									self.parent_sub  := left.parent_number[11..];
																									self:=left;	
																									self := [];
																									));


	
	EXPORT file_hierarchy_parent_to_child_root_sub := PROJECT(file_base, 
																														Transform(Layouts.layout_hierarchy_parent_to_child_root_sub,	
																														self.parent_root := IF( left.parent_number != '', left.parent_number[1..9], left.root );
																														self.parent_sub  := IF( left.parent_number != '', left.parent_number[11..], left.sub );
																														self.child_root  := left.root;
																														self.child_sub   := left.sub;
																														self.child_level := left.level;	
																														SELF := Left;	
																														SELF := [];
																														));


	
	EXPORT file_hierarchy_root_sub := PROJECT(base_bdid, 
																						Transform(Layouts.layout_hierarchy_root_sub,	
																						self.bdid		:= left.bdid;
																						self.level	:= left.level;
																						self.root		:= left.root;
																						self.sub		:= left.sub;
																						self.parent_root := left.parent_number[1..9];
																						self.parent_sub  := left.parent_number[11..];
																						SELF:=Left;	
																						SELF := [];
																						));

	EXPORT file_root_sub := 
		PROJECT(base_bdid, Transform(Layouts.layout_root_sub,	SELF:=Left;	SELF := [];));


	EXPORT file_autokey := 
		PROJECT(file_base, Transform(Layouts.layout_autokey,	
																SELF.BDID                     := left.BDID;
																SELF.company_name             := left.Name;
																SELF.company_phone            := left.Phone;
																SELF.bus_addr.prim_range      := left.physical_address.prim_range;
																SELF.bus_addr.predir          := left.physical_address.predir;
																SELF.bus_addr.prim_name       := left.physical_address.prim_name;
																SELF.bus_addr.addr_suffix     := left.physical_address.addr_suffix;
																SELF.bus_addr.postdir         := left.physical_address.postdir;
																SELF.bus_addr.unit_desig      := left.physical_address.unit_desig;
																SELF.bus_addr.sec_range       := left.physical_address.sec_range;
																SELF.bus_addr.p_city_name     := left.physical_address.p_city_name;
																SELF.bus_addr.v_city_name     := left.physical_address.v_city_name;
																SELF.bus_addr.st              := left.physical_address.st;
																SELF.bus_addr.zip5            := left.physical_address.zip;
																SELF.bus_addr.zip4            := left.physical_address.zip4;
																SELF.bus_addr.fips_state      := '';
																SELF.bus_addr.fips_county     := Left.physical_address.fips_county;
																SELF.bus_addr.addr_rec_type   := '';
																SELF:= Left;	
																SELF := [];
																));
	//end empty key files
	
 //needed for BIP header
	EXPORT file_base_companies := 
		PROJECT(file_base, 
						Transform(Layouts.layout_base_companies,
											SELF.rawfields	:= LEFT.companies;
											SELF := LEFT;
											SELF	:= [];
											));
                      
//CCPA Phase 2
	EXPORT contacts_bdid := dataset([], layouts.contact_bdid);
END;