import prte2_business_credit, BIPV2, Address;

layouts.LinkedBase  xformLinkids(file_BusinessInformation L) := transform
		self.powid															:= L.powid;
		self.proxid															:= L.proxid;
		self.seleid															:= L.seleid;
		self.orgid															:= L.orgid;
		self.ultid															:= L.ultid;
		self.Version														:= L.version;
		self.Original_Version										:= L.Original_Version;
		self.record_type												:= L.record_type;
		self.Sbfe_Contributor_Number						:= L.Sbfe_Contributor_Number;
		self.Contract_Account_Number						:= L.Contract_Account_Number;
		self.Original_Contract_Account_Number		:= L.Original_Contract_Account_Number;
		self.Account_Type_Reported							:= L.account_type_reported; //003
		self.dt_first_seen											:= L.dt_first_seen;
		self.dt_last_seen												:= L.dt_last_seen;
		self.dt_vendor_first_reported						:= L.dt_vendor_first_reported;	
		self.dt_vendor_last_reported						:= L.dt_vendor_last_reported;
		self.dt_datawarehouse_first_reported		:= L.dt_datawarehouse_first_reported;
		self.dt_datawarehouse_last_reported			:= L.dt_datawarehouse_last_reported;
		self.did																:= L.did;
		self.did_score													:= 0;
		self.source															:= L.source;
		self := L;
		self := [];
	END;

EXPORT File_Linkids := project(file_BusinessInformation, xformLinkids(left));