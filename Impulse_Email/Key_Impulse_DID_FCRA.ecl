Import Data_Services, doxie;

//Remove Impulse Data from FCRA Keys
base_file			:=	DATASET([], layouts.layout_Impulse_Email_final);

layouts.layout_Impulse_Email_Did_Key	tBasetoKey(layouts.layout_Impulse_Email_final pInput)
	:=
		TRANSFORM
			self.AID											:=	(unsigned4)(string)pInput.RawAID;
			self.ProcessDate							:=	pInput.file_date[1..6];
			self.DateVendorFirstReported	:=	(unsigned3)((string)pInput.DateVendorFirstReported)[1..6];
			self.DateVendorLastReported		:=	(unsigned3)((string)pInput.DateVendorLastReported)[1..6];
			self.cln_PRIM_RANGE						:=	pInput.prim_range;
			self.cln_PRIM_NAME						:=	pInput.prim_name;
			self.cln_SEC_RANGE						:=	pInput.sec_range;
			self.cln_ST										:=	pInput.st;
			self.cln_ZIP									:=	pInput.zip5;	
			//Added for CCPA-108 
			self.global_sid               :=  pInput.global_sid;
			self.record_sid               :=  pInput.record_sid;
			self													:=	pInput;
		END;
		
base_key_file	:=	PROJECT(base_file(did<>0 AND length(trim(siteid))<5 AND record_type != 'I'), tBasetoKey(LEFT));

export Key_Impulse_DID_FCRA := INDEX(base_key_file,{did},{base_key_file},Data_Services.Data_location.Prefix('impulse')+'thor_data400::key::impulse_email::fcra::'+doxie.Version_SuperKey+'::did');