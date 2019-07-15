import marketing_best, doxie, dma, _Control;

dIn	:= File_Gong_Base; 

slim_layout
	:=Record
		string10    phoneno:= '';
		string10    prim_range:= '';
		string2     predir:= '';
		string28    prim_name:= '';
		string4     suffix:= '';
		string2     postdir:= '';
		string10    unit_desig:= '';
		string8     sec_range:= '';
		string25    p_city_name:= '';
		string2     st:= '';
		string5     z5:= '';
		string4     z4:= '';
		string20    name_first:= '';
		string20    name_last:= '';
	end;
	
dslim:=PROJECT(Din,slim_layout);
	
d_supp_phone:=JOIN(dslim, dma.key_DNC_Phone,keyed(LEFT.phoneno = RIGHT.phonenumber),
				   LEFT only) ; 
d_supp_addr := JOIN(d_supp_phone, dma.key_DNM_Name_Address, 
                       keyed(LEFT.prim_name = RIGHT.l_prim_name) AND
					   keyed(LEFT.prim_range = RIGHT.l_prim_range) AND 
					   keyed(LEFT.st = RIGHT.l_st) AND
					   keyed(doxie.Make_CityCode(LEFT.p_city_name) = RIGHT.l_city_code) AND 
					   keyed(LEFT.z5 = RIGHT.l_zip) AND 
					   keyed(LEFT.sec_range = RIGHT.l_sec_range) AND 
					   keyed(LEFT.name_last = RIGHT.l_lname) AND
					   keyed(LEFT.name_first = RIGHT.l_fname),
					   LEFT only );

Out_layout :=RECORD
   STRING36 click_id  ;
   STRING38 click_hhid  ;
   STRING10 phone ;
end;

Out_layout t(d_supp_addr l)
:=TRANSFORM
  SELF.click_id    := fn_create_click_id(TRIM(l.prim_range,LEFT,RIGHT)+' '+TRIM(l.predir,LEFT,RIGHT)+' '+TRIM(l.prim_name,LEFT,RIGHT)+' '+TRIM(l.suffix,LEFT,RIGHT)+' '+TRIM(l.postdir,LEFT,RIGHT)+' '+TRIM(l.unit_desig,LEFT,RIGHT)+' '+TRIM(l.sec_range,LEFT,RIGHT),l.z5,l.name_last,'','','');
  SELF.click_hhid  := fn_create_click_id(TRIM(l.prim_range,LEFT,RIGHT)+' '+TRIM(l.predir,LEFT,RIGHT)+' '+TRIM(l.prim_name,LEFT,RIGHT)+' '+TRIM(l.suffix,LEFT,RIGHT)+' '+TRIM(l.postdir,LEFT,RIGHT)+' '+TRIM(l.unit_desig,LEFT,RIGHT)+' '+TRIM(l.sec_range,LEFT,RIGHT),l.z5,'','','','');
  SELF.phone       :=   l.phoneno  ; 

end; 


export proc_build_gongAsClickdata := 

sequential(
output(DEDUP(PROJECT(d_supp_addr,t(LEFT)),all),,'~thor::out::gong_ForClickdataSuppression',csv(terminator('\n'), separator(','), quote('"')),overwrite),

fileservices.Despray('~thor::out::gong_ForClickdataSuppression',_Control.IPAddress.bctlpedata10, 

           '/data/data_build_5_2/gongneustar/newmovers/gong_ForClickdataSuppression.csv',,,,true),

output(count(dma.key_DNC_Phone)),
output(count(dma.key_DNM_Name_Address)),
output(count(din)));  
				    

