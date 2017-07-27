import doxie;

base_file			:=	DATASET('~thor_data400::base::impulse_email', layouts.layout_Impulse_Email_final, THOR);

layouts.layout_Impulse_Email_Did_Key	tBasetoKey(layouts.layout_Impulse_Email_final pInput)
	:=
		TRANSFORM
			self.AID											:=	(unsigned4)(string)pInput.RawAID;
			self.ProcessDate							:=	pInput.file_date[1..6];
			self.DateVendorFirstReported	:=	(unsigned3)(string)pInput.DateVendorFirstReported[1..6];
			self.DateVendorLastReported		:=	(unsigned3)(string)pInput.DateVendorLastReported[1..6];
			self.cln_PRIM_RANGE						:=	pInput.prim_range;
			self.cln_PRIM_NAME						:=	pInput.prim_name;
			self.cln_SEC_RANGE						:=	pInput.sec_range;
			self.cln_ST										:=	pInput.st;
			self.cln_ZIP									:=	pInput.zip5;
			self													:=	pInput;
		END;

base_key_file	:=	PROJECT(base_file(did<>0 AND length(trim(siteid))<5 AND record_type != 'I'), tBasetoKey(LEFT));

export Key_Impulse_DID := INDEX(base_key_file,{did},{base_key_file},'~thor_data400::key::impulse_email::'+Doxie.Version_SuperKey+'::did');