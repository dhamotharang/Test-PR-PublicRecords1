import	Address,Codes,iesp,InsuranceContext_iesp,ut,std;  

export	Convert2IESP(	PropertyCharacteristics_Services.IParam.Report	pInMod,
											iesp.property_info.t_PropertyInformationRequest	pRequest
										)	:=
module

	// Function to populate the inquiry report section
	export	iesp.property_info.t_PropertyInformationReportBy	SetReportBy(Address.ICleanAddress	clean_addr)	:=
	function
		iesp.property_info.t_PropertyInformationReportBy	tReportBy(iesp.property_info.t_PropertyInformationRequest	pInput)	:=
		transform
			self.AddressInfo.StreetNumber					:=	clean_addr.prim_range;
			self.AddressInfo.StreetPreDirection		:=	clean_addr.predir;
			self.AddressInfo.StreetName						:=	clean_addr.prim_name;
			self.AddressInfo.StreetSuffix					:=	clean_addr.suffix;
			self.AddressInfo.StreetPostDirection	:=	clean_addr.postdir;
			self.AddressInfo.UnitDesignation			:=	clean_addr.unit_desig;
			self.AddressInfo.UnitNumber						:=	clean_addr.sec_range;
			self.AddressInfo.City									:=	clean_addr.v_city;
			self.AddressInfo.State								:=	clean_addr.state;
			self.AddressInfo.Zip5									:=	clean_addr.zip;
			self.AddressInfo.Zip4									:=	clean_addr.zip4;
			self.AddressInfo.StreetAddress1				:=	address.Addr1FromComponents(	clean_addr.prim_range,
																																							clean_addr.predir,
																																							clean_addr.prim_name,
																																							clean_addr.suffix,
																																							clean_addr.postdir,
																																							clean_addr.unit_desig,
																																							clean_addr.sec_range
																																						)[1..60];
			self.AddressInfo.StreetAddress2				:=	address.Addr1FromComponents(	clean_addr.prim_range,
																																							clean_addr.predir,
																																							clean_addr.prim_name,
																																							clean_addr.suffix,
																																							clean_addr.postdir,
																																							clean_addr.unit_desig,
																																							clean_addr.sec_range
																																						)[61..];
			self.AddressInfo.StateCityZip					:=	Address.Addr2FromComponents(	clean_addr.v_city,
																																							clean_addr.state,
																																							clean_addr.zip
																																						);
			self.AddressInfo.CensusTract					:=	clean_addr.geo_blk[1..4]	+	'.'	+	clean_addr.geo_blk[5..6];
			self																	:=	pInput.ReportBy;
		end;
		
		return	project(pRequest,tReportBy(left));
	end;
	
	// Function to populate the ReportID header section
	// TODO: remove defaults?
	export	iesp.property_info.t_ReportIdSection	SetReportID(	InsuranceContext_iesp.insurance_risk_context.t_PropertyInformationContext	pInsContext,
																															// iesp.property_value_report.t_PropertyValueReportResponseEx								pGatewayResponse,
																															unsigned																																	combined_errors,
																															boolean																																		pLNPropResultsExists	= false,
																															boolean                                                                   isHomeGateway = false                            
																														)	:=
	function	
		boolean		valid_account		:=	pInsContext.Account.MBSId	=	''			or
																	pInsContext.Account.Status	!=	'A'	or
																	pInsContext.Products.PROPINFO.Status	!=	'A';
		
		unsigned	required_input	:=	Constants.InternalCodes.INSUFFICIENT_ADDRESS	+
																	Constants.InternalCodes.LAST_NAME_REQUIRED		+
																	Constants.InternalCodes.FIRST_NAME_REQUIRED		+
																	Constants.InternalCodes.LIVING_AREA_SQFT_REQUIRED;
		
		boolean		insufficient_address	:=	combined_errors	&	Constants.InternalCodes.INSUFFICIENT_ADDRESS	=	Constants.InternalCodes.INSUFFICIENT_ADDRESS;
		
		iesp.property_info.t_ReportIdSection	tReportID()	:=
		transform
			self.ServiceType								:=	pInMod.ReportType;
			self.AccountNumber							:=	pInsContext.Account.Legacy.Base;
			self.AccountSuffix							:=	pInsContext.Account.Legacy.Suffix;
			self.OrderDate									:=	iesp.ECL2ESP.toDate((INTEGER)Std.Date.Today());
			self.ReceiptDate								:=	iesp.ECL2ESP.toDate((INTEGER)Std.Date.Today());
			self.CompletionDate							:=	iesp.ECL2ESP.toDate((INTEGER)Std.Date.Today());
			self.ProcessingStatus						:=	map(	valid_account																																		=>	'4',
																								pInMod.ReportType	not in	['K','L']	AND ~isHomeGateway          								=>	'7',
			// TODO: there's slight change of logic in relation to "living square footage" here:
																								combined_errors & required_input	>	0																						=>	'5',
																								// exists(pGatewayResponse.Response._Header.Exceptions)														=>	'8',
																								// pGatewayResponse.Response.Result.Report.Properties[1].Response.ErrorCode	=	'0'	=>	'1',
                                                 isHomeGateway AND pLNPropResultsExists                                         =>  '1',
																								'2'
																							);
			self.AttachmentProcessingStatus	:=	map(	isHomeGateway                       =>  '',
			                                          valid_account												=>	'4',
																								pInMod.ReportType	not in	['I','K','P']	=>	'7',
																								insufficient_address								=>	'5',
																								pLNPropResultsExists								=>	'1',
																								'2'
																							);
			self														:=	[];
		end;
		
		return	row(tReportID());
	end;

/*  MC
	// ITV REPORT SECTION
	// Function to populate cost summary
	iesp.property_info.t_CostSummaryRecordReport	SetITVCostSummary(iesp.property_value_report.t_ERCSummary	pERCSummary)	:=
	function
		iesp.property_info.t_CostSummaryRecordReport	tITVCostSummary(iesp.property_value_report.t_ERCSummary	pInput)	:=
		transform
			self.InsuranceToValue					:=	round((real) pInput.ITV);
			self.EstimatedReplacementCost	:=	(unsigned)stringlib.stringfilterout(pInput.ERC,',');
			self.Profit										:=	(unsigned)stringlib.stringfilterout(pInput.Profit,',');
			self.ArchitectAmount					:=	(unsigned)stringlib.stringfilterout(pInput.Architect,',');
			self.SalesTaxIncluded					:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.IncludesTax),
																							'TRUE'	=>	'Y',
																							'FALSE'	=>	'N',
																							'U'
																						);
			self.DebrisAmount							:=	(unsigned)stringlib.stringfilterout(pInput.Debris,',');
			self.ActualCashValue					:=	(unsigned)stringlib.stringfilterout(pInput.ACV,',');
			self.OverheadAmount						:=	(unsigned)stringlib.stringfilterout(pInput.Overhead,',');
			self.EstReplacementCostScore	:=	(unsigned)pInput.Score;
			self.ActualCashValueScore			:=	(unsigned)pInput.ACVScore;
		end;
		
		return	project(pERCSummary,tITVCostSummary(left));
	end;
	
	// Function to populate property attributes
	iesp.property_info.t_PropertyAttributesReport	SetITVPropAttr(	iesp.property_value_report.t_PropertyCharacteristics	pPropAttr,
																																iesp.property_value_report.t_PolicyInformation				pPolicyInfo,
																																string																								pPropertyID
																															)	:=
	function
		iesp.property_info.t_PropertyAttributesReport	tITVPropAttr(iesp.property_value_report.t_PropertyCharacteristics	pInput)	:=
		transform
			self.LivingAreaSF							:=	(string)pInput.LivingArea;
			self.Bedrooms									:=	(string)pInput.Bedrooms;
			self.Baths										:=	(string)pInput.Bathrooms;
			self.Stories									:=	(string)pInput.Stories;
			self.Fireplaces								:=	(string)pInput.Fireplaces;
			self.Pool											:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.Pool),
																							'TRUE'	=>	'Y',
																							'FALSE'	=>	'N',
																							'U'
																						);
			self.AC												:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.AC),
																							'TRUE'	=>	'Y',
																							'FALSE'	=>	'N',
																							'U'
																						);
			self.FireplaceIndicator				:=	if(pInput.Fireplaces	!=	0,'Y','U');
			self.QualityOfStructCode			:=	pInput.Quality;
			self.QualityOfStruct					:=	PropertyCharacteristics_Services.Code_Translations.QualityDesc(pInput.Quality);
			self.TypeOfResidence					:=	pInput.Residence;
			self.PolicyCoverageValue			:=	pPolicyInfo.PolicyValue;
			self.ReplacementCostReportId	:=	pPropertyID;
			
			self													:=	pInput;
			self													:=	[];
		end;
		
		return	project(pPropAttr,tITVPropAttr(left));
	end;
	
	// Function to populate property characteristics
	iesp.property_info.t_PropertyCharacteristicRecordReport	SetITVPropChar(dataset(iesp.property_value_report.t_PropertyDetail)	pPropDetail)	:=
	function
		iesp.property_info.t_PropertyCharacteristicRecordReport	tITVPropChar(iesp.property_value_report.t_PropertyDetail	pInput)	:=
		transform,skip(PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.AttributeType)	=	'ADDITIONAL FEATURES')
			string	vFieldName			:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.AttributeType),
																				'APPLIANCES, BUILT-IN'	=>	'APPLIANCES_BUILT_IN',
																				'BASE COST'							=>	'BASECOST',
																				'CLIMATE CONTROL'				=>	'CLIMATE_CONTROL',
																				'DECKS & PATIOS'				=>	'DECKS_PATIOS',
																				'DETACHED PARKING'			=>	'DETACHED_PARKING',
																				'EXTERIOR FINISH'				=>	'EXTERIOR_FINISH',
																				'WALLS AND CEILINGS'		=>	'WALLS_CEILINGS',
																				PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.AttributeType)
																			);
			
			string	vCommonCodeDesc	:=	Codes.KeyCodes('PROPERTYINFO',vFieldName,'PINFO',pInput.Material);
			
			self.Category				:=	if(	vCommonCodeDesc[5..7]	!=	'',
																	vCommonCodeDesc[5..7],
																	skip
																);
			self.CategoryDesc		:=	PropertyCharacteristics_Services.Code_Translations.CommonCategoryDesc(self.Category);
			self.Material				:=	if(	vCommonCodeDesc[1..3]	!=	'',
																	vCommonCodeDesc[1..3],
																	skip
																);
			self.MaterialDesc		:=	vCommonCodeDesc[9..];
			self.Quality				:=	PropertyCharacteristics_Services.Code_Translations.Quality(pInput.Quality);
			self.QualityDesc		:=	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.Quality);
			self.Condition			:=	PropertyCharacteristics_Services.Code_Translations.Condition(pInput.Condition);
			self.ConditionDesc	:=	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.Condition);
			self.Value					:=	if(	(real)pInput.Value	!=	0,
																	(real8)stringlib.stringfilterout(pInput.Value,','),
																	skip
																);
			self.ERCValue				:=	(unsigned)stringlib.stringfilterout(pInput.ERCValue,',');
			self								:=	pInput;
			self								:=	[];
		end;
		
		return	project(pPropDetail,tITVPropChar(left));
	end;
	
	// Function to populate property description
	iesp.property_info.t_PropertyDescriptionRecordPartReport	SetITVPropDesc(dataset(iesp.property_value_report.t_PropertyDetail)	pPropDetail)	:=
	function
		iesp.property_info.t_PropertyDescriptionRecordPartReport	tITVPropDesc(iesp.property_value_report.t_PropertyDetail	pInput)	:=
		transform,skip(PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.AttributeType)	!=	'ADDITIONAL FEATURES')			
			self.PropertyDesc										:=	if(	pInput.Description	!=	'',
																									pInput.Description,
																									skip
																								);
			self.PropertyAdditionValue					:=	if(	(real)pInput.Value	!=	0,
																									(real8)stringlib.stringfilterout(pInput.Value,','),
																									skip
																								);
			self.PropertyAdditionQuality				:=	PropertyCharacteristics_Services.Code_Translations.Quality(pInput.Quality);
			self.PropertyAdditionQualityDesc		:=	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.Quality);
			self.PropertyAdditionCondition			:=	PropertyCharacteristics_Services.Code_Translations.Condition(pInput.Condition);
			self.PropertyAdditionConditionDesc	:=	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.Condition);
			self.ERCValue												:=	(unsigned)stringlib.stringfilterout(pInput.ERCValue,',');
			self																:=	pInput;
			self																:=	[];
		end;
		
		return	project(pPropDetail,tITVPropDesc(left));
	end;
	
	// Function to convert ERC gateway response to ITV section in property info
	export	iesp.property_info.t_EstimatedReplacementCost	ConvertGatewayResponse2ITV(iesp.property_value_report.t_PropertyOut	pInput)	:=
	transform
		self.CostSummary									:=	SetITVCostSummary(pInput.Summary);
		self.PropertyAttributes						:=	SetITVPropAttr(pInput.PropertyCharacteristics,pInput.PolicyInformation,pInput.PropertyID);
		self.PropertyCharacteristics			:=	SetITVPropChar(pInput.PropertyDetails);
		self.PropertyDescriptionRecordSet	:=	SetITVPropDesc(pInput.PropertyDetails);
	end;
*/
	
	// PROPERTY DATA ITEM SECTION	
	// Risk address transform function
	iesp.property_info.t_AddressInfo	SetPropDataRiskAddress(PropertyCharacteristics_Services.Layouts.Payload	pRow)	:=
	function
		iesp.property_info.t_AddressInfo	tRiskAddress(PropertyCharacteristics_Services.Layouts.Payload	pInput)	:=
		transform
			self.StreetNumber					:=	pInput.prim_range;
			self.StreetPreDirection		:=	pInput.predir;
			self.StreetName						:=	pInput.prim_name;
			self.StreetSuffix					:=	pInput.addr_suffix;
			self.StreetPostDirection	:=	pInput.postdir;
			self.UnitDesignation			:=	pInput.unit_desig;
			self.UnitNumber						:=	pInput.sec_range;
			self.City									:=	pInput.v_city_name;
			self.State								:=	pInput.st;
			self.Zip5									:=	pInput.zip;
			self.Zip4									:=	pInput.zip4;
			self.County								:=	pInput.county_name;
			self.PostalCode						:=	'';
			self.StreetAddress1				:=	pInput.property_street_address[1..60];
			self.StreetAddress2				:=	pInput.property_street_address[61..];
			self.StateCityZip					:=	pInput.property_city_state_zip;
			self.CensusTract					:=	pInput.census_tract;
		end;
		
		return	project(pRow,tRiskAddress(left));
	end;
	
	// Property attributes transform function
	iesp.property_info.t_PropertyAttributesReport	SetPropDataAttr(PropertyCharacteristics_Services.Layouts.Payload	pRow)	:=
	function
		iesp.property_info.t_PropertyAttributesReport	tPropAttr(PropertyCharacteristics_Services.Layouts.Payload	pInput)	:=
		transform
			self.LivingAreaSF							:=	if(	pInput.living_area_square_footage	!=	'',
																						pInput.living_area_square_footage,
																						if(pRequest.ReportBy.PropertyAttributes.LivingAreaSF	!=	'' OR pInput.src_building_square_footage = 'DEFLT',
																								'',
																								pInput.building_square_footage)
																					);
			self.Stories									:=	pInput.no_of_stories;
			self.Bedrooms									:=	pInput.no_of_bedrooms;
			self.Baths										:=	pInput.no_of_baths;
			self.Fireplaces								:=	pInput.no_of_fireplaces;
			self.Pool											:=	if(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.pool_indicator)	in	['Y','N','U'],
																						PropertyCharacteristics_Services.Functions.fnClean2Upper(pInput.pool_indicator),
																						''
																					);
			self.AC												:=	map(	pInput.air_conditioning_type	=		'NON'	=>	'N',
																							pInput.air_conditioning_type	=		'UNK'	=>	'U',
																							pInput.air_conditioning_type	!=	''		=>	'Y',
																							''
																						);
			self.YearBuilt								:=	(unsigned)pInput.year_built;
			self.QualityOfStructCode			:=	pInput.structure_quality;
			self.QualityOfStruct					:=	Codes.KeyCodes('PROPERTYINFO','QUALITY','COMMN',self.QualityOfStructCode);
			self.ReplacementCostReportId	:=	'';
			self.PolicyCoverageValue			:=	0;
			self.FireplaceIndicator				:=	pInput.fireplace_ind;
			self.Units										:=	(unsigned)pInput.no_of_units;
			self.Rooms										:=	(unsigned)pInput.no_of_rooms;
			self.FullBaths								:=	(unsigned)pInput.no_of_full_baths;
			self.HalfBaths								:=	(unsigned)pInput.no_of_half_baths;
			self.BathFixtures							:=	(unsigned)pInput.no_of_bath_fixtures;
			self.EffectiveYearBuilt				:=	(unsigned)pInput.effective_year_built;
			self.SlopeCode								:=	'';
			self.Slope										:=	'';
			self.ConditionOfStructureCode	:=	'';
			self.ConditionOfStructure			:=	'';
			self.BuildingAreaSF						:=	(unsigned)pInput.building_square_footage;
			self.GroundFloorAreaSF				:=	(unsigned)pInput.first_floor_square_footage;
			self.BasementAreaSF						:=	(unsigned)pInput.basement_square_footage;
			self.GarageAreaSF							:=	(unsigned)pInput.garage_square_footage;
			self.TypeOfResidence					:=	'';
			self.FloodZonePanelNumber			:=	pInput.flood_zone_panel;
			self.StoriesType							:=	pInput.stories_type;
		end;
		
		return	project(pRow,tPropAttr(left));
	end;
	
	// Property characteristics transform function
	iesp.property_info.t_PropertyCharacteristicRecordReport	SetPropDataChar(PropertyCharacteristics_Services.Layouts.Payload	pRow)	:=
	function
		dSlimmed	:=	project(pRow,transform(PropertyCharacteristics_Services.Layouts.SlimmedPropChar,self	:=	left));
		
		iesp.property_info.t_PropertyCharacteristicRecordReport	tPropChar(PropertyCharacteristics_Services.Layouts.SlimmedPropChar	pInput,integer	cnt)	:=
		transform
			self.Category			:=	choose(	cnt,
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('AIR_CONDITIONING_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('BASEMENT_FINISH'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('CONSTRUCTION_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('EXTERIOR_WALL'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('FIREPLACE_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('FLOOR_COVER'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('FOUNDATION_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('FRAME'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('FUEL_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('GARAGE_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('HEATING_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('PARKING_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('POOL_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('ROOF_COVER_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('ROOF_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('SEWER_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('STYLE_TYPE'),
																		PropertyCharacteristics_Services.Code_Translations.CommonCategoryCode('WATER_TYPE')
																	);
			self.CategoryDesc	:=	PropertyCharacteristics_Services.Code_Translations.CommonCategoryDesc(self.category);
			self.Material			:=	choose(	cnt,
																		pInput.air_conditioning_type,
																		pInput.basement_finish,
																		pInput.construction_type,
																		pInput.exterior_wall,
																		pInput.fireplace_type,
																		pInput.floor_type,
																		pInput.foundation,
																		pInput.frame_type,
																		pInput.fuel_type,
																		pInput.garage,
																		pinput.heating,
																		pInput.parking_type,
																		pInput.pool_type,
																		pInput.roof_cover,
																		pInput.roof_type,
																		pInput.sewer,
																		pInput.style_type,
																		pInput.water
																	);
			self.MaterialDesc	:=	choose(	cnt,
																		Codes.KeyCodes('PROPERTYINFO','AIR_CONDITIONING_TYPE'	,'COMMN',pInput.air_conditioning_type),
																		Codes.KeyCodes('PROPERTYINFO','BASEMENT_FINISH'				,'COMMN',pInput.basement_finish),
																		Codes.KeyCodes('PROPERTYINFO','CONSTRUCTION_TYPE'			,'COMMN',pInput.construction_type),
																		Codes.KeyCodes('PROPERTYINFO','EXTERIOR_WALL'					,'COMMN',pInput.exterior_wall),
																		Codes.KeyCodes('PROPERTYINFO','FIREPLACE_TYPE'				,'COMMN',pInput.fireplace_type),
																		Codes.KeyCodes('PROPERTYINFO','FLOOR_COVER'						,'COMMN',pInput.floor_type),
																		Codes.KeyCodes('PROPERTYINFO','FOUNDATION_TYPE'				,'COMMN',pInput.foundation),
																		Codes.KeyCodes('PROPERTYINFO','FRAME'									,'COMMN',pInput.frame_type),
																		Codes.KeyCodes('PROPERTYINFO','FUEL_TYPE'							,'COMMN',pInput.fuel_type),
																		Codes.KeyCodes('PROPERTYINFO','GARAGE_TYPE'						,'COMMN',pInput.garage),
																		Codes.KeyCodes('PROPERTYINFO','HEATING_TYPE'					,'COMMN',pinput.heating),
																		Codes.KeyCodes('PROPERTYINFO','PARKING_TYPE'					,'COMMN',pInput.parking_type),
																		Codes.KeyCodes('PROPERTYINFO','POOL_TYPE'							,'COMMN',pInput.pool_type),
																		Codes.KeyCodes('PROPERTYINFO','ROOF_COVER_TYPE'				,'COMMN',pInput.roof_cover),
																		Codes.KeyCodes('PROPERTYINFO','ROOF_TYPE'							,'COMMN',pInput.roof_type),
																		Codes.KeyCodes('PROPERTYINFO','SEWER_TYPE'						,'COMMN',pInput.sewer),
																		Codes.KeyCodes('PROPERTYINFO','STYLE_TYPE'						,'COMMN',pInput.style_type),
																		Codes.KeyCodes('PROPERTYINFO','WATER_TYPE'						,'COMMN',pInput.water)
																	);
			self							:=	[];
		end;
		
		dNormalize	:=	normalize(dataset(dSlimmed),19,tPropChar(left,counter));
				
		return	dedup(dNormalize(Material	!=	'' and	MaterialDesc	!=	''),all);
	end;
	
	// Property mortgage info transform function
	iesp.property_info.t_MortgageRecordReport	SetPropDataMortgageInfo(PropertyCharacteristics_Services.Layouts.Payload	pRow)	:=
	function
		dSlimmed	:=	project(pRow,transform(PropertyCharacteristics_Services.Layouts.SlimmedMortgage,self	:=	left));
		
		iesp.property_info.t_MortgageRecordReport	tMortgageInfo(PropertyCharacteristics_Services.Layouts.SlimmedMortgage	pInput,integer	cnt)	:=
		transform
			self.MortgageCompanyName	:=	choose(cnt,pInput.mortgage_company_name,'');
			self.MortgageType					:=	choose(cnt,1,2);
			self.LoanAmount						:=	choose(cnt,(real)pInput.loan_amount,(real)pInput.second_loan_amount);
			self.LoanTypeCode					:=	choose(cnt,pInput.loan_type_code,'');
			self.LoanType							:=	choose(cnt,Codes.KeyCodes('PROPERTYINFO','MORTGAGE_LOAN_TYPE_CODE','COMMN',pInput.loan_type_code),'');
			self.InterestRateTypeCode	:=	choose(cnt,pInput.interest_rate_type_code,'');
			self.InterestRateType			:=	choose(cnt,Codes.KeyCodes('PROPERTYINFO','TYPE_FINANCING','COMMN',pInput.interest_rate_type_code),'');
			self											:=	[];
		end;
		
		return	normalize(dataset(dSlimmed),if(dSlimmed.second_loan_amount	!=	'',2,1),tMortgageInfo(left,counter));
	end;
	
	// Property sales info transform function
	iesp.property_info.t_PropertySalesInfoRecordReport	SetPropDataSalesInfo(PropertyCharacteristics_Services.Layouts.Payload	pRow)	:=
	function
		iesp.property_info.t_PropertySalesInfoRecordReport	tPropSalesInfo(PropertyCharacteristics_Services.Layouts.Payload	pInput)	:=
		transform
			self.Classification			:=	'';
			self.DeedRecordingDate	:=	iesp.ECL2ESP.toDate((unsigned)pInput.deed_recording_date);
			self.SalesDate					:=	iesp.ECL2ESP.toDate((unsigned)pInput.sale_date);
			self.DeedDocumentNumber	:=	pInput.deed_document_number;
			self.SalesAmount				:=	(real)pInput.sale_amount;
			self.SalesTypeCode			:=	pInput.sale_type_code;
			self.SalesType					:=	Codes.KeyCodes('PROPERTYINFO','SALE_TRANS_CODE','COMMN',self.SalesTypeCode);
			self.SalesFullPart			:=	pInput.full_part_sale;
			self										:=	[];
		end;
		
		return	project(pRow,tPropSalesInfo(left));
	end;
	
	// Property tax info transform function
	iesp.property_info.t_PropertyTaxInfoRecordReport	SetPropDataTaxInfo(PropertyCharacteristics_Services.Layouts.Payload	pRow)	:=
	function
		iesp.property_info.t_PropertyTaxInfoRecordReport	tPropTaxInfo(PropertyCharacteristics_Services.Layouts.Payload	pInput)	:=
		transform
			self.LegalDesc								:=	'';
			self.County										:=	pInput.county_name;
			self.ParcelNumber							:=	'';
			self.FipsCode									:=	pInput.fips_code;
			self.ApnNumber								:=	pInput.apn_number;
			self.BlockNumber							:=	pInput.block_number;
			self.LotNumber								:=	pInput.lot_number;
			self.SubdivisionName					:=	pInput.subdivision;
			self.TownshipName							:=	pInput.township;
			self.MunicipalityName					:=	pInput.municipality;
			self.Range										:=	pInput.range;
			self.Section									:=	'';
			self.ZoningDesc								:=	pInput.zoning;
			self.LocationOfInfluenceCode	:=	pInput.location_influence_code;
			self.LocationOfInfluence			:=	Codes.KeyCodes('PROPERTYINFO','LOCATION_INFLUENCE','COMMN',self.LocationOfInfluenceCode);
			self.LandUseCode							:=	pInput.land_use_code;
			self.LandUse									:=	Codes.KeyCodes('PROPERTYINFO','LAND_USE_CODE','COMMN',self.LandUseCode);
			self.PropertyTypeCode					:=	pInput.property_type_code;
			self.PropertyType							:=	Codes.KeyCodes('PROPERTYINFO','PROPERTY_IND','COMMN',self.PropertyTypeCode);
			self.Latitude									:=	pInput.latitude;
			self.Longitude								:=	pInput.longitude;
			self.LotSize									:=	pInput.lot_size;
			self.LotFrontFootage					:=	pInput.lot_front_footage;
			self.LotDepthFootage					:=	pInput.lot_depth_footage;
			self.Acres										:=	pInput.acres;
			self.TotalAssessedValue				:=	(real)pInput.total_assessed_value;
			self.TotalCalculatedValue			:=	(real)pInput.total_calculated_value;
			self.TotalMarketValue					:=	(real)pInput.total_market_value;
			self.TotalLandValue						:=	(real)pInput.total_land_value;
			self.MarketLandValue					:=	(real)pInput.market_land_value;
			self.AssessedLandValue				:=	(real)pInput.assessed_land_value;
			self.ImprovementValue					:=	(real)pInput.improvement_value;
			self.AssessedYear							:=	(unsigned)pInput.assessed_year;
			self.TaxCodeArea							:=	'';
			self.TaxBillingYear						:=	(unsigned)pInput.tax_year;
			self.HomeSteadExemption				:=	pInput.homestead_exemption_ind;
			self.TaxAmount								:=	(real)pInput.tax_amount;
			self.PercentImproved					:=	pInput.percent_improved;
			self.AssessmentDocumentNumber	:=	pInput.assessment_document_number;
			self.AssessmentRecordingDate	:=	iesp.ECL2ESP.toDate((unsigned)pInput.assessment_recording_date);
			self													:=	[];
		end;
		
		return	project(pRow,tPropTaxInfo(left));
	end;
		
	// Confidence factors - part1 transform function
	iesp.property_info.t_ConfidenceFactor1	SetPropDataConfidenceFactor1(PropertyCharacteristics_Services.Layouts.Payload	pRow)	:=
	function
		iesp.property_info.t_ConfidenceFactor1	tConfidenceFactor1(PropertyCharacteristics_Services.Layouts.Payload	pInput)	:=
		transform
			string	vACType				:=	Codes.KeyCodes('PROPERTYINFO','AIR_CONDITIONING_TYPE'	,'COMMN',pInput.air_conditioning_type);
			string	vHeatingType	:=	Codes.KeyCodes('PROPERTYINFO','HEATING_TYPE'					,'COMMN',pinput.heating);
			string	vFuelType			:=	Codes.KeyCodes('PROPERTYINFO','FUEL_TYPE'							,'COMMN',pInput.fuel_type);
			string	vConstType		:=	Codes.KeyCodes('PROPERTYINFO','CONSTRUCTION_TYPE'			,'COMMN',pInput.construction_type);
			string	vExtWall			:=	Codes.KeyCodes('PROPERTYINFO','EXTERIOR_WALL'					,'COMMN',pInput.exterior_wall);
			string	vGarageType		:=	Codes.KeyCodes('PROPERTYINFO','GARAGE_TYPE'						,'COMMN',pInput.garage);
			string	vParkingType	:=	Codes.KeyCodes('PROPERTYINFO','PARKING_TYPE'					,'COMMN',pInput.parking_type);
																		
			self.Acres												:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_acres);
			self.AirConditioningTypeCode			:=	if(	vACType	!=	'',
																								PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_air_conditioning_type),
																								0
																							);
			self.ApnNumber										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_apn_number);
			self.AssessedLandValue						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_assessed_land_value);
			self.AssessedYear									:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_assessed_year);
			self.BasementFinishType						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_basement_finish);
			self.BasementSquareFootage				:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_basement_square_footage);
			self.BlockNumber									:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_block_number);
			self.BuildingSquareFootage				:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_building_square_footage);
			self.CensusTract									:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_census_tract);
			self.ConstructionType							:=	if(	vConstType	!=	'',
																								PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_construction_type),
																								0
																							);
			self.County												:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_county_name);
			self.EffectiveYearBuilt						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_effective_year_built);
			self.ExteriorWallType							:=	if(	vExtWall	!=	'',
																								PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_exterior_wall),
																								0
																							);
			self.FipsCode											:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_fips_code);
			self.FireplaceIndicator						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_fireplace_ind);
			self.FireplaceType								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_fireplace_type);
			self.FloorType										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_floor_type);
			self.FoundationType								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_foundation);
			self.FrameType										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_frame_type);
			self.FuelType											:=	if(	vFuelType	!=	'',
																								PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_fuel_type),
																								0
																							);
			self.GarageCarportType						:=	if(	vGarageType	!=	'',
																								PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_garage),
																								0
																							);
			self.GarageSquareFootage					:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_garage_square_footage);
			self.GroundFloorSquareFootage			:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_first_floor_square_footage);
			self.HeatingType									:=	if(	vHeatingType	!=	'',
																								PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_heating),
																								0
																							);
			self.HomesteadExemptionIndicator	:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_homestead_exemption_ind);
			self.ImprovementValue							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_improvement_value);
			self.LandUseCode									:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_land_use_code);
			self.Latitude											:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_latitude);
			self.LivingAreaSquareFootage			:=	if(	pInput.src_living_area_square_footage	!=	'',
																								PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_living_area_square_footage),
																								if(	pRequest.ReportBy.PropertyAttributes.LivingAreaSF	!=	'' OR pInput.src_building_square_footage = 'DEFLT',
																										0,
																										PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_building_square_footage)
																									)
																							);
			self.LocationOfInfluenceCode			:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_location_influence_code);
			self.Longitude										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_longitude);
			self.LotDepthFootage							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_lot_depth_footage);
			self.LotFrontFootage							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_lot_front_footage);
			self.LotNumber										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_lot_number);
			self.LotSize											:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_lot_size);
			self.MarketLandValue							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_market_land_value);
			self.MunicipalityName							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_municipality);
			self.NumberOfBathFixtures					:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_bath_fixtures);
			self.NumberOfBaths								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_baths);
			self.NumberOfBedrooms							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_bedrooms);
			self.NumberOfFireplaces						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_fireplaces);
			self.NumberOfFullBaths						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_full_baths);
			self.NumberOfHalfBaths						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_half_baths);
			self.NumberOfRooms								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_rooms);
			self.NumberOfStories							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_stories);
			self.NumberOfUnits								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_no_of_units);
			self.ParkingType									:=	if(	vParkingType	!=	'',
																								PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_parking_type),
																								0
																							);
			self.PercentImproved							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_percent_improved);
			self.PoolIndicator								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_pool_indicator);
			self.PoolType											:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_pool_type);
			self.PropertyTypeCode							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_property_type_code);
			self.QualityOfStructureCode				:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_structure_quality);
			self.Range												:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_range);
			self.RoofCoverType								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_roof_cover);
			self.RoofType											:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_roof_type);
			self.SewerType										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_sewer);
			self.StoriesType									:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_stories_type);
			self.StyleType										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_style_type);
			self.SubdivisionName							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_subdivision);
			self.TaxAmount										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_tax_amount);
			self.TaxBillingYear								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_tax_year);
			self.TotalAssessedValue						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_total_assessed_value);
			self.TotalCalculatedValue					:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_total_calculated_value);
			self.TotalLandValue								:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_total_land_value);
			self.TotalMarketValue							:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_total_market_value);
			self.TownshipName									:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_township);
			self.WaterType										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_water);
			self.YearBuilt										:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_year_built);
			self.ZoningDescription						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_zoning);
			self.FloodZonePanelNumber					:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_flood_zone_panel);
			self.AssessmentDocumentNumber			:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_assessment_document_number);
			self.AssessmentRecordingDate			:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_assessment_recording_date);
		end;
		
		return	project(pRow,tConfidenceFactor1(left));
	end;
		
	// Confidence factors - part2 transform function
	iesp.property_info.t_ConfidenceFactor2	SetPropDataConfidenceFactor2(PropertyCharacteristics_Services.Layouts.Payload	pRow)	:=
	function
		iesp.property_info.t_ConfidenceFactor2	tConfidenceFactor2(PropertyCharacteristics_Services.Layouts.Payload	pInput)	:=
		transform
			self.DeedDocumentNumber		:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_deed_document_number);
			self.InterestRateTypeCode	:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_interest_rate_type_code);
			self.LoanAmount						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_loan_amount);
			self.SecondLoanAmount			:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_second_loan_amount);
			self.LoanTypeCode					:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_loan_type_code);
			self.MortgageCompanyName	:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_mortgage_company_name);
			self.DeedRecordingDate		:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_deed_recording_date);
			self.SaleFullOrPart				:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_full_part_sale);
			self.SalesAmount					:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_sale_amount);
			self.SalesDate						:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_sale_date);
			self.SalesTypeCode				:=	PropertyCharacteristics_Services.Code_Translations.SetConfidenceFactor(pInput.src_sale_type_code);
		end;
		
		return	project(pRow,tConfidenceFactor2(left));
	end;
	
	// Property Data Report - only for report types 'K' and 'P'
	// Format the results to the ESP layout
	export iesp.property_info.t_PropertyDataItem	Convert2PropDataItem (PropertyCharacteristics_Services.Layouts.Payload	pInput)	:=
		transform
			self.DataSource								:=	map(	pInput.vendor_source	=	'D'	=>	'A',	//FARES
																							pInput.vendor_source
																						);
			self.Messages									:=	[];
			self.RiskAddress							:=	SetPropDataRiskAddress(pInput);
			self.PropertyAttributes				:=	SetPropDataAttr(pInput);
			self.PropertyCharacteristics	:=	SetPropDataChar(pInput);
			self.Mortgages								:=	SetPropDataMortgageInfo(pInput);
			self.PropertySales						:=	SetPropDataSalesInfo(pInput);
			self.PropertyTax							:=	SetPropDataTaxInfo(pInput);
			self.ConfidenceFactor1				:=	if(	pInMod.IncludeConfidenceFactors,
																						SetPropDataConfidenceFactor1(pInput),
																						row([],iesp.property_info.t_ConfidenceFactor1)
																					);
			self.ConfidenceFactor2				:=	if(	pInMod.IncludeConfidenceFactors,
																						SetPropDataConfidenceFactor2(pInput),
																						row([],iesp.property_info.t_ConfidenceFactor2)
																					);
		end;

end;