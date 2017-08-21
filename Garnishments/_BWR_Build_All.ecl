pversion 					:= '20100901'														;		// modify to current date
pFilenamePattern 	:= '^.*in::liensv2::.*::hgn::okclien$'	;

#workunit('name', Garnishments._Dataset().Name + ' Build ' + pversion);
Garnishments.Build_All(
	 pversion
	,pFilenamePattern
);