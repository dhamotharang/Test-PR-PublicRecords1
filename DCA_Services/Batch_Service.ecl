/*--SOAP--
<message name="DCA_Services.Batch_Service">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
  <part name="NoCompanyHierarchy"   type="xsd:boolean"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/


EXPORT Batch_Service(useCannedRecs = false) :=
	MACRO

		// **************************************************************************************
		//     Define input XML as a dataset, or use canned records for development/testing.
		// **************************************************************************************
	  // 1. Accept input records.
		ds_xml_in   := DATASET([], DCA_Services.layouts_batch.Batch_in) : STORED('batch_in', FEW);
		ds_batch_in := IF( NOT useCannedRecs, ds_xml_in, DCA_Services._canned_records );
		mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
		BOOLEAN	NoCompanyHierarchy := FALSE	:	STORED('NoCompanyHierarchy');

		// 2. Get matching records and output
		OUTPUT( DCA_Services.Batch_Service_Records(ds_batch_in, mod_access, NoCompanyHierarchy), NAMED('Results') );

	ENDMACRO;
