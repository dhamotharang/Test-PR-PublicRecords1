/*--SOAP--
<message name="PhoneOwnership_BatchService">
	<part name="batch_in"              					type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DataPermissionMask" 						type="xsd:string"/>
	<part name="DataRestrictionMask" 						type="xsd:string"/>
	<part name="DPPAPurpose"				 						type="xsd:string"/>
	<part name="GLBPurpose"				 							type="xsd:string"/>
	<part name="IndustryClass" 									type="xsd:string"/>
	<part name="UseCase"												type="xsd:string"/>
	<part name="ProductCode"										type="xsd:string"/>
	<part name="BillingID" 											type="xsd:string"/>
	<part name="search_level"										type="xsd:unsignedInt"/>
	<part name="return_current"									type="xsd:boolean"/>
	<part name="MaxIdentityCount"								type="xsd:unsignedInt"/>
	<part name="contact_risk_flag"							type="xsd:boolean"/>
	<part name="reverse_phonescore_model"				type="xsd:string"/>
	<part name="ReturnDetailedRoyalties" 				type="xsd:boolean"/>	
	<separator/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
/*--INFO-- This service returns likely ownership for phone based on CallerID and/or Relative/Employer/Business Associations.
*/

IMPORT AutoKeyI,BatchShare,PhoneOwnership,Phones,Royalty,ut,WSInput;

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
			SELF.err_search := IF(l.phone_number='' OR l.name_first='' OR l.name_last='',AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT,0); 
			SELF := l;
			SELF := [];
		END;
		batch_in_wErr := PROJECT(ds_batch_in, checkValidity(LEFT));
		//********************Get PhoneOwnership Records**************************/
		dBatchPhonesOut := PhoneOwnership.BatchRecords(batch_in_wErr(err_search=0), batch_params);
		BatchShare.MAC_RestoreAcctno(batch_in_wErr, dBatchPhonesOut.Results,Results,TRUE,TRUE);	
		BatchShare.MAC_RestoreAcctno(batch_in_wErr, dBatchPhonesOut.Royalties,Royalties,TRUE,FALSE);	
		dBatchResults := SORT(Results, acctno);
		dBatchRoyalties := SORT(Royalties, acctno);
		
		RoyaltySet := Royalty.GetBatchRoyalties(dBatchRoyalties, batch_params.ReturnDetailedRoyalties);		
			
		OUTPUT(dBatchResults,  NAMED('Results') );		
		OUTPUT(RoyaltySet,  NAMED('RoyaltySet') );		
		OUTPUT(DATASET([],Phones.Layouts.ZumigoIdentity.zOut),NAMED('LOG_delta__phonefinder_delta__phones__gateway'));
				
	ENDMACRO;	