import standard, ut, doxie; 

dbase := File_ABIUS_Company_Base;

rec := record
    dbase.ABi_number;	
	dbase.phone;
	dbase.company_name;
	dbase.bdid;
	standard.Name Name;
	Standard.L_Address.base addr;
	unsigned1 zero := 0;
	unsigned6 fdid := 0; 
end;

rec tNormalizeAddr(dbase l,unsigned1 pCounter) := transform
	
	self.Name   	 				:=l;
	self.name                       :=[];

	self.addr.prim_range    :=choose(pCounter,l.prim_range ,l.prim_range2);
	self.addr.predir 		:=choose(pCounter,l.predir ,l.predir2);
	self.addr.prim_name 	:=choose(pCounter,l.prim_name ,l.prim_name2);
	self.addr.addr_suffix 	:=choose(pCounter,l.addr_suffix ,l.addr_suffix2);
	self.addr.postdir 		:=choose(pCounter,l.postdir ,l.postdir2);
	self.addr.unit_desig 	:=choose(pCounter,l.unit_desig ,l.unit_desig2);
	self.addr.sec_range 	:=choose(pCounter,l.sec_range ,l.sec_range2);
	self.addr.v_city_name 	:=choose(pCounter,l.v_city_name ,l.v_city_name2);
	self.addr.p_city_name 	:=choose(pCounter,l.p_city_name ,l.p_city_name2);
	self.addr.st 			:=choose(pCounter,l.st ,l.st2);
	self.addr.fips_state    :=choose(pCounter,l.county[1..2],l.county2[1..2]);  
	self.addr.fips_county   :=choose(pCounter,l.county[3..5],l.county2[3..5]);
	self.addr.zip5 			:=choose(pCounter,l.z5 ,l.z52);
	self.addr.zip4 			:=choose(pCounter,l.zip4 ,l.zip42);
	self.addr.addr_rec_type :=choose(pCounter,l.rec_type ,l.rec_type2);
	self 				     		:= l;
end;

b:=project(dbase,tNormalizeAddr(left,2));

 export File_Abius_SearchAutokey := b;