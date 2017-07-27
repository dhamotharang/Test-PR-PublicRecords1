export	Mac_Property_Rollup(inFile,outFile,includeBB	=	true,isBase	=	false)	:=
macro
	LOADXML('<xml/>');
	#EXPORTXML(dInFileMetaInfo,recordof(inFile))

	#uniquename(tAssignSource)
	
	recordof(inFile)	%tAssignSource%(inFile	pInput)	:=
	transform
		#IF(%'doAssignDefaults'%='')
			#DECLARE(doAssignDefaults)
		#END

		#FOR(dInFileMetaInfo)
			#FOR(Field)
				#SET(doAssignDefaults,'')
				#IF(%'@type'% = 'string'	and	regexfind('^src_',%'@name'%,nocase))
					#APPEND(doAssignDefaults,'self.'	+	%'@name'%)
					#APPEND(doAssignDefaults,'	:=	if((string)pInput.')
					#APPEND(doAssignDefaults,%'@name'%[5..])
					#APPEND(doAssignDefaults,'	not in	[\'\',\'0\'],')
					#APPEND(doAssignDefaults,'pInput.vendor,')
					#APPEND(doAssignDefaults,'\'\'')
					#APPEND(doAssignDefaults,');\n')
					%doAssignDefaults%;
				#ELSEIF(%'@type'% = 'string'	and	regexfind('^tax_dt_',%'@name'%,nocase))
					#APPEND(doAssignDefaults,'self.'	+	%'@name'%)
					#APPEND(doAssignDefaults,'	:=	if((string)pInput.')
					#APPEND(doAssignDefaults,%'@name'%[8..])
					#APPEND(doAssignDefaults,'	not in	[\'\',\'0\'],')
					#APPEND(doAssignDefaults,'pInput.tax_sortby_date,')
					#APPEND(doAssignDefaults,'\'\'')
					#APPEND(doAssignDefaults,');\n')
					%doAssignDefaults%;
				#ELSEIF(%'@type'% = 'string'	and	regexfind('^rec_dt_',%'@name'%,nocase))
					#APPEND(doAssignDefaults,'self.'	+	%'@name'%)
					#APPEND(doAssignDefaults,'	:=	if(pInput.')
					#APPEND(doAssignDefaults,%'@name'%[8..])
					#APPEND(doAssignDefaults,'	!=	\'\',')
					#APPEND(doAssignDefaults,'pInput.deed_sortby_date,')
					#APPEND(doAssignDefaults,'\'\'')
					#APPEND(doAssignDefaults,');\n')
					%doAssignDefaults%;
				#ELSE
					#APPEND(doAssignDefaults,'')
				#END
			#END
		#END
		self :=	pInput;
	end;

	#uniquename(dPreRollup)
	
	#if(isBase)
		%dPreRollup%	:=	inFile;
	#else
		%dPreRollup%	:=	project(inFile,%tAssignSource%(left));
	#end
	
	// Filter out records which don't have the full address populated
	#uniquename(dPreRollupFilt)
	#uniquename(dPreRollupDist)
	#uniquename(dPreRollupSort)
	
	%dPreRollupFilt%	:=	%dPreRollup%(prim_range	!=	''	and	prim_name	!=	''	and	zip	!=	'');
	
	#if(includeBB	=	true)
		%dPreRollupDist%	:=	distribute(%dPreRollupFilt%,property_ace_aid);
		%dPreRollupSort%	:=	sort(	%dPreRollupDist%,
																property_ace_aid,
																-tax_sortby_date,-deed_sortby_date,vendor_preference,-dt_vendor_last_reported,
																local
															);
	#else
		%dPreRollupDist%	:=	distribute(%dPreRollupFilt%,hash32(vendor_source,property_ace_aid));
		%dPreRollupSort%	:=	sort(	%dPreRollupDist%,
																vendor_source,property_ace_aid,
																-tax_sortby_date,-deed_sortby_date,-dt_vendor_last_reported,
																local
															);
	#end

	// Rollup data on property address
	#EXPORTXML(dPreRollupMetaInfo,recordof(%dPreRollupSort%))
	
	#uniquename(tRollup)
	recordof(inFile)	%tRollup%(%dPreRollupSort%	le,%dPreRollupSort%	ri)	:=
	transform
		#IF(%'doRollupText'%='')
			#DECLARE(doRollupText)
		#END

		#FOR(dPreRollupMetaInfo)
			#FOR(Field)
				#SET(doRollupText,'')
				#IF(%'@type'% = 'string'	and	regexfind('^src_',%'@name'%,nocase))
					#APPEND(doRollupText,'self.'	+	%'@name'%)
					#APPEND(doRollupText,'	:=	if((string)le.')
					#APPEND(doRollupText,%'@name'%[5..])
					#APPEND(doRollupText,'	not in	[\'\',\'0\'],')
					#APPEND(doRollupText,'le.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,',')
					#APPEND(doRollupText,'if((string)ri.')
					#APPEND(doRollupText,%'@name'%[5..])
					#APPEND(doRollupText,'	not in	[\'\',\'0\'],')
					#APPEND(doRollupText,'ri.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,',')
					#APPEND(doRollupText,'\'\')')
					#APPEND(doRollupText,');\n')
					%doRollupText%;
				#ELSEIF(%'@type'% = 'string'	and	regexfind('^tax_dt_',%'@name'%,nocase))
					#APPEND(doRollupText,'self.'	+	%'@name'%)
					#APPEND(doRollupText,'	:=	if((string)le.')
					#APPEND(doRollupText,%'@name'%[8..])
					#APPEND(doRollupText,'	not in	[\'\',\'0\'],')
					#APPEND(doRollupText,'le.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,',')
					#APPEND(doRollupText,'if((string)ri.')
					#APPEND(doRollupText,%'@name'%[8..])
					#APPEND(doRollupText,'	not in	[\'\',\'0\'],')
					#APPEND(doRollupText,'ri.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,',')
					#APPEND(doRollupText,'\'\')')
					#APPEND(doRollupText,');\n')
					%doRollupText%;
				#ELSEIF(%'@type'% = 'string'	and	regexfind('^rec_dt_',%'@name'%,nocase))
					#APPEND(doRollupText,'self.'	+	%'@name'%)
					#APPEND(doRollupText,'	:=	if(le.')
					#APPEND(doRollupText,%'@name'%[8..])
					#APPEND(doRollupText,'	!=	\'\',')
					#APPEND(doRollupText,'le.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,',')
					#APPEND(doRollupText,'if(ri.')
					#APPEND(doRollupText,%'@name'%[8..])
					#APPEND(doRollupText,'	!=	\'\',')
					#APPEND(doRollupText,'ri.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,',')
					#APPEND(doRollupText,'\'\')')
					#APPEND(doRollupText,');\n')
					%doRollupText%;
				#ELSEIF(%'@type'% = 'string'	and	stringlib.stringfind(stringlib.stringtolowercase(%'@name'%),'vendor_source',1)	>	0)
					#APPEND(doRollupText,'self.'	+	%'@name'%)
					#APPEND(doRollupText,'	:=	le.vendor_source;\n')
					%doRollupText%;
				#ELSEIF(%'@type'% = 'string'	and	regexfind('category|material|quality|condition',%'@name'%,nocase)	=	false)
					#APPEND(doRollupText,'self.'	+	%'@name'%)
					#APPEND(doRollupText,'	:=	if(le.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,'	!=	\'\',le.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,',ri.')
					#APPEND(doRollupText,%'@name'%)
					#APPEND(doRollupText,');\n')
					%doRollupText%;
				#ELSE
					#APPEND(doRollupText,'')
				#END
			#END
		#END
		self.dt_vendor_first_reported	:=	ut.EarliestDate(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
		self.dt_vendor_last_reported	:=	ut.LatestDate(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
		self													:=	le;
	end;

	#uniquename(dRollup)
	
	#if(includeBB)
		%dRollup%	:=	rollup(	%dPreRollupSort%,
													left.property_ace_aid	=	right.property_ace_aid,
													%tRollup%(left,right),
													local
												);
	#else
		%dRollup%	:=	rollup(	%dPreRollupSort%,
													left.vendor_source		=	right.vendor_source	and
													left.property_ace_aid	=	right.property_ace_aid,
													%tRollup%(left,right),
													local
												);
	#end

	// Rollup records keeping the most recent tax record
	#uniquename(tTaxRollup)
	recordof(inFile)	%tTaxRollup%(%dPreRollupSort%	le,%dPreRollupSort%	ri)	:=
	transform
		// Populate the below tax fields with the most recent tax data
		// If two records meet the criteria for the rollup, make sure to keep the field with populated value
		self.homestead_exemption_ind						:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.homestead_exemption_ind,
																										if(le.homestead_exemption_ind	!=	'',le.homestead_exemption_ind,ri.homestead_exemption_ind)
																									);
		self.src_homestead_exemption_ind				:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.homestead_exemption_ind	!=	'',le.src_homestead_exemption_ind,''),
																										if(	le.homestead_exemption_ind	!=	'',
																												le.src_homestead_exemption_ind,
																												if(ri.homestead_exemption_ind	!=	'',ri.src_homestead_exemption_ind,'')
																											)
																									);
		self.tax_dt_homestead_exemption_ind			:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.homestead_exemption_ind	!=	'',le.tax_dt_homestead_exemption_ind,''),
																										if(	le.homestead_exemption_ind	!=	'',
																												le.tax_dt_homestead_exemption_ind,
																												if(ri.homestead_exemption_ind	!=	'',ri.tax_dt_homestead_exemption_ind,'')
																											)
																									);
		self.tax_amount													:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.tax_amount,
																										if(le.tax_amount	!=	'',le.tax_amount,ri.tax_amount)
																									);
		self.src_tax_amount											:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.tax_amount	!=	'',le.src_tax_amount,''),
																										if(	le.tax_amount	!=	'',
																												le.src_tax_amount,
																												if(ri.tax_amount	!=	'',ri.src_tax_amount,'')
																											)
																									);
		self.tax_dt_tax_amount									:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.tax_amount	!=	'',le.tax_dt_tax_amount,''),
																										if(	le.tax_amount	!=	'',
																												le.tax_dt_tax_amount,
																												if(ri.tax_amount	!=	'',ri.tax_dt_tax_amount,'')
																											)
																									);
		self.tax_year														:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.tax_year,
																										if(le.tax_year	!=	'',le.tax_year,ri.tax_year)
																									);
		self.src_tax_year												:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.tax_year	!=	'',le.src_tax_year,''),
																										if(	le.tax_year	!=	'',
																												le.src_tax_year,
																												if(ri.tax_year	!=	'',ri.src_tax_year,'')
																											)
																									);
		self.assessed_land_value								:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.assessed_land_value,
																										if(le.assessed_land_value	!=	'',le.assessed_land_value,ri.assessed_land_value)
																									);
		self.src_assessed_land_value						:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.assessed_land_value	!=	'',le.src_assessed_land_value,''),
																										if(	le.assessed_land_value	!=	'',
																												le.src_assessed_land_value,
																												if(ri.assessed_land_value	!=	'',ri.src_assessed_land_value,'')
																											)
																									);
		self.tax_dt_assessed_land_value					:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.assessed_land_value	!=	'',le.tax_dt_assessed_land_value,''),
																										if(	le.assessed_land_value	!=	'',
																												le.tax_dt_assessed_land_value,
																												if(ri.assessed_land_value	!=	'',ri.tax_dt_assessed_land_value,'')
																											)
																									);
		self.assessed_year											:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.assessed_year,
																										if(le.assessed_year	!=	'',le.assessed_year,ri.assessed_year)
																									);
		self.src_assessed_year									:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.assessed_year	!=	'',le.src_assessed_year,''),
																										if(	le.assessed_year	!=	'',
																												le.src_assessed_year,
																												if(ri.assessed_year	!=	'',ri.src_assessed_year,'')
																											)
																									);
		self.tax_dt_assessed_year								:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.assessed_year	!=	'',le.tax_dt_assessed_year,''),
																										if(	le.assessed_year	!=	'',
																												le.tax_dt_assessed_year,
																												if(ri.assessed_year	!=	'',ri.tax_dt_assessed_year,'')
																											)
																									);
		self.improvement_value									:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.improvement_value,
																										if(le.improvement_value	!=	'',le.improvement_value,ri.improvement_value)
																									);
		self.src_improvement_value							:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.improvement_value	!=	'',le.src_improvement_value,''),
																										if(	le.improvement_value	!=	'',
																												le.src_improvement_value,
																												if(ri.improvement_value	!=	'',ri.src_improvement_value,'')
																											)
																									);
		self.tax_dt_improvement_value						:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.improvement_value	!=	'',le.tax_dt_improvement_value,''),
																										if(	le.improvement_value	!=	'',
																												le.tax_dt_improvement_value,
																												if(ri.improvement_value	!=	'',ri.tax_dt_improvement_value,'')
																											)
																									);
		self.market_land_value									:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.market_land_value,
																										if(le.market_land_value	!=	'',le.market_land_value,ri.market_land_value)
																									);
		self.src_market_land_value							:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.market_land_value	!=	'',le.src_market_land_value,''),
																										if(	le.market_land_value	!=	'',
																												le.src_market_land_value,
																												if(ri.market_land_value	!=	'',ri.src_market_land_value,'')
																											)
																									);
		self.tax_dt_market_land_value						:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.market_land_value	!=	'',le.tax_dt_market_land_value,''),
																										if(	le.market_land_value	!=	'',
																												le.tax_dt_market_land_value,
																												if(ri.market_land_value	!=	'',ri.tax_dt_market_land_value,'')
																											)
																									);
		self.total_assessed_value								:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.total_assessed_value,
																										if(le.total_assessed_value	!=	'',le.total_assessed_value,ri.total_assessed_value)
																									);
		self.src_total_assessed_value						:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.total_assessed_value	!=	'',le.src_total_assessed_value,''),
																										if(	le.total_assessed_value	!=	'',
																												le.src_total_assessed_value,
																												if(ri.total_assessed_value	!=	'',ri.src_total_assessed_value,'')
																											)
																									);
		self.tax_dt_total_assessed_value				:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.total_assessed_value	!=	'',le.tax_dt_total_assessed_value,''),
																										if(	le.total_assessed_value	!=	'',
																												le.tax_dt_total_assessed_value,
																												if(ri.total_assessed_value	!=	'',ri.tax_dt_total_assessed_value,'')
																											)
																									);
		self.percent_improved										:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.percent_improved,
																										if(le.percent_improved	!=	0,le.percent_improved,ri.percent_improved)
																									);
		self.src_percent_improved								:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.percent_improved	!=	0,le.src_percent_improved,''),
																										if(	le.percent_improved	!=	0,
																												le.src_percent_improved,
																												if(ri.percent_improved	!=	0,ri.src_percent_improved,'')
																											)
																									);
		self.tax_dt_percent_improved						:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.percent_improved	!=	0,le.tax_dt_percent_improved,''),
																										if(	le.percent_improved	!=	0,
																												le.tax_dt_percent_improved,
																												if(ri.percent_improved	!=	0,ri.tax_dt_percent_improved,'')
																											)
																									);
		self.total_market_value									:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.total_market_value,
																										if(le.total_market_value	!=	'',le.total_market_value,ri.total_market_value)
																									);
		self.src_total_market_value							:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.total_market_value	!=	'',le.src_total_market_value,''),
																										if(	le.total_market_value	!=	'',
																												le.src_total_market_value,
																												if(ri.total_market_value	!=	'',ri.src_total_market_value,'')
																											)
																									);
		self.tax_dt_total_market_value					:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.total_market_value	!=	'',le.tax_dt_total_market_value,''),
																										if(	le.total_market_value	!=	'',
																												le.tax_dt_total_market_value,
																												if(ri.total_market_value	!=	'',ri.tax_dt_total_market_value,'')
																											)
																									);
		self.total_land_value										:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.total_land_value,
																										if(le.total_land_value	!=	'',le.total_land_value,ri.total_land_value)
																									);
		self.src_total_land_value								:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.total_land_value	!=	'',le.src_total_land_value,''),
																										if(	le.total_land_value	!=	'',
																												le.src_total_land_value,
																												if(ri.total_land_value	!=	'',ri.src_total_land_value,'')
																											)
																									);
		self.tax_dt_total_land_value						:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.total_land_value	!=	'',le.tax_dt_total_land_value,''),
																										if(	le.total_land_value	!=	'',
																												le.tax_dt_total_land_value,
																												if(ri.total_land_value	!=	'',ri.tax_dt_total_land_value,'')
																											)
																									);
		self.total_calculated_value							:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.total_calculated_value,
																										if(le.total_calculated_value	!=	'',le.total_calculated_value,ri.total_calculated_value)
																									);
		self.src_total_calculated_value					:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.total_calculated_value	!=	'',le.src_total_calculated_value,''),
																										if(	le.total_calculated_value	!=	'',
																												le.src_total_calculated_value,
																												if(ri.total_calculated_value	!=	'',ri.src_total_calculated_value,'')
																											)
																									);
		self.tax_dt_total_calculated_value			:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.total_calculated_value	!=	'',le.tax_dt_total_calculated_value,''),
																										if(	le.total_calculated_value	!=	'',
																												le.tax_dt_total_calculated_value,
																												if(ri.total_calculated_value	!=	'',ri.tax_dt_total_calculated_value,'')
																											)
																									);
		self.assessment_document_number					:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.assessment_document_number,
																										if(le.assessment_document_number	!=	'',le.assessment_document_number,ri.assessment_document_number)
																									);
		self.src_assessment_document_number			:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.assessment_document_number	!=	'',le.src_assessment_document_number,''),
																										if(	le.assessment_document_number	!=	'',
																												le.src_assessment_document_number,
																												if(ri.assessment_document_number	!=	'',ri.src_assessment_document_number,'')
																											)
																									);
		self.tax_dt_assessment_document_number	:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.assessment_document_number	!=	'',le.tax_dt_assessment_document_number,''),
																										if(	le.assessment_document_number	!=	'',
																												le.tax_dt_assessment_document_number,
																												if(ri.assessment_document_number	!=	'',ri.tax_dt_assessment_document_number,'')
																											)
																									);
		self.assessment_recording_date					:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										le.assessment_recording_date,
																										if(le.assessment_recording_date	!=	'',le.assessment_recording_date,ri.assessment_recording_date)
																									);
		self.src_assessment_recording_date			:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.assessment_recording_date	!=	'',le.src_assessment_recording_date,''),
																										if(	le.assessment_recording_date	!=	'',
																												le.src_assessment_recording_date,
																												if(ri.assessment_recording_date	!=	'',ri.src_assessment_recording_date,'')
																											)
																									);
		self.tax_dt_assessment_recording_date		:=	if(	(integer)ri.tax_sortby_date[1..4]	<	(integer)le.tax_sortby_date[1..4],
																										if(le.assessment_recording_date	!=	'',le.tax_dt_assessment_recording_date,''),
																										if(	le.assessment_recording_date	!=	'',
																												le.tax_dt_assessment_recording_date,
																												if(ri.assessment_recording_date	!=	'',ri.tax_dt_assessment_recording_date,'')
																											)
																									);
		self																		:=	le;
	end;
	
	#uniquename(dTaxRollup)
	
	#if(includeBB)
		%dTaxRollup%	:=	rollup(	%dPreRollupSort%,
															left.property_ace_aid	=	right.property_ace_aid,
															%tTaxRollup%(left,right),
															local
														);
	#else
		%dTaxRollup%	:=	rollup(	%dPreRollupSort%,
															left.vendor_source		=	right.vendor_source	and
															left.property_ace_aid	=	right.property_ace_aid,
															%tTaxRollup%(left,right),
															local
														);
	#end
	
	// Join the rolled up file to the current tax file to get the latest tax information
	#uniquename(tGetCurrentTaxInfo)
	recordof(inFile)	%tGetCurrentTaxInfo%(%dRollup%	le,%dTaxRollup%	ri)	:=
	transform
		self.homestead_exemption_ind						:=	ri.homestead_exemption_ind;
		self.src_homestead_exemption_ind				:=	ri.src_homestead_exemption_ind;
		self.tax_dt_homestead_exemption_ind			:=	ri.tax_dt_homestead_exemption_ind;
		self.tax_amount													:=	ri.tax_amount;
		self.src_tax_amount											:=	ri.src_tax_amount;
		self.tax_dt_tax_amount									:=	ri.tax_dt_tax_amount;
		self.tax_year														:=	ri.tax_year;
		self.src_tax_year												:=	ri.src_tax_year;
		self.assessed_land_value								:=	ri.assessed_land_value;
		self.src_assessed_land_value						:=	ri.src_assessed_land_value;
		self.tax_dt_assessed_land_value					:=	ri.tax_dt_assessed_land_value;
		self.assessed_year											:=	ri.assessed_year;
		self.src_assessed_year									:=	ri.src_assessed_year;
		self.tax_dt_assessed_year								:=	ri.tax_dt_assessed_year;
		self.improvement_value									:=	ri.improvement_value;
		self.src_improvement_value							:=	ri.src_improvement_value;
		self.tax_dt_improvement_value						:=	ri.tax_dt_improvement_value;
		self.market_land_value									:=	ri.market_land_value;
		self.src_market_land_value							:=	ri.src_market_land_value;
		self.tax_dt_market_land_value						:=	ri.tax_dt_market_land_value;
		self.total_assessed_value								:=	ri.total_assessed_value;
		self.src_total_assessed_value						:=	ri.src_total_assessed_value;
		self.tax_dt_total_assessed_value				:=	ri.tax_dt_total_assessed_value;
		self.percent_improved										:=	ri.percent_improved;
		self.src_percent_improved								:=	ri.src_percent_improved;
		self.tax_dt_percent_improved						:=	ri.tax_dt_percent_improved;
		self.total_market_value									:=	ri.total_market_value;
		self.src_total_market_value							:=	ri.src_total_market_value;
		self.tax_dt_total_market_value					:=	ri.tax_dt_total_market_value;
		self.total_land_value										:=	ri.total_land_value;
		self.src_total_land_value								:=	ri.src_total_land_value;
		self.tax_dt_total_land_value						:=	ri.tax_dt_total_land_value;
		self.total_calculated_value							:=	ri.total_calculated_value;
		self.src_total_calculated_value					:=	ri.src_total_calculated_value;
		self.tax_dt_total_calculated_value			:=	ri.tax_dt_total_calculated_value;
		self.assessment_document_number					:=	ri.assessment_document_number;
		self.src_assessment_document_number			:=	ri.src_assessment_document_number;
		self.tax_dt_assessment_document_number	:=	ri.tax_dt_assessment_document_number;
		self.assessment_recording_date					:=	ri.assessment_recording_date;
		self.src_assessment_recording_date			:=	ri.src_assessment_recording_date;
		self.tax_dt_assessment_recording_date		:=	ri.tax_dt_assessment_recording_date;
		
		self																		:=	le;
	end;
	
	#uniquename(dCurrentTaxInfo)
	
	#if(includeBB)
		%dCurrentTaxInfo%	:=	join(	%dRollup%,
																%dTaxRollup%,
																left.property_ace_aid	=	right.property_ace_aid,
																%tGetCurrentTaxInfo%(left,right),
																left outer,
																local
															);
	#else
		%dCurrentTaxInfo%	:=	join(	%dRollup%,
																%dTaxRollup%,
																left.vendor_source		=	right.vendor_source	and
																left.property_ace_aid	=	right.property_ace_aid,
																%tGetCurrentTaxInfo%(left,right),
																left outer,
																local
															);
	#end
	
	// Sort records on property address and deed recording date and rollup records keeping the most recent record
	#uniquename(dDeedSort)
	%dDeedSort%		:=	sort(	%dPreRollupDist%,
													property_ace_aid,
													-deed_sortby_date,-tax_sortby_date,
													vendor_preference,-dt_vendor_last_reported,
													local
												);

	#uniquename(tDeedRollup)
	recordof(inFile)	%tDeedRollup%(%dDeedSort%	le,%dDeedSort%	ri)	:=
	transform
		// Populate the below deed fields with the most recent deed/mortgage data
		// If two records meet the criteria for the rollup, make sure to keep the field with populated value
		self.deed_document_number						:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.deed_document_number,
																								if(le.deed_document_number	!=	'',le.deed_document_number,ri.deed_document_number)
																							);
		self.src_deed_document_number				:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.deed_document_number	!=	'',le.src_deed_document_number,''),
																								if(	le.deed_document_number	!=	'',
																										le.src_deed_document_number,
																										if(ri.deed_document_number	!=	'',ri.src_deed_document_number,'')
																									)
																							);
		self.rec_dt_deed_document_number		:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.deed_document_number	!=	'',le.rec_dt_deed_document_number,''),
																								if(	le.deed_document_number	!=	'',
																										le.rec_dt_deed_document_number,
																										if(ri.deed_document_number	!=	'',ri.rec_dt_deed_document_number,'')
																									)
																							);
		self.deed_recording_date						:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.deed_recording_date,
																								if(le.deed_recording_date	!=	'',le.deed_recording_date,ri.deed_recording_date)
																							);
		self.src_deed_recording_date				:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.deed_recording_date	!=	'',le.src_deed_recording_date,''),
																								if(	le.deed_recording_date	!=	'',
																										le.src_deed_recording_date,
																										if(ri.deed_recording_date	!=	'',ri.src_deed_recording_date,'')
																									)
																							);
		self.full_part_sale									:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.full_part_sale,
																								if(le.full_part_sale	!=	'',le.full_part_sale,ri.full_part_sale)
																							);
		self.src_full_part_sale							:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.full_part_sale	!=	'',le.src_full_part_sale,''),
																								if(	le.full_part_sale	!=	'',
																										le.src_full_part_sale,
																										if(ri.full_part_sale	!=	'',ri.src_full_part_sale,'')
																									)
																							);
		self.rec_dt_full_part_sale					:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.full_part_sale	!=	'',le.rec_dt_full_part_sale,''),
																								if(	le.full_part_sale	!=	'',
																										le.rec_dt_full_part_sale,
																										if(ri.full_part_sale	!=	'',ri.rec_dt_full_part_sale,'')
																									)
																							);
		self.sale_amount										:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.sale_amount,
																								if(le.sale_amount	!=	'',le.sale_amount,ri.sale_amount)
																							);
		self.src_sale_amount								:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.sale_amount	!=	'',le.src_sale_amount,''),
																								if(	le.sale_amount	!=	'',
																										le.src_sale_amount,
																										if(ri.sale_amount	!=	'',ri.src_sale_amount,'')
																									)
																							);
		self.rec_dt_sale_amount							:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.sale_amount	!=	'',le.rec_dt_sale_amount,''),
																								if(	le.sale_amount	!=	'',
																										le.rec_dt_sale_amount,
																										if(ri.sale_amount	!=	'',ri.rec_dt_sale_amount,'')
																									)
																							);
		self.sale_date											:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.sale_date,
																								if(le.sale_date	!=	'',le.sale_date,ri.sale_date)
																							);
		self.src_sale_date									:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.sale_date	!=	'',le.src_sale_date,''),
																								if(	le.sale_date	!=	'',
																										le.src_sale_date,
																										if(ri.sale_date	!=	'',ri.src_sale_date,'')
																									)
																							);
		self.rec_dt_sale_date								:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.sale_date	!=	'',le.rec_dt_sale_date,''),
																								if(	le.sale_date	!=	'',
																										le.rec_dt_sale_date,
																										if(ri.sale_date	!=	'',ri.rec_dt_sale_date,'')
																									)
																							);
		self.sale_type_code									:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.sale_type_code,
																								if(le.sale_type_code	!=	'',le.sale_type_code,ri.sale_type_code)
																							);
		self.src_sale_type_code							:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.sale_type_code	!=	'',le.src_sale_type_code,''),
																								if(	le.sale_type_code	!=	'',
																										le.src_sale_type_code,
																										if(ri.sale_type_code	!=	'',ri.src_sale_type_code,'')
																									)
																							);
		self.rec_dt_sale_type_code					:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.sale_type_code	!=	'',le.rec_dt_sale_type_code,''),
																								if(	le.sale_type_code	!=	'',
																										le.rec_dt_sale_type_code,
																										if(ri.sale_type_code	!=	'',ri.rec_dt_sale_type_code,'')
																									)
																							);
		self.loan_amount										:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.loan_amount,
																								if(le.loan_amount	!=	'',le.loan_amount,ri.loan_amount)
																							);
		self.src_loan_amount								:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.loan_amount	!=	'',le.src_loan_amount,''),
																								if(	le.loan_amount	!=	'',
																										le.src_loan_amount,
																										if(ri.loan_amount	!=	'',ri.src_loan_amount,'')
																									)
																							);
		self.rec_dt_loan_amount							:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.loan_amount	!=	'',le.rec_dt_loan_amount,''),
																								if(	le.loan_amount	!=	'',
																										le.rec_dt_loan_amount,
																										if(ri.loan_amount	!=	'',ri.rec_dt_loan_amount,'')
																									)
																							);
		self.second_loan_amount							:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.second_loan_amount,
																								if(le.second_loan_amount	!=	'',le.second_loan_amount,ri.second_loan_amount)
																							);
		self.src_second_loan_amount					:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.second_loan_amount	!=	'',le.src_second_loan_amount,''),
																								if(	le.second_loan_amount	!=	'',
																										le.src_second_loan_amount,
																										if(ri.second_loan_amount	!=	'',ri.src_second_loan_amount,'')
																									)
																							);
		self.rec_dt_second_loan_amount			:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.second_loan_amount	!=	'',le.rec_dt_second_loan_amount,''),
																								if(	le.second_loan_amount	!=	'',
																										le.rec_dt_second_loan_amount,
																										if(ri.second_loan_amount	!=	'',ri.rec_dt_second_loan_amount,'')
																									)
																							);
		self.loan_type_code									:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.loan_type_code,
																								if(le.loan_type_code	!=	'',le.loan_type_code,ri.loan_type_code)
																							);
		self.src_loan_type_code							:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.loan_type_code	!=	'',le.src_loan_type_code,''),
																								if(	le.loan_type_code	!=	'',
																										le.src_loan_type_code,
																										if(ri.loan_type_code	!=	'',ri.src_loan_type_code,'')
																									)
																							);
		self.rec_dt_loan_type_code					:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.loan_type_code	!=	'',le.rec_dt_loan_type_code,''),
																								if(	le.loan_type_code	!=	'',
																										le.rec_dt_loan_type_code,
																										if(ri.loan_type_code	!=	'',ri.rec_dt_loan_type_code,'')
																									)
																							);
		self.interest_rate_type_code				:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.interest_rate_type_code,
																								if(le.interest_rate_type_code	!=	'',le.interest_rate_type_code,ri.interest_rate_type_code)
																							);
		self.src_interest_rate_type_code		:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.interest_rate_type_code	!=	'',le.src_interest_rate_type_code,''),
																								if(	le.interest_rate_type_code	!=	'',
																										le.src_interest_rate_type_code,
																										if(ri.interest_rate_type_code	!=	'',ri.src_interest_rate_type_code,'')
																									)
																							);
		self.rec_dt_interest_rate_type_code	:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.interest_rate_type_code	!=	'',le.rec_dt_interest_rate_type_code,''),
																								if(	le.interest_rate_type_code	!=	'',
																										le.rec_dt_interest_rate_type_code,
																										if(ri.interest_rate_type_code	!=	'',ri.rec_dt_interest_rate_type_code,'')
																									)
																							);
		self.mortgage_company_name					:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								le.mortgage_company_name,
																								if(le.mortgage_company_name	!=	'',le.mortgage_company_name,ri.mortgage_company_name)
																							);
		self.src_mortgage_company_name			:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.mortgage_company_name	!=	'',le.src_mortgage_company_name,''),
																								if(	le.mortgage_company_name	!=	'',
																										le.src_mortgage_company_name,
																										if(ri.mortgage_company_name	!=	'',ri.src_mortgage_company_name,'')
																									)
																							);
		self.rec_dt_mortgage_company_name		:=	if(	(integer)ri.deed_sortby_date	<	(integer)le.deed_sortby_date,
																								if(le.mortgage_company_name	!=	'',le.rec_dt_mortgage_company_name,''),
																								if(	le.mortgage_company_name	!=	'',
																										le.rec_dt_mortgage_company_name,
																										if(ri.mortgage_company_name	!=	'',ri.rec_dt_mortgage_company_name,'')
																									)
																							);
		
		self																:=	le;
	end;
	
	#uniquename(dDeedRollup)
	%dDeedRollup%	:=	rollup(	%dDeedSort%,
														left.property_ace_aid	=	right.property_ace_aid,
														%tDeedRollup%(left,right),
														local
													);
	
	// Populate the fields which should contain the most recent deed information
	#uniquename(dCurrentDeedInfo)
	
	#if(includeBB)
		#uniquename(tGetCurrentDeedInfo)
		recordof(inFile)	%tGetCurrentDeedInfo%(%dCurrentTaxInfo%	le,%dDeedRollup%	ri)	:=
		transform
			self.deed_document_number						:=	ri.deed_document_number;
			self.src_deed_document_number				:=	ri.src_deed_document_number;
			self.rec_dt_deed_document_number		:=	ri.rec_dt_deed_document_number;
			self.deed_recording_date						:=	ri.deed_recording_date;
			self.src_deed_recording_date				:=	ri.src_deed_recording_date;
			self.full_part_sale									:=	ri.full_part_sale;
			self.src_full_part_sale							:=	ri.src_full_part_sale;
			self.rec_dt_full_part_sale					:=	ri.rec_dt_full_part_sale;
			self.sale_amount										:=	ri.sale_amount;
			self.src_sale_amount								:=	ri.src_sale_amount;
			self.rec_dt_sale_amount							:=	ri.rec_dt_sale_amount;
			self.sale_date											:=	ri.sale_date;
			self.src_sale_date									:=	ri.src_sale_date;
			self.rec_dt_sale_date								:=	ri.rec_dt_sale_date;
			self.sale_type_code									:=	ri.sale_type_code;
			self.src_sale_type_code							:=	ri.src_sale_type_code;
			self.rec_dt_sale_type_code					:=	ri.rec_dt_sale_type_code;
			self.loan_amount										:=	ri.loan_amount;
			self.src_loan_amount								:=	ri.src_loan_amount;
			self.rec_dt_loan_amount							:=	ri.rec_dt_loan_amount;
			self.second_loan_amount							:=	ri.second_loan_amount;
			self.src_second_loan_amount					:=	ri.src_second_loan_amount;
			self.rec_dt_second_loan_amount			:=	ri.rec_dt_second_loan_amount;
			self.loan_type_code									:=	ri.loan_type_code;
			self.src_loan_type_code							:=	ri.src_loan_type_code;
			self.rec_dt_loan_type_code					:=	ri.rec_dt_loan_type_code;
			self.interest_rate_type_code				:=	ri.interest_rate_type_code;
			self.src_interest_rate_type_code		:=	ri.src_interest_rate_type_code;
			self.rec_dt_interest_rate_type_code	:=	ri.rec_dt_interest_rate_type_code;
			self.mortgage_company_name					:=	ri.mortgage_company_name;
			self.src_mortgage_company_name			:=	ri.src_mortgage_company_name;
			self.rec_dt_mortgage_company_name		:=	ri.rec_dt_mortgage_company_name;
			
			self																:=	le;
		end;
	
		%dCurrentDeedInfo%	:=	join(	%dCurrentTaxInfo%,
																	%dDeedRollup%,
																	left.property_ace_aid	=	right.property_ace_aid,
																	%tGetCurrentDeedInfo%(left,right),
																	left outer,
																	local
																);
	#else
		#uniquename(tGetCurrentLNDeedInfo)
		recordof(inFile)	%tGetCurrentLNDeedInfo%(%dCurrentTaxInfo%	pInput)	:=
		transform
			/*
			self.src_deed_document_number				:=	if(pInput.deed_document_number	!=	'',pInput.vendor,'');
			self.rec_dt_deed_document_number		:=	if(pInput.deed_document_number	!=	'',pInput.deed_recording_date,'');
			self.src_deed_recording_date				:=	if(pInput.deed_recording_date	!=	'',pInput.vendor,'');
			self.src_full_part_sale							:=	if(pInput.full_part_sale	!=	'',pInput.vendor,'');
			self.rec_dt_full_part_sale					:=	if(pInput.full_part_sale	!=	'',pInput.deed_recording_date,'');
			self.src_sale_amount								:=	if(pInput.sale_amount	!=	'',pInput.vendor,'');
			self.rec_dt_sale_amount							:=	if(pInput.sale_amount	!=	'',pInput.deed_recording_date,'');
			self.src_sale_date									:=	if(pInput.sale_date	!=	'',pInput.vendor,'');
			self.rec_dt_sale_date								:=	if(pInput.sale_date	!=	'',pInput.deed_recording_date,'');
			self.src_sale_type_code							:=	if(pInput.sale_type_code	!=	'',pInput.vendor,'');
			self.rec_dt_sale_type_code					:=	if(pInput.sale_type_code	!=	'',pInput.deed_recording_date,'');
			self.src_loan_amount								:=	if(pInput.loan_amount	!=	'',pInput.vendor,'');
			self.rec_dt_loan_amount							:=	if(pInput.loan_amount	!=	'',pInput.deed_recording_date,'');
			self.src_second_loan_amount					:=	if(pInput.second_loan_amount	!=	'',pInput.vendor,'');
			self.rec_dt_second_loan_amount			:=	if(pInput.second_loan_amount	!=	'',pInput.deed_recording_date,'');
			self.src_loan_type_code							:=	if(pInput.loan_type_code	!=	'',pInput.vendor,'');
			self.rec_dt_loan_type_code					:=	if(pInput.loan_type_code	!=	'',pInput.deed_recording_date,'');
			self.src_interest_rate_type_code		:=	if(pInput.interest_rate_type_code	!=	'',pInput.vendor,'');
			self.rec_dt_interest_rate_type_code	:=	if(pInput.interest_rate_type_code	!=	'',pInput.deed_recording_date,'');
			self.src_mortgage_company_name			:=	if(pInput.mortgage_company_name	!=	'',pInput.vendor,'');
			self.rec_dt_mortgage_company_name		:=	if(pInput.mortgage_company_name	!=	'',pInput.deed_recording_date,'');
			*/
			self																:=	pInput;
		end;
		
		%dCurrentDeedInfo%	:=	project(%dCurrentTaxInfo%,%tGetCurrentLNDeedInfo%(left));
	#end

	outFile	:=	%dCurrentDeedInfo%;
endmacro;