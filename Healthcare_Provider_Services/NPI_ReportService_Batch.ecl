/*--SOAP--
<message name="NPI_ReportService_Batch">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
  <part name="batch_in" 						type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="DataRestrictionMask" 	type="xsd:string" default="00000000000"/>
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt"/>
</message>
*/
import Autokey_batch,AutoStandardI;

EXPORT NPI_ReportService_Batch () := FUNCTION

	Batch_In := DATASET ([], Healthcare_Provider_Services.NPI_Layouts.t_NPIBatchRequest) : STORED('batch_in', FEW);

	NPI_Batch_Request	:=	PROJECT	(Batch_In, TRANSFORM (Healthcare_Provider_Services.NPI_Layouts.batch_in,	SELF	:=	LEFT;));

	// text := NPI_Batch_Request[1].NpiNumber;

	// #stored('MessageText', text);

	// string MessageString := '' : STORED('MessageText');

	// Outcome := ThorLib.LogString(MessageString);

	// output(Outcome,named('Outcome'));
	
  in_mod := module (Healthcare_Provider_Services.CLIA_Interfaces.clia_config)
		export unsigned4 MaxRecordsPerRow 	:= 	4 : stored('MaxRecordsPerRow');
		export unsigned4 penalty_threshold 	:= 	10 : stored('penalty_threshold');
		export string applicationType				:= 	AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
  end;

	NPI_Data := GetNPIRecords (NPI_Batch_Request,in_mod);

	RETURN OUTPUT (NPI_Data,NAMED('Results'));
END;