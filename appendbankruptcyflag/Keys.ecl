EXPORT Keys := MODULE
	SHARED prefix := '~';//'~foreign::10.241.3.238:7070::';
	BocashellBankruptcyFile := DATASET('', $.Layouts.BocashellBankruptcyLayout, THOR);

	EXPORT BocashellBankruptcyKey := INDEX(BocashellBankruptcyFile,{did},{BocashellBankruptcyFile},prefix + 'thor_data400::key::bankruptcyv3::bocashell_qa');
END;