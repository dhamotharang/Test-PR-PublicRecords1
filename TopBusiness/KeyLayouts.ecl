export KeyLayouts := module

	export Abstract := record
		Layout_Abstract.Linked - [source_docid,source_party];
		string1 source_docid_1;
	end;

	export AddressesPhones := record
		Layout_Linking.Linked.bid;
		Layout_Linking.Linked.source;
		string1 source_docid_1;
		Layout_Linking.Linked.date_first_seen;
		Layout_Linking.Linked.date_last_seen;
		Layout_Linking.Linked.address_type;
		Layout_Linking.Linked.prim_range;
		Layout_Linking.Linked.predir;
		Layout_Linking.Linked.prim_name;
		Layout_Linking.Linked.addr_suffix;
		Layout_Linking.Linked.postdir;
		Layout_Linking.Linked.unit_desig;
		Layout_Linking.Linked.sec_range;
		Layout_Linking.Linked.city_name;
		Layout_Linking.Linked.state;
		Layout_Linking.Linked.zip;
		Layout_Linking.Linked.county_name;
		Layout_Linking.Linked.msa;
		Layout_Linking.Linked.phone_type;
		Layout_Linking.Linked.phone;
	end;
	
	export Aircraft := module
	
		export Main := record
			Layout_Aircraft.Main.Linked - [source_docid];
			unsigned4 date_9999;
			string1 source_docid_1;
		end;
		
		export Party := Layout_Aircraft.Party;

  end;				
	
	export Bankruptcy := module
		
		export Main := record
			Layout_Bankruptcy.Main.Linked - [source_docid,source_party];
			string1 party_type;
			unsigned4 date_filed_9999;
			string1 source_docid_1;
		end;
		
		export Party := Layout_Bankruptcy.Party;
	
	end;
	
	export Contacts := record	    
		Layout_Contacts.Linked - [brid,blid,source_docid,source_party];
		boolean IsExecutive;
		boolean IsCurrent;     		 
		string1 source_docid_1;
  end;					 
	
	export Finance := record
		Layout_Finance.Linked - [source_docid,source_party];
		string1 source_docid_1;
	end;
	
	export Foreclosure := module
	   export Main := record
		   layout_Foreclosure.main.Linked;
			 string1 source_docid_1;
		 end;
     export Party := record
		   layout_Foreclosure.Party.Linked;
		 end;
  end;		 
	
	export Incorporation := record
		Layout_Incorporation.Linked - [source_docid,source_party];
		string1 source_docid_1;
	end;

	export Industry := record
		Layout_Industry.Linked - [source_docid,source_party];
		string1 source_docid_1;
	end;

	export License := record
		Layout_License.Linked - [source_docid,source_party];
		string1 source_docid_1;
	end;
	
	export Liens := module
		
		export Main := record
			Layout_Liens.Main.Linked - [source_party];
			string1 status_code;
      unsigned4 orig_filing_date_9999;
			string1 party_type;
			string1 source_docid_1;
		end;
		
		export Party := Layout_Liens.Party;
	
	end;
	
	export LinkDiagnostic := Layout_Linking.Linked;

	export LLID := record
		Layout_LLID.Linked.bid;
		Layout_LLID.Linked.brid;
		Layout_LLID.Linked.blid;
		Layout_LLID.Linked.llid12;
		Layout_LLID.Linked.llid9;
	end;
	
	export MatchDiagnostic := record
		unsigned6 beid1;
		unsigned6 beid2;
		unsigned4 matchcode;
	end;
	
	export MotorVehicle := module
	
		export Main := record
			Layout_MotorVehicle.Main.Linked;
			string1 source_docid_1;
		end;
		
		export Registration := record
			Layout_MotorVehicle.Registration;
			unsigned4 date_9999;
		end;

		export Title       := record
			Layout_MotorVehicle.Title;
			unsigned4 date_9999;
		end;
	
		export Party := record
		  Layout_MotorVehicle.Party;
		end;

  end;				

	export NamesFEINs := record
		Layout_Linking.Linked.bid;
		Layout_Linking.Linked.source;
		string1 source_docid_1;
		Layout_Linking.Linked.date_first_seen;
		Layout_Linking.Linked.date_last_seen;
		Layout_Linking.Linked.company_name_type;
		Layout_Linking.Linked.company_name;
		Layout_Linking.Linked.fein;
	end;
	
	export Property := module
		
		export Main := record
			Layout_Property.Main.Linked - [source_docid,source_party]; //- [source_party];	
			string1 party_type;
			unsigned4 date_9999;
			string1 source_docid_1;
		end;				
		export Party      := record
			Layout_Property.Party.Linked - [source_docid,source_party];
		end;
		
		export Assessment := record
			Layout_Property.Assessment.Linked;
			unsigned4 date_9999;
		end;

		export Deed       := record
			Layout_Property.Deed.Linked;
			unsigned4 date_9999;
		end;
	
		export Foreclosure       := record
			Layout_Property.Foreclosure.Linked;
		end;
	
	end;
	
	export Relationship := record
		unsigned6 bid;
		unsigned6 other_bid;
		string25 role;
		string25 other_role;
		string2 source;
		string1 source_docid_1;
		string2 other_source;
		string1 other_source_docid_1;
	end;
	
	export Source := record
		unsigned6 bid;
		unsigned2 item_type;
		unsigned4 item_hash;
		string2 source;
		string50 source_docid;
	end;
	
	export TradeLines := record
		Layout_TradeLines.Linked - [source_docid,source_party];
		string1 source_docid_1;
	end;
	
	export UCC := module
		
		export Main := record
			Layout_UCC.Main.Linked - [source_docid,source_party];
			string1 party_type;
			unsigned4 orig_filing_date_9999;
			string1 source_docid_1;
		end;
		
		export Party := Layout_UCC.Party;
		export Collateral := Layout_UCC.Collateral;
	
	end;
	
	export URLs := record
		Layout_URLs.Linked - [source_docid,source_party];
		string1 source_docid_1;
	end;

	export Watercraft := module
		
		export Main := record
			Layout_Watercraft.Main.Linked - [source_docid,source_party];
		  string1   current_prior;
      unsigned4 regist_date_9999;
			string1   party_type;
			string1   source_docid_1;
		end;
		
		export Party := record
		  Layout_Watercraft.Party;
		  string1  current_prior;
		end;
	end;
	
end;
