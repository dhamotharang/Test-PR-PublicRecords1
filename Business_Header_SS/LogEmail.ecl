EXPORT LogEmail(stage = 'started', extraBody = '', infile,matchset,keep_count,score_threshold,pFileVersion,pUseOtherEnvironment,pSetLinkingVersions) := 
MACRO

	fileservices.sendemail(
		// 'charles.morton@lexisnexis.com;david.bayliss@lexisnexis.com',
		'charles.morton@lexisnexis.com',
		'bizlink logging: ' + _Control.ThisEnvironment.Name + ' ' + stage + ' ' + thorlib.jobowner() + ' ' + thorlib.wuid() + ' ' + thorlib.jobname(),
		'count(infile): ' + count(infile) + '\n' +	
		'matchset: ' + #text(matchset) + '\n' +	
		'keep_count: ' + #text(keep_count) + '\n' +	
		'score_threshold: ' + #text(score_threshold) + '\n' +	
		'pFileVersion: ' + #text(pFileVersion) + '\n' +	
		'pUseOtherEnvironment: ' + #text(pUseOtherEnvironment) + '\n' +	
		'pSetLinkingVersions: ' + #text(pSetLinkingVersions) + '\n' +	
		'ut.GetDate: ' + ut.GetDate + '\n' +     
		'ut.getTime(): ' + ut.getTime() + '\n' +     
		'thorlib.cluster: ' + thorlib.cluster() + '\n' +     
		'thorlib.daliservers: ' + thorlib.daliservers() + '\n' +       
		'thorlib.jobname: ' + thorlib.jobname() + '\n' +     
		'thorlib.jobowner: ' + thorlib.jobowner() + '\n' +     
		'thorlib.nodes: ' + thorlib.nodes() + '\n' +     
		'thorlib.priority: ' + thorlib.priority() + '\n' +     
		'thorlib.wuid: ' + thorlib.wuid() + '\n' +
		extraBody
		
		//workaround bug 118769
		,'mailout.br.seisint.com',25,'hpcc@dataland.env'
		//end workaround bug 118769
	)

ENDMACRO;