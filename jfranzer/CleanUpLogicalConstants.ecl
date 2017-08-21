EXPORT CleanUpLogicalConstants(string lClusterFilter='thor400_30') := module
export thor_30_capacity:= 656514200000000;
export thor_20_capacity:=  644809200000000;
export thor_92_capacity:=  912596000000;

export dname_prod:=dataset([
{'jfranzer_prod','Julianne.Franzer@lexisnexis.com'}
],{string30 owner,string75 email});

export dname_dataland:=dataset([
{'jfranzer','Julianne.Franzer@lexisnexis.com'}
],{string30 owner,string75 email});

export subj
		:=    lClusterFilter+' is low in Space'
			;

export p1
		:=   '\nYou are receiving this email because your ECL id is associated with\n'
					+'the files below and '+lClusterFilter+' cluster is low in space.\n'
					+'\nThese are orphan files that are over 75 days old, please, delete or move as many as possible.\n'
					+'\nAll combined they are using '
					;

export p2
		:=   '\nTo assist you with this task, the command to permanently delete\n'
					+'the files has already been written for you.\n'
					+'\nHowever, you must go throught the list carefuly to verify these may be deletd.\n'
					+'\nOnce the command line has been appropriately edited to prevent the deletion of those\n'
					+'files you do not yet want to delete, the command may be excecuted in HTHOR from an IDE window\n'
					+'\nThank you in advance for your prompt attention.\n'
					+'\n'
					;

end;