/*2012-01-25T21:07:18Z (gwhitaker)
C:\Documents and Settings\gwhitaker\Application Data\LexisNexis\querybuilder\gwhitaker\default\zz_gwhitaker\mac_suppress_ADDR_dups\2012-01-25T21_07_18Z.ecl
*/
import doxie, LIB_WORD, ut;


export MAC_Suppress_ADDR_dups(inRecs, outRecs, prim_range='prim_range', predir='predir', prim_name='prim_name',
                              postdir='postdir',suffix='suffix', sec_range='sec_range', city_name='city_name', 
															st='st',zip='zip', fromDate ='fromDate', toDate='toDate',inCityName='') := MACRO

#uniquename(orderedLayout)
#uniquename(origIt)
#uniquename(recsOrig)
#uniquename(fixstreet)
#uniquename(layout)
#uniquename(fixedRR)
#uniquename(fixedRRSorted)
#uniquename(sortCitySt)
#uniquename(sameCitySt)
#uniquename(sortCityStZip)
#uniquename(sameCityStZip)
#uniquename(sortSameCityStZip)
#uniquename(sortApt)
#uniquename(sortPrimRange)
#uniquename(outRecsRolled)
#uniquename(outRecs)
#uniquename(fixedRRnoDups)
#uniquename(storeCity)
#uniquename(matchCity)
#uniquename(Zip2Flip)
#uniquename(CityOut)
#uniquename(finalOut)
#uniquename(cityNameRec)
#uniquename(cityNameAll)  //all key value pars for street addresess and citynames
#uniquename(cityNameCnts)  //key value pars for street addresses with cityname most used.
#uniquename(cityNameMostUsed)  //key value pars for street addresses with cityname most used.
#uniquename(changedCityName)
  
	%cityNameRec% := record
	  integer origOrder;
	  integer did;
	  string50 key; //zip|primrange|primname
	  string50 cityvalue;
		string110 LocationId;
		integer cnt
	end;
	
	%fixstreet%(STRING rawStreet) := FUNCTION
	//NOTE:  this fix assumes that all STATE ROUTES are a single set of characters/numbers (like: 234A not like 234 A)
	//removes all characters on STATE ROUTE addresses after the number that follows RR or ST RT or STATE ROUTE.
			outStreet  := map(lib_word.lead_contains(rawStreet,'RR ')  				=> 'STATE ROUTE '+ LIB_WORD.WORD(rawStreet,2) ,
												lib_word.lead_contains(rawStreet,'ST RT ') 			=> 'STATE ROUTE '+ LIB_WORD.WORD(rawStreet,3),
												lib_word.lead_contains(rawStreet,'ST RTE ') 		=> 'STATE ROUTE '+ LIB_WORD.WORD(rawStreet,3),
												lib_word.lead_contains(rawStreet,'RURAL ROUTE ')=> 'STATE ROUTE '+ LIB_WORD.WORD(rawStreet,3),
												lib_word.lead_contains(rawStreet,'STATE ROUTE ')=> 'STATE ROUTE '+ LIB_WORD.WORD(rawStreet,3),
												rawStreet);
			RETURN outStreet;
	END;
	
	%orderedLayout% := record(recordof(inRecs))
	   integer origOrder;
		 STRING mergedWith;
 	 end;
	
	%orderedLayout% %origIt%(inRecs l, integer c) := transform
	   self.origOrder := c;
		 self.mergedWith := '';
		 self := l;
	 end;
	 %recsOrig% := project(inRecs, %origIt%(left, counter));

// determine which city names were used the most
    %cityNameRec% addKeyValue(%recsOrig% l) := transform
		  self.origOrder := l.origOrder;
		  self.did := (integer)l.did;
		  self.key := trim(l.zip)+'|'+trim(l.prim_range)+'|'+l.prim_name+'|'+l.sec_range; //zip|primrange|primname|apt#
	    self.cityvalue := l.city_name;
			self.locationID := l.LocationID;
			self.cnt := 1;
		end;
    %cityNameAll% := project(%recsOrig%, addKeyValue(LEFT));
    %cityNameRec% namecnts(%cityNameAll% l, %cityNameAll% r) := transform
		   self.cnt := l.cnt + r.cnt;
			 self := l; //key all info from first record fror each key cityvalue combination.
		end;
		%cityNameCnts% := rollup(sort(%cityNameAll%, did, key, cityvalue, origOrder), namecnts(LEFT,RIGHT), did, key, cityvalue); 
		
		%cityNameRec% mostused(%cityNameCnts% l, %cityNameCnts% r) := transform
		  self := l;  //key all info from first record fror each key.
		end;
		%cityNameMostUsed% := rollup(sort(%cityNameCnts%,did, key,-cnt, origOrder),mostused(LEFT,RIGHT),did, key);
	// ***********************************************************
  //  USPS prefered CITY NAME needs to get added to fixit TRANSFORM to use for dedupping
	//  add additional cityname field to save list of non-usps citynames rolled up.
	//***************************************************************
   %matchCity% := (inCityName <> '');	 
   //fix STATE ROUTE, RR, ST RT when standardizer finds extra chars and doesn't standardize.
	 %orderedLayout%  fixit(%recsOrig% l) := transform
	    uspsCity := if (l.zip <> '', ut.ziptocities(l.zip).set_cities, [l.city_name] ) ;
			cityName2Use := if (l.city_name not in uspsCity, uspsCity[1], l.city_name);
			savedOrig := if (cityName2use <> l.city_name, l.city_name, '');
			self.city_name := cityName2Use;
			self.pCity := if (%matchCity% and (savedOrig=inCityName or inCityName in uspsCity), inCityName, '');
	    self.prim_name := IF (LENGTH(TRIM(L.PRIM_NAME)) = 0, L.PRIM_NAME, %fixstreet%(L.prim_name));
	    self := l;
	 end;
	 
	 %fixedRR% := project(%recsOrig%, fixit(left));
 
 // use the most use citynames and assign them to use from here on.
    %orderedLayout% changeCityName(%fixedRR% l,  %cityNameMostUsed% r) := transform
		  self.city_name := r.cityvalue;
			self.locationID := r.locationID;
			self := l;
		end;
	 %changedCityName% := join(%fixedRR%, %cityNameMostUsed%, right.did = left.did and right.key = trim(left.zip)+'|'+trim(left.prim_range)+'|'+left.prim_name+'|'+left.sec_range, changeCityName(LEFT,RIGHT), left outer, LIMIT(0),KEEP(1)); 	
	 
	 
	 %fixedRRSorted% := SORT(%changedCityName%, RECORD, EXCEPT origOrder, fromDate, toDate, mergedWith, pCity);

   // add count to cityname variations per address, used later for what cityname to use. 
 
	 //rollup entire record duplicates
	 %orderedLayout% rollupAddrDups(%fixedRR% l, %fixedRR% r) := transform
	  self.origOrder := if (l.origOrder < r.origOrder, l.origOrder, r.origOrder);
		self.mergedWith := map(r.mergedWith = '' and l.mergedwith <> ''=> l.mergedwith + '|'+ r.origOrder,
													 l.mergedWith = '' and r.mergedwith <> ''=> r.mergedwith + '|'+ l.origOrder,
													 (string)r.origOrder + '|'+ (string)l.origOrder);
    self.pCity := if (l.pCity <> '', l.pCity, r.pCity);
	  ut.mac_roll_DFS(fromDate);
		ut.mac_roll_DLS(toDate);
	  self := l;
	end;									 
	 %fixedRRnoDups% := rollup(%fixedRRSorted%, rollupAddrDups(LEFT,RIGHT), prim_range,predir,prim_name,postdir,suffix,sec_range,city_name,st,zip);

// rollup up addresses with no street or zip but same city state			
  %sortCitySt% := sort(%fixedRRnoDups%,DID, city_name, st, prim_range, prim_name, origOrder);						 
  %orderedLayout% rollCitySt(%sortCitySt% l, %sortCitySt% r) := transform
	  self.origOrder := if (l.origOrder < r.origOrder, l.origOrder, r.origOrder);
		self.mergedWith := map(r.mergedWith = '' and l.mergedwith <> ''=> l.mergedwith + '|'+ r.origOrder,
													 l.mergedWith = '' and r.mergedwith <> ''=> r.mergedwith + '|'+ l.origOrder,
													 (string)r.origOrder + '|'+ (string)l.origOrder);
    self.pCity := if (l.pCity <> '', l.pCity, r.pCity);				 
	  self.sec_range := if (l.sec_range = '', r.sec_range,l.sec_range);
		ut.mac_roll_DFS(fromDate);
		ut.mac_roll_DLS(toDate);
	  self := R;
	end;									 
  %sameCitySt% := rollup(%sortCitySt%,
                   LEFT.DID = RIGHT.DID AND
									 LEFT.city_name = RIGHT.city_name AND
									 LEFT.st = RIGHT.st AND
									 (LEFT.prim_range = '' and LEFT.prim_name = '') AND
									 (RIGHT.prim_range <> '' OR RIGHT.prim_name <> '') AND
									 LEFT.zip = '',
									 rollCitySt(LEFT,RIGHT));

// rollup up addresses with no street but same city state zip									 
  %sortCityStZip% := sort(%sameCitySt%,DID, city_name, st, zip, prim_range, prim_name, origOrder);
	%orderedLayout%   rollCityStZip(%sortCityStZip% l,%sortCityStZip% r) := transform
	  self.origOrder := if (l.origOrder < r.origOrder, l.origOrder, r.origOrder);
		self.mergedWith := map(r.mergedWith = '' and l.mergedwith <> ''=> l.mergedwith + '|'+ r.origOrder,
													 l.mergedWith = '' and r.mergedwith <> ''=> r.mergedwith + '|'+ l.origOrder,
													 (string)r.origOrder + '|'+ (string)l.origOrder);
    self.pCity := if (l.pCity <> '', l.pCity, r.pCity);				 
	  self.sec_range := if (l.sec_range = '', r.sec_range,l.sec_range);
		ut.mac_roll_DFS(fromDate);
		ut.mac_roll_DLS(toDate);
	  self := r;
	end;									 
  %sameCityStZip% := rollup(%sortCityStZip%,
                   LEFT.DID = RIGHT.DID AND
									 LEFT.city_name = RIGHT.city_name AND
									 LEFT.st = RIGHT.st AND
									 LEFT.zip = RIGHT.zip AND
									 (LEFT.prim_range = '' and LEFT.prim_name = '') AND
									 (RIGHT.prim_range <> '' OR RIGHT.prim_name <> ''),
									 rollCityStZip(LEFT,RIGHT));

	//now combine records with missing apt to those that do.								 
	%sortApt% := sort(%sameCityStZip%,DID, prim_range, predir,prim_name,suffix,postdir,city_name,st,zip, -sec_range);
	%orderedLayout% rollApt(%sortApt% l,%sortApt% r) := transform
	  self.origOrder := if (l.origOrder < r.origOrder, l.origOrder, r.origOrder);
		self.mergedWith := map(r.mergedWith = '' and l.mergedwith <> ''=> l.mergedwith + '|'+ r.origOrder,
													 l.mergedWith = '' and r.mergedwith <> ''=> r.mergedwith + '|'+ l.origOrder,
													 (string)r.origOrder + '|'+ (string)l.origOrder);
    self.pCity := if (l.pCity <> '', l.pCity, r.pCity);				 
	  self.sec_range := if (l.sec_range = '', r.sec_range,l.sec_range);
		ut.mac_roll_DFS(fromDate);
		ut.mac_roll_DLS(toDate);
	  self := l;
	end;
  %outRecsRolled% := rollup(%sortApt%,
                   LEFT.DID = RIGHT.DID AND
									 LEFT.prim_range = RIGHT.prim_range AND
									 LEFT.predir = RIGHT.predir AND
									 LEFT.prim_name = RIGHT.prim_name AND
									 LEFT.suffix = RIGHT.suffix AND
									 LEFT.postdir = RIGHT.postdir AND
									 LEFT.city_name = RIGHT.city_name AND
									 LEFT.st = RIGHT.st AND
									 LEFT.zip = RIGHT.zip AND
									 (LEFT.sec_range <> RIGHT.sec_range and RIGHT.sec_range = ''),
									 rollApt(LEFT,RIGHT));
   %Zip2Flip% := %outRecsRolled%(pCity <> '')[1].zip;
	 %orderedLayout% flipIt(%outRecsRolled% l) := transform
	    self.pCity := if (l.zip = %zip2flip%, inCityName, l.pCity);
	    self := l;
	 end;
	 %cityOut% := project(%outRecsRolled%, flipIt(LEFT));
	 
   //rollup records without house# (prim_range) with those that do.
	 
	 %sortPrimRange% := sort(%cityOut%,DID, predir,prim_name,suffix,postdir,city_name,st,zip, sec_range, -prim_range);
	 %orderedLayout% rollPrimRange(%sortPrimRange% l,%sortPrimRange% r) := transform
	  self.origOrder := if (l.origOrder < r.origOrder, l.origOrder, r.origOrder);
		self.mergedWith := map(r.mergedWith = '' and l.mergedwith <> ''=> l.mergedwith + '|'+ r.origOrder,
													 l.mergedWith = '' and r.mergedwith <> ''=> r.mergedwith + '|'+ l.origOrder,
													 (string)r.origOrder + '|'+ (string)l.origOrder);
    self.pCity := if (l.pCity <> '', l.pCity, r.pCity);				 
	  self.prim_range := if (l.prim_range = '', r.prim_range,l.prim_range);
		ut.mac_roll_DFS(fromDate);
		ut.mac_roll_DLS(toDate);
	  self := l;
	end;

	 %finalOut% := rollup(%sortPrimRange%,
                   LEFT.DID = RIGHT.DID AND
									 LEFT.predir = RIGHT.predir AND
									 LEFT.prim_name = RIGHT.prim_name AND
									 LEFT.suffix = RIGHT.suffix AND
									 LEFT.postdir = RIGHT.postdir AND
									 LEFT.city_name = RIGHT.city_name AND
									 LEFT.st = RIGHT.st AND
									 LEFT.zip = RIGHT.zip AND
									 LEFT.sec_range = RIGHT.sec_range AND
									 (LEFT.prim_range <> RIGHT.prim_range and RIGHT.prim_range = ''),
									 rollPrimRange(LEFT,RIGHT));
	 outrecs := sort(%finalOut%, origOrder);
	
ENDMACRO;
