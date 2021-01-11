/*--SOAP--
<message name="PhoneOwnership_BatchService">
	<part name="batch_in"              					type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DataPermissionMask" 					type="xsd:string"/>
	<part name="DataRestrictionMask" 					type="xsd:string"/>
	<part name="DPPAPurpose"				 			type="xsd:string"/>
	<part name="GLBPurpose"				 				type="xsd:string"/>
	<part name="IndustryClass" 							type="xsd:string"/>
	<part name="UseCase"								type="xsd:string"/>
	<part name="ProductCode"							type="xsd:string"/>
	<part name="BillingID" 								type="xsd:string"/>
	<part name="search_level"							type="xsd:unsignedInt"/>
	<part name="return_current"							type="xsd:boolean"/>
	<part name="MaxIdentityCount"						type="xsd:unsignedInt"/>
	<part name="contact_risk_flag"						type="xsd:boolean"/>
	<part name="reverse_phonescore_model"				type="xsd:string"/>
	<part name="ReturnDetailedRoyalties" 				type="xsd:boolean"/>	
	<separator/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- 
This service returns likely ownership for phone based on CallerID and/or Relative/Employer/Business Associations.
The minimum required input is firstname, lastname, and phone with 10 digits.
The service has three flavors:-
 ULTIMATE: validates relatives, employers, associates, and businesses (REAB) data with Carriers\Zumigo
 PREMIUM : get callerID data from Accudata
 BASIC	 : gets phone info from gong, phonesplus, and Bip contacts

 The service outputs 3 datasets:-
 Results
 Royalties
 Zumigo Results
*/

IMPORT AutoKeyI,BatchShare,PhoneOwnership,Phones,STD,Royalty,WSInput, doxie;

EXPORT PhoneOwnership_BatchService(useCannedRecs = 'false') := 
	MACRO
		WSInput.MAC_PhoneOwnership_Batch_Service();
		batch_params		:= PhoneOwnership.IParams.getBatchParams();	
		ds_xml_in_raw  	:= DATASET([], PhoneOwnership.Layouts.BatchIn) : STORED('batch_in', FEW);
		ds_xml_in 			:= IF( useCannedRecs, 
															PROJECT(Phones.BatchCannedInput.PhonesAttribute,TRANSFORM(PhoneOwnership.Layouts.BatchIn,SELF.phone_number:=LEFT.phoneno,SELF:=LEFT,SELF:=[])), 
															ds_xml_in_raw);	

		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);		
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_batch_in);		
		
		//********************Check if recs meet minimum input requirements*********/
		RECORDOF(ds_batch_in) checkValidity(RECORDOF(ds_batch_in) l) := TRANSFORM
			SELF.err_search := IF(LENGTH(STD.Str.Filter(l.phone_number,'0123456789'))<> 10 OR l.name_first='' OR l.name_last='',AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT,0); 
			SELF := l;
			SELF := [];
		END;
		batch_in_wErr := PROJECT(ds_batch_in, checkValidity(LEFT));
		//********************Get PhoneOwnership Records**************************/
		IF(~doxie.compliance.use_WDNC(batch_params.DataPermissionMask), FAIL('Permission not set for TCPA'));
		dBatchPhonesOut := PhoneOwnership.BatchRecords(batch_in_wErr(err_search=0), batch_params);
		BatchShare.MAC_RestoreAcctno(batch_in_wErr, dBatchPhonesOut.Results,Results,TRUE,TRUE);	
		BatchShare.MAC_RestoreAcctno(batch_in_wErr, dBatchPhonesOut.Royalties,Royalties,TRUE,FALSE);	
		BatchShare.MAC_RestoreAcctno(batch_in_wErr, dBatchPhonesOut.ZumigoResults,ZumigoResults,TRUE,FALSE);	
		dBatchResults := SORT(Results, acctno);
		dBatchRoyalties := SORT(Royalties, acctno);
		dBatchZumigoResults := SORT(ZumigoResults, acctno);
		
		RoyaltySet := Royalty.GetBatchRoyalties(dBatchRoyalties, batch_params.ReturnDetailedRoyalties);	
		
		// RQ-15243 Layout mismatch not capturing Zumigo history records
		Zumigo_log_records := DATASET([{dBatchZumigoResults(source = Phones.Constants.GatewayValues.ZumigoIdentity)}], Phones.Layouts.ZumigoIdentity.zDeltabaseLog);
			
		OUTPUT(dBatchResults,  NAMED('Results') );		
		OUTPUT(RoyaltySet,  NAMED('RoyaltySet') );		
		OUTPUT(Zumigo_log_records,NAMED('LOG_DELTA__PHONEFINDER_DELTA__PHONES__GATEWAY'));
				
	ENDMACRO;	