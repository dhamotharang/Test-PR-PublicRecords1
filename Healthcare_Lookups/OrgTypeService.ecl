/*--SOAP--
<message name="OrgTypeService">
</message>
 Inline dataset to serve the list of facility types 
*/

IMPORT Healthcare_Lookups;
export OrgTypeService := MACRO
	rawRecs := Healthcare_Lookups.Functions_OrgType.Values;
	ds := Project(rawRecs,transform(iesp.ws_healthcare_utility_svc.t_ListOrganizationTypesResult,self.ID:=(string)left.OrgTypeID;self.name:=left.OrgTypeName));
	iesp.ws_healthcare_utility_svc.t_ListOrganizationTypesResponse format() := transform
				string q_id := '' : stored ('_QueryId');
				string t_id := '' : stored ('_TransactionId');
				self._Header.status        	:= 0;
				self._Header.message        := '';
				self._Header.queryid        := q_id;
				self._Header.transactionid  := t_id;
				self.RecordCount := count(ds);
				self.OrganizationTypes	:= ds;
				self := [];
	end;
	results := dataset([format()]);
	output(results, named('Results'));
ENDMACRO;
