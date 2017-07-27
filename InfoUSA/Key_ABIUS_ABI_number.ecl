import  InfoUsa,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::infoUSA::ABIUS::'+ Doxie.Version_SuperKey;
dBase 	      := InfoUSA.File_ABIUS_Company_Base(abi_number <> '');

Layout_Key_ABius_ABI_Number T_standard(dbase l):=transform

		self.addr1.prim_range :=l.prim_range ;
		self.addr1.predir :=l.predir ;
		self.addr1.prim_name :=l.prim_name ;
		self.addr1.addr_suffix :=l.addr_suffix ;
		self.addr1.postdir :=l.postdir ;
		self.addr1.unit_desig :=l.unit_desig ;
		self.addr1.addr_rec_type:=l.rec_type;
		self.addr1.sec_range :=l.sec_range ;
		self.addr1.p_city_name:=l.p_city_Name;
		self.addr1.v_city_name :=l.v_city_name ;
		self.addr1.st :=l.st ;
		self.addr1.fips_state :=l.county[1..2];  
		self.addr1.fips_county:=l.county[3..5];
		self.addr1.zip5 :=l.z5 ;
		self.addr1.zip4 :=l.zip4 ;
		self.addr2.prim_range :=l.prim_range2;
		self.addr2.predir :=l.predir2;
		self.addr2.prim_name :=l.prim_name2;
		self.addr2.addr_suffix :=l.addr_suffix2;
		self.addr2.postdir :=l.postdir2;
		self.addr2.unit_desig :=l.unit_desig2;
		self.addr2.addr_rec_type:=l.rec_type2;
		self.addr2.sec_range :=l.sec_range2;
		self.addr2.p_city_name:=l.p_city_name2;
		self.addr2.v_city_name :=l.v_city_name2;
		self.addr2.st :=l.st2;
		self.addr2.fips_state :=l.county2[1..2];  
		self.addr2.fips_county:=l.county2[3..5];
		self.addr2.zip5 :=l.z52;
		self.addr2.zip4 :=l.zip42;
		self.name       :=l;
		self.name:=[];
		self :=l;
		end;
pDbase:=project(dbase,T_standard(left));

export Key_ABIUS_ABI_number  := INDEX(pdBase  ,{ABI_number},{pdBase},KeyName +'::ABI_number');