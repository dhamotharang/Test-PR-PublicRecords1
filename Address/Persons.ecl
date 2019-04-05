import STD, lib_stringlib;
export Persons := MODULE
//OPTION('regexVersion', 1)

//shared rgxBasic := '([A-Z]+|[A-Z][.]?)';
shared rgxBasic := '([A-Z]+)';
shared rgxBasic2 := '([A-Z]{2,})';
shared rgxBasicX := '([A-Z]+(-[A-Z]+)?)';
//shared rgxBasicX := '([A-Z]+-?[A-Z]*)';
shared rgxFirst := '([A-Z-]+)';
shared rgxLast := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELA |DELLA |DELLO |DOS |DU |LA |MC |VON |VAN DEN |VAN DER |VAN DE |VAN |VANDER |VANDEN |ST |SAN |EL |LE |ABU |[ODANL]\')?([A-Z]+[A-Z\'-]+)';
// last or initial
shared rgxLastI := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELA |DELLA |DELLO |DOS |DU |LA |MC |VON |VAN DEN |VAN DER |VAN DE |VAN |VANDER |VANDEN |ST |SAN |EL |LE |ABU |[ODANL]\')?([A-Z]+)';
//shared rgxLast := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELLA |DELLO |DOS |VON |VAN DER |VAN |VANDER |ST |EL |[ODANL]\')?([A-Z][A-Z-]+)';
//shared rgxLastStrong := '(DI |DA |DEL |DE LA |DELA |DE LOS |DES |DE |DELA |DELLA |DOS |DU |LA |MC |MAC |VON |VAN DEN |VAN DER |VAN DE |VAN DEN |VAN |VANDER |VANDEN |ST |SAN |EL |LE |[ODANL]\'|A-|ABU-EL-|ABU|VAN-DEN-)([A-Z][A-Z-]+)';
shared rgxLastStrong := '(DI |DA |DEL |DE LA |DELA |DE LOS |DES |DE |DELA |DELLA |DOS |DU |LA |MC |MAC |VON |VAN DEN |VAN DER |VAN DE |VAN DEN |VAN |VANDER |VANDEN |ST |SAN |EL |LE |[ODANL]\'|(A|ABU-EL|ABU|AL|ABDUL|BAR|BEN|BOU|EL|VAN-DEN)-)([A-Z][A-Z-]+)';
shared rgxLastOrInitial := '(DI |DA |DEL |DES |DE LA |DE LOS |DE |DELA |DELLA |DELLO |DOS |DU |MC |VON |VAN DEN |VAN DER |VAN DE |VAN |VANDER |VANDEN |ST |SAN |EL |LE |[ODANL]\'|A-|ABU-EL-|ABU|VAN-DEN-)?([A-Z][A-Z-]*)';
shared rgxGen := '(JR|SR|I|II|III|IV|V|VI|VII|VIII|IX|2ND|3RD|THRD|03|4TH|5TH|6TH|1|2|3|4|5|6|7|8|9)';
shared rgxSureGen := '(JR|SR|II|III|IV|VI|VII|VIII|IX|2ND|3RD|THRD|03|4TH|5TH|6TH|1|2|3|4|5|6|7|8|9)';
shared rgxHonor := 
 '(MD|DMD|DDS|CNFP|CNM|CNP|CPA|CSW|DR|PHD|ESQ|RN|LN|DO|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|AS|NP|FNP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|MA|PT|SJ|MBA|MSD|CTM|DTM|CPS|ADJ|DWP|SEC|VDM|VMD|PA-C|PA|RPA-C|RPA|APA-C|CRNA|MBBS|PNP|RNP|CNS)';
shared rgxSureHonor := 	// no oriental names
 '(MD|DMD|DDS|CNFP|CNM|CNP|CPA|CSW|DR|PHD|ESQ|RN|LN|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|NP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|PT|SJ|MBA|MSD|CTM|DTM|CPS|ADJ|DWP|SEC|VDM|VMD|PA-C|PA|RPA-C|RPA|APA-C|CRNA|MBBS|PNP|RNP|CNS)';
shared rgxSuffix := '(' + rgxGen + '|' + rgxHonor + ')';
shared rgxSureSuffix := '(' + rgxSureGen + '|' + rgxSureHonor + ')';
shared rgxTitles := '(MR|MRS|MISS|MS|DR|REV|SHRF|SIR)';
//shared rgxConnector := 	'( AND |&| OR | AND/OR |&/OR |\\+)';
shared rgxConnector := 	'( AND |&| OR | AND/OR |&/OR |& OR |& ETUX |\\+)';
shared rgxInitial := '[A-Z][.]?';
shared rgxHyphenated := '([A-Z]+(-[A-Z-]+)?)';

shared rgxFL := '^' + rgxBasic + ' +('  + rgxLastStrong + ')$';
shared rgxFLhL := '^' + rgxBasic + ' +(([A-Z]{2,})-([A-Z]{2,}))$';
shared rgxLF := '^(' + rgxLastStrong + ') +' + rgxBasic + '$';
shared rgxLFM := '^(' + rgxLastStrong + ') +' + rgxBasic + ' +([A-Z]+)$';
shared rgxFLoLF := '^' + rgxHyphenated + ' +(' + rgxLast + ')$';										//rgxHyphenated + '$';
shared rgxFLcS := '^' + rgxBasic + ' +('  + rgxLast + ') *, *' + rgxSuffix + '$';
shared rgxFLS := '^' + rgxBasic + ' +('  + rgxLastStrong + ') +' + rgxSuffix + '$';
shared rgxFLSorLFS := '^' + rgxBasic + ' +'  + rgxBasic + ' +' + rgxSuffix + '$';
shared rgxFiMiL := '^([A-Z]) +[A-Z] +' + '(' + rgxLast + ')$';
shared rgxLFi := '^(' + rgxLast + ') +(' +  rgxInitial+ ')$';
shared rgxLFiS := '^(' + rgxLast + ') +([A-Z]) +' + rgxSureSuffix + '$';
shared rgxFiL := '^(' + rgxInitial + ') +(' + rgxLast + ')$';
shared rgxFiLS := '^(' + rgxInitial + ') +(' + rgxLast + ') +' + rgxSuffix + '$';
shared rgxFiML := '^(' + rgxInitial + ') +([A-Z]+) +(' + rgxLast + ')$';
shared rgxFiMLS := '^(' + rgxInitial + ') +([A-Z]+) +(' + rgxLast + ') +' + rgxSuffix + '$';

shared rgxFLL := '^' + rgxBasic + ' +('  + rgxLastStrong + ')' + ' +('  + rgxLast +  ')$';
shared rgxFLLS := '^' + rgxBasic + ' +('  + rgxLastStrong + ')' + ' +('  + rgxLast +  ') +' + rgxSuffix +  '$';
//shared rgxFMLL := '^' + rgxBasic + ' +([A-Z]+) +('  + rgxLast + ')' + ' +('  + rgxLast +  ')$';
shared rgxFMLL := '^(' + rgxLast + ') +([A-Z]+) +('  + rgxLast + ')' + ' +('  + rgxLast +  ')$';
shared rgxFMSL := '^' + rgxBasic + ' +([A-Z]+) +'  + rgxSureGen + ' +('  + rgxLast +  ')$';
shared rgxFMLLS := '^' + rgxBasic + ' +([A-Z]+) +('  + rgxLast + ')' + ' +('  + rgxLast + ') +' + rgxSuffix +  '$';
shared rgxFMML := '^' + rgxBasic + ' +([A-Z]+) +([A-Z]+) +('  + rgxLast +  ')$';
shared rgxFMiMiL := '^' + rgxBasic + ' +([A-Z]) +([A-Z]) +('  + rgxLast +  ')$';
shared rgxLFMiM := '^' + rgxBasic + ' +([A-Z]+) +([A-Z]) +'  + rgxBasic +  '$';
shared rgxLFMiMi := '^(' + rgxLast + ') +([A-Z]+) +([A-Z] +[A-Z])$';
shared rgxFMMLS := '^' + rgxBasic + ' +([A-Z]+) +([A-Z]+) +('  + rgxLast +  ') +' + rgxSuffix + '$';

shared rgxLFcMi := '^(' + rgxLast + ') +([A-Z]+) *, *([A-Z])$';

shared rgxFMLorLFM := '^(' + rgxLastOrInitial + ') +([A-Z\'-]+) +([A-Z]+|(' + rgxLast + '))$'; 
shared rgxFML := '^([A-Z\'-]+) +([A-Z-]+) +([A-Z]+|(' + rgxLast + '))$'; 
shared rgxILI := '^([A-Z]) +([A-Z-]+) +([A-Z])$'; 

//shared rgxFMLS := '^(' + rgxBasic + ')[ ]+(' + rgxBasic + '[ ]+)?' + rgxLast + '[ ]+' + rgxSuffix + '$';
shared rgxFMLS := '^' + rgxBasic + ' +' + rgxBasic + ' +(' + rgxLast + ') +' + rgxSuffix + '$';
shared rgxFMLcS := '^' + rgxBasic + ' +' + rgxBasic + ' +(' + rgxLast + ') *, *' + rgxSuffix + '$';
shared rgxLFMicS := '^(' + rgxLast + ') +' + rgxBasic + ' +([A-Z]) *, *' + rgxSuffix + '$';
shared rgxFMLcIII := '^' + rgxBasic + ' +' + rgxBasic + ' +(' + rgxLast + ') *, *[A-Z] +[A-Z] +[A-Z]$';
shared rgxFMcSL := '^' + rgxBasic + ' +' + rgxBasic + ' *, *' + rgxGen + ' +(' + rgxLast + ')$';

shared rgxLFS := '^(' + rgxLastStrong + ') +' + rgxBasic + ' +' + rgxSureGen + '$';
shared rgxLFMS := '^(' + rgxLast + ') +' + rgxBasic + ' +' + rgxBasic + ' +' + rgxSuffix + '$';

// dual F M & F M L
//shared rgxFMaFML := '^([A-Z]+) +([A-Z]+) *' + rgxConnector + 
//					' *([A-Z]+) +([A-Z]+ +)?(' + rgxLast + ')$';
shared rgxFMaFML := '^([A-Z]+) +([A-Z]+) *' + rgxConnector + 
					' *([A-Z]+) +([A-Z]+) +(' + rgxLast + ')$';
// dual L F & L F
shared rgxLFaLF := '^(' + rgxLast + ') +([A-Z]+) *' + rgxConnector + 
					' *\\1,? +([A-Z]+)$';
shared rgxLFaLF1 := '^(' + rgxLast + ') +([A-Z]+) *' + rgxConnector + 
					' *(' + rgxLastStrong + ') +([A-Z]+)$';
// dual L F & L F M
shared rgxLFaLFM2 := '^(' + rgxLast + ') +([A-Z]+) *' + rgxConnector + 
					' *(' + rgxLast + ') +([A-Z]+) +([A-Z]+)$';
// dual L F & F Mi Mi
shared rgxLFaFMiMi := '^(' + rgxLast + ') +([A-Z]+) *' + rgxConnector + 
					' *(' + rgxLast + ') +([A-Z]) +([A-Z])$';
// dual L F & L F M
shared rgxLFaLFM := '^([A-Z]{2,}) +([A-Z]+) *' + rgxConnector + 
					' *\\1 +([A-Z]+) +([A-Z]+)$';
// dual F M S & F M L
shared rgxFMSaFML := '^([A-Z]+) +([A-Z]+) +' + rgxSuffix + ' *' + rgxConnector + 
					' *([A-Z]+) +([A-Z]+) +(' + rgxLast + ')$';
// dual F M & F L S
shared rgxFMaFLS := '^([A-Z]+) +([A-Z]+) *' + rgxConnector + 
					' *([A-Z]+) +(' + rgxLast + ') +' + rgxSuffix + '$';
// dual L F & F M S
shared rgxLFaFMS := '^(' + rgxLast + ') +([A-Z]+) *' + rgxConnector + 
					' *([A-Z]+) +([A-Z]+) +' + rgxSuffix + '$';

// dual L F & F
shared rgxLFaF := '^(' + rgxLast + ') +' + rgxBasicX + ' *' + rgxConnector + ' *' + rgxHyphenated + '$';
shared rgxLFaFS := '^(' + rgxLast + ') +' + rgxBasicX + ' *' + rgxConnector +
					' *' + rgxHyphenated + ' +' + rgxSureSuffix + '$';
shared rgxLFiaFiL := '^' + rgxBasic + ' +([A-Z]) *' + rgxConnector + ' *([A-Z]) +' + rgxBasic + '$';
shared rgxFiMiaFiL := '^([A-Z]) +([A-Z]) *' + rgxConnector + ' *([A-Z]) +(' + rgxLast + ')$';
shared rgxLFiaFiMi := '^' + rgxBasic + ' +([A-Z]) *' + rgxConnector + ' *([A-Z]) +([A-Z])$';
shared rgxLFiaFi := '^(' + rgxLast + ') +([A-Z]) *' + rgxConnector + ' *' + '([A-Z])$';
shared rgxLFiMiaFiMi := '^(' + rgxLast + ') +([A-Z]) +([A-Z]) *' + rgxConnector + 
					' *' + '([A-Z]) +([A-Z])$';
// dual L F & F M
//shared rgxLFaFM := '^(' + rgxLast + ') +([A-Z-]+) *' + rgxConnector + ' *([A-Z-]+) +' + rgxBasic + '( +[A-Z]+)?$';
shared rgxLFaFM := '^(' + rgxLast + ') +([A-Z-]+) *' + rgxConnector + ' *([A-Z-]+) +' + rgxHyphenated + '$';
shared rgxFSaFL := '^([A-Z]+) +' + rgxSureGen + ' *' + rgxConnector + ' *([A-Z-]+) +(' + rgxLast + ')$';
shared rgxFLaFM := '^' + rgxBasic + ' +(' + rgxLastStrong + ') *' + rgxConnector + ' *' + rgxBasic + '( +([A-Z]+))?$';
shared rgxLFaLcF := '^(' + rgxLast + ') +' + rgxBasic + ' *' + rgxConnector + ' *(' + rgxLast + '), *' + rgxBasic + '$';
shared rgxFMiaFL := '^' + rgxBasicX + ' +([A-Z]) *' + rgxConnector + ' *' + rgxBasicX + ' +(' + rgxLast + ')$';
shared rgxFMaFL := '^' + rgxBasicX + ' +([A-Z]+) *' + rgxConnector + ' *' + rgxBasicX + ' +(' + rgxLast + ')$';
// dual F L & F L
shared rgxFLaFL := '^' + rgxBasic + ' +(' + rgxLast + ') *' + rgxConnector + ' *' + rgxBasic + ' +\\2$';
// dual L F & F L
shared rgxLFaFL := '^' + rgxBasic + ' +' + rgxBasic + ' *' + rgxConnector + ' *' + rgxBasic + ' +\\1$';


shared rgxLFMaFML := 
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+ )?'+ rgxConnector + ' *([A-Z]+) +([A-Z]+ )?\\1$';
shared rgxFMLaFML := 
'^' + rgxBasic + ' +' + '([A-Z]+) +(' + rgxLast + ') *'+ rgxConnector + ' *([A-Z]+) +([A-Z]+) +\\3$';
shared rgxFMLaFML2 := 
'^' + rgxBasic + ' +' + '([A-Z]+) +(' + rgxLast + ') *'+ rgxConnector + ' *([A-Z]+) +([A-Z]+) +([A-Z]+)$';
shared rgxFMLcFML := 
'^' + rgxBasic + ' +' + '([A-Z]+) +(' + rgxLast + ') *, *([A-Z]+) +([A-Z]+) +([A-Z]+)$';
shared rgxLFMaLFM := 
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *\\1,? +([A-Z]+)( +([A-Z]+))?$';
shared rgxLFMaLFM2 := 	// unique last names
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *(' + rgxLast + ') +([A-Z]+) +([A-Z]+)$';
//'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *([A-Z]{2,}) +([A-Z]+) +([A-Z]+)$';
shared rgxLFMaLFM2S := 	// unique last names
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *([A-Z]{2,}) +([A-Z]+) +([A-Z]+) +' + rgxSuffix + '$';
shared rgxLFMaFMS := 
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *([A-Z]{2,}) +([A-Z]+) +' + rgxSureGen + '$';
shared rgxLFMaFiMiL := 	// unique last names
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *([A-Z]) +([A-Z]+) +([A-Z]{2,})$';
shared rgxLFMaFiMiI := 	
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *([A-Z]) +([A-Z]) +([A-Z])$';
shared rgxLFMaFMiI := 	
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *([A-Z]{2,}) +([A-Z]) +([A-Z])$';
shared rgxFMLaIFI := 
'^' + rgxBasic + ' +' + '([A-Z]+) +(' + rgxLast + ') *'+ rgxConnector + ' *([A-Z]) +([A-Z]{2,}) +([A-Z])$';
shared rgxFLSaIFI := 
'^' + rgxBasic + ' +(' + rgxLast + ') +' + rgxGen + ' *'+ rgxConnector + ' *([A-Z]) +([A-Z]{2,}) +([A-Z])$';
shared rgxLFMiaIFI := 
'^' + rgxBasic + ' +' + '([A-Z]+) +([A-Z]) *'+ rgxConnector + ' *([A-Z]) +([A-Z]{2,}) +([A-Z])$';
shared rgxFMLSaFML := 
'^' + rgxBasic + ' +' + '([A-Z]+) +(' + rgxLast + ') +' + rgxGen + ' *'+ rgxConnector +
	' *([A-Z]+) +([A-Z]+) +([A-Z]{2,})$';
shared rgxLFMSaFML := 
'^(' + rgxLast + ') +' + '([A-Z]+) +([A-Z]+) +' + rgxGen + ' *'+ rgxConnector +
	' *([A-Z]+) +([A-Z]+) +(\\1)$';


shared rgxLcFMM :=
'^(' + rgxLast + ') *, *([A-Z]+) +([A-Z]+) +([A-Z]+)$';
shared rgxLcSFM :=
'^(' + rgxLast + ') *, *' + rgxSureGen + ' +([A-Z]+)( +([A-Z]+))?$';

shared rgxLFMi := '^(' + rgxLast + ') +([A-Z]+) +([A-Z])$';
shared rgxLFiMi := '^(' + rgxLast + ') +([A-Z]) +([A-Z])$';

shared rgxLFMMi :=
'^(' + rgxLast + ') +([A-Z]+) +([A-Z]+) +([A-Z])$';

shared rgxLFMiS := 
'^(' + rgxLast + ') +' + rgxBasic + ' +([A-Z]),? +' + rgxSuffix + '$';
shared rgxLFSM := 
'^(' + rgxLast + ') +' + rgxBasic + ' +' + rgxSureGen + ' +([A-Z]+)$';


shared rgxLcFaF := '^(' + rgxLast + ') *, *([A-Z]+) *' + rgxConnector + ' *([A-Z][A-Z-]*)$';
shared rgxLcFaFM := '^(' + rgxLast + ') *, *([A-Z-]+) *' + rgxConnector + ' *([A-Z][A-Z-]*) +([A-Z]+)( +[A-Z]+)?$';

shared rgxFMLaFM := 
		'^' + rgxHyphenated + ' +([A-Z]+) +(' + rgxLast + ') *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +([A-Z]+))?$';
shared rgxLFMaFM := 
//'^(' + rgxLast + ') +([A-Z]+) +([A-Z]+) *'+ rgxConnector + ' *' + rgxHyphenated + '( +[A-Z]+)?$'; // used to be rgxLastStrong
'^(' + rgxLast + ') +' + rgxHyphenated + ' +([A-Z]+) *'+ rgxConnector + ' *' + rgxHyphenated + '( +([A-Z]+))?$'; // used to be rgxLastStrong
shared rgxFMLaFL := 
		'^' + rgxBasic + ' +([A-Z]+) +(' + rgxLast + ') *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +\\3?$';
shared rgxFMiSaFL := 
		'^' + rgxBasic + ' +([A-Z]) +' + rgxGen + ' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +(' + rgxLast + ')$';
shared rgxLFiSaI := 
		'^(' + rgxLast + ') +([A-Z]) +' + rgxGen + ' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z])$';
shared rgxLSFaFM := 
		'^(' + rgxLast + ') +' + rgxSureGen + '[ ,]+' + rgxBasic + ' *' + rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +[A-Z]+)?$';
shared rgxLSFMaFM := 
		'^(' + rgxLast + ') +' + rgxSureGen + '[ ,]+' + rgxBasic + ' +' + rgxBasic + ' *' + rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +[A-Z]+)?$';
shared rgxFLSaFM := 
		'^' + rgxBasic + ' +(' + rgxLast + ') +' + rgxSureGen + ' *' + rgxConnector + 
	/* name 2*/	' *([A-Z]+)( +([A-Z]+))?$';
shared rgxFaFML := 
		'^' + rgxBasicX + ' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+|[A-Z]+-[A-Z]+) +([A-Z]+|[A-Z]+ [A-Z]) +(' + rgxLast + ')$';
shared rgxFaFMLS := 
		'^' + rgxBasic + ' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+) +(' + rgxLast + ') +' + rgxGen + '$';
shared rgxFMaFMLS := 
		'^' + rgxBasic + ' +([A-Z])+ *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+) +(' + rgxLast + ') +' + rgxGen + '$';
shared rgxFaFLS := 
		'^' + rgxFirst + ' *'+ rgxConnector + 
	/* name 2*/	' *' + rgxFirst + ' +(' + rgxLast + ') +' + rgxGen +'$';
shared rgxFiaFiL := 
		'^([A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]) +(' + rgxLast + ')$';
shared rgxFaFL := 
		'^' + rgxFirst + ' *'+ rgxConnector + 
	/* name 2*/	' *' + rgxFirst + ' +(' + rgxLast + ')$';
shared rgxLFMiaFM := 
		'^(' + rgxLast + ') +([A-Z]+) +([A-Z]) *'+ rgxConnector + 
	/* name 2*/	//' *([A-Z-]+) +([A-Z]+)$';  // may be LFMiaFL
	/* name 2*/	' *([A-Z-]+) +(' + rgxLast +')$';
	
shared rgxLFMiaF := 
		'^(' + rgxLast + ') +([A-Z]+) +([A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z-]+)$';
shared rgxFMiaFMiL := 
		'^([A-Z]+|[A-Z]+-[A-Z]+) +([A-Z]|[A-Z] [A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+|[A-Z]+-[A-Z]+) +([A-Z]) +(' + rgxLast + ')$';
shared rgxLFaFMiS := 
		'^(' + rgxLast + ') +([A-Z]|[A-Z] [A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+|[A-Z]+-[A-Z]+) +([A-Z]) +' + rgxGen + '$';
shared rgxFMiaFMiMiL := 
		'^([A-Z]+) +([A-Z]|[A-Z] [A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z] +[A-Z]) +(' + rgxLast + ')$';
shared rgxLFMaLFMS := 
		'^(' + rgxLast + ') +([A-Z]+) +([A-Z]|[A-Z] [A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *(' + rgxLast + ') +([A-Z]+) +([A-Z]+) +' + rgxGen + '$';
shared rgxLFMiaFMiL := 
		'^(' + rgxLast + ') +([A-Z]+) +([A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]) +(' + rgxLast + ')$';
shared rgxLcFSaFMM := 
		'^(' + rgxLast + ') *, *' + '([A-Z]+) +' + rgxSureGen +' *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+)( +[A-Z]+)?$';
shared rgxLcFMaFMM := 
		'^(' + rgxLast + ') *, *' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+)( +[A-Z]+)?$';
shared rgxLcSFaFMM := 
		'^(' + rgxLast + ') *, *' + rgxSureGen + ' +([A-Z]+) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+)( +[A-Z]+)?$';
shared rgxLcFMiMiaFMM := 
		'^(' + rgxLast + ')[ ,]+' + '([A-Z-]+) +([A-Z]) +([A-Z]) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z-]+)( +[A-Z]+)?( +[A-Z]+)?$';
shared rgxLcFMaF := 
		'^(' + rgxLast + ') *, *' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+)$';
shared rgxLcFMaFMS := 
		'^(' + rgxLast + ') *, *' + '([A-Z]+) +([A-Z]+) *'+ rgxConnector + 
	/* name 2*/	' *([A-Z]+) +([A-Z]+) +' + rgxSuffix + '$';

shared rgxLcFMSaFMM := 
'^(' + rgxLast + '), *([A-Z]+) +([A-Z]+)[, ]+' + rgxGen + ' *' + rgxConnector +
	/* 2nd name */			' *([A-Z]+)( +[A-Z]+)?( +[A-Z]+)?$';
shared rgxLFMSaFMM := 
'^(' + rgxLast + ') +([A-Z]+) +([A-Z]+) +' + rgxSuffix + ' *' + rgxConnector +
	/* 2nd name */			' *([A-Z]+)( +[A-Z]+)?( +[A-Z]+)?$';
shared rgxLcFMaLcF := 
'^(' + rgxLast + '), *([A-Z]+) +([A-Z]+) *' + rgxConnector +
	/* 2nd name */			' *(' + rgxLast + '), *([A-Z]+)$';
shared rgxLcFMaLcFM := 
'^(' + rgxLast + '), *([A-Z]+) +([A-Z]+)? *' + rgxConnector +
	/* 2nd name */			' *(' + rgxLast + '), *([A-Z]+) +([A-Z]+)$';
shared rgxLcFMSaLcFM := 
'^(' + rgxLast + '), *([A-Z]+) +([A-Z]+) +' + rgxSuffix + ' *' + rgxConnector +
	/* 2nd name */			' *(' + rgxLast + '), *([A-Z]+) +([A-Z]+)$';
shared rgxLcFMaLcFS := 
'^(' + rgxLast + '), *([A-Z]+) +([A-Z]+) *' + rgxConnector +
	/* 2nd name */			' *(' + rgxLast + '), *([A-Z]+) +' + rgxSuffix + '$';
shared rgxLcFaLcF := 
'^(' + rgxLast + '), *([A-Z]+) *' + rgxConnector +
	/* 2nd name */			' *(' + rgxLast + '), *([A-Z]+)$';
shared rgxLcFaLcFM := 
'^(' + rgxLast + '), *([A-Z]+) *' + rgxConnector +
	/* 2nd name */			' *(' + rgxLast + '), *([A-Z]+) +([A-Z]+)$';

shared rgxLcF := 
'^(' + rgxLast + ') *, *' + rgxBasic + '$';
shared rgxLcFS := 
'^(' + rgxLast + ') *, *' + rgxBasic + ' +' + rgxSureSuffix + '$';
shared rgxLcFMS	:=
'^(' + rgxLast + ') *, *' + rgxBasic + ' +' + rgxBasic + ' +' + rgxSuffix + '$';
shared rgxLcFM	:=
'^(' + rgxLast + ') *, *' + rgxFirst + ' +' + rgxBasicX + '$';
shared rgxFccL := 	// missing middle name
'^([A-Z]+),,(' + rgxLast + ')$';

shared rgxLcTF := 
'^(' + rgxLast + ') *, *' + rgxTitles + ' +' + rgxBasic +'$';


//shared rgxLLcFM := '^([A-Z]+) +([A-Z]{2,}) *, *([A-Z]+)( +[A-Z]+)?$';
//shared rgxLLcFM := '^(' + rgxLast + ') +(' + rgxLast+ ') *, *([A-Z]+)( +[A-Z]+)?$';
shared rgxLLcFM := '^(' + rgxLast + ') +(' + rgxLast+ ') *, *([A-Z]+)( +(' + rgxLastI + '))?$';
shared rgxLLcFS := '^(' + rgxLast + ') +(' + rgxLast+ ') *, *([A-Z]+) +' + rgxSureSuffix + '?$';

shared rgxLcFhF := 		// hyphenated first name (Taiwanese or Hong Kong style)
'^([A-Z]+) *, *([A-Z]+-[A-Z]+)$';

shared rgxLScFM := '^(' + rgxLast + ') +' + rgxSuffix + ' *, *'  + rgxBasic + ' +' + rgxBasic + '$';
shared rgxLSFM := '^(' + rgxLast + ') +' + rgxSureGen + ' +'  + rgxBasic + '( +' + rgxBasic + ')?$';
shared rgxLScF := '^(' + rgxLast + ') +' + rgxGen + ' *, *'  + rgxBasic + '$';
shared rgxLScFMM := '^(' + rgxLast + ') +' + rgxSuffix + ' *, *'  + rgxBasic + ' +([A-Z]+ +[A-Z]+)$';

shared rgxFMiL := '^' + rgxBasic + ' +([A-Z]) +('  + rgxLast + ')$';
shared rgxFMiLI := '^' + rgxBasic + ' +([A-Z]) +('  + rgxLast + ') +([A-Z])$';
shared rgxFMiLS := '^' + rgxBasic + ' +([A-Z]) +('  + rgxLast + ') +' + rgxSuffix + '$';

// Fx L L	extended Spanish names: 'MARIA DE JESUS GARCIA LOPEZ';
//shared rgxFxLL := '^([A-Z]+ +DE +[A-Z]+) +[A-Z]+ +([A-Z]+)$';
shared rgxFxLL := '^([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+) +[A-Z]{2,} +([A-Z]{2,})$';
shared rgxFxL := '^([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+) +([A-Z]+)$';
shared rgxFxLS := '^([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+) +([A-Z]+) +' + rgxSuffix + '$';
shared rgxLxFM := '^([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+) +' + rgxBasic + ' +([A-Z]+)$';

shared rgxSpanishLName1 := '([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+)';

// Fi I I L
shared rgxFiIIL := '^([A-Z]) +[A-Z] +[A-Z] +(' + rgxLast + ')$';

// S F L
shared rgxSFL := '^' + rgxSureGen + ' +' + rgxBasic + ' +(' + rgxLast + ')$';
// F S L
shared rgxFSL := '^' + rgxBasic + ' +' + rgxSureGen + ' +(' + rgxLast + ')$';

// Spanish style name (LOPEZ Y PEREZ)
shared rgxFMLyL := '^([A-Z]+) *([A-Z]+)? +(([A-Z]{3,}) +Y +([A-Z]{3,}))$';

// Special case: MR and MRS
shared rgxMrMrs := '\\b((MR|DR) (&|AND)? (MRS|MS))\\b';

// comma separated names
shared rgxLcFMcS := 	// LcFMcS
'^(' + rgxLast + ') *, *' + rgxBasic + ' +' + rgxBasic + ' *, *' + rgxSuffix + '$';
shared rgxLcFcS := 		// LcFcS
'^(' + rgxLast + ') *, *' + rgxBasic + ' *, *' + rgxSureGen + '$';
shared rgxLcFcM := 		// LcFcM
'^(' + rgxLast + ') *, *' + rgxBasic + ' *, *' + rgxBasic + '$';
shared rgxFcMcL := 		// F,M,L
'^' + rgxBasic + ' *, *' + rgxBasic + ' *, *(' + rgxLastStrong + ')$';
shared rgxFoLcMcL := '^([A-Z]+) *, *([A-Z]+) *, *([A-Z]+)$';
shared rgxLcFcMS := 	// LcFcMS
'^(' + rgxLast + ') *, *' + rgxBasic + ' *, *' + rgxBasic + ' +' + rgxSuffix + '$';
shared rgxLcFcMcS := 	// LcFcMcS
'^(' + rgxLast + ') *, *' + rgxBasic + ' *, *' + rgxBasic + ' *, *' + rgxSuffix + '$';
shared rgxLcScF := 	// LcScF
'^(' + rgxLast + ') *, *' + rgxSuffix + ' *, *'  + rgxBasic + '$';
shared rgxLcScFM := 	// LcScFM
'^(' + rgxLast + ') *, *' + rgxSuffix + ' *, *'  + rgxBasic + ' +' + rgxBasic + '$';

// found in property
shared rgxLScFMaFML := '^([A-Z]+) (JR|SR|II|III), *([A-Z]+)( ([A-Z]))? *' + rgxConnector +
												' *([A-Z]+) (([A-Z]+) )?(\\1)( (JR|SR|II|III))?$';


// special
shared rgxLLaL := '^(' + rgxLast + ') +(' + rgxLast + ') *' + rgxConnector + ' *(' + rgxLast + ')$';

// partial name formats:
shared rgxL := '^(' + rgxLast + ')$';
shared rgxFMi := '^([A-Z])+ +([A-Z])$';
shared rgxLS := '^(' + rgxLast + ') +' + rgxSureSuffix + '$';



shared nmn := ['NMI','NMN'];
		
export NameFormat := ENUM(integer2, NoName=0,
	// single name formats
		FL, LF, LFM, FLorLF, FLcS, FLS, LFS, FLSorLFS, LFMi, LFiMi, FML, FMLorLFM, ILI, FMLSorLFMS, FMLcS, FMcSL, LFMS, LcFMS, LScF,
		LScFM, LScFMM, LSFM, FMLLS, FMSL, LcFMM, LcSFM, LFMMi, FccL, LFSM,
		FiL, FiML, FiMLS, FiLS, FLL, FLLS, FMLL, FMML, FMiMiL, LFMiM, LFMiMi, FMMLS, LFcMi, LcF, LcFS, LcFM, LcTF, LFMiS, LFi, LFiS,
		LLcFM, LLcFS, LcFhF, FMiL, FMiLS, FMiLI, FiIIL, FxLL, FxL, FxLS, LxFM, SFL, FSL, FMLyL,
		LFMicS, FMLcIII, LcFMcS, FcMcL, FoLcMcL, LcFcM, LcFcMS, LcFcMcS, LcFcS, LcScF, LcScFM,
	// partial name formats
		L,LS,
	// dual name formats
		LFaF, LFaFS, LFiaFi, LFiaFiL, FiMiaFiL, LFiaFiMi, LFiMiaFiMi, LFaFM, FSaFL, FLaFM, FLaFL, LFaFL, FMiaFL, FMaFL, FMLaFM, LFMaFM, FMLaFL, FMiSaFL, LFiSaI, LSFaFM, LSFMaFM, FLSaFM,
		LFMiaFM, LFMiaF,
		LcFMaF, LcFMaFMM, LcSFaFMM, LcFMiMiaFMM, LcFMaFMS, LFMaFML, FMLaFML, FMLaFML2, FMLcFML, LFMaLFM, LFMaLFM2, LFMaLFM2S, LFMaFMS, LFMaFiMiL,
		LFMaFiMiI, LFMaFMiI, FMLaIFI, FLSaIFI, LFMiaIFI, FMaFML, LFaLFM, LFaLFM2, LFaFMiMi, LFaLF, LFaLF1, LFaLcF, FMSaFML, FMaFLS, LFaFMS, FaFL, FiaFiL,
		FaFML, FaFMLS, FMaFMLS, FaFLS, LcFaF, LcFaFM, LcFMSaFMM, LFMSaFMM, LcFaLcF, LcFaLcFM, LcFMaLcF, 
		LcFMaLcFM, LcFMSaLcFM, LcFMaLcFS, LScFMaFML,
		FMLSaFML, LFMSaFML, LFMiaFMiL, FMiaFMiL, LFaFMiS, FMiaFMiMiL, LFMaLFMS, MrMrs
		);

	

// search order is important
// based on most common formats first
// some are order dependent
export SingleNameFormat(string s, boolean forceValid = false) := 
	IF(NOT forceValid and NameTester.InvalidNameFormat(s), NameFormat.NoName,
		MAP(
		// S F L  
		REGEXFIND(rgxSFL, s) => NameFormat.SFL,
		// F S L  
		REGEXFIND(rgxFSL, s) => NameFormat.FSL,
		// L Fi S
		REGEXFIND(rgxLFiS, s) => NameFormat.LFiS,
		// F Mi L S		
		REGEXFIND(rgxFMiLS, s) => NameFormat.FMiLS,
		// F Mi L
		REGEXFIND(rgxFMiL, s) => NameFormat.FMiL,
		// F Mi L
		REGEXFIND(rgxFMiLI, s) => NameFormat.FMiLI,
		// Fi L
		REGEXFIND(rgxFiL, s) => NameFormat.FiL,
		// L Fi
		REGEXFIND(rgxLFi, s) => NameFormat.LFi,
		// F L or L F
		REGEXFIND(rgxLS, s) => NameFormat.LS,		// eliminate name suffix 
		// F L
		REGEXFIND(rgxFL, s) => NameFormat.FL,
		REGEXFIND(rgxFLoLF, s) => NameFormat.FLorLF,
		//REGEXFIND('^[A-Z][\']?[A-Z][A-Z/-]+ +[A-Z][\']?[A-Z/-]*$', s, NOCASE) => NameFormat.FLorLF,
		// L F
		REGEXFIND(rgxLF, s) => NameFormat.LF,
		// I L I
		REGEXFIND(rgxILI, s) => NameFormat.ILI,
		// Fi L S
		REGEXFIND(rgxFiLS, s) => NameFormat.FiLS,
		// Fi M L S
		REGEXFIND(rgxFiMLS, s) => NameFormat.FiMLS,
		// Fi M L
		REGEXFIND(rgxFiML, s) => NameFormat.FiML,
		
		// F L S
		REGEXFIND(rgxFLcS, s) => NameFormat.FLcS,
		// L Fi Mi
		REGEXFIND(rgxLFiMi, s) => NameFormat.LFiMi,
		// L S F M
		REGEXFIND(rgxLSFM, s) => NameFormat.LSFM,
		// L F S M
		REGEXFIND(rgxLFSM, s) => NameFormat.LFSM,
		// L F Mi
		REGEXFIND(rgxLFMi, s) => NameFormat.LFMi,
		// F L S
		REGEXFIND(rgxFLS, s) => NameFormat.FLS,
		// L F S
		REGEXFIND(rgxLFS, s) => NameFormat.LFS,
		// L F M
		REGEXFIND(rgxLFM, s) => NameFormat.LFM,
		// F L S or L F S
		REGEXFIND(rgxFLSorLFS, s) => NameFormat.FLSorLFS,
		// L F Mi S
		REGEXFIND(rgxLFMiS, s) => NameFormat.LFMiS,
		// F L L
		REGEXFIND(rgxFLL, s) => NameFormat.FLL,
		// F L L S
		REGEXFIND(rgxFLLS, s) => NameFormat.FLLS,
		// F M L S or L F M S
		REGEXFIND(rgxFMLS, s) => NameFormat.FMLSorLFMS,
		// L F Mi, S 
		REGEXFIND(rgxLFMicS, s) => NameFormat.LFMicS,
		// F M L, I I I
		REGEXFIND(rgxFMLcIII, s) => NameFormat.FMLcIII,
		// F M L, S rgxLFMicS
		REGEXFIND(rgxFMLcS, s) => NameFormat.FMLcS,
		// F M L or L F M
		REGEXFIND(rgxFMLorLFM, s) => NameFormat.FMLorLFM,
		// F M L y L (Spanish style) 
		REGEXFIND(rgxFMLyL,s) => NameFormat.FMLyL,
		// F Mi Mi L
		REGEXFIND(rgxFMiMiL, s) => NameFormat.FMiMiL,
		// L F Mi Mi
		REGEXFIND(rgxLFMiMi, s) => NameFormat.LFMiMi,
		// L F Mi M
		REGEXFIND(rgxLFMiM, s) => NameFormat.LFMiM,
		// F M S L
		REGEXFIND(rgxFMSL, s) => NameFormat.FMSL,
		// F M L L
		REGEXFIND(rgxFMLL, s) => NameFormat.FMLL,
		// Fi I I L
		REGEXFIND(rgxFiIIL, s) => NameFormat.FiIIL,
		// F M M L
		REGEXFIND(rgxFMML, s) => NameFormat.FMML,
		// F M M L S
		REGEXFIND(rgxFMMLS, s) => NameFormat.FMMLS,

		// L F M S
		REGEXFIND(rgxLFMS, s) => NameFormat.LFMS,

		// L S, F M
		REGEXFIND(rgxLScFM, s) => NameFormat.LScFM,
		// L S, F M M
		REGEXFIND(rgxLScFMM, s) => NameFormat.LScFMM,
		// L S, F
		REGEXFIND(rgxLScF, s) => NameFormat.LScF,

		// F M L L (S)
		REGEXFIND(rgxFMLLS, s) => NameFormat.FMLLS,
		// L F M Mi
		REGEXFIND(rgxLFMMi, s) => NameFormat.LFMMi,
		// L, F
		REGEXFIND(rgxLcF, s) => NameFormat.LcF,
		// L, F S
		REGEXFIND(rgxLcFS, s) => NameFormat.LcFS,
		// L, T F
		REGEXFIND(rgxLcTF, s, NOCASE) => NameFormat.LcTF,
		// L, S F M	
		REGEXFIND(rgxLcSFM, s) => NameFormat.LcSFM,
		// L, F M S
		REGEXFIND(rgxLcFMS, s) => NameFormat.LcFMS,
		// L, F M
		REGEXFIND(rgxLcFM, s, NOCASE) => NameFormat.LcFM,
		// L, F M M	
		REGEXFIND(rgxLcFMM, s) => NameFormat.LcFMM,
		// L F, Mi
		REGEXFIND(rgxLFcMi, s) => NameFormat.LFcMi,
		// L L, F M
		REGEXFIND(rgxLLcFS, s) => NameFormat.LLcFS,
		// L L, F M
		REGEXFIND(rgxLLcFM, s) => NameFormat.LLcFM,
		// L, F-F
		REGEXFIND(rgxLcFhF, s) => NameFormat.LcFhF,
		// FxL  
		REGEXFIND(rgxFxL, s) => NameFormat.FxL,
		// Fx L S  
		REGEXFIND(rgxFxLS, s) => NameFormat.FxLS,
		// FxL L 
		REGEXFIND(rgxFxLL, s) => NameFormat.FxLL,
		// L, F M, S
		REGEXFIND(rgxLcFMcS, s) => NameFormat.LcFMcS,
		// L, S, F 
		REGEXFIND(rgxLcScF, s) => NameFormat.LcScF,
		// L, S, F M
		REGEXFIND(rgxLcScFM, s) => NameFormat.LcScFM,
		// L, F, S
		REGEXFIND(rgxLcFcS, s) => NameFormat.LcFcS,
		// L, F, M
		REGEXFIND(rgxLcFcM, s) => NameFormat.LcFcM,
		// F, M, L
		REGEXFIND(rgxFcMcL, s) => NameFormat.FcMcL,
		// F, M, L
		REGEXFIND(rgxFoLcMcL, s) => NameFormat.FoLcMcL,	
		// L, F, M S
		REGEXFIND(rgxLcFcMS, s) => NameFormat.LcFcMS,
		// L, F, M, S
		REGEXFIND(rgxLcFcMcS, s) => NameFormat.LcFcMcS,
		// Lx F M  
		REGEXFIND(rgxLxFM, s) => NameFormat.LxFM,
		// F M L 
		REGEXFIND(rgxFML, s) => NameFormat.FML,
		// F M, X L
		REGEXFIND(rgxFMcSL, s) => NameFormat.FMcSL,
		// F,,L
		REGEXFIND(rgxFccL, s) => NameFormat.FccL,
		// partial names
		REGEXFIND(rgxL, s) => NameFormat.L,
		NameFormat.NoName
	));


		// *** DUAL NAMES
DualNameFormatConnector(string s) := MAP(
		// L Fi & Fi
		REGEXFIND(rgxLFiaFi, s) => NameFormat.LFiaFi,
		// L Fi & Fi Mi
		REGEXFIND(rgxLFiaFiMi, s) => NameFormat.LFiaFiMi,	
		// Fi Mi & Fi L
		REGEXFIND(rgxFiMiaFiL, s) => NameFormat.FiMiaFiL,
		// L F & F S
		REGEXFIND(rgxLFaFS, s) => NameFormat.LFaFS,
		// L Fi & Fi L
		REGEXFIND(rgxLFiaFiL, s) => NameFormat.LFiaFiL,
		// L F & F
		REGEXFIND(rgxLFaF, s) => NameFormat.LFaF,
		// L Fi Mi & Fi Mi
		REGEXFIND(rgxLFiMiaFiMi, s) => NameFormat.LFiMiaFiMi,
		// F Mi & F L
		REGEXFIND(rgxFMiaFL, s) => NameFormat.FMiaFL,
		// L F & L F 	(dual)
		REGEXFIND(rgxLFaLF, s) => NameFormat.LFaLF,		          
		// L F & L F 	(dual)
		REGEXFIND(rgxLFaLF1, s) => NameFormat.LFaLF1,		          
		// L F & L, F 	(dual)
		REGEXFIND(rgxLFaLcF, s) => NameFormat.LFaLcF,		          
		// L F & F L
		REGEXFIND(rgxLFaFL, s) => NameFormat.LFaFL,
		// F L & F L
		REGEXFIND(rgxFLaFL, s) => NameFormat.FLaFL,
		// L F & L F M	(dual)
		REGEXFIND(rgxLFaLFM, s) => NameFormat.LFaLFM,		          
		// L F & F L
		REGEXFIND(rgxLFaFMiS, s) => NameFormat.LFaFMiS,
		// L F M & F M S	(dual)
		REGEXFIND(rgxLFMaFMS, s) => NameFormat.LFMaFMS,
		// L F Mi & F (M)	(dual)
		REGEXFIND(rgxLFMiaFMiL, s) => NameFormat.LFMiaFMiL,
		// L F (M) & F (M) L	(dual)
		REGEXFIND(rgxLFMaFML, s) => NameFormat.LFMaFML,
		REGEXFIND(rgxFMiaFMiL, s) => NameFormat.FMiaFMiL,
		REGEXFIND(rgxLFMaLFMS, s) => NameFormat.LFMaLFMS,
		REGEXFIND(rgxFMiaFMiMiL, s) => NameFormat.FMiaFMiMiL,
		
		// F S & F L	
		REGEXFIND(rgxFSaFL, s) => NameFormat.FSaFL,
		// F L & F M
		REGEXFIND(rgxFLaFM, s) => NameFormat.FLaFM,
		REGEXFIND(rgxLFaFM, s) => NameFormat.LFaFM,
		// L F & F M
//		REGEXFIND(rgxLFaFM, s) => NameFormat.LFaFM,
		// F M & F L
		REGEXFIND(rgxFMaFL, s) => NameFormat.FMaFL,
		// L F M & L F M	(dual)
		REGEXFIND(rgxLFMaLFM, s) => NameFormat.LFMaLFM,
		// F M L & I F I	(dual)
		REGEXFIND(rgxFMLaIFI, s) => NameFormat.FMLaIFI,
		// F M L & F M L	(dual)
		REGEXFIND(rgxFMLaFML, s) => NameFormat.FMLaFML,
		// F M L & F M L	(dual)
		REGEXFIND(rgxLFMaFiMiL, s) => NameFormat.LFMaFiMiL,
		// F L S & I F I	(dual)
		REGEXFIND(rgxFLSaIFI, s) => NameFormat.FLSaIFI,
		// F M L & Fi Mi L	(dual)
		REGEXFIND(rgxLFMaFMiI, s) => NameFormat.LFMaFMiI,
		// F M L & Fi Mi L	(dual)
		REGEXFIND(rgxLFMaFiMiI, s) => NameFormat.LFMaFiMiI,
		// L F Mi & I F I	(dual)
		REGEXFIND(rgxLFMiaIFI, s) => NameFormat.LFMiaIFI,
		// L F M & L F M unique las name	(dual)
		REGEXFIND(rgxLFMaLFM2, s) => NameFormat.LFMaLFM2,
		// L F M & L F M S unique las name	(dual)
		REGEXFIND(rgxLFMaLFM2S, s) => NameFormat.LFMaLFM2S,
		// L F M S & F M L	(dual)
		REGEXFIND(rgxLFMSaFML, s) => NameFormat.LFMSaFML,
		// F M L S & F M L	(dual)LFMSaFML
		REGEXFIND(rgxFMLSaFML, s) => NameFormat.FMLSaFML,
		// F M L & F M L	(dual)
		REGEXFIND(rgxLFMaFML, s) => NameFormat.LFMaFML,
		// F L S & F (M)	(dual)
		REGEXFIND(rgxFLSaFM, s, NOCASE) => NameFormat.FLSaFM,
		// L S F & F (M)	(dual)
		REGEXFIND(rgxLSFaFM, s, NOCASE) => NameFormat.LSFaFM,
		// L S F & F (M)	(dual)
		REGEXFIND(rgxLSFMaFM, s, NOCASE) => NameFormat.LSFMaFM,
		// F M L & F M L	(dual)
		REGEXFIND(rgxFMLaFML2, s) => NameFormat.FMLaFML2,
		// L F Mi & F	(dual)
		REGEXFIND(rgxLFMiaF, s) => NameFormat.LFMiaF,
		// L F Mi & F (M)	(dual)
		REGEXFIND(rgxLFMiaFM, s, NOCASE) => NameFormat.LFMiaFM,
		// L Fi S & Fi		(dual)
		REGEXFIND(rgxLFiSaI, s) => NameFormat.LFiSaI,
		// F Mi S & F L	(dual)
		REGEXFIND(rgxFMiSaFL, s) => NameFormat.FMiSaFL,
		// F M L & F L	(dual)
		REGEXFIND(rgxFMLaFL, s) AND (REGEXFIND(rgxFMLaFL, s, 3) NOT IN nmn) => NameFormat.FMLaFL,
		// L F M & F (M)	(dual)
		REGEXFIND(rgxLFMaFM, s) => NameFormat.LFMaFM,
		// F M L & F (M)	(dual)
		REGEXFIND(rgxFMLaFM, s) => NameFormat.FMLaFM,
		// L F (M) & F M S	(dual)
		REGEXFIND(rgxLcFMaFMS, s, NOCASE) => NameFormat.LcFMaFMS,
		// L F (M) & F 	(dual)
		REGEXFIND(rgxLcFMaF, s, NOCASE) => NameFormat.LcFMaF,
		// L F S & F (M) (M)	(dual)
		//REGEXFIND(rgxLcFSaFMM, s) => NameFormat.LcFSaFMM,
		// L S F & F (M) (M)	(dual)
		REGEXFIND(rgxLcSFaFMM, s) => NameFormat.LcSFaFMM,
		// L F (M) & F (M) (M)	(dual)
		REGEXFIND(rgxLcFMaFMM, s) => NameFormat.LcFMaFMM,
		// L F Mi Mi & F (M) (M)	(dual)
		REGEXFIND(rgxLcFMiMiaFMM, s) => NameFormat.LcFMiMiaFMM,
		// F M & F L S	(dual)
		REGEXFIND(rgxFMaFLS, s) => NameFormat.FMaFLS,		          
		// F M & F M L	(dual)
		REGEXFIND(rgxLFaFMS, s) => NameFormat.LFaFMS,		
		// F M S & F M L	(dual)
		REGEXFIND(rgxFMSaFML, s) => NameFormat.FMSaFML,		          
		// F M & F M L	(dual)
		REGEXFIND(rgxFMaFML, s) => NameFormat.FMaFML,		 	
		// L F & F Mi Mi	(dual)
		REGEXFIND(rgxLFaFMiMi, s) => NameFormat.LFaFMiMi,		          
		// L F & L F M	(dual)
		REGEXFIND(rgxLFaLFM2, s) => NameFormat.LFaLFM2,		          
		//REGEXFIND('^[A-Z]+([ ]+[A-Z]+[ ]*)?&[ ]*[A-Z]+[ ]+([A-Z]+[ ]+)?[A-Z][\']?[A-Z-]+$', s, NOCASE) => NameFormat.FMaFML,		          
		// F & F M L	(dual)
		//REGEXFIND('^[A-Z]+([ ]+AND[ ]+|[ ]*&[ ]*|[ ]+OR[ ]+)[A-Z]+[ ]+([A-Z]+[ ]+)?[A-Z][\']?[A-Z-]+$', s, NOCASE)
		// Fi & Fi L
		REGEXFIND(rgxFiaFiL, s) => NameFormat.FiaFiL,
		// F & F L
		REGEXFIND(rgxFaFL, s) => NameFormat.FaFL,
		// F & F L S
		REGEXFIND(rgxFaFLS, s) => NameFormat.FaFLS,		          
		// F & F M L
		REGEXFIND(rgxFaFML, s) => NameFormat.FaFML,		          
		// F & F M L S
		REGEXFIND(rgxFaFMLS, s) => NameFormat.FaFMLS,			
		// F M & F M L S
		REGEXFIND(rgxFMaFMLS, s) => NameFormat.FMaFMLS,	
		// L, F M S & F M (M)
		REGEXFIND(rgxLcFMSaFMM, s, NOCASE) => NameFormat.LcFMSaFMM,
		//REGEXFIND(rgxLast + ',[ ]?[A-Z]+ [A-Z]+[ ]+' + rgxGen + '[ ]*&[ ]*[A-Z]+([ ]+[A-Z]+)?([ ]+[A-Z]+)?$', s, NOCASE) => NameFormat.LcFMSaFMM,
		// L F M S & F M
		REGEXFIND(rgxLFMSaFMM, s, NOCASE) => NameFormat.LFMSaFMM,
		// L, F & F
		REGEXFIND(rgxLcFaF, s, NOCASE) => NameFormat.LcFaF,
		// L, F & F M (M)
		REGEXFIND(rgxLcFaFM, s, NOCASE) => NameFormat.LcFaFM,
		// L, F & L, F
		REGEXFIND(rgxLcFaLcF, s) => NameFormat.LcFaLcF,
		// L, F & L, F M
		REGEXFIND(rgxLcFaLcFM, s) => NameFormat.LcFaLcFM,
		// L, F M & L, F 
		REGEXFIND(rgxLcFMaLcF, s) => NameFormat.LcFMaLcF,
		// L, F M & L, F S
		REGEXFIND(rgxLcFMaLcFS, s) => NameFormat.LcFMaLcFS,
		// L, F M & L, F M
		REGEXFIND(rgxLcFMaLcFM, s) => NameFormat.LcFMaLcFM,
		// L, F M S & L, F M
		REGEXFIND(rgxLcFMSaLcFM, s) => NameFormat.LcFMSaLcFM,
		// L S, F M & F M L
		REGEXFIND(rgxLScFMaFML, s) => NameFormat.LScFMaFML,

		// MR & MRS
		//REGEXFIND(rgxMrMrs, s) AND
		//	SingleNameFormat(REGEXREPLACE(rgxMrMrs, s, '')) != NameFormat.NoName
		//		=> NameFormat.MrMrs,
		NameFormat.NoName
	);
	
export DualNameFormat(string s) := MAP(
		REGEXFIND(rgxConnector, s) => DualNameFormatConnector(s),
		REGEXFIND(rgxLScFMM, s) OR	// not to clash with FMLcFML
		REGEXFIND(rgxLcFMS, s) OR	// not to clash with FMLcFML
		REGEXFIND(rgxLcFMM, s) OR	// not to clash with FMLcFML
		REGEXFIND(rgxFMLcIII, s) => NameFormat.NoName,	// not to clash with FMLcFML
		REGEXFIND(rgxFMLcFML, s) => NameFormat.FMLcFML,	// F M L, F M L	(dual)
		NameFormat.NoName);

	
// determine name format so we know location of first name
// supports hyphenated last name and period after middle name
export PersonalNameFormat(string s, boolean forceValid = false) := 
	//IF(REGEXFIND('([ ]+AND[ ]+|[ ]*&[ ]*)', s, NOCASE), DualNameFormat(s), SingleNameFormat(s));
	//IF(REGEXFIND(rgxConnector, s), DualNameFormat(s), SingleNameFormat(s));
	MAP(
		Not forceValid and NameTester.InvalidNameFormat(s) => NameFormat.NoName,
		REGEXFIND(rgxConnector, s) => DualNameFormat(s),
		REGEXFIND(rgxLScFMM, s) => NameFormat.LScFMM,	// not to clash with FMLcFML
		REGEXFIND(rgxLcSFM, s) => NameFormat.LcSFM,	// not to clash with FMLcFML
		REGEXFIND(rgxLcFMS, s) => NameFormat.LcFMS,	// not to clash with FMLcFML
		REGEXFIND(rgxLcFMM, s) => NameFormat.LcFMM,	// not to clash with FMLcFML
		REGEXFIND(rgxFMLcIII, s) => NameFormat.FMLcIII,	// not to clash with FMLcFML
		REGEXFIND(rgxFMLcFML, s) => NameFormat.FMLcFML,
		SingleNameFormat(s, forceValid)
	);
	

export boolean IsDualNameFormat(string s) := PersonalNameFormat(s) >= NameFormat.LFaF;
export boolean IsNameFormatDual(integer2 n) := (n >= NameFormat.LFaF);
export boolean validPersonNameFormat(integer2 n) := (n != NameFormat.NoName) AND (NOT IsNameFormatDual(n));
export boolean validNameFormat(string s) := PersonalNameFormat(s) != NameFormat.NoName;

shared InvalidFormat := ENUM(integer2, NotInvalid=0,
	L,		// Last name only  van damme	
	FMi,	// first middle initial Mary J
	LS,		// name suffix	Tom JR, Smith Sr
	TL,		// title name MR Smith
	LT		// name titles Smith, MR and Mrs
	);

rgxTL := 
		'^' + rgxTitles + ' +(' + rgxLast + ')$';
rgxLT := '^(' + rgxLast + '),? +((MR|DR) (&|AND)? (MRS|MS))$';

shared InvalidNameFormat(string s) := MAP(
		REGEXFIND(rgxL, s) => InvalidFormat.L,
		REGEXFIND(rgxFMi, s) => InvalidFormat.FMi,
		REGEXFIND(rgxLS, s) => InvalidFormat.LS,
		REGEXFIND(rgxTL, s) => InvalidFormat.TL,
		REGEXFIND(rgxLT, s) => InvalidFormat.LT,
		InvalidFormat.NotInvalid
		);


export IsSuffix(string name) := REGEXFIND('^'+rgxSuffix+'$',name);
// uninclude suffixes that could possibly be names
export IsSureSuffix(string name) := REGEXFIND('^'+rgxSureSuffix+'$',name);
export HasSuffix(string name) := REGEXFIND(rgxFMLS,name) OR REGEXFIND(rgxFLSorLFS,name);

export IsGeneration(string name) := 
	TRIM(name,LEFT,RIGHT) IN ['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
export IsSureGen(string name) := 
	TRIM(name,LEFT,RIGHT) IN ['JR','SR','II','III','IV','VI','VII','VIII','IX'];

// determine if name may be multi-part last name
shared boolean IsLastNameOnly(string name) := RegexFind('^' + rgxLastStrong + '$', name);
export boolean IsJustLastName(string name) := 
	IF(RegexFind('^' + rgxLastStrong + '$', name),
		NOT NameTester.IsFirstName(RegexFind('^([A-Z]+) +', name, 1)) and NOT NameTester.IsLoPctFirstName(RegexFind('^([A-Z]+) +', name, 1)),
		false);

shared ShortLastNames := ['NG','OK','OX','UI','KU','DO','JO','RO','UX','KRCH','LI'];
shared BadLastNames := ['ASS','AV','NMN','NMI','NLN','ERROR', 'RET','RE','XX','XY','OR','ET','AKA',
							'MC','ST','HW','FR','CH','SM','ME','AS','LC','EST','COC','NT','PUSSY','BASTARD','BITCH'];

export boolean InvalidLastName(string name) := 
	Length(name) < 2 OR
	Length(name) > 25 OR
	IsSureSuffix(name) OR		// don't consider suffixes as last names
	REGEXFIND('^[A-Z]-[A-Z]$',name) OR		// A-B
	name in  BadLastNames OR
	(name not in ShortLastNames AND REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{2,}$',name)) 
	OR NameTester.IsBusinessWord(name);

// should replace InvalidLastName when tested
export boolean InvalidLastName1(string name) := 
	Length(name) < 2 OR
	Length(name) > 25 OR
	IsSureSuffix(name) OR		// don't consider suffixes as last names
	REGEXFIND('^[A-Z]-[A-Z]$',name) OR		// A-B
	name in  BadLastNames OR
	(name not in ShortLastNames AND REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{2,}$',name)) 
	;
// likely last name

export boolean IsLastNameEx(string name) := MAP(
	Length(name) < 2 => false,
	IsSureSuffix(name) => false,
	//IsCensusName(name) => true,
	NameTester.IsLastName(name) => true,
	IsLastNameOnly(name) => true,
	SpanishNames.IsSpanishSurname(name) => true,
	IndianNames.IsIndianSurname(name) => true,
	ArabicNames.IsArabicSurname(name) => true,
	OrientalNames.IsOrientalSurname(name) => true,
	JapaneseNames.IsJapaneseSurname(name) => true,
	name IN ShortLastNames => true,
	name in  BadLastNames => false,

	REGEXFIND('[A-Z]+(WITZ|WICZ|WISCH|SKI|SKIY|SKY|TZKY|VICH|VITCH|VICZ|VITZ|STEIN|SHTEIN|STEAD|STAD|FELD|BACH|MAN|MANN|DOLPH|IAK|OV|OVIC|ROFF|DORF|LIEB|HAUSEN|SCHI|SCHE|SCHO|EVA|OVA|KAYA|ACK|TZKY|ZYK|RECHT|SCHLING|CHUK|ENKO|SHKIN|EK|ESCU|EANU|GONZA|VANDE|QUIST|BAUM)$',name) => true,	// east european endings
	REGEXFIND('[A-Z](OULOS|OYLOS|ELLIS|IDIS|IADIS|OUDAS|OUKAS|AKIS|OUSIS|SIOS|KONIS|OTIS|ATOS|ITIS)$',name) => true,	// greek endings
	REGEXFIND('^(KARA|PAPA|KONDO|SCHN|STEIN)[A-Z]{2,}$',name) => true,		// greek & otherprefixes
	REGEXFIND('[A-Z]{2,}(SON|SEN|FIELD|SHIRE|BERG|BERRY|BERY|BURG|BURY|CROFT|NESS|WELL|INGTON|ELLS|LAND|WARD|FORD|BODY|DALE|OY|ER|TOM|TRY|ARTON|SHAW|DOTTIR|IAMS|VAND|VILL|WILL|WIRTH)$',name)
						AND NOT NameTester.IsFirstName(name) => true,		// anglo endings
	REGEXFIND('[A-Z](SWAMY|NKA|OOD|UZ|MURTI|MADI|REVA|REZA|ERJEE|ARJUNA|YAMA|IAN|TULLA)$',name) => true,				// asian endings
	REGEXFIND('[B-DF-HJ-NP-TVWXZ](EZ|ES|IZ)$',name) => true,	// possible spanish name
	//REGEXFIND('[B-DF-HJ-NP-TVWXZ](ITO|ELLI|ANO|ONA|TINI|ACCI|ETTO|COLA|ENCIO|ENZO|ENTO|ETTI|AGNI|ISTA|UCCI|UZZO|DELLA)$',name) AND NOT NameTester.IsFirstName(name) => true,	// possible italian name
	REGEXFIND('[A-Z](ITO|ELLI|ANO|ONA|TINI|ACCI|ETTO|COLA|ENCIO|ENZO|ENTO|ETTI|AGNI|ISTA|UCCI|UZZO|DELLA)$',name) AND NOT NameTester.IsFirstName(name) => true,	// possible italian name
	REGEXFIND('[B-DF-HJ-NP-TVWXZ]{7,}',name) => false,	// consecutive consonants
	name[1] = 'O' AND NameTester.IsLastName(name[2..]) => true,
	NameTester.IsLastName(REGEXFIND('^(O|DU|VAN|DE|DI)([A-Z]{2,})$',name,2)) AND name <> 'DEBORAH' => true,
	//name[1..2] = 'MC' AND IsLastName(name[3..]) => true,
	REGEXFIND('^(MAC|MC)[A-Z]{2,}$',name) => true,		// scottish prefixes
	//REGEXFIND('[B-DF-HJ-NP-TVWXZ](A|E|I|O)$',name) AND NOT IsFirstName(name) => true,	// possible name ending
	REGEXFIND('^[A-Z]-[A-Z]$',name) => false,		// A-B
	REGEXFIND(rgxSpanishLName1, name) => true,
	REGEXFIND('^(AL|ABD|ABDUL|BAR|BEN|BOU|EL|ST)[ -][A-Z]+', name) => true,		// arabic/hebrew name: AL-ARABI
	REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{3,}$',name) => false,
	REGEXFIND('^[A-Z]{3,}(JR|SR)$',name) => NameTester.IsLastName(REGEXFIND('^([A-Z]+)(JR|SR)$',name,1)),
	false);
/*
shared rgxHyphenatedname := '^([A-Z]\'?[A-Z]+)-([A-Z]\'?[A-Z]+)$';
	

shared rgxDoubledName := '^([A-Z]+) ([A-Z]+)$';
	
export boolean IsLastNameDoubled(string name) := 
	IF(REGEXFIND(rgxDoubledName,name),
			REGEXFIND(rgxDoubledName, name, 1) in ['AL', 'BEN', 'DA','DE','DEL','LA','MC','ST','VAN','VON']
			OR IsLastNameEx(REGEXFIND(rgxDoubledName, name, 1))
			OR IsLastNameEx(REGEXFIND(rgxDoubledName, name, 2)),		
		false);
*/
shared boolean ProbableFirstName(string name) :=
	NameTester.IsFirstName(name) AND NOT NameTester.IsLastName(name);
	
	
/*	
shared boolean IsLastNameHyphenated(string name) := 		//REGEXFIND(rgxHyphenatedname, name);
				IF(StringLib.StringFind(name, '-', 1) > 0,
					REGEXFIND('^(AL|ABDUL|BAR|BEN|BOU|EL)-[A-Z]+', name)
					OR IsLastNameEx(REGEXFIND(rgxHyphenatedname, name, 1))
					OR IsLastNameEx(REGEXFIND(rgxHyphenatedname, name, 2)),
					false);
					
export boolean IsLastNameExOrHyphenated(string name) := 
	IsLastNameHyphenated(name) OR		
		IsLastNameEx(name);
*/
shared rgxDoubleName := '^([A-Z]\'?[A-Z]+)( |-)([A-Z]\'?[A-Z]+)$';
export boolean IsDoubleLastName(string name) :=
					IsLastNameEx(REGEXFIND(rgxDoubleName, name, 1))
							OR IsLastNameEx(REGEXFIND(rgxDoubleName, name, 3));
							
export boolean IsLastNameExOrHyphenated(string name) := 
		IsLastNameEx(name) OR
	      IsDoubleLastName(name);		

export boolean ProbableLastName(string name) := 
	IsLastNameEx(name) OR IsDoubleLastName(name) OR NOT NameTester.IsFirstName(name);
//	IsLastNameExOrHyphenated(name) OR IsLastNameDoubled(name) OR NOT NameTester.IsFirstName(name);
	
export boolean IsLastNameConfirmed(string name) := 
	IF(Length(name) < 2 OR
	IsSureSuffix(name),false,			// don't consider suffixes as last names
	IF(IsLastNameEx(name) OR
		//IsLastNameOnly(name) OR
		//IsLastNameHyphenated(name) OR
		IsDoubleLastName(name)
		, true,
	false));
	
shared boolean RepeatedLetters(string name) :=
	REGEXFIND('\\b([A-Z])\\1{2,}\\b', name);
	
shared rgxLastReversed := 	// VAN DELA DOS LE DU LA
	'^([A-Z]+) +(DI|DA|DEL|DES|DE|MC|VON|ST|EL)$';
		
shared rgxConsonants := '\\b([B-DF-HJ-NP-TVWXZ]{3,})\\b';	
/*shared boolean ValidateConsonants(string name) := MAP(
		REGEXFIND('\\b' + rgxHonor + '\\b', name) => true,	// could be a honor
		IsLastNameEx(name) => true,		// strange last name
		SpecialNames.IsAbbreviation(name) => false,		// on our restricted list
		NameTester.IsFirstName(name) => true,		// misspelled first name
		name in ['NFN','NMN']
		);
	
/*	
export boolean InvalidNameFormat(string name) := MAP(
	REGEXFIND('^[A-Z]+ +(JR|SR|NMN|NMI|II|III|IV)$', name)	=> true,	// NAME JR
	REGEXFIND('^[A-Z] +[A-Z] +(JR|SR|I|II|III|IV|V)$', name)	=> true,	// A B JR
	REGEXFIND('^(JR|SR|MC|ST|NMN|NMI|ATTN) +[A-Z]+$', name)	=> true,	// JR NAME
	REGEXFIND('\\b(JR|SR|II|III|IV) +(JR|SR|II|III|IV)$', name)	=> true,	// JR JR
	REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', name) => true,
	//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{4,}\\b', name) => NOT REGEXFIND('\\b' + rgxHonor + '\\b', name) OR
	//					NOT IsLastNameEx(REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]{4,})\\b', name, 1)),
	REGEXFIND(rgxLastReversed, name) => true,
	REGEXFIND('^[A-Z]+ +[A-Z]* *[A-Z]+[0-9][A-Z]+$',name) => true,	// embedded numeral
	REGEXFIND('^[A-Z] +[A-Z]$', name) => true,	// A B
	REGEXFIND('^[A-Z] +[A-Z] +[A-Z]$', name) => true,	// A B C
	REGEXFIND('\\b([B-HJ-Z])\\1{2,}', name) => true,	// XXX (except AAA and III)
	REGEXFIND('\\b([AI])\\1{4,}', name) => true,	// XXX (except AAA and III)
	REGEXFIND('^([A-Z]+) \\1$', name) => true,	// DURAN DURAN
	//REGEXFIND('\\b[A-Z]-[A-Z]\\b', name) => true,	// A-B
	REGEXFIND('^[A-Z]-[A-Z]\\b', name) => true,	// ^A-B
	REGEXFIND('\\b[A-Z]-[A-Z]$', name) => true,	// A-B$
	REGEXFIND('\\b[A-Z]{2,}-[A-Z] ', name) => 
						NOT NameTester.IsFirstName(REGEXFIND('\\b([A-Z]{2,})-[A-Z] ', name, 1)),		// GARCIA-R
	REGEXFIND('\\b(AND|OR)$', name)	=> true,	// ends with "AND"
	REGEXFIND('^(AND|OR)\\b', name)	=> true,	// begins with "OR"
	REGEXFIND('\\b(ERROR|ISSUED)\\b', name)	=> true,	// 
	REGEXFIND('^COOKIE +[A-Z]* +MONSTER$', name)	=> true,	// 
	REGEXFIND('^I LIKE +[A-Z]*\\b', name)	=> true,	// 
	REGEXFIND('\\b(LT|FT|DL|JT|HW)\\b',name) => true,  // unprocessed abbreviations
	REGEXFIND('^[A-Z][A-Z] [A-Z][A-Z]$',name) => true,
	REGEXFIND('^[A-Z]+ [A-Z] (ST|MC)$',name) => true,
	REGEXFIND('\\b[0-9]+ [A-Z]+ (ST|STREET|RD|DR|DRIVE)\\b',name) => true,
	REGEXFIND(rgxConsonants, name) => NOT
				ValidateConsonants(REGEXFIND(rgxConsonants, name, 1)),
	false);
*/		
shared string NameOrGen(string rgx, string s, integer2 pos, boolean getgen) := FUNCTION
		name := TRIM(REGEXFIND(rgx, s, pos, NOCASE),LEFT,RIGHT);
		RETURN IF (getgen, IF(IsSureGen(name),name,''),
							IF(IsSureGen(name),'',name));
END;


export string16 WhichFormat(NameFormat n) := CASE(n,
			NameFormat.NoName =>	'',
			NameFormat.FL =>		'FL',
			NameFormat.LF =>		'LF',
			NameFormat.FLorLF => 	'FLorLF',
			NameFormat.FLcS =>		'FLcS',
			NameFormat.FLS =>		'FLS',
			NameFormat.LFS =>		'LFS',
			NameFormat.FLSorLFS =>	'FLSorLFS',
			NameFormat.FLL =>		'FLL',
			NameFormat.FLLS =>	'FLLS',
			NameFormat.FxL =>		'FxL',
			NameFormat.FxLS =>		'FxLS',
			NameFormat.LxFM	=>		'LxFM',
			NameFormat.FxLL =>		'FxLL',
			NameFormat.FMLL =>		'FMLL',
			NameFormat.FMSL =>		'FMSL',
			NameFormat.FMiMiL =>	'FMiMiL',
			NameFormat.LFMiM =>		'LFMiM',
			NameFormat.LFMiMi =>	'LFMiMi',
			NameFormat.FMML =>		'FMML',
			NameFormat.FMMLS =>		'FMMLS',
			NameFormat.LFiMi =>		'LFiMi',
			NameFormat.LFMi =>		'LFMi',
			NameFormat.LFM =>		'LFM',
			NameFormat.FMLorLFM => 	'FMLorLFM',
			NameFormat.ILI => 		'ILI',
			NameFormat.FML => 		'FML',
			NameFormat.FMLSorLFMS => 'FMLSorLFMS',
			NameFormat.LFMicS =>	'LFMicS',
			NameFormat.FMLcIII =>	'FMLcIII',
			NameFormat.FMLcS => 	'FMLcS',
			NameFormat.FMcSL =>		'FMcSL',
			NameFormat.LcFMS => 	'LcFMS',
			NameFormat.LFMiS =>	 	'LFMiS',
			NameFormat.LFMS =>	 	'LFMS',
			NameFormat.LScF => 		'LScF',
			NameFormat.LSFM =>	 	'LSFM',
			NameFormat.LScFM => 	'LScFM',
			NameFormat.LScFMM => 	'LScFMM',
			NameFormat.FMLLS => 	'FMLLS',
			NameFormat.LcFMM => 	'LcFMM',
			NameFormat.LcSFM => 	'LcSFM',
			NameFormat.LFMMi => 	'LFMMi',
			NameFormat.LFSM =>		'LFSM',
			//NameFormat.FiMiL =>		'FiMiL',
			NameFormat.LFi =>		'LFi',
			NameFormat.LFiS =>		'LFiS',
			NameFormat.FiL =>		'FiL',
			NameFormat.FiML =>		'FiML',
			NameFormat.FiLS =>		'FiLS',
			NameFormat.FiMLS =>		'FiMLS',
			NameFormat.FMiL =>		'FMiL',
			NameFormat.FMiLS =>		'FMiLS',
			NameFormat.FMiLI =>		'FMiLI',
			NameFormat.LFcMi =>		'LFcMi',
			NameFormat.LcF =>		'LcF',
			NameFormat.LcTF =>		'LcTF',
			NameFormat.LcFM =>		'LcFM',
			NameFormat.LcFS =>		'LcFS',
			NameFormat.LLcFM =>		'LLcFM',
			NameFormat.LLcFS =>		'LLcFS',
			NameFormat.LcFhF =>		'LcFhF',
			NameFormat.FiIIL =>		'FiIIL',
			NameFormat.FccL =>		'FccL',
			NameFormat.SFL =>		'SFL',
			NameFormat.FSL =>		'FSL',
			NameFormat.FMLyL =>		'FMLyL',
			NameFormat.LcFMcS =>	'LcFMcS',
			NameFormat.FcMcL => 	'FcMcL',
			NameFormat.FoLcMcL => 	'FoLcMcL',
			NameFormat.LcFcM =>		'LcFcM',
			NameFormat.LcFcMS =>	'LcFcMS',
			NameFormat.LcFcMcS =>	'LcFcMcS',
			NameFormat.LcFcS =>		'LcFcS',
			NameFormat.LcScF =>		'LcScF',
			NameFormat.LcScFM =>	'LcScFM',
			
			// Dual Names
			NameFormat.LFaF =>		'LFaF',
			NameFormat.LFaFS =>		'LFaFS',
			NameFormat.LFiaFi =>	'LFiaFi',
			NameFormat.LFiaFiMi =>	'LFiaFiMi',
			NameFormat.FiMiaFiL =>	'FiMiaFiL',
			NameFormat.LFiaFiL =>	'LFiaFiL',
			NameFormat.LFiMiaFiMi =>'LFiMiaFiMi',
			NameFormat.FMiaFL => 	'FMiaFL',
			NameFormat.FMaFL => 	'FMaFL',
			NameFormat.FLaFL =>		'FLaFL',
			NameFormat.LFaFL =>		'LFaFL',
			NameFormat.LFaFM =>		'LFaFM',
			NameFormat.FLaFM =>		'FLaFM',
			NameFormat.FSaFL =>		'FSaFL',
			NameFormat.FMSaFML => 'FMSaFML',
			NameFormat.LFMaFML =>	'LFMaFML',
			NameFormat.LFMiaF =>	'LFMiaF',
			NameFormat.LFMiaFM =>	'LFMiaFM',
			NameFormat.LFMiaFMiL =>	'LFMiaFMiL',
			NameFormat.FMiaFMiL =>	'FMiaFMiL',
			NameFormat.LFaFMiS =>	'LFaFMiS',
			NameFormat.FMiaFMiMiL =>	'FMiaFMiMiL',
			NameFormat.LFMaLFMS => 'LFMaLFMS',
			NameFormat.FLSaFM =>	'FLSaFM',
			NameFormat.LSFaFM =>	'LSFaFM',
			NameFormat.LSFMaFM =>	'LSFMaFM',
			NameFormat.FMLaFML =>	'FMLaFML',
			NameFormat.FMLaFML2 =>	'FMLaFML2',
			NameFormat.FMLcFML =>	'FMLcFML',
			NameFormat.LFMSaFML =>	'LFMSaFML',
			NameFormat.FMLSaFML =>	'FMLSaFML',
			NameFormat.LFMaLFM =>	'LFMaLFM',
			NameFormat.FLSaIFI =>	'FLSaIFI',
			NameFormat.LFMiaIFI =>	'LFMiaIFI',
			NameFormat.FMLaIFI =>	'FMLaIFI',
			NameFormat.LFMaFMiI =>	'LFMaFMiI',
			NameFormat.LFMaFiMiI =>	'LFMaFiMiI',
			NameFormat.LFMaFiMiL =>	'LFMaFiMiL',
			NameFormat.LFMaFMS =>	'LFMaFMS',
			NameFormat.LFMaLFM2 =>	'LFMaLFM2',
			NameFormat.LFMaLFM2S =>	'LFMaLFM2S',
			NameFormat.LFiSaI =>	'LFiSaI',
			NameFormat.FMiSaFL =>	'FMiSaFL',
			NameFormat.FMLaFL =>	'FMLaFL',
			NameFormat.LFMaFM =>	'LFMaFM',
			NameFormat.FMLaFM =>	'FMLaFM',
			NameFormat.LcFMaFMS =>	'LcFMaFMS',
			NameFormat.LcFMaF =>	'LcFMaF',
			//NameFormat.LcFSaFMM => 'LcFSaFMM',
			NameFormat.LcFMaFMM =>	'LcFMaFMM',
			NameFormat.LcSFaFMM =>	'LcSFaFMM',
			NameFormat.LcFMiMiaFMM => 'LcFMiMiaFMM',
			NameFormat.FMaFLS =>	'FMaFLS',
			NameFormat.LFaLF =>		'LFaLF',
			NameFormat.LFaLF1 =>	'LFaLF1',
			NameFormat.LFaLcF =>	'LFaLcF',
			NameFormat.LFaLFM =>	'LFaLFM',
			NameFormat.LFaLFM2 =>	'LFaLFM2',
			NameFormat.LFaFMiMi =>	'LFaFMiMi',
			NameFormat.FMaFML =>	'FMaFML',
			NameFormat.LFaFMS =>	'LFaFMS',
			NameFormat.FiaFiL =>	'FiaFiL',
			NameFormat.FaFL =>		'FaFL',
			NameFormat.FaFLS =>		'FaFLS',
			NameFormat.FMaFMLS =>	'FMaFMLS',
			NameFormat.FaFMLS =>	'FaFMLS',
			NameFormat.FaFML =>		'FaFML',
			NameFormat.LcFMSaFMM =>	'LcFMSaFMM',
			NameFormat.LFMSaFMM =>	'LFMSaFMM',
			NameFormat.LcFaF =>		'LcFaF',
			NameFormat.LcFaFM =>	'LcFaFM',
			NameFormat.LcFMaLcF =>	'LcFMaLcF',
			NameFormat.LcFMaLcFS =>	'LcFMaLcFS',
			NameFormat.LcFMaLcFM =>	'LcFMaLcFM',
			NameFormat.LcFMSaLcFM =>'LcFMSaLcFM',
			NameFormat.LcFaLcF =>	'LcFaLcF',
			NameFormat.LcFaLcFM =>	'LcFaLcFM',
			NameFormat.LScFMaFML => 'LScFMaFML',
			NameFormat.MrMrs =>	'MrMrs',
			// partial names
			NameFormat.L => 'L',
			NameFormat.LS => 'LS',
			'X' + (string)n
		);

shared rgxHyphenatedSimplename := '^([A-Z]{2,})-([A-Z]{2,})$';
shared rgxCompoundFirstName := '^([A-Z]{2,})(ANN|ANNE|BETH|ELLEN|MAE|LYN|LYNN)$';
			
// check for hyphenated first names
shared boolean IsFirstNamePart(string name, string partname) :=
	NameTester.IsFirstNameBasic(partname) and ~NameTester.IsLastName(name)
		and (partname not in ['MAC','HAM','AB','AM','HEM','LAP','NORM']);
export boolean IsFirstNameEx(string name) := MAP(
		NameTester.IsFirstName(name) => true,
		REGEXFIND('^[A-Z]{2,}-[A-Z]$', name) => NameTester.IsFirstName(REGEXFIND('^([A-Z]{2,})-[A-Z]$', name, 1)),
		REGEXFIND(rgxHyphenatedSimplename, name) => 
			(NameTester.IsFirstName(REGEXFIND(rgxHyphenatedSimplename, name, 1)) AND
			NameTester.IsFirstName(REGEXFIND(rgxHyphenatedSimplename, name, 2))) OR
			NameTester.IsFirstName(StringLib.StringFilterOut(name,'-')),
		REGEXFIND(rgxCompoundFirstName,name) => 
				IsFirstNamePart(name,REGEXFIND(rgxCompoundFirstName,name,1)),
		REGEXFIND('^[A-Z]{3,}(JR|SR)$',name) => NameTester.IsFirstName(REGEXFIND('^([A-Z]+)(JR|SR)$',name,1)),
		//name[1..2] in ['LA','DA'] AND LENGTH(name) > 5 => NameTester.IsFirstNameBasic(name[3..]) AND NOT Address.OrientalNames.IsOrientalName(name[3..]),
		false
	);
	
export boolean IsFirstNameSlammed(string name) := MAP(
	IsFirstNameEx(name) => true,
	LENGTH(name) > 3 AND NameTester.IsFirstNameBasic(name[1..LENGTH(name)-1]) => true,	// name & MI slammed
	false);

shared boolean IsPossibleFirstName(string name) := MAP(
	IsFirstNameEx(name) => true,
	name in ['NFN','NMN', 'NMI'] => true,	// placeholder for name
	REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{3,}$',name) =>	// three consonants
			NOT SpecialNames.IsAbbreviation(REGEXFIND('^([B-DF-HJ-NP-TVWXZ]{3})$', name, 1)),
	false
	);
	
shared boolean InvalidFirstName(string name) := name in ['NFN','NMN','NMI','NT','ASS','BASTARD'];
	
shared boolean IsFirstNameOrInitial(string name) :=
	IsFirstNameEx(name) OR (LENGTH(TRIM(name)) = 1);
shared boolean IsFirstNameOrInitialOrBlank(string name) :=
	IsFirstNameEx(name) OR (LENGTH(TRIM(name)) <= 1);
	

//shared boolean IsLastNameOnlyOrHyphenated(string name) := 
//	IsLastNameOnly(name) OR
//		IsLastNameHyphenated(name);
		
//shared boolean IsNickName(string name) :=
//	IF(TRIM(Nid.PreferredFirstNew(name)) = name, false, true);
shared boolean IsNickName(string name) := NOT IsLastNameEx(name);
//shared boolean IsNoFirstLastNameExOrHyphenated(string name) := 
//	IsLastNameExOrHyphenated(name) AND NOT NameTester.IsFirstName(name);
	//IsLastNameEx(name) OR
	//	((REGEXFIND(rgxHyphenatedname, name) OR LENGTH(name) > 10)AND NOT IsFirstName(name) );

export boolean IsValidLastName(string nm) :=
	~InvalidLastName(nm) AND (IsLastNameEx(nm) OR IsDoubleLastName(nm));
	//~InvalidLastName(nm) AND (IsLastNameExOrHyphenated(nm) OR IsLastNameDoubled(nm));
	
// for test only		
shared types := ['X','F','L','B'];
shared string1 GetNameType(string nm) :=
	types[IF (IsFirstNameOrInitial(nm),1,0) +
	IF (IsValidLastName(nm),2,0) + 1];

shared string1 GetNameTypeI(string nm) :=
	types[IF (IsFirstNameOrInitial(nm) OR LENGTH(TRIM(nm,LEFT,RIGHT))=1,1,0) +
	IF (IsValidLastName(nm),2,0) + 1];	
	
export string GetNameTypes(string fname, string lname, string mname='') := FUNCTION
//OUTPUT(fname + ' ' + lname);
return		GetNameType(fname)
			+ IF(mname='','',GetNameType(mname))
			+ GetNameType(lname); 
END;
shared string ExtractNameTypes(string rgx, string s, integer fname, integer lname, integer mname=0) :=
	GetNameTypes(REGEXFIND(rgx, s, fname), REGEXFIND(rgx, s, lname),
		IF(mname=0, '', REGEXFIND(rgx, s, mname)));
		
shared string ExtractNameTypesFML(string rgx, string s, integer fname, integer mname, integer lname) :=
	GetNameType(REGEXFIND(rgx, s, fname)) +
	GetNameType(REGEXFIND(rgx, s, mname)) +
	GetNameType(REGEXFIND(rgx, s, lname));
		
shared string ExtractNameTypes4(string rgx, string s, integer fname, integer mname, integer lname, integer lname2) :=
	GetNameType(REGEXFIND(rgx, s, fname)) +
	GetNameType(REGEXFIND(rgx, s, mname)) +
	GetNameType(REGEXFIND(rgx, s, lname)) +
	GetNameType(REGEXFIND(rgx, s, lname2));
	
shared string ExtractNameTypes3(string rgx, string s, integer name1, integer name2, integer name3) :=
	GetNameType(REGEXFIND(rgx, s, name1)) +
	GetNameType(REGEXFIND(rgx, s, name2)) +
	GetNameType(REGEXFIND(rgx, s, name3));
	
shared string ExtractNameTypes2(string rgx, string s, integer name1, integer name2) :=
	GetNameType(REGEXFIND(rgx, s, name1)) +
	GetNameType(REGEXFIND(rgx, s, name2));

shared string ExtractNameTypes2I(string rgx, string s, integer name1, integer name2) :=
	GetNameTypeI(REGEXFIND(rgx, s, name1)) +
	GetNameTypeI(REGEXFIND(rgx, s, name2));

shared string ExtractNameTypesLFF(string rgx, string s, integer lname, integer fname1, integer fname2) :=
	GetNameType(REGEXFIND(rgx, s, lname)) +
	GetNameType(REGEXFIND(rgx, s, fname1)) +
	GetNameType(REGEXFIND(rgx, s, fname2));


// F = FML
// L = LFM
// U = LMF (flip)
shared string1 GetNameOrderFML(string rgx, string s, integer2 posf1, integer2 posf2, 
													integer2 posl1, integer2 posl2, string1 clue='U',
													integer2 posm1, integer2 posm2) := FUNCTION
		segs := ExtractNameTypesFML(rgx, s, posf1, posm1, posl1);

		return	MAP(
				//clue in ['l','L'] =>
				//		GetNameOrder(rgx, s, posf1, posf2, posl1, posl2, clue, posm1, posm2),
				REGEXFIND(rgx, s, posm1) in nmn => 'F',
				REGEXFIND(rgx, s, posm2) in nmn => 'L',
				InvalidLastName(REGEXFIND(rgx, s, posl1)) => 'L',
				InvalidLastName(REGEXFIND(rgx, s, posl2)) => 'F',
				segs IN ['FFL','FBB','FBL','FLB','FBX','BFL','BBL','XXX','FBL','FXL','FLX','FLL','FXX','BXL','BXL','BLX','LXL','XLL','XXL'] => 'F',
				segs IN ['LFF','LFB','LFL','LFX','LBF','LBB','LBL','LBX','LXX','LXF','LXB','BFF','BBF','XBX','XFX','XFB','XXF','XFF','XBF','XBB'] => 'L',
				segs in ['LLF','XLF','BLF','LLB'] => IF(nameTester.IsLoPctFirstName(REGEXFIND(rgx, s, posm1)), 'L', 'U'),
				segs in ['XFL','XBL'] => IF(nameTester.IsLoPctFirstName(REGEXFIND(rgx, s, posl1)), 'L', 'F'),
				segs in ['BFB'] => if(clue in ['l','L'], 'L', 'F'),
				clue in ['l','L'] => 'L',
				'F'
				//GetNameOrder(rgx, s, posf1, posf2, posl1, posl2, clue, posm1, posm2)
			);
END;

// F = FMLL
// L = LFMM
// U = FMML
// X = LFML
// Y = LLFF
// NOTE: to be backward compatible, this will revert back to FML
shared string1 GetNameOrderFMLL(string rgx, string s, integer2 posf1, integer2 posm1,
																		integer2 posl1, integer2 posl2) := FUNCTION

		allsegs := ExtractNameTypes4(rgx, s, posf1, posm1, posl1, posl2);
		segs := allsegs[1..3];
		x :=	MAP(
				REGEXFIND(rgx, s, posm1) in nmn => 'F',
				REGEXFIND('\\b(BEN|AL) [A-Z]+$', s) => 'F',
//				InvalidLastName(REGEXFIND(rgx, s, posl1)) => 'L',
//				InvalidLastName(REGEXFIND(rgx, s, posl2)) => 'F',
				LENGTH(TRIM(REGEXFIND(rgx, s, posm1))) = 1 => 'F',			// middle initial
				allsegs IN ['XFBL','XFLL','XFBB','XFLB','BXFL','BBBB','FFLL','FFBL','FFBB','FXXX','BXXX'] => 'F',
				allsegs IN ['LFFF','LFFB','LFBF'] => 'L',
				allsegs IN ['BFFB','BFFL','FFFL','FFFB','FFFX','BFFX'] => 'U',
				allsegs IN ['LFBL','LFFL'] => 'X',
				allsegs IN ['LLFF','LLFB','LLBF','XLFB','XLFF','XLFL'] => 'Y',
				segs IN ['FFL','FBL','BFL','BBL','XXX','FBL','FXL','FLX','FLL','FXX','BXL','BXL','BLX','BFB','LXL','XLL','BBB'] => 'F',
				allsegs[1..2] IN ['LL','LX','XL','XX'] => 'Y',
				segs IN ['LFF','LFB','LFX','LBF','LBB','LBX','LXX','LXF','BFF','BBF','BXF','XBX','XFX','XFB','XLF','BLF'] => 'L',
				segs in ['FFF','FBB','FBF','FFB'] => 'U',
				/*IsLastNameEx(REGEXFIND(rgx, s, posf1)) AND IsFirstNameOrInitial(REGEXFIND(rgx, s, posm1))
						AND IsFirstNameOrInitial(REGEXFIND(rgx, s, posl1))
						=> 'L',
				IsFirstNameEx(REGEXFIND(rgx, s, posf1)) AND IsFirstNameOrInitial(REGEXFIND(rgx, s, posm1))
						=> 'F',*/
				'F'
			);
//OUTPUT(allsegs);
//			OUTPUT(x);
			return x;
END;
			

shared string1 GetNameOrderFMiL(string rgx, string s, integer2 posf1, integer2 posf2, 
													integer2 posl1, integer2 posl2, string1 clue='U') := FUNCTION
			segs := ExtractNameTypes(rgx, s, posf1, posl1);
			return MAP(
				REGEXFIND(rgx, s, posl1) in nmn => 'U',
				REGEXFIND(rgxFiMiL, s) => 'F',
				InvalidLastName(REGEXFIND(rgx, s, posl1)) => 'L',
				InvalidLastName(REGEXFIND(rgx, s, posl2)) => 'F',
				//LENGTH(REGEXFIND(rgx, s, posl1)) = 1 => 'F',
				segs in ['FL','BL','FB','FX','FF','XL','XB'] => 'F',
				segs in ['LF','LB','XF'] => 'L',		//,'BF' leads to too many name reversals
				segs = 'LX' => IF(NameTester.IsLoPctFirstName(REGEXFIND(rgx, s, posf1)), 'F', 'L'), 
				clue in ['l','L'] => 'L',	// LL XX BX BB
				'F'		// LL XX BX BB
				/*IsFirstNameEx(REGEXFIND(rgx, s, posf1)) AND IsLastNameExOrHyphenated(REGEXFIND(rgx, s, posl1))
						=> 'F',
				IsLastNameExOrHyphenated(REGEXFIND(rgx, s, posl2)) AND IsFirstNameEx(REGEXFIND(rgx, s, posf2))
						=> 'L',
				IsFirstNameEx(REGEXFIND(rgx, s, posf1)) => 'F',
				IsLastNameExOrHyphenated(REGEXFIND(rgx, s, posl1)) => 'F',
				IsFirstNameEx(REGEXFIND(rgx, s, posf2)) => 'L',
				IsLastNameExOrHyphenated(REGEXFIND(rgx, s, posl2)) => 'L',
				'F'*/
			);

END;
		
shared string1 GetNameOrderFL(string rgx, string s, integer2 posf1, integer2 posf2, 
													integer2 posl1, integer2 posl2, string1 clue='U') :=
		FUNCTION
			segs := ExtractNameTypes(rgx, s, posf1, posl1);

			return MAP(
				InvalidLastName1(REGEXFIND(rgx, s, posl1)) => 'L',
				InvalidLastName1(REGEXFIND(rgx, s, posl2)) => 'F',
				segs in ['FL','BL','FB','FX','XL'] => 'F',
				segs in ['LF','LB','BF','XF','LX'] => 'L',
				segs = 'XB' => IF(NameTester.IsHiPctFirstName(REGEXFIND(rgx,s,posl1)) OR NameTester.IsEthnicFirstName(REGEXFIND(rgx,s,posl1)), 'L', 'L'),
				segs = 'BB' => IF(NameTester.IsHiPctFirstName(REGEXFIND(rgx,s,posf1)),'F',
													IF(NameTester.IsHiPctFirstName(REGEXFIND(rgx,s,posl1)),	'L', clue)),
	//	
				segs = 'LL' => IF(NameTester.IsLoPctFirstName(REGEXFIND(rgx,s,posf1)), 'F', 
													IF(NameTester.IsLoPctFirstName(REGEXFIND(rgx,s,posl1)), 'L', clue)),
				clue in ['l','L'] => 'L',	// LL XX BX BB
				'F'		// LL XX BX BB
			);
		END;
			
shared string1 GetNameOrderFLL(string rgx, string s, integer2 posf1, 
													integer2 posl1, integer2 posl2, string1 clue='U') :=
		FUNCTION
			segs := ExtractNameTypesFML(rgx, s, posf1, posl1, posl2);
			
			return MAP(
				//InvalidLastName(REGEXFIND(rgx, s, posl1)) => 'L',
				//InvalidLastName(REGEXFIND(rgx, s, posl2)) => 'F',
				segs[1] = 'F' => 'F',
				segs[1] = 'L' => 'L',
				segs[3] = 'F' => 'L',
				segs[1..2] in ['BL','FX','FF','XL'] => 'F',
				segs[1..2] in ['BL','XF','XB'] => 'L',
				clue in ['l','L'] => 'L',	// LL XX BX BB
				'F'		// LL XX BX BB
			);
		END;
/*
shared string1 NameFlip(string rgx, string s, integer2 posf1, integer2 posf2, 
													integer2 posl1, integer2 posl2, string1 clue='U') :=
		FUNCTION
			segs := ExtractNameTypes(rgx, s, posf1, posl1);

			return MAP(
				InvalidLastName(REGEXFIND(rgx, s, posl1)) => 'L',
				InvalidLastName(REGEXFIND(rgx, s, posl2)) => 'F',
				segs in ['FL','FB','FX','BL','XL'] => 'F',
				segs in ['LF','LB','LX','BF','XF'] => 'L',
				clue
			);
		END;
*/
shared string1 GetNameOrderLFMi(string rgx, string s, integer2 posf1, integer2 posl1) := FUNCTION
			//segs := ExtractNameTypes(rgx, s, posf1, posl1);
			return MAP(
				InvalidLastName(REGEXFIND(rgx, s, posl1)) => 'F',
//				NameTester.IsFirstName(REGEXFIND(rgx, s, posf1)) AND IsLastNameExOrHyphenated(REGEXFIND(rgx, s, posl1))
//						=> 'L',
				IsLastNameExOrHyphenated(REGEXFIND(rgx, s, posl1)) => 'L',
				NameTester.IsFirstName(REGEXFIND(rgx, s, posl1)) AND IsLastNameExOrHyphenated(REGEXFIND(rgx, s, posf1))
						=> 'F',
				NameTester.IsFirstName(REGEXFIND(rgx, s, posf1)) => 'L',
				NameTester.IsFirstName(REGEXFIND(rgx, s, posl1)) => 'F',
				'L'
			);
END;
			                                    

shared string4 GetNameOrderNNaNN(string4 segs) :=
			MAP(
				segs in ['BFFF','BBFF','BFBF','BFFB','XFFF','XBFF','XFBF','XFFB','FFFF',
									'BXFF'] => 'LFFM',		// 
				segs in ['FLFL','FLBL','BLFL','BLBL','FXFL','FLXL','FLFX'] => 'FLFL',		// FL & FL
				segs in ['FBBF','FLFF','FLFB','FLBF','BLFF'] => 'FLFM',		// FL & Fm(L)
				segs in ['LFLF','BFLF','XFLF'] => 'LFLF',		// LF a LF
				segs in ['FLLF', 'FLLX'] => 'FLLF',		// FL a LF
				segs in ['LFFL','LFBL','LFXL'] => 'LFFL',		// LF a FL
				segs in ['FFLF','FBLF'] => 'FFLF',		// LF a FL
				segs in ['FLLL','FLXX','XXFX'] => 'FLFL',			// best guess for consistency
				segs[1] = 'L' => 'LFFM',
				segs[4] = 'L' and segs[2] != 'L' => 'FMFL',	
				'XXXX');	// default

shared string4 GetNameOrder2Names(string2 segs) :=
			MAP(
					segs[1] in ['L','X'] => 'LF', 
					segs[2] = 'L' => 'FL',
					'FM');
			 
				 
// check for first name with space or other punctuation
shared boolean StandaloneFirstLast(string rgx, string s, integer2 posf, integer2 posl) :=
			NameTester.IsFirstName(REGEXFIND(rgx, s, posf)) AND IsLastNameEx(REGEXFIND(rgx, s, posl));


// 27 Apr 2015: do not use double middle names
shared string CompoundName(string rgx, string s, integer part1, integer part2) := FUNCTION
	name1 := TRIM(REGEXFIND(rgx, s, part1),left,right);
	name2 := TRIM(REGEXFIND(rgx, s, part2),left,right);
//	RETURN TRIM(IF(name1 in ['AL', 'BEN', 'DA','DE','DEL','LA','MC','ST','VAN','VON'],
//			 name1, name1 + ' ' + name2),LEFT,RIGHT);
	RETURN TRIM(IF(name1 in ['AL', 'BEN', 'DA','DE','DEL','LA','MC','ST','VAN','VON'] OR LENGTH(name2)=1,
			 name1 + ' ' + name2, name1),LEFT,RIGHT);
END;

shared string CompoundName2(string rgx, string s, integer part1, integer part2) := FUNCTION
	name1 := TRIM(REGEXFIND(rgx, s, part1),left,right);
	name2 := TRIM(REGEXFIND(rgx, s, part2),left,right);
	RETURN TRIM(name1 + ' ' + name2,LEFT,RIGHT);
END;

firstPartOnly(string s) := s;
//		IF(REGEXFIND(' ', TRIM(s,LEFT,RIGHT)),
//				REGEXFIND('^([A-Z\'-]+)', s, 1), s);
shared string20 FilterMName(string s) := 
			TRIM(firstPartOnly(
					IF(s in ['NMI','NMN','NULL','\''] OR IsSureGen(s),'',
							IF(STD.Str.EndsWith(s, '-'),s[1..LENGTH(s)-1],
							s))),LEFT,RIGHT);

shared string20 NoMC(string s) := IF(REGEXFIND('^(MC|O)[ -](.+)',s),REGEXREPLACE('^(MC|O)[ -](.+)',s,'$1$2'),s);
shared string20 FilterLName(string s) := 
			TRIM(Stringlib.StringFilterOut(s,'\''),LEFT,RIGHT);

shared string GenToAlpha(string suffix) :=
		IF(IsGeneration(suffix), suffix,
		CASE(suffix,
			'' => '',
			'1' => 'SR',
			'2' => 'II',
			'3' => 'III',
			'03' => 'III',
			'4' => 'IV',
			'5' => 'V',
			'6' => 'VI',
			'7' => 'VII',
			'8' => 'VIII',
			'9' => 'IX',
			'1ST' => 'I',
			'2N' => 'II',
			'2ND' => 'II',
			'ND' => 'II',
			'3RD' => 'III',
			'RD' => 'III',
			'THRD' => 'III',
			'4TH' => 'IV',
			'5TH' => 'V',
			'6TH' => 'VI',
			'000' => '',
			''));


		
shared string20 blank20 := ' ';
shared string5 blank5 := ' ';

shared string65 FormatNameFM(string rgx, string name, integer fn, integer mn) := 
	(string20)REGEXFIND(rgx, name, fn) +
	(string20)(REGEXFIND(rgx, name,mn)) +
	blank20 +
	blank5;
shared string65 FormatNameFL(string rgx, string name, integer fn, integer lnm) := 
	(string20)TRIM(REGEXFIND(rgx, name, fn),LEFT,RIGHT) +
	blank20 +
	FilterLName(REGEXFIND(rgx, name,lnm)) +
	blank5;
	
shared string65 GetFormatNameFL(string rgx, string name, integer fn, integer lnm, string1 clue='U') := 
			CASE(GetNameOrderFL(rgx, name, fn, lnm, lnm, fn, clue),
										'F' => FormatNameFL(rgx, name, fn, lnm),
										'L' => FormatNameFL(rgx, name, lnm, fn),
										FormatNameFL(rgx, name, fn, lnm)
									);		
	
shared string65 FormatNameFLS(string rgx, string name, integer fn, integer lnm, integer sn) := 
 (string20)REGEXFIND(rgx, name, fn) +
	blank20 +
	FilterLName(REGEXFIND(rgx, name, lnm)) +
	(string5)genToAlpha(TRIM(REGEXFIND(rgx, name, sn),LEFT,RIGHT));

shared string65 FormatNameFML(string rgx, string name, integer fn, integer mn, integer lnm, string1 initial='') := 
	(string20)TRIM(REGEXFIND(rgx, name, fn),LEFT,RIGHT) +
	(string20)FilterMName(TRIM(REGEXFIND(rgx, name, mn),LEFT,RIGHT)) +
	(string20)TRIM(initial+FilterLName(REGEXFIND(rgx, name, lnm)),left,right) +
	blank5;
	
shared string65 GetFormatNameFML(string rgx, string s, integer fn, integer mn, integer lnm, string1 clue='U') := 

			CASE(GetNameOrderFML(rgx, s, fn, mn, lnm, fn, clue, mn, lnm),
										'F' => FormatNameFML(rgx, s, fn, mn, lnm),
										'L' => FormatNameFML(rgx, s, mn, lnm, fn),
										'U' => FormatNameFML(rgx, s, lnm, fn, mn),
										FormatNameFML(rgx,s, fn, mn, lnm)
									);
	
shared string65 FormatNameFMLorFLS(string rgx, string name, integer fn, integer mn, integer lnm, integer sfx) := 
	IF(IsSureSuffix(REGEXFIND(rgx, name, sfx)), FormatNameFLS(rgx, name, fn, lnm, sfx), FormatNameFML(rgx, name, fn, mn, lnm)); 

shared string65 FormatNameFMLL(string rgx, string name, integer fn, integer mn, integer lnm, integer lnm2) := 
	FUNCTION
		lname := TRIM(FilterLName(REGEXFIND(rgx, name, lnm))) + ' ' + 
							TRIM(FilterLName(REGEXFIND(rgx, name, lnm2)));

		return (string20)REGEXFIND(rgx, name, fn) +
			FilterMName(TRIM(REGEXFIND(rgx, name, mn),LEFT,RIGHT)) +
			NoMC(lname) +
			blank5;
	END;
shared string65 FormatNameFLL(string rgx, string name, integer fn, integer lnm, integer lnm2) := 
	FUNCTION
		/*lname := TRIM(FilterLName(REGEXFIND(rgx, name, lnm))) + ' ' +
						TRIM(FilterLName(REGEXFIND(rgx, name, lnm2)));
		return (string20)REGEXFIND(rgx, name, fn) +
			blank20 +
			NoMC(lname) +
			blank5;*/
			//mname := NoMC(TRIM(FilterLName(REGEXFIND(rgx, name, lnm))));
			//lname := FilterLName(REGEXFIND(rgx, name, lnm2));
			lname1 := TRIM(NoMC(TRIM(FilterLName(REGEXFIND(rgx, name, lnm)))));
			lname2 := TRIM(FilterLName(REGEXFIND(rgx, name, lnm2)));

		return (string20)REGEXFIND(rgx, name, fn) +
			blank20 +
			(string20)(lname1 + ' ' + lname2) +
			blank5;
	
	END;
	

shared string65 FormatNameFLLS(string rgx, string name, integer fn, integer lnm, integer lnm2, integer sn) := 
	FUNCTION
		lname := TRIM(FilterLName(REGEXFIND(rgx, name, lnm))) + ' ' +
						TRIM(FilterLName(REGEXFIND(rgx, name, lnm2)));
		return (string20)REGEXFIND(rgx, name, fn) +
			blank20 +
			NoMC(lname) +
			(string5)genToAlpha(REGEXFIND(rgx, name, sn));
	END;
	
shared string65 FormatNameFMML(string rgx, string name, integer fn, integer mn, integer mn2, integer lnm) := FUNCTION
	mname := CompoundName(rgx, name, mn, mn2);
	lname := IF(REGEXFIND('[A-Z]+ [A-Z]+', mname), FilterLName(REGEXFIND(rgx, name, lnm)),
						TRIM(FilterLName(REGEXFIND(rgx, name, mn2))) + ' ' + 
							TRIM(FilterLName(REGEXFIND(rgx, name, lnm))));

	return (string20)REGEXFIND(rgx, name, fn) +
	(string20)mname +
	(string20)TRIM(lname,left,right) +	
	blank5;
END;

shared string65 FormatNameFMLS(string rgx, string name, integer fn, integer mn, integer lnm, integer sn, string1 initial='') := 
	(string20)REGEXFIND(rgx, name, fn) +
	(string20)FilterMName(REGEXFIND(rgx, name, mn)) +
	(string20)TRIM(initial+FilterLName(REGEXFIND(rgx, name, lnm)),left,right) +
	(string5)genToAlpha(REGEXFIND(rgx, name, sn));
	
shared string65 FormatNameFMMLS(string rgx, string name, integer fn, integer mn, integer mn2, integer lnm, integer sn) := 
	(string20)REGEXFIND(rgx, name, fn) +
	(string20)CompoundName2(rgx, name, mn, mn2) +
	FilterLName(REGEXFIND(rgx, name, lnm)) +
	(string5)genToAlpha(REGEXFIND(rgx, name, sn));
	
shared string65 FormatNameL(string rgx, string name, integer lnm) := 
	blank20 +
	blank20 +
	FilterLName(REGEXFIND(rgx, name, lnm)) +
	blank5;
shared string65 FormatNameF(string rgx, string name, integer fnm) := 
	(string20)REGEXFIND(rgx, name, fnm) +
	blank20 +
	blank20 +
	blank5;
shared string65 FormatNameLS(string rgx, string name, integer lnm, integer sfx) := 
	blank20 +
	blank20 +
	FilterLName(REGEXFIND(rgx, name, lnm)) +
	(string5)genToAlpha(REGEXFIND(rgx, name, sfx));
	

export string70 FormatName(string s, NameFormat fmt = 0, string1 clue='U') := FUNCTION
	n := IF(fmt = 0, PersonalNameFormat(s), fmt);

	return 
		blank5 +
		CASE (n,
			NameFormat.NoName =>	'',
			NameFormat.FL =>		FormatNameFL(rgxFL, s, 1, 2),
			NameFormat.LF =>		MAP(
									TRIM(REGEXFIND(rgxLF, s, 2)) in ['MAC','VAN'] and IsSureSuffix(REGEXFIND(rgxLF, s, 5)) =>
													FormatNameFLS(rgxLF, s, 2, 4, 5),
									StandaloneFirstLast(rgxLF, s, 1, 5) => FormatNameFL(rgxLF, s, 1, 5),
										FormatNameFL(rgxLF, s, 5, 1)),
			NameFormat.LFM =>	IF(IsSureGen(REGEXFIND(rgxLFM, s, 5)),
													FormatNameFLS(rgxLFM, s, 6, 1, 5),
													FormatNameFML(rgxLFM, s, 5, 6, 1)),
			NameFormat.FLorLF => 	CASE(GetNameOrderFL(rgxFLoLF, s, 1, 3, 3, 1, clue),
										'F' => FormatNameFL(rgxFLoLF, s, 1, 3),
										'L' => FormatNameFL(rgxFLoLF, s, 3, 1),
										FormatNameFL(rgxFLoLF, s, 1, 3)
									),		
			NameFormat.FLcS =>		FormatNameFLS(rgxFLcS, s, 1, 2, 6),
			NameFormat.FLS =>		FormatNameFLS(rgxFLS, s, 1, 2, 6),
			NameFormat.LFS =>		FormatNameFLS(rgxLFS, s, 5, 1, 6),
			NameFormat.FLSorLFS =>	CASE(GetNameOrderFL(rgxFLSorLFS, s, 1, 2, 2, 1),
										'F' => FormatNameFLS(rgxFLSorLFS, s, 1, 2, 3),
										'L' => FormatNameFLS(rgxFLSorLFS, s, 2, 1, 3),
										FormatNameFLS(rgxFLSorLFS, s, 1, 2, 3)
									),
			NameFormat.FLL =>	IF(IsSuffix(REGEXFIND(rgxFLL, s, 6)),
													FormatNameFLS(rgxFLL, s, 1, 2, 6),
												CASE(GetNameOrderFL(rgxFLL, s, 1, 6, 6, 2),
					/* FL or MLF */		'F' => FormatNameFLL(rgxFLL, s, 1, 2, 6),
										'L' => FormatNameFML(rgxFLL, s, 6, 1, 2),
										FormatNameFLL(rgxFLL, s, 1, 2, 6)
									)),
			NameFormat.FLLS =>		FormatNameFLLS(rgxFLLS, s, 1, 2, 6, 9),
			NameFormat.FxL =>		FormatNameFL(rgxFxL, s, 1, 2),
			NameFormat.FxLS =>		FormatNameFLS(rgxFxLS, s, 1, 2, 5),
			NameFormat.LxFM =>		FormatNameFML(rgxLxFM, s, 3, 4, 1),
			NameFormat.FxLL =>		FormatNameFL(rgxFxLL, s, 1, 3),

			NameFormat.FMLL => IF(IsSureSuffix(REGEXFIND(rgxFMLL, s, 1)),
										FormatNameFMLS(rgxFMLL, s, 4, 5, 8, 1), 
										CASE(GetNameOrderFMLL(rgxFMLL, s, 1, 4, 5, 8),
										'F' => FormatNameFMLL(rgxFMLL, s, 1, 4, 5, 8),		// FMLL
										'L' => FormatNameFMML(rgxFMLL, s, 4, 5, 8, 1),		// LFMM
										'U' => FormatNameFMML(rgxFMLL, s, 1, 4, 5, 8),		// FMML
										'X' => FormatNameFMLL(rgxFMLL, s, 4, 5, 8, 1),		// LFML
										'Y' => FormatNameFMLL(rgxFMLL, s, 5, 8, 1, 4),		// LLFF
										FormatNameFMML(rgxFMLL, s, 4, 5, 8, 1)						// LLMM
									)),
			NameFormat.FMiMiL =>	IF(IsSureSuffix(REGEXFIND(rgxFMiMiL, s, 1)),
														FormatNameFMLS(rgxFMiMiL, s, 2, 3, 4, 1),
															IF(TRIM(REGEXFIND(rgxFMiMiL, s, 3)) = 'O',
																FormatNameFML(rgxFMiMiL, s, 1, 2, 4, 'O'),
																FormatNameFML(rgxFMiMiL, s, 1, 2, 4)
															)
														),
			NameFormat.LFMiMi =>	FormatNameFML(rgxLFMiMi,s, 4, 5, 1),
			NameFormat.LFMiM =>		CASE(GetNameOrderFML(rgxLFMiM, s, 1, 2, 4, 1, 'U', 2, 4),
										'F' => IF(TRIM(REGEXFIND(rgxLFMiM, s, 3))='O',
														FormatNameFML(rgxLFMiM, s, 1, 2, 4, 'O'),
														FormatNameFML(rgxLFMiM, s, 1, 2, 4)
													),
										'L' => FormatNameFML(rgxLFMiM, s, 2, 4, 1),
										'U' => FormatNameFML(rgxLFMiM, s, 4, 1, 2),
										FormatNameFML(rgxLFMiM,s, 1, 3, 4)
									),
			NameFormat.FMML =>	IF(TRIM(REGEXFIND(rgxFMML, s, 3))='O',
														FormatNameFML(rgxFMML, s, 1, 2, 4, 'O'),
														FormatNameFMML(rgxFMML, s, 1, 2, 3, 4)),
			NameFormat.FMMLS =>	IF(TRIM(REGEXFIND(rgxFMMLS, s, 3))='O',
														FormatNameFMLS(rgxFMMLS, s, 1, 2, 4, 7, 'O'),
														FormatNameFMMLS(rgxFMMLS, s, 1, 2, 3, 4, 7)
													),
			NameFormat.FMSL =>		FormatNameFMLS(rgxFMSL, s, 1, 2, 4, 3),
			NameFormat.LFiMi =>		FormatNameFML(rgxLFiMi, s, 4, 5, 1),
			NameFormat.LFMi =>		CASE(GetNameOrderLFMi(rgxLFMi, s, 4, 1),
											'F' => FormatNameFML(rgxLFMi, s, 1, 5, 4),
											'L' => FormatNameFML(rgxLFMi, s, 4, 5, 1),
											FormatNameFML(rgxLFMi, s, 4, 5, 1)
										),

			NameFormat.FML =>		FormatNameFML(rgxFML, s, 1, 2, 3),
			NameFormat.ILI =>		FormatNameFL(rgxILI, s, 1, 2),
			NameFormat.FMLorLFM => 	CASE(GetNameOrderFML(rgxFMLorLFM, s, 1, 4, 5, 1, clue, 4, 5),
										'F' => FormatNameFML(rgxFMLorLFM, s, 1, 4, 5),	// FML
										'L' => FormatNameFML(rgxFMLorLFM, s, 4, 5, 1),	// LFM
										'U' => FormatNameFML(rgxFMLorLFM, s, 5, 1, 4),	// MLF
										FormatNameFML(rgxFMLorLFM, s, 1, 4, 5)
									),
			NameFormat.FMLSorLFMS => CASE(GetNameOrderFML(rgxFMLS, s, 1, 2, 3, 1, 'U', 2, 3),
										'F' => FormatNameFMLS(rgxFMLS, s, 1, 2, 3, 6),	// FML
										'L' => FormatNameFMLS(rgxFMLS, s, 2, 3, 1, 6),	// LFM
										'U' => FormatNameFMLS(rgxFMLS, s, 3, 1, 2, 6),	// MLF
										FormatNameFMLS(rgxFMLS, s, 1, 2, 3, 6)
									),
			NameFormat.LFMicS => 	FormatNameFMLS(rgxLFMicS, s, 4, 5, 1, 6),
			NameFormat.FMLcIII =>	FormatNameFML(rgxFMLcIII, s, 1, 2, 3),
			NameFormat.FMLcS => 	FormatNameFMLS(rgxFMLcS, s, 1, 2, 3, 6),
			NameFormat.FMcSL => 	FormatNameFMLS(rgxFMcSL, s, 1, 2, 4, 3),
			NameFormat.LcFMS => 	FormatNameFMLS(rgxLcFMS, s, 4, 5, 1, 6),
			NameFormat.LcFMcS => 	FormatNameFMLS(rgxLcFMcS, s, 4, 5, 1, 6),
			NameFormat.LScF => 		FormatNameFLS(rgxLScF, s, 5, 1, 4),
			NameFormat.LSFM => 		FormatNameFMLS(rgxLSFM, s, 5, 7, 1, 4),
			NameFormat.LScFM => 	FormatNameFMLS(rgxLScFM, s, 7, 8, 1, 4),
			NameFormat.LScFMM => 	FormatNameFMLS(rgxLScFMM, s, 7, 8, 1, 4),
			NameFormat.LcScF => 	FormatNameFLS(rgxLcScF, s, 7, 1, 4),
			NameFormat.LcScFM => 	FormatNameFMLS(rgxLcScFM, s, 7, 8, 1, 4),
			NameFormat.LFMiS =>		FormatNameFMLS(rgxLFMiS, s, 4, 5, 1, 6),
			NameFormat.LFMS => 		FormatNameFMLS(rgxLFMS, s, 4, 5, 1, 6),
			NameFormat.FMLLS => 	FormatNameFMLS(rgxFMLLS, s, 1, 2, 6, 9),
			NameFormat.LcFMM => 	CASE(REGEXFIND(rgxLcFMM, s, 1),
															'JR' => FormatNameFMLS(rgxLcFMM, s, 5, 6, 4, 1),
															'III' => FormatNameFMLS(rgxLcFMM, s, 5, 6, 4, 1),
															'MC' => FormatNameFMLL(rgxLcFMM, s, 5, 6, 1, 4),
															'ST' => FormatNameFMLL(rgxLcFMM, s, 5, 6, 1, 4),
															'XX' => FormatNameFML(rgxLcFMM, s, 4, 5, 6),
															FormatNameFMML(rgxLcFMM, s, 4, 5, 6, 1)),
			NameFormat.LcSFM => 	FormatNameFMLS(rgxLcSFM, s, 5, 7, 1, 4),
			NameFormat.LFSM =>		IF(LENGTH(REGEXFIND(rgxLFSM, s, 6)) = 1,
															IF(GetNameOrderFL(rgxLFSM, s, 1, 4, 4, 1) = 'F',
																FormatNameFMLS(rgxLFSM, s, 1, 6, 4, 5),
																FormatNameFMLS(rgxLFSM, s, 4, 6, 1, 5)),
															IF( GetNameOrderFL(rgxLFSM, s, 1, 4, 6, 1) = 'F',
																FormatNameFMLS(rgxLFSM, s, 1, 4, 6, 5),
																FormatNameFMLS(rgxLFSM, s, 4, 6, 1, 5))),
			NameFormat.LFMMi =>		CASE(GetNameOrderFLL(rgxLFMMi, s, 1, 4, 5, 'U'),
										'F' => FormatNameFML(rgxLFMMi, s, 4, 5, 1),	// FML
										'L' => FormatNameFMLL(rgxLFMMi, s, 5, 6, 1, 4), //LL F Mi
										FormatNameFML(rgxLFMMi, s, 4, 5, 1)
									),
			NameFormat.LFi =>	FormatNameFL(rgxLFi, s, 4, 1),	
			NameFormat.LFiS =>		FormatNameFLS(rgxLFiS, s, 4, 1, 5),
			NameFormat.FiL =>		FormatNameFL(rgxFiL, s, 1, 2),
			NameFormat.FiML =>		CASE(GetNameOrderFL(rgxFiML, s, 2, 3, 3, 2),
										'F' => FormatNameFML(rgxFiML, s, 1, 2, 3),
										'L' => FormatNameFML(rgxFiML, s, 3, 1, 2),
										FormatNameFML(rgxFiML, s, 1, 2, 3)
									), //),
			NameFormat.FiLS =>		FormatNameFLS(rgxFiLS, s, 1, 2, 5),
			NameFormat.FiMLS =>		CASE(GetNameOrderFL(rgxFiMLS, s, 2, 3, 3, 2),
										'F' => FormatNameFMLS(rgxFiMLS, s, 1, 2, 3, 6),
										'L' => FormatNameFMLS(rgxFiMLS, s, 3, 1, 2, 6),
										FormatNameFMLS(rgxFiMLS, s, 1, 2, 3, 6)
									), //),
			NameFormat.FMiL =>		CASE(GetNameOrderFMiL(rgxFMiL, s, 1, 3, 3, 1, clue),
										'F' => FormatNameFML(rgxFMiL, s, 1, 2, 3),
										'L' => FormatNameFML(rgxFMiL, s, 3, 2, 1),
										FormatNameFML(rgxFMiL, s, 2, 3, 1)
									),
			NameFormat.FMiLS =>	CASE(GetNameOrderFMiL(rgxFMiLS, s, 1, 3, 3, 1, clue),
										'F' => FormatNameFMLS(rgxFMiLS, s, 1, 2, 3, 6),
										'L' => FormatNameFMLS(rgxFMiLS, s, 2, 3, 1, 6),
										FormatNameFMLS(rgxFMiLS, s, 1, 2, 3, 6)
									),
			NameFormat.FMiLI =>	IF(IsSureGen(REGEXFIND(rgxFMiLI, s, 3)),
													FormatNameFMLS(rgxFMiLI, s, 2, 6, 1, 3),
													CASE(GetNameOrderFL(rgxFMiLI, s, 1, 3, 3, 1, 'U'),
										'F' => FormatNameFML(rgxFMiLI, s, 1, 2, 3),
										'L' => FormatNameFML(rgxFMiLI, s, 3, 2, 1),
										FormatNameFML(rgxFMiLI, s, 1, 2, 3)
									)),
			NameFormat.LFcMi =>		CASE(GetNameOrderFL(rgxLFcMi, s, 1, 4, 4, 1, 'U'),
															'F' => FormatNameFML(rgxLFcMi, s, 1, 5, 4),
															'L' => FormatNameFML(rgxLFcMi, s, 4, 5, 1),
															FormatNameFLL(rgxLFcMi, s, 5, 1, 4)
														),
			NameFormat.LcF =>		FormatNameFL(rgxLcF, s, 4, 1),
			NameFormat.LcTF =>		FormatNameFL(rgxLcTF, s, 5, 1),
			NameFormat.LcFM =>		FormatNameFML(rgxLcFM, s, 4, 5, 1),
			NameFormat.LcFcS =>		FormatNameFLS(rgxLcFcS, s, 4, 1, 5),
			NameFormat.LcFcM => 	IF(IsSureGen(REGEXFIND(rgxLcFcM, s, 1)),
														FormatNameFLS(rgxLcFcM, s, 4, 5, 1),
														CASE(GetNameOrderFML(rgxLcFcM, s, 1, 4, 5, 1, 'U', 4, 5),
										'F' => FormatNameFML(rgxLcFcM, s, 1, 4, 5),	// FML
										'L' => FormatNameFML(rgxLcFcM, s, 4, 5, 1),	// LFM
										'U' => FormatNameFML(rgxLcFcM, s, 5, 1, 4),	// MLF
										FormatNameFML(rgxLcFcM, s, 1, 4, 5)
									)),
			NameFormat.FcMcL => 	FormatNameFML(rgxFcMcL, s, 1, 2, 3),
			NameFormat.FoLcMcL => CASE(GetNameOrderFML(rgxFoLcMcL, s, 1, 2, 3, 1, 'U', 2, 3),
										'F' => FormatNameFML(rgxFoLcMcL, s, 1, 2, 3),	// FML
										'L' => FormatNameFML(rgxFoLcMcL, s, 2, 3, 1),	// LFM
										'U' => FormatNameFML(rgxFoLcMcL, s, 3, 2, 1),	// MLF
										FormatNameFML(rgxFoLcMcL, s, 1, 2, 3)
									),
			
			NameFormat.LcFcMS =>	FormatNameFMLS(rgxLcFcMS, s, 4, 5, 1, 6),
			NameFormat.LcFcMcS =>	FormatNameFMLS(rgxLcFcMcS, s, 4, 5, 1, 6),
			NameFormat.LcFS =>		FormatNameFLS(rgxLcFS, s, 4, 1, 5),
			NameFormat.LLcFM =>		MAP(
															IsSuffix(TRIM(REGEXFIND(rgxLLcFM, s, 7))) => FormatNameFMLS(rgxLLcFM, s, 1, 4, 9, 7),
															TRIM(REGEXFIND(rgxLLcFM, s, 9)) = '' => FormatNameFLL(rgxLLcFM, s, 7, 1, 4),
															FormatNameFMLL(rgxLLcFM, s, 7, 9, 1, 4)),
			NameFormat.LLcFS =>		FormatNameFLS(rgxLLcFS, s, 7, 1, 8),
			NameFormat.LcFhF =>		FormatNameFL(rgxLcFhF, s, 2, 1),
			NameFormat.FiIIL =>		FormatNameFL(rgxFiIIL, s, 1, 2),
			NameFormat.SFL =>		FormatNameFLS(rgxSFL, s, 2, 3, 1),
			NameFormat.FSL =>		CASE(GetNameOrderFL(rgxFSL, s, 1, 3, 3, 1),
										'F' => FormatNameFLS(rgxFSL, s, 1, 3, 2),
										'L' => FormatNameFLS(rgxFSL, s, 3, 1, 2),
										FormatNameFLS(rgxFSL, s, 1, 3, 2)
									),
			NameFormat.FMLyL =>		FormatNameFML(rgxFMLyL,s, 1, 2, 3),

			NameFormat.FccL =>		FormatNameFL(rgxFccL, s, 1, 2),

			NameFormat.L =>			IF(GetNameType(REGEXFIND(rgxL,s,1)) = 'F',
										FormatNameF(rgxL, s, 1),
										FormatNameL(rgxL, s, 1)),
			NameFormat.LS =>		FormatNameLS(rgxLS, s, 1, 4),
			'');
END;
			//*** Dual Names
export string70 FormatName1(string s, NameFormat fmt = 0, string1 clue='U') := FUNCTION
	n := IF(fmt = 0, DualNameFormat(s), fmt);
	return blank5 +
		CASE (n,
			NameFormat.LFiaFi =>	FormatNameFL(rgxLFiaFi, s, 4, 1),
			NameFormat.LFiaFiMi =>	FormatNameFL(rgxLFiaFiMi, s, 2, 1),
			NameFormat.FiMiaFiL =>	FormatNameFML(rgxFiMiaFiL, s, 1, 2, 5),
			NameFormat.LFiaFiL =>	FormatNameFL(rgxLFiaFiL, s, 2, 1),
			NameFormat.LFiMiaFiMi =>FormatNameFML(rgxLFiMiaFiMi, s, 4, 5, 1),
			NameFormat.LFaF =>		CASE(GetNameOrderFL(rgxLFaF, s, 1, 4, 4, 1, 'L'),
										'F' => FormatNameFL(rgxLFaF, s, 1, 4),
										'L' => FormatNameFL(rgxLFaF, s, 4, 1),
										FormatNameFL(rgxLFaF, s, 4, 1)
									),
			NameFormat.LFaFS =>		IF(ExtractNameTypes(rgxLFaFS, s, 4, 1) in ['LF','LB'],
															FormatNameFL(rgxLFaFS, s, 1, 4),
															FormatNameFL(rgxLFaFS, s, 4, 1)),
			//NameFormat.FMiaFL =>	CASE(GetNameOrderFL(rgxFMiaFL, s, 5, 7, 7, 5),
			//												'L' => FormatNameFML(rgxFMiaFL, s, 1, 3, 5),
			//												FormatNameFML(rgxFMiaFL, s, 1, 3, 7)),
			NameFormat.FMiaFL =>	CASE(GetNameOrderNNaNN(ExtractNameTypes4(rgxFMiaFL, s, 1, 3, 5, 7)),
															'LFFL' => FormatNameFL(rgxFMiaFL, s, 3, 1),
															'LFLF' => FormatNameFL(rgxFMiaFL, s, 3, 1),
															'FFLF' => FormatNameFML(rgxFMiaFL, s, 1, 3, 5),
															//'LFFM' => FormatNameFL(rgxFMiaFL, s, 3, 1),
															FormatNameFML(rgxFMiaFL, s, 1, 3, 7)),
			NameFormat.FMaFL =>	CASE(GetNameOrderNNaNN(ExtractNameTypes4(rgxFMaFL, s, 1, 3, 5, 7)),
														'FLLF' => FormatNameFL(rgxFMaFL, s, 1, 3),
														'FLFL' => FormatNameFL(rgxFMaFL, s, 1, 3),
														'LFFL' => FormatNameFL(rgxFMaFL, s, 3, 1),
															FormatNameFML(rgxFMaFL, s, 1, 3, 7)),
			NameFormat.FLaFL =>		FormatNameFL(rgxFLaFL, s, 1, 2),
			NameFormat.LFaFL =>		FormatNameFL(rgxLFaFL, s, 2, 1),
			// following could also be FLaFL of FLaFM 
			NameFormat.LFaFM =>		CASE(GetNameOrderNNaNN(ExtractNameTypes4(rgxLFaFM, s, 1, 4, 6, 7)),
														'FLFM' => FormatNameFL(rgxLFaFM, s, 1, 4),
														'FMFL' => FormatNameFML(rgxLFaFM, s, 1, 4, 7),
														'FLFL' => FormatNameFL(rgxLFaFM, s, 1, 4),
														'LFLF' => FormatNameFL(rgxLFaFM, s, 4, 1),
														'FLLF' => FormatNameFL(rgxLFaFM, s, 1, 4),
														'LFFM' => FormatNameFL(rgxLFaFM, s, 4, 1),
														'LFFL' => FormatNameFL(rgxLFaFM, s, 4, 1),
														'FFLF' => FormatNameFML(rgxLFaFM, s, 1, 4, 6),
														FormatNameFL(rgxLFaFM, s, 4, 1)),
														//IF(LENGTH(TRIM(REGEXFIND(rgxLFaFM, s, 7)))=1,
														//FormatNameFML(rgxLFaFM, s, 1, 4, 6),
														//FormatNameFML(rgxLFaFM, s, 1, 4, 7))),
			NameFormat.FLaFM =>		FormatNameFL(rgxFLaFM, s, 1, 2),
			NameFormat.FSaFL =>		FormatNameFLS(rgxFSaFL, s, 1, 5, 2),
			NameFormat.FMLaFML  =>	FormatNameFML(rgxFMLaFML, s, 1, 2, 3),
			NameFormat.FMLaFML2  =>	CASE(GetNameOrderFML(rgxFMLaFML2, s, 1, 3, 3, 1, 'U', 2, 3),
																'F' => FormatNameFML(rgxFMLaFML2, s, 1, 2, 3),
																'L' => FormatNameFML(rgxFMLaFML2, s, 2, 3, 1),
																'U' => FormatNameFML(rgxFMLaFML2, s, 3, 1, 2),
																FormatNameFML(rgxFMLaFML2, s, 1, 2, 3)),
			NameFormat.FMLcFML  =>	CASE(GetNameOrderFML(rgxFMLcFML, s, 1, 2, 3, 1, 'U', 2, 3),
										'F' => FormatNameFML(rgxFMLcFML, s, 1, 2, 3),
										'L' => FormatNameFML(rgxFMLcFML, s, 2, 3, 1),
										'U' => FormatNameFML(rgxFMLcFML, s, 3, 1, 2),
										FormatNameFML(rgxFMLcFML, s, 1, 2, 3)
									),
			NameFormat.LFMSaFML  =>	FormatNameFMLS(rgxLFMSaFML, s, 4, 5, 1, 6),
			NameFormat.FMLSaFML  =>	FormatNameFMLS(rgxFMLSaFML, s, 1, 2, 3, 6),
			NameFormat.LFMaLFM  =>	MAP(
																IsSureGen(REGEXFIND(rgxLFMaLFM, s, 4)) => FormatNameFLS(rgxLFMaLFM, s, 5, 1, 4),
																LENGTH(TRIM(REGEXFIND(rgxLFMaLFM, s, 5))) = 1 => FormatNameFML(rgxLFMaLFM, s, 4, 5, 1),
																CASE(GetNameOrderFML(rgxLFMaLFM, s, 1, 4, 5, 1, 'L', 5, 4),
																		'F' => FormatNameFML(rgxLFMaLFM, s, 1, 4, 5),
																		'L' => FormatNameFML(rgxLFMaLFM, s, 4, 5, 1),
																		'U' => FormatNameFML(rgxLFMaLFM, s, 4, 5, 1),
																		FormatNameFML(rgxLFMaLFM, s, 4, 5, 1)
																)),
			NameFormat.FLSaIFI =>	FormatNameFLS(rgxFLSaIFI, s, 1, 2, 5),
			NameFormat.LFMiaIFI =>	FormatNameFML(rgxLFMiaIFI, s, 2, 3, 1),
			NameFormat.FMLaIFI =>	FormatNameFML(rgxFMLaIFI, s, 1, 2, 3),
			NameFormat.LFMaFMiI =>	FormatNameFML(rgxLFMaFMiI, s, 4, 5, 1),
			NameFormat.LFMaFiMiI =>	FormatNameFML(rgxLFMaFiMiI, s, 4, 5, 1),
			NameFormat.LFMaFiMiL =>	FormatNameFML(rgxLFMaFiMiL, s, 4, 5, 1),
			NameFormat.LFMaFMS =>	FormatNameFML(rgxLFMaFMS, s, 4, 5, 1),
			NameFormat.LFMaLFM2 => 	IF(IsSureGen(REGEXFIND(rgxLFMaLFM2, s, 5)),
															FormatNameFLS(rgxLFMaLFM2, s, 4, 1, 5),
										CASE(GetNameOrderFML(rgxLFMaLFM2, s, 1, 4, 5, 1, 'U', 4, 5),
										'F' => FormatNameFML(rgxLFMaLFM2, s, 1, 4, 5),
										'L' => FormatNameFML(rgxLFMaLFM2, s, 4, 5, 1),
										'U' => FormatNameFML(rgxLFMaLFM2, s, 5, 1, 4),
										FormatNameFML(rgxLFMaLFM2, s, 1, 4, 5)
									)),
			NameFormat.LFMaLFM2S => CASE(GetNameOrderFML(rgxLFMaLFM2S, s, 1, 4, 5, 1, 'U', 4, 5),
										'F' => FormatNameFML(rgxLFMaLFM2S, s, 1, 4, 5),
										'L' => FormatNameFML(rgxLFMaLFM2S, s, 4, 5, 1),
										'U' => FormatNameFML(rgxLFMaLFM2S, s, 5, 1, 4),
										FormatNameFML(rgxLFMaLFM2S, s, 1, 4, 5)
									),
			NameFormat.LFMaFML =>	FormatNameFML(rgxLFMaFML, s, 4, 5, 1),
			NameFormat.FLSaFM =>	CASE(GetNameOrderFL(rgxFLSaFM, s, 1, 2, 2, 1),
										'F' => FormatNameFLS(rgxFLSaFM, s, 1, 2, 5),
										'L' => FormatNameFLS(rgxFLSaFM, s, 2, 1, 5),
										FormatNameFLS(rgxFLSaFM, s, 1, 2, 5)
									),
			NameFormat.LSFaFM =>	FormatNameFLS(rgxLSFaFM, s, 5, 1, 4),
			NameFormat.LSFMaFM =>	FormatNameFMLS(rgxLSFMaFM, s, 5, 6, 1, 4),
			NameFormat.LFiSaI  =>	FormatNameFLS(rgxLFiSaI, s, 4, 1, 5),
			NameFormat.FMiSaFL  =>	FormatNameFMLS(rgxFMiSaFL, s, 1, 2, 6, 3),
			NameFormat.FMLaFL =>	FormatNameFML(rgxFMLaFL, s, 1, 2, 3),
			//NameFormat.LFMaFM =>	FormatNameFML(rgxLFMaFM, s, 4, 6, 1),
			NameFormat.LFMaFM =>	CASE(GetNameOrderFL(rgxLFMaFM, s, 1, 4, 6, 1),
										'F' => FormatNameFML(rgxLFMaFM, s, 1, 4, 6),
										'L' => FormatNameFML(rgxLFMaFM, s, 4, 6, 1),
										FormatNameFML(rgxLFMaFM, s, 4, 6, 1)
									),
			NameFormat.FMLaFM =>	CASE(GetNameOrderFML(rgxFMLaFM, s, 1, 4, 4, 1, 'U', 3, 4),
										'F' => FormatNameFML(rgxFMLaFM, s, 1, 3, 4),
										'L' => FormatNameFML(rgxFMLaFM, s, 3, 4, 1),
										'U' => FormatNameFML(rgxFMLaFM, s, 4, 1, 3),
										FormatNameFML(rgxFMLaFM, s, 1, 3, 4)
									),
			NameFormat.LFMiaFM  =>	FormatNameFML(rgxLFMiaFM, s, 4, 5, 1),
			NameFormat.LFMiaF  =>	FormatNameFML(rgxLFMiaF, s, 4, 5, 1),
			NameFormat.LFMiaFMiL => FormatNameFML(rgxLFMiaFMiL, s, 4, 5, 1),
			NameFormat.FMiaFMiL => FormatNameFML(rgxFMiaFMiL, s, 1, 2, 6),
			NameFormat.LFaFMiS => FormatNameFL(rgxLFaFMiS, s, 4, 1),
			NameFormat.FMiaFMiMiL => FormatNameFML(rgxFMiaFMiMiL, s, 1, 2, 6),
			NameFormat.LFMaLFMS => FormatNameFML(rgxLFMaLFMS, s, 4, 5, 1),
			NameFormat.LcFMaFMS =>	FormatNameFML(rgxLcFMaFMS, s, 4, 5, 1),
			NameFormat.LcFMaF =>	if(IsSureSuffix(REGEXFIND(rgxLcFMaF, s, 4)),
															FormatNameFLS(rgxLcFMaF, s, 5, 1, 4),
															FormatNameFML(rgxLcFMaF, s, 4, 5, 1)),
			NameFormat.LcFMaFMM =>	if(IsSureSuffix(REGEXFIND(rgxLcFMaFMM, s, 5)),
															FormatNameFLS(rgxLcFMaFMM, s, 4, 1, 5),
															FormatNameFML(rgxLcFMaFMM, s, 4, 5, 1)), // nameOrGen
			NameFormat.LcSFaFMM =>	FormatNameFLS(rgxLcSFaFMM, s, 5, 1, 4),
			NameFormat.LcFMiMiaFMM =>	FormatNameFMML(rgxLcFMiMiaFMM, s, 4, 5, 6, 1), 		
			NameFormat.FMaFLS =>	IF(GetNameOrderFL(rgxFMaFLS, s, 1, 5, 2, 1)='F', FormatNameFML(rgxFMaFLS, s, 1, 2, 5),
																					FormatNameFL(rgxFMaFLS, s, 2, 1)),
			NameFormat.LFaFMS =>	FormatNameFL(rgxLFaFMS, s, 4, 1),
			NameFormat.FMSaFML =>	FormatNameFMLS(rgxFMSaFML, s, 1, 2, 9, 3),
			NameFormat.LFaLF	 =>	FormatNameFL(rgxLFaLF, s, 4, 1),
			NameFormat.LFaLF1	 =>	FormatNameFL(rgxLFaLF1, s, 4, 1),
			NameFormat.LFaLcF	 =>	FormatNameFL(rgxLFaLcF, s, 4, 1),
			NameFormat.LFaLFM =>	GetFormatNameFL(rgxLFaLFM, s, 2, 1),
			NameFormat.LFaLFM2 =>	FormatNameFL(rgxLFaLFM2, s, 4, 1),
			NameFormat.LFaFMiMi =>	FormatNameFL(rgxLFaFMiMi, s, 4, 1),
			NameFormat.FMaFML =>	CASE(GetNameOrder2Names(ExtractNameTypes2(rgxFMaFML, s, 1, 2)),
															'FM' => FormatNameFML(rgxFMaFML,s, 1, 2, 6),
															'LF' => FormatNameFL(rgxFMaFML, s, 2, 1),
															FormatNameFL(rgxFMaFML, s, 1, 2)),
			NameFormat.FiaFiL =>	FormatNameFL(rgxFiaFiL, s, 1, 4),
			NameFormat.FaFL =>		FormatNameFL(rgxFaFL, s, 1, 4),
			NameFormat.FaFLS =>		FormatNameFL(rgxFaFLS, s, 1, 4),
			NameFormat.FaFMLS =>	FormatNameFL(rgxFaFMLS, s, 1, 5),
			NameFormat.FMaFMLS =>	FormatNameFML(rgxFMaFMLS, s, 1, 2, 6),
			NameFormat.FaFML =>		FormatNameFL(rgxFaFML, s, 1, 6),
			NameFormat.LcFMSaFMM =>	FormatNameFMLS(rgxLcFMSaFMM, s, 4, 5, 1, 6),
			NameFormat.LFMSaFMM =>	CASE(GetNameOrderFML(rgxLFMSaFMM, s, 1, 4, 5, 1, 'U', 4, 5),
										'F' => FormatNameFMLS(rgxLFMSaFMM, s, 1, 4, 5, 6),	// FMLS
										'L' => FormatNameFMLS(rgxLFMSaFMM, s, 4, 5, 1, 6),	// LFMS
										'U' => FormatNameFMLS(rgxLFMSaFMM, s, 5, 1, 4, 6),	// MLFS
										FormatNameFMLS(rgxLFMSaFMM, s, 1, 4, 5, 6)
									),
			NameFormat.LcFaF 	=>	FormatNameFL(rgxLcFaF, s, 4, 1),
			NameFormat.LcFaFM 	=>	FormatNameFL(rgxLcFaFM, s, 4, 1),
			NameFormat.LcFMaLcF =>	if(IsSureSuffix(REGEXFIND(rgxLcFMaLcF, s, 4)),
															FormatNameFLS(rgxLcFMaLcF, s, 5, 1, 4),
															FormatNameFML(rgxLcFMaLcF, s, 4, 5, 1)),
			NameFormat.LcFMaLcFS =>	FormatNameFML(rgxLcFMaLcFS, s, 4, 5, 1),
			NameFormat.LcFMaLcFM =>	FormatNameFML(rgxLcFMaLcFM, s, 4, 5, 1),
			NameFormat.LcFMSaLcFM =>FormatNameFML(rgxLcFMSaLcFM, s, 4, 5, 1),
			NameFormat.LcFaLcF =>	FormatNameFL(rgxLcFaLcF, s, 4, 1),	
			NameFormat.LcFaLcFM =>	FormatNameFL(rgxLcFaLcFM, s, 4, 1),	
			NameFormat.LScFMaFML => FormatNameFMLS(rgxLScFMaFML, s, 3, 5, 1, 2),
			'');
END;
// format the second name of a dual name
export string70 FormatName2(string s, NameFormat fmt = 0) := FUNCTION
	n := IF(fmt = 0, DualNameFormat(s), fmt);

	return blank5 +
		CASE (n,
			//*** Dual Names
			NameFormat.LFiaFi =>	FormatNameFL(rgxLFiaFi, s, 6, 1),
			NameFormat.LFiaFiMi =>	FormatNameFML(rgxLFiaFiMi, s, 4, 5, 1),
			NameFormat.FiMiaFiL =>	FormatNameFL(rgxFiMiaFiL, s, 4, 5),
			NameFormat.LFiaFiL =>	FormatNameFL(rgxLFiaFiL, s, 4, 5),
			NameFormat.LFiMiaFiMi =>FormatNameFML(rgxLFiMiaFiMi, s, 7, 8, 1),
			NameFormat.LFaF =>		CASE(GetNameOrderFL(rgxLFaF, s, 1, 4, 4, 1, 'L'),
										'F' => FormatNameFL(rgxLFaF, s, 7, 4),
										'L' => FormatNameFL(rgxLFaF, s, 7, 1),
										FormatNameFL(rgxLFaF, s, 7, 1)
									),
			NameFormat.LFaFS =>		IF(ExtractNameTypes(rgxLFaFS, s, 4, 1) in ['LF','LB'],
															FormatNameFLS(rgxLFaFS, s, 7, 4, 9),
															FormatNameFLS(rgxLFaFS, s, 7, 1, 9)),
			//NameFormat.FMiaFL =>	CASE(GetNameOrderFL(rgxFMiaFL, s, 5, 7, 7, 5),
			//												'L' => FormatNameFL(rgxFMiaFL, s, 7, 5),
			//												FormatNameFL(rgxFMiaFL, s, 5, 7)),
			NameFormat.FMiaFL =>	CASE(GetNameOrderNNaNN(ExtractNameTypes4(rgxFMiaFL, s, 1, 3, 5, 7)),
															'LFFL' => FormatNameFL(rgxFMiaFL, s, 5, 7),
															'LFLF' => FormatNameFL(rgxFMiaFL, s, 7, 5),
															'FFLF' => FormatNameFL(rgxFMiaFL, s, 7, 5),
															//'LFFM' => FormatNameFML(rgxFMiaFL, s, 5, 7, 1),
															FormatNameFL(rgxFMiaFL, s, 5, 7)),
			NameFormat.FMaFL =>	CASE(GetNameOrderNNaNN(ExtractNameTypes4(rgxFMaFL, s, 1, 3, 5, 7)),
														'FLLF' => FormatNameFL(rgxFMaFL, s, 7, 5),
														'FLFL' => FormatNameFL(rgxFMaFL, s, 5, 7),
														'LFFL' => FormatNameFL(rgxFMaFL, s, 5, 7),
														FormatNameFL(rgxFMaFL, s, 5, 7)),
			NameFormat.FLaFL =>		FormatNameFL(rgxFLaFL, s, 6, 2),
			NameFormat.LFaFL =>		FormatNameFL(rgxLFaFL, s, 4, 1),
			// following could also be FLaFL
//			NameFormat.LFaFM =>		IF(ExtractNameTypes(rgxLFaFM, s, 6, 7) in
//																['FL','BL'],		// FL & FL
//														FormatNameFL(rgxLFaFM, s, 6, 7),
//														FormatNameFMML(rgxLFaFM, s, 6, 7, 8, 1)), 
			NameFormat.LFaFM =>		CASE(GetNameOrderNNaNN(ExtractNameTypes4(rgxLFaFM, s, 1, 4, 6, 7)),
														'FLFM' => FormatNameFML(rgxLFaFM, s, 6, 7, 4),
														'FMFL' => FormatNameFL(rgxLFaFM, s, 6, 7),
														'FLFL' => FormatNameFL(rgxLFaFM, s, 6, 7),
														'LFLF' => FormatNameFL(rgxLFaFM, s, 7, 6),
														'FLLF' => FormatNameFL(rgxLFaFM, s, 7, 6),
														'LFFM' => FormatNameFML(rgxLFaFM, s, 6, 7, 1),
														'LFFL' => FormatNameFL(rgxLFaFM, s, 6, 7),
														'FFLF' => FormatNameFL(rgxLFaFM, s, 7, 6),
														FormatNameFML(rgxLFaFM, s, 6, 7, 1)),
														//IF(LENGTH(TRIM(REGEXFIND(rgxLFaFM, s, 7)))=1,
														//FormatNameFL(rgxLFaFM, s, 7, 6),
														//FormatNameFL(rgxLFaFM, s, 6, 7))),
			NameFormat.FLaFM =>		FormatNameFML(rgxFLaFM, s, 6, 8, 2),
			NameFormat.FSaFL =>		FormatNameFL(rgxFSaFL, s, 4, 5),
			NameFormat.FMLaFML  =>	FormatNameFML(rgxFMLaFML, s, 7, 8, 3),
			NameFormat.FMLaFML2  =>	CASE(GetNameOrderFML(rgxFMLaFML2, s, 7, 8, 9, 7, 'U', 8, 9),
																'F' => FormatNameFML(rgxFMLaFML2, s, 7, 8, 9),
																'L' => FormatNameFML(rgxFMLaFML2, s, 8, 9, 7),
																'U' => FormatNameFML(rgxFMLaFML2, s, 9, 7, 8),
																FormatNameFML(rgxFMLaFML2, s, 7, 8, 9)),
			//NameFormat.FMLaFML2  =>	FormatNameFML(rgxFMLaFML2, s, 7, 8, 9),
			NameFormat.FMLcFML  =>	CASE(GetNameOrderFML(rgxFMLcFML, s, 6, 7, 8, 6, 'f', 7, 8),
										'F' => FormatNameFML(rgxFMLcFML, s, 6, 7, 8),
										'L' => FormatNameFML(rgxFMLcFML, s, 7, 8, 6),
										'U' => FormatNameFML(rgxFMLcFML, s, 8, 6, 7),
										FormatNameFML(rgxFMLcFML, s, 6, 7, 8)
									),
			NameFormat.LFMSaFML  =>	FormatNameFML(rgxLFMSaFML, s, 8, 9, 1),
			NameFormat.FMLSaFML  =>	FormatNameFML(rgxFMLSaFML, s, 8, 9, 10),
			NameFormat.LFMaLFM  =>		IF(
																		LENGTH(TRIM(REGEXFIND(rgxLFMaLFM, s, 9))) = 0,
																			CASE(GetNameOrderFL(rgxLFMaLFM, s, 1, 7, 7, 1, 'L'),
																			'F' => FormatNameFL(rgxLFMaLFM, s, 1, 7),
																			'L' => FormatNameFL(rgxLFMaLFM, s, 7, 1),
																			FormatNameFL(rgxLFMaLFM, s, 7, 1)),
																		CASE(GetNameOrderFML(rgxLFMaLFM, s, 1, 7, 9, 1, 'L', 7, 9),
																		'F' => FormatNameFML(rgxLFMaLFM, s, 1, 7, 9),
																		'L' => FormatNameFML(rgxLFMaLFM, s, 7, 9, 1),
																		'U' => FormatNameFML(rgxLFMaLFM, s, 7, 9, 1),
																		FormatNameFML(rgxLFMaLFM, s, 7, 9, 1)
																)),
			
			NameFormat.FLSaIFI =>	FormatNameFML(rgxFLSaIFI, s, 8, 9, 2),
			NameFormat.LFMiaIFI =>	FormatNameFML(rgxLFMiaIFI, s, 6, 7, 1),
			NameFormat.FMLaIFI =>	FormatNameFML(rgxFMLaIFI, s, 8, 9, 3), 
			NameFormat.LFMaFMiI =>	FormatNameFML(rgxLFMaFMiI, s, 7, 8, 1),
			NameFormat.LFMaFiMiI =>	FormatNameFML(rgxLFMaFiMiI, s, 7, 8, 1),
			NameFormat.LFMaFiMiL =>	FormatNameFML(rgxLFMaFiMiL, s, 7, 8, 9),
			NameFormat.LFMaFMS =>	FormatNameFMLS(rgxLFMaFMS, s, 7, 8, 1, 9),
			NameFormat.LFMaLFM2 => 	CASE(GetNameOrderFML(rgxLFMaLFM2, s, 7, 10, 11, 7, 'U', 10, 11),
										'F' => FormatNameFML(rgxLFMaLFM2, s, 7, 10, 11),
										'L' => FormatNameFML(rgxLFMaLFM2, s, 10, 11, 7),
										'U' => FormatNameFML(rgxLFMaLFM2, s, 11, 7, 10),
										FormatNameFML(rgxLFMaLFM2, s, 7, 10, 11)
									),
			NameFormat.LFMaLFM2S => CASE(GetNameOrderFML(rgxLFMaLFM2S, s, 7, 8, 9, 7, 'U', 8, 9),
										'F' => FormatNameFMLS(rgxLFMaLFM2S, s, 7, 8, 9, 10),
										'L' => FormatNameFMLS(rgxLFMaLFM2S, s, 8, 9, 7, 10),
										'U' => FormatNameFMLS(rgxLFMaLFM2S, s, 9, 7, 8, 10),
										FormatNameFMLS(rgxLFMaLFM2S, s, 7, 8, 9, 10)
									),
			NameFormat.LFMaFML =>	FormatNameFML(rgxLFMaFML, s, 7, 8, 1),
			NameFormat.FLSaFM => MAP(
											IsSureGen(REGEXFIND(rgxFLSaFM, s, 9)) => 
													CASE(GetNameOrderFL(rgxFLSaFM, s, 1, 2, 2, 1),
														'F' => FormatNameFLS(rgxFLSaFM, s, 7, 2, 9),
														'L' => FormatNameFLS(rgxFLSaFM, s, 7, 1, 9),
														FormatNameFML(rgxFLSaFM, s, 7, 9, 2)
													),
											IsFirstNameOrInitial(REGEXFIND(rgxFLSaFM, s, 7)) AND 
																IsFirstNameOrInitialOrBlank(REGEXFIND(rgxFLSaFM, s, 9)) =>
												CASE(GetNameOrderFL(rgxFLSaFM, s, 1, 2, 2, 1),
													'F' => FormatNameFML(rgxFLSaFM, s, 7, 9, 2),
													'L' => FormatNameFML(rgxFLSaFM, s, 7, 9, 1),
													FormatNameFML(rgxFLSaFM, s, 7, 9, 2)
												),
											IsLastNameEx(REGEXFIND(rgxFLSaFM, s, 9)) => FormatNameFL(rgxFLSaFM, s, 7, 9),
											FormatNameFL(rgxFLSaFM, s, 9, 7)),
			NameFormat.LSFaFM =>	FormatNameFML(rgxLSFaFM, s, 7, 8, 1),
			NameFormat.LSFMaFM =>	FormatNameFML(rgxLSFMaFM, s, 8, 9, 1),
			NameFormat.LFiSaI  =>	FormatNameFL(rgxLFiSaI, s, 7, 1),
			NameFormat.FMiSaFL  =>	FormatNameFL(rgxFMiSaFL, s, 5, 6),
			NameFormat.FMLaFL =>	FormatNameFL(rgxFMLaFL, s, 7, 3),  
			//NameFormat.LFMaFM =>	FormatNameFML(rgxLFMaFM, s, 8, 10, 1),
			NameFormat.LFMaFM =>	MAP(
															//REGEXFIND(rgxLFMaFM, s, 11) = '' => FormatNameFL(rgxLFMaFM, s, 8, 1),
															NOT IsFirstNameOrInitialOrBlank(REGEXFIND(rgxLFMaFM, s, 11)) => FormatNameFL(rgxLFMaFM, s, 8, 11),
															GetNameOrderFL(rgxLFMaFM, s, 1, 4, 6, 1) = 'F' => FormatNameFML(rgxLFMaFM, s, 8, 11, 6),
															FormatNameFML(rgxLFMaFM, s, 8, 11, 1)
														),
			NameFormat.FMLaFM =>	IF(ExtractNameTypes2(rgxFMLaFM, s, 8, 10) = 'FL',
															FormatNameFL(rgxFMLaFM, s, 8, 10),
										CASE(GetNameOrderFML(rgxFMLaFM, s, 1, 4, 4, 1, 'U', 3, 4),
											'F' => FormatNameFMLorFLS(rgxFMLaFM, s, 8, 10, 4, 10),
											'L' => FormatNameFMLorFLS(rgxFMLaFM, s, 8, 10, 1, 10),
											'U' => FormatNameFMLorFLS(rgxFMLaFM, s, 8, 10, 3, 10),
											FormatNameFMLorFLS(rgxFMLaFM, s, 8, 10, 3, 10)
									)),
			NameFormat.FaFL =>		FormatNameFL(rgxFaFL, s, 3, 4),
			NameFormat.LFMiaF  =>	FormatNameFL(rgxLFMiaF, s, 7, 1),
			NameFormat.LFMiaFM  =>	MAP(
																IsSureGen(REGEXFIND(rgxLFMiaFM, s, 8)) => FormatNameFLS(rgxLFMiaFM, s, 7, 1, 8),
																ExtractNameTypes2I(rgxLFMiaFM, s, 7, 8) in ['FL','FX'] => 
																					FormatNameFL(rgxLFMiaFM, s, 7, 8),
																ExtractNameTypes2I(rgxLFMiaFM, s, 7, 8) in ['LF'] => 
																					FormatNameFL(rgxLFMiaFM, s, 8, 7),
																FormatNameFML(rgxLFMiaFM, s, 7, 8, 1)), 
			NameFormat.LFMiaFMiL => //FormatNameFML(rgxLFMiaFMiL, s, 7, 8, 9),
															CASE(GetNameOrderFMiL(rgxLFMiaFMiL, s, 7, 9, 9, 7),
																'F' => FormatNameFML(rgxLFMiaFMiL, s, 7, 8, 9),
																'L' => FormatNameFML(rgxLFMiaFMiL, s, 9, 8, 7),
																FormatNameFML(rgxLFMiaFMiL, s, 7, 8, 9)
															),
			NameFormat.FMiaFMiL => FormatNameFML(rgxFMiaFMiL, s, 4, 5, 6),
			NameFormat.LFaFMiS => FormatNameFMLS(rgxLFaFMiS, s, 6, 7, 1, 8),
			NameFormat.FMiaFMiMiL => FormatNameFML(rgxFMiaFMiMiL, s, 4, 5, 6),
			NameFormat.LFMaLFMS => FormatNameFMLS(rgxLFMaLFMS, s, 10, 11, 7, 12),
			NameFormat.LcFMaFMS =>	FormatNameFMLS(rgxLcFMaFMS, s, 7, 8, 1, 10),
			NameFormat.LcFMaF =>	FormatNameFL(rgxLcFMaF, s, 7, 1),
			NameFormat.LcFMaFMM =>	MAP(
																IsSureSuffix(REGEXFIND(rgxLcFMaFMM, s, 7)) => FormatNameFLS(rgxLcFMaFMM, s, 8, 1, 7),
																ExtractNameTypes2(rgxLcFMaFMM, s, 7, 8) = 'FL' => FormatNameFL(rgxLcFMaFMM, s, 7, 8),
																FormatNameFML(rgxLcFMaFMM, s, 7, 8, 1)),
			NameFormat.LcSFaFMM =>	FormatNameFML(rgxLcSFaFMM, s, 7, 8, 1),
			NameFormat.LcFMiMiaFMM =>	FormatNameFMML(rgxLcFMiMiaFMM, s, 8, 9, 10, 1), 		
			NameFormat.FMaFLS =>	IF(GetNameOrderFL(rgxFMaFLS, s, 4, 5, 5, 4)='F', FormatNameFLS(rgxFMaFLS, s, 4, 5, 9),
																					FormatNameFLS(rgxFMaFLS, s, 5, 4, 9)),
			NameFormat.LFaFMS =>	FormatNameFMLS(rgxLFaFMS, s, 6, 7, 1, 8),
			NameFormat.FMSaFML =>	FormatNameFML(rgxFMSaFML, s, 7, 8, 9),
			NameFormat.LFaLF	 =>	FormatNameFL(rgxLFaLF, s, 6, 1),
			NameFormat.LFaLF1	 =>	FormatNameFL(rgxLFaLF1, s, 9, 6),
			NameFormat.LFaLcF	 =>	FormatNameFL(rgxLFaLcF, s, 9, 6),
			NameFormat.LFaLFM =>	GetFormatNameFML(rgxLFaLFM, s, 1, 4, 5),
			NameFormat.LFaLFM2 =>	FormatNameFML(rgxLFaLFM2, s, 9, 10, 6),
			NameFormat.LFaFMiMi =>	FormatNameFMML(rgxLFaFMiMi, s, 6, 9, 10, 1),
			NameFormat.FMaFML =>	CASE(GetNameOrderFML(rgxFMaFML, s, 4, 6, 6, 4, 'F', 5, 5),
										'F' => FormatNameFML(rgxFMaFML, s, 4, 5, 6),
										'L' => FormatNameFML(rgxFMaFML, s, 5, 6, 4),
										'U' => FormatNameFML(rgxFMaFML, s, 4, 5, 6),
										FormatNameFML(rgxFMaFML, s, 4, 5, 6)
									),			//FormatNameFML(rgxFMaFML, s, 4, 5, 6),
			NameFormat.FiaFiL =>	FormatNameFL(rgxFiaFiL, s, 3, 4), 
			NameFormat.FaFLS =>		FormatNameFLS(rgxFaFLS, s, 3, 4, 7),
			NameFormat.FaFMLS =>	FormatNameFMLS(rgxFaFMLS, s, 3, 4, 5, 8),
			NameFormat.FMaFMLS =>	FormatNameFMLS(rgxFMaFMLS, s, 4, 5, 6, 8),
			NameFormat.FaFML =>		FormatNameFML(rgxFaFML, s, 4, 5, 6),
			NameFormat.LcFMSaFMM =>	FormatNameFML(rgxLcFMSaFMM, s, 8, 9, 1),
			NameFormat.LFMSaFMM =>	CASE(GetNameOrderFML(rgxLFMSaFMM, s, 1, 4, 5, 1, 'U', 4, 5),
										'F' => FormatNameFML(rgxLFMSaFMM, s, 10, 11, 5),	// FMLS
										'L' => FormatNameFML(rgxLFMSaFMM, s, 10, 11, 1),	// LFMS
										'U' => FormatNameFML(rgxLFMSaFMM, s, 10, 11, 4),	// MLFS
										FormatNameFML(rgxLFMSaFMM, s, 10, 11, 5)
									),
			NameFormat.LcFaF 	=>	FormatNameFL(rgxLcFaF, s, 6, 1),
			NameFormat.LcFaFM 	=>	FormatNameFML(rgxLcFaFM, s, 6, 7, 1),
			NameFormat.LcFMaLcF =>	FormatNameFL(rgxLcFMaLcF, s, 10, 7),
			NameFormat.LcFMaLcFS =>	FormatNameFLS(rgxLcFMaLcFS, s, 10, 7, 11),
			NameFormat.LcFMaLcFM =>	FormatNameFML(rgxLcFMaLcFM, s, 10, 11, 7),
			NameFormat.LcFMSaLcFM =>FormatNameFML(rgxLcFMSaLcFM, s, 13, 14, 10),
			NameFormat.LcFaLcF =>	IF(IsSureSuffix(REGEXFIND(rgxLcFaLcF, s, 9)),
															FormatNameFLS(rgxLcFaLcF, s, 6, 1, 9),	
															FormatNameFL(rgxLcFaLcF, s, 9, 6)),	
			NameFormat.LcFaLcFM =>	FormatNameFML(rgxLcFaLcFM, s, 9, 10, 6),	
			NameFormat.LScFMaFML => FormatNameFML(rgxLScFMaFML, s, 7, 9, 1),
		
			'');
END;

shared titles :=
 '\\b(MR|MRS|MS|MMS|MISS|DR|REV|RABBI|REVEREND|MSGR|PROF|FR|LT COL|COL|LCOL|LTCOL|LTC|CH|LT GEN|LT CDR|LCDR|LT CMDR|MAJ|SFC|SRTA|APCO|CAPT|CPT|SGT|SSG|MSG|MGR|CPL|CPO|SHRF|SMSG|SMSGT|SIR)\\b';
export string Title (string s, NameFormat n, string1 clue='U', string fullname='') := FUNCTION
	clnname := FormatName(s, n);
	return MAP(
		n = NameFormat.LcTF =>		REGEXFIND(rgxLcTF, s, 4),
		REGEXFIND(titles, fullname) => REGEXFIND(titles, fullname, 1),
		REGEXFIND(rgxMrMrs, fullname) => REGEXFIND(rgxMrMrs, fullname, 2),
		CASE(NameTester.genderEx(clnname[6..25],clnname[26..45]),
			'M' => 'MR',
			'F' => 'MS',
		'')
	);
END;

// first title of dual name
export string Title1 (string s, NameFormat n, string1 clue='U', string fullname='') := FUNCTION
	clnname := FormatName1(s, n);
	return MAP(
		REGEXFIND(titles, fullname) => REGEXFIND(titles, fullname, 1),
		REGEXFIND(rgxMrMrs, fullname) => REGEXFIND(rgxMrMrs, fullname, 2),
		CASE(NameTester.genderEx(clnname[6..25],clnname[26..45]),
			'M' => 'MR',
			'F' => 'MS',
		'')
	);
END;
export string Title2 (string s, NameFormat n, string fullname='') := FUNCTION
	clnname := FormatName2(s, n);
	return	CASE(NameTester.genderEx(clnname[6..25],clnname[26..45]),
			'M' => 'MR',
			'F' => 'MS',
			'');
END;

shared boolean IsHyphenatedFirstName(string s) := MAP(
	REGEXFIND('([A-Z]+)-([A-Z]+)', s) => NameTester.IsFirstName(s) OR
											NameTester.IsFirstName(REGEXFIND('([A-Z]+)-([A-Z]+)', s, 1)),
	NameTester.IsFirstname(s));
	

shared set of NameFormat ValidatedDualNameFormats := [
				NameFormat.FLSaFM,
				NameFormat.FLSaIFI,
				NameFormat.FLaFL,
				NameFormat.FLaFM,
				NameFormat.FMLSaFML,
				NameFormat.FMLaFL,
				NameFormat.FMLaFML,
				NameFormat.FMLaFML2,
				NameFormat.FMLaIFI,
				NameFormat.FMLcFML,
				NameFormat.FMSaFML,
				NameFormat.FMaFMLS,
				NameFormat.FMiaFMiL,
				NameFormat.LFaFMiS,
				NameFormat.FMiaFMiMiL,
				NameFormat.LFMaLFMS,
				NameFormat.FaFLS,
				NameFormat.FaFMLS,
				NameFormat.FiMiaFiL,
				NameFormat.FiaFiL,
				NameFormat.LFMSaFML,
				NameFormat.LFMaFML,
				NameFormat.LFMaFMS,
				NameFormat.LFMaFMiI,
				NameFormat.LFMaFiMiI,
				NameFormat.LFMaFiMiL,
				NameFormat.LFMaLFM,
				NameFormat.LFMaLFM2,
				NameFormat.LFMaLFM2S,
				NameFormat.LFMiaF,
				NameFormat.LFMiaFM,
				NameFormat.LFMiaFMiL,
				NameFormat.LFMiaIFI,
				NameFormat.LFaFL,
				NameFormat.LFaFMS,
				NameFormat.LFaFS,
				NameFormat.FSaFL,
				NameFormat.LFaLF,
				NameFormat.LFaLF1,
				NameFormat.LFaLFM,
				NameFormat.LFaLFM2,
				NameFormat.LFaLcF,
				NameFormat.LFiMiaFiMi,
				NameFormat.LFiaFi,
				NameFormat.LFiaFiL,
				NameFormat.LFiaFiMi,
				NameFormat.LSFMaFM,
				NameFormat.LSFaFM,
				NameFormat.LcFMSaLcFM,
				NameFormat.LcFMaF,
				NameFormat.LcFMaFMM,
				NameFormat.LcSFaFMM,
				NameFormat.LcFMaFMS,
				NameFormat.LcFMaLcF,
				NameFormat.LcFMaLcFM,
				NameFormat.LcFMaLcFS,
				NameFormat.LcFMiMiaFMM,
				NameFormat.LcFaFM,
				NameFormat.LcFaLcF,
				NameFormat.LcFaLcFM,
				NameFormat.LcFMSaLcFM,
				NameFormat.FMaFLS,
				NameFormat.MrMrs,
				NameFormat.LFMaFM,
				NameFormat.LFMSaFMM
			];


shared boolean IsDualFmtValid(string s) := MAP(
	//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', s) => false,
	//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{4,}\\b', s) => false,
	//REGEXFIND('\\b(PT|LT|FT|DL|JT|ERROR|EST)\\b',s) => false,  // unprocessed abbreviations
	REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]+Q|[B-DF-HJ-NP-TVWXZ]{4,}|PT|LT|FT|DL|JT|ERROR|EST)\\b',s) => false,

	REGEXFIND('\\b[A-Z] +OR +(JR|SR)$', s) => false,
	REGEXFIND('^[A-Z]+ +(JR|SR) *' + rgxConnector + ' *[A-Z]+$', s) => false,
	REGEXFIND('\\b(AND|OR)$', s) => false,
	REGEXFIND('^[A-Z]+ +[A-Z] +OR +[A-Z]+$', s) => false,	// LEE O OR DEES
	REGEXFIND('^[A-Z] *& *[A-Z]$', s) => false,
	REGEXFIND('^[A-Z] *& *[A-Z] +(RET|NLN|NMN)$', s) => false,
	REGEXFIND(rgxConnector + ' *(GUEST(S)?|PARENT(S)?|CHILD(REN?))\\b', s) => false,
	REGEXFIND(rgxLScFMM, s) => false,
	REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]{3})\\b', s) => 
					~SpecialNames.IsAbbreviation(REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]{3})\\b', s, 1)),
	true
);

IsLoQualityFirstName(string s) :=
	NameTester.IsLoPctFirstName(s)
	OR IsHyphenatedFirstName(s)
	OR LENGTH(s) = 1;

			
export boolean TestDualName(string lname, string fname1, string fname2) := FUNCTION
			segs := GetNameType(lname)+GetNameType(fname1)+GetNameType(fname2);

			return MAP(
					segs IN ['LLL','LLX',	// vary 3
									//'LBL',	// vary 2
									'LXL',	// vary 2
									'XLL','XLB','XLX',	// vary 1
									'XXL',				// 'XXX' let's assume XXX is a person
									'BLL','BLB','BLX',	// vary 1
									'BXL']							//'BXB','BXX'],
								=> IF(IsLoQualityFirstName(fname1) OR IsLoQualityFirstName(fname2), true, false),
					//segs = 'LLB' => NameTester.IsLoQualityFirstName(fname1),
					true);
							// removed 11/5: 'LBX','LXB',
//				segs IN ['FFL','FBL','BFL','BBL','XXX','FBL','FXL','BXL','XBL','BFB'] => 'F',
//				segs IN ['LFF','LFB','LFX','LBF','LBB','LBX','LXL','LXX','LXF','BFF','BBF','XBX','XFX'] => 'L',
//				segs in ['LLF','XLF','BLF'] => 'U',
END;

boolean TestLastName(string lname) := FUNCTION
			seg := GetNameType(lname);
			return (seg in ['L','B']) or ~NameTester.LikelyBizWord(lname);
END;
	


export boolean ValidDualName(string s, integer2 format) := FUNCTION
	fullname := FormatName1(s, format) + FormatName2(s, format);
	fname := TRIM(fullname[6..25]);
	fname2 := TRIM(fullname[76..95]);
	lname := TRIM(fullname[46..65]);
	lname2 := TRIM(fullname[116..135]);
//	segs := ExtractNameTypes4(rgxFaFML, s, 1, 4, 5, 6);
//	ord := GetNameOrderNNaNN(segs);
/*OUTPUT('Format: ' + WhichFormat(format));
OUTPUT('Fullname: ' + fullname);
OUTPUT('ValidDualName: fname ' + fname + ' lname ' + lname + ' name2: ' + fname2 + ' * ' + lname2);
//OUTPUT('segs ' + segs + ' order ' + ord);
OUTPUT(NameTester.IsFirstName(FName) OR NameTester.IsFirstName(FName2) 
				OR IsLastNameConfirmed(LName));*/
	return MAP (
			format = NameFormat.NoName OR NOT IsNameFormatDual(format) =>	false,
		InvalidLastName(lname) => false,
		InvalidLastName(lname2) => false,
			format IN ValidatedDualNameFormats =>	true,		// this is a validated format
			format = NameFormat.FiaFiL => TestLastName(lname),
			//format = NameFormat.FMLaFM  =>	(NameTester.IsFirstName(fname) OR NameTester.IsFirstName(TRIM(fullname[26..45])))
			//							OR NameTester.IsFirstName(fname2),
			format = NameFormat.FMLaFM => TestDualName(lname, fname, fname2),
			//format = NameFormat.LcFaF => NameTester.IsFirstName(FName) OR IsHyphenatedFirstName(FName2),
			format = NameFormat.LcFaF => TestDualName(lname, fname, fname2),
			//format = NameFormat.LFaF => IsLastNameExOrHyphenated(LName) OR 
			//					NameTester.IsFirstName(FName) OR
			//					NameTester.IsFirstName(FName2),
			format = NameFormat.LFaF => TestDualName(lname, fname, fname2),
			format = NameFormat.FaFL => true,
			format = NameFormat.LFaFM => IsLastNameExOrHyphenated(LName) OR 
								IsFirstNameOrInitial(FName) OR
								IsFirstNameOrInitial(FName2) OR
								IsFirstNameOrInitial(TRIM(fullname[96..115])), // middle name 2
			IsFirstNameOrInitial(FName) OR IsFirstNameOrInitial(FName2) 
				OR IsLastNameConfirmed(LName)
			);
END;
			
export boolean IsDualName(string s) := FUNCTION
	fmt := DualNameFormat(s);

	return MAP(
		fmt = NameFormat.NoName =>	false,
		NameTester.InvalidNameFormat(s) => false,
		/*NOT REGEXFIND(rgxConnector, s) AND NOT REGEXFIND(rgxFMLcFML,s) => false,
		REGEXFIND(rgxLScFMM, s) => false,
		REGEXFIND(rgxLcFMM, s) => false,
		REGEXFIND(rgxFMLcIII, s) => false,*/
		//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', s) => false,
		//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{4,}\\b', s) => false,
		//REGEXFIND('\\b(PT|LT|FT|DL|JT|ERROR|EST)\\b',s) => false,  // unprocessed abbreviations
		REGEXFIND('^[A-Z] +AND +[A-Z] +[A-Z]$',s) => false,
		REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]+Q|[B-DF-HJ-NP-TVWXZ]{5,}|PT|LT|FT|DL|JT|ERROR|EST)\\b',s) => false,
		REGEXFIND('^[A-Z] +(AND|&) +[A-Z]+ +[A-Z]$',s) => false,

		REGEXFIND('\\b[A-Z]+ *( AND | OR |&) *(JR|SR|II|III|IV)$', s) => false,
		REGEXFIND('^[A-Z]+ +(JR|SR) *' + rgxConnector + ' *[A-Z]+$', s) => false,
		REGEXFIND('^[A-Z]+ +[A-Z] +OR +[A-Z]+$', s) => false,	// LEE O OR DEES
		REGEXFIND('^[A-Z] *' + rgxConnector + ' *[A-Z]$', s) => false,
		REGEXFIND('^[A-Z] *& *[A-Z] +(RET|NLN|NMN|COL|REV|ESQ|ESQUIRE|MAJ)$', s) => false,
		REGEXFIND('^FIRM +', s) => false,
		//REGEXFIND('\\bAND GUEST(S)?$', s) => false,
		REGEXFIND(rgxConnector + ' *(GUEST(S)?|PARENT(S)?|CHILD(REN?)|TREASURER|DIRECTOR)\\b', s) => false,
		REGEXFIND(' *& *NT\\b', s) => false,
		SpecialNames.IsAbbreviation(REGEXFIND('\\b([B-DF-HJ-NP-TVWXZ]{3})\\b', s, 1)) => false,
		ValidDualName(s, fmt)
	);
END;

// check for a last name in the expected place
rgx_any := '([A-Z\'-]+)([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z\'-]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?([^A-Z]+)?([A-Z]+)?';


// check for a first name in the expected place
//shared	titles := '^MMS\\b(.+)';

shared set of NameFormat LikelyNameFormats := [
	NameFormat.FL, NameFormat.LF, NameFormat.LFM, NameFormat.FLcS, NameFormat.FLS, NameFormat.LFS, NameFormat.FLSorLFS,
	NameFormat.FMLLS, NameFormat.FMSL, NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS, //NameFormat.FiMiL,
	NameFormat.FMiL, NameFormat.FMiLS, NameFormat.LSFM, NameFormat.FMLSorLFMS,
	/*NameFormat.LFi,*/ NameFormat.LFiS, NameFormat.LFMS, NameFormat.LFMiS,	NameFormat.ILI,
	NameFormat.LcFMS, NameFormat.LcFMcS,NameFormat.LcFcMS,NameFormat.LcFcMcS,
	NameFormat.LScFM, NameFormat.LScFMM, NameFormat.LcScFM, NameFormat.LcScF, NameFormat.FcMcL, NameFormat.LScF,
	NameFormat.LcF, NameFormat.LFMi, NameFormat.LcFhF, NameFormat.FiIIL, NameFormat.SFL, NameFormat.FSL,
	NameFormat.FMMLS, NameFormat.LcFM, NameFormat.LcFMM, NameFormat.LcSFM, NameFormat.LcFS, NameFormat.LcFcS, NameFormat.LcTF,
	NameFormat.LFMicS, NameFormat.LFMiMi, NameFormat.FMLcIII, NameFormat.FMcSL, NameFormat.FMLcS,
	NameFormat.FccL,NameFormat.LLcFM
	];
	
shared set of NameFormat PossibleNameFormats := [
	NameFormat.FMiMiL		//,NameFormat.LcFcM
	];
	
/*export boolean IsLikelyPersonalNameFormat(NameFormat fmt) := 
	MAP(
		NOT validPersonNameFormat(fmt) => FALSE,
		fmt in LikelyNameFormats => TRUE,
		FALSE);
*/
//export boolean IsSomewhatLikelyPersonalNameFormat(NameFormat fmt) := 
//		fmt in [NameFormat.FLorLF,NameFormat.FMLorLFM,NameFormat.FMLL];


//shared boolean IsActualFirstName(string s) :=
//	IF(LENGTH(s) > 1, IsFirstNameEx(s), false);


shared set of NameFormat FirstNameFirst := [
	NameFormat.FL, NameFormat.FLcS, NameFormat.FLS, NameFormat.FMLLS, 
	NameFormat.FiML, NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS,	//NameFormat.FiMiL,
	NameFormat.FMLcS, NameFormat.FMcSL, NameFormat.FMLcIII, NameFormat.FMiLS, NameFormat.FLL, NameFormat.FMiLI,NameFormat.ILI,
	NameFormat.FxL, NameFormat.FxLS, NameFormat.FxLL,	NameFormat.FSL, NameFormat.FML,NameFormat.FMSL,
	NameFormat.FMLL, NameFormat.FMiMiL, NameFormat.FMML, NameFormat.FMMLS, NameFormat.FiIIL, NameFormat.FMLyL,
	NameFormat.FccL, NameFormat.FcMcL
	];

shared set of NameFormat LastNameFirst := [
	NameFormat.LF, NameFormat.LFM, NameFormat.LFi, NameFormat.LFiS, NameFormat.LFMS, NameFormat.LFMiS, 
	NameFormat.LcFMS, NameFormat.LcFMcS, NameFormat.LScF, NameFormat.LScFM, NameFormat.LScFMM,
	NameFormat.LcScFM,NameFormat.LcScF,	NameFormat.LxFM,
	NameFormat.LcFMM, NameFormat.LcSFM, NameFormat.LFMi, NameFormat.LFiMi,
	/*NameFormat.LFMMi,*/ NameFormat.LFcMi, NameFormat.LSFM,
	NameFormat.LcF, NameFormat.LcFM, NameFormat.LcFcM, NameFormat.LcFcMS,NameFormat.LcFcMcS,
	NameFormat.LcFcS, NameFormat.LcFS, NameFormat.LLcFM, NameFormat.LLcFS, NameFormat.LcFhF,
	NameFormat.LFMiM, NameFormat.LFMiMi, NameFormat.LFMicS
	];
shared set of NameFormat NameFML := [
	NameFormat.FL, NameFormat.FLcS, NameFormat.FLS, NameFormat.FMLLS, 
	NameFormat.FiML, NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS,	//NameFormat.FiMiL,
	NameFormat.FMLcS, NameFormat.FMcSL, NameFormat.FMLcIII, NameFormat.FMiLS, NameFormat.FLL, NameFormat.FMiLI,
	NameFormat.FxL, NameFormat.FxLS, NameFormat.FxLL, NameFormat.FML, NameFormat.FMSL,
	NameFormat.FMLL, NameFormat.FMiMiL, NameFormat.FMML, NameFormat.FMMLS,	NameFormat.FiIIL, NameFormat.FMLyL,
	NameFormat.FccL, NameFormat.FcMcL
	];

shared set of NameFormat NameLFM := [
	NameFormat.LF, NameFormat.LFM, NameFormat.LFi, NameFormat.LFMS, NameFormat.LFMiS, 
	NameFormat.LcFMS, NameFormat.LcFMcS, NameFormat.LScFM, NameFormat.LScFMM,
	NameFormat.LcFMM, NameFormat.LFMi, NameFormat.LFiMi,/*NameFormat.LFMMi,*/ NameFormat.LFcMi, 
	NameFormat.LcF, NameFormat.LcFM, NameFormat.LcFcM, NameFormat.LcFcMS,NameFormat.LcFcMcS,
	NameFormat.LcFcS, NameFormat.LLcFM, NameFormat.LLcFS, NameFormat.LxFM, NameFormat.LcFhF,
	NameFormat.LFMiM, NameFormat.LFMiMi, NameFormat.LFMicS
	];

// these names could be in any order
shared set of NameFormat FlippedNames := [NameFormat.FLorLF, NameFormat.FLSorLFS,NameFormat.FMLSorLFMS,
				NameFormat.FMiL, NameFormat.FSL];
// to replace IsProbableName
		//Persons.InvalidNameFormat(name) => MatchType.Inv,
		//Persons.IsJustLastName(name) => MatchType.Unclass,
export NameStatus := enum(UNSIGNED2, NotAName = 0, InvalidNameFormat = 1,
				StandaloneName = 2, 
				ProbableName = 3, PossibleName = 4, ImprobableName = 5,
				PossibleDualName = 6);
//types := ['X','F','L','B'];
string1 GetNameClass(string nm) :=
	types[IF (IsFirstNameOrInitial(nm),1,0) +
	//IF (IsLastNameConfirmed(nm),2,0) + 1];
	IF (IsValidLastName(nm),2,0) + 1];
	

NameStatus VerifyNameOrder(string2 s, string fname, string lname) := FUNCTION

	return MAP(
		s in ['FL','BL','FB','BB','LF','LB','BF'] => NameStatus.ProbableName,
		s in ['FF','LL','LB','FX','XF','BX','XB'] => NameStatus.PossibleName,
		s = 'XL' => IF(NameTester.LikelyBizWord(fname),NameStatus.ImprobableName,NameStatus.PossibleName),
		s = 'LX' => IF(NameTester.LikelyBizWord(lname),NameStatus.ImprobableName,NameStatus.PossibleName),
		NameStatus.ImprobableName
		);
END;


NameStatus VerifyName(string fname, string lname) := FUNCTION
	s := GetNameClass(fname) + GetNameClass(lname);
//OUTPUT('VerifyName: ' + s + ' fname: ' + fname + ' lname: ' + lname) ;
	return VerifyNameOrder(s, fname, lname);
END; 

NameStatus VerifyNameFL(string rgx, string s, integer f, integer l) :=
							VerifyName(REGEXFIND(rgxFLoLF, s, f), REGEXFIND(rgxFLoLF, s, l));


/*
NameStatus VerifyName2(string fname, string lname, string mname) := FUNCTION
	s := If(length(fname) > 1, GetNameClass(fname), GetNameClass(mname)) 
			+ GetNameClass(REGEXFIND('^([A-Z]+)\\b',lname, 1));
	return IF(REGEXFIND('^(BEN|AL) [A-Z]+$', lname), NameStatus.ProbableName,
					VerifyNameOrder(s,If(length(fname) > 1, fname, mname), lname));
END;
*/
NameStatus VerifyHyphenatedName(string fname, string lname) := FUNCTION
	s := IF(NameTester.IsFirstname(fname), 'F', 'X') +
		IF(IsLastNameEx(REGEXFIND(rgxDoubleName, lname, 1)) OR
			IsLastNameEx(REGEXFIND(rgxDoubleName, lname, 3)),'L','X');
	return IF(s='XX',NameStatus.PossibleName,NameStatus.ProbableName);
	//return VerifyNameOrder(s);
END;

NameStatus VerifyPossibleName(string fname, string lname) := 
	IF(NameTester.IsFirstname(fname) and IsLastNameEx(lname),NameStatus.ProbableName,NameStatus.PossibleName);


NameStatus VerifyNameFML(string fname, string mname, string lname) := FUNCTION
	segs := GetNameTypes(fname, lname, mname);
	segsFL := segs[1] + segs[3];		// FML
	segM := segs[2];

	return MAP(
//		segs = 'XXX' => NameStatus.ImprobableName,
		segs in ['FFX','FFL','FFB','FBX','FBL','FLL','FXL',
		         'BFX','BFB','BBX','BFL','BBL','BXL',
							'XFL','XBL','LLF','LFF','XBF'] => NameStatus.ProbableName,
		segs in ['FXX','FBX','FLX','LFX','LXX','LLB','LBX','LBF','BFX','BLX','BXX','XLX','XFX','XFB','XXL','LLX','XLX','XXF','XFF','XBB','XLL'] => NameStatus.PossibleName,
		segsFL = 'BB' => NameStatus.ProbableName,
		//segsFL = 'XX' => NameStatus.ImprobableName,
		segsFL in ['FF','LL','LB','BF'] => NameStatus.PossibleName,
		segsFL in ['BB','FL','FB','BL','LF'] => NameStatus.ProbableName,
		segsFL in ['BX','FX'] => IF(NameTester.LikelyBizWord(lname),NameStatus.ImprobableName,NameStatus.PossibleName),
		segsFL in ['XB','XL'] => IF(NameTester.LikelyBizWord(fname),NameStatus.ImprobableName,NameStatus.PossibleName),
		//segsFL in ['LX'] => NameStatus.ImprobableName,
		segM in ['F','B'] => NameStatus.PossibleName,
		IF(NameTester.LikelyBizWord(fname),NameStatus.ImprobableName,NameStatus.PossibleName)
	);
END;

NameStatus VerifyNameL(string lname) := CASE(
	GetNameType(lname),
	'F' => IF(NameTester.IsFirstNameBasic(lname),NameStatus.ImprobableName,NameStatus.PossibleName),
	'X' => NameStatus.PossibleName,
	NameStatus.ProbableName
	);

NameStatus VerifyNameFLL(string s) := FUNCTION
	segs := ExtractNameTypesFML(rgxFLL, s, 1, 2, 5);

	return MAP(
//		segs = 'XXX' => NameStatus.ImprobableName,
		segs[1] IN ['F','B'] AND (segs[2] IN ['B','L'] OR segs[2] IN ['B','L']) => NameStatus.ProbableName,
		segs[1] IN ['F','B'] OR segs[2] IN ['B','L'] OR segs[2] IN ['B','L'] => NameStatus.PossibleName,
		IF(NameTester.LikelyBizWord(s),NameStatus.ImprobableName,NameStatus.PossibleName)
	);
END;

rgxStreet := '^[0-9]+.+ (ROAD|RD|STREET|ST|AVE|AVENUE|DRIVE|DR|PLACE|PATH|LANE|LN|WAY|WY)$';		// street address only

export NameStatus ValidatePersonalName(string name,string1 hint='U') := FUNCTION
	//n := PersonalNameFormat(name);
	n := SingleNameFormat(name);
	fullname := FormatName(name, n);
	fname := TRIM(fullname[6..25]);
	mname := TRIM(fullname[26..45]);
	lname := TRIM(fullname[46..65]);

	return MAP (
		n = NameFormat.NoName => NameStatus.NotAName,
		InvalidLastName(lname) AND lname<>'' => NameStatus.InvalidNameFormat,
		InvalidFirstName(fname) AND fname<>'' => NameStatus.InvalidNameFormat,
		NameTester.IsBusinessWord(fname) OR NameTester.IsBusinessWord(mname) OR NameTester.IsBusinessWord(lname) => NameStatus.ImprobableName,
		n in LikelyNameFormats => NameStatus.ProbableName,		
		REGEXFIND(rgxFLhL, name) => VerifyHyphenatedName(REGEXFIND(rgxFLhL, name, 1),REGEXFIND(rgxFLhL, name,2)),
		REGEXFIND(rgxStreet, name) => NameStatus.InvalidNameFormat,
		n = NameFormat.LFi => VerifyNameL(lname),
		n IN PossibleNameFormats => VerifyPossibleName(fname,lname),
		n = NameFormat.FMLL => VerifyNameFML(fname,mname,lname),
					//VerifyName2(fname,mname,lname),
		n = NameFormat.FLorLF => VerifyNameFL(rgxFLoLF, name, 1, 3),
		/*n in [NameFormat.FLorLF, NameFormat.FLSorLFS,NameFormat.FMLSorLFMS,
				NameFormat.FMiL, NameFormat.FSL] =>
					VerifyName(FirstName(name, n, hint),LastName(name, n, hint)),*/
		n = NameFormat.LFiMi => IF(IsLastNameEx(lname),
									NameStatus.ProbableName,NameStatus.PossibleName),
		//n = NameFormat.FMLorLFM => VerifyNameFML(REGEXFIND(rgxFMLorLFM, name, 1),
		//									REGEXFIND(rgxFMLorLFM, name, 4),REGEXFIND(rgxFMLorLFM, name, 5)),
		n in [NameFormat.FMLorLFM,NameFormat.LcFcM] => VerifyNameFML(fname,mname,lname),
		n = NameFormat.FLL => VerifyNameFLL(name),
		n = NameFormat.LFMMi => VerifyNameFML(fname,mname,lname),
		n = NameFormat.FiML => VerifyPossibleName(mname,lname),
		n = NameFormat.L => CASE(GetNameType(lname),
								'F' => NameStatus.ImprobableName,
								NameStatus.StandaloneName),
		n = NameFormat.LS => NameStatus.StandaloneName,
		VerifyName(fname,lname)
	);

END;

export NameStatus NameQuality(string name,string1 hint='U') := 
	MAP(
		TRIM(name) = '' => NameStatus.NotAName,
		NameTester.InvalidNameFormat(name) => NameStatus.InvalidNameFormat,
//		REGEXFIND(rgxConnector, name) => IF(IsDualName(name),	NameStatus.PossibleDualName,
//									NameStatus.InvalidNameFormat),
//		REGEXFIND(rgxConnector, name) => NameStatus.PossibleDualName,
		REGEXFIND(rgxConnector, name) => If(DualNameFormat(name) = 0, NameStatus.InvalidNameFormat, NameStatus.PossibleDualName),
		IsJustLastName(name) => NameStatus.StandaloneName,
		ValidatePersonalName(name,hint)
		);

// for test purposes
export string3 NameQualityText(string s,string1 hint='U') :=
	CASE(NameQuality(s,hint),
		NameStatus.NotAName => 'NAN',
		NameStatus.InvalidNameFormat => 'INV',
		NameStatus.StandaloneName => 'STA',
		NameStatus.ProbableName => 'YES',
		NameStatus.PossibleName => 'MAY',
		NameStatus.ImprobableName => 'NO ',
		NameStatus.PossibleDualName => 'DUL',
		'?');
		


// matches a supported name format
export boolean IsPossibleName(string name) := IF(
		TRIM(name) = '' OR
		REGEXFIND(rgxConnector, name) OR
		NameTester.InvalidNameFormat(name) OR
		IsJustLastName(name) OR
		SingleNameFormat(name) = NameFormat.NoName,
		false, true);
		
// matches a likely name format

export boolean IsLikelyNameFormat(string name) := IF(
		TRIM(name) = '' OR
		REGEXFIND(rgxConnector, name) OR
		NameTester.InvalidNameFormat(name) OR
		IsJustLastName(name),
		false,
			SingleNameFormat(name) IN (LikelyNameFormats + [NameFormat.FLorLF]));
	
//export boolean IsLikelyName(string name) := 
		//IF (NameQuality(name) = NameStatus.ProbableName, true, false);
		
export boolean IsLikelyName(string name) := 
	IF(ValidatePersonalName(name) in [NameStatus.ProbableName,NameStatus.PossibleName], true, false);



export boolean IsPossibleDualName(string name) := IF(
		TRIM(name) = '' OR
		~REGEXFIND(rgxConnector, name) OR
		~IsDualFmtValid(name) OR
		DualNameFormat(name) = NameFormat.NoName,
		false, true);

shared set of NameFormat StandAloneNameFormats := [
	NameFormat.FL, NameFormat.FLS, NameFormat.FLSorLFS, NameFormat.FMLLS,
	NameFormat.FiML,NameFormat.FiL,NameFormat.FiMLS,NameFormat.FiLS, //NameFormat.FiMiL,
	NameFormat.FMiL, NameFormat.FMiLS, NameFormat.FMLSorLFMS,
	/*NameFormat.LFMi,*/ NameFormat.FiIIL, /*NameFormat.FSL,*/
	NameFormat.FMMLS, NameFormat.FLorLF,NameFormat.FMLorLFM,NameFormat.FMLL
	];



string FixGen(string suffix) :=
		CASE(suffix,
			//'1' => '',	//'SR',
			//'2' => 'JR',
			//'3' => 'III',
			//'4' => 'IV',
			//'5' => 'V',
			//'6' => 'VI',
			//'7' => 'VII',
			//'8' => 'VIII',
			//'9' => 'IX',
			'JR' => 'JR',
			'JR,' => 'JR',
			'SR' => 'SR',
			'I' => 'I',
			'II' => 'II',
			'II,' => 'II',
			'III' => 'III',
			'IV' => 'IV',
			'IIII' => 'IV',
			'V' => 'V',
			//'1ST' => 'I',
			'2N' => 'II',
			//'2ND' => 'II',
			'ND' => 'II',
			//'3RD' => 'III',
			'RD' => 'III',
			'3 I' => 'III',
			//'4TH' => 'IV',
			//'5TH' => 'V',
			'000' => '',
			suffix);

/***
	assumes that last word is a suffix and convert to alphs
***/
export string SuffixToAlpha(string name) := FUNCTION
	suffix := REGEXFIND('^.+[ ,]([A-Z0-9]+)$', name, 1);
	return IF (suffix = '', name,
			TRIM(REGEXREPLACE('^(.+)([ ,])([A-Z0-9]+)$', name,
			'$1$2') + FixGen(suffix)));	
END;
/*
rgxSlashAtEnd := '/$';		// slash at end
punctAtEnd := '[ .,+;?_*:#%"/]$';		// slash at end

string ReconstructLName(string name) := MAP(
		length(name) <= 1 => name,
		//name[1..2] = 'O ' => 'O\'' + name[3..],
		REGEXFIND('^[A-Z]{2,}/(JR|SR)$',name) => REGEXREPLACE('^([A-Z]{2,})/(JR|SR)$',name, '$1'),
		REGEXFIND('^[A-Z]{2,}/[A-Z ]{2,}$',name) => StringLib.StringFindReplace(name, '/', '-'),
		REGEXFIND('^[A-Z]{2,}-[A-Z]{2,}/[A-Z]$',name) => StringLib.StringFindReplace(name, '/', ' '),
		REGEXFIND('^[A-Z]/[A-Z]+$',name) => REGEXREPLACE('^[A-Z]/([A-Z]+)$',name, '$1'),
		REGEXFIND('^[A-Z]+/[A-Z]$',name) => REGEXREPLACE('^([A-Z]+)/[A-Z]$',name, '$1'),
		//REGEXFIND(rgxSlashAtEnd, name) => TRIM(StringLib.StringFilterOut(name, '/')),
		REGEXFIND('^([A-Z]+-)([A-Z]+)/\\2$',name) => REGEXREPLACE('^([A-Z]+-)([A-Z]+)/\\2$',name, '$1$2'),
		REGEXFIND('^([A-Z]+) +-([A-Z]+)$',name) => REGEXREPLACE('^([A-Z]+) +-([A-Z]+)$',name, '$1-$2'),
		REGEXFIND(punctAtEnd, name) => REGEXREPLACE('[ .,+;?_*:#%"/]+$',name,''),
		name[1..3] = 'MC ' => 'MC' + name[4..],
		name='FF' => '',
		name
	);


export string ReconstructName(string fname, string mname, string lname, string suffix) := FUNCTION
		//name := TRIM(lname);
		lnam := TRIM(ReconstructLName(TRIM(lname,LEFT,RIGHT)),LEFT,RIGHT);
		mnam := MAP(
					//mname in ['NMN','NMI'] => '',
					StringLib.StringFindCount(mname, '/') > 0 =>
						StringLib.StringFindReplace(mname, '/', ' '),
					mname);
		gen := CASE(TRIM(StringLib.StringToUpperCase(suffix)),
			//'1' => 'SR',
			//'2' => 'JR',
			//'3' => 'III',
			//'4' => 'IV',
			//'5' => 'V',
			//'6' => '',
			//'7' => '',
			//'8' => '',
			//'9' => '',
			'JR' => suffix,
			'JR,' => suffix[1..2],
			'SR' => suffix,
			'I' => 'I',
			'II' => 'II',
			'II,' => 'II',
			'III' => 'III',
			'IV' => 'IV',
			'IIII' => 'IV',
			'V' => 'V',
			'1ST' => 'I',
			'2N' => 'II',
			'2ND' => 'II',
			'ND' => 'II',
			'3D' => 'III',
			'3RD' => 'III',
			'RD' => 'III',
			'3 I' => 'III',
			'4TH' => 'IV',
			'000' => '',
			TRIM(StringLib.StringFilterOut(suffix,',()')));
			
//		RETURN TRIM( 
//				TRIM(fname) +
//					IF(mnam='','',' ' + TRIM(mnam)) +
//					' ' + lnam + 
//					IF(gen='','',' ' + TRIM(gen))
//				, LEFT, RIGHT);
			return Std.Str.ToUpperCase(Std.Str.CleanSpaces(fname + ' ' + mnam + ' ' + lnam + ' ' + gen));
END;
*/

export string GetNameSegments(string s1, integer2 fmtx=0) := FUNCTION
	s := PrecleanName(s1);
	NameFormat fmt := IF(fmtx = 0, PersonalNameFormat(s), fmtx);
	return CASE(fmt,
			NameFormat.NoName =>	'',
			NameFormat.FL =>		ExtractNameTypes(rgxFL,s,1,2),
			NameFormat.LF =>		ExtractNameTypes(rgxLF,s, 1,5),
			NameFormat.LFM =>		ExtractNameTypes(rgxLFM,s, 1,5,6),
			NameFormat.FLorLF => 	ExtractNameTypes(rgxFLoLF, s, 1, 3),

			NameFormat.FLcS =>		ExtractNameTypes(rgxFLcS, s, 1,2),
			NameFormat.FLS =>		ExtractNameTypes(rgxFLS, s, 1,2),
			NameFormat.LFS =>		ExtractNameTypes(rgxLFS, s, 1,4),
			NameFormat.FLSorLFS =>	ExtractNameTypes(rgxFLSorLFS, s, 1, 2),
			NameFormat.LFSM =>		ExtractNameTypes(rgxLFSM, s, 1, 4),
			
			NameFormat.FLL =>		ExtractNameTypesFML(rgxFLL, s, 1, 2, 6),
			NameFormat.FxL =>		ExtractNameTypes(rgxFxL, s, 1,3),
			NameFormat.FxLS =>		ExtractNameTypes(rgxFxLS, s, 1,3),
			NameFormat.LxFM =>		ExtractNameTypes(rgxLxFM, s, 3,1,4),
			NameFormat.FxLL =>		ExtractNameTypes(rgxFxLL, s, 1,3),
			NameFormat.FMLL =>		ExtractNameTypes4(rgxFMLL, s, 1,4,5,8),
			NameFormat.FMiMiL =>	ExtractNameTypes(rgxFMiMiL, s, 1,4),
			NameFormat.LFMiM =>		ExtractNameTypes(rgxLFMiM, s, 1, 4, 2),
			NameFormat.LFMiMi =>		ExtractNameTypes(rgxLFMiMi, s, 1, 4),
			NameFormat.FMML =>		ExtractNameTypes4(rgxFMML, s, 1,2,3,4),
			NameFormat.FMMLS =>		ExtractNameTypes(rgxFMMLS, s, 1,4,2),
			NameFormat.FMSL =>		ExtractNameTypesFML(rgxFMSL, s, 1, 2, 4),
			NameFormat.LFMi =>		ExtractNameTypes(rgxLFMi, s, 1,4),

			NameFormat.FML =>		ExtractNameTypesFML(rgxFML, s, 1,2,3),
			NameFormat.FMLorLFM => 	ExtractNameTypesFML(rgxFMLorLFM, s, 1, 4, 5),
			NameFormat.FMLSorLFMS => ExtractNameTypesFML(rgxFMLS, s, 1, 2,3),

			NameFormat.LFMicS => 	ExtractNameTypes(rgxLFMicS, s, 4,1),
			NameFormat.FMLcS => 	ExtractNameTypesFML(rgxFMLcS, s, 1,2,3),
			NameFormat.FMcSL =>		ExtractNameTypesFML(rgxFMcSL, s, 1,2,4),
			NameFormat.LcFMS => 	ExtractNameTypesFML(rgxLcFMS, s, 1, 4,5),
			NameFormat.LcFMcS => 	ExtractNameTypesFML(rgxLcFMcS, s, 1,4,5),
			NameFormat.LScF => 		ExtractNameTypes(rgxLScF, s, 1,5),
			NameFormat.LSFM => 		ExtractNameTypes(rgxLSFM, s, 1,5,7),
			NameFormat.LScFM => 	ExtractNameTypes(rgxLScFM, s, 1,7,8),
			NameFormat.LScFMM => 	ExtractNameTypes(rgxLScFMM, s, 1,7,8),
			NameFormat.LcScF => 	ExtractNameTypes(rgxLcScF, s, 1,7),
			NameFormat.LcScFM => 	ExtractNameTypesFML(rgxLcScFM, s, 1,7,8),
			NameFormat.LFMiS =>		ExtractNameTypes(rgxLFMiS, s, 1,4),
			NameFormat.LFMS => 		ExtractNameTypesFML(rgxLFMS, s, 1,4,5),
			NameFormat.FMLLS => 	ExtractNameTypes(rgxFMLLS, s, 1,3,2),
			NameFormat.LcFMM => 	ExtractNameTypesFML(rgxLcFMM, s, 1,4,5),
			NameFormat.LcSFM => 	ExtractNameTypesFML(rgxLcFMM, s, 1,5,6),

			NameFormat.LFMMi =>		ExtractNameTypesFML(rgxLFMMi, s, 1, 4, 5),
			NameFormat.LFi =>		GetNameType(REGEXFIND(rgxLFi, s, 1)),
			NameFormat.LFiS =>		GetNameType(REGEXFIND(rgxLFiS, s, 1)),
			NameFormat.FiL =>		GetNameType(REGEXFIND(rgxFiL, s, 2)),
			NameFormat.FiML =>		ExtractNameTypes(rgxFiML,s, 2,3),
			NameFormat.FiLS =>		ExtractNameTypes(rgxFiLS, s, 1,2),
			NameFormat.FiMLS =>		ExtractNameTypes(rgxFiMLS, s, 1,3,2),
			NameFormat.FMiL =>		ExtractNameTypes(rgxFMiL, s, 1, 3),
			NameFormat.ILI =>		GetNameType(REGEXFIND(rgxILI, s, 2)),

			NameFormat.FMiLS =>		ExtractNameTypes(rgxFMiLS, s, 1,3),
			NameFormat.FMiLI =>		ExtractNameTypes(rgxFMiLI, s, 1,3),
			NameFormat.LFcMi =>		ExtractNameTypes(rgxLFcMi, s, 1,4),
			NameFormat.LcF =>		ExtractNameTypes(rgxLcF, s, 1,4),
			NameFormat.LcTF =>		ExtractNameTypes(rgxLcTF, s, 1,5),
			NameFormat.LcFM =>		ExtractNameTypes(rgxLcFM, s, 1,4,5),
			
			NameFormat.LcFcS =>		ExtractNameTypes(rgxLcFcS, s, 1,4),
			NameFormat.LcFcM =>		ExtractNameTypesFML(rgxLcFcM, s, 1,4,5),
			NameFormat.LcFcMS =>	ExtractNameTypes(rgxLcFcMS, s, 1,4,5),
			NameFormat.LcFcMcS =>	ExtractNameTypes(rgxLcFcMcS, s, 1,4,5),
			NameFormat.LcFS =>		ExtractNameTypes(rgxLcFS, s, 1,4),
			NameFormat.LLcFM =>		ExtractNameTypes(rgxLLcFM, s, 1,7,9),
			NameFormat.LLcFS =>		ExtractNameTypes(rgxLLcFS, s, 7,1),
			NameFormat.LcFhF =>		ExtractNameTypes(rgxLcFhF, s, 2,1),
			
			NameFormat.FiIIL =>		ExtractNameTypes(rgxFiIIL, s, 1,2),
			NameFormat.SFL =>		ExtractNameTypes(rgxSFL, s, 2,3),
			NameFormat.FSL =>		ExtractNameTypes(rgxFSL, s, 1, 3),
			NameFormat.FMLyL =>		ExtractNameTypes(rgxFMLyL,s,1,2,3),
			NameFormat.FoLcMcL => ExtractNameTypes(rgxFoLcMcL,s,1,2,3),
// dual
			NameFormat.FaFL =>		ExtractNameTypes3(rgxFaFL,s,1,3,4),
			NameFormat.LFaF =>		ExtractNameTypesLFF(rgxLFaF,s,1,4,7),
			NameFormat.LFiaFi =>		GetNameType(REGEXFIND(rgxLFiaFi, s, 1)),
			NameFormat.LFaFM =>		//ExtractNameTypes(rgxLFaFM,s,1,4)+'&'+ExtractNameTypes(rgxLFaFM,s,6,7),
														ExtractNameTypes4(rgxLFaFM, s, 1, 4, 6, 7),
			NameFormat.LcFaF =>		ExtractNameTypesLFF(rgxLcFaF,s,1,4,6),
			NameFormat.FaFML =>		GetNameType(REGEXFIND(rgxFaFML, s, 1)) + '&' +
																	ExtractNameTypes3(rgxFaFML, s, 4, 5, 6),
			NameFormat.L =>			GetNameType(REGEXFIND(rgxL, s, 1)),
			NameFormat.FiaFiL =>		GetNameType(REGEXFIND(rgxFiaFiL,s,4)),
			NameFormat.FMaFML =>	ExtractNameTypes(rgxFMaFML, s, 1, 2)  + '&'
									+	ExtractNameTypes(rgxFMaFML, s, 4, 6, 5),
			NameFormat.LFMiaF => ExtractNameTypes3(rgxLFMiaF, s, 1, 4, 7),
			NameFormat.LFMiaFM => ExtractNameTypes4(rgxLFMiaFM, s, 1, 4, 7, 8),
			NameFormat.LFMaFM => ExtractNameTypes3(rgxLFMaFM, s, 1, 4, 6) + '&'
									+	ExtractNameTypes2(rgxLFMaFM, s, 8, 10),
			NameFormat.LFMaLFM2S => ExtractNameTypes(rgxLFMaLFM2S, s, 1, 5, 4) + '&'
									+	ExtractNameTypes(rgxLFMaLFM2S, s, 7, 9, 8),
			NameFormat.FMLaFM => ExtractNameTypesFML(rgxFMLaFM, s, 1, 3, 4)  + '&'
									+	GetNameType(REGEXFIND(rgxFMLaFM, s, 8))
									+ IF(REGEXFIND(rgxFMLaFM,s,10)='','',GetNameType(REGEXFIND(rgxFMLaFM,s,10))),
			NameFormat.FMaFLS => ExtractNameTypes2I(rgxFMaFLS, s, 1, 2) + '&' + ExtractNameTypes2I(rgxFMaFLS, s, 4, 5),
			NameFormat.FMaFL => ExtractNameTypes2I(rgxFMaFL, s, 1, 3) + '&' + ExtractNameTypes2I(rgxFMaFL, s, 5, 7),
			NameFormat.FLSaFM => ExtractNameTypes2I(rgxFLSaFM, s, 1, 2) + '&' + ExtractNameTypes2I(rgxFLSaFM, s, 7, 9),
			NameFormat.LcFMiMiaFMM =>	ExtractNameTypes4(rgxLcFMiMiaFMM, s, 4, 5, 6, 1) +'%'+ExtractNameTypes4(rgxLcFMiMiaFMM, s, 8, 9, 10, 1), 		
			NameFormat.LFMaLFM => ExtractNameTypes3(rgxLFMaLFM, s, 1, 4, 5) +'&'+ ExtractNameTypes3(rgxLFMaLFM, s, 7, 8, 1),
			'***'
		);
END;
         

/*	
export string8 NameOrder(string name, integer2 fmtx=0, string1 hint='U') := FUNCTION
	//s := FixupSlash(name), '/', ',');
	//NameFormat fmt := SingleNameFormat(name);
	NameFormat fmt := IF(fmtx = 0, PersonalNameFormat(name), fmtx);
	clue := MAP(
		//fmt IN FirstNameFirst	=> 'Frst',
		//fmt IN LastNameFirst	=> 'Last',
		fmt = NameFormat.FMiL =>	ValidateNames(rgxFMiL, name, 1, 3, 3, 1),
		fmt = NameFormat.FiML =>	ValidateNames(rgxFiML, name, 2, 3, 3, 2),
		fmt = NameFormat.LFMi =>	ValidateNames(rgxLFMi, name, 1, 4, 4, 1),
		fmt = NameFormat.FLorLF => 	ValidateNames(rgxFLoLF, name, 1, 3, 3, 1),
		fmt = NameFormat.FLSorLFS =>	ValidateNames(rgxFLSorLFS, name, 1, 2, 2, 1),
		fmt = NameFormat.FMLorLFM => ValidateNames(rgxFMLorLFM, name, 1, 4, 5, 1),
		fmt = NameFormat.LFMSaFMM => ValidateNames(rgxLFMSaFMM, name, 1, 5, 4, 1),
		fmt = NameFormat.FLSaFM => ValidateNames(rgxFLSaFM, name, 1, 2, 2, 1),
		fmt = NameFormat.FMLSorLFMS => ValidateNames(rgxFMLS, name, 1, 2, 3, 1),	
		fmt = NameFormat.FLL =>	ValidateNames(rgxFLL, name, 1, 5, 5, 2),
		fmt = NameFormat.FSL =>	ValidateNames(rgxFSL, name, 1, 3, 3, 1),
		fmt = NameFormat.LFMMi => ValidateNames(rgxLFMMi, name, 4, 5, 1, 4),
		//fmt = NameFormat.LFaF => GetNameType(REGEXFIND(rgxLFaF,name,1)) + 
		//			GetNameType(REGEXFIND(rgxLFaF,name,4)) + GetNameType(REGEXFIND(rgxLFaF,name,6)) + ' ',
		fmt = NameFormat.LFaF => ValidateNames(rgxLFaF, name, 1, 4, 4, 1),
		fmt = NameFormat.FMLaFM =>	ValidateNames(rgxFMLaFM, name, 1, 3, 3, 1),
		IF(IsFirstName(FirstName(name, fmt)), 'F',' ') +
			IF(IsNoFirstLastNameExOrHyphenated(LastName(name,fmt)),'L',' ')
	);
	clue2 := MAP(
		fmt = NameFormat.FMLorLFM => GetNameOrderFML(rgxFMLorLFM, name, 1, 4, 5, 1, hint, 4, 5),
		fmt = NameFormat.FMiL =>	GetNameOrderFMiL(rgxFMiL, name, 1, 3, 3, 1, hint),
		fmt = NameFormat.FiML =>	GetNameOrder(rgxFiML, name, 2, 3, 3, 2, hint, 2, 0),
		fmt = NameFormat.FLorLF =>	GetNameOrderFL(rgxFLoLF, name, 1, 3, 3, 1, hint),
		fmt = NameFormat.LFaF =>	GetNameOrder(rgxLFaF, name, 1, 4, 4, 1, hint),
		fmt = NameFormat.LFMi =>	GetNameOrder(rgxLFMi, name, 1, 4, 4, 1, 'U'),
		fmt in FirstNameFirst => 'f',
		fmt in LastNameFirst => 'l',
		StringLib.StringToUpperCase(hint)
	);
	clue3 := MAP(
		fmt = NameFormat.FMLorLFM =>  
					IF(IsFirstName(REGEXFIND(rgxFMLorLFM, name, 4)),'M','m') +
					IF(IsFirstName(REGEXFIND(rgxFMLorLFM, name, 5)),'M','m'),
		fmt = NameFormat.FMiL =>  
					' ' +
					IF(IsFirstName(REGEXFIND(rgxFMiL, name, 3)),'M','m'),
		If(IsFirstName(MiddleName(name,fmt,hint)),'M',
					IF(MiddleName(name,fmt,hint)='',' ','m'))
	);

	return clue + '-' + clue2 + clue3;
END;
*/

export string140 CleanName(string name, string1 hint='U') := FUNCTION
	s := PrecleanName(name);
	
	NameFormat fmt := IF(hint = 'U',SingleNameFormat(s),NameFormat.NoName);
	clue := MAP(
		fmt = NameFormat.NoName => StringLib.StringToUpperCase(hint),
		fmt IN NameFML	=> 'F',
		fmt IN NameLFM	=> 'L',
		'U'
	);

	RETURN CASE(clue,
		'F'	=> CleanPersonFML73(s)[1..70],
		'L'	=> CleanPersonLFM73(s)[1..70],
		'D' => CleanDualName140(s),
		CleanPerson73(s)[1..70]
	);

END;

/*
export boolean IsCouple(string s) := 
	IF(REGEXFIND(rgxMrMrs, s),
		IsProbableName(REGEXREPLACE(rgxMrMrs, s, '')), false);
*/	

END;