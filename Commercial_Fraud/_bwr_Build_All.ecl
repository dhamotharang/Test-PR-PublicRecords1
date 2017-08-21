pversion 		:= '20100204'	;		// modify to current date
poverwrite	:= true				;
pDirectory	:= '';

#workunit('name', Commercial_Fraud._Dataset().Name + ' Build ' + pversion);

Commercial_Fraud.Build_all(pversion,poverwrite := poverwrite,pdirectory := pdirectory).all;