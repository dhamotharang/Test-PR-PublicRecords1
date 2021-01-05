import	iesp,PropertyCharacteristics,Codes, PropertyCharacteristics_Services, Doxie, Suppress;  

export	Functions	:=
module

	// Clean string
	export	string	fnClean2Upper(string	pStr)	:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(pStr));

	// Remove default data from the property data section
	string	searchPattern1	:=	'^(property_rid|global_sid|record_sid|dt_vendor_first_reported|dt_vendor_last_reported|tax_sortby_date|deed_sortby_date|vendor_source|';
	string	searchPattern2	:=	'fares_unformatted_apn|property_street_address|property_city_state_zip|property_raw_aid|';
	string	searchPattern3	:=	'prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|p_city_name|v_city_name|';
	string	searchPattern4	:=	'st|zip|zip4|cart|cr_sort_sz|lot|lot_order|dbpc|chk_digit|rec_type|county|geo_lat|geo_long|msa|geo_blk|geo_match|err_stat)';
	
	export	string	searchPattern	:=	searchPattern1	+	searchPattern2	+	searchPattern3	+	searchPattern4;
	
	export	Mac_Remove_Default_Data(inFile,outFile)	:=
	macro
		LOADXML('<xml/>');

		#EXPORTXML(dLNPropertyMetaInfo,recordof(inFile))
		
		#uniquename(tRemoveDefaultData)
		recordof(inFile) %tRemoveDefaultData%(inFile pInput) :=
		transform
			#IF(%'dLNPropertyMetaInfo'%='')
				#DECLARE(doRemoveDefaultDataText)
			#END
		
			#SET (doRemoveDefaultDataText,false)
			#FOR (dLNPropertyMetaInfo)
				#FOR(Field)
					#IF(%'@isDataset'%	=	'1'	and	%'@label'%	=	'insurbase_codes')
						#BREAK
					#ELSEIF(regexfind('^src_',%'@name'%,nocase))
						#SET (doRemoveDefaultDataText,'SELF.'	+	%'@name'%)
						#APPEND (doRemoveDefaultDataText,'	:=	if(pInput.vendor_source	!=	\'B\'	and	pInput.')
						#APPEND (doRemoveDefaultDataText,%'@name'%)
						#APPEND (doRemoveDefaultDataText,'	=	\'DEFLT\',\'\',pInput.')
						#APPEND (doRemoveDefaultDataText,%'@name'%)
						#APPEND (doRemoveDefaultDataText,');\n')
						%doRemoveDefaultDataText%;
					#ELSEIF(regexfind('^(tax_dt_|rec_dt_)',%'@name'%,nocase)	or	regexfind(PropertyCharacteristics_Services.Functions.searchPattern,%'@name'%,nocase))
						#SET(doRemoveDefaultDataText,'')
					#ELSEIF(%'@type'%	=	'string')
						#SET (doRemoveDefaultDataText,'SELF.'	+	%'@name'%)
						#APPEND (doRemoveDefaultDataText,'	:=	if(pInput.vendor_source	!=	\'B\'	and	pInput.src_')
						#APPEND (doRemoveDefaultDataText,%'@name'%)
						#APPEND (doRemoveDefaultDataText,'	=	\'DEFLT\',\'\',pInput.')
						#APPEND (doRemoveDefaultDataText,%'@name'%)
						#APPEND (doRemoveDefaultDataText,');\n')
						%doRemoveDefaultDataText%;
					#ELSE
						#SET (doRemoveDefaultDataText,'SELF.'	+	%'@name'%)
						#APPEND (doRemoveDefaultDataText,'	:=	if(pInput.vendor_source	!=	\'B\'	and	pInput.src_')
						#APPEND (doRemoveDefaultDataText,%'@name'%)
						#APPEND (doRemoveDefaultDataText,'	=	\'DEFLT\',0,pInput.')
						#APPEND (doRemoveDefaultDataText,%'@name'%)
						#APPEND (doRemoveDefaultDataText,');\n')
						%doRemoveDefaultDataText%;
					#END
				#END
			#END
			SELF	:=	pInput;
		END;

		outFile	:=	PROJECT(inFile,%tRemoveDefaultData%(LEFT));
	endmacro;
	
	// Function to convert the request to flat layout so facilitate logging
	export	PropertyCharacteristics_Services.Layouts.Input	RequestIntLogging(	iesp.property_info.t_PropertyInformationReportBy			pReportBy,
																																							PropertyCharacteristics_services.IParam.SearchRecords	pInMod
																																						)	:=
	function
		PropertyCharacteristics_Services.Layouts.Input	tIntLogging()	:=
		transform
			pInput												:=	pReportBy;			
			self.ReportType								:=	pInMod.ReportType;
			self.FirstName								:=	pInput.Name.First;
			self.MiddleName								:=	pInput.Name.Middle;
			self.LastName									:=	pInput.Name.Last;
//TODO: find out if it is correct -- to store cleaned address, instead of user's input
			self.StreetAddress						:=	pInMod.addr;
			self.City											:=	pInMod.city;
			self.State										:=	pInMod.state;
			self.Zip											:=	pInMod.zip;
			self.CensusTract							:=	pInput.AddressInfo.CensusTract;
			self.PolicyNumber							:=	pInput.PolicyNumber;
			self.Quoteback								:=	pInput.Quoteback;
			self.Property_Characteristics	:=	pInput.PropertyCharacteristics;
			self.Property_Description			:=	pInput.PropertyDescriptionSet;
			self.LivingAreaSF							:=	pInput.PropertyAttributes.LivingAreaSF;
			self.Stories									:=	pInput.PropertyAttributes.Stories;
			self.Bedrooms									:=	pInput.PropertyAttributes.Bedrooms;
			self.Baths										:=	pInput.PropertyAttributes.Baths;
			self.Fireplaces								:=	pInput.PropertyAttributes.Fireplaces;
			self.YearBuilt								:=	(string)pInput.PropertyAttributes.YearBuilt;
			self.PolicyCoverageValue			:=	(string)pInput.PropertyAttributes.PolicyCoverageValue;
			self													:=	pInput.PropertyAttributes;
		end;
		
		return	dataset([tIntLogging()]);
	end;
	
	export	Mac_Map_SourceID(inFile,outFile)	:=
	macro
		LOADXML('<xml/>');

		#EXPORTXML(dLNPropertyMetaInfo,recordof(inFile))
		
		#uniquename(tMapSourceIDs)
		recordof(inFile) %tMapSourceIDs%(inFile pInput) :=
		transform
			#IF(%'dLNPropertyMetaInfo'%='')
				#DECLARE(doMapSourceIDText)
			#END
		
			#SET (doMapSourceIDText,false)
			#FOR (dLNPropertyMetaInfo)
				#FOR(Field)
					#IF(regexfind('^src_',%'@name'%,nocase))
						#SET (doMapSourceIDText,'SELF.'	+	%'@name'%)
						#APPEND (doMapSourceIDText,'	:=	PropertyCharacteristics_Services.Code_Translations.SetIntermediateSourceID(pInput.')
						#APPEND (doMapSourceIDText,%'@name'%)
						#APPEND (doMapSourceIDText,');\n')
						%doMapSourceIDText%;
					#END
				#END
			#END
			SELF.vendor_source	:=	if(pInput.vendor_source	=	'D','A',pInput.vendor_source);
			SELF								:=	pInput;
		END;

		outFile	:=	SORT(PROJECT(inFile,%tMapSourceIDs%(LEFT)),vendor_source);
	endmacro;

	// produces key fields count based on a single record
	export GetKeyFieldCount (PropertyCharacteristics_Services.Layouts.payload pInput) :=
			if(pInput.living_area_square_footage	<>	'',1,0)
		+	if(pInput.building_square_footage			<>	'',1,0)
		+	if(pInput.air_conditioning_type				<>	''	and	pInput.src_air_conditioning_type			<>	'DEFLT',1,0)
		+ if(pInput.basement_finish							<>	''	and	pInput.src_basement_finish						<>	'DEFLT',1,0)
		+ if(pInput.construction_type						<>	''	and	pInput.src_construction_type					<>	'DEFLT',1,0)
		+ if(pInput.exterior_wall								<>	''	and	pInput.src_exterior_wall							<>	'DEFLT',1,0)
		+ if(pInput.fireplace_ind								<>	''	and	pInput.src_fireplace_ind							<>	'DEFLT',1,0)
		+ if(pInput.fireplace_type							<>	''	and	pInput.src_fireplace_type							<>	'DEFLT',1,0)
		+ if(pInput.garage											<>	''	and	pInput.src_garage											<>	'DEFLT',1,0)
		+ if(pInput.first_floor_square_footage	<>	''	and	pInput.src_first_floor_square_footage	<>	'DEFLT',1,0)
		+ if(pInput.heating											<>	''	and	pInput.src_heating										<>	'DEFLT',1,0)
		+ if(pInput.no_of_baths									<>	''	and	pInput.src_no_of_baths								<>	'DEFLT',1,0)
		+ if(pInput.no_of_bedrooms							<>	''	and	pInput.src_no_of_bedrooms							<>	'DEFLT',1,0)
		+ if(pInput.no_of_fireplaces						<>	''	and	pInput.src_no_of_fireplaces						<>	'DEFLT',1,0)
		+ if(pInput.no_of_full_baths						<>	''	and	pInput.src_no_of_full_baths						<>	'DEFLT',1,0)
		+ if(pInput.no_of_half_baths						<>	''	and	pInput.src_no_of_half_baths						<>	'DEFLT',1,0)
		+ if(pInput.no_of_stories								<>	''	and	pInput.src_no_of_stories							<>	'DEFLT',1,0)
		+ if(pInput.parking_type								<>	''	and	pInput.src_parking_type								<>	'DEFLT',1,0)
		+ if(pInput.pool_indicator							<>	''	and	pInput.src_pool_indicator							<>	'DEFLT',1,0)
		+ if(pInput.pool_type										<>	''	and	pInput.src_pool_type									<>	'DEFLT',1,0)
		+ if(pInput.roof_cover									<>	''	and	pInput.src_roof_cover									<>	'DEFLT',1,0)
		+ if(pInput.year_built									<>	''	and	pInput.src_year_built									<>	'DEFLT',1,0)
		+ if(pInput.foundation									<>	''	and	pInput.src_foundation									<>	'DEFLT',1,0)
	;

	// produces non-key fields count based on a single record
	export GetNonKeyFieldCount (PropertyCharacteristics_Services.Layouts.payload pInput) :=
			if(pInput.flood_zone_panel						<>	'',1,0)
		+ if(pInput.basement_square_footage			<>	'',1,0)
		+ if(pInput.effective_year_built				<>	'',1,0)
		+ if(pInput.garage_square_footage				<>	'',1,0)
		+ if(pInput.stories_type								<>	'',1,0)
		+ if(pInput.apn_number									<>	'',1,0)
		+ if(pInput.census_tract								<>	'',1,0)
		+ if(pInput.range												<>	'',1,0)
		+ if(pInput.zoning											<>	'',1,0)
		+ if(pInput.block_number								<>	'',1,0)
		+ if(pInput.county_name									<>	'',1,0)
		+ if(pInput.fips_code										<>	'',1,0)
		+ if(pInput.subdivision									<>	'',1,0)
		+ if(pInput.municipality								<>	'',1,0)
		+ if(pInput.township										<>	'',1,0)
		+ if(pInput.homestead_exemption_ind			<>	'',1,0)
		+ if(pInput.land_use_code								<>	'',1,0)
		+ if(pInput.latitude										<>	'',1,0)
		+ if(pInput.longitude										<>	'',1,0)
		+ if(pInput.location_influence_code			<>	'',1,0)
		+ if(pInput.acres												<>	'',1,0)
		+ if(pInput.lot_depth_footage						<>	'',1,0)
		+ if(pInput.lot_front_footage						<>	'',1,0)
		+ if(pInput.lot_number									<>	'',1,0)
		+ if(pInput.lot_size										<>	'',1,0)
		+ if(pInput.property_type_code					<>	'',1,0)
		+ if(pInput.structure_quality						<>	'',1,0)
		+ if(pInput.water												<>	'',1,0)
		+ if(pInput.sewer												<>	'',1,0)
		+ if(pInput.assessed_land_value					<>	'',1,0)
		+ if(pInput.assessed_year								<>	'',1,0)
		+ if(pInput.tax_amount									<>	'',1,0)
		+ if(pInput.tax_year										<>	'',1,0)
		+ if(pInput.market_land_value						<>	'',1,0)
		+ if(pInput.improvement_value						<>	'',1,0)
		+ if((REAL8)pInput.percent_improved			<>	0	,1,0)
		+ if(pInput.total_assessed_value				<>	'',1,0)
		+ if(pInput.total_calculated_value			<>	'',1,0)
		+ if(pInput.total_land_value						<>	'',1,0)
		+ if(pInput.total_market_value					<>	'',1,0)
		+ if(pInput.floor_type									<>	'',1,0)
		+ if(pInput.frame_type									<>	'',1,0)
		+ if(pInput.fuel_type										<>	'',1,0)
		+ if(pInput.no_of_bath_fixtures					<>	'',1,0)
		+ if(pInput.no_of_rooms									<>	'',1,0)
		+ if(pInput.no_of_units									<>	'',1,0)
		+ if(pInput.style_type									<>	'',1,0)
		+ if(pInput.assessment_document_number	<>	'',1,0)
		+ if(pInput.assessment_recording_date		<>	'',1,0)
		+ if(pInput.deed_recording_date					<>	'',1,0)
		+ if(pInput.deed_document_number				<>	'',1,0)
		+ if(pInput.full_part_sale							<>	'',1,0)
		+ if(pInput.sale_amount									<>	'',1,0)
		+ if(pInput.sale_date										<>	'',1,0)
		+ if(pInput.sale_type_code							<>	'',1,0)
		+ if(pInput.mortgage_company_name				<>	'',1,0)
		+ if(pInput.loan_amount									<>	'',1,0)
		+ if(pInput.second_loan_amount					<>	'',1,0)
		+ if(pInput.loan_type_code							<>	'',1,0)
		+ if(pInput.interest_rate_type_code			<>	'',1,0)
	;

	export string GetDefaultBaths (integer living_area_sf) := map (
		living_area_sf	!=	0	and	living_area_sf	<=	800	=>	'1',
		living_area_sf	between	801		and	1200						=>	'1.5',
		living_area_sf	between	1201	and	1800						=>	'2',
		living_area_sf	between	1801	and	2200						=>	'2.5',
		living_area_sf	between	2201	and	2700						=>	'3',
		living_area_sf	between	2701	and	3200						=>	'3.5',
		living_area_sf	between	3201	and	4000						=>	'4',
		living_area_sf	between	4001	and	5000						=>	'4.5',
		living_area_sf	>=	5001													=>	(string)(5	+	PropertyCharacteristics.Functions.round2point5((living_area_sf	-	5000)/1000)),
		''
	);

	export string GetDefaultBedrooms (integer living_area_sf) := map (
		living_area_sf !=	0	and	living_area_sf <= 800	=>	'1',
		living_area_sf between  801 and 1000					=>	'2',
		living_area_sf between 1001 and 2000					=>	'3',
		living_area_sf between 2001 and 3500					=>	'4',
		living_area_sf between 3501 and 7000					=>	'5',
		living_area_sf >=	7001												=>	(string)(6	+	round((living_area_sf	-	7000)/1500)),
		''
	);

	export string GetDefaultStories (integer living_area_sf) := map (
		living_area_sf	!=	0	and	living_area_sf	<=	1800	=>	'1',
		living_area_sf	between	1801	and	2400							=>	'1.5',
		living_area_sf	>=	2401														=>	'2',
		''
	); 

	export string GetDefaultFireplaces (integer living_area_sf) := map (
		living_area_sf	!= 0 and living_area_sf	<=	800	=>	'1',
		living_area_sf	between	801		and	1500					=>	'1',
		living_area_sf	between	1501	and	2500					=>	'2',
		living_area_sf	between	2501	and	7500					=>	'3',
		living_area_sf	between	7501	and	10000					=>	'4',
		''
	);

	// output: at most 1 row of PropertyCharacteristics_Services.Layouts.BOB
	export GetBestInhouseRecord (
		dataset(PropertyCharacteristics_Services.layouts.Payload) dLNSearchResult,
		iesp.property_info.t_PropertyInformationRequest	pRequest)
	:= function
	
		// Calculate field populations for each record
		PropertyCharacteristics_Services.Layouts.BOB	tCntPopulatedFields(dLNSearchResult	pInput)	:= transform
			self.wghtLivingSqFt	:=	if(pInput.living_area_square_footage		<>	'',1,0);
			self.wghtBldgSqFt		:=	if(pInput.building_square_footage				<>	'',1,0);
			self.cntKeyFields		:=	GetKeyFieldCount (pInput);
			self.cntNonKeyFields:=	GetNonKeyFieldCount (pInput);
			self								:=	pInput;
		end;
		dLNPopulatedFieldsCnt	:=	project(dLNSearchResult, tCntPopulatedFields (left));

		// Pick the best of the best record
		dLNBOB	:=	if(	pRequest.ReportBy.PropertyAttributes.LivingAreaSF	!=	'',
										topn(dLNPopulatedFieldsCnt,1,-cntKeyFields,-cntNonKeyFields,-vendor_source),
										topn(dLNPopulatedFieldsCnt,1,-wghtLivingSqFt,-wghtBldgSqFt,-cntKeyFields,-cntNonKeyFields,-vendor_source)
									);

    return dLNBOB[1];
  end;
/*
  export GetBluebookCodes (dataset (iesp.property_info.t_PropertyCharacteristic) dReqPropChar) := function

    iesp.property_value_report.t_StructureAttribute  GetCodes (iesp.property_info.t_PropertyCharacteristic  le, Codes.Key_Codes_V3 ri) := transform
      string  vIBCategory      :=  PropertyCharacteristics_Services.Code_Translations.IBCategoryCode(le.Category);
      string  vIBMaterial      :=  ri.long_desc;
      integer  vIBMatPipeIndex :=  stringlib.stringfind(vIBMaterial,'|',2);
      
      self.Category := if (vIBCategory != '', vIBCategory, skip);
      self.Material := if (vIBMaterial != '', vIBMaterial[vIBMatPipeIndex+1..vIBMatPipeIndex+3], skip);
      // self.Value    := if (le.Value    !=  0,
                           // map (le.Category  !=  '013'                                    	        =>  le.Value,
                                // vUnFinishedBasementExists  or  (self.Material  in  ['BFA','BAB'])  =>  le.Value,
                                // if(pLNResult.basement_square_footage  !=  '',(real)pLNResult.basement_square_footage,le.Value)
                                // ),
                           // skip);
      self.Value    := if (le.Value    !=  0,le.Value, skip);
      self := le;
    end;
    
    res := join (dReqPropChar, Codes.Key_Codes_V3,
                 right.file_name        = 'PROPERTYINFO'
                 and  right.field_name  = PropertyCharacteristics_Services.Code_Translations.CodesV3FieldName(left.Category)
                 and  right.field_name2 = 'CMNIB'
                 and  right.code        = fnClean2Upper(left.Material),
                 GetCodes(left,right),
                 many lookup);
    return res;
	end;
*/
  export integer1 GetProductType (string1 product_in) :=     
    case (stringlib.stringToUpperCase (product_in),
          'I' => PropertyCharacteristics_Services.Constants.PRODUCT.INSPECTION,
          'P' => PropertyCharacteristics_Services.Constants.PRODUCT.PROPERTY,
          PropertyCharacteristics_Services.Constants.PRODUCT.DEFAULT);

	export unsigned GetCombinedErrors (
		dataset (PropertyCharacteristics_Services.layouts.payload)	dLNSearchResult,
		iesp.property_info.t_PropertyInformationRequest							pRequest,
		string1 ReportType,
		boolean valid_address)	:= function

		// Check service type
		// Added 'I' to list - RR 186945
		boolean	isValidReportType	:=	ReportType	in ['I','P']; //in	['K','L','P'];
		// boolean	isSent2ERC				:=	ReportType	in	['K','L'];

		PropCharacteristics	:=	pRequest.ReportBy.PropertyCharacteristics;
		PropDescriptionSet	:=	pRequest.ReportBy.PropertyDescriptionSet;
		
		// Value based check for property characteristics
		boolean	isPropCharBadCategory		:=	exists(PropCharacteristics(fnClean2Upper(Category)	not in	PropertyCharacteristics_Services.Constants.ValidCategories));
		boolean	isPropCharBadMaterial		:=	exists(PropCharacteristics(Material	=	''));
		boolean	isPropCharBadValue			:=	exists(PropCharacteristics(Value	=	0));
		
		// Value based checks for property description
		boolean	isPropDescBadDesc				:=	exists(PropDescriptionSet(Description	=	''));
		boolean	isPropDescBadValue			:=	exists(PropDescriptionSet(AdditionValue	=	0));


		// Boolean values created for populating the processing status in the report
		boolean	isLNameExists				:=	pRequest.ReportBy.Name.Last	!=	'';
		
		boolean	isFNameExists				:=	pRequest.ReportBy.Name.First	!=	'';
		
		// Check if the property is a single family property - BlueBook ERC calculator only works for single family residences
		singleFamilyLandUseCodes		:=	['BGW','CLH','COO','HSR','HST','PPT','PRS','RES','RNH','RRR','RWH','SFR','ZLL'];

		boolean no_sec_range := /*clean_addr.sec_range='' and*/ dLNSearchResult.land_use_code='' and dLNSearchResult.property_type_code='';

		boolean	isSingleFamily			:=	map(ReportType	=	'L'					=>	true,
		// TODO: seems redundant?										~exists(dLNPropResultsFiltered)	=>	true,
		// TODO: seems redundant										ReportType	=	'P'					=>	false,
																								exists(dLNSearchResult(property_type_code	=	'SFR')) or
																								exists(dLNSearchResult(land_use_code	in	singleFamilyLandUseCodes)) or
																								exists(dLNSearchResult(no_sec_range)) or
																								(count(dLNSearchResult(no_sec_range))	=	count(dLNSearchResult))
																						);


		// Check if the living area square footage exists, it's required for ERC calculation
		
		boolean	isLivingSFExists		:=	((integer) pRequest.ReportBy.PropertyAttributes.LivingAreaSF != 0) or
																						exists(dLNSearchResult(living_area_square_footage != '' or building_square_footage != ''));

		
		// Check if all the conditions for the request data meet the requirements before passing to gateway	
		boolean	isBadPropChar				:=	isPropCharBadCategory	or	isPropCharBadMaterial	or	isPropCharBadValue;
		
		boolean	isBadPropDesc				:=	isPropDescBadDesc	or	isPropDescBadValue;
		

		return 0 +	if (~isValidReportType, 
										Constants.InternalCodes.INVALID_REPORT_TYPE, 0) +
								if (isValidReportType	and	~valid_address,
										Constants.InternalCodes.INSUFFICIENT_ADDRESS, 0)
										// +
								// these errors will be calculated only in case of a gateway call
								// if (isSent2ERC	and	~isLNameExists,
										// Constants.InternalCodes.LAST_NAME_REQUIRED, 0) +
								// if (isSent2ERC	and	~isFNameExists,
										// Constants.InternalCodes.FIRST_NAME_REQUIRED, 0) +
								// if (isSent2ERC	and	valid_address	and	~isSingleFamily,
										// Constants.InternalCodes.SINGLE_FAMILY_ERROR, 0) +
								// if (isSent2ERC	and	valid_address	and	isSingleFamily	and	~isLivingSFExists,
										// Constants.InternalCodes.LIVING_AREA_SQFT_REQUIRED, 0) +
								// if (isSent2ERC	and	valid_address	and	isSingleFamily	and	isLivingSFExists	and	isPropCharBadCategory,
										// Constants.InternalCodes.PROP_CHAR_INVALID_CATEGORY, 0) +
								// if (isSent2ERC	and	valid_address	and	isSingleFamily	and	isPropCharBadMaterial,
										// Constants.InternalCodes.PROP_CHAR_MATERIAL_REQUIRED, 0) +
								// if (isSent2ERC	and	valid_address	and	isSingleFamily	and	isPropCharBadValue,
										// Constants.InternalCodes.PROP_CHAR_VALUE_REQUIRED, 0) +
								// if (isSent2ERC	and	valid_address	and	isSingleFamily	and	isPropDescBadDesc,
										// Constants.InternalCodes.PROP_DESC_REQUIRED, 0) +
								// if (isSent2ERC	and	valid_address	and	isSingleFamily	and	isPropDescBadValue,
										// Constants.InternalCodes.INSUFFICIENT_ADDRESS, 0)
										;
							// these two are used outside:
							// GATEWAY_XML_ERROR=2048
							// GATEWAY_EXCEPTION=4096

	end;

  
LOADXML('<xml/>');
#DECLARE(inhouse_characteristics);
#SET(inhouse_characteristics, '');

#DECLARE(inhouse_mortgages);
#SET(inhouse_mortgages, '');

#DECLARE (k);
#SET (k, 1);
#LOOP
  #IF (%k% > 85)
    #BREAK
  #ELSE
    #APPEND (inhouse_characteristics, 
             'Self.Category_' + %'k'% + ' := L.property.PropertyCharacteristics[' + %'k'% + '].Category;\n' +
             'Self.CategoryDesc_' + %'k'% + ' := L.property.PropertyCharacteristics[' + %'k'% + '].CategoryDesc;\n' +
             'Self.Material_' + %'k'% + ' := L.property.PropertyCharacteristics[' + %'k'% + '].Material;\n' +
             'Self.MaterialDesc_' + %'k'% + ' := L.property.PropertyCharacteristics[' + %'k'% + '].MaterialDesc;\n' +
             'Self.Value_' + %'k'% + ' := L.property.PropertyCharacteristics[' + %'k'% + '].Value;\n' +
             'Self.ErcValue_' + %'k'% + ' := L.property.PropertyCharacteristics[' + %'k'% + '].ErcValue;\n');
    #SET (k, %k% + 1);
  #END
#END

#SET (k, 1);
#LOOP
  #IF (%k% > 3)
    #BREAK
  #ELSE
    #APPEND (inhouse_mortgages, 
             'Self.MortgageCompanyName_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].MortgageCompanyName;\n' +
             'Self.MortgageType_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].MortgageType;\n' +
             'Self.MortgageTypeDesc_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].MortgageTypeDesc;\n' +
             'Self.LoanAmount_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].LoanAmount;\n' +
             'Self.LoanTypeCode_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].LoanTypeCode;\n' +
             'Self.LoanType_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].LoanType;\n' +
             'Self.InterestRate_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].InterestRate;\n' +
             'Self.InterestRateTypeCode_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].InterestRateTypeCode;\n' +
             'Self.InterestRateType_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].InterestRateType;\n' +
             'Self.MortgageLoanNumber_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].MortgageLoanNumber;\n' +
             'Self.FsiMortgageLoanNumber_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].FsiMortgageLoanNumber;\n' +
             'Self.FsiMortgageCompanyName_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].FsiMortgageCompanyName;\n' +
             'Self.Classification_' + %'k'% + ' := L.property.Mortgages[' + %'k'% + '].Classification;\n');
    #SET (k, %k% + 1);
  #END
#END

#DECLARE(erc_characteristics);
#SET(erc_characteristics, '');

#SET (k, 1);
#LOOP
  #IF (%k% > 85)
    #BREAK
  #ELSE
    #APPEND (erc_characteristics, 
             'Self.ERC_CategoryDesc_' + %'k'% + ' := L.ERC[1].PropertyCharacteristics[' + %'k'% + '].CategoryDesc;\n' +
             'Self.ERC_MaterialDesc_' + %'k'% + ' := L.ERC[1].PropertyCharacteristics[' + %'k'% + '].MaterialDesc;\n' +
             'Self.ERC_Value_' + %'k'% + ' := L.ERC[1].PropertyCharacteristics[' + %'k'% + '].Value;\n' +
             'Self.ERC_ErcValue_' + %'k'% + ' := L.ERC[1].PropertyCharacteristics[' + %'k'% + '].ErcValue;\n');

    #SET (k, %k% + 1);
  #END
#END
//not used:
	// string3 Category {xpath('Category')};
	// string3 Material {xpath('Material')};
	// real8 Value {xpath('Value')};
	// unsigned ErcValue {xpath('ErcValue')};

#DECLARE(erc_propertydescriptions);
#SET(erc_propertydescriptions, '');

#SET (k, 1);
#LOOP
  #IF (%k% > 10)
    #BREAK
  #ELSE
    #APPEND (erc_propertydescriptions, 
             'Self.ERC_PropertyDesc_' + %'k'% + ' := L.ERC[1].PropertyDescriptionRecordSet[' + %'k'% + '].PropertyDesc;\n' +
             'Self.ERC_PropertyAdditionValue_' + %'k'% + ' := L.ERC[1].PropertyDescriptionRecordSet[' + %'k'% + '].PropertyAdditionValue;\n' +
             'Self.ERCDesc_Value_' + %'k'% + ' := L.ERC[1].PropertyDescriptionRecordSet[' + %'k'% + '].ErcValue;\n');
    #SET (k, %k% + 1);
  #END
#END

	export layouts.batch_out FlattenBatchOutput (layouts.batch_combined L) := transform
    Self.acctno := L.acctno;
    Self.DataSource := L.property.DataSource;
    Self := L.property.RiskAddress; // inhouse address
    Self := L.property.PropertyAttributes; // inhouse main property attributes
    %inhouse_characteristics%
    %inhouse_mortgages%
		Self.DeedRecordingDate := iesp.ECL2ESP.t_DateToString8 (L.property.PropertySales.DeedRecordingDate);
		Self.SalesDate := iesp.ECL2ESP.t_DateToString8 (L.property.PropertySales.SalesDate);
    Self := L.property.PropertySales;
    Self.AssessmentRecordingDate := iesp.ECL2ESP.t_DateToString8 (L.property.PropertyTax.AssessmentRecordingDate);
    Self.Tax_County := L.property.PropertyTax.County;
    Self := L.property.PropertyTax;

    Self.CF1_Acres := L.property.ConfidenceFactor1.Acres;
    Self.CF1_AirConditioningTypeCode := L.property.ConfidenceFactor1.AirConditioningTypeCode;
    Self.CF1_ApnNumber := L.property.ConfidenceFactor1.ApnNumber;
    Self.CF1_AssessedLandValue := L.property.ConfidenceFactor1.AssessedLandValue;
    Self.CF1_AssessedYear := L.property.ConfidenceFactor1.AssessedYear;
    Self.CF1_AssessmentDocumentNumber := L.property.ConfidenceFactor1.AssessmentDocumentNumber;
    Self.CF1_AssessmentRecordingDate := L.property.ConfidenceFactor1.AssessmentRecordingDate;
    Self.CF1_BasementFinishType := L.property.ConfidenceFactor1.BasementFinishType;
    Self.CF1_BasementSquareFootage := L.property.ConfidenceFactor1.BasementSquareFootage;
    Self.CF1_BlockNumber := L.property.ConfidenceFactor1.BlockNumber;
    Self.CF1_BuildingSquareFootage := L.property.ConfidenceFactor1.BuildingSquareFootage;
    Self.CF1_CensusTract := L.property.ConfidenceFactor1.CensusTract;
    Self.CF1_ConstructionType := L.property.ConfidenceFactor1.ConstructionType;
    Self.CF1_County := L.property.ConfidenceFactor1.County;
    Self.CF1_EffectiveYearBuilt := L.property.ConfidenceFactor1.EffectiveYearBuilt;
    Self.CF1_ExteriorWallType := L.property.ConfidenceFactor1.ExteriorWallType;
    Self.CF1_FipsCode := L.property.ConfidenceFactor1.FipsCode;
    Self.CF1_FireplaceIndicator := L.property.ConfidenceFactor1.FireplaceIndicator;
    Self.CF1_FireplaceType := L.property.ConfidenceFactor1.FireplaceType;
    Self.CF1_FloodZonePanelNumber := L.property.ConfidenceFactor1.FloodZonePanelNumber;
    Self.CF1_FloorType := L.property.ConfidenceFactor1.FloorType;
    Self.CF1_FoundationType := L.property.ConfidenceFactor1.FoundationType;
    Self.CF1_FrameType := L.property.ConfidenceFactor1.FrameType;
    Self.CF1_FuelType := L.property.ConfidenceFactor1.FuelType;
    Self.CF1_GarageCarportType := L.property.ConfidenceFactor1.GarageCarportType;
    Self.CF1_GarageSquareFootage := L.property.ConfidenceFactor1.GarageSquareFootage;
    Self.CF1_GroundFloorSquareFootage := L.property.ConfidenceFactor1.GroundFloorSquareFootage;
    Self.CF1_HeatingType := L.property.ConfidenceFactor1.HeatingType;
    Self.CF1_HomesteadExemptionIndicator := L.property.ConfidenceFactor1.HomesteadExemptionIndicator;
    Self.CF1_ImprovementValue := L.property.ConfidenceFactor1.ImprovementValue;
    Self.CF1_LandUseCode := L.property.ConfidenceFactor1.LandUseCode;
    Self.CF1_Latitude := L.property.ConfidenceFactor1.Latitude;
    Self.CF1_LivingAreaSquareFootage := L.property.ConfidenceFactor1.LivingAreaSquareFootage;
    Self.CF1_LocationOfInfluenceCode := L.property.ConfidenceFactor1.LocationOfInfluenceCode;
    Self.CF1_Longitude := L.property.ConfidenceFactor1.Longitude;
    Self.CF1_LotDepthFootage := L.property.ConfidenceFactor1.LotDepthFootage;
    Self.CF1_LotFrontFootage := L.property.ConfidenceFactor1.LotFrontFootage;
    Self.CF1_LotNumber := L.property.ConfidenceFactor1.LotNumber;
    Self.CF1_LotSize := L.property.ConfidenceFactor1.LotSize;
    Self.CF1_MarketLandValue := L.property.ConfidenceFactor1.MarketLandValue;
    Self.CF1_MunicipalityName := L.property.ConfidenceFactor1.MunicipalityName;
    Self.CF1_NumberOfBathFixtures := L.property.ConfidenceFactor1.NumberOfBathFixtures;
    Self.CF1_NumberOfBaths := L.property.ConfidenceFactor1.NumberOfBaths;
    Self.CF1_NumberOfBedrooms := L.property.ConfidenceFactor1.NumberOfBedrooms;
    Self.CF1_NumberOfFireplaces := L.property.ConfidenceFactor1.NumberOfFireplaces;
    Self.CF1_NumberOfFullBaths := L.property.ConfidenceFactor1.NumberOfFullBaths;
    Self.CF1_NumberOfHalfBaths := L.property.ConfidenceFactor1.NumberOfHalfBaths;
    Self.CF1_NumberOfRooms := L.property.ConfidenceFactor1.NumberOfRooms;
    Self.CF1_NumberOfStories := L.property.ConfidenceFactor1.NumberOfStories;
    Self.CF1_NumberOfUnits := L.property.ConfidenceFactor1.NumberOfUnits;
    Self.CF1_ParkingType := L.property.ConfidenceFactor1.ParkingType;
    Self.CF1_PercentImproved := L.property.ConfidenceFactor1.PercentImproved;
    Self.CF1_PoolIndicator := L.property.ConfidenceFactor1.PoolIndicator;
    Self.CF1_PoolType := L.property.ConfidenceFactor1.PoolType;
    Self.CF1_PropertyTypeCode := L.property.ConfidenceFactor1.PropertyTypeCode;
    Self.CF1_QualityOfStructureCode := L.property.ConfidenceFactor1.QualityOfStructureCode;
    Self.CF1_Range := L.property.ConfidenceFactor1.Range;
    Self.CF1_RoofCoverType := L.property.ConfidenceFactor1.RoofCoverType;
    Self.CF1_RoofType := L.property.ConfidenceFactor1.RoofType;
    Self.CF1_SewerType := L.property.ConfidenceFactor1.SewerType;
    Self.CF1_StoriesType := L.property.ConfidenceFactor1.StoriesType;
    Self.CF1_StyleType := L.property.ConfidenceFactor1.StyleType;
    Self.CF1_SubdivisionName := L.property.ConfidenceFactor1.SubdivisionName;
    Self.CF1_TaxAmount := L.property.ConfidenceFactor1.TaxAmount;
    Self.CF1_TaxBillingYear := L.property.ConfidenceFactor1.TaxBillingYear;
    Self.CF1_TotalAssessedValue := L.property.ConfidenceFactor1.TotalAssessedValue;
    Self.CF1_TotalCalculatedValue := L.property.ConfidenceFactor1.TotalCalculatedValue;
    Self.CF1_TotalLandValue := L.property.ConfidenceFactor1.TotalLandValue;
    Self.CF1_TotalMarketValue := L.property.ConfidenceFactor1.TotalMarketValue;
    Self.CF1_TownshipName := L.property.ConfidenceFactor1.TownshipName;
    Self.CF1_WaterType := L.property.ConfidenceFactor1.WaterType;
    Self.CF1_YearBuilt := L.property.ConfidenceFactor1.YearBuilt;
    Self.CF1_ZoningDescription := L.property.ConfidenceFactor1.ZoningDescription;
		
	//iesp.property_info.t_ConfidenceFactor2 := L.property.ConfidenceFactor1.;
    Self.CF2_DeedDocumentNumber := L.property.ConfidenceFactor2.DeedDocumentNumber;
    Self.CF2_DeedRecordingDate := L.property.ConfidenceFactor2.DeedRecordingDate;
    Self.CF2_InterestRateTypeCode := L.property.ConfidenceFactor2.InterestRateTypeCode;
    Self.CF2_LoanAmount := L.property.ConfidenceFactor2.LoanAmount;
    Self.CF2_LoanTypeCode := L.property.ConfidenceFactor2.LoanTypeCode;
    Self.CF2_MortgageCompanyName := L.property.ConfidenceFactor2.MortgageCompanyName;
    Self.CF2_SaleFullOrPart := L.property.ConfidenceFactor2.SaleFullOrPart;
    Self.CF2_SalesAmount := L.property.ConfidenceFactor2.SalesAmount;
    Self.CF2_SalesDate := L.property.ConfidenceFactor2.SalesDate;
    Self.CF2_SalesTypeCode := L.property.ConfidenceFactor2.SalesTypeCode;
    Self.CF2_SecondLoanAmount := L.property.ConfidenceFactor2.SecondLoanAmount;

    Self := L.ERC[1].CostSummary;
    Self.ERC_LivingAreaSF := L.ERC[1].PropertyAttributes.LivingAreaSF;
    Self.ERC_Stories := L.ERC[1].PropertyAttributes.Stories;
    Self.ERC_Bedrooms := L.ERC[1].PropertyAttributes.Bedrooms;
    Self.ERC_Baths := L.ERC[1].PropertyAttributes.Baths;
    Self.ERC_Fireplaces := L.ERC[1].PropertyAttributes.Fireplaces;
    Self.ERC_Pool := L.ERC[1].PropertyAttributes.Pool; //values['U','Y','N','']
    Self.ERC_AC := L.ERC[1].PropertyAttributes.AC; //values['U','Y','N','']
    Self.ERC_YearBuilt := L.ERC[1].PropertyAttributes.YearBuilt;
    Self.ERC_SlopeCode := L.ERC[1].PropertyAttributes.SlopeCode;
    Self.ERC_Slope := L.ERC[1].PropertyAttributes.Slope;
    Self.ERC_QualityOfStructCode := L.ERC[1].PropertyAttributes.QualityOfStructCode;
    Self.ERC_QualityOfStruct := L.ERC[1].PropertyAttributes.QualityOfStruct;
    Self.ERC_ReplacementCostReportId := L.ERC[1].PropertyAttributes.ReplacementCostReportId;
    Self.ERC_PolicyCoverageValue := L.ERC[1].PropertyAttributes.PolicyCoverageValue;
    Self.ERC_FireplaceIndicator := L.ERC[1].PropertyAttributes.FireplaceIndicator; //values['U','Y','N','']
    Self.ERC_TypeOfResidence := L.ERC[1].PropertyAttributes.TypeOfResidence;

    %erc_characteristics%
    %erc_propertydescriptions%

    // diagnostics:
    Self.is_cleaned := L.clean_address.is_cleaned;
    Self.general_err := L.general_err;
    Self.erc_err := L.erc_err;
    Self.erc_err_message := L.erc_err_message;
  end;

	EXPORT PropertyCharacteristics_Services.Layouts.inhouse_layout xJoinAB(PropertyCharacteristics_Services.Layouts.inhouse_layout L, PropertyCharacteristics_Services.Layouts.inhouse_layout R) := TRANSFORM
		self.src_building_square_footage 			:= IF(L.src_building_square_footage = 'DEFLT' AND R.src_building_square_footage <> '', '', L.src_building_square_footage);
		self.building_square_footage					:= IF(self.src_building_square_footage = '', '', L.building_square_footage);
		self.tax_dt_building_square_footage		:= IF(self.src_building_square_footage = '', '', L.tax_dt_building_square_footage);
		
		self.src_air_conditioning_type 				:= IF(L.src_air_conditioning_type = 'DEFLT' AND R.src_air_conditioning_type <> '', '', L.src_air_conditioning_type);
		self.air_conditioning_type						:= IF(self.src_air_conditioning_type = '', '', L.air_conditioning_type);
		self.tax_dt_air_conditioning_type			:= IF(self.src_air_conditioning_type = '', '', L.tax_dt_air_conditioning_type);
		
		self.src_basement_finish 							:= IF(L.src_basement_finish = 'DEFLT' AND R.src_basement_finish <> '', '', L.src_basement_finish);
		self.basement_finish									:= IF(self.src_basement_finish = '', '', L.basement_finish);
		self.tax_dt_basement_finish						:= IF(self.src_basement_finish = '', '', L.tax_dt_basement_finish);
		
		self.src_construction_type 						:= IF(L.src_construction_type = 'DEFLT' AND R.src_construction_type <> '', '', L.src_construction_type);
		self.construction_type								:= IF(self.src_construction_type = '', '', L.construction_type);
		self.tax_dt_construction_type					:= IF(self.src_construction_type = '', '', L.construction_type);
		
		self.src_exterior_wall 								:= IF(L.src_exterior_wall = 'DEFLT' AND R.src_exterior_wall <> '', '', L.src_exterior_wall);
		self.exterior_wall										:= IF(self.src_exterior_wall = '', '', L.exterior_wall);
		self.tax_dt_exterior_wall							:= IF(self.src_exterior_wall = '', '', L.tax_dt_exterior_wall);
		
		self.src_fireplace_ind 								:= IF(L.src_fireplace_ind = 'DEFLT' AND R.src_fireplace_ind <> '', '', L.src_fireplace_ind);
		self.fireplace_ind										:= IF(self.src_fireplace_ind = '', '', L.fireplace_ind);
		self.tax_dt_fireplace_ind							:= IF(self.src_fireplace_ind = '', '', L.tax_dt_fireplace_ind);
		
		self.src_fireplace_type 							:= IF(L.src_fireplace_type = 'DEFLT' AND R.src_fireplace_type <> '', '', L.src_fireplace_type);
		self.fireplace_type										:= IF(self.src_fireplace_type = '', '', L.fireplace_type);
		self.tax_dt_fireplace_type						:= IF(self.src_fireplace_type = '', '', L.tax_dt_fireplace_type);
		
		self.src_flood_zone_panel 						:= IF(L.src_flood_zone_panel = 'DEFLT' AND R.src_flood_zone_panel <> '', '', L.src_flood_zone_panel);
		self.flood_zone_panel									:= IF(self.src_flood_zone_panel = '', '', L.flood_zone_panel);
		self.tax_dt_flood_zone_panel					:= IF(self.src_flood_zone_panel = '', '', L.tax_dt_flood_zone_panel);
		
		self.src_garage 											:= IF(L.src_garage = 'DEFLT' AND R.src_garage <> '', '', L.src_garage);
		self.garage														:= IF(self.src_garage = '', '', L.garage);
		self.tax_dt_garage										:= IF(self.src_garage = '', '', L.tax_dt_garage);

		self.src_first_floor_square_footage 		:= IF(L.src_first_floor_square_footage = 'DEFLT' AND R.src_first_floor_square_footage <> '', '', L.src_first_floor_square_footage);
		self.first_floor_square_footage					:= IF(self.src_first_floor_square_footage = '', '', L.first_floor_square_footage);
		self.tax_dt_first_floor_square_footage	:= IF(self.src_first_floor_square_footage = '', '', L.tax_dt_first_floor_square_footage);
		
		self.src_heating 											:= IF(L.src_heating = 'DEFLT' AND R.src_heating <> '', '', L.src_heating);
		self.heating													:= IF(self.src_heating = '', '', L.heating);
		self.tax_dt_heating										:= IF(self.src_heating = '', '', L.tax_dt_heating);
		
		self.src_living_area_square_footage 		:= IF(L.src_living_area_square_footage = 'DEFLT' AND R.src_living_area_square_footage <> '', '', L.src_living_area_square_footage);
		self.living_area_square_footage					:= IF(self.src_living_area_square_footage = '', '', L.living_area_square_footage);
		self.tax_dt_living_area_square_footage	:= IF(self.src_living_area_square_footage = '', '', L.tax_dt_living_area_square_footage);
		
		self.src_no_of_baths 									:= IF(L.src_no_of_baths = 'DEFLT' AND R.src_no_of_baths <> '', '', L.src_no_of_baths);
		self.no_of_baths											:= IF(self.src_no_of_baths = '', '', L.no_of_baths);
		self.tax_dt_no_of_baths								:= IF(self.src_no_of_baths = '', '', L.tax_dt_no_of_baths);
		
		self.src_no_of_bedrooms 							:= IF(L.src_no_of_bedrooms = 'DEFLT' AND R.src_no_of_bedrooms <> '', '', L.src_no_of_bedrooms);
		self.no_of_bedrooms										:= IF(self.src_no_of_bedrooms = '', '', L.no_of_bedrooms);
		self.tax_dt_no_of_bedrooms						:= IF(self.src_no_of_bedrooms = '', '', L.tax_dt_no_of_bedrooms);
		
		self.src_no_of_fireplaces 						:= IF(L.src_no_of_fireplaces = 'DEFLT' AND R.src_no_of_fireplaces <> '', '', L.src_no_of_fireplaces);
		self.no_of_fireplaces									:= IF(self.src_no_of_fireplaces = '', '', L.no_of_fireplaces);
		self.tax_dt_no_of_fireplaces					:= IF(self.src_no_of_fireplaces = '', '', L.tax_dt_no_of_fireplaces);
		
		self.src_no_of_full_baths 						:= IF(L.src_no_of_full_baths = 'DEFLT' AND R.src_no_of_full_baths <> '', '', L.src_no_of_full_baths);
		self.no_of_full_baths									:= IF(self.src_no_of_full_baths = '', '', L.no_of_full_baths);
		self.tax_dt_no_of_full_baths					:= IF(self.src_no_of_full_baths = '', '', L.tax_dt_no_of_full_baths);
		
		self.src_no_of_half_baths 						:= IF(L.src_no_of_half_baths = 'DEFLT' AND R.src_no_of_half_baths <> '', '', L.src_no_of_half_baths);
		self.no_of_half_baths									:= IF(self.src_no_of_half_baths = '', '', L.no_of_half_baths);
		self.tax_dt_no_of_half_baths					:= IF(self.src_no_of_half_baths = '', '', L.tax_dt_no_of_half_baths);
		
		self.src_no_of_stories 								:= IF(L.src_no_of_stories = 'DEFLT' AND R.src_no_of_stories <> '', '', L.src_no_of_stories);
		self.no_of_stories										:= IF(self.src_no_of_stories = '', '', L.no_of_stories);
		self.tax_dt_no_of_stories							:= IF(self.src_no_of_stories = '', '', L.tax_dt_no_of_stories);
		
		self.src_parking_type 								:= IF(L.src_parking_type = 'DEFLT' AND R.src_parking_type <> '', '', L.src_parking_type);
		self.parking_type											:= IF(self.src_parking_type = '', '', L.parking_type);
		self.tax_dt_parking_type							:= IF(self.src_parking_type = '', '', L.tax_dt_parking_type);
		
		self.src_pool_indicator 							:= IF(L.src_pool_indicator = 'DEFLT' AND R.src_pool_indicator <> '', '', L.src_pool_indicator);
		self.pool_indicator										:= IF(self.src_pool_indicator = '', '', L.pool_indicator);
		self.tax_dt_pool_indicator						:= IF(self.src_pool_indicator = '', '', L.tax_dt_pool_indicator);
		
		self.src_pool_type 										:= IF(L.src_pool_type = 'DEFLT' AND R.src_pool_type <> '', '', L.src_pool_type);
		self.pool_type												:= IF(self.src_pool_type = '', '', L.pool_type);
		self.tax_dt_pool_type									:= IF(self.src_pool_type = '', '', L.tax_dt_pool_type);
		
		self.src_roof_cover 									:= IF(L.src_roof_cover = 'DEFLT' AND R.src_roof_cover <> '', '', L.src_roof_cover);
		self.roof_cover												:= IF(self.src_roof_cover = '', '', L.roof_cover);
		self.tax_dt_roof_cover								:= IF(self.src_roof_cover = '', '', L.tax_dt_roof_cover);
		
		self.src_year_built 									:= IF(L.src_year_built = 'DEFLT' AND R.src_year_built <> '', '', L.src_year_built);
		self.year_built												:= IF(self.src_year_built = '', '', L.year_built);
		self.tax_dt_year_built								:= IF(self.src_year_built = '', '', L.tax_dt_year_built);
		
		self.src_foundation 									:= IF(L.src_foundation = 'DEFLT' AND R.src_foundation <> '', '', L.src_foundation);
		self.foundation												:= IF(self.src_foundation = '', '', L.foundation);
		self.tax_dt_foundation								:= IF(self.src_foundation = '', '', L.tax_dt_foundation);
		
		self.src_basement_square_footage 			:= IF(L.src_basement_square_footage = 'DEFLT' AND R.src_basement_square_footage <> '', '', L.src_basement_square_footage);
		self.basement_square_footage					:= IF(self.src_basement_square_footage = '', '', L.basement_square_footage);
		self.tax_dt_basement_square_footage		:= IF(self.src_basement_square_footage = '', '', L.tax_dt_basement_square_footage);
		
		self.src_effective_year_built 				:= IF(L.src_effective_year_built = 'DEFLT' AND R.src_effective_year_built <> '', '', L.src_effective_year_built);
		self.effective_year_built							:= IF(self.src_effective_year_built = '', '', L.effective_year_built);
		self.tax_dt_effective_year_built			:= IF(self.src_effective_year_built = '', '', L.tax_dt_effective_year_built);
		
		self.src_garage_square_footage 				:= IF(L.src_garage_square_footage = 'DEFLT' AND R.src_garage_square_footage <> '', '', L.src_garage_square_footage);
		self.garage_square_footage						:= IF(self.src_garage_square_footage = '', '', L.garage_square_footage);
		self.tax_dt_garage_square_footage			:= IF(self.src_garage_square_footage = '', '', L.tax_dt_garage_square_footage);
		
		self.src_stories_type 								:= IF(L.src_stories_type = 'DEFLT' AND R.src_stories_type <> '', '', L.src_stories_type);
		self.stories_type											:= IF(self.src_stories_type = '', '', L.stories_type);
		self.tax_dt_stories_type							:= IF(self.src_stories_type = '', '', L.tax_dt_stories_type);
		
		self.src_apn_number 									:= IF(L.src_apn_number = 'DEFLT' AND R.src_apn_number <> '', '', L.src_apn_number);
		self.apn_number												:= IF(self.src_apn_number = '', '', L.apn_number);
		self.tax_dt_apn_number								:= IF(self.src_apn_number = '', '', L.tax_dt_apn_number);
		
		self.src_census_tract 								:= IF(L.src_census_tract = 'DEFLT' AND R.src_census_tract <> '', '', L.src_census_tract);
		self.census_tract											:= IF(self.src_census_tract = '', '', L.census_tract);
		self.tax_dt_census_tract							:= IF(self.src_census_tract = '', '', L.tax_dt_census_tract);
		
		self.src_range 												:= IF(L.src_range = 'DEFLT' AND R.src_range <> '', '', L.src_range);
		self.range														:= IF(self.src_range = '', '', L.range);
		self.tax_dt_range											:= IF(self.src_range = '', '', L.tax_dt_range);
		
		self.src_zoning 											:= IF(L.src_zoning = 'DEFLT' AND R.src_zoning <> '', '', L.src_zoning);
		self.zoning														:= IF(self.src_zoning = '', '', L.zoning);
		self.tax_dt_zoning										:= IF(self.src_zoning = '', '', L.tax_dt_zoning);
		
		self.src_block_number 								:= IF(L.src_block_number = 'DEFLT' AND R.src_block_number <> '', '', L.src_block_number);
		self.block_number											:= IF(self.src_block_number = '', '', L.block_number);
		self.tax_dt_block_number							:= IF(self.src_block_number = '', '', L.tax_dt_block_number);
		
		self.src_county_name 									:= IF(L.src_county_name = 'DEFLT' AND R.src_county_name <> '', '', L.src_county_name);
		self.county_name											:= IF(self.src_county_name = '', '', L.county_name);
		self.tax_dt_county_name								:= IF(self.src_county_name = '', '', L.tax_dt_county_name);
		
		self.src_fips_code 										:= IF(L.src_fips_code = 'DEFLT' AND R.src_fips_code <> '', '', L.src_fips_code);
		self.fips_code												:= IF(self.src_fips_code = '', '', L.fips_code);
		self.tax_dt_fips_code									:= IF(self.src_fips_code = '', '', L.tax_dt_fips_code);
		
		self.src_subdivision 									:= IF(L.src_subdivision = 'DEFLT' AND R.src_subdivision <> '', '', L.src_subdivision);
		self.subdivision											:= IF(self.src_subdivision = '', '', L.subdivision);
		self.tax_dt_subdivision								:= IF(self.src_subdivision = '', '', L.tax_dt_subdivision);
		
		self.src_municipality 								:= IF(L.src_municipality = 'DEFLT' AND R.src_municipality <> '', '', L.src_municipality);
		self.municipality											:= IF(self.src_municipality = '', '', L.municipality);
		self.tax_dt_municipality							:= IF(self.src_municipality = '', '', L.tax_dt_municipality);
		
		self.src_township 										:= IF(L.src_township = 'DEFLT' AND R.src_township <> '', '', L.src_township);
		self.township													:= IF(self.src_township = '', '', L.township);
		self.tax_dt_township									:= IF(self.src_township = '', '', L.tax_dt_township);
		
		self.src_homestead_exemption_ind 			:= IF(L.src_homestead_exemption_ind = 'DEFLT' AND R.src_homestead_exemption_ind <> '', '', L.src_homestead_exemption_ind);
		self.homestead_exemption_ind					:= IF(self.src_homestead_exemption_ind = '', '', L.homestead_exemption_ind);
		self.tax_dt_homestead_exemption_ind		:= IF(self.src_homestead_exemption_ind = '', '', L.tax_dt_homestead_exemption_ind);
		
		self.src_land_use_code 								:= IF(L.src_land_use_code = 'DEFLT' AND R.src_land_use_code <> '', '', L.src_land_use_code);
		self.land_use_code										:= IF(self.src_land_use_code = '', '', L.land_use_code);
		self.tax_dt_land_use_code							:= IF(self.src_land_use_code = '', '', L.tax_dt_land_use_code);
		
		self.src_latitude 										:= IF(L.src_latitude = 'DEFLT' AND R.src_latitude <> '', '', L.src_latitude);
		self.latitude													:= IF(self.src_latitude = '', '', L.latitude);
		self.tax_dt_latitude									:= IF(self.src_latitude = '', '', L.tax_dt_latitude);
		
		self.src_longitude 										:= IF(L.src_longitude = 'DEFLT' AND R.src_longitude <> '', '', L.src_longitude);
		self.longitude												:= IF(self.src_longitude = '', '', L.longitude);
		self.tax_dt_longitude									:= IF(self.src_longitude = '', '', L.tax_dt_longitude);
		
		self.src_location_influence_code 			:= IF(L.src_location_influence_code = 'DEFLT' AND R.src_location_influence_code <> '', '', L.src_location_influence_code);
		self.location_influence_code					:= IF(self.src_location_influence_code = '', '', L.location_influence_code);
		self.tax_dt_location_influence_code		:= IF(self.src_location_influence_code = '', '', L.tax_dt_location_influence_code);
		
		self.src_acres 												:= IF(L.src_acres = 'DEFLT' AND R.src_acres <> '', '', L.src_acres);
		self.acres														:= IF(self.src_acres = '', '', L.acres);
		self.tax_dt_acres											:= IF(self.src_acres = '', '', L.tax_dt_acres);
		
		self.src_lot_depth_footage 						:= IF(L.src_lot_depth_footage = 'DEFLT' AND R.src_lot_depth_footage <> '', '', L.src_lot_depth_footage);
		self.lot_depth_footage								:= IF(self.src_lot_depth_footage = '', '', L.lot_depth_footage);
		self.tax_dt_lot_depth_footage					:= IF(self.src_lot_depth_footage = '', '', L.tax_dt_lot_depth_footage);
		
		self.src_lot_front_footage 						:= IF(L.src_lot_front_footage = 'DEFLT' AND R.src_lot_front_footage <> '', '', L.src_lot_front_footage);
		self.lot_front_footage								:= IF(self.src_lot_front_footage = '', '', L.lot_front_footage);
		self.tax_dt_lot_front_footage					:= IF(self.src_lot_front_footage = '', '', L.tax_dt_lot_front_footage);
		
		self.src_lot_number 									:= IF(L.src_lot_number = 'DEFLT' AND R.src_lot_number <> '', '', L.src_lot_number);
		self.lot_number												:= IF(self.src_lot_number = '', '', L.lot_number);
		self.tax_dt_lot_number								:= IF(self.src_lot_number = '', '', L.tax_dt_lot_number);
		
		self.src_lot_size 										:= IF(L.src_lot_size = 'DEFLT' AND R.src_lot_size <> '', '', L.src_lot_size);
		self.lot_size													:= IF(self.src_lot_size = '', '', L.lot_size);
		self.tax_dt_lot_size									:= IF(self.src_lot_size = '', '', L.tax_dt_lot_size);
		
		self.src_property_type_code 					:= IF(L.src_property_type_code = 'DEFLT' AND R.src_property_type_code <> '', '', L.src_property_type_code);
		self.property_type_code								:= IF(self.src_property_type_code = '', '', L.property_type_code);
		self.tax_dt_property_type_code				:= IF(self.src_property_type_code = '', '', L.tax_dt_property_type_code);
		
		self.src_structure_quality 						:= IF(L.src_structure_quality = 'DEFLT' AND R.src_structure_quality <> '', '', L.src_structure_quality);
		self.structure_quality								:= IF(self.src_structure_quality = '', '', L.structure_quality);
		self.tax_dt_structure_quality					:= IF(self.src_structure_quality = '', '', L.tax_dt_structure_quality);
		
		self.src_water 												:= IF(L.src_water = 'DEFLT' AND R.src_water <> '', '', L.src_water);
		self.water														:= IF(self.src_water = '', '', L.water);
		self.tax_dt_water											:= IF(self.src_water = '', '', L.tax_dt_water);
		
    self.src_sewer 	                    	:= IF(L.src_sewer = 'DEFLT' AND R.src_sewer <> '', '', L.src_sewer);		
		self.sewer					                  := IF(self.src_sewer = '', '', L.sewer);
		self.tax_dt_sewer											:= IF(self.src_sewer = '', '', L.tax_dt_sewer);
		
		self.src_assessed_land_value 		      := IF(L.src_assessed_land_value = 'DEFLT' AND R.src_assessed_land_value <> '', '', L.src_assessed_land_value);
		self.assessed_land_value					    := IF(self.src_assessed_land_value = '', '', L.assessed_land_value);
		self.tax_dt_assessed_land_value       := IF(self.src_assessed_land_value = '', '', L.tax_dt_assessed_land_value);
		
		self.src_assessed_year 					      := IF(L.src_assessed_year = 'DEFLT' AND R.src_assessed_year <> '', '', L.src_assessed_year);
		self.assessed_year                    := IF(self.src_assessed_year = '', '', L.assessed_year);
		self.tax_dt_assessed_year             := IF(self.src_assessed_year = '', '', L.tax_dt_assessed_year);
		
		self.src_tax_amount 		              := IF(L.src_tax_amount = 'DEFLT' AND R.src_tax_amount <> '', '', L.src_tax_amount);
		self.tax_amount					              := IF(self.src_tax_amount = '', '', L.tax_amount);
		self.tax_dt_tax_amount                := IF(self.src_tax_amount = '', '', L.tax_dt_tax_amount); 
		
		self.src_tax_year 		                := IF(L.src_tax_year = 'DEFLT' AND R.src_tax_year <> '', '', L.src_tax_year);
		self.tax_year				                	:= IF(self.src_tax_year = '', '', L.tax_year);
				
    self.src_market_land_value 		        := IF(L.src_market_land_value = 'DEFLT' AND R.src_market_land_value <> '', '', L.src_market_land_value);		
		self.market_land_value					      := IF(self.src_market_land_value = '', '', L.market_land_value);
		self.tax_dt_market_land_value         := IF(self.src_market_land_value = '', '', L.tax_dt_market_land_value); 
		
    self.src_improvement_value 		        := IF(L.src_improvement_value = 'DEFLT' AND R.src_improvement_value <> '', '', L.src_improvement_value);		
		self.improvement_value					      := IF(self.src_improvement_value = '', '', L.improvement_value);
		self.tax_dt_improvement_value         := IF(self.src_improvement_value = '', '', L.tax_dt_improvement_value);
		
    self.src_percent_improved 		        := IF(L.src_percent_improved  = 'DEFLT' AND R.src_percent_improved <> '', '', L.src_percent_improved);		
		self.percent_improved					        := IF(self.src_percent_improved  = '', 0, L.percent_improved);
		self.tax_dt_percent_improved          := IF(self.src_percent_improved = '', '', L.tax_dt_improvement_value);
		
    self.src_total_assessed_value 		    := IF(L.src_total_assessed_value = 'DEFLT' AND R.src_total_assessed_value <> '', '', L.src_total_assessed_value);		
		self.total_assessed_value					    := IF(self.src_total_assessed_value = '', '', L.total_assessed_value);
		self.tax_dt_total_assessed_value      := IF(self.src_total_assessed_value = '', '', L.tax_dt_total_assessed_value);
		
    self.src_total_calculated_value 		  := IF(L.src_total_calculated_value = 'DEFLT' AND R.src_total_calculated_value <> '', '', L.src_total_calculated_value);		
		self.total_calculated_value					  := IF(self.src_total_calculated_value = '', '', L.total_calculated_value);
		self.tax_dt_total_calculated_value    := IF(self.src_total_calculated_value = '', '', L.tax_dt_total_calculated_value);
		
		self.src_total_land_value 		        := IF(L.src_total_land_value = 'DEFLT' AND R.src_total_land_value <> '', '', L.src_total_land_value);
		self.total_land_value					        := IF(self.src_total_land_value = '', '', L.total_land_value);
		self.tax_dt_total_land_value          := IF(self.src_total_land_value = '', '', L.tax_dt_total_land_value);
		
		self.src_total_market_value 		      := IF(L.src_total_market_value = 'DEFLT' AND R.src_total_market_value <> '', '', L.src_total_market_value);
		self.total_market_value					      := IF(self.src_total_market_value = '', '', L.total_market_value);
		self.tax_dt_total_market_value        := IF(self.src_total_market_value = '', '', L.tax_dt_total_market_value);
		
    self.src_floor_type 		              := IF(L.src_floor_type = 'DEFLT' AND R.src_floor_type <> '', '', L.src_floor_type);		
		self.floor_type					              := IF(self.src_floor_type = '', '', L.floor_type);
		self.tax_dt_floor_type                := IF(self.src_floor_type  = '', '', L.tax_dt_floor_type);
		
    self.src_frame_type 		              := IF(L.src_frame_type = 'DEFLT' AND R.src_frame_type <> '', '', L.src_frame_type);		
		self.frame_type					              := IF(self.src_frame_type = '', '', L.frame_type);
		self.tax_dt_frame_type                := IF(self.src_frame_type  = '', '', L.tax_dt_frame_type);
		
    self.src_fuel_type 	                	:= IF(L.src_fuel_type = 'DEFLT' AND R.src_fuel_type <> '', '', L.src_fuel_type);		
		self.fuel_type					              := IF(self.src_fuel_type = '', '', L.fuel_type);
		self.tax_dt_fuel_type                 := IF(self.src_fuel_type  = '', '', L.tax_dt_fuel_type);
		
    self.src_no_of_bath_fixtures 		      := IF(L.src_no_of_bath_fixtures = 'DEFLT' AND R.src_no_of_bath_fixtures <> '', '', L.src_no_of_bath_fixtures);		
		self.no_of_bath_fixtures				    	:= IF(self.src_no_of_bath_fixtures = '', '', L.no_of_bath_fixtures);
		self.tax_dt_no_of_bath_fixtures       := IF(self.src_no_of_bath_fixtures  = '', '', L.tax_dt_no_of_bath_fixtures);
		
		self.src_no_of_rooms 		              := IF(L.src_no_of_rooms = 'DEFLT' AND R.src_no_of_rooms <> '', '', L.src_no_of_rooms);
		self.no_of_rooms				            	:= IF(self.src_no_of_rooms = '', '', L.no_of_rooms);
		self.tax_dt_no_of_rooms               := IF(self.src_no_of_rooms = '', '', L.tax_dt_no_of_rooms);
		
		self.src_no_of_units 		              := IF(L.src_no_of_units = 'DEFLT' AND R.src_no_of_units <> '', '', L.src_no_of_units);
		self.no_of_units					            := IF(self.src_no_of_units = '', '', L.no_of_units);
		self.tax_dt_no_of_units               := IF(self.src_no_of_units = '', '', L.tax_dt_no_of_units);
		
    self.src_style_type 		              := IF(L.src_style_type = 'DEFLT' AND R.src_style_type <> '', '', L.src_style_type);		
		self.style_type					              := IF(self.src_style_type = '', '', L.style_type);
		self.tax_dt_style_type                := IF(self.src_style_type = '', '', L.tax_dt_style_type);
		
    self.src_assessment_document_number 	  := IF(L.src_assessment_document_number = 'DEFLT' AND R.src_assessment_document_number <> '', '', L.src_assessment_document_number);		
		self.assessment_document_number					:= IF(self.src_assessment_document_number = '', '', L.assessment_document_number);
		self.tax_dt_assessment_document_number  := IF(self.src_assessment_document_number = '', '', L.tax_dt_assessment_document_number);
		
    self.src_assessment_recording_date 		  := IF(L.src_assessment_recording_date = 'DEFLT' AND R.src_assessment_recording_date <> '', '', L.src_assessment_recording_date);		
		self.assessment_recording_date					:= IF(self.src_assessment_recording_date = '', '', L.assessment_recording_date);
		self.tax_dt_assessment_recording_date   := IF(self.src_assessment_recording_date = '', '', L.tax_dt_assessment_recording_date);
		
    self.src_deed_document_number 	      	:= IF(L.src_deed_document_number = 'DEFLT' AND R.src_deed_document_number <> '', '', L.src_deed_document_number);		
		self.deed_document_number				      	:= IF(self.src_deed_document_number = '', '', L.deed_document_number);
		self.rec_dt_deed_document_number        := IF(self.src_deed_document_number = '', '', L.rec_dt_deed_document_number);
		
		self.src_deed_recording_date 		        := IF(L.src_deed_recording_date = 'DEFLT' AND R.src_deed_recording_date <> '', '', L.src_deed_recording_date);
		self.deed_recording_date				        := IF(self.src_deed_recording_date = '', '', L.deed_recording_date);
		
		self.src_full_part_sale 		            := IF(L.src_full_part_sale = 'DEFLT' AND R.src_full_part_sale <> '', '', L.src_full_part_sale);
		self.full_part_sale					            := IF(self.src_full_part_sale = '', '', L.full_part_sale);
		self.rec_dt_full_part_sale              := IF(self.src_full_part_sale = '', '', L.rec_dt_full_part_sale);
		
    self.src_sale_amount 		                := IF(L.src_sale_amount = 'DEFLT' AND R.src_sale_amount <> '', '', L.src_sale_amount);		
		self.sale_amount					              := IF(self.src_sale_amount = '', '', L.sale_amount);
		self.rec_dt_sale_amount                 := IF(self.src_sale_amount= '', '', L.rec_dt_sale_amount);
		
		self.src_sale_date 		                  := IF(L.src_sale_date = 'DEFLT' AND R.src_sale_date <> '', '', L.src_sale_date);
		self.sale_date					                := IF(self.src_sale_date = '', '', L.sale_date);
		self.rec_dt_sale_date                   := IF(self.src_sale_date= '', '', L.rec_dt_sale_date);
		
		self.src_sale_type_code 		            := IF(L.src_sale_type_code = 'DEFLT' AND R.src_sale_type_code <> '', '', L.src_sale_type_code);
		self.sale_type_code					            := IF(self.src_sale_type_code = '', '', L.sale_type_code);
		self.rec_dt_sale_type_code              := IF(self.src_sale_type_code	= '', '', L.rec_dt_sale_type_code);
		
    self.src_mortgage_company_name 		      := IF(L.src_mortgage_company_name = 'DEFLT' AND R.src_mortgage_company_name <> '', '', L.src_mortgage_company_name);		
		self.mortgage_company_name					    := IF(self.src_mortgage_company_name = '', '', L.mortgage_company_name);
		self.rec_dt_mortgage_company_name       := IF(self.src_mortgage_company_name	= '', '', L.rec_dt_mortgage_company_name);
		
    self.src_loan_amount 		                := IF(L.src_loan_amount = 'DEFLT' AND R.src_loan_amount <> '', '', L.src_loan_amount);		
		self.loan_amount					              := IF(self.src_loan_amount = '', '', L.loan_amount);
		self.rec_dt_loan_amount                 := IF(self.src_loan_amount = '', '', L.rec_dt_loan_amount);
		
		self.src_second_loan_amount 		        := IF(L.src_second_loan_amount = 'DEFLT' AND R.src_second_loan_amount <> '', '', L.src_second_loan_amount);
		self.second_loan_amount					        := IF(self.src_second_loan_amount = '', '', L.second_loan_amount);
		self.rec_dt_second_loan_amount          := IF(self.src_second_loan_amount	= '', '', L.rec_dt_second_loan_amount);
		
		self.src_loan_type_code 		            := IF(L.src_loan_type_code = 'DEFLT' AND R.src_loan_type_code <> '', '', L.src_loan_type_code);
		self.loan_type_code					            := IF(self.src_loan_type_code = '', '', L.loan_type_code);
		self.rec_dt_loan_type_code              := IF(self.src_loan_type_code = '', '', L.rec_dt_loan_type_code);
		
		self.src_interest_rate_type_code 		    := IF(L.src_interest_rate_type_code = 'DEFLT' AND R.src_interest_rate_type_code <> '', '', L.src_interest_rate_type_code);
		self.interest_rate_type_code					  := IF(self.src_interest_rate_type_code = '', '', L.interest_rate_type_code);
		self.rec_dt_interest_rate_type_code     := IF(self.src_interest_rate_type_code = '', '', L.rec_dt_interest_rate_type_code);

		self := L;

	END;
	
	// Rollup source B records where you have move than one value for a field.
	EXPORT PropertyCharacteristics_Services.Layouts.inhouse_layout xRollUpB_Rec(PropertyCharacteristics_Services.Layouts.inhouse_layout L, PropertyCharacteristics_Services.Layouts.inhouse_layout R) := TRANSFORM
    score(STRING val) := CASE(val, '' => 0 , 'DEFLT' => 1, 2);
		
		self.src_building_square_footage 			  := IF(score(L.src_building_square_footage) > score(R.src_building_square_footage), L.src_building_square_footage, R.src_building_square_footage);
		self.building_square_footage					  := IF(score(L.src_building_square_footage) > score(R.src_building_square_footage), L.building_square_footage, R.building_square_footage);
		self.tax_dt_building_square_footage		  := IF(score(L.src_building_square_footage) > score(R.src_building_square_footage), L.tax_dt_building_square_footage, R.tax_dt_building_square_footage);
		
		self.src_air_conditioning_type 				  := IF(score(L.src_air_conditioning_type) > score(R.src_air_conditioning_type), L.src_air_conditioning_type, R.src_air_conditioning_type);
		self.air_conditioning_type						  := IF(score(L.src_air_conditioning_type) > score(R.src_air_conditioning_type), L.air_conditioning_type, R.air_conditioning_type);
		self.tax_dt_air_conditioning_type			  := IF(score(L.src_air_conditioning_type) > score(R.src_air_conditioning_type), L.tax_dt_air_conditioning_type, R.tax_dt_air_conditioning_type);
		
		self.src_basement_finish 							  := IF(score(L.src_basement_finish) > score(R.src_basement_finish), L.src_basement_finish, R.src_basement_finish);
		self.basement_finish									  := IF(score(L.src_basement_finish) > score(R.src_basement_finish), L.basement_finish, R.basement_finish);
		self.tax_dt_basement_finish						  := IF(score(L.src_basement_finish) > score(R.src_basement_finish), L.tax_dt_basement_finish, R.tax_dt_basement_finish);
		
		self.src_construction_type 						  := IF(score(L.src_construction_type) > score(R.src_construction_type), L.src_construction_type, R.src_construction_type);
		self.construction_type								  := IF(score(L.src_construction_type) > score(R.src_construction_type), L.construction_type, R.construction_type);
		self.tax_dt_construction_type					  := IF(score(L.src_construction_type) > score(R.src_construction_type), L.tax_dt_construction_type, R.tax_dt_construction_type);
		
		self.src_exterior_wall 								  := IF(score(L.src_exterior_wall) > score(R.src_exterior_wall), L.src_exterior_wall, R.src_exterior_wall);
		self.exterior_wall										  := IF(score(L.src_exterior_wall) > score(R.src_exterior_wall), L.exterior_wall, R.exterior_wall);
		self.tax_dt_exterior_wall							  := IF(score(L.src_exterior_wall) > score(R.src_exterior_wall), L.tax_dt_exterior_wall, R.tax_dt_exterior_wall);
		
		self.src_fireplace_ind 								  := IF(score(L.src_fireplace_ind) > score(R.src_fireplace_ind), L.src_fireplace_ind, R.src_fireplace_ind);
		self.fireplace_ind										  := IF(score(L.src_fireplace_ind) > score(R.src_fireplace_ind), L.fireplace_ind, R.fireplace_ind);
		self.tax_dt_fireplace_ind							  := IF(score(L.src_fireplace_ind) > score(R.src_fireplace_ind), L.tax_dt_fireplace_ind, R.tax_dt_fireplace_ind);
		
		self.src_fireplace_type 							  := IF(score(L.src_fireplace_type) > score(R.src_fireplace_type), L.src_fireplace_type, R.src_fireplace_type);
		self.fireplace_type										  := IF(score(L.src_fireplace_type) > score(R.src_fireplace_type), L.fireplace_type, R.fireplace_type);
		self.tax_dt_fireplace_type						  := IF(score(L.src_fireplace_type) > score(R.src_fireplace_type), L.tax_dt_fireplace_type, R.tax_dt_fireplace_type);
		
		self.src_flood_zone_panel 						  := IF(score(L.src_flood_zone_panel) > score(R.src_flood_zone_panel), L.src_flood_zone_panel, R.src_flood_zone_panel);
		self.flood_zone_panel									  := IF(score(L.src_flood_zone_panel) > score(R.src_flood_zone_panel), L.flood_zone_panel, R.flood_zone_panel);
		self.tax_dt_flood_zone_panel					  := IF(score(L.src_flood_zone_panel) > score(R.src_flood_zone_panel), L.tax_dt_flood_zone_panel, R.tax_dt_flood_zone_panel);
		
		self.src_garage 		                    := IF(score(L.src_garage) > score(R.src_garage), L.src_garage, R.src_garage);
		self.garage					                    := IF(score(L.src_garage) > score(R.src_garage), L.garage, R.garage);
		self.tax_dt_garage	                    := IF(score(L.src_garage) > score(R.src_garage), L.tax_dt_garage, R.tax_dt_garage);
			
    self.src_first_floor_square_footage 		:= IF(score(L.src_first_floor_square_footage) > score(R.src_first_floor_square_footage), L.src_first_floor_square_footage, R.src_first_floor_square_footage);
		self.first_floor_square_footage					:= IF(score(L.src_first_floor_square_footage) > score(R.src_first_floor_square_footage), L.first_floor_square_footage, R.first_floor_square_footage);
		self.tax_dt_first_floor_square_footage	:= IF(score(L.src_first_floor_square_footage) > score(R.src_first_floor_square_footage), L.tax_dt_first_floor_square_footage, R.tax_dt_first_floor_square_footage);
		
		self.src_heating 											  := IF(score(L.src_heating) > score(R.src_heating), L.src_heating, R.src_heating);
		self.heating													  := IF(score(L.src_heating) > score(R.src_heating), L.heating, R.heating);
		self.tax_dt_heating										  := IF(score(L.src_heating) > score(R.src_heating), L.tax_dt_heating, R.tax_dt_heating);
		
		self.src_living_area_square_footage 		:= IF(score(L.src_living_area_square_footage) > score(R.src_living_area_square_footage), L.src_living_area_square_footage, R.src_living_area_square_footage);
		self.living_area_square_footage					:= IF(score(L.src_living_area_square_footage) > score(R.src_living_area_square_footage), L.living_area_square_footage, R.living_area_square_footage);
		self.tax_dt_living_area_square_footage	:= IF(score(L.src_living_area_square_footage) > score(R.src_living_area_square_footage), L.tax_dt_living_area_square_footage, R.tax_dt_living_area_square_footage);
		                                          		
		self.src_no_of_baths 						   			:= IF(score(L.src_no_of_baths) > score(R.src_no_of_baths), L.src_no_of_baths, R.src_no_of_baths);
		self.no_of_baths					              := IF(score(L.src_no_of_baths) > score(R.src_no_of_baths), L.no_of_baths, R.no_of_baths);
		self.tax_dt_no_of_baths								  := IF(score(L.src_no_of_baths) > score(R.src_no_of_baths), L.tax_dt_no_of_baths, R.tax_dt_no_of_baths);
		                                       		
		self.src_no_of_bedrooms 							  := IF(score(L.src_no_of_bedrooms) > score(R.src_no_of_bedrooms), L.src_no_of_bedrooms, R.src_no_of_bedrooms);
		self.no_of_bedrooms										  := IF(score(L.src_no_of_bedrooms) > score(R.src_no_of_bedrooms), L.no_of_bedrooms, R.no_of_bedrooms);
		self.tax_dt_no_of_bedrooms						  := IF(score(L.src_no_of_bedrooms) > score(R.src_no_of_bedrooms), L.tax_dt_no_of_bedrooms, R.tax_dt_no_of_bedrooms);
		
		self.src_no_of_fireplaces 					  	:= IF(score(L.src_no_of_fireplaces) > score(R.src_no_of_fireplaces), L.src_no_of_fireplaces, R.src_no_of_fireplaces);
		self.no_of_fireplaces									  := IF(score(L.src_no_of_fireplaces) > score(R.src_no_of_fireplaces), L.no_of_fireplaces, R.no_of_fireplaces);
		self.tax_dt_no_of_fireplaces					  := IF(score(L.src_no_of_fireplaces) > score(R.src_no_of_fireplaces), L.tax_dt_no_of_fireplaces, R.tax_dt_no_of_fireplaces);
		
		self.src_no_of_full_baths 						  := IF(score(L.src_no_of_full_baths) > score(R.src_no_of_full_baths), L.src_no_of_full_baths, R.src_no_of_full_baths);
		self.no_of_full_baths									  := IF(score(L.src_no_of_full_baths) > score(R.src_no_of_full_baths), L.no_of_full_baths, R.no_of_full_baths);
		self.tax_dt_no_of_full_baths					  := IF(score(L.src_no_of_full_baths) > score(R.src_no_of_full_baths), L.tax_dt_no_of_full_baths, R.tax_dt_no_of_full_baths);
		
		self.src_no_of_half_baths 						  := IF(score(L.src_no_of_half_baths) > score(R.src_no_of_half_baths), L.src_no_of_half_baths, R.src_no_of_half_baths);
		self.no_of_half_baths									  := IF(score(L.src_no_of_half_baths) > score(R.src_no_of_half_baths), L.no_of_half_baths, R.no_of_half_baths);
		self.tax_dt_no_of_half_baths					  := IF(score(L.src_no_of_half_baths) > score(R.src_no_of_half_baths), L.tax_dt_no_of_half_baths, R.tax_dt_no_of_half_baths);
		
		self.src_no_of_stories 								  := IF(score(L.src_no_of_stories) > score(R.src_no_of_stories), L.src_no_of_stories, R.src_no_of_stories);
		self.no_of_stories										  := IF(score(L.src_no_of_stories) > score(R.src_no_of_stories), L.no_of_stories, R.no_of_stories);
		self.tax_dt_no_of_stories							  := IF(score(L.src_no_of_stories) > score(R.src_no_of_stories), L.tax_dt_no_of_stories, R.tax_dt_no_of_stories);
		
		self.src_parking_type 								  := IF(score(L.src_parking_type) > score(R.src_parking_type), L.src_parking_type, R.src_parking_type);
		self.parking_type											  := IF(score(L.src_parking_type) > score(R.src_parking_type), L.parking_type, R.parking_type);
		self.tax_dt_parking_type							  := IF(score(L.src_parking_type) > score(R.src_parking_type), L.tax_dt_parking_type, R.tax_dt_parking_type);
		                    		
		self.src_pool_indicator 							  := IF(score(L.src_pool_indicator) > score(R.src_pool_indicator), L.src_pool_indicator, R.src_pool_indicator);
		self.pool_indicator										  := IF(score(L.src_pool_indicator) > score(R.src_pool_indicator), L.pool_indicator, R.pool_indicator);
		self.tax_dt_pool_indicator						  := IF(score(L.src_pool_indicator) > score(R.src_pool_indicator), L.tax_dt_pool_indicator, R.tax_dt_pool_indicator);
		
		self.src_pool_type 										  := IF(score(L.src_pool_type) > score(R.src_pool_type), L.src_pool_type, R.src_pool_type);
		self.pool_type												  := IF(score(L.src_pool_type) > score(R.src_pool_type), L.pool_type, R.pool_type);
		self.tax_dt_pool_type									  := IF(score(L.src_pool_type) > score(R.src_pool_type), L.tax_dt_pool_type, R.tax_dt_pool_type);
		                            		
		self.src_roof_cover 									  := IF(score(L.src_roof_cover) > score(R.src_roof_cover), L.src_roof_cover, R.src_roof_cover);
		self.roof_cover												  := IF(score(L.src_roof_cover) > score(R.src_roof_cover), L.roof_cover, R.roof_cover);
		self.tax_dt_roof_cover								  := IF(score(L.src_roof_cover) > score(R.src_roof_cover), L.tax_dt_roof_cover, R.tax_dt_roof_cover);
		                                     		
		self.src_year_built 								  	:= IF(score(L.src_year_built) > score(R.src_year_built), L.src_year_built, R.src_year_built);
		self.year_built												  := IF(score(L.src_year_built) > score(R.src_year_built), L.year_built, R.year_built);
		self.tax_dt_year_built								  := IF(score(L.src_year_built) > score(R.src_year_built), L.tax_dt_year_built, R.tax_dt_year_built);
		
		self.src_foundation 								  	:= IF(score(L.src_foundation) > score(R.src_foundation), L.src_foundation, R.src_foundation);
		self.foundation												  := IF(score(L.src_foundation) > score(R.src_foundation), L.foundation, R.foundation);
		self.tax_dt_foundation								  := IF(score(L.src_foundation) > score(R.src_foundation), L.tax_dt_foundation, R.tax_dt_foundation);
		
		self.src_basement_square_footage 			  := IF(score(L.src_basement_square_footage) > score(R.src_basement_square_footage), L.src_basement_square_footage, R.src_basement_square_footage);
		self.basement_square_footage					  := IF(score(L.src_basement_square_footage) > score(R.src_basement_square_footage), L.basement_square_footage, R.basement_square_footage);
		self.tax_dt_basement_square_footage		  := IF(score(L.src_basement_square_footage) > score(R.src_basement_square_footage), L.tax_dt_basement_square_footage, R.tax_dt_basement_square_footage);
		                   		
		self.src_effective_year_built 				  := IF(score(L.src_effective_year_built) > score(R.src_effective_year_built), L.src_effective_year_built, R.src_effective_year_built);
		self.effective_year_built							  := IF(score(L.src_effective_year_built) > score(R.src_effective_year_built), L.effective_year_built, R.effective_year_built);
		self.tax_dt_effective_year_built			  := IF(score(L.src_effective_year_built) > score(R.src_effective_year_built), L.tax_dt_effective_year_built, R.tax_dt_effective_year_built);
		
		self.src_garage_square_footage 					:= IF(score(L.src_garage_square_footage) > score(R.src_garage_square_footage), L.src_garage_square_footage, R.src_garage_square_footage);
		self.garage_square_footage							:= IF(score(L.src_garage_square_footage) > score(R.src_garage_square_footage), L.garage_square_footage, R.garage_square_footage);
		self.tax_dt_garage_square_footage				:= IF(score(L.src_garage_square_footage) > score(R.src_garage_square_footage), L.tax_dt_garage_square_footage, R.tax_dt_garage_square_footage);
				
		self.src_stories_type 									:= IF(score(L.src_stories_type) > score(R.src_stories_type), L.src_stories_type, R.src_stories_type);
		self.stories_type												:= IF(score(L.src_stories_type) > score(R.src_stories_type), L.stories_type, R.stories_type);
		self.tax_dt_stories_type								:= IF(score(L.src_stories_type) > score(R.src_stories_type), L.tax_dt_stories_type, R.tax_dt_stories_type);
		
		self.src_apn_number 										:= IF(score(L.src_apn_number) > score(R.src_apn_number), L.src_apn_number, R.src_apn_number);
   	self.apn_number													:= IF(score(L.src_apn_number) > score(R.src_apn_number), L.apn_number, R.apn_number);
		self.tax_dt_apn_number									:= IF(score(L.src_apn_number) > score(R.src_apn_number), L.tax_dt_apn_number, R.tax_dt_apn_number);
		
		self.src_census_tract 									:= IF(score(L.src_census_tract) > score(R.src_census_tract), L.src_census_tract, R.src_census_tract);
		self.census_tract												:= IF(score(L.src_census_tract) > score(R.src_census_tract), L.census_tract, R.census_tract);
		self.tax_dt_census_tract								:= IF(score(L.src_census_tract) > score(R.src_census_tract), L.tax_dt_census_tract, R.tax_dt_census_tract);
	
		self.src_range 													:= IF(score(L.src_range) > score(R.src_range), L.src_range, R.src_range);
		self.range															:= IF(score(L.src_range) > score(R.src_range), L.range, R.range);
		self.tax_dt_range												:= IF(score(L.src_range) > score(R.src_range), L.tax_dt_range, R.tax_dt_range);
		                                  		
		self.src_zoning 												:= IF(score(L.src_zoning) > score(R.src_zoning), L.src_zoning, R.src_zoning);
		self.zoning															:= IF(score(L.src_zoning) > score(R.src_zoning), L.zoning, R.zoning);
		self.tax_dt_zoning											:= IF(score(L.src_zoning) > score(R.src_zoning), L.tax_dt_zoning, R.tax_dt_zoning);
		                                    		
		self.src_block_number 									:= IF(score(L.src_block_number) > score(R.src_block_number), L.src_block_number, R.src_block_number);
		self.block_number												:= IF(score(L.src_block_number) > score(R.src_block_number), L.block_number, R.block_number);
		self.tax_dt_block_number								:= IF(score(L.src_block_number) > score(R.src_block_number), L.tax_dt_block_number, R.tax_dt_block_number);
		
		self.src_county_name 										:= IF(score(L.src_county_name) > score(R.src_county_name), L.src_county_name, R.src_county_name);
		self.county_name												:= IF(score(L.src_county_name) > score(R.src_county_name), L.county_name, R.county_name);
		self.tax_dt_county_name									:= IF(score(L.src_county_name) > score(R.src_county_name), L.tax_dt_county_name, R.tax_dt_county_name);
		
		self.src_fips_code 											:= IF(score(L.src_fips_code) > score(R.src_fips_code), L.src_fips_code, R.src_fips_code);
		self.fips_code													:= IF(score(L.src_fips_code) > score(R.src_fips_code), L.fips_code, R.fips_code);
		self.tax_dt_fips_code										:= IF(score(L.src_fips_code) > score(R.src_fips_code), L.tax_dt_fips_code, R.tax_dt_fips_code);
		                                     		
		self.src_subdivision 										:= IF(score(L.src_subdivision) > score(R.src_subdivision), L.src_subdivision, R.src_subdivision);
		self.subdivision												:= IF(score(L.src_subdivision) > score(R.src_subdivision), L.subdivision, R.subdivision);
		self.tax_dt_subdivision									:= IF(score(L.src_subdivision) > score(R.src_subdivision), L.tax_dt_subdivision, R.tax_dt_subdivision);
		
		self.src_municipality 									:= IF(score(L.src_municipality) > score(R.src_municipality), L.src_municipality, R.src_municipality);
		self.municipality												:= IF(score(L.src_municipality) > score(R.src_municipality), L.municipality, R.municipality);
		self.tax_dt_municipality								:= IF(score(L.src_municipality) > score(R.src_municipality), L.tax_dt_municipality, R.tax_dt_municipality);
		
		self.src_township 											:= IF(score(L.src_township) > score(R.src_township), L.src_township, R.src_township);
		self.township														:= IF(score(L.src_township) > score(R.src_township), L.township, R.township);
		self.tax_dt_township										:= IF(score(L.src_township) > score(R.src_township), L.tax_dt_township, R.tax_dt_township);
		
		self.src_homestead_exemption_ind 				:= IF(score(L.src_homestead_exemption_ind) > score(R.src_homestead_exemption_ind), L.src_homestead_exemption_ind, R.src_homestead_exemption_ind);
		self.homestead_exemption_ind						:= IF(score(L.src_homestead_exemption_ind) > score(R.src_homestead_exemption_ind), L.homestead_exemption_ind, R.homestead_exemption_ind);
		self.tax_dt_homestead_exemption_ind			:= IF(score(L.src_homestead_exemption_ind) > score(R.src_homestead_exemption_ind), L.tax_dt_homestead_exemption_ind, R.tax_dt_homestead_exemption_ind);
		
		self.src_land_use_code 									:= IF(score(L.src_land_use_code) > score(R.src_land_use_code), L.src_land_use_code, R.src_land_use_code);
		self.land_use_code											:= IF(score(L.src_land_use_code) > score(R.src_land_use_code), L.land_use_code, R.land_use_code);
		self.tax_dt_land_use_code								:= IF(score(L.src_land_use_code) > score(R.src_land_use_code), L.tax_dt_land_use_code, R.tax_dt_land_use_code);
		
		self.src_latitude 											:= IF(score(L.src_latitude) > score(R.src_latitude), L.src_latitude, R.src_latitude);
		self.latitude														:= IF(score(L.src_latitude) > score(R.src_latitude), L.latitude, R.latitude);
		self.tax_dt_latitude										:= IF(score(L.src_latitude) > score(R.src_latitude), L.tax_dt_latitude, R.tax_dt_latitude);
		
		self.src_longitude 											:= IF(score(L.src_longitude) > score(R.src_longitude), L.src_longitude, R.src_longitude);
		self.longitude													:= IF(score(L.src_longitude) > score(R.src_longitude), L.longitude, R.longitude);
		self.tax_dt_longitude										:= IF(score(L.src_longitude) > score(R.src_longitude), L.tax_dt_longitude, R.tax_dt_longitude);
		
		self.src_location_influence_code 				:= IF(score(L.src_location_influence_code) > score(R.src_location_influence_code), L.src_location_influence_code, R.src_location_influence_code);
		self.location_influence_code						:= IF(score(L.src_location_influence_code) > score(R.src_location_influence_code), L.location_influence_code, R.location_influence_code);
		self.tax_dt_location_influence_code			:= IF(score(L.src_location_influence_code) > score(R.src_location_influence_code), L.tax_dt_location_influence_code, R.tax_dt_location_influence_code);
		
		self.src_acres 													:= IF(score(L.src_acres) > score(R.src_acres), L.src_acres, R.src_acres);
		self.acres															:= IF(score(L.src_acres) > score(R.src_acres), L.acres, R.acres);
		self.tax_dt_acres												:= IF(score(L.src_acres) > score(R.src_acres), L.tax_dt_acres, R.tax_dt_acres);
		
		self.src_lot_depth_footage 							:= IF(score(L.src_lot_depth_footage) > score(R.src_lot_depth_footage), L.src_lot_depth_footage, R.src_lot_depth_footage);
		self.lot_depth_footage									:= IF(score(L.src_lot_depth_footage) > score(R.src_lot_depth_footage), L.lot_depth_footage, R.lot_depth_footage);
		self.tax_dt_lot_depth_footage						:= IF(score(L.src_lot_depth_footage) > score(R.src_lot_depth_footage), L.tax_dt_lot_depth_footage, R.tax_dt_lot_depth_footage);
		
		self.src_lot_front_footage 							:= IF(score(L.src_lot_front_footage) > score(R.src_lot_front_footage), L.src_lot_front_footage, R.src_lot_front_footage);
		self.lot_front_footage									:= IF(score(L.src_lot_front_footage) > score(R.src_lot_front_footage), L.lot_front_footage, R.lot_front_footage);
		self.tax_dt_lot_front_footage						:= IF(score(L.src_lot_front_footage) > score(R.src_lot_front_footage), L.tax_dt_lot_front_footage, R.tax_dt_lot_front_footage);
		
		self.src_lot_number 										:= IF(score(L.src_lot_number) > score(R.src_lot_number), L.src_lot_number, R.src_lot_number);
		self.lot_number													:= IF(score(L.src_lot_number) > score(R.src_lot_number), L.lot_number, R.lot_number);
		self.tax_dt_lot_number									:= IF(score(L.src_lot_number) > score(R.src_lot_number), L.tax_dt_lot_number, R.tax_dt_lot_number);
		
		self.src_lot_size 											:= IF(score(L.src_lot_size) > score(R.src_lot_size), L.src_lot_size, R.src_lot_size);
		self.lot_size														:= IF(score(L.src_lot_size) > score(R.src_lot_size), L.lot_size, R.lot_size);
		self.tax_dt_lot_size										:= IF(score(L.src_lot_size) > score(R.src_lot_size), L.tax_dt_lot_size, R.tax_dt_lot_size);
		
		self.src_property_type_code 						:= IF(score(L.src_property_type_code) > score(R.src_property_type_code), L.src_property_type_code, R.src_property_type_code);
		self.property_type_code									:= IF(score(L.src_property_type_code) > score(R.src_property_type_code), L.property_type_code, R.property_type_code);
		self.tax_dt_property_type_code					:= IF(score(L.src_property_type_code) > score(R.src_property_type_code), L.tax_dt_property_type_code, R.tax_dt_property_type_code);
		
		self.src_structure_quality 							:= IF(score(L.src_structure_quality) > score(R.src_structure_quality), L.src_structure_quality, R.src_structure_quality);
		self.structure_quality									:= IF(score(L.src_structure_quality) > score(R.src_structure_quality), L.structure_quality, R.structure_quality);
		self.tax_dt_structure_quality						:= IF(score(L.src_structure_quality) > score(R.src_structure_quality), L.tax_dt_structure_quality, R.tax_dt_structure_quality);
		
		self.src_water 													:= IF(score(L.src_water) > score(R.src_water), L.src_water, R.src_water);
		self.water															:= IF(score(L.src_water) > score(R.src_water), L.water, R.water);
		self.tax_dt_water												:= IF(score(L.src_water) > score(R.src_water), L.tax_dt_water, R.tax_dt_water);
		
    self.src_sewer 	                    		:= IF(score(L.src_sewer) > score(R.src_sewer), L.src_sewer, R.src_sewer);
		self.sewer					                  	:= IF(score(L.src_sewer) > score(R.src_sewer), L.sewer, R.sewer);
		self.tax_dt_sewer												:= IF(score(L.src_sewer) > score(R.src_sewer), L.tax_dt_sewer, R.tax_dt_sewer);
		
		self.src_assessed_land_value 		      	:= IF(score(L.src_assessed_land_value) > score(R.src_assessed_land_value), L.src_assessed_land_value, R.src_assessed_land_value);
		self.assessed_land_value					    	:= IF(score(L.src_assessed_land_value) > score(R.src_assessed_land_value), L.assessed_land_value, R.assessed_land_value);
		self.tax_dt_assessed_land_value       	:= IF(score(L.src_assessed_land_value) > score(R.src_assessed_land_value), L.tax_dt_assessed_land_value, R.tax_dt_assessed_land_value);
		
		self.src_assessed_year 					      	:= IF(score(L.src_assessed_year) > score(R.src_assessed_year), L.src_assessed_year, R.src_assessed_year);
		self.assessed_year                    	:= IF(score(L.src_assessed_year) > score(R.src_assessed_year), L.assessed_year, R.assessed_year);
		self.tax_dt_assessed_year             	:= IF(score(L.src_assessed_year) > score(R.src_assessed_year), L.tax_dt_assessed_year, R.tax_dt_assessed_year);
		
		self.src_tax_amount 		              	:= IF(score(L.src_tax_amount) > score(R.src_tax_amount), L.src_tax_amount, R.src_tax_amount);
		self.tax_amount					              	:= IF(score(L.src_tax_amount) > score(R.src_tax_amount), L.tax_amount, R.tax_amount);
		self.tax_dt_tax_amount                	:= IF(score(L.src_tax_amount) > score(R.src_tax_amount), L.tax_dt_tax_amount, R.tax_dt_tax_amount);
		
		self.src_tax_year 		                	:= IF(score(L.src_tax_year) > score(R.src_tax_year), L.src_tax_year, R.src_tax_year);
		self.tax_year				                		:= IF(score(L.src_tax_year) > score(R.src_tax_year), L.tax_year, R.tax_year);
				
    self.src_market_land_value 		        	:= IF(score(L.src_market_land_value) > score(R.src_market_land_value), L.src_market_land_value, R.src_market_land_value);
		self.market_land_value					      	:= IF(score(L.src_market_land_value) > score(R.src_market_land_value), L.market_land_value, R.market_land_value);
		self.tax_dt_market_land_value         	:= IF(score(L.src_market_land_value) > score(R.src_market_land_value), L.tax_dt_market_land_value, R.tax_dt_market_land_value);
		
    self.src_improvement_value 		        	:= IF(score(L.src_improvement_value) > score(R.src_improvement_value), L.src_improvement_value, R.src_improvement_value);
		self.improvement_value					      	:= IF(score(L.src_improvement_value) > score(R.src_improvement_value), L.improvement_value, R.improvement_value);
		self.tax_dt_improvement_value         	:= IF(score(L.src_improvement_value) > score(R.src_improvement_value), L.tax_dt_improvement_value, R.tax_dt_improvement_value);
		
    self.src_percent_improved 		        	:= IF(score(L.src_percent_improved) > score(R.src_percent_improved), L.src_percent_improved, R.src_percent_improved);
		self.percent_improved					        	:= IF(score(L.src_percent_improved) > score(R.src_percent_improved), L.percent_improved, R.percent_improved);
		self.tax_dt_percent_improved          	:= IF(score(L.src_percent_improved) > score(R.src_percent_improved), L.tax_dt_percent_improved, R.tax_dt_percent_improved);
		
    self.src_total_assessed_value 		    	:= IF(score(L.src_total_assessed_value) > score(R.src_total_assessed_value), L.src_total_assessed_value, R.src_total_assessed_value);
		self.total_assessed_value					    	:= IF(score(L.src_total_assessed_value) > score(R.src_total_assessed_value), L.total_assessed_value, R.total_assessed_value);
		self.tax_dt_total_assessed_value      	:= IF(score(L.src_total_assessed_value) > score(R.src_total_assessed_value), L.tax_dt_total_assessed_value, R.tax_dt_total_assessed_value);
		
    self.src_total_calculated_value 		  	:= IF(score(L.src_total_calculated_value) > score(R.src_total_calculated_value), L.src_total_calculated_value, R.src_total_calculated_value);
		self.total_calculated_value					  	:= IF(score(L.src_total_calculated_value) > score(R.src_total_calculated_value), L.total_calculated_value, R.total_calculated_value);
		self.tax_dt_total_calculated_value    	:= IF(score(L.src_total_calculated_value) > score(R.src_total_calculated_value), L.tax_dt_total_calculated_value, R.tax_dt_total_calculated_value);
		
		self.src_total_land_value 		        	:= IF(score(L.src_total_land_value) > score(R.src_total_land_value), L.src_total_land_value, R.src_total_land_value);
		self.total_land_value					        	:= IF(score(L.src_total_land_value) > score(R.src_total_land_value), L.total_land_value, R.total_land_value);
		self.tax_dt_total_land_value          	:= IF(score(L.src_total_land_value) > score(R.src_total_land_value), L.tax_dt_total_land_value, R.tax_dt_total_land_value);
		
		self.src_total_market_value 		      	:= IF(score(L.src_total_market_value) > score(R.src_total_market_value), L.src_total_market_value, R.src_total_market_value);
		self.total_market_value					      	:= IF(score(L.src_total_market_value) > score(R.src_total_market_value), L.total_market_value, R.total_market_value);
		self.tax_dt_total_market_value        	:= IF(score(L.src_total_market_value) > score(R.src_total_market_value), L.tax_dt_total_market_value, R.tax_dt_total_market_value);
		
    self.src_floor_type 		              	:= IF(score(L.src_floor_type) > score(R.src_floor_type), L.src_floor_type, R.src_floor_type);
		self.floor_type					              	:= IF(score(L.src_floor_type) > score(R.src_floor_type), L.floor_type, R.floor_type);
		self.tax_dt_floor_type                	:= IF(score(L.src_floor_type) > score(R.src_floor_type), L.tax_dt_floor_type, R.tax_dt_floor_type);
		
    self.src_frame_type 		              	:= IF(score(L.src_frame_type) > score(R.src_frame_type), L.src_frame_type, R.src_frame_type);
		self.frame_type					              	:= IF(score(L.src_frame_type) > score(R.src_frame_type), L.frame_type, R.frame_type);
		self.tax_dt_frame_type                	:= IF(score(L.src_frame_type) > score(R.src_frame_type), L.tax_dt_frame_type, R.tax_dt_frame_type);
		
    self.src_fuel_type 	                		:= IF(score(L.src_fuel_type) > score(R.src_fuel_type), L.src_fuel_type, R.src_fuel_type);
		self.fuel_type					              	:= IF(score(L.src_fuel_type) > score(R.src_fuel_type), L.fuel_type, R.fuel_type);
		self.tax_dt_fuel_type                 	:= IF(score(L.src_fuel_type) > score(R.src_fuel_type), L.tax_dt_fuel_type, R.tax_dt_fuel_type);
		
    self.src_no_of_bath_fixtures 		      	:= IF(score(L.src_no_of_bath_fixtures) > score(R.src_no_of_bath_fixtures), L.src_no_of_bath_fixtures, R.src_no_of_bath_fixtures);
		self.no_of_bath_fixtures				    		:= IF(score(L.src_no_of_bath_fixtures) > score(R.src_no_of_bath_fixtures), L.no_of_bath_fixtures, R.no_of_bath_fixtures);
		self.tax_dt_no_of_bath_fixtures       	:= IF(score(L.src_no_of_bath_fixtures) > score(R.src_no_of_bath_fixtures), L.tax_dt_no_of_bath_fixtures, R.tax_dt_no_of_bath_fixtures);
		
		self.src_no_of_rooms 		              	:= IF(score(L.src_no_of_rooms) > score(R.src_no_of_rooms), L.src_no_of_rooms, R.src_no_of_rooms);
		self.no_of_rooms				            		:= IF(score(L.src_no_of_rooms) > score(R.src_no_of_rooms), L.no_of_rooms, R.no_of_rooms);
		self.tax_dt_no_of_rooms               	:= IF(score(L.src_no_of_rooms) > score(R.src_no_of_rooms), L.tax_dt_no_of_rooms, R.tax_dt_no_of_rooms);
		
		self.src_no_of_units 		              	:= IF(score(L.src_no_of_units) > score(R.src_no_of_units), L.src_no_of_units, R.src_no_of_units);
		self.no_of_units					            	:= IF(score(L.src_no_of_units) > score(R.src_no_of_units), L.no_of_units, R.no_of_units);
		self.tax_dt_no_of_units               	:= IF(score(L.src_no_of_units) > score(R.src_no_of_units), L.tax_dt_no_of_units, R.tax_dt_no_of_units);
		
    self.src_style_type 		              	:= IF(score(L.src_style_type) > score(R.src_style_type), L.src_style_type, R.src_style_type);
		self.style_type					              	:= IF(score(L.src_style_type) > score(R.src_style_type), L.style_type, R.style_type);
		self.tax_dt_style_type                	:= IF(score(L.src_style_type) > score(R.src_style_type), L.tax_dt_style_type, R.tax_dt_style_type);
		
    self.src_assessment_document_number 	 	:= IF(score(L.src_assessment_document_number) > score(R.src_assessment_document_number), L.src_assessment_document_number, R.src_assessment_document_number);
		self.assessment_document_number				 	:= IF(score(L.src_assessment_document_number) > score(R.src_assessment_document_number), L.assessment_document_number, R.assessment_document_number);
		self.tax_dt_assessment_document_number 	:= IF(score(L.src_assessment_document_number) > score(R.src_assessment_document_number), L.tax_dt_assessment_document_number, R.tax_dt_assessment_document_number);
		
    self.src_assessment_recording_date 		 	:= IF(score(L.src_assessment_recording_date) > score(R.src_assessment_recording_date), L.src_assessment_recording_date, R.src_assessment_recording_date);
		self.assessment_recording_date				 	:= IF(score(L.src_assessment_recording_date) > score(R.src_assessment_recording_date), L.assessment_recording_date, R.assessment_recording_date);
		self.tax_dt_assessment_recording_date  	:= IF(score(L.src_assessment_recording_date) > score(R.src_assessment_recording_date), L.tax_dt_assessment_recording_date, R.tax_dt_assessment_recording_date);
		
    self.src_deed_document_number 	       	:= IF(score(L.src_deed_document_number) > score(R.src_deed_document_number), L.src_deed_document_number, R.src_deed_document_number);
		self.deed_document_number				       	:= IF(score(L.src_deed_document_number) > score(R.src_deed_document_number), L.deed_document_number, R.deed_document_number);
		self.rec_dt_deed_document_number       	:= IF(score(L.src_deed_document_number) > score(R.src_deed_document_number), L.rec_dt_deed_document_number, R.rec_dt_deed_document_number);
		
		self.src_deed_recording_date 		       	:= IF(score(L.src_deed_recording_date) > score(R.src_deed_recording_date), L.src_deed_recording_date, R.src_deed_recording_date);
		self.deed_recording_date				       	:= IF(score(L.src_deed_recording_date) > score(R.src_deed_recording_date), L.deed_recording_date, R.deed_recording_date);
		
		self.src_full_part_sale 		           	:= IF(score(L.src_full_part_sale) > score(R.src_full_part_sale), L.src_full_part_sale, R.src_full_part_sale);
		self.full_part_sale					           	:= IF(score(L.src_full_part_sale) > score(R.src_full_part_sale), L.full_part_sale, R.full_part_sale);
		self.rec_dt_full_part_sale             	:= IF(score(L.src_full_part_sale) > score(R.src_full_part_sale), L.rec_dt_full_part_sale, R.rec_dt_full_part_sale);
		
    self.src_sale_amount 		               	:= IF(score(L.src_sale_amount) > score(R.src_sale_amount), L.src_sale_amount, R.src_sale_amount);
		self.sale_amount					             	:= IF(score(L.src_sale_amount) > score(R.src_sale_amount), L.sale_amount, R.sale_amount);
		self.rec_dt_sale_amount                	:= IF(score(L.src_sale_amount) > score(R.src_sale_amount), L.rec_dt_sale_amount, R.rec_dt_sale_amount);
		
		self.src_sale_date 		                 	:= IF(score(L.src_sale_date) > score(R.src_sale_date), L.src_sale_date, R.src_sale_date);
		self.sale_date					               	:= IF(score(L.src_sale_date) > score(R.src_sale_date), L.sale_date, R.sale_date);
		self.rec_dt_sale_date                  	:= IF(score(L.src_sale_date) > score(R.src_sale_date), L.rec_dt_sale_date, R.rec_dt_sale_date);
		
		self.src_sale_type_code 		           	:= IF(score(L.src_sale_type_code) > score(R.src_sale_type_code), L.src_sale_type_code, R.src_sale_type_code);
		self.sale_type_code					           	:= IF(score(L.src_sale_type_code) > score(R.src_sale_type_code), L.sale_type_code, R.sale_type_code);
		self.rec_dt_sale_type_code             	:= IF(score(L.src_sale_type_code) > score(R.src_sale_type_code), L.rec_dt_sale_type_code, R.rec_dt_sale_type_code);
		
    self.src_mortgage_company_name 		     	:= IF(score(L.src_mortgage_company_name) > score(R.src_mortgage_company_name), L.src_mortgage_company_name, R.src_mortgage_company_name);
		self.mortgage_company_name					   	:= IF(score(L.src_mortgage_company_name) > score(R.src_mortgage_company_name), L.mortgage_company_name, R.mortgage_company_name);
		self.rec_dt_mortgage_company_name      	:= IF(score(L.src_mortgage_company_name) > score(R.src_mortgage_company_name), L.rec_dt_mortgage_company_name, R.rec_dt_mortgage_company_name);
		
    self.src_loan_amount 		               	:= IF(score(L.src_loan_amount) > score(R.src_loan_amount), L.src_loan_amount, R.src_loan_amount);
		self.loan_amount					             	:= IF(score(L.src_loan_amount) > score(R.src_loan_amount), L.loan_amount, R.loan_amount);
		self.rec_dt_loan_amount                	:= IF(score(L.src_loan_amount) > score(R.src_loan_amount), L.rec_dt_loan_amount, R.rec_dt_loan_amount);
		
		self.src_second_loan_amount 		       	:= IF(score(L.src_second_loan_amount) > score(R.src_second_loan_amount), L.src_second_loan_amount, R.src_second_loan_amount);
		self.second_loan_amount					       	:= IF(score(L.src_second_loan_amount) > score(R.src_second_loan_amount), L.second_loan_amount, R.second_loan_amount);
		self.rec_dt_second_loan_amount         	:= IF(score(L.src_second_loan_amount) > score(R.src_second_loan_amount), L.rec_dt_second_loan_amount, R.rec_dt_second_loan_amount);
		
		self.src_loan_type_code 		           	:= IF(score(L.src_loan_type_code) > score(R.src_loan_type_code), L.src_loan_type_code, R.src_loan_type_code);
		self.loan_type_code					           	:= IF(score(L.src_loan_type_code) > score(R.src_loan_type_code), L.loan_type_code, R.loan_type_code);
		self.rec_dt_loan_type_code             	:= IF(score(L.src_loan_type_code) > score(R.src_loan_type_code), L.rec_dt_loan_type_code, R.rec_dt_loan_type_code);
		
		self.src_interest_rate_type_code 		   	:= IF(score(L.src_interest_rate_type_code) > score(R.src_interest_rate_type_code), L.src_interest_rate_type_code, R.src_interest_rate_type_code);
		self.interest_rate_type_code					 	:= IF(score(L.src_interest_rate_type_code) > score(R.src_interest_rate_type_code), L.interest_rate_type_code, R.interest_rate_type_code);
		self.rec_dt_interest_rate_type_code    	:= IF(score(L.src_interest_rate_type_code) > score(R.src_interest_rate_type_code), L.rec_dt_interest_rate_type_code, R.rec_dt_interest_rate_type_code);
				
		self := L;
	END;	
	
	EXPORT PropertyCharacteristics_Services.Layouts.inhouse_layout DPOJOin(PropertyCharacteristics_Services.Layouts.inhouse_layout L, PropertyCharacteristics_Services.Layouts.inhouse_layout R) := TRANSFORM
		self.src_building_square_footage 			:= IF(L.src_building_square_footage = Constants.MSL_Src, L.src_building_square_footage, R.src_building_square_footage);
		self.building_square_footage					:= IF(L.src_building_square_footage = Constants.MSL_Src, L.building_square_footage, R.building_square_footage);
		self.tax_dt_building_square_footage		:= IF(L.src_building_square_footage = Constants.MSL_Src, L.tax_dt_building_square_footage, R.tax_dt_building_square_footage);
		
		self.src_air_conditioning_type 				:= IF(L.src_air_conditioning_type = Constants.MSL_Src, L.src_air_conditioning_type, R.src_air_conditioning_type);
		self.air_conditioning_type						:= IF(L.src_air_conditioning_type = Constants.MSL_Src, L.air_conditioning_type, R.air_conditioning_type);
		self.tax_dt_air_conditioning_type			:= IF(L.src_air_conditioning_type = Constants.MSL_Src, L.tax_dt_air_conditioning_type, R.tax_dt_air_conditioning_type);
		
		self.src_basement_finish 							:= IF(L.src_basement_finish = Constants.MSL_Src, L.src_basement_finish, R.src_basement_finish);
		self.basement_finish									:= IF(L.src_basement_finish = Constants.MSL_Src, L.basement_finish, R.basement_finish);
		self.tax_dt_basement_finish						:= IF(L.src_basement_finish = Constants.MSL_Src, L.tax_dt_basement_finish, R.tax_dt_basement_finish);
		
		self.src_construction_type 						:= IF(L.src_construction_type = Constants.MSL_Src, L.src_construction_type, R.src_construction_type);
		self.construction_type								:= IF(L.src_construction_type = Constants.MSL_Src, L.construction_type, R.construction_type);
		self.tax_dt_construction_type					:= IF(L.src_construction_type = Constants.MSL_Src, L.tax_dt_construction_type, R.tax_dt_construction_type);
		
		self.src_exterior_wall 								:= IF(L.src_exterior_wall = Constants.MSL_Src, L.src_exterior_wall, R.src_exterior_wall);
		self.exterior_wall										:= IF(L.src_exterior_wall = Constants.MSL_Src, L.exterior_wall, R.exterior_wall);
		self.tax_dt_exterior_wall							:= IF(L.src_exterior_wall = Constants.MSL_Src, L.tax_dt_exterior_wall, R.tax_dt_exterior_wall);
		
		self.src_fireplace_ind 								:= IF(L.src_fireplace_ind = Constants.MSL_Src, L.src_fireplace_ind, R.src_fireplace_ind);
		self.fireplace_ind										:= IF(L.src_fireplace_ind = Constants.MSL_Src, L.fireplace_ind, R.fireplace_ind);
		self.tax_dt_fireplace_ind							:= IF(L.src_fireplace_ind = Constants.MSL_Src, L.tax_dt_fireplace_ind, L.tax_dt_fireplace_ind);
		
		self.src_fireplace_type 							:= IF(L.src_fireplace_type = Constants.MSL_Src, L.src_fireplace_type, R.src_fireplace_type);
		self.fireplace_type										:= IF(L.src_fireplace_type = Constants.MSL_Src, L.fireplace_type, R.fireplace_type);
		self.tax_dt_fireplace_type						:= IF(L.src_fireplace_type = Constants.MSL_Src, L.tax_dt_fireplace_type, R.tax_dt_fireplace_type);
		
		self.src_flood_zone_panel 						:= IF(L.src_flood_zone_panel = Constants.MSL_Src, L.src_flood_zone_panel, R.src_flood_zone_panel);
		self.flood_zone_panel									:= IF(L.src_flood_zone_panel = Constants.MSL_Src, L.flood_zone_panel, R.flood_zone_panel);
		self.tax_dt_flood_zone_panel					:= IF(L.src_flood_zone_panel = Constants.MSL_Src, L.tax_dt_flood_zone_panel, R.tax_dt_flood_zone_panel);
		
		self.src_garage 											:= IF(L.src_garage = Constants.MSL_Src, L.src_garage, R.src_garage);
		self.garage														:= IF(L.src_garage = Constants.MSL_Src, L.garage, R.garage);
		self.tax_dt_garage										:= IF(L.src_garage = Constants.MSL_Src, L.tax_dt_garage, R.tax_dt_garage);

		self.src_first_floor_square_footage 		:= IF(L.src_first_floor_square_footage = Constants.MSL_Src, L.src_first_floor_square_footage, R.src_first_floor_square_footage);
		self.first_floor_square_footage					:= IF(L.src_first_floor_square_footage = Constants.MSL_Src, L.first_floor_square_footage, R.first_floor_square_footage);
		self.tax_dt_first_floor_square_footage	:= IF(L.src_first_floor_square_footage = Constants.MSL_Src, L.tax_dt_first_floor_square_footage, R.tax_dt_first_floor_square_footage);
		
		self.src_heating 											:= IF(L.src_heating = Constants.MSL_Src, L.src_heating, R.src_heating);
		self.heating													:= IF(L.src_heating = Constants.MSL_Src, L.heating, R.heating);
		self.tax_dt_heating										:= IF(L.src_heating = Constants.MSL_Src, L.tax_dt_heating, R.tax_dt_heating);
		
		self.src_living_area_square_footage 		:= IF(L.src_living_area_square_footage = Constants.MSL_Src, L.src_living_area_square_footage, R.src_living_area_square_footage);
		self.living_area_square_footage					:= IF(L.src_living_area_square_footage = Constants.MSL_Src, L.living_area_square_footage, R.living_area_square_footage);
		self.tax_dt_living_area_square_footage	:= IF(L.src_living_area_square_footage = Constants.MSL_Src, L.tax_dt_living_area_square_footage, R.tax_dt_living_area_square_footage);
		
		self.src_no_of_baths 									:= IF(L.src_no_of_baths = Constants.MSL_Src, L.src_no_of_baths, R.src_no_of_baths);
		self.no_of_baths											:= IF(L.src_no_of_baths = Constants.MSL_Src, L.no_of_baths, R.no_of_baths);
		self.tax_dt_no_of_baths								:= IF(L.src_no_of_baths = Constants.MSL_Src, L.tax_dt_no_of_baths, R.tax_dt_no_of_baths);
		
		self.src_no_of_bedrooms 							:= IF(L.src_no_of_bedrooms = Constants.MSL_Src, L.src_no_of_bedrooms, R.src_no_of_bedrooms);
		self.no_of_bedrooms										:= IF(L.src_no_of_bedrooms = Constants.MSL_Src, L.no_of_bedrooms, R.no_of_bedrooms);
		self.tax_dt_no_of_bedrooms						:= IF(L.src_no_of_bedrooms = Constants.MSL_Src, L.tax_dt_no_of_bedrooms, R.tax_dt_no_of_bedrooms);
		
		self.src_no_of_fireplaces 						:= IF(L.src_no_of_fireplaces = Constants.MSL_Src, L.src_no_of_fireplaces, R.src_no_of_fireplaces);
		self.no_of_fireplaces									:= IF(L.src_no_of_fireplaces = Constants.MSL_Src, L.no_of_fireplaces, R.no_of_fireplaces);
		self.tax_dt_no_of_fireplaces					:= IF(L.src_no_of_fireplaces = Constants.MSL_Src, L.tax_dt_no_of_fireplaces, R.tax_dt_no_of_fireplaces);
		
		self.src_no_of_full_baths 						:= IF(L.src_no_of_full_baths = Constants.MSL_Src, L.src_no_of_full_baths, R.src_no_of_full_baths);
		self.no_of_full_baths									:= IF(L.src_no_of_full_baths = Constants.MSL_Src, L.no_of_full_baths, R.no_of_full_baths);
		self.tax_dt_no_of_full_baths					:= IF(L.src_no_of_full_baths = Constants.MSL_Src, L.tax_dt_no_of_full_baths, R.tax_dt_no_of_full_baths);
		
		self.src_no_of_half_baths 						:= IF(L.src_no_of_half_baths = Constants.MSL_Src, L.src_no_of_half_baths, R.src_no_of_half_baths);
		self.no_of_half_baths									:= IF(L.src_no_of_half_baths = Constants.MSL_Src, L.no_of_half_baths, R.no_of_half_baths);
		self.tax_dt_no_of_half_baths					:= IF(L.src_no_of_half_baths = Constants.MSL_Src, L.tax_dt_no_of_half_baths, R.tax_dt_no_of_half_baths);
		
		self.src_no_of_stories 								:= IF(L.src_no_of_stories = Constants.MSL_Src, L.src_no_of_stories, R.src_no_of_stories);
		self.no_of_stories										:= IF(L.src_no_of_stories = Constants.MSL_Src, L.no_of_stories, R.no_of_stories);
		self.tax_dt_no_of_stories							:= IF(L.src_no_of_stories = Constants.MSL_Src, L.tax_dt_no_of_stories, R.tax_dt_no_of_stories);
		
		self.src_parking_type 								:= IF(L.src_parking_type = Constants.MSL_Src, L.src_parking_type, R.src_parking_type);
		self.parking_type											:= IF(L.src_parking_type = Constants.MSL_Src, L.parking_type, R.parking_type);
		self.tax_dt_parking_type							:= IF(L.src_parking_type = Constants.MSL_Src, L.tax_dt_parking_type, R.tax_dt_parking_type);
		
		self.src_pool_indicator 							:= IF(L.src_pool_indicator = Constants.MSL_Src, L.src_pool_indicator, R.src_pool_indicator);
		self.pool_indicator										:= IF(L.src_pool_indicator = Constants.MSL_Src, L.pool_indicator, R.pool_indicator);
		self.tax_dt_pool_indicator						:= IF(L.src_pool_indicator = Constants.MSL_Src, L.tax_dt_pool_indicator, R.tax_dt_pool_indicator);
		
		self.src_pool_type 										:= IF(L.src_pool_type = Constants.MSL_Src, L.src_pool_type, R.src_pool_type);
		self.pool_type												:= IF(L.src_pool_type = Constants.MSL_Src, L.pool_type, R.pool_type);
		self.tax_dt_pool_type									:= IF(L.src_pool_type = Constants.MSL_Src, L.tax_dt_pool_type, R.tax_dt_pool_type);
		
		self.src_roof_cover 									:= IF(L.src_roof_cover = Constants.MSL_Src, L.src_roof_cover, R.src_roof_cover);
		self.roof_cover												:= IF(L.src_roof_cover = Constants.MSL_Src, L.roof_cover, R.roof_cover);
		self.tax_dt_roof_cover								:= IF(L.src_roof_cover = Constants.MSL_Src, L.tax_dt_roof_cover, R.tax_dt_roof_cover);
		
		self.src_year_built 									:= IF(L.src_year_built = Constants.MSL_Src, L.src_year_built, R.src_year_built);
		self.year_built												:= IF(L.src_year_built = Constants.MSL_Src, L.year_built, R.year_built);
		self.tax_dt_year_built								:= IF(L.src_year_built = Constants.MSL_Src, L.tax_dt_year_built, R.tax_dt_year_built);
		
		self.src_foundation 									:= IF(L.src_foundation = Constants.MSL_Src, L.src_foundation, R.src_foundation);
		self.foundation												:= IF(L.src_foundation = Constants.MSL_Src, L.foundation, R.foundation);
		self.tax_dt_foundation								:= IF(L.src_foundation = Constants.MSL_Src, L.tax_dt_foundation, R.tax_dt_foundation);
		
		self.src_basement_square_footage 			:= IF(L.src_basement_square_footage = Constants.MSL_Src, L.src_basement_square_footage, R.src_basement_square_footage);
		self.basement_square_footage					:= IF(L.src_basement_square_footage = Constants.MSL_Src, L.basement_square_footage, R.basement_square_footage);
		self.tax_dt_basement_square_footage		:= IF(L.src_basement_square_footage = Constants.MSL_Src, L.tax_dt_basement_square_footage, R.tax_dt_basement_square_footage);
		
		self.src_effective_year_built 				:= IF(L.src_effective_year_built = Constants.MSL_Src, L.src_effective_year_built, R.src_effective_year_built);
		self.effective_year_built							:= IF(L.src_effective_year_built = Constants.MSL_Src, L.effective_year_built, R.effective_year_built);
		self.tax_dt_effective_year_built			:= IF(L.src_effective_year_built = Constants.MSL_Src, L.tax_dt_effective_year_built, R.tax_dt_effective_year_built);
		
		self.src_garage_square_footage 				:= IF(L.src_garage_square_footage = Constants.MSL_Src, L.src_garage_square_footage, R.src_garage_square_footage);
		self.garage_square_footage						:= IF(L.src_garage_square_footage = Constants.MSL_Src, L.garage_square_footage, R.garage_square_footage);
		self.tax_dt_garage_square_footage			:= IF(L.src_garage_square_footage = Constants.MSL_Src, L.tax_dt_garage_square_footage, R.tax_dt_garage_square_footage);
		
		self.src_stories_type 								:= IF(L.src_stories_type = Constants.MSL_Src, L.src_stories_type, R.src_stories_type);
		self.stories_type											:= IF(L.src_stories_type = Constants.MSL_Src, L.stories_type, R.stories_type);
		self.tax_dt_stories_type							:= IF(L.src_stories_type = Constants.MSL_Src, L.tax_dt_stories_type, R.tax_dt_stories_type);
		
		self.src_apn_number 									:= IF(L.src_apn_number = Constants.MSL_Src, L.src_apn_number, R.src_apn_number);
		self.apn_number												:= IF(L.src_apn_number = Constants.MSL_Src, L.apn_number, R.apn_number);
		self.tax_dt_apn_number								:= IF(L.src_apn_number = Constants.MSL_Src, L.tax_dt_apn_number, R.tax_dt_apn_number);
		
		self.src_census_tract 								:= IF(L.src_census_tract = Constants.MSL_Src, L.src_census_tract, R.src_census_tract);
		self.census_tract											:= IF(L.src_census_tract = Constants.MSL_Src, L.census_tract, R.census_tract);
		self.tax_dt_census_tract							:= IF(L.src_census_tract = Constants.MSL_Src, L.tax_dt_census_tract, R.tax_dt_census_tract);
		
		self.src_range 												:= IF(L.src_range = Constants.MSL_Src, L.src_range, R.src_range);
		self.range														:= IF(L.src_range = Constants.MSL_Src, L.range, R.range);
		self.tax_dt_range											:= IF(L.src_range = Constants.MSL_Src, L.tax_dt_range, R.tax_dt_range);
		
		self.src_zoning 											:= IF(L.src_zoning = Constants.MSL_Src, L.src_zoning, R.src_zoning);
		self.zoning														:= IF(L.src_zoning = Constants.MSL_Src, L.zoning, R.zoning);
		self.tax_dt_zoning										:= IF(L.src_zoning = Constants.MSL_Src, L.tax_dt_zoning, R.tax_dt_zoning);
		
		self.src_block_number 								:= IF(L.src_block_number = Constants.MSL_Src, L.src_block_number, R.src_block_number);
		self.block_number											:= IF(L.src_block_number = Constants.MSL_Src, L.block_number, R.block_number);
		self.tax_dt_block_number							:= IF(L.src_block_number = Constants.MSL_Src, L.tax_dt_block_number, R.tax_dt_block_number);
		
		self.src_county_name 									:= IF(L.src_county_name = Constants.MSL_Src, L.src_county_name, R.src_county_name);
		self.county_name											:= IF(L.src_county_name = Constants.MSL_Src, L.county_name, R.county_name);
		self.tax_dt_county_name								:= IF(L.src_county_name = Constants.MSL_Src, L.tax_dt_county_name, R.tax_dt_county_name);
		
		self.src_fips_code 										:= IF(L.src_fips_code = Constants.MSL_Src, L.src_fips_code, R.src_fips_code);
		self.fips_code												:= IF(L.src_fips_code = Constants.MSL_Src, L.fips_code, R.fips_code);
		self.tax_dt_fips_code									:= IF(L.src_fips_code = Constants.MSL_Src, L.tax_dt_fips_code, R.tax_dt_fips_code);
		
		self.src_subdivision 									:= IF(L.src_subdivision = Constants.MSL_Src, L.src_subdivision, R.src_subdivision);
		self.subdivision											:= IF(L.src_subdivision = Constants.MSL_Src, L.subdivision, R.subdivision);
		self.tax_dt_subdivision								:= IF(L.src_subdivision = Constants.MSL_Src, L.tax_dt_subdivision, R.tax_dt_subdivision);
		
		self.src_municipality 								:= IF(L.src_municipality = Constants.MSL_Src, L.src_municipality, R.src_municipality);
		self.municipality											:= IF(L.src_municipality = Constants.MSL_Src, L.municipality, R.municipality);
		self.tax_dt_municipality							:= IF(L.src_municipality = Constants.MSL_Src, L.tax_dt_municipality, R.tax_dt_municipality);
		
		self.src_township 										:= IF(L.src_township = Constants.MSL_Src, L.src_township, R.src_township);
		self.township													:= IF(L.src_township = Constants.MSL_Src, L.township, R.township);
		self.tax_dt_township									:= IF(L.src_township = Constants.MSL_Src, L.tax_dt_township, R.tax_dt_township);
		
		self.src_homestead_exemption_ind 			:= IF(L.src_homestead_exemption_ind = Constants.MSL_Src, L.src_homestead_exemption_ind, R.src_homestead_exemption_ind);
		self.homestead_exemption_ind					:= IF(L.src_homestead_exemption_ind = Constants.MSL_Src, L.homestead_exemption_ind, R.homestead_exemption_ind);
		self.tax_dt_homestead_exemption_ind		:= IF(L.src_homestead_exemption_ind = Constants.MSL_Src, L.tax_dt_homestead_exemption_ind, R.tax_dt_homestead_exemption_ind);
		
		self.src_land_use_code 								:= IF(L.src_land_use_code = Constants.MSL_Src, L.src_land_use_code, R.src_land_use_code);
		self.land_use_code										:= IF(L.src_land_use_code = Constants.MSL_Src, L.land_use_code, R.land_use_code);
		self.tax_dt_land_use_code							:= IF(L.src_land_use_code = Constants.MSL_Src, L.tax_dt_land_use_code, R.tax_dt_land_use_code);
		
		self.src_latitude 										:= IF(L.src_latitude = Constants.MSL_Src, L.src_latitude, R.src_latitude);
		self.latitude													:= IF(L.src_latitude = Constants.MSL_Src, L.latitude, R.latitude);
		self.tax_dt_latitude									:= IF(L.src_latitude = Constants.MSL_Src, L.tax_dt_latitude, R.tax_dt_latitude);
		
		self.src_longitude 										:= IF(L.src_longitude = Constants.MSL_Src, L.src_longitude, R.src_longitude);
		self.longitude												:= IF(L.src_longitude = Constants.MSL_Src, L.longitude, R.longitude);
		self.tax_dt_longitude									:= IF(L.src_longitude = Constants.MSL_Src, L.tax_dt_longitude, R.tax_dt_longitude);
		
		self.src_location_influence_code 			:= IF(L.src_location_influence_code = Constants.MSL_Src, L.src_location_influence_code, R.src_location_influence_code);
		self.location_influence_code					:= IF(L.src_location_influence_code = Constants.MSL_Src, L.location_influence_code, R.location_influence_code);
		self.tax_dt_location_influence_code		:= IF(L.src_location_influence_code = Constants.MSL_Src, L.tax_dt_location_influence_code, R.tax_dt_location_influence_code);
		
		self.src_acres 												:= IF(L.src_acres = Constants.MSL_Src, L.src_acres, R.src_acres);
		self.acres														:= IF(L.src_acres = Constants.MSL_Src, L.acres, R.acres);
		self.tax_dt_acres											:= IF(L.src_acres = Constants.MSL_Src, L.tax_dt_acres, R.tax_dt_acres);
		
		self.src_lot_depth_footage 						:= IF(L.src_lot_depth_footage = Constants.MSL_Src, L.src_lot_depth_footage, R.src_lot_depth_footage);
		self.lot_depth_footage								:= IF(L.src_lot_depth_footage = Constants.MSL_Src, L.lot_depth_footage, R.lot_depth_footage);
		self.tax_dt_lot_depth_footage					:= IF(L.src_lot_depth_footage = Constants.MSL_Src, L.tax_dt_lot_depth_footage, R.tax_dt_lot_depth_footage);
		
		self.src_lot_front_footage 						:= IF(L.src_lot_front_footage = Constants.MSL_Src, L.src_lot_front_footage, R.src_lot_front_footage);
		self.lot_front_footage								:= IF(L.src_lot_front_footage = Constants.MSL_Src, L.lot_front_footage, R.lot_front_footage);
		self.tax_dt_lot_front_footage					:= IF(L.src_lot_front_footage = Constants.MSL_Src, L.tax_dt_lot_front_footage, R.tax_dt_lot_front_footage);
		
		self.src_lot_number 									:= IF(L.src_lot_number = Constants.MSL_Src, L.src_lot_number, R.src_lot_number);
		self.lot_number												:= IF(L.src_lot_number = Constants.MSL_Src, L.lot_number, R.lot_number);
		self.tax_dt_lot_number								:= IF(L.src_lot_number = Constants.MSL_Src, L.tax_dt_lot_number, R.tax_dt_lot_number);
		
		self.src_lot_size 										:= IF(L.src_lot_size = Constants.MSL_Src, L.src_lot_size, R.src_lot_size);
		self.lot_size													:= IF(L.src_lot_size = Constants.MSL_Src, L.lot_size, R.lot_size);
		self.tax_dt_lot_size									:= IF(L.src_lot_size = Constants.MSL_Src, L.tax_dt_lot_size, R.tax_dt_lot_size);
		
		self.src_property_type_code 					:= IF(L.src_property_type_code = Constants.MSL_Src, L.src_property_type_code, R.src_property_type_code);
		self.property_type_code								:= IF(L.src_property_type_code = Constants.MSL_Src, L.property_type_code, R.property_type_code);
		self.tax_dt_property_type_code				:= IF(L.src_property_type_code = Constants.MSL_Src, L.tax_dt_property_type_code, R.tax_dt_property_type_code);
		
		self.src_structure_quality 						:= IF(L.src_structure_quality = Constants.MSL_Src, L.src_structure_quality, R.src_structure_quality);
		self.structure_quality								:= IF(L.src_structure_quality = Constants.MSL_Src, L.structure_quality, R.structure_quality);
		self.tax_dt_structure_quality					:= IF(L.src_structure_quality = Constants.MSL_Src, L.tax_dt_structure_quality, R.tax_dt_structure_quality);
		
		self.src_water 												:= IF(L.src_water = Constants.MSL_Src, L.src_water, R.src_water);
		self.water														:= IF(L.src_water = Constants.MSL_Src, L.water, R.water);
		self.tax_dt_water											:= IF(L.src_water = Constants.MSL_Src, L.tax_dt_water, R.tax_dt_water);
		
    self.src_sewer 	                    	:= IF(L.src_sewer = Constants.MSL_Src, L.src_sewer, R.src_sewer);		
		self.sewer					                  := IF(L.src_sewer = Constants.MSL_Src, L.sewer, R.sewer);
		self.tax_dt_sewer											:= IF(L.src_sewer = Constants.MSL_Src, L.tax_dt_sewer, R.tax_dt_sewer);
		
		self.src_assessed_land_value 		      := IF(L.src_assessed_land_value = Constants.MSL_Src, L.src_assessed_land_value, R.src_assessed_land_value);
		self.assessed_land_value					    := IF(L.src_assessed_land_value = Constants.MSL_Src, L.assessed_land_value, R.assessed_land_value);
		self.tax_dt_assessed_land_value       := IF(L.src_assessed_land_value = Constants.MSL_Src, L.tax_dt_assessed_land_value, R.tax_dt_assessed_land_value);
		
		self.src_assessed_year 					      := IF(L.src_assessed_year = Constants.MSL_Src, L.src_assessed_year, R.src_assessed_year);
		self.assessed_year                    := IF(L.src_assessed_year = Constants.MSL_Src, L.assessed_year, R.assessed_year);
		self.tax_dt_assessed_year             := IF(L.src_assessed_year = Constants.MSL_Src, L.tax_dt_assessed_year, R.tax_dt_assessed_year);
		
		self.src_tax_amount 		              := IF(L.src_tax_amount = Constants.MSL_Src, L.src_tax_amount, R.src_tax_amount);
		self.tax_amount					              := IF(L.src_tax_amount = Constants.MSL_Src, L.tax_amount, R.tax_amount);
		self.tax_dt_tax_amount                := IF(L.src_tax_amount = Constants.MSL_Src, L.tax_dt_tax_amount, R.tax_dt_tax_amount); 
		
		self.src_tax_year 		                := IF(L.src_tax_year = Constants.MSL_Src, L.src_tax_year, R.src_tax_year);
		self.tax_year				                	:= IF(L.src_tax_year = Constants.MSL_Src, L.tax_year, R.tax_year);
				
    self.src_market_land_value 		        := IF(L.src_market_land_value = Constants.MSL_Src, L.src_market_land_value, R.src_market_land_value);		
		self.market_land_value					      := IF(L.src_market_land_value = Constants.MSL_Src, L.market_land_value, R.market_land_value);
		self.tax_dt_market_land_value         := IF(L.src_market_land_value = Constants.MSL_Src, L.tax_dt_market_land_value, R.tax_dt_market_land_value); 
		
    self.src_improvement_value 		        := IF(L.src_improvement_value = Constants.MSL_Src, L.src_improvement_value, R.src_improvement_value);		
		self.improvement_value					      := IF(L.src_improvement_value = Constants.MSL_Src, L.improvement_value, R.improvement_value);
		self.tax_dt_improvement_value         := IF(L.src_improvement_value = Constants.MSL_Src, L.tax_dt_improvement_value, R.tax_dt_improvement_value);
		
    self.src_percent_improved 		        := IF(L.src_percent_improved  = Constants.MSL_Src, L.src_percent_improved, R.src_percent_improved);		
		self.percent_improved					        := IF(L.src_percent_improved  = Constants.MSL_Src, L.percent_improved, R.percent_improved);
		self.tax_dt_percent_improved          := IF(L.src_percent_improved  = Constants.MSL_Src, L.tax_dt_improvement_value, R.tax_dt_improvement_value);
		
    self.src_total_assessed_value 		    := IF(L.src_total_assessed_value = Constants.MSL_Src, L.src_total_assessed_value, R.src_total_assessed_value);		
		self.total_assessed_value					    := IF(L.src_total_assessed_value = Constants.MSL_Src, L.total_assessed_value, R.total_assessed_value);
		self.tax_dt_total_assessed_value      := IF(L.src_total_assessed_value = Constants.MSL_Src, L.tax_dt_total_assessed_value, R.tax_dt_total_assessed_value);
		
    self.src_total_calculated_value 		  := IF(L.src_total_calculated_value = Constants.MSL_Src, L.src_total_calculated_value, R.src_total_calculated_value);		
		self.total_calculated_value					  := IF(L.src_total_calculated_value = Constants.MSL_Src, L.total_calculated_value, R.total_calculated_value);
		self.tax_dt_total_calculated_value    := IF(L.src_total_calculated_value = Constants.MSL_Src, L.tax_dt_total_calculated_value, R.tax_dt_total_calculated_value);
		
		self.src_total_land_value 		        := IF(L.src_total_land_value = Constants.MSL_Src, L.src_total_land_value, R.src_total_land_value);
		self.total_land_value					        := IF(L.src_total_land_value = Constants.MSL_Src, L.total_land_value, R.total_land_value);
		self.tax_dt_total_land_value          := IF(L.src_total_land_value = Constants.MSL_Src, L.tax_dt_total_land_value, R.tax_dt_total_land_value);
		
		self.src_total_market_value 		      := IF(L.src_total_market_value = Constants.MSL_Src, L.src_total_market_value, R.src_total_market_value);
		self.total_market_value					      := IF(L.src_total_market_value = Constants.MSL_Src, L.total_market_value, R.total_market_value);
		self.tax_dt_total_market_value        := IF(L.src_total_market_value = Constants.MSL_Src, L.tax_dt_total_market_value, R.tax_dt_total_market_value);
		
    self.src_floor_type 		              := IF(L.src_floor_type = Constants.MSL_Src, L.src_floor_type, R.src_floor_type);		
		self.floor_type					              := IF(L.src_floor_type = Constants.MSL_Src, L.floor_type, R.floor_type);
		self.tax_dt_floor_type                := IF(L.src_floor_type = Constants.MSL_Src, L.tax_dt_floor_type, R.tax_dt_floor_type);
		
    self.src_frame_type 		              := IF(L.src_frame_type = Constants.MSL_Src, L.src_frame_type, R.src_frame_type);		
		self.frame_type					              := IF(L.src_frame_type = Constants.MSL_Src, L.frame_type, R.frame_type);
		self.tax_dt_frame_type                := IF(L.src_frame_type = Constants.MSL_Src, L.tax_dt_frame_type, R.tax_dt_frame_type);
		
    self.src_fuel_type 	                	:= IF(L.src_fuel_type = Constants.MSL_Src, L.src_fuel_type, R.src_fuel_type);		
		self.fuel_type					              := IF(L.src_fuel_type = Constants.MSL_Src, L.fuel_type, R.fuel_type);
		self.tax_dt_fuel_type                 := IF(L.src_fuel_type = Constants.MSL_Src, L.tax_dt_fuel_type, R.tax_dt_fuel_type);
		
    self.src_no_of_bath_fixtures 		      := IF(L.src_no_of_bath_fixtures = Constants.MSL_Src, L.src_no_of_bath_fixtures, R.src_no_of_bath_fixtures);		
		self.no_of_bath_fixtures				    	:= IF(L.src_no_of_bath_fixtures = Constants.MSL_Src, L.no_of_bath_fixtures, R.no_of_bath_fixtures);
		self.tax_dt_no_of_bath_fixtures       := IF(L.src_no_of_bath_fixtures = Constants.MSL_Src, L.tax_dt_no_of_bath_fixtures, R.tax_dt_no_of_bath_fixtures);
		
		self.src_no_of_rooms 		              := IF(L.src_no_of_rooms = Constants.MSL_Src, L.src_no_of_rooms, R.src_no_of_rooms);
		self.no_of_rooms				            	:= IF(L.src_no_of_rooms = Constants.MSL_Src, L.no_of_rooms, R.no_of_rooms);
		self.tax_dt_no_of_rooms               := IF(L.src_no_of_rooms = Constants.MSL_Src, L.tax_dt_no_of_rooms, R.tax_dt_no_of_rooms);
		
		self.src_no_of_units 		              := IF(L.src_no_of_units = Constants.MSL_Src, L.src_no_of_units, R.src_no_of_units);
		self.no_of_units					            := IF(L.src_no_of_units = Constants.MSL_Src, L.no_of_units, R.no_of_units);
		self.tax_dt_no_of_units               := IF(L.src_no_of_units = Constants.MSL_Src, L.tax_dt_no_of_units, R.tax_dt_no_of_units);
		
    self.src_style_type 		              := IF(L.src_style_type = Constants.MSL_Src, L.src_style_type, R.src_style_type);		
		self.style_type					              := IF(L.src_style_type = Constants.MSL_Src, L.style_type, R.style_type);
		self.tax_dt_style_type                := IF(L.src_style_type = Constants.MSL_Src, L.tax_dt_style_type, R.tax_dt_style_type);
		
    self.src_assessment_document_number 	  := IF(L.src_assessment_document_number = Constants.MSL_Src, L.src_assessment_document_number, R.src_assessment_document_number);		
		self.assessment_document_number					:= IF(L.src_assessment_document_number = Constants.MSL_Src, L.assessment_document_number, R.assessment_document_number);
		self.tax_dt_assessment_document_number  := IF(L.src_assessment_document_number = Constants.MSL_Src, L.tax_dt_assessment_document_number, R.tax_dt_assessment_document_number);
		
    self.src_assessment_recording_date 		  := IF(L.src_assessment_recording_date = Constants.MSL_Src, L.src_assessment_recording_date, R.src_assessment_recording_date);		
		self.assessment_recording_date					:= IF(L.src_assessment_recording_date = Constants.MSL_Src, L.assessment_recording_date, R.assessment_recording_date);
		self.tax_dt_assessment_recording_date   := IF(L.src_assessment_recording_date = Constants.MSL_Src, L.tax_dt_assessment_recording_date, R.tax_dt_assessment_recording_date);
		
    self.src_deed_document_number 	      	:= IF(L.src_deed_document_number = Constants.MSL_Src, L.src_deed_document_number, R.src_deed_document_number);		
		self.deed_document_number				      	:= IF(L.src_deed_document_number = Constants.MSL_Src, L.deed_document_number, R.deed_document_number);
		self.rec_dt_deed_document_number        := IF(L.src_deed_document_number = Constants.MSL_Src, L.rec_dt_deed_document_number, R.rec_dt_deed_document_number);
		
		self.src_deed_recording_date 		        := IF(L.src_deed_recording_date = Constants.MSL_Src, L.src_deed_recording_date, R.src_deed_recording_date);
		self.deed_recording_date				        := IF(L.src_deed_recording_date = Constants.MSL_Src, L.deed_recording_date, R.deed_recording_date);
		
		self.src_full_part_sale 		            := IF(L.src_full_part_sale = Constants.MSL_Src, L.src_full_part_sale, R.src_full_part_sale);
		self.full_part_sale					            := IF(L.src_full_part_sale = Constants.MSL_Src, L.full_part_sale, R.full_part_sale);
		self.rec_dt_full_part_sale              := IF(L.src_full_part_sale = Constants.MSL_Src, L.rec_dt_full_part_sale, R.rec_dt_full_part_sale);
		
    self.src_sale_amount 		                := IF(L.src_sale_amount = Constants.MSL_Src, L.src_sale_amount, R.src_sale_amount);		
		self.sale_amount					              := IF(L.src_sale_amount = Constants.MSL_Src, L.sale_amount, R.sale_amount);
		self.rec_dt_sale_amount                 := IF(L.src_sale_amount = Constants.MSL_Src, L.rec_dt_sale_amount, R.rec_dt_sale_amount);
		
		self.src_sale_date 		                  := IF(L.src_sale_date = Constants.MSL_Src, L.src_sale_date, R.src_sale_date);
		self.sale_date					                := IF(L.src_sale_date = Constants.MSL_Src, L.sale_date, R.sale_date);
		self.rec_dt_sale_date                   := IF(L.src_sale_date = Constants.MSL_Src, L.rec_dt_sale_date, R.rec_dt_sale_date);
		
		self.src_sale_type_code 		            := IF(L.src_sale_type_code = Constants.MSL_Src, L.src_sale_type_code, R.src_sale_type_code);
		self.sale_type_code					            := IF(L.src_sale_type_code = Constants.MSL_Src, L.sale_type_code, R.sale_type_code);
		self.rec_dt_sale_type_code              := IF(L.src_sale_type_code = Constants.MSL_Src, L.rec_dt_sale_type_code, R.rec_dt_sale_type_code);
		
    self.src_mortgage_company_name 		      := IF(L.src_mortgage_company_name = Constants.MSL_Src, L.src_mortgage_company_name, R.src_mortgage_company_name);		
		self.mortgage_company_name					    := IF(L.src_mortgage_company_name = Constants.MSL_Src, L.mortgage_company_name, R.mortgage_company_name);
		self.rec_dt_mortgage_company_name       := IF(L.src_mortgage_company_name = Constants.MSL_Src, L.rec_dt_mortgage_company_name, R.rec_dt_mortgage_company_name);
		
    self.src_loan_amount 		                := IF(L.src_loan_amount = Constants.MSL_Src, L.src_loan_amount, R.src_loan_amount);		
		self.loan_amount					              := IF(L.src_loan_amount = Constants.MSL_Src, L.loan_amount, R.loan_amount);
		self.rec_dt_loan_amount                 := IF(L.src_loan_amount = Constants.MSL_Src, L.rec_dt_loan_amount, R.rec_dt_loan_amount);
		
		self.src_second_loan_amount 		        := IF(L.src_second_loan_amount = Constants.MSL_Src, L.src_second_loan_amount, R.src_second_loan_amount);
		self.second_loan_amount					        := IF(L.src_second_loan_amount = Constants.MSL_Src, L.second_loan_amount, R.second_loan_amount);
		self.rec_dt_second_loan_amount          := IF(L.src_second_loan_amount = Constants.MSL_Src, L.rec_dt_second_loan_amount, R.rec_dt_second_loan_amount);
		
		self.src_loan_type_code 		            := IF(L.src_loan_type_code = Constants.MSL_Src, L.src_loan_type_code, R.src_loan_type_code);
		self.loan_type_code					            := IF(L.src_loan_type_code = Constants.MSL_Src, L.loan_type_code, R.loan_type_code);
		self.rec_dt_loan_type_code              := IF(L.src_loan_type_code = Constants.MSL_Src, L.rec_dt_loan_type_code, R.rec_dt_loan_type_code);
		
		self.src_interest_rate_type_code 		    := IF(L.src_interest_rate_type_code = Constants.MSL_Src, L.src_interest_rate_type_code, R.src_interest_rate_type_code);
		self.interest_rate_type_code					  := IF(L.src_interest_rate_type_code = Constants.MSL_Src, L.interest_rate_type_code, R.interest_rate_type_code);
		self.rec_dt_interest_rate_type_code     := IF(L.src_interest_rate_type_code = Constants.MSL_Src, L.rec_dt_interest_rate_type_code, R.rec_dt_interest_rate_type_code);

		SELF := L;
	END;
	
	EXPORT	UNSIGNED1	DataSource_SortOrder(STRING25	DataSource)	:=
			CASE(DataSource, 
										'A' => 1,
										'B' => 2,
										'B DEFAULT PLUS' => 3,
										'B DEFAULT PLUS NO HLD' => 4,
										'F SELECTED SOURCE' => 5,
										'G SELECTED SRCE NO HLD' => 6,
										'F SELECTED SOURCE PLUS' => 7,
										'G SEL SRCE PLUS NO HLD' => 8,
										'D PUBLIC RECORD SOURCE A' => 9,
										'C PUBLIC RECORD SOURCE B' => 10,
										'E HOME LISTING DATA' => 11,
										12);
										
  EXPORT isOptOut ( UNSIGNED8 Lexid, doxie.IDataAccess mod_access) := FUNCTION
    MAC_Suppress_In_Layout := RECORD
        UNSIGNED6 did;
        UNSIGNED4 global_sid;
    END;
    ds_in	:= DATASET([{Lexid, Constants.MLS_Global_Source_ID}],MAC_Suppress_In_Layout);
    RETURN ~EXISTS(Suppress.MAC_SuppressSource(ds_in, mod_access));
  END;                    
end;