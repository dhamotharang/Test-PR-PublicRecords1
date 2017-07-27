/*--SOAP--
<message name="TaxonomyService">
	<part name="TaxonomySearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
 Inline dataset to serve the list of facility types 
*/

IMPORT Healthcare_Lookups, IESP;
export TaxonomyService := MACRO
	ds_in := DATASET ([], iesp.ws_healthcare_utility_svc.t_TaxonomySearchRequest) : STORED('TaxonomySearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;	
	isCodeSearch 						:= first_row.SearchBy.Code <> '';
	isCrosswalkSearch 			:= first_row.SearchBy.HMSCode <> '';
	isGroupingSearch 				:= first_row.SearchBy.Grouping <> '';
	isClassificationSearch 	:= first_row.SearchBy.Classification <> '';
	isSpecializationSearch 	:= first_row.SearchBy.Specialization <> '';
	isGeneralGroupListing		:= not isCodeSearch and not isCrosswalkSearch and not isGroupingSearch and not isClassificationSearch and not isSpecializationSearch;
	getResults := map(isCodeSearch => Healthcare_Lookups.Functions_Taxonomy.getTaxonomybyCode(first_row.SearchBy.Code),
										isCrosswalkSearch => Healthcare_Lookups.Functions_Taxonomy.getTaxonomybyHMSCode(first_row.SearchBy.HMSCode),
										isGroupingSearch => Healthcare_Lookups.Functions_Taxonomy.getTaxonomyClassificationByGrouping(first_row.SearchBy.Grouping),
										isClassificationSearch => Healthcare_Lookups.Functions_Taxonomy.getTaxonomySpecializationByClassification(first_row.SearchBy.Classification),
										isSpecializationSearch => Healthcare_Lookups.Functions_Taxonomy.getTaxonomySpecialization(first_row.SearchBy.Specialization),
										Healthcare_Lookups.Functions_Taxonomy.getTaxonomyGroupings);
	fmtResults := Project(getResults, transform(iesp.ws_healthcare_utility_svc.t_TaxonomySearchResult,
																							self.Code := if(isGeneralGroupListing,'',left.code);
																							self.HMSCode := if(isGeneralGroupListing,'',left.HMSCode);
																							self.Grouping := left.Grouping;
																							self.Classification := if(isGeneralGroupListing,'',left.Classification);
																							self.Specialization := if(isGeneralGroupListing,'',left.Specialization);
																							self.LastLetterDescription := if(isGeneralGroupListing,'',left.LastLetterDescription);
																							self.EffectiveDate := iesp.ecl2esp.toDate(if(isGeneralGroupListing,0,(integer)left.EffectiveDate));
																							self.DeactivationDate := iesp.ecl2esp.toDate(if(isGeneralGroupListing,0,(integer)left.DeactivationDate));
																							self.LastModifiedDate := iesp.ecl2esp.toDate(if(isGeneralGroupListing,0,(integer)left.LastModifiedDate));
																							self:=[];));
	appendNotes := if(first_row.Options.IncludeNotes,
																			project(fmtResults,transform(iesp.ws_healthcare_utility_svc.t_TaxonomySearchResult,
																							self.Notes := if(isGeneralGroupListing,'',Healthcare_Lookups.Functions_Taxonomy.getNotesByTaxonomyCode(left.Code)[1].Notes);
																							self:=left;))
																			,fmtResults);
	appendDefinition := if(first_row.Options.IncludeDefinition,
																			project(appendNotes,transform(iesp.ws_healthcare_utility_svc.t_TaxonomySearchResult,
																							self.Definition := if(isGeneralGroupListing,'',Healthcare_Lookups.Functions_Taxonomy.getDefinitionByTaxonomyCode(left.Code)[1].Definition);
																							self:=left;))
																			,appendNotes);

	results := project(dataset([{'1'}],{string acctno;}), transform(iesp.ws_healthcare_utility_svc.t_TaxonomySearchResponse,
																						self.SearchBy:= first_row.SearchBy;
																						self.SearchOptions:=first_row.options;
																						self.RecordCount := count(appendDefinition);
																						self.Taxonomies := appendDefinition;
																						self:=left;self := [];));
	// OUTPUT(inRec, NAMED('inRec'));
	// OUTPUT(TempResult, NAMED('TempResult'));
	OUTPUT(Results, NAMED('Results'));
ENDMACRO;
