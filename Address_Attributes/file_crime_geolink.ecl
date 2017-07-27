import address_attributes, doxie_build, doxie_files;

//Append Geolink Population and crime data for a rolling 12 months
//Pull geolink population for the last 12 months
head 				:= doxie_build.file_header_building;
earliest 		:= address_attributes.Constants.YearsAgo(1)[1..6];
head_valid 	:= head(dt_first_seen != 0, dt_last_seen > (unsigned3)earliest, prim_name[1..6] != 'PO BOX',trim(st)!='',trim(county)!='',trim(geo_blk)!='');
a2d   			:= address_attributes.Functions.AddrToDid(head_valid, true);

layout_geolink := record
	string12 geolink;
end;
rHeadCrim := record
	layout_geolink;
	recordof(doxie_build.file_header_building);
	boolean criminal_hit; //Found them on file
	boolean	criminal;			//New crime within the last 12 months
	integer	crime_count;	//Number of crimes on record
	boolean	felony_hit;		//Found a felony hit on file
	boolean	felon;				//New felony within the last 12 months
	integer felony_count;	//Total number of felonies
end;
layout_Crime := record
	unsigned2		population;			//Did count wintin the last 12 months
	unsigned2		criminal_12;		//Count of people with a convictions within the last 12 months			
	unsigned2		criminals;			//Count of people with a prior conviction	ever
	unsigned2		crimes_tot;			//Number of historic convictions
	decimal8_6	crim_12_ratio; 	//Ratio between population within last 12 months and new criminal convictions
	decimal8_6	crim_ratio;			//Ratio between population within last 12 months and all people with criminal convictions
	decimal8_6	crim_tot_ratio;	//Ratio between population within last 12 months and total criminal convictions
	unsigned2		felon_12;				//Count of people with a felony within the last 12 months	
	unsigned2		felons;					//Count of people with a prior felony	ever
	unsigned2		felonies_tot;		//Number of felonies ever
	decimal8_6	felon_12_ratio;	//Ratio between population within last 12 months and new felony convictions
	decimal8_6	felon_ratio;		//Ratio between population within last 12 months and all people with felony convictions
	decimal8_6	felon_tot_ratio;//Ratio between population within last 12 months and total felony convictions
end;
layout_Crime_geolink := record
	layout_geolink;
	layout_Crime;
end;
//

//Criminal Current Year////////////////////
Crim2 := doxie_files.Key_BocaShell_Crim2;
rHeadCrim pullCriminal(a2d l, Crim2 r) := transform
		self.did := l.did;
		self.criminal_hit := r.did = l.did;
		self.felony_hit := if(r.felony_count > 0, true, false);
		self.felony_count := r.felony_count;
		self.crime_count := r.criminal_count;
		self.Criminal := if((string)r.last_criminal_date[1..6] >= earliest or (string)r.last_felony_date[1..6] >= earliest, true, false);	
		self.Felon := if((string)r.last_felony_date[1..6] >= earliest, true, false);	
		self.geolink := l.st + l.county + l.geo_blk;
		self := l;
end;
head_crim := join(a2d, Crim2,
					keyed(left.did = right.did),
					pullCriminal(left, right), left outer, keep(1));

dCrim := distribute(head_crim, hash32(geolink));

layout_Crime_geolink countPop(dCrim l) := TRANSFORM
		self.population 	:= 1;												//Did count wintin the last 12 months
		
		self.criminal_12 	:= if(l.Criminal, 1,0);			//Count of people with a convictions within the last 12 months			
		self.criminals 		:= if(l.criminal_hit, 1,0);	//Count of people with a prior conviction	ever
		self.crimes_tot 	:= l.crime_count;						//Number of historic convictions
		
		self.felon_12 		:= if(l.Felon, 1,0);				//Count of people with a felony within the last 12 months	
		self.felons 			:= if(l.felony_hit, 1,0);		//Count of people with a prior felony	ever
		self.felonies_tot := l.felony_count;					//Number of felonies ever
		
		self := l;
		self := [];
END;

address_pops := project(dCrim, countPop(left), local);

layout_Crime_geolink rollOccupants(layout_Crime_geolink l, layout_Crime_geolink r) := TRANSFORM
		self.population := l.population + r.population;
		self.criminal_12 := l.criminal_12 + r.criminal_12;
		self.criminals := l.criminals + r.criminals;
		self.crimes_tot := l.crimes_tot + r.crimes_tot;
		self.felon_12 := l.felon_12 + r.felon_12;
		self.felons := l.felons + r.felons;
		self.felonies_tot := l.felonies_tot + r.felonies_tot;
		self := l;
END;
	
sortaddr := sort(address_pops, geolink, local);
Neighborhood_Criminals := rollup(sortaddr,
		left.geolink = right.geolink,
		rollOccupants(left,right), local);


layout_Crime_geolink calcRatios(Neighborhood_Criminals l) := TRANSFORM
	self.crim_12_ratio 		:= l.criminal_12 / l.population; 	//Ratio between population within last 12 months and new criminal convictions
	self.crim_ratio 			:= l.criminals / l.population;		//Ratio between population within last 12 months and all criminal convictions
	self.crim_tot_ratio 	:= l.crimes_tot / l.population;		//Ratio between population within last 12 months and total criminal convictions
	self.felon_12_ratio 	:= l.felon_12 / l.population;			//Ratio between population within last 12 months and new felony convictions
	self.felon_ratio 			:= l.felons / l.population;				//Ratio between population within last 12 months and all felony convictions
	self.felon_tot_ratio	:= l.felonies_tot / l.population;	//Ratio between population within last 12 months and total felony convictions
	self := l;
END;

finalCrim := project(Neighborhood_Criminals, calcRatios(left), local);


EXPORT file_crime_geolink := finalCrim;