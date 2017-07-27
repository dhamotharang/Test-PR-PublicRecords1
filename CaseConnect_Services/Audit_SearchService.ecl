/*--SOAP--
<message name='SearchService'		wuTimeout='300000'>	
	<part name='DID'   						type='xsd:string'/>		
	<separator />
  <part name="AuditSearchRequest" type="tns:XmlDataSet" cols="80" rows="20" />
</message>
*/
/*--HELP--
<pre>
&lt;AuditSearchRequest&gt;
&lt;row&gt;
	&lt;Options&gt;
		&lt;UseNickNames&gt;0&lt;/UseNickNames&gt;
		&lt;UsePhonetics&gt;0&lt;/UsePhonetics&gt;
		&lt;StartingRecord&gt;1&lt;/StartingRecord&gt;
		&lt;ReturnCount&gt;30&lt;/ReturnCount&gt;
		&lt;DateStart&gt;
			&lt;Year&gt;&lt;/Year&gt;
			&lt;Month&gt;&lt;/Month&gt;
			&lt;Day&gt;&lt;/Day&gt;
		&lt;/DateStart&gt;
		&lt;DateEnd&gt;
			&lt;Year&gt;&lt;/Year&gt;
			&lt;Month&gt;&lt;/Month&gt;
			&lt;Day&gt;&lt;/Day&gt;
		&lt;/DateEnd&gt;
	&lt;/Options&gt;
	&lt;SearchBy&gt;
		&lt;Name&gt;
			&lt;Full&gt;&lt;/Full&gt;
			&lt;First&gt;&lt;/First&gt;
			&lt;Middle&gt;&lt;/Middle&gt;
			&lt;Last&gt;&lt;/Last&gt;
			&lt;Suffix&gt;&lt;/Suffix&gt;
			&lt;Prefix&gt;&lt;/Prefix&gt;
		&lt;/Name&gt;
		&lt;Address&gt;
			&lt;StreetNumber&gt;&lt;/StreetNumber&gt;
			&lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
			&lt;StreetName&gt;&lt;/StreetName&gt;
			&lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
			&lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
			&lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
			&lt;UnitNumber&gt;&lt;/UnitNumber&gt;
			&lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
			&lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
			&lt;City&gt;&lt;/City&gt;
			&lt;State&gt;&lt;/State&gt;
			&lt;Zip5&gt;&lt;/Zip5&gt;
			&lt;Zip4&gt;&lt;/Zip4&gt;
			&lt;County&gt;&lt;/County&gt;
			&lt;PostalCode&gt;&lt;/PostalCode&gt;
			&lt;StateCityZip&gt;&lt;/StateCityZip&gt;
		&lt;/Address&gt;
		&lt;DOB&gt;
			&lt;Year&gt;&lt;/Year&gt;
			&lt;Month&gt;&lt;/Month&gt;
			&lt;Day&gt;&lt;/Day&gt;
		&lt;/DOB&gt;
		&lt;SSN&gt;&lt;/SSN&gt;
		&lt;UniqueId&gt;&lt;/UniqueId&gt;
		&lt;Phone10&gt;&lt;/Phone10&gt;
		&lt;DriversLicense&gt;&lt;/DriversLicense&gt;
		&lt;CompanyName&gt;&lt;/CompanyName&gt;
		&lt;BusinessId&gt;&lt;/BusinessId&gt;
		&lt;DomainName&gt;&lt;/DomainName&gt;
		&lt;UserId&gt;&lt;/UserId&gt;
		&lt;CompanyIds&gt;
			&lt;CompanyId&gt;&lt;/CompanyId&gt;
		&lt;/CompanyIds&gt;
		&lt;ExclusionList&gt;
			&lt;UserId&gt;&lt;/UserId&gt;
		&lt;/ExclusionList&gt;
	&lt;/SearchBy&gt;
	&lt;/row&gt;
&lt;/AuditSearchRequest&gt;
</pre>
*/
import iesp;

EXPORT Audit_SearchService := MACRO

	ds_in := DATASET ([], iesp.deconfliction_audit.t_AuditSearchRequest) : STORED('AuditSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	CaseConnect_Services.IParam.SetInputRequest(first_row.searchBy);	
	CaseConnect_Services.IParam.SetInputOptions(first_row.options);
	tmpMod := CaseConnect_Services.IParam.getSearchModule(first_row);
	
	exclusionCount := Count(first_row.searchBy.ExclusionList);
	records := if (exclusionCount >= iesp.Constants.DECONFLICTION.MAX_EXCL_UIDS, 
		fail(dataset([], iesp.deconfliction_audit.t_AuditRecord), 510, 'Exclusion list limit exceeded'), 
			CaseConnect_Services.Audit_SearchRecords(tmpMod));
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(records, iespOutput, iesp.deconfliction_audit.t_AuditSearchResponse);
	output(iespOutput, named('Results'));
ENDMACRO;
