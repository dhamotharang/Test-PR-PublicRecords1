import _Control, Data_Services;

EXPORT Constants := MODULE

	shared prefix := IF(_Control.ThisEnvironment.Name='Dataland', Data_Services.foreign_prod,'~');
	//shared prefix := '~';
	export sfCorteraHdr := prefix + 'thor::cortera::header';
	export sfAttributes := prefix + 'thor::cortera::attributes';
	export sfExecutives := prefix + 'thor::cortera::executives';
	export sfLinking := prefix + 'thor::cortera::linking';
	export sfIndustry := prefix + 'thor::cortera::industry';
	export sfHeaderIn := prefix + 'thor::cortera::hdr_in';
	export sfAttributesIn := prefix + 'thor::cortera::attr_in';


END;