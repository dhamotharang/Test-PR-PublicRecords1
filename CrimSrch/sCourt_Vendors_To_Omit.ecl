export sCourt_Vendors_To_Omit
 :=
  [
	 '05',      //Criminal Court Convictions for the state of Minnesota
//   '06',      //Criminal Court AR Statewide
   '07',      //Criminal Court TN Statewide
   '08',      //Criminal Court NC Statewide
   '12',      //Criminal Court VA Statewide
   '14',      //Criminal Court convictions for the state of Rhode Island
   '15',      //Traffic  Court Convictions for the state of Rhode Island
   '16',      //Criminal Court San Bernardino County, California
	 '17',      //Criminal Court CA Los Angeles County
   '27',      //Criminal Court Convictions for Broward County, Florida
   '31',      //Criminal Court Oregan Statewide
   '34',      //Criminal Court Fl Duval Statewide Traffic and Criminal
   '44',      //Criminal Court Convictions for Osceola County, Florida
	 '46',      //Criminal Court PA Statewide
   '47',      //Criminal Court Convictions for Travis County, Texas
   '50',      //Criminal Court Convictions for Gregg County, Texas
   '54',      //Criminal Court Convictions for Chambers County, Texas
   '56',      //Criminal Court Convictions for Santa Cruz County, California
   '57',      //Criminal Court Convictions for Fairfax County, Virginia
   '59',      //Criminal Court Convictions for El Paso County, Texas
   '61',      //Criminal Court Convictions for the state of Oklahoma
   '64',      //Criminal Court CA Mendocino
   '65',      //Criminal Court AZ Maricopa
   '66',      //Criminal Court Fl Duval Statewide Traffic and Criminal
   '68',      //Criminal Court FL Orange
   '69',      //Criminal Court Administrative Office for Florida courts
   '70',      //Criminal Court TX Fort Bend
   '73',      //Criminal Court Convictions for Stanislaus, CA
   '76',      //Criminal Court Convictions for Lee County, Florida
   '77',      //Criminal Court Convictions for Comal County, Texas
   '78',      //Criminal Court Convictions for Lamar County, Texas
   '79',      //Criminal Court Convictions for Parker County, Texas
   '80',      //Criminal Court Convictions for Tom Green County, Texas
   '81',      //Criminal Court Convictions for the state of Georgia
   '82',      //Criminal Court Sentencing for the state of Oklahoma
   '86',      //Criminal Court TX Collin
   '90',      //Criminal Court AZ Mohave - Vendor Issue
   '94',      //Criminal court records in Brazoria County, Texas
   '97',      //Criminal Court TX Williamson - Layout Change - Reintegrated 20090306
	 '1D',        //Criminal Court records in OH Butler - Added ver. 20090814
   '1F',      //Criminal Court OH Clermont - Layout Change
   '1G',      //Criminal records in Columbiana County, Ohio - Added back ver. 20090814
	 '1H',      //Criminal Court records in OH Delaware - Added ver. 20090814
	 '1I',      //Criminal Court records in OH Fairfield - Added ver. 20110623
   '1J',      //Criminal Court records in Denver County, Colorado
	 '1L',      //Criminal Court records in OH Lake - Added ver. 20090814
	 '1O',      //Criminal Court records in OH Trumbull - Added ver. 20090814
   '1K',      //Criminal Court records in Santa Clara County, California
	 '1M',      //Criminal Court records in OH Sandusky
	 '1P',      //Criminal Court records in OH Tuscarawas
   '1R',      //Criminal records in Hamilton County, Ohio
	 '2H',      //Criminal Court records in OH Hancock
	 '2I',      //Criminal Court records in OH Fulton
	 '2K',      //Criminal Court records in OH Richland - Added ver. 20090814
	 '2L',      //Criminal Court records in OH Wayne - Added ver. 20090814
	 '2N',      //Criminal Court records in LA St Tammany - Added ver. 20100115
	 '2O',      //Criminal Court records in OH Mahoning - Added ver. 20090814
   '2Q',      //Criminal Court records in SC Greenville
   '2T',      //Criminal Court records in FL Hernando
   '2W',      //Criminal Court records in OH Adams
	 '3C',      //Criminal Court records in OH Allen Lima Municipal
	 '3D',      //OH Athens - Alpahretta fulfilled Criminal Court
	 '3E',      //OH Ross Municiapal - Alpahretta fulfilled Criminal Court
   '3F',      //OH Brown - Alpahretta fulfilled Criminal Court
	 '3G',      //OH Clinton - Alpahretta fulfilled Criminal Court
	 '3H',      //OH Cuyahoga - Alpahretta fulfilled Criminal Court
	 '3I',      //OH Lawrence - Alpahretta fulfilled Criminal Court
	 '3J',      //OH Pickaway - Alpahretta fulfilled Criminal Court
	 '3K',      //TX Garyson - Alpahretta fulfilled Criminal Court
	 '3L',      //TX Lamar - Alpahretta fulfilled Criminal Court
	 '3M',      //Criminal Court records in FL Sarasota
	 '3N',      //Criminal Court records in LA East Baton Rouge
	 '3O',      //Criminal Court records in LA Jefferson
	 '3Q',      //SC Richland - Alpahretta fulfilled Criminal Court
	 '3X',      //OH Ross Common Pleas - Alpahretta fulfilled Criminal Court
	 '4C',      //OH Summit CuyhaogaFalls - Alpahretta fulfilled Criminal Court
	 '4D',      //OH Brown - Alpahretta fulfilled Criminal Court
	 '4G',      //OH Summit - Alpahretta fulfilled Criminal Court
   'CO',      //Felony Convictions for the Colorado
   'DC',      //Felony Convictions for the District of Columbia
   'GA',      //Felony Convictions for the state of Iowa
   'IA',      //Felony Convictions for the state of Iowa
	 'IL',       //Felony Convictions for the state of Illinois
   'KY',      //Felony Convictions for the state of Kentuckey
	 'LA',       //Felony Convictions for the state of Louisiana
   'ME',      //Felony Convictions for the state of Maine
	 //'MS',      //MS Statewide
   'NV',      //NV Statewide      
	 'NY',       //Felony Convictions for the state of New York
   'PA',      //Inmate records for the state of Pennsylvania
	 'UT',      //Felony Convictions for the state of Utah
   'VA',      //Felony Convictions for the state of Virginia
   'WA',       //Felony Convictions for the state of Washington
   'WI',       //Felony Convictions for the state of Wisconsin
   'WV'       //Felony Convictions for the state of West Virginia
	//NV, CA, and UT Sex Offenders are being removed also but in this case the CrimSrch.Out_Offender and CrimSrch.Out_Offenses
	//have a filter condition applied because the vendor is C2 for all the Sex Offender data.
  ]
 ;