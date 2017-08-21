import strata;


export STRATA_XML_TPM(string filedate) := function

ds:= Telcordia_tpm_base;


 Layout_tmp_strata := 
   record
   CountGroup                                                             := count(group); 																							
    ds.npa;
    nxx								                                   		:= sum(group,if(ds.nxx<>'',1,0));
    tb								                                     	:= sum(group,if(ds.tb<>'',1,0));
    city												                            := sum(group,if(ds.city<>'',1,0));
    st										                                 	:= sum(group,if(ds.st<>'',1,0));
    ocn											                                := sum(group,if(ds.ocn<>'',1,0));
    company_type														                := sum(group,if(ds.company_type<>'',1,0));
    dial_ind									       												:= sum(group,if(ds.dial_ind<>'',1,0));
    point_id									     													:= sum(group,if(ds.point_id<>'',1,0));
  end;
	
tStats := table(ds,Layout_tmp_strata,npa,few);

zOrig_Stats := output(choosen(tStats,all));

STRATA.createXMLStats(tStats,'TPM','base',filedate,'jfreibaum@seisint.com',npa,'View','population')


return sequential (zOrig_Stats,npa);

									  
END;
									 