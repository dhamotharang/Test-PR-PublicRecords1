#workunit('name','crs soapcall')
import doxie_cbrs,doxie,ut,watchdog;

myFile := dataset('~thor_data400::BASE::Watchdog_Best',watchdog.Layout_Best,thor);

run_number := 10000;
file_number := COUNT(myFile) DIV run_number;
random_number := RANDOM() % file_number + 1;

dids := // choosen(
				DISTRIBUTE(
					ENTH(
						myFile
					,1,file_number,random_number)
				,RANDOM() % 10);
				// ,run_number);

rec_in := record
	dids.did;
	unsigned2 DPPAPurpose := 1;
	unsigned2 GLBPurpose := 1;
end;

ut.MAC_Slim_Back(dids, rec_in, dids_ds)

o := output(dids_ds, NAMED('input_sample'), ALL);

rec_out := record
	unsigned6 did{XPATH('best_information_children/Row/did')};
	INTEGER code := 0;
	STRING message := '';
end;

rec_out ft(dids_ds inn) :=
TRANSFORM
	SELF.did := inn.did;
	SElF.code := IF(FAILCODE = 0, -1, FAILCODE);
	SELF.message := FAILMESSAGE;
END;

servicename := 'Doxie.Comprehensive_Report_Service';

fromsoap := soapcall(dids_ds, 
										'http://certstagingvip.hpcc.risk.regn.net:9876',
									  servicename, 
										{dids_ds},
									  dataset(rec_out), PARALLEL(1), onFail(ft(LEFT)),
										XPATH('Doxie.Comprehensive_Report_ServiceResponse/Results/Result/Dataset[1]/Row[1]'));
										
a := output(fromsoap(code <> 0), NAMED('Exceptions'), ALL);
b := output(fromsoap(code = 0 AND did <> 0), NAMED('Successes'), ALL);

j := JOIN(dids_ds,fromsoap,LEFT.did=RIGHT.did,TRANSFORM(rec_out,SELF:=LEFT,SELF:=RIGHT),LEFT ONLY);
c := output(j, NAMED('BlankBest'), ALL);

export Test_CRS := parallel(o,a,b,c);