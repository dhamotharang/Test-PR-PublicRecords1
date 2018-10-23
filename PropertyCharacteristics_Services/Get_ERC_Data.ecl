import	address,codes,iesp,propertycharacteristics,ut, Gateway,std;

// Creates a gateway request and executes it.
// Gateway request if filled in using in-house data, customer data, or both, dependng on the report type;
export	Get_ERC_Data(	PropertyCharacteristics_services.IParam.Report	pInMod,
											iesp.property_info.t_PropertyInformationRequest	pRequest,
											PropertyCharacteristics_Services.Layouts.BOB		dLNSearchResult,
											Address.ICleanAddress														clean_addr
										)	:=	
function
	
	// Slim down the request to contain only the relevant information
	dRequestSlim	:=	project(dataset(pRequest),transform(iesp.property_info.t_PropertyInformationReportBy,self	:=	left.ReportBy));
	
	// Name and address transform function
	iesp.property_value_report.t_PropertyAddressIn	SetNameAddr(iesp.property_info.t_PropertyInformationReportBy	L)	:=
		transform
			self.FirstName		:=	L.Name.First;
			self.LastName			:=	L.Name.Last;
			self.Street				:=	Address.Addr1FromComponents(	clean_addr.prim_range,
																													clean_addr.predir,
																													clean_addr.prim_name,
																													clean_addr.suffix,
																													clean_addr.postdir,
																													clean_addr.unit_desig,
																													clean_addr.sec_range
																												);
			self.City					:=	clean_addr.v_city;
			self.State				:=	clean_addr.state;
			self.Zip					:=	clean_addr.zip;
			self.County				:=	'';
			self.CensusTract	:=	clean_addr.geo_blk[1..4]	+	'.'	+	clean_addr.geo_blk[5..6];
	end;

	iesp.property_value_report.t_PropertyAddition SetPropertyAdditions (iesp.property_info.t_PropertyDescription L) :=
		transform
			self.Description	:=	PropertyCharacteristics_Services.Functions.fnClean2Upper(L.Description);
			self.Value				:=	L.AdditionValue;
			self							:=	L;
	end;

	// Report Type 'K' - Convert BOB to gateway request layout
	iesp.property_value_report.t_PropertyIn	tFormatBOB2PropReq(iesp.property_info.t_PropertyInformationReportBy	le)	:=
	transform
		// Default values for property attributes since the calculator doesn't default them
		integer	vLivingAreaSF	:=	(integer) if(	le.PropertyAttributes.LivingAreaSF	!=	'',
																						le.PropertyAttributes.LivingAreaSF,
																						if(	dLNSearchResult.living_area_square_footage	!=	'',
																								dLNSearchResult.living_area_square_footage,
																								dLNSearchResult.building_square_footage)
																					);
		string	vDfltBaths			:=	Functions.GetDefaultBaths (vLivingAreaSF);
		string	vDfltBedrooms		:=	Functions.GetDefaultBedrooms (vLivingAreaSF);
		string	vDfltStories		:=	Functions.GetDefaultStories (vLivingAreaSF);
		string	vDfltFireplaces	:=	Functions.GetDefaultFireplaces (vLivingAreaSF);

		real vStories	:=	(real)	if(	le.PropertyAttributes.Stories	!=	'',
																	le.PropertyAttributes.Stories,
																	if(dLNSearchResult.no_of_stories	!=	'',dLNSearchResult.no_of_stories,vDfltStories)
															);

		self.Reference											:=	'';
		self.PropertyId											:=	0;
		self.CoverageA											:=	le.PropertyAttributes.PolicyCoverageValue;
		self.NameAddress										:=	project(le,SetNameAddr(left));
		self.PropertyAttributes.LivingArea	:=	vLivingAreaSF;
		self.PropertyAttributes.Stories			:=	vStories;

		self.PropertyAttributes.Bedrooms		:=	if(	le.PropertyAttributes.Bedrooms	!=	'',
																								(integer)le.PropertyAttributes.Bedrooms,
																								if(dLNSearchResult.no_of_bedrooms	!=	'',(integer)dLNSearchResult.no_of_bedrooms,(integer)vDfltBedrooms)
																							);
		self.PropertyAttributes.Bathrooms		:=	if(	le.PropertyAttributes.Baths	!=	'',
																								(real)le.PropertyAttributes.Baths,
																								if(dLNSearchResult.no_of_baths	!=	'',(real)dLNSearchResult.no_of_baths,(real)vDfltBaths)
																							);
		self.PropertyAttributes.Fireplaces	:=	if(	le.PropertyAttributes.Fireplaces	!=	'',
																								(integer)le.PropertyAttributes.Fireplaces,
																								if(	dLNSearchResult.no_of_fireplaces	!=	''	and	dLNSearchResult.src_no_of_fireplaces	!=	'DEFLT',
																										(integer)dLNSearchResult.no_of_fireplaces,
																										if(dLNSearchResult.fireplace_ind	=	'N',0,(integer)vDfltFireplaces)
																									)
																							);
		self.PropertyAttributes.Pool				:=	le.PropertyAttributes.Pool	=	'Y'	or	dLNSearchResult.pool_indicator	=	'Y';
		self.PropertyAttributes.AC					:=	le.PropertyAttributes.AC	=	'Y'	or	dLNSearchResult.air_conditioning_type	not in	['','NON'];
		self.PropertyAttributes.Age					:=	if(	le.PropertyAttributes.YearBuilt	!=	0,
																								(INTEGER)Std.Date.Today()[1..4]	-	le.PropertyAttributes.YearBuilt,
																								if(dLNSearchResult.year_built	!=	'',(INTEGER)Std.Date.Today()[1..4]	-	(integer)dLNSearchResult.year_built,0)
																							);
		self.PropertyAttributes.Quality			:=	le.PropertyAttributes.QualityOfStructCode;
		self.PropertyAttributes.Slope				:=	le.PropertyAttributes.SlopeCode;
		self.StructureAttributes						:=	PropertyCharacteristics_Services.GatewayFunctions.SetStructureAttr(le,dLNSearchResult,vLivingAreaSF,vStories, true);
		self.PropertyAdditions							:=	project(	le.PropertyDescriptionSet, SetPropertyAdditions (Left));
		self.PropertyDataSources := [];
		self.DetachedGarages := [];
	end;
	dReqReportTypeK := project (dRequestSlim, tFormatBOB2PropReq (Left));
	
	// Report Type 'L' - Convert request to gateway property request layout
	iesp.property_value_report.t_PropertyIn	tFormatReq2PropReq(iesp.property_info.t_PropertyInformationReportBy	le)	:=
	transform
		// Default values for property attributes since the calculator doesn't default the attributes
		integer	vLivingAreaSF	:=	(integer) le.PropertyAttributes.LivingAreaSF;

		string	vDfltBaths			:=	Functions.GetDefaultBaths (vLivingAreaSF);
		string	vDfltBedrooms		:=	Functions.GetDefaultBedrooms (vLivingAreaSF);
		string	vDfltStories		:=	Functions.GetDefaultStories (vLivingAreaSF);
		string	vDfltFireplaces	:=	Functions.GetDefaultFireplaces (vLivingAreaSF);

		real	vStories	:=	(real) if(	le.PropertyAttributes.Stories	!=	'',
																		le.PropertyAttributes.Stories,
																		vDfltStories
																	);
		
		self.Reference											:=	'';
		self.PropertyId											:=	0;
		self.CoverageA											:=	le.PropertyAttributes.PolicyCoverageValue;
		self.NameAddress										:=	project(le,SetNameAddr(left));
		self.PropertyAttributes.LivingArea	:=	vLivingAreaSF;
		self.PropertyAttributes.Stories			:=	vStories;
		self.PropertyAttributes.Bedrooms		:=	if(	le.PropertyAttributes.Bedrooms	!=	'',
																								(integer)le.PropertyAttributes.Bedrooms,
																								(integer)vDfltBedrooms
																							);
		self.PropertyAttributes.Bathrooms		:=	if(	le.PropertyAttributes.Baths	!=	'',
																								(real)le.PropertyAttributes.Baths,
																								(real)vDfltBaths
																							);
		self.PropertyAttributes.Fireplaces	:=	if(	le.PropertyAttributes.Fireplaces	!=	'',
																								(integer)le.PropertyAttributes.Fireplaces,
																								(integer)vDfltFireplaces
																							);
		self.PropertyAttributes.Pool				:=	le.PropertyAttributes.Pool	=	'Y';
		self.PropertyAttributes.AC					:=	le.PropertyAttributes.AC	=	'Y';
		self.PropertyAttributes.Age					:=	if(	le.PropertyAttributes.YearBuilt	!=	0,
																								(INTEGER)Std.Date.Today()[1..4]	-	le.PropertyAttributes.YearBuilt,
																								0
																							);
		self.PropertyAttributes.Quality			:=	le.PropertyAttributes.QualityOfStructCode;
		self.PropertyAttributes.Slope				:=	le.PropertyAttributes.SlopeCode;
		self.StructureAttributes						:=	PropertyCharacteristics_Services.GatewayFunctions.SetStructureAttr(le,dLNSearchResult,vLivingAreaSF,vStories, false);
		self.PropertyAdditions							:=	project(	le.PropertyDescriptionSet, SetPropertyAdditions (Left));
		self.PropertyDataSources := [];
		self.DetachedGarages := [];
	end;
	
	dReqReportTypeL	:=	project(dRequestSlim,tFormatReq2PropReq(left));
	
	// Depending on the ReportType and the request we either do a join on the cleaned address or only use the customer provided data
	dFormat2PropReq	:=	if(	pInMod.ReportType	=	'K',
													dReqReportTypeK,
													dReqReportTypeL
												);

	// Will need the gateway config
	ERCGatewayCfg := pInMod.GatewayConfig[1];	
		
	// Transform for gateway iesp request layout
	iesp.property_value_report.t_PropertyValueReportRequest	tFormat2IESPReq(dFormat2PropReq	pInput)	:=
	transform
		self.Options																	:=	pRequest.Options;
		self.PropertyDocument.PropertyInfo.Properties	:=	pInput;
		self.User.ReferenceCode												:=	ERCGatewayCfg.TransactionId;		
		self.User																			:=	[];
		self																					:=	[];
	end;
	
	dFormat2IESPReq	:=	project(dFormat2PropReq,tFormat2IESPReq(left));
	
	// Soap call function to get ERC
	dERCGatewayResponse	:=	Gateway.SoapCall_ERC(dFormat2IESPReq,ERCGatewayCfg);
// output (dLNSearchResult, named ('BOB'));
	return	dERCGatewayResponse[1];
end;
