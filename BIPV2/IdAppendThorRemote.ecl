import _Control;

EXPORT IdAppendThorRemote(
		dataset(BIPV2.IdAppendLayouts.AppendInput) inputDs
		,unsigned scoreThreshold = 75
		,unsigned weightThreshold = 0
		,boolean disableSaltForce = true
		,boolean primForcePost = false 
		,boolean useFuzzy = true
		,boolean doZipExpansion = true
		,boolean reAppend = true
		,boolean mimicRoxie = false // This is for ease of testing and can cause slower performance
		                            // on thor appends so should not be used for production.
	) := module

	shared serviceName := 'BizLinkFull.svcappend';

	shared xmlUnsigned(string element, unsigned val) :=
		'<' + element + '>'
		+ (string)val
		+ '</' + element + '>';

	shared xmlString(string element, string val) :=
		'<' + element + '>'
		+ val
		+ '</' + element + '>';

	shared xmlBool(string element, boolean val) :=
		'<' + element + '>'
		+ if(val, 'true', 'false')
		+ '</' + element + '>';

	
	isProd := _control.ThisEnvironment.Name = 'Prod';
	certUrl := _control.RoxieEnv.boca_certvip;
	prodUrl := _control.RoxieEnv.boca_prodvip;
	shared urlBipAppend := if(isProd, prodUrl, certUrl);

	shared pipeParms := xmlUnsigned('score_threshold', scoreThreshold)
		+ xmlUnsigned('weight_threshold', weightThreshold)
		+ xmlBool('disable_salt_force', disableSaltForce)
		+ xmlBool('prim_force_post', primForcePost)
		+ xmlBool('use_fuzzy', useFuzzy)
		+ xmlBool('do_zip_expansion', doZipExpansion)
		+ xmlBool('re_append', reAppend)
		+ xmlBool('from_thor', not mimicRoxie);

	shared IdsAndBest(boolean includeBest, string fetchLevel = BIPV2.IdConstants.fetch_level_proxid, boolean allBest = false) := function

		pipeOutput := PIPE(inputDs,
			'roxiepipe -iw ' + SIZEOF(BIPV2.IdAppendLayouts.AppendInput)+' -t 1 -ow '
			+ SIZEOF(BIPV2.IdAppendLayouts.svcAppendOut)
			+ ' -b 1000 -mr 2 -h '+ urlBipAppend + ' -vip -r ' + 'Results' + ' -q "<' + serviceName + ' format=\'raw\'>'
			+ pipeParms
			+ xmlBool('include_best', includeBest)
			+ xmlString('fetch_level', fetchLevel)
			+ xmlBool('all_best', allBest)
			+ '<append_input id=\'id\' format=\'raw\'></append_input></' + serviceName + '>"'
			,BIPV2.IdAppendLayouts.svcAppendOut);

		return project(pipeOutput, transform(BIPV2.IdAppendLayouts.AppendOutput, self := left, self := []));

	end;

	export IdsOnly() := IdsAndBest(includeBest := false);
	export WithBest(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid, boolean allBest = false)
		:= IdsAndBest(includeBest := true, fetchLevel := fetchLevel, allBest := allBest);

	export WithRecords(string fetchLevel = BIPV2.IdConstants.fetch_level_proxid) := function

		pipeOutput := PIPE(inputDs,
			'roxiepipe -iw ' + SIZEOF(BIPV2.IdAppendLayouts.AppendInput)+' -t 1 -ow '
			+ SIZEOF(BIPV2.IdAppendLayouts.svcAppendRecsOut)
			+ ' -b 1000 -mr 2 -h '+ urlBipAppend + ' -vip -r ' + 'Header' + ' -q "<' + serviceName + ' format=\'raw\'>'
			+ pipeParms
			+ xmlBool('include_best', false)
			+ xmlBool('include_records', true)
			+ xmlString('fetch_level', fetchLevel)
			+ '<append_input id=\'id\' format=\'raw\'></append_input></' + serviceName + '>"'
			,BIPV2.IdAppendLayouts.svcAppendRecsOut);

		return project(pipeOutput, transform(BIPV2.IdAppendLayouts.AppendWithRecsOutput, self := left, self := []));

	end;
	

end;