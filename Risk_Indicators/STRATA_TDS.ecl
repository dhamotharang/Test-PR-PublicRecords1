import strata;

export STRATA_TDS(string filedate, boolean omit_output_to_screen = true) := function 

ds := Risk_Indicators.File_Telcordia_tds;

rSTRATA_TDS := record	 
	CountGroup              	:= count(group); 		
	npa												:= sum(group,if(ds.npa<>'',1,0));
	nxx												:= sum(group,if(ds.nxx<>'',1,0));
	tb												:= sum(group,if(ds.tb<>'',1,0));
	state											:= sum(group,if(ds.state<>'',1,0));
	timezone									:= sum(group,if(ds.timezone<>'',1,0));
	COCType										:= sum(group,if(ds.COCType<>'',1,0));
	SSC												:= sum(group,if(ds.SSC<>'',1,0));
	Wireless_ind 							:= sum(group,if(ds.Wireless_ind<>'',1,0));
 END;
 
 
 tStats := table(ds,rSTRATA_TDS, nxx,npa,tb,state,few);

strata.createXMLStats(tStats,'TDS','data',filedate,'',resultsOut,,,,,omit_output_to_screen);
return resultsOut;
end;