// prte2_frandx.proc_build_base
// prte2.fn_appendfakeid
// custname='LN_PR'

IMPORT header,std,Address,prte2,ut, AID, AID_Support,AID_BUILD;;
EXPORT PreProcess := module
#option('multiplePersistInstances',FALSE);
// header.PreProcess
in_file := PRTE2_Header.file_personrecs;

{in_file} tNormalizeNames (in_file L, unsigned1 pCounter):=transform

        // vCleanName   := nid.CleanPerson73(...  // much more complex. Probably not needed
        vCleanName   := Address.CleanPersonFML73(choose(pCounter,L.fname+' '+L.mname+' '+L.lname
                                                ,L.alias1,L.alias2,L.alias3,L.alias4));
        tmp_cln_name := Address.CleanNameFields(vCleanName).CleanNameRecord;
        self.fname   := choose(pCounter,L.fname,tmp_cln_name.fname);
        self.mname   := choose(pCounter,L.mname,tmp_cln_name.mname);
        self.lname   := choose(pCounter,L.lname,tmp_cln_name.lname);
        SELF         := L;

end;

in_file_noemalized_names := normalize(in_file,5,tNormalizeNames(LEFT,counter))(fname<>'' or mname<>'' or lname<>'');


layout_normed_adderess := record

 {in_file_noemalized_names} AND NOT [addr1, addr2, city, st, zip];
 // string prep_addr1;
 // string prep_addr2;
 // {in_file_noemalized_names} AND NOT [addr1, addr2, city, st, zip];
 string prep_addr1;
 string prep_addr2;
 string prep_city;
 string	prep_state;
 string	prep_zip5;
 header.Layout_New_Records.rec_type;
 string dummy;
 
end;

layout_normed_adderess tNormalizeAddresses (in_file_noemalized_names L, unsigned1 pCounter):= transform
       
        self.prep_addr1    := choose(pCounter, std.str.cleanspaces(STD.Str.ToUpperCase(L.addr1 +' ' + L.addr2))
                                     ,L.Prev1_addr    ,L.Prev2_addr     ,L.Prev3_addr     ,L.Prev4_addr     ,L.Prev5_addr      
                                     ,L.Prev6_addr    ,L.Prev7_addr     ,L.Prev8_addr     ,L.Prev9_addr     ,L.Prev10_addr     );
                                     
        self.prep_addr2    := choose(pCounter, Address.Addr2FromComponents(L.city, L.st, L.zip)
                                    ,L.Prev1_citystzip,L.Prev2_citystzip,L.Prev3_citystzip,L.Prev4_citystzip,L.Prev5_citystzip
                                    ,L.Prev6_citystzip,L.Prev7_citystzip,L.Prev8_citystzip,L.Prev9_citystzip,L.Prev10_citystzip);
                                    
        self.date_first_seen:=choose(pCounter, L.date_first_reported
                                    ,L.prev1_in_dt    ,L.prev2_in_dt    ,L.prev3_in_dt    ,L.prev4_in_dt    ,L.prev5_in_dt    
                                    ,L.prev6_in_dt    ,L.prev7_in_dt    ,L.prev8_in_dt    ,L.prev9_in_dt    ,L.prev10_in_dt    );
                                    
        self.date_last_seen :=choose(pCounter, L.date_last_reported
                                    ,L.prev1_out_dt   ,L.prev2_out_dt   ,L.prev3_out_dt   ,L.prev4_out_dt   ,L.prev5_out_dt   
                                    ,L.prev6_out_dt   ,L.prev7_out_dt   ,L.prev8_out_dt   ,L.prev9_out_dt   ,L.prev10_out_dt   );
                                    
        self.src            :=choose(pCounter, L.src
                                    ,L.prevsrc1       ,L.prevsrc2       ,L.prevsrc3       ,L.prevsrc4       ,L.prevsrc5       
                                    ,L.prevsrc6       ,L.prevsrc7       ,L.prevsrc8       ,L.prevsrc9       ,L.prevsrc10      );
        
        self.rec_type       :=choose(pCounter, '1', '2','3','4','5','6','7','8','9','A');
        SELF := L;
				self := [];


end;


in_file_normalized_addresse := normalize(in_file_noemalized_names,10,tNormalizeAddresses(LEFT,counter))(prep_addr1<>'');

in_Convert_addrsss := project(in_file_normalized_addresse, transform(layout_normed_adderess,
															v_city 			:= trim(left.prep_addr2[1..STD.Str.Find(left.prep_addr2, ',', 1) -1], right);
															v_statezip 	:= trim(left.prep_addr2[STD.Str.Find(left.prep_addr2, ',', 1)+1..],left,right);
															v_state			:= trim(v_statezip[1..STD.Str.Find(v_statezip, ' ', 1) -1], right);
															v_zip				:= trim(v_statezip[STD.Str.Find(v_statezip, ' ', 1)..],left,right);
															self.prep_city   := v_city;
															self.prep_state		:= v_state;
															self.prep_zip5			:= v_zip;
															self := left;
															));
																																																																					

shared dAddressCleaned := PRTE2.AddressCleaner(in_Convert_addrsss,
																							['prep_addr1'],
																							['prep_addr2'], //blank field, not used but passed for attribute purposes
																							['prep_city'],
																							['prep_state'],
																							['prep_zip5'],
																							['clean_address'],
																							['RawAID']);

AID_BUILD.layouts.rFinal	tFinal(dAddressCleaned pInput) :=
TRANSFORM
	SELF.RawAID	:=	pInput.RawAID;
	SELF				:=	pInput.clean_address;
	SELF	:= [];
END;

export dFinal	:=	PROJECT(dAddressCleaned,tFinal(LEFT)): persist('~prte::persist::header::standardized');																				


header.Layout_New_Records mapToNewRecords(dAddressCleaned L) := transform
/*
    clean_address		:= Address.CleanAddress182(L.prep_addr1, L.prep_addr2);

    self.prim_range  	:= clean_address[1..10];
    self.predir  		  := clean_address[11..12];
    self.prim_name  	:= clean_address[13..40];
    self.suffix       := clean_address[41..44];
    self.postdir  		:= clean_address[45..46];
    self.unit_desig  	:= clean_address[47..56];
    self.sec_range  	:= clean_address[57..64];
    self.city_name  	:= clean_address[65..89];
 // self.v_city_name  := clean_address[90..114];
    self.st				    := clean_address[115..116];
    self.zip  			  := clean_address[117..121];
    self.zip4  			  := clean_address[122..125];
 // self.cart  		    := clean_address[126..129];
 // self.cr_sort_sz   := clean_address[130];
 // self.lot  		    := clean_address[131..134];
 // self.lot_order  	:= clean_address[135];
 // self.dbpc  		    := clean_address[136..137];
 // self.chk_digit  	:= clean_address[138];
 // self.rec_type  	  := clean_address[139..140];
 // self.fips_state	  := clean_address[141..142];
    self.county	      := clean_address[143..145]; // fips_county
 // self.geo_lat  	  := clean_address[146..155];
 // self.geo_long  	  := clean_address[156..166];
 // self.msa  		    := clean_address[167..170];
    self.geo_blk  		:= clean_address[171..177];
 // self.geo_match  	:= clean_address[178];
 // self.err_stat  	  := clean_address[179..182];
 */
 
		self.prim_range  := L.clean_address.prim_range;
		self.predir  		 := L.clean_address.predir;
    self.prim_name   := L.clean_address.prim_name;
    self.suffix      := L.clean_address.addr_suffix ;
    self.postdir  	 := L.clean_address.postdir;
    self.unit_desig  := L.clean_address.unit_desig;
    self.sec_range   := L.clean_address.sec_range;
    self.city_name   := L.clean_address.p_city_name;
		self.st				   := L.clean_address.st;
    self.zip  			 := L.clean_address.zip;
    self.zip4  			 := L.clean_address.zip4;
		self.county	     := L.clean_address.fips_county; // fips_county
		self.geo_blk  	 := L.clean_address.geo_blk;
		self.rawaid			 := L.rawaid;
    
		self.dob                        := (integer)((string)L.dob);
    o_dt_first_seen                 := (integer)((string)L.date_first_seen)[1..6];
    self.dt_first_seen              := if(o_dt_first_seen=0,198001,o_dt_first_seen);
    today                           := (unsigned)((string)Std.Date.Today())[1..6];
    o_dt_last_seen                  := (integer)((string)L.date_last_seen)[1..6];
    self.dt_last_seen               := if(o_dt_last_seen=0,today,o_dt_last_seen);
    self.dt_vendor_first_reported   := (integer)((string)L.date_first_reported)[1..6];
    self.dt_vendor_last_reported    := (integer)((string)L.date_last_reported)[1..6];
    self.dt_nonglb_last_seen        := (integer)((string)L.date_last_seen)[1..6];
    self.vendor_id                  := L.cust_name;
    name_gender                     := ut.GenderTools.gender(L.fname,L.mname);
    self.title                      := CASE(name_gender,
                                            'M' => 'MR',
                                            'F' => 'MS',
                                            '');
                                            
    self.name_suffix                := L.suffix;
    
    self.phone  := ut.CleanPhone(L.phone);
    self.src    := L.src;
    self.rid    := 0;
    self.did    := prte2.fn_appendfakeid.did(L.fname,L.lname,L.link_ssn,
                       L.link_dob, L.cust_name);
    self        := L;

end;

export as_header := project(dAddressCleaned,mapToNewRecords(LEFT));

// return as_header;
end;