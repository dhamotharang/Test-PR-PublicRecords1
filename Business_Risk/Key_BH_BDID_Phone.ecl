import business_header, mdr, Prte2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
df := Prte2_Business_Header.File_Business_Header_Base_for_keybuild;
#ELSE
df := Business_Header.File_Business_Header_Base_for_keybuild;
#END;

bh_layout := recordof(df);

bh_layout  filterDNBAddressPhone(bh_layout l) := 
transform
	
	isdb := mdr.sourceTools.sourceisdunn_bradstreet(l.source);
	
	self.prim_range		:= if(isdb	,''	,l.prim_range		);
	self.predir				:= if(isdb	,''	,l.predir				);
	self.prim_name		:= if(isdb	,''	,l.prim_name		);
	self.addr_suffix	:= if(isdb	,''	,l.addr_suffix	);
	self.postdir			:= if(isdb	,''	,l.postdir			);
	self.unit_desig		:= if(isdb	,''	,l.unit_desig		);
	self.sec_range		:= if(isdb	,''	,l.sec_range		);
	self.zip					:= if(isdb	,0	,l.zip					);
	self.zip4					:= if(isdb	,0	,l.zip4					);
	self.county				:= if(isdb	,''	,l.county				);
	self.msa					:= if(isdb	,''	,l.msa					);
	self.geo_lat			:= if(isdb	,''	,l.geo_lat			);
	self.geo_long			:= if(isdb	,''	,l.geo_long			);
	self.phone				:= if(isdb	,0	,l.phone				);
	self.phone_score	:= if(isdb	,0	,l.phone_score	);
	self 							:= l;                     
end;

p := project(df, filterDNBAddressPhone(left));


df2 := dedup(sort(distribute(p(phone != 0) , hash(bdid)),bdid, phone, company_name, prim_range, prim_name, sec_range, zip, local), bdid, phone, company_name, prim_range, prim_name, sec_range, zip, local);

export Key_BH_BDID_Phone := index(df2, {bdid}, {phone, company_name, prim_range, prim_name, sec_range, zip}, '~thor_Data400::key::BH_BDID_To_Phone_QA');
