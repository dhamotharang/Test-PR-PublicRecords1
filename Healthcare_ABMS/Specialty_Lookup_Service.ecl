/*--SOAP--
<message name="Specialty_Lookup_Service">
	<!-- COMPLIANCE SETTINGS -->
	<part name="ABMSSpecialtyLookupRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

import iesp, AutoStandardI;

export Specialty_Lookup_Service := MACRO
	ds_in := DATASET ([], iesp.abms.t_ABMSSpecialtyLookupRequest) : STORED('ABMSSpecialtyLookupRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	string FilterbySpecialty := first_row.SearchBy.Specialty :stored('Specialty');
	boolean includeSubSpecialty := first_row.Options.includeSubSpecialty : stored('includeSubSpecialty');	

	//Get the Data
	rawRecs := project(ABMS.Keys().Lookups.Specialty.qa, ABMS.Layouts.Lookups.Specialty);
	rawRecs_Filtered := if(FilterbySpecialty<>'',rawRecs(specialty=FilterbySpecialty),rawRecs);
	rawRecs_rolled := dedup(rawRecs_Filtered,specialty,all);
	rawRecs_Final := if(includeSubSpecialty,rawRecs_Filtered,rawRecs_rolled);

	recs := project(rawRecs_Final,transform(iesp.abms.t_ABMSSpecialtyLookupResults,
																					self.Specialty := left.Specialty;
																					self.SubSpecialty := if(includeSubSpecialty,left.sub_specialty,'');
																					self.SpecialtyCode := left.sub_specialty_id;));
	
	iesp.abms.t_ABMSSpecialtyLookupResponse format() := transform
				string q_id := '' 	 : stored ('_QueryId');
				string t_id := '' 	 : stored ('_TransactionId');
				self._Header         := ROW ({0, '', q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				self.RecordCount 		 := count(recs);
				self.Records := choosen(recs,iesp.Constants.HPR.Max_Cnt_Search);
	end;

	Results := dataset([format()]);

	output(Results, named('Results'));
	
ENDMACRO;