Import History_Analysis,STD, dops, ut;


Export Validate_Deltas(string pVersion ) := Module


Shared validateQADeltasRec := RECORD
        String25 datasetname;
        String10 buildversion;
        String25 whenQAlive;
        String   superkey;
        Integer8 size;
        Integer8 recordcount;
        // String10 version_validation;
        // String10 size_validation;
        // String10 recordCount_validation;
        // String10 deltaSize_validation;
        // String10 deltaPerc_validation;
END;

    
Shared validateProdDeltasRec := RECORD
        String25 datasetname;
        String10 buildversion;
        String25 whenProdlive;
        String   superkey;
        Integer8 size;
        Integer8 recordcount;
        // String10 version_validation;
        // String10 size_validation;
        // String10 recordCount_validation;
        // String10 deltaSize_validation;
        // String10 deltaPerc_validation;
END;


todays_date := (string)Std.Date.today():global;

tommorrow := (string)Std.Date.AdjustDate((integer)todays_date,0,0,1):global;

ninedaysprior := (string)Std.Date.AdjustDate((integer)todays_date,0,0,-9):global;

eighteendaysprior := (string)Std.Date.AdjustDate((integer)todays_date,0,0,-18):global;

eightdaysprior := (string)Std.Date.AdjustDate((integer)todays_date,0,0,-8):global;


nonfcrainput1 := dops.GetHistoricalKeyInfo('*', 'B', 'N', ninedaysprior, tommorrow, 'prod' );
fcrainput1 :=  dops.GetHistoricalKeyInfo('*', 'B', 'F', ninedaysprior, tommorrow, 'prod' );

nonfcrainput2 := dops.GetHistoricalKeyInfo('*', 'B', 'N', eighteendaysprior, eightdaysprior, 'prod' );
fcrainput2 := dops.GetHistoricalKeyInfo('*', 'B', 'F', eighteendaysprior, eightdaysprior, 'prod' );

datasets1 := (nonfcrainput1 + fcrainput1 );
datasets2 := (nonfcrainput2 + fcrainput2);

Shared add_all := (datasets1 + datasets2);

fn_format_date (string date) := Function

	time:= date[12..19];
	hour := (unsigned4)date[12..13];
	formatted_hour := map(    
					hour = 24 => '12',
					hour = 23 => '11',
					hour = 22 => '10',
					hour = 21 => '9',
					hour = 20 => '8',
					hour = 19 => '7',
					hour = 18 => '6',
					hour = 17 => '5',
					hour = 16 => '4',
			        hour = 15 => '3', 
					hour = 14 => '2', 
					hour = 13 => '1', 
					hour < 13 => (string4) hour, '');
	AMPM := if( hour > 11, ' PM', ' AM');
	
	finalDate := date[6..7] + '/' + date[9..10]  + '/' + date[1..4] + ' ' + trim(formatted_hour) + ':' + date[15..16] + ':' + date[18..19] +  AMPM;

	filterFinal := if(date = 'NA', 'NA', finalDate);

	return filterFinal;
	
End;

Shared dsDopsServiceQA := project(add_all, transform(validateQADeltasRec,
                                self.datasetname := trim(left.datasetname,right, whitespace );
								self.buildversion := trim(left.buildversion, right, whitespace );
								self.whenQAlive := trim(left.whenQAlive, right, whitespace );
								self.superkey := trim(left.superkey, right, whitespace );
							    self.size := (integer)left.size;
                                self.recordcount := (integer)left.recordcount;
                                ));

Shared dsDopsServiceProd := project(add_all, transform(validateProdDeltasRec,
                                self.datasetname := trim(left.datasetname,right, whitespace );
								self.buildversion := trim(left.buildversion, right, whitespace );
								self.whenProdlive := trim(left.whenProdlive, right, whitespace );
								self.superkey := trim(left.superkey, right, whitespace );
							    self.size := (integer)left.size;
                                self.recordcount := (integer)left.recordcount;
                                ));

			

Export sortedDsQA := sort(dsDopsServiceQA(datasetname<>'',whenQAlive<>'NA',whenQAlive<>''), datasetname, -buildversion );

Export sortedDsProd := sort(dsDopsServiceProd(datasetname<>'',whenProdlive<>'NA',whenProdlive<>''), datasetname, -buildversion );





deltasQA := History_Analysis.Files(pVersion).counted_deltasQA;
deltasProd := History_Analysis.Files(pVersion).counted_deltasProd;

dsCertDeltas := sort(project(deltasQA, transform(validateQADeltasRec, self:=left )), datasetname, -buildversion );
dsProdDeltas := sort(project(deltasProd, transform(validateProdDeltasRec, self:=left )), datasetname, -buildversion );








// cross validate raw data and deltas 

// process 

// compare records in one dataset to check if records exist in main dataset

// output results


End;