import strata;

export STRATA_City_State_Zip(string filedate) := function 

ds := RiskWise.Key_CityStZip;

rSTRATA_City_State_Zip := record	 
 CountGroup              	:= count(group); 			
	zip5  									:= ds.zip5;
	zipclass								:= sum(group,if(ds.zipclass<>'',1,0));
	city		  							:= ds.city;
	state	  								:= ds.state;
	county									:= sum(group,if(ds.county<>'',1,0));
	prefctystname 					:= sum(group,if(ds.prefctystname<>'',1,0));
 END;
 
 
 tStats := table(ds,rSTRATA_City_State_Zip,zip5,city,state,few);

strata.createXMLStats(tStats,'citystatezip','data',filedate,'',resultsOut);
return resultsOut;
end;