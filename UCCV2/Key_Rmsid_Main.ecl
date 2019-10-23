import  UCCV2,RoxieKeyBuild,ut,autokey,doxie,fcra; 

export Key_rmsid_main (boolean  IsFCRA = false) := function
		KeyName       :=cluster.cluster_out+'Key::ucc::';
		
		dMain	:=	if (isFCRA,
										File_UCC_Main_Base_FCRA,
										File_UCC_Main_Base
									);
									
		string fXlateUnprintable(string pInput)	:=stringlib.StringToUpperCase(regexreplace('[^\\x20-\\x7F]',pInput,''));

		Layout_UCC_Common.Layout_ucc_new tProject(File_UCC_Main_Base pInput) := Transform
					SELF.collateral_count   			:=IF(regexreplace('[0-9]',pInput.collateral_count,'')='',pInput.collateral_count,'');
					SELF.static_value							:=fXlateUnprintable(pInput.static_value);
					SELF.date_vendor_removed			:=fXlateUnprintable(pInput.date_vendor_removed);
					SELF.date_vendor_changed			:=fXlateUnprintable(pInput.date_vendor_changed);
					SELF.Filing_Jurisdiction			:=fXlateUnprintable(pInput.Filing_Jurisdiction);
					SELF.orig_filing_number 			:=fXlateUnprintable(pInput.orig_filing_number);
					SELF.orig_filing_type					:=fXlateUnprintable(pInput.orig_filing_type);
					SELF.orig_filing_date					:=fXlateUnprintable(pInput.orig_filing_date);
					SELF.orig_filing_time					:=fXlateUnprintable(pInput.orig_filing_time);
					SELF.filing_number						:=fXlateUnprintable(pInput.filing_number);
					SELF.filing_number_indc			  :=fXlateUnprintable(pInput.filing_number_indc );
					SELF.filing_type							:=fXlateUnprintable(pInput.filing_type);
					SELF.filing_date							:=fXlateUnprintable(pInput.filing_date);
					SELF.filing_time							:=fXlateUnprintable(pInput.filing_time);
					SELF.filing_status						:=fXlateUnprintable(pInput. filing_status);
					SELF.Status_type							:=fXlateUnprintable(pInput.Status_type);
					SELF.page											:=fXlateUnprintable(pInput.page);
					SELF.expiration_date					:=fXlateUnprintable(pInput.expiration_date);
					SELF.contract_type						:=fXlateUnprintable(pInput.contract_type);
					SELF.vendor_entry_date				:=fXlateUnprintable(pInput.vendor_entry_date);
					SELF.vendor_upd_date					:=fXlateUnprintable(pInput.vendor_upd_date);
					SELF.statements_filed					:=fXlateUnprintable(pInput.statements_filed);
					SELF.continuious_expiration		:=fXlateUnprintable(pInput.continuious_expiration);
					SELF.microfilm_number					:=fXlateUnprintable(pInput.microfilm_number);
					SELF.amount										:=fXlateUnprintable(pInput.amount);
					SELF.irs_serial_number				:=fXlateUnprintable(pInput.irs_serial_number);
					SELF.effective_date						:=fXlateUnprintable(pInput.effective_date);
					SELF.Signer_Name							:=fXlateUnprintable(pInput.Signer_Name);
					SELF.title										:=fXlateUnprintable(pInput.title);
					SELF.filing_agency						:=fXlateUnprintable(pInput.filing_agency);
					SELF.address									:=fXlateUnprintable(pInput.address);
					SELF.city											:=fXlateUnprintable(pInput.city);
					SELF.state										:=fXlateUnprintable(pInput.state);
					SELF.county										:=fXlateUnprintable(pInput.county);
					SELF.zip											:=fXlateUnprintable(pInput.zip);
					SELF.duns_number							:=fXlateUnprintable(pInput.duns_number);
					SELF.cmnt_effective_date			:=fXlateUnprintable(pInput.cmnt_effective_date);
					SELF.description							:=fXlateUnprintable(pInput.description);
					SELF.collateral_desc					:=fXlateUnprintable(pInput.collateral_desc);
					SELF.prim_machine							:=fXlateUnprintable(pInput.prim_machine);
					SELF.sec_machine							:=fXlateUnprintable(pInput.sec_machine);
					SELF.manufacturer_code				:=fXlateUnprintable(pInput. manufacturer_code);
					SELF.manufacturer_name				:=fXlateUnprintable(pInput.manufacturer_name);
					SELF.model										:=fXlateUnprintable(pInput.model);
					SELF.model_year								:=fXlateUnprintable(pInput.model_year);
					SELF.model_desc								:=fXlateUnprintable(pInput.model_desc);
					SELF.manufactured_year				:=fXlateUnprintable(pInput.manufactured_year);
					SELF.new_used									:=fXlateUnprintable(pInput.new_used);
					SELF.serial_number						:=fXlateUnprintable(pInput.serial_number);
					SELF.Property_desc						:=fXlateUnprintable(pInput.Property_desc);
					SELF.borough									:=fXlateUnprintable(pInput.borough);
					SELF.block										:=fXlateUnprintable(pInput.block);
					SELF.lot											:=fXlateUnprintable(pInput.lot);
					SELF.collateral_address				:=fXlateUnprintable(pInput.collateral_address);
					SELF.air_rights_indc					:=fXlateUnprintable(pInput.air_rights_indc);
					SELF.subterranean_rights_indc	:=fXlateUnprintable(pInput.subterranean_rights_indc);
					SELF.easment_indc							:=fXlateUnprintable(pInput.easment_indc);
					SELF	             					  := pInput;
	 end;

		dmainBase 	  := 	project(dMain,tProject(left));
		dSort         := 	sort(distribute(dmainBase,hash(tmsid,rmsid)),tmsid,rmsid,local);

		return_file		:= IF (IsFCRA
												,INDEX(dataset([],Layout_UCC_Common.Layout_ucc_new) ,{tmsid,rmsid},{dataset([],Layout_UCC_Common.Layout_ucc_new)},KeyName +'fcra::main_Rmsid_' +  doxie.Version_SuperKey)
												,INDEX(dSort ,{tmsid,rmsid},{dmainBase},KeyName +'main_Rmsid_' +  doxie.Version_SuperKey)
												);
		return(return_file); 
		
end;