/*--SOAP--
<message name="FacilityTypeService">
</message>
 Inline dataset to serve the list of facility types 
*/

IMPORT Healthcare_Lookups,IESP;
export FacilityTypeService := MACRO
	rawRecs := Healthcare_Lookups.Functions_FacilityType.Values;
	ds := Project(rawRecs,transform(iesp.ws_healthcare_utility_svc.t_ListFacilityTypesResult,self.ID:=(string)left.FacilityTypeID;self.name:=left.FacilityTypeName));
	iesp.ws_healthcare_utility_svc.t_ListFacilityTypesResponse format() := transform
				string q_id := '' : stored ('_QueryId');
				string t_id := '' : stored ('_TransactionId');
				self._Header.status        	:= 0;
				self._Header.message        := '';
				self._Header.queryid        := q_id;
				self._Header.transactionid  := t_id;
				self.RecordCount := count(ds);
				self.FacilityTypes	:= ds;
				self := [];
	end;
	results := dataset([format()]);
	output(results, named('Results'));
ENDMACRO;
