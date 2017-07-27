Import risk_indicators,riskwise,address,ut,std;
EXPORT Transforms_ConsumerShell := Module
	// add sequence to matchup later to add acctno to output
	Export RAMPS_Healthcare.Layout_ConsumerShell.Layout_ConsumerShell_Batch_In AddSeq(RAMPS_Healthcare.Layout_ConsumerShell.Layout_ConsumerShell_Batch_In le, integer C) := TRANSFORM
		self.acctno := map((integer)le.seq<>0 => (string)le.seq,
																(integer)le.acctno<>0 => (string)le.acctno,
																(string)c);
		self.seq := map((integer)le.seq<>0 => (integer)le.seq,
										(integer)le.acctno<>0 => (integer)le.acctno,
										C);
		self := le;
	END;
	Export risk_indicators.Layout_Input CleanBatch(RAMPS_Healthcare.Layout_ConsumerShell.Layout_ConsumerShell_Batch_In le) := TRANSFORM
		// clean up input
		dob_val := riskwise.cleandob(le.dob);
		self.historydate := 999999;
		self.seq := le.seq;	
		self.ssn := IF(le.ssn='000000000','',le.ssn);	// blank out social if it is all 0's
		self.dob := dob_val;
		self.age := if ((integer)dob_val != 0,(STRING3)ut.GetAgeI((integer)dob_val), '');
		
		self.phone10 := le.Home_Phone;
		self.wphone10 := le.Work_Phone;
		
		cleaned_name := address.CleanPerson73(le.UnParsedFullName);
		boolean valid_cleaned := le.UnParsedFullName <> '';
		
		self.fname := STD.Str.ToUpperCase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
		self.lname := STD.Str.ToUpperCase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
		self.mname := STD.Str.ToUpperCase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
		self.suffix := STD.Str.ToUpperCase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
		self.title := STD.Str.ToUpperCase(if(valid_cleaned, cleaned_name[1..5],''));

		street_address := le.street_addr;
		clean_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

		SELF.in_streetAddress := street_address;
		SELF.in_city := le.p_City_name;
		SELF.in_state := le.St;
		SELF.in_zipCode := le.Z5;
			
		self.prim_range := Address.CleanFields(clean_addr).prim_range;
		self.predir := Address.CleanFields(clean_addr).predir;
		self.prim_name := Address.CleanFields(clean_addr).prim_name;
		self.addr_suffix := Address.CleanFields(clean_addr).addr_suffix;
		self.postdir := Address.CleanFields(clean_addr).postdir;
		self.unit_desig := Address.CleanFields(clean_addr).unit_desig;
		self.sec_range := Address.CleanFields(clean_addr).sec_range;
		self.p_city_name := Address.CleanFields(clean_addr).p_city_name;
		self.st := Address.CleanFields(clean_addr).st;
		self.z5 := Address.CleanFields(clean_addr).zip;
		self.zip4 := Address.CleanFields(clean_addr).zip4;
		self.lat := Address.CleanFields(clean_addr).geo_lat;
		self.long := Address.CleanFields(clean_addr).geo_long;
		self.addr_type := Address.CleanFields(clean_addr).rec_type[1];
		self.addr_status := Address.CleanFields(clean_addr).err_stat;
		self.county := Address.CleanFields(clean_addr).county[3..5]; // we only want the county fips, not all 5.  first 2 are the state fips
		self.geo_blk := Address.CleanFields(clean_addr).geo_blk;
		self := [];
	END;
	Export RAMPS_Healthcare.Layout_ConsumerShell.layout_ConsumerShell_batch_flattened FlattenOutput(RAMPS_Healthcare.Layout_ConsumerShell.layout_ConsumerShell_combined le) := TRANSFORM
			self.acctno																	:= le.acctno;
			self.Lexid																	:= (string)le.did;
			self.v4_RelativesCount                      := le.version4.RelativesCount;
			self.v4_RelativesBankruptcyCount            := le.version4.RelativesBankruptcyCount;
			self.v4_RelativesFelonyCount                := le.version4.RelativesFelonyCount;
			self.v4_DerogSeverityIndex                  := le.version4.DerogSeverityIndex;
			self.v4_DerogCount                          := le.version4.DerogCount;
			self.v4_DerogAge                            := le.version4.DerogAge;
			self.v4_FelonyCount                         := le.version4.FelonyCount;
			self.v4_FelonyAge		                        := le.version4.FelonyAge;
			self.v4_FelonyCount01	                      := le.version4.FelonyCount01;
			self.v4_FelonyCount03                       := le.version4.FelonyCount03;
			self.v4_FelonyCount06                       := le.version4.FelonyCount06;
			self.v4_FelonyCount12                       := le.version4.FelonyCount12;
			self.v4_FelonyCount24                       := le.version4.FelonyCount24;
			self.v4_FelonyCount60                       := le.version4.FelonyCount60;
			self.v4_ArrestCount                         := le.version4.ArrestCount;
			self.v4_ArrestAge		                        := le.version4.ArrestAge;
			self.v4_ArrestCount01                       := le.version4.ArrestCount01;
			self.v4_ArrestCount03                       := le.version4.ArrestCount03;
			self.v4_ArrestCount06                       := le.version4.ArrestCount06;
			self.v4_ArrestCount12                       := le.version4.ArrestCount12;
			self.v4_ArrestCount24                       := le.version4.ArrestCount24;
			self.v4_ArrestCount60                       := le.version4.ArrestCount60;
			self.v4_BankruptcyCount                     := le.version4.BankruptcyCount;
			self.v4_BankruptcyAge                       := le.version4.BankruptcyAge;
			self.v4_BankruptcyType                      := le.version4.BankruptcyType;
			self.v4_BankruptcyStatus                    := le.version4.BankruptcyStatus;
			self.v4_BankruptcyCount01                   := le.version4.BankruptcyCount01;
			self.v4_BankruptcyCount03                   := le.version4.BankruptcyCount03;
			self.v4_BankruptcyCount06                   := le.version4.BankruptcyCount06;
			self.v4_BankruptcyCount12                   := le.version4.BankruptcyCount12;
			self.v4_BankruptcyCount24                   := le.version4.BankruptcyCount24;
			self.v4_BankruptcyCount60                   := le.version4.BankruptcyCount60;
			self:=[];
		END;
End;