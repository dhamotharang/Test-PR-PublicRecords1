
IMPORT ut,lib_fileservices,_Control,lib_stringlib,AID,address,idl_header,Prof_License_Mari,STD;

EXPORT  file_NMLS_RegulatoryActions(DATASET(Prof_License_Mari.layouts_NMLS0900.Regulatory) pRegulatory, STRING process_dte) := FUNCTION

src_cd	:= 'S0900'; //Vendor code
src_st	:= 'US';	//License state

//Destination File
MARIDest		:= Prof_License_Mari.thor_Cluster +'out::proflic_mari::nmls::';

//raw to MARIBASE layout - Regulatory
 Prof_License_Mari.layouts.Regulatory_Action	xformRegulatoryActions(pRegulatory pInput) := TRANSFORM
		SELF.DATE_FIRST_SEEN							:= process_dte;
		SELF.DATE_LAST_SEEN								:= process_dte;
		SELF.DATE_VENDOR_FIRST_REPORTED		:= process_dte;
		SELF.DATE_VENDOR_LAST_REPORTED		:= process_dte;
		SELF.PROCESS_DATE									:= thorlib.wuid()[2..9];
		SELF.STD_SOURCE_UPD								:= src_cd;
		SELF.STATE_ACTION_ID							:= pInput.STATE_ACTION_ID;
		SELF.NMLS_ID											:= pInput.NMLS_ID;
		SELF.AFFIL_TYPE_CD								:= MAP(pInput.entity_type = 'COMPANY' =>  'CO',
																						pInput.entity_type = 'BRANCH' => 'BR',
																						pInput.entity_type = 'INDIVIDUAL' => 'IN','');

		SELF.REGULATOR										:= ut.CleanSpacesAndUpper(pInput.REGULATOR);
		SELF.ACTION_TYPE									:= ut.CleanSpacesAndUpper(pInput.ACTION_TYPE);
		SELF.ACTION_DTE										:= pInput.ACTION_DATE;
		SELF.MULTI_STATE_ID								:= ut.CleanSpacesAndUpper(pInput.MULTI_STATE_ACTION_ID);
		SELF.DOCKET_NBR										:= ut.CleanSpacesAndUpper(pInput.DOCKET_NUMBER);
		// SELF.URL													:= STRINGLib.StringFilterOut(pInput.URL,'"');
		SELF.URL													:= REGEXREPLACE('[^ -~]',trim(STD.Str.CleanSpaces(STRINGLib.StringFilterOut(pInput.URL,'"')),left,right),'');
		SELF.CLN_ACTION_DTE								:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ACTION_DATE);

END;		

ds_regulatory := PROJECT(pRegulatory, xformRegulatoryActions(LEFT)); //: persist('~thor_data400::persist::nmls::regulatory_actions');
ut.CleanFields(ds_regulatory,ds_cln_regulatory);
ds_base_dedup := OUTPUT(DEDUP(ds_cln_regulatory,RECORD,ALL,LOCAL), ,'~thor_data400::out::proflic_mari::nmls::'+process_dte+'::regulatory_actions',__COMPRESSED__,OVERWRITE);

RETURN ds_base_dedup;
		
END;