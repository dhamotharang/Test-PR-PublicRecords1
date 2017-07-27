/*--SOAP--
<message name="StateLicenseCleanerService">
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
/*--INFO--
<pre>
This service will return a set of cleaned records given License State and License Number
</pre>
*/

EXPORT StateLicenseCleanerService := MACRO
	ds_batch_in_stored := DATASET([], Healthcare_Cleaners.Layouts_StateLicense.LayoutLicenseBatchIn) : STORED('batch_in', FEW);
	getClnLicense := project(ds_batch_in_stored, transform(Healthcare_Cleaners.Layouts_StateLicense.LayoutLicenseBatchOut,
												clnLicense := Healthcare_Cleaners.Functions_StateLicense.getCleanLicense(left.LicenseNumber, left.LicenseState, left.LicenseType);
												self.acctno := left.acctno;
												self.Raw := left;
												Self.LicenseNumber := clnLicense.LicenseNumber;
												Self.LicenseState := clnLicense.LicenseState;
												Self.LicenseType := clnLicense.LicenseType;));
	ut.mac_TrimFields(getClnLicense, 'getClnLicense', Results);
	output(Results, named('Results'));
ENDMACRO;
