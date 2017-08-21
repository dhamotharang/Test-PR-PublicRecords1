IMPORT ut,lib_fileservices,_Control,lib_stringlib,AID,address,idl_header,Prof_License_Mari;

export file_NMLS_Indv_Detail(dataset(Prof_License_Mari.layouts_NMLS0900.INDV_REGISTRATION) indv,
														 dataset(Prof_License_Mari.layouts_NMLS0900.INDV_REGDETAIL) detail,
														 dataset(Prof_License_Mari.layouts_NMLS0900.SPONSORSHIP) sponsorship,
														 string process_dte
															) := function
															
#workunit('name','Prof License MARI- NMLS Individual Detail File');
src_cd	:= 'S0900'; //Vendor code
src_st	:= 'US';	//License state

//Destination File
MARIDest		:= Prof_License_Mari.thor_Cluster +'out::proflic_mari::nmls::';

// Populating IndividualLicense Regulation/Sponsorship File
rRawIndividualRegistration_layout	:=
RECORD
	Prof_License_Mari.layouts_NMLS0900.INDV_REGISTRATION;	
	Prof_License_Mari.layouts_NMLS0900.INDV_REGDETAIL AND NOT [INDIVIDUAL_NMLS_ID];
	Prof_License_Mari.layouts_NMLS0900.SPONSORSHIP AND NOT [INDIVIDUAL_NMLS_ID,START_DATE,END_DATE];
	string1 RECORD_TYPE_IND;
	
END;


inFileIndvReg := project(indv,TRANSFORM(rRawIndividualRegistration_layout,SELF := LEFT; SELF := []));


//Join Individual Registration Files
rRawIndividualRegistration_layout 		trans_IndividualReg(inFileIndvReg L, recordof(detail) R) := transform
  self.EMPLOYER_NAME 		:= R.EMPLOYER_NAME;
	self.INSTIT_NAME 			:= R.INSTIT_NAME;
	self.INSTIT_NMLS_ID 	:= R.INSTIT_NMLS_ID;
	self.FEDREGULATOR			:= R.FEDREGULATOR;
	self.START_DATE 			:= R.START_DATE;
	self.END_DATE 				:= R.END_DATE;
	self.RECORD_TYPE_IND	:= 'F';
	self := L;
	// SELF := [];	
end;

ds_Individual_reg := JOIN(inFileIndvReg, detail,
						       left.INDIVIDUAL_NMLS_ID= right.INDIVIDUAL_NMLS_ID,
						       trans_IndividualReg(left,right),left outer,many lookup);



// Join Sponsorship File
rRawIndividualRegistration_layout 		trans_Sponsorship(recordof(sponsorship) pInput) := transform
	self.INDIVIDUAL_NMLS_ID	:= pInput.INDIVIDUAL_NMLS_ID;
  self.COMPANY_NMLS_ID 		:= pInput.COMPANY_NMLS_ID;
	self.COMPANY 						:= pInput.COMPANY;
	self.REGULATOR 					:= pInput.REGULATOR;
	self.LICENSE_ID					:= pInput.LICENSE_ID;
	self.LICENSE_TYPE				:= pInput.LICENSE_TYPE;
	self.START_DATE 				:= pInput.START_DATE;
	self.END_DATE 					:= pInput.END_DATE;
	self.RECORD_TYPE_IND		:= 'S';
	self := pInput;
	SELF := [];	
end;


ds_IndvSponsorship := project(sponsorship, trans_Sponsorship(left));

dsIndvRegSponsor := 	ds_Individual_reg + ds_IndvSponsorship; //: persist('~thor_data400::persist::nmls::individual_sponsor'); 								 

Prof_License_Mari.layouts.Individual_Reg		xformIndvDetailSponsor(dsIndvRegSponsor pInput) := TRANSFORM
		self.DATE_FIRST_SEEN							:= process_dte;
		self.DATE_LAST_SEEN								:= process_dte;
		self.DATE_VENDOR_FIRST_REPORTED		:= process_dte;
		self.DATE_VENDOR_LAST_REPORTED		:= process_dte;
		self.PROCESS_DATE									:= thorlib.wuid()[2..9];
		self.STD_SOURCE_UPD								:= src_cd;
		self.RECORD_TYPE_IND							:= pInput.RECORD_TYPE_IND;
		self.INDIVIDUAL_NMLS_ID						:= pInput.INDIVIDUAL_NMLS_ID;
		self.COMPANY_NMLS_ID							:= pInput.COMPANY_NMLS_ID;
		self.INSTIT_NMLS_ID								:= pInput.INSTIT_NMLS_ID;
		self.NAME_REGISTRATION						:= ut.fnTrim2Upper(pInput.REGNAME);
		self.REG_STATUS										:= ut.fnTrim2Upper(pInput.STATUS);
		self.is_Authorized_Conduct				:= StringLib.StringFilterOut(ut.fnTrim2Upper(pInput.IS_REG_AUTHORIZED),'"');	
		self.NAME_EMPLOYER								:= ut.fnTrim2Upper(pInput.EMPLOYER_NAME);
		tmpCompany := if(pInput.COMPANY_NMLS_ID != 0, pInput.COMPANY,
											If(pInput.INSTIT_NMLS_ID != 0, pInput.INSTIT_NAME,
											''));
		self.NAME_COMPANY							:= ut.fnTrim2Upper(tmpCompany);
		self.LICENSE_ID										:= pInput.LICENSE_ID;
		self.RAW_LICENSE_TYPE							:= ut.fnTrim2Upper(pInput.LICENSE_TYPE);
		self.STD_LICENSE_DESC 						:= self.RAW_LICENSE_TYPE;
	
		tmpRegulator := if(pInput.COMPANY_NMLS_ID != 0,pInput.REGULATOR,
												IF(pInput.INSTIT_NMLS_ID != 0, pInput.FEDREGULATOR,
														''));
		self.REGULATOR										:= ut.fnTrim2Upper(tmpRegulator);
		self.START_DTE										:= pInput.START_DATE;
		self.END_DTE											:= pInput.END_DATE;
		self.CLN_START_DTE								:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.START_DATE);
		self.CLN_END_DTE									:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.END_DATE);
	end;

ds_detail := project(dsIndvRegSponsor, xformIndvDetailSponsor(left)); //: persist('~thor_data400::persist::nmls::indv_detail');
ds_base := output(dedup(ds_detail,record,all,local), ,'~thor_data400::out::proflic_mari::nmls::' +process_dte+ '::individual_detail',__compressed__,overwrite);

return ds_base;

end;


