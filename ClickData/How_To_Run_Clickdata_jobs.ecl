
//original definition


export Mac_Spray_And_Process(srcIP,		/* IP of the node where the file to be processed is located usually tapeload02(10.121.145.44)*/
														inpath,		/* path to the input file i.e. 'd:\\clickdata\\20051005\\cd10016.csv' */
														dstIP,		/* IP of the landingzone (where you are despraying the file to) usually tapeload02 (10.121.145.44)*/
														outpath,	/* path to the output file i.e. 'd:\\clickdata\\20051005\\cd10016_output.csv' */ 
														appends = 'false', /*If set to true appends best name and best address */
														bestphone = 'false')/* If set to true, appends best phone */                     


//1.-product in xml= <product>Interim ADL BN/BA Append</product> 
//definition::Derive ADL, and append Best Name, Best Address


clickdata.Mac_Spray_And_Process('10.121.145.44','d:\\clickdata\\20051005\\cd10016.csv','10.121.145.44','d:\\clickdata\\20051005\\cd10016_output.csv',true,false);
                         
//2.-product in xml= <product>Interim ADL BN/BA/BP Append</product>
//definition::Derive ADL, and append Best Name, Best Address, Best Phone


clickdata.Mac_Spray_And_Process('10.121.145.44','d:\\clickdata\\20051005\\cd10016.csv','10.121.145.44','d:\\clickdata\\20051005\\cd10016_output.csv',true,true);

//3.-product in xml= <product>ADL BN/BA Score</product>

clickdata.Mac_Spray_And_Process('10.121.145.44','d:\\clickdata\\20051005\\cd10016.csv','10.121.145.44','d:\\clickdata\\20051005\\cd10016_output.csv',false,false);


//4.-product in xml= <product>ADL BN/BA/BP Score</product>

clickdata.Mac_Spray_And_Process('10.121.145.44','d:\\clickdata\\20051005\\cd10016.csv','10.121.145.44','d:\\clickdata\\20051005\\cd10016_output.csv',false,false);


//definition for relatives
export Mac_Spray_And_Process_RR(srcIP,
															inpath, 
															dstIP, 
															outpath, 
															appends = 'false') 
															

//1.-product in xml= <product>ADL ADL RR </product>

clickdata.Mac_Spray_And_Process_RR('10.121.145.44','d:\\clickdata\\20051005\\cd10016.csv','10.121.145.44','d:\\clickdata\\20051005\\cd10016_output.csv',false);

//2.-product in xml= <product>Interim ADL ADL RR/BN/BA Append</product>

clickdata.Mac_Spray_And_Process_RR('10.121.145.44','d:\\clickdata\\20051005\\cd10016.csv','10.121.145.44','d:\\clickdata\\20051005\\cd10016_output.csv',true);

//3.-product in xml= <product>ADL RR</product>

clickdata.Mac_Spray_And_Process_RR('10.121.145.44','d:\\clickdata\\20051005\\cd10016.csv','10.121.145.44','d:\\clickdata\\20051005\\cd10016_output.csv',false);
