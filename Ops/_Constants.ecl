EXPORT _Constants(string lClusterFilter='thor400_30') := module
export thor_30_capacity:= 656514200000000;
export thor_20_capacity:=  644809200000000;
export thor_92_capacity:=  912596000000;
export dname:=dataset([
{'aherzberg','angela.herzberg@lexisnexis.com'}
,{'aherzberg_prod','angela.herzberg@lexisnexis.com'}
,{'akayttala','ayeesha.kayttala@lexisnexis.com'}
,{'akayttala_prod','ayeesha.kayttala@lexisnexis.com'}
,{'ametzmaier','albert.metzmaier@lexisnexis.com'}
,{'ametzmaier_prod','albert.metzmaier@lexisnexis.com'}
,{'ananth','anantha.venkatachalam@lexisnexis.com'}
,{'ananth_prod','anantha.venkatachalam@lexisnexis.com'}
,{'jhuang','zaimingjenny.huang@lexisnexis.com'}
,{'jhuang_prod','zaimingjenny.huang@lexisnexis.com'}
,{'cbrodeur_prod','christopher.brodeur@lexisnexis.com'}
,{'cbrodeur','christopher.brodeur@lexisnexis.com'}
,{'csalvo','charles.salvo@lexisnexis.com'}
,{'csalvo_prod','charles.salvo@lexisnexis.com'}
,{'cguyton','zaimingjenny.huang@lexisnexis.com,wenhong.ma@lexisnexis.com,john.freibaum@lexisnexis.com'}
,{'cguyton_prod','zaimingjenny.huang@lexisnexis.com,wenhong.ma@lexisnexis.com,john.freibaum@lexisnexis.com'}
,{'cmorton2','charles.morton@lexisnexis.com'}
,{'cmorton2_prod','charles.morton@lexisnexis.com'}
,{'cpettola','charles.pettola@lexisnexis.com'}
,{'cpettola_prod','charles.pettola@lexisnexis.com'}
,{'ctio','cathy.tio@lexisnexis.com'}
,{'ctio_prod','cathy.tio@lexisnexis.com'}
,{'dknowles','darren.knowles@lexisnexis.com'}
,{'dknowles_prod','darren.knowles@lexisnexis.com'}
,{'grajulapalli','giri.rajulapalli@lexisnexis.com'}
,{'grajulapalli_prod','giri.rajulapalli@lexisnexis.com'}
,{'gwitz','gavin.witz@lexisnexis.com'}
,{'gwitz_prod','gavin.witz@lexisnexis.com'}
,{'jbello','jose.bello@lexisnexis.com'}
,{'jbello_prod','jose.bello@lexisnexis.com'}
,{'jfranzer','julianne.franzer@lexisnexis.com'}
,{'jfranzer_prod','julianne.franzer@lexisnexis.com'}
,{'jfreibaum','john.freibaum@lexisnexis.com'}
,{'jfreibaum_prod','john.freibaum@lexisnexis.com'}
,{'jhabbu','jaideep.habbu@lexisnexis.com'}
,{'jhabbu_prod','jaideep.habbu@lexisnexis.com'}
,{'jhennigar','jennifer.hennigar@lexisnexis.com'}
,{'jhennigar_prod','jennifer.hennigar@lexisnexis.com'}
,{'jshaw','jesse.shaw@lexisnexis.com'}
,{'jshaw_prod','jesse.shaw@lexisnexis.com'}
,{'jtrost','jason.trost@lexisnexis.com'}
,{'jtrost_prod','jason.trost@lexisnexis.com'}
,{'jtrost2_prod','jose.bello@lexisnexis.com'}
,{'kreeder','kevin.reeder@lexisnexis.com'}
,{'kreddy','kevin.reddy@lexisnexis.com'}
,{'kreddy_prod','kevin.reddy@lexisnexis.com'}
,{'kreeder_prod','kevin.reeder@lexisnexis.com'}
,{'lbentley','laverne.bentley@lexisnexis.com'}
,{'lbentley_prod','laverne.bentley@lexisnexis.com'}
,{'mgould','michael.gould@lexisnexis.com'}
,{'mgould_prod','michael.gould@lexisnexis.com'}
,{'mjackson','melanie.jackson@lexisnexis.com'}
,{'mjackson_prod','melanie.jackson@lexisnexis.com'}
,{'mlakdawala','mustafa.lakdawala@lexisnexis.com'}
,{'mlakdawala_prod','mustafa.lakdawala@lexisnexis.com'}
,{'rreyes','randy.reyes@lexisnexis.com'}
,{'rreyes_prod','randy.reyes@lexisnexis.com'}
,{'skasavajjala','sudhir.kasavajjala@lexisnexis.com'}
,{'skasavajjala_prod','sudhir.kasavajjala@lexisnexis.com'}
,{'smyana','saritha.myana@lexisnexis.com'}
,{'smyana_prod','saritha.myana@lexisnexis.com'}
,{'speriasamy','senthilkumar.periasamy@lexisnexis.com'}
,{'speriasamy_prod','senthilkumar.periasamy@lexisnexis.com'}
,{'tedman','tamika.edman@lexisnexis.com'}
,{'tedman_prod','tamika.edman@lexisnexis.com'}
,{'tgeorge','terri.hardy-george@lexisnexis.com'}
,{'tgeorge_prod','terri.hardy-george@lexisnexis.com'}
,{'tkirk','tony.kirk@lexisnexis.com'}
,{'tkirk_prod','tony.kirk@lexisnexis.com'}
,{'tleonard','todd.leonard@lexisnexis.com'}
,{'tleonard_prod','todd.leonard@lexisnexis.com'}
,{'upamarthy','uma.pamarthy@lexisnexis.com'}
,{'upamarthy_prod','uma.pamarthy@lexisnexis.com'}
,{'vchikte','vani.chikte@lexisnexis.com'}
,{'vchikte_prod','vani.chikte@lexisnexis.com'}
,{'wma','wenhong.ma@lexisnexis.com'}
,{'wma_prod','wenhong.ma@lexisnexis.com'}
,{'sbutler','sandy.butler@lexisnexis.com'}
,{'sbutler_prod','sandy.butler@lexisnexis.com'}
,{'ndobmeier','nicole.dobmeier@lexisnexis.com'}
,{'ndobmeier_prod','nicole.dobmeier@lexisnexis.com'}
,{'gmarcan','gabriel.marcan@lexisnexis.com'}
,{'gmarcan_prod','gabriel.marcan@lexisnexis.com'}
,{'alima','aleida.lima@lexisnexis.com'}
,{'alima_prod','aleida.lima@lexisnexis.com'}
,{'dpearson','dan.pearson@lexisnexis.com'}
,{'dpearson_prod','dan.pearson@lexisnexis.com'}
,{'bpahl','brenton.pahl@lexisnexis.com'}
,{'bpahl_prod','brenton.pahl@lexisnexis.com'}
,{'amireles','audra.mireles@lexisnexis.com'}
,{'amireles_prod','audra.mireles@lexisnexis.com'}
,{'kgarrity','kevin.garrity@lexisnexis.com'}
,{'kgarrity_prod','kevin.garrity@lexisnexis.com'}

],{string30 owner,string75 email});

export ccList:=
								',jose.bello@lexisnexis.com'
							+',valerie.minnis@lexisnexis.com'
							;

export subj
		:=    lClusterFilter+' is low in Space'
			;

export p1
		:=   '\nYou are receiving this email because your ECL id is associated with\n'
					+'the files below and '+lClusterFilter+' cluster is low in space.\n'
					+'\nThese are orphan files that are over 75 days old, please, deleted or move as many as possible.\n'
					+'\nAll combined they are using '
					;

export p2
		:=   '\nTo assist you with this task, the command to permanently delete\n'
					+'the files was prepared for you below.\n'
					+'\nHowever, you must go through the list carefully to verify these may be deleted.\n'
					+'\nOnce the command line has been appropriately edited to prevent the deletion of those\n'
					+'files you do not yet want to delete, the command may be executed in HTHOR from an IDE window\n'
					+'\nThank you in advance for your prompt attention.\n'
					+'\n'
					;

end;