import _control;

export spray_CanadianWhitepages(string filedate) := function

// sprayupdate1     := FileServices.SprayFixed(_Control.IPAddress.edata12, '/data/hds_2/telephones/canadian/'+ filedate +'/canada.dat' ,291, 'thor_dell400', 
							  // CanadianPhones.thor_cluster + 'in::canadian_wp::'+filedate+ '::canada.dat' , , , ,true,true,false);
							  
// sprayupdate2     := FileServices.SprayFixed(_Control.IPAddress.edata12, '/data/hds_2/telephones/canadian/business/'+ filedate +'/canada.dat' ,291, 'thor_dell400', 
							  // CanadianPhones.thor_cluster + 'base::infoUSA::'+filedate+ '::canada.dat' , , , ,true,true,false);

sprayupdate3     := FileServices.SprayVariable(_Control.IPAddress.bctlpedata11,
                        '/data/hds_2/telephones/canadian/axciom/data/residential/'+ filedate +'/canres.csv',
                        ,                  					// max rec size
                        ',',              					// separator
						'\r\n',             				// end of rec terminator
                        ,              					    // quotations included
                        'thor400_44',    	// cluster
                        CanadianPhones.thor_cluster + 'in::axciomRes::'+filedate+ '::canada.dat',      // filename on Thor
                        ,
                        ,
                        ,
                        true,             // overwrite
                        true,             // replicate
                        false             // compress
                   ); 
				   	  
sprayupdate4     := FileServices.SprayVariable(_Control.IPAddress.bctlpedata11,
                        '/data/hds_2/telephones/canadian/axciom/data/business/'+ filedate +'/canbus.csv',
                        ,                  					// max rec size
                        ',',              					// separator
						'\r\n',             				// end of rec terminator
                        ,              					    // quotations included
                        'thor400_44',    	// cluster
                        CanadianPhones.thor_cluster + 'in::axciomBus::'+filedate+ '::canada.dat',      // filename on Thor
                        ,
                        ,
                        ,
                        true,             // overwrite
                        true,             // replicate
                        false             // compress
                   ); 

		  
sfShuffle := sequential(
	//fileservices.startsuperfiletransaction(),
	
	// fileservices.clearsuperfile(CanadianPhones.thor_cluster + 'in::canadianwp'),
	// fileservices.addsuperfile(CanadianPhones.thor_cluster + 'in::canadianwp',CanadianPhones.thor_cluster + 'in::canadian_wp::'+filedate+ '::canada.dat'),
	// fileservices.clearsuperfile(CanadianPhones.thor_cluster + 'base::infoUSA'),
	// fileservices.addsuperfile(CanadianPhones.thor_cluster + 'base::infoUSA',CanadianPhones.thor_cluster + 'in::infoUSA::'+filedate+ '::canada.dat'),
	fileservices.addsuperfile(CanadianPhones.thor_cluster + 'in::axciomRes',CanadianPhones.thor_cluster + 'in::axciomRes::'+filedate+ '::canada.dat'),
	fileservices.addsuperfile(CanadianPhones.thor_cluster + 'in::axciomBus',CanadianPhones.thor_cluster + 'in::axciomBus::'+filedate+ '::canada.dat')
	//fileservices.finishsuperfiletransaction()
	);
return							  
sequential(//sprayupdate1
						//,sprayupdate2
						 sprayupdate3
						,sprayupdate4
						,sfshuffle
						);
						
end;