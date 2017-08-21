IMPORT PRTE2_DNB_FEIN, DNB_FEINV2, Experian_FEIN;

EXPORT Files := MODULE

	EXPORT Main_in	:= DATASET('~prte::in::dnbfein::main', Layouts.Main_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	
	EXPORT Main_di_ref := DATASET('~prte::base::dnbfein::main', Layouts.DNB_Main_di_ref, THOR);
	
	EXPORT DNB_base	:= PROJECT(Main_di_ref, TRANSFORM(DNB_FEINV2.layout_DNB_fein_base_main, SELF := LEFT));
	
	EXPORT Experian_di_ref	:= DATASET('~prte::base::experian_fein::data', Layouts.Experian_Main_di_ref, THOR);
	
	EXPORT Experian_base := PROJECT(Experian_di_ref, TRANSFORM(Experian_FEIN.Layouts.base, SELF := LEFT; SELF := []));
	
	//Autokey file transformation
	Layouts.ak_rec tra(DNB_base l) := TRANSFORM
    self.company_addr.st := l.st;
		self.company_addr.zip5 := l.zip ; 
		self.company_addr.addr_rec_type := l.rec_type ;  
		self.company_addr.fips_state := l.county[1..2] ;
		self.company_addr.fips_county := l.county[3..5]; 
		self.company_addr := l;
		self.company_addr := [];
		self.intbdid := (unsigned6)l.bdid;
		self := l;
	END;

	EXPORT SearchAutokey	:= project(DNB_base, tra(left));
	
END;