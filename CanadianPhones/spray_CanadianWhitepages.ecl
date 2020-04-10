import $, STD;

export spray_CanadianWhitepages(	
															STRING  pVersion,
															STRING  pSource,
															STRING  pHostname,
															STRING  pGroup = STD.System.Thorlib.Group()
															) := function


sprayupdate     := STD.File.SprayVariable(pHostname,
                        pSource,
												//'/data/hds_2/telephones/canadian/axciom/data/business/20200305/CANADADA.txt',
                        ,                  					// max rec size
                        '\t',              					// separator
												'\r\n',             				// end of rec terminator
                        ,              					    // quotations included
                        pGroup,    	// cluster
                        CanadianPhones.thor_cluster + 'in::infutorwp::'+pVersion+ '::canadada.dat',      // filename on Thor
                        ,
                        ,
                        ,
                        true,             // overwrite
                        true,             // replicate
                        false             // compress
                   ); 
		  
sfShuffle := sequential(
	// fileservices.addsuperfile(CanadianPhones.thor_cluster + 'in::axciomRes',CanadianPhones.thor_cluster + 'in::axciomRes::'+filedate+ '::canada.dat'),
	// fileservices.addsuperfile(CanadianPhones.thor_cluster + 'in::axciomBus',CanadianPhones.thor_cluster + 'in::axciomBus::'+filedate+ '::canada.dat')
		fileservices.addsuperfile(CanadianPhones.thor_cluster + 'in::infutorwp',CanadianPhones.thor_cluster + 'in::infutorwp::'+pVersion+ '::canadada.dat')
	);
return							  
sequential(sprayupdate
						,sfshuffle
						);
						
end;