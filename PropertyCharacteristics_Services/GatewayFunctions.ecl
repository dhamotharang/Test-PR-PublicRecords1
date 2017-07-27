import	Codes,iesp, InsuranceContext_iesp, Gateway;

export	GatewayFunctions	:=
module

	// Function to get gateway configuration (NOT USED)
	export GetGatewayConfig(InsuranceContext_iesp.insurance_risk_context.t_PropertyInformationContext insuranceCtx) := function				
		//vGatewayTransId 			:= Gateway.Configuration.GetTransactionId();
		vGatewayCfg						:= project(insuranceCtx.Gateways(Gateway.Configuration.IsERC(servicename)),
																		 transform(Gateway.Layouts.Config,														
																							 //self.TransactionId := vGatewayTransId,
																							 self := left));	
    return vGatewayCfg;																							 
  end;																								

	// Function to populate the structure attribute fields - either customer or LN with customer values taking precedence
	export	iesp.property_value_report.t_StructureAttribute	SetStructureAttr(
								iesp.property_info.t_PropertyInformationReportBy	pRequest,
								PropertyCharacteristics_Services.Layouts.BOB			pLNResult,
								integer																						pLivingAreaSF,
								real																							pStories,
								boolean 																					use_inhouse
	)	:=	function
		// Slim down the layout to just contain the property characteristics
		dReqPropChar	:=	pRequest.PropertyCharacteristics;
		dLNPropChar		:=	pLNResult.insurbase_codes;
		
		basement_baths := dReqPropChar(Category = '013', PropertyCharacteristics_Services.Functions.fnClean2Upper(Material) = 'BTH');
		boolean	vBasementBathExists	:=	count(basement_baths) = 1;

		vUnFinishedBasementCodes		:=	['BFL','DFU','DPA','FST','FUN','FUT','IMP','UNK','YES'];
		vFinishedBasementCodes			:=	['FBE','FBR','FFD','FFI','FFL','FFP','FIN','FOF','FPF','FRR'];
		
		// Convert customer provided common values to bluebook (insurbase) codes
		// Rule to the exception - if the basement category is passed more than once, keep only one instance of the unfinished basement
		boolean	vUnFinishedBasementExists	:=	exists(dReqPropChar(Category	=	'013'	and	PropertyCharacteristics_Services.Functions.fnClean2Upper(Material)	in	vUnFinishedBasementCodes));

		// One input [Category, Material] may correspond to multiple bluebook translations, for which 
		// original "value" should be evenly distributed;
		// bluebook translations change the material; category is also may be changed for the gateway call,
		// so I will save "original" category and material here.
    propchar_rec := record (iesp.property_info.t_PropertyCharacteristic)
			typeof (iesp.property_info.t_PropertyCharacteristic.Category) OrigCategory;
			typeof (iesp.property_info.t_PropertyCharacteristic.Material) OrigMaterial;
		end;
		propchar_rec PreprocessPropChar (iesp.property_info.t_PropertyCharacteristic le) := transform
			Self.OrigCategory := le.Category;
			Self.OrigMaterial := le.Material;
			Self := le;
		end;
		dReqPropChar_pre := project (dReqPropChar, PreprocessPropChar (Left));

		propchar_rec	tConvert2BBCodes(propchar_rec	le, Codes.Key_Codes_V3	ri)	:=
		transform
			string	vIBCategory			:=	PropertyCharacteristics_Services.Code_Translations.IBCategoryCode(le.Category);
			string	vIBMaterial			:=	ri.long_desc;
			integer	vIBMatPipeIndex	:=	stringlib.stringfind(vIBMaterial,'|',2);
			
			self.Category					:=	if(	vIBCategory	!=	'',
																		vIBCategory,
																		skip
																	);
			self.Material					:=	if(	vIBMaterial	!=	'',
																		vIBMaterial[vIBMatPipeIndex+1..vIBMatPipeIndex+3],
																		skip
																	);
			self.Value						:=	if(	le.Value	!=	0,
																		map(	~use_inhouse	or (le.Category	!=	'013')													=>	le.Value,
																					vUnFinishedBasementExists	or	(self.Material	in	['BFA','BAB'])	=>	le.Value,
																					if(pLNResult.basement_square_footage	!=	'',(real)pLNResult.basement_square_footage,le.Value)
																				),
																		skip
																	);
			self									:=	le;
		end;
		
		dStructureAttr	:=	join(	dReqPropChar_pre, Codes.Key_Codes_V3,
															right.file_name		=	'PROPERTYINFO'
													and	right.field_name	=	PropertyCharacteristics_Services.Code_Translations.CodesV3FieldName(left.Category)
													and	right.field_name2	=	'CMNIB'
													and	right.code 				= PropertyCharacteristics_Services.Functions.fnClean2Upper(left.Material),
													tConvert2BBCodes(left,right),
													limit (10), keep(10) //so far at most 4: PROPERTYINFO TRADE PINFO 3
												);

		// Do the counts for flooring, exterior finish, roofing, foundation so as to split the value equally accross the materials
		rec_count := record
			dStructureAttr.OrigCategory;
			dStructureAttr.OrigMaterial;
			integer cnt := count (group)
		end;
		dStructureAttr_cnt := table (dStructureAttr, rec_count, OrigCategory, OrigMaterial, FEW);

		iesp.property_value_report.t_StructureAttribute GetCorrectedValue (propchar_rec L, rec_count R) := transform
			self.Value := if (l.Category in ['003','005','006','007'], l.Value / R.cnt, l.Value);
			self       := l;
		end;
		dStructureAttrValues := join (dStructureAttr, dStructureAttr_cnt,
																	(Left.OrigCategory = Right.OrigCategory) and (Left.OrigMaterial = Right.OrigMaterial),
																	GetCorrectedValue (Left, Right),
																	keep (1));
		
		// Filter for values with BUF (unfinished basement) and keep only one with the highest value
		dBasementIBCodes			:=	dStructureAttrValues(Category	=	'013'	and	Material	=	'BUF');
		dBasementIBCodesDedup	:=	TOPN(dBasementIBCodes, 1, -Value);

		integer	vBasementSF	:=	if(	use_inhouse and pLNResult.basement_square_footage	!=	'',
																(integer)pLNResult.basement_square_footage,
																round(pLivingAreaSF/pStories)
															);
		
		dReqStructureAttr	:=	if(	vBasementBathExists,
															project(	dStructureAttrValues,
																				transform(	iesp.property_value_report.t_StructureAttribute,
																										self.Value	:=	if(left.Category	=	'013'	and	left.Material	=	'BUF',vBasementSF,left.Value);
																										self				:=	left;
																									)
																			),
															dBasementIBCodesDedup	+	dStructureAttrValues(~(Category	=	'013'	and	Material	=	'BUF'))
														);
		
		// Give preference to vendor provided categories
		dLNPropCharOnly	:=	join(	dReqStructureAttr,
															dLNPropChar,
															PropertyCharacteristics_Services.Functions.fnClean2Upper(left.category)	=	PropertyCharacteristics_Services.Functions.fnClean2Upper(right.category),
															transform (iesp.property_value_report.t_StructureAttribute, Self := Right),
															right only
														);

    all_characteristics := dReqStructureAttr + dLNPropCharOnly;

    // Make final additions in case of using in-house data.
    // Add unfinished basement, if basement is not among characteristics and we have it in the in-house data;
    // (note: I'm not interested about "basement bath" here)
    boolean no_basement := ~exists (all_characteristics (Category = '013', Material != 'BTH'));

    all_appended := all_characteristics +
										if (no_basement and pLNResult.basement_square_footage != '', 
                        dataset ([{'013', 'BUF', (real) pLNResult.basement_square_footage, '', '', 0}], iesp.property_value_report.t_StructureAttribute));

    dPropChar := if (use_inhouse, all_appended, dReqStructureAttr);

// output (dReqStructureAttr, named ('dReqStructureAttr'), extend);		
// output (dLNPropChar, named ('dLNPropChar'), extend);		
		return	dPropChar;
	end;
	

end;