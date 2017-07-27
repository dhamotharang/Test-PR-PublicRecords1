export get_fl_cities(string pInput) :=
        map(
         pInput = '11-02-E' => 'Alachua'
        ,pInput = '11-04-A' => 'Gainesville'
        ,pInput = '11-08-E' => 'High Springs'
        ,pInput = '11-14-F' => 'Newberry **'
        ,pInput = '11-98'   => 'Sea/Air Occurrence'
        ,pInput = '11-99'   => 'Balance of County'
        ,pInput = '12-02-E' => 'Macclenny'
        ,pInput = '12-98'   => 'Sea/Air Occurrence'
        ,pInput = '12-99'   => 'Balance of County'
        ,pInput = '13-02-D' => 'Callaway'
        ,pInput = '13-04-D' => 'Lynn Haven'
        ,pInput = '13-06-C' => 'Panama City'
        ,pInput = '13-05-E' => 'Panama City Beach'
        ,pInput = '13-07-E' => 'Parker'
        ,pInput = '13-08-E' => 'Springfield'
        ,pInput = '13-98'   => 'Sea/Air Occurrence'
        ,pInput = '13-99'   => 'Balance of County'
				,pInput = '14-02-E' => 'Starke'
        ,pInput = '14-98'   => 'Sea/Air Occurrence'
        ,pInput = '14-99'   => 'Balance of County'
        ,pInput = '15-01-E' => 'Cape Canaveral'
        ,pInput = '15-02-D' => 'Cocoa'
        ,pInput = '15-03-D' => 'Cocoa Beach'
        ,pInput = '15-05-E' => 'Indialantic'
        ,pInput = '15-13-E' => 'Indian Harbour Beach'
        ,pInput = '15-14-F' => 'Malabar **'
        ,pInput = '15-06-B' => 'Melbourne'
        ,pInput = '15-11-E' => 'Melbourne Beach'
        ,pInput = '15-07-B' => 'Palm Bay'
        ,pInput = '15-08-D' => 'Rockledge'
        ,pInput = '15-09-D' => 'Satellite Beach'
        ,pInput = '15- C'   => 'Titusville'
        ,pInput = '15-12-E' => 'West Melbourne'
        ,pInput = '15-98'   => 'Sea/Air Occurrence'
        ,pInput = '15-99'   => 'Balance of County'
        ,pInput = '16-24-C' => 'Coconut Creek'
				,pInput = '16-01-C' => 'Cooper City'
        ,pInput = '16-03-A' => 'Coral Springs'
        ,pInput = '16-02-D' => 'Dania'
        ,pInput = '16-05-B' => 'Davie'
        ,pInput = '16-04-B' => 'Deerfield Beach'
        ,pInput = '16-06-A' => 'Fort Lauderdale'
        ,pInput = '16-08-C' => 'Hallandale'
        ,pInput = '16- A'   => 'Hollywood'
        ,pInput = '16-07-E' => 'Lauderdale-by-the-Sea'
        ,pInput = '16-21-C' => 'Lauderdale Lakes'
        ,pInput = '16-09-B' => 'Lauderhill'
        ,pInput = '16-22-D' => 'Lighthouse Point'
        ,pInput = '16-11-B' => 'Margate'
        ,pInput = '16-12-B' => 'Miramar'
        ,pInput = '16-17-C' => 'North Lauderdale'
        ,pInput = '16-13-C' => 'Oakland Park'
        ,pInput = '16-25-D' => 'Parkland'
        ,pInput = '16-23-E' => 'Pembroke Park'
        ,pInput = '16-15-A' => 'Pembroke Pines'
				,pInput = '16-14-B' => 'Plantation'
        ,pInput = '16-16-B' => 'Pompano Beach'
        ,pInput = '16-18-B' => 'Sunrise'
        ,pInput = '16-19-B' => 'Tamarac'
        ,pInput = '16-26-C' => 'Weston **'
        ,pInput = '16-20-D' => 'Wilton Manors'
        ,pInput = '16-98'   => 'Sea/Air Occurrence'
        ,pInput = '16-99'   => 'Balance of County'
        ,pInput = '17-02-E' => 'Blountstown'
        ,pInput = '17-98'   => 'Sea/Air Occurrence'
        ,pInput = '17-99'   => 'Balance of County'
        ,pInput = '18-02-D' => 'Punta Gorda'
        ,pInput = '18-98'   => 'Sea/Air Occurrence'
        ,pInput = '18-99'   => 'Balance of County'
        ,pInput = '19-01-E' => 'Crystal River'
        ,pInput = '19-04-E' => 'Inverness'
        ,pInput = '19-98'   => 'Sea/Air Occurrence'
        ,pInput = '19-99'   => 'Balance of County'
        ,pInput = '20-02-E' => 'Green Cove Springs'
				,pInput = '20-04-E' => 'Orange Park'
        ,pInput = '20-98'   => 'Sea/Air Occurrence'
        ,pInput = '20-99'   => 'Balance of County'
        ,pInput = '21-01-D' => 'Marco Island **'
        ,pInput = '21-02-D' => 'Naples'
        ,pInput = '21-98'   => 'Sea/Air Occurrence'
        ,pInput = '21-99'   => 'Balance of County'
        ,pInput = '22-02-D' => 'Lake City'
        ,pInput = '22-98'   => 'Sea/Air Occurrence'
        ,pInput = '22-99'   => 'Balance of County'
        ,pInput = '23-03-D' => 'Aventura **'
        ,pInput = '23-01-E' => 'Bal Harbour'
        ,pInput = '23-02-E' => 'Bay Harbor Islands'
        ,pInput = '23-04-E' => 'Biscayne Park'
        ,pInput = '23-06-C' => 'Coral Gables'
        ,pInput = '23-08-E' => 'El Portal'
        ,pInput = '23- E'   => 'Florida City'
        ,pInput = '23-12-A' => 'Hialeah'
        ,pInput = '23-13-D' => 'Hialeah Gardens'
				,pInput = '23-14-C' => 'Homestead'
        ,pInput = '23-15-E' => 'Key Biscayne'
        ,pInput = '23-16-A' => 'Miami'
        ,pInput = '23-18-B' => 'Miami Beach'
        ,pInput = '23-20-D' => 'Miami Shores'
        ,pInput = '23-22-D' => 'Miami Springs'
        ,pInput = '23-23-E' => 'North Bay Village'
        ,pInput = '23-24-B' => 'North Miami'
        ,pInput = '23-26-C' => 'North Miami Beach'
        ,pInput = '23-28-D' => 'Opa-Locka'
        ,pInput = '23-30-D' => 'Pinecrest **'
        ,pInput = '23-32-D' => 'South Miami'
        ,pInput = '23-33-D' => 'Sunny Isles Beach **'
        ,pInput = '23-34-E' => 'Surfside'
        ,pInput = '23-35-D' => 'Sweetwater'
        ,pInput = '23-36-G' => 'Virginia Gardens'
        ,pInput = '23-38-E' => 'West Miami'
        ,pInput = '23-98'   => 'Sea/Air Occurrence'
        ,pInput = '23-99'   => 'Balance of County'
				,pInput = '24-02-E' => 'Arcadia'
        ,pInput = '24-98'   => 'Sea/Air Occurrence'
        ,pInput = '24-99'   => 'Balance of County'
        ,pInput = '25-98'   => 'Sea/Air Occurrence'
        ,pInput = '25-99'   => 'Balance of County'
        ,pInput = '26-02-D' => 'Atlantic Beach'
        ,pInput = '26-04-G' => 'Baldwin'
        ,pInput = '26-08-A' => 'Jacksonville'
        ,pInput = '26- D'   => 'Jacksonville Beach'
        ,pInput = '26-12-E' => 'Neptune Beach'
        ,pInput = '26-98'   => 'Sea/Air Occurrence'
        ,pInput = '26-08'   => 'Balance of County'
        ,pInput = '27-03-G' => 'Century'
        ,pInput = '27-08-B' => 'Pensacola'
        ,pInput = '27-98'   => 'Sea/Air Occurrence'
        ,pInput = '27-99'   => 'Balance of County'
        ,pInput = '28-01-E' => 'Flagler Beach'
        ,pInput = '28-98'   => 'Sea/Air Occurrence'
        ,pInput = '28-99'   => 'Balance of County'
				,pInput = '29-02-E' => 'Apalachicola'
        ,pInput = '29-98'   => 'Sea/Air Occurrence'
        ,pInput = '29-99'   => 'Balance of County'
        ,pInput = '30-02-E' => 'Chattahoochee'
        ,pInput = '30-03-E' => 'Gretna **'
        ,pInput = '30-04-G' => 'Havana'
        ,pInput = '30-06-E' => 'Quincy'
        ,pInput = '30-98'   => 'Sea/Air Occurrence'
        ,pInput = '30-99'   => 'Balance of County'
        ,pInput = '31-98'   => 'Sea/Air Occurrence'
        ,pInput = '31-99'   => 'Balance of County'
        ,pInput = '32-98'   => 'Sea/Air Occurrence'
        ,pInput = '32-99'   => 'Balance of County'
        ,pInput = '33-02-E' => 'Port St. Joe'
        ,pInput = '33-98'   => 'Sea/Air Occurrence'
        ,pInput = '33-99'   => 'Balance of County'
        ,pInput = '34-98'   => 'Sea/Air Occurrence'
        ,pInput = '34-99'   => 'Balance of County'
        ,pInput = '35-01-G' => 'Bowling Green'
				,pInput = '39-99'   => 'Balance of County'
        ,pInput = '40-01-E' => 'Bonifay'
        ,pInput = '40-98'   => 'Sea/Air Occurrence'
        ,pInput = '40-99'   => 'Balance of County'
        ,pInput = '41-01-E' => 'Fellsmere **'
        ,pInput = '41-02-E' => 'Indian River Shores'
        ,pInput = '41-03-D' => 'Sebastian'
        ,pInput = '41-04-D' => 'Vero Beach'
        ,pInput = '41-98'   => 'Sea/Air Occurrence'
        ,pInput = '41-99'   => 'Balance of County'
        ,pInput = '42-02-E' => 'Graceville'
        ,pInput = '42-04-E' => 'Marianna'
        ,pInput = '42-98'   => 'Sea/Air Occurrence'
        ,pInput = '42-99'   => 'Balance of County'
        ,pInput = '43-02-E' => 'Monticello'
        ,pInput = '43-98'   => 'Sea/Air Occurrence'
        ,pInput = '43-99'   => 'Balance of County'
        ,pInput = '44-98'   => 'Sea/Air Occurrence'
        ,pInput = '44-99'   => 'Balance of County'
        ,pInput = '45-02-E' => 'Clermont'
        ,pInput = '45-04-D' => 'Eustis'
        ,pInput = '45-06-E' => 'Fruitland Park'
        ,pInput = '45-05-E' => 'Groveland'
        ,pInput = '45-07-D' => 'Lady Lake'
        ,pInput = '45-08-D' => 'Leesburg'
        ,pInput = '45-09-F' => 'Mascotte **'
        ,pInput = '45-11-E' => 'Minneola **'
        ,pInput = '45- E'   => 'Mount Dora'
        ,pInput = '45-12-E' => 'Tavares'
        ,pInput = '45-14-F' => 'Umatilla'
        ,pInput = '45-98'   => 'Sea/Air Occurrence'
        ,pInput = '45-99'   => 'Balance of County'
        ,pInput = '46-01-B' => 'Cape Coral'
        ,pInput = '46-02-C' => 'Fort Myers'
        ,pInput = '46-04-E' => 'Fort Myers Beach **'
        ,pInput = '46-03-E' => 'Sanibel'
        ,pInput = '46-98'   => 'Sea/Air Occurrence'
				 ,pInput = '46-99'   => 'Balance of County'
        ,pInput = '47-04-A' => 'Tallahassee'
        ,pInput = '47-98'   => 'Sea/Air Occurrence'
        ,pInput = '47-99'   => 'Balance of County'
        ,pInput = '48- G'   => 'Williston'
        ,pInput = '48-98'   => 'Sea/Air Occurrence'
        ,pInput = '48-99'   => 'Balance of County'
        ,pInput = '49-98'   => 'Sea/Air Occurrence'
        ,pInput = '49-99'   => 'Balance of County'
        ,pInput = '50-04-E' => 'Madison'
        ,pInput = '50-98'   => 'Sea/Air Occurrence'
        ,pInput = '50-99'   => 'Balance of County'
        ,pInput = '51-02-C' => 'Bradenton'
        ,pInput = '51-01-G' => 'Bradenton Beach'
        ,pInput = '51-03-E' => 'Holmes Beach'
        ,pInput = '51-05-E' => 'Longboat Key M...*'
        ,pInput = '51-06-D' => 'Palmetto'
        ,pInput = '51-98'   => 'Sea/Air Occurrence'
        ,pInput = '51-99'   => 'Balance of County'
        ,pInput = '52-02-E' => 'Belleview'
        ,pInput = '52-04-C' => 'Ocala'
        ,pInput = '52-98'   => 'Sea/Air Occurrence'
        ,pInput = '52-99'   => 'Balance of County'
        ,pInput = '53-02-D' => 'Stuart'
        ,pInput = '53-03-B' => 'Port St. Lucie M...*'
        ,pInput = '53-98'   => 'Sea/Air Occurrence'
        ,pInput = '53-99'   => 'Balance of County'
        ,pInput = '54-02-C' => 'Key West'
        ,pInput = '54-04-E' => 'Islamorada **'
        ,pInput = '54-06-F' => 'Marathon **'
        ,pInput = '54-98'   => 'Sea/Air Occurrence'
        ,pInput = '54-99'   => 'Balance of County'
        ,pInput = '55-02-D' => 'Fernandina Beach'
        ,pInput = '55-04-E' => 'Hilliard'
        ,pInput = '55-98'   => 'Sea/Air Occurrence'
        ,pInput = '55-99'   => 'Balance of County'
        ,pInput = '56-02-D' => 'Crestview'
				,pInput = '56-04-D' => 'Destin'
        ,pInput = '56-06-D' => 'Fort Walton Beach'
        ,pInput = '56-07-E' => 'Mary Esther'
        ,pInput = '56-08-D' => 'Niceville'
        ,pInput = '56- E'   => 'Valparaiso'
        ,pInput = '56-98'   => 'Sea/Air Occurrence'
        ,pInput = '56-99'   => 'Balance of County'
        ,pInput = '57-02-E' => 'Okeechobee'
        ,pInput = '57-98'   => 'Sea/Air Occurrence'
        ,pInput = '57-99'   => 'Balance of County'
        ,pInput = '58-02-D' => 'Apopka'
        ,pInput = '58-03-E' => 'Belle Isle'
        ,pInput = '58-05-F' => 'Eatonville'
        ,pInput = '58-04-D' => 'Maitland O...*'
        ,pInput = '58-06-D' => 'Ocoee'
        ,pInput = '58-08-A' => 'Orlando'
        ,pInput = '58- D'   => 'Winter Garden'
        ,pInput = '58-12-D' => 'Winter Park'
        ,pInput = '58-98'   => 'Sea/Air Occurrence'
        ,pInput = '58-99'   => 'Balance of County'
        ,pInput = '59-02-C' => 'Kissimmee'
        ,pInput = '59-04-D' => 'St. Cloud'
        ,pInput = '59-98'   => 'Sea/Air Occurrence'
        ,pInput = '59-99'   => 'Balance of County'
        ,pInput = '60-02-D' => 'Belle Glade'
        ,pInput = '60-06-B' => 'Boca Raton'
        ,pInput = '60-08-B' => 'Boynton Beach'
        ,pInput = '60-14-B' => 'Delray Beach'
        ,pInput = '60-01-D' => 'Greenacres City'
        ,pInput = '60-05-E' => 'Highland Beach'
        ,pInput = '60-12-E' => 'Juno Beach'
        ,pInput = '60-03-C' => 'Jupiter'
        ,pInput = '60-04-E' => 'Lake Clarke Shores'
        ,pInput = '60-15-E' => 'Lake Park'
        ,pInput = '60-16-C' => 'Lake Worth'
        ,pInput = '60-18-E' => 'Lantana'
        ,pInput = '60-19-D' => 'North Palm Beach'
				 ,pInput = '60-20-E' => 'Pahokee'
        ,pInput = '60-22-E' => 'Palm Beach'
        ,pInput = '60-07-C' => 'Palm Beach Gardens'
        ,pInput = '60-23-D' => 'Palm Springs'
        ,pInput = '60-24-C' => 'Riviera Beach'
        ,pInput = '60-11-D' => 'Royal Palm Beach'
        ,pInput = '60-09-E' => 'South Bay'
        ,pInput = '60- E'   => 'Tequesta'
        ,pInput = '60-28-C' => 'Wellington **'
        ,pInput = '60-30-B' => 'West Palm Beach'
        ,pInput = '60-98'   => 'Sea/Air Occurrence'
        ,pInput = '60-99'   => 'Balance of County'
        ,pInput = '61-02-E' => 'Dade City'
        ,pInput = '61-06-D' => 'New Port Richey'
        ,pInput = '61-07-E' => 'Port Richey'
        ,pInput = '61-08-E' => 'Zephyrhills'
        ,pInput = '61-98'   => 'Sea/Air Occurrence'
        ,pInput = '61-99'   => 'Balance of County'
        ,pInput = '62-02-E' => 'Belleair'
        ,pInput = '62-11-G' => 'Belleair Bluffs'
        ,pInput = '62-04-A' => 'Clearwater'
        ,pInput = '62-06-C' => 'Dunedin'
        ,pInput = '62-08-D' => 'Gulfport'
        ,pInput = '62-01-E' => 'Indian Rocks Beach'
        ,pInput = '62-03-E' => 'Kenneth City'
        ,pInput = '62- B'   => 'Largo'
        ,pInput = '62-12-E' => 'Madeira Beach'
        ,pInput = '62-13-D' => 'Oldsmar'
        ,pInput = '62-14-C' => 'Pinellas Park'
        ,pInput = '62-15-G' => 'Redington Shores'
        ,pInput = '62-05-D' => 'Safety Harbor'
        ,pInput = '62-16-A' => 'St. Petersburg'
        ,pInput = '62-17-E' => 'St. Petersburg Beach'
        ,pInput = '62-07-E' => 'Seminole'
        ,pInput = '62-09-E' => 'South Pasadena'
        ,pInput = '62-18-D' => 'Tarpon Springs'
        ,pInput = '62-20-E' => 'Treasure Island'
				,pInput = '62-98'   => 'Sea/Air Occurrence'
        ,pInput = '62-99'   => 'Balance of County'
        ,pInput = '63'      => 'New Smyrna Beach'
        ,pInput = '63-02-E' => 'Auburndale'
        ,pInput = '63-04-D' => 'Bartow'
        ,pInput = '63-07-E' => 'Dundee'
        ,pInput = '63- E'   => 'Fort Meade'
        ,pInput = '63-12-E' => 'Frostproof'
        ,pInput = '63-14-D' => 'Haines City'
        ,pInput = '63-16-E' => 'Lake Alfred'
        ,pInput = '63-22-D' => 'Lake Wales'
        ,pInput = '63-18-B' => 'Lakeland'
        ,pInput = '63-24-E' => 'Mulberry'
        ,pInput = '63-30-C' => 'Winter Haven'
        ,pInput = '63-98'   => 'Sea/Air Occurrence'
        ,pInput = '63-99'   => 'Balance of County'
        ,pInput = '64-04-D' => 'Palatka'
        ,pInput = '64-98'   => 'Sea/Air Occurrence'
        ,pInput = '64-99'   => 'Balance of County'
        ,pInput = '65-04-D' => 'St. Augustine'
        ,pInput = '65-05-E' => 'St. Augustine Beach'
        ,pInput = '65-98'   => 'Sea/Air Occurrence'
        ,pInput = '65-99'   => 'Balance of County'
        ,pInput = '66-02-C' => 'Fort Pierce'
        ,pInput = '66-03-B' => 'Port St. Lucie S...*'
        ,pInput = '66-98'   => 'Sea/Air Occurrence'
        ,pInput = '66-99'   => 'Balance of County'
        ,pInput = '67-04-E' => 'Gulf Breeze'
        ,pInput = '67-02-E' => 'Milton'
        ,pInput = '67-98'   => 'Sea/Air Occurrence'
        ,pInput = '67-99'   => 'Balance of County'
        ,pInput = '68-02-E' => 'Longboat Key S...*'
        ,pInput = '68-03-D' => 'North Port'
        ,pInput = '68-04-B' => 'Sarasota'
        ,pInput = '68-06-D' => 'Venice'
        ,pInput = '68-98'   => 'Sea/Air Occurrence'
        ,pInput = '68-99'   => 'Balance of County'
				,pInput = '69-02-C' => 'Altamonte Springs'
        ,pInput = '69-04-D' => 'Casselberry'
        ,pInput = '69-01-E' => 'Lake Mary'
        ,pInput = '69-03-D' => 'Longwood'
        ,pInput = '69-14-E' => 'Maitland S...*'
        ,pInput = '69-05-D' => 'Oviedo'
        ,pInput = '69-06-C' => 'Sanford'
        ,pInput = '69- C'   => 'Winter Springs'
        ,pInput = '69-98'   => 'Sea/Air Occurrence'
        ,pInput = '69-99'   => 'Balance of County'
        ,pInput = '70-02-F' => 'Bushnell **'
        ,pInput = '70- E'   => 'Wildwood'
        ,pInput = '70-98'   => 'Sea/Air Occurrence'
        ,pInput = '70-99'   => 'Balance of County'
        ,pInput = '71-02-E' => 'Live Oak'
        ,pInput = '71-98'   => 'Sea/Air Occurrence'
        ,pInput = '71-99'   => 'Balance of County'
        ,pInput = '72-04-E' => 'Perry'
        ,pInput = '72-98'   => 'Sea/Air Occurrence'
        ,pInput = '72-99'   => 'Balance of County'
        ,pInput = '73-98'   => 'Sea/Air Occurrence'
        ,pInput = '73-99'   => 'Balance of County'
        ,pInput = '74-02-B' => 'Daytona Beach'
        ,pInput = '74-03-E' => 'Daytona Beach Shores'
        ,pInput = '74-17-D' => 'DeBary'
        ,pInput = '74-04-D' => 'DeLand'
        ,pInput = '74-07-B' => 'Deltona **'
        ,pInput = '74-05-D' => 'Edgewater'
        ,pInput = '74-06-D' => 'Holly Hill'
        ,pInput = '74-15-E' => 'Lake Helen'
        ,pInput = '74-09-E' => 'Orange City'
        ,pInput = '74- C'   => 'Ormond Beach'
        ,pInput = '74-12-F' => 'Ponce Inlet **'
        ,pInput = '74-11-C' => 'Port Orange'
        ,pInput = '74-13-D' => 'South Daytona'
        ,pInput = '74-98'   => 'Sea/Air Occurrence'
        ,pInput = '74-99'   => 'Balance of County'
				 ,pInput = '75-98'   => 'Sea/Air Occurrence'
        ,pInput = '75-99'   => 'Balance of County'
        ,pInput = '76-02-E' => 'DeFuniak Springs'
        ,pInput = '76-98'   => 'Sea/Air Occurrence'
        ,pInput = '76-99'   => 'Balance of County'
        ,pInput = '77-02-E' => 'Chipley'
        ,pInput = '77-98'   => 'Sea/Air Occurrence'
        ,pInput = '77-99'   => 'Balance of County'
        ,'');
