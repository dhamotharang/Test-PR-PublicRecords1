
export RoxieEnv := MODULE

	export QA := 'QA';
	export Prod := 'Prod';
	export Demo := '';
	export Test := 'Test';
	export certvip := 'http://roxiestaging.br.seisint.com:9876';
	export prodvip := 'http://roxiebatch.br.seisint.com:9856';
	export boca_certvip := 'roxiestaging.br.seisint.com:9876';
	export boca_prodvip := 'roxiebatch.br.seisint.com:9856';
	export prodbipvip := 'http://biproxievip.sc.seisint.com:9876';
	export certbipvip := 'http://certbiproxievip.sc.seisint.com:9876';
	export certprctvip := 'http://demoroxiecertvip.sc.seisint.com:9876';
	export prodprctvip := 'http://demoroxievip.sc.seisint.com:9876';

	export prod_batch_neutral := 'http://roxiebatch.br.seisint.com:9856';
	export prod_batch_fcra := 'http://fcrabatch.sc.seisint.com:9876';

	export DR_prod_neutral_roxieIP := 'http://oroxievip.sc.seisint.com:9876';
	export DR_prod_fcra_roxieIP := 'http://ofcraroxievip.sc.seisint.com:9876';

	export staging_neutral_roxieIP := 'http://roxiestaging.br.seisint.com:9876'; 
	export staging_fcra_roxieIP :='http://certfcraroxievip.sc.seisint.com:9876'; 

END;