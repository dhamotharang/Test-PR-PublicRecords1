IMPORT PRTE2_DCA, PRTE2,ut,std;

EXPORT Files := MODULE

 file_in_a := DATASET(Constants.in_dca, Layouts.layout_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
  
	PRTE2.CleanFields(file_in_a,file_in_b);  
	Export file_in:=file_in_b;
	
	EXPORT file_base := DATASET(Constants.base_dca, Layouts.layout_base, FLAT );

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
	
	EXPORT file_linkids := 
		PROJECT(file_base, 
						Transform(Layouts.layout_linkids,
											SELF.rawfields	:= LEFT.companies;
           SELF := LEFT;
											SELF	:= [];
											));

                     
	EXPORT file_bdid := 
		PROJECT(file_base, 
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
	

	//The rest are used to create empty keys
	EXPORT file_base_empty := PROJECT(file_base(link_inc_date=''),Layouts.layout_base);
	
	EXPORT file_entnum := 
		PROJECT(file_base_empty, Transform(Layouts.layout_entnum,	SELF:=Left;	SELF := [];));

	EXPORT file_hierarchy_parent_to_child_entnum := 
		PROJECT(file_base_empty, Transform(Layouts.layout_hierarchy_parent_to_child_entnum,	SELF:=Left;	SELF := [];));

	EXPORT file_hierarchy_bdid := 
		PROJECT(file_base_empty, Transform(Layouts.layout_hierarchy_bdid, SELF:=Left;	SELF := [];));

	EXPORT file_hierarchy_parent_to_child_root_sub := 
		PROJECT(file_base_empty, Transform(Layouts.layout_hierarchy_parent_to_child_root_sub,	SELF:=Left;	SELF := [];));

	EXPORT file_hierarchy_root_sub := 
		PROJECT(file_base_empty, Transform(Layouts.layout_hierarchy_root_sub,	SELF:=Left;	SELF := [];));

	EXPORT file_root_sub := 
		PROJECT(file_base_empty, Transform(Layouts.layout_root_sub,	SELF:=Left;	SELF := [];));

	EXPORT file_autokey := 
		PROJECT(file_base_empty, Transform(Layouts.layout_autokey,	SELF:=Left;	SELF := [];));
	//end empty key files
	
 //needed for BIP header
	EXPORT file_base_companies := 
		PROJECT(file_base, 
						Transform(Layouts.layout_base_companies,
											SELF.rawfields	:= LEFT.companies;
           SELF := LEFT;
											SELF	:= [];
											));
                      

END;