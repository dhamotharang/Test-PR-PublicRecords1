
IMPORT NAC_V2, NAC, STD;


EXPORT fn_despray_dbc1 (DATASET(NAC.Layouts.Collisions) ds_NAC_collissions) := FUNCTION


 NAC.Layouts.DBC xformtoNAC1DBC(NAC.Layouts.Collisions  l) := TRANSFORM
    SELF.SequenceNumber := l.SearchSequenceNumber;
    SELF.LF := '\n';
		self := l;
END;


    despray_dbc_nac1_file := FUNCTION	 
        suffix := STD.Str.FindReplace(workunit[2..16], '-', '_');
        dbcFname := '~nac::v2::xx_dbc_' + suffix;
        dbc := PROJECT(ds_NAC_collissions , xformtoNAC1DBC(LEFT));
        writethorfile := OUTPUT(dbc, , dbcFname, COMPRESSED, OVERWRITE);
        desprayfilename:='XX_DBC_' + suffix;  
        destinationfolder := '/data/hds_180/nac/drupal/';             
        pDestinationFile := destinationfolder + trim(desprayfilename) + '.dat';          
        despray := FileServices.Despray(dbcFname, NAC_V2.Constants.LandingZoneServer, pDestinationFile,,,,TRUE);
        RETURN SEQUENTIAL(writethorfile, despray); 
    END;

    RETURN despray_dbc_nac1_file; 
END;



