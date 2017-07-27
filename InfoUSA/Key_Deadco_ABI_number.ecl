import  InfoUsa,RoxieKeyBuild,ut,autokey,doxie;

KeyName       := cluster.cluster_out+'Key::infoUSA::DEADCO::'+ Doxie.Version_SuperKey;
dBase 	      := File_Deadco_base;


Layout_Key_DEADCO_ABI_Number T_standard(dbase l):=transform

		self.addr.prim_range :=l.prim_range ;
		self.addr.predir :=l.predir ;
		self.addr.prim_name :=l.prim_name ;
		self.addr.addr_suffix :=l.addr_suffix ;
		self.addr.postdir :=l.postdir ;
		self.addr.unit_desig :=l.unit_desig ;
		self.addr.addr_rec_type:=l.rec_type;
		self.addr.sec_range :=l.sec_range ;
		self.addr.p_city_name:=l.p_city_Name;
		self.addr.v_city_name :=l.v_city_name ;
		self.addr.st :=l.st ;
		self.addr.fips_state :=l.ace_fips_st;  
		self.addr.fips_county:=l.ace_fips_county;		
		self.addr.zip5 :=l.zip5 ;
		self.addr.zip4 :=l.zip4 ;
		self.name       :=l;
		self.name:=[];
		self :=l;
		end;
pDbase:=project(dbase,T_standard(left));
export Key_Deadco_ABI_number  := INDEX(pdBase  ,{ABI_number},{pdBase},KeyName +'::ABI_number');
