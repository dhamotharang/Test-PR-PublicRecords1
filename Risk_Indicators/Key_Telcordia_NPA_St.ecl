import doxie,Data_Services;	
	// this stuff finds the most likely state for a particular area code
	// this is needed because the gong file that makes up the Key_telcordia_tpm
	// contains entries for area codes that are from different states!

import Risk_Indicators;
	telcordiazips := Risk_Indicators.Telcordia_tpm_base;
	layout_npast := RECORD
		string3 npa := telcordiazips.npa;
		string2 st := telcordiazips.st;
		groupCount := Count(Group);
	END;
	zwr := Table(telcordiazips, layout_npast,npa,st);
	distzwr := distribute(zwr,hash(npa));
	sortedzwr := SORT(distzwr,npa,groupCount,local);

	layout_npast tr(layout_npast l, layout_npast r) :=  TRANSFORM 
		SELF.npa := l.npa;
		self.groupCount := if(l.groupCount > r.groupCount,l.groupCount,r.groupCount);
		self.st := if(l.groupCount > r.groupCount,l.st,r.st);
	END;
	rolledzwr := ROLLUP(sortedzwr,tr(LEFT,RIGHT),npa,local);


export Key_Telcordia_NPA_St := INDEX(rolledzwr,
 {npa,st},
 {groupCount},
 Data_Services.Data_Location.Prefix('Telcordia')+'thor_data400::key::telcordia_npa_st_'+doxie.Version_SuperKey,OPT);