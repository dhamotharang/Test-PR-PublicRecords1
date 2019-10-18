IMPORT PRTE2_Bankruptcy, BankruptcyV2, standard, ut, doxie;

EXPORT Files := MODULE

	//Base Input files
	EXPORT main_in			:= DATASET(Constants.IN_PREFIX + 'main', PRTE2_Bankruptcy.Layouts.Main, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT comments_in	:= DATASET(Constants.IN_PREFIX + 'comments', PRTE2_Bankruptcy.Layouts.Comments, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT status_in		:= DATASET(Constants.IN_PREFIX + 'status', PRTE2_Bankruptcy.Layouts.Status, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT search_in		:= DATASET(Constants.IN_PREFIX + 'search', PRTE2_Bankruptcy.Layouts.Search, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

	//Base Output files
	EXPORT Main_Base_ext		:= DATASET(Constants.BASE_PREFIX + 'main', PRTE2_Bankruptcy.Layouts.Main_BaseV3_ext, THOR); //Includes fields added by DI
	EXPORT Main_Base				:= PROJECT(Main_Base_ext, PRTE2_Bankruptcy.Layouts.Main_BaseV3);
	EXPORT Main_Base_supp		:= PROJECT(Main_Base_ext, PRTE2_Bankruptcy.Layouts.Main_BaseV3_supp);
	EXPORT Search_Base_ext	:= DATASET(Constants.BASE_PREFIX + 'search', PRTE2_Bankruptcy.Layouts.Search_Base_ext, THOR); //Includes fields added by DI
	EXPORT Search_Base			:= PROJECT(Search_Base_ext, PRTE2_Bankruptcy.Layouts.Search_Base);
  EXPORT Withdrawal_Base 	:= DATASET([],	Layouts.WithdrawnStatus_Base);
	
	//Main Base in V2 Layout
	Layouts.Main_BaseV2 xformV2(Main_Base l, Search_Base r) := transform
		self.chapter	:= r.chapter;
		self.orig_filing_type	:= r.filing_type;
		self.corp_flag := r.corp_flag;
		self.disposed_date := r.date_last_seen;
		self.disposition := r.disposition;
		self.pro_se_ind := r.pro_se_ind;
		self.record_type	:= r.record_type;
		self.converted_date	:= r.converted_date;
		self := l;
	end;
	
	EXPORT Main_BaseV2		:= 	JOIN(Main_Base, Search_Base, left.tmsid = right.tmsid, xformV2(left,right),left outer);
	
	//Autokey file
	EXPORT Bankruptcy_file_autokey := function

	rec := record
		Search_Base.name_type;
		unsigned4 party_bits := 0;
		Search_Base.cname;
		Search_Base.tmsid;
		string9 ssn;
		string9 tax_id;
		standard.Addr addr;
		standard.name name;
		unsigned1 zero := 0;
		unsigned6 intdid;
		unsigned6 intbdid;
	end;	

	rec tra(Search_Base l) := transform
		self.party_bits := (unsigned4) ut.bit_set(0,doxie.lookup_bit( 'PARTY_'+l.name_type ));
		self.addr.zip5 := l.zip;
		self.addr := l;
		self.addr := [];
		self.name := l;
		self.intdid := (unsigned6) l.did; 
		self.intbdid := (unsigned6) l.bdid ; 
		self.ssn := if((unsigned6)L.ssn <> 0,  L.ssn, L.app_ssn);
		self.tax_id := if((unsigned6)L.tax_id <> 0,  L.tax_id, L.app_tax_id);
		self := l;
	end;

	d2 := dedup(sort(distribute(project(Search_Base, tra(left)), hash(tmsid)),record,local),record,local);

	c := d2(cname <> '') ;
	p := d2(cname = '') ;

	dwr := record
		d2.name_type;
		d2.party_bits;
		d2.zero;
		d2.tmsid;
		d2.intDID;
		d2.intBDID;
		d2.cname;
		d2.ssn;
		d2.tax_id;
		standard.Addr company_addr;
		standard.Addr person_addr;
		standard.Name person_name;
	end;

	dwr mdw(p l, c r) := transform
		self.intDID := l.intDID;
		self.intBDID := r.intBDID;
		self.cname := r.cname;
		self.tax_id := r.tax_id;
		self.company_addr := r.addr;
		self.person_addr := l.addr;
		self.person_name := l.name;
		self.ssn := l.ssn;
		self := if(l.tmsid = '', r, l);
	end;


	b := join(p,c,left.tmsid = right.tmsid and 
			  left.name_type = right.name_type, 
			  mdw(left, right), 
			  full outer, local);


	RETURN dedup(sort(b, record, local), record, local);
END;
	
END;