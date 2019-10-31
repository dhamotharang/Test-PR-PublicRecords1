// file run through Neustar's phone verificaton process
import address, aid, nid, DID_Add, header_slimsort,  didville, data_services;
EXPORT File_NVerification := module

EXPORT Layout_in := RECORD
	STRING	field1; // unique identifier
	STRING	field2; // unique identifier
	STRING	field3; // source code: L9 = Link2Tek, 01, 02, 03 = Cellphone sources
	STRING	name_last_first;
	STRING	addressline1;
	STRING	addressline2;
	STRING	city;
	STRING	state;
	STRING	zip;
	STRING	phone;
	STRING	EID_1320_ResultCode;
	STRING	Prepaid_Phone_Attribute;
	STRING	Business_Phone_Indicator;
	STRING	Phone_In_Service_Indicator;
	STRING	Phone_Type_Indicator;
	STRING	EID_3261_ResultCode;
	STRING	EID_3261STRING;
END;

EXPORT Layout_Out := RECORD
	Layout_in;
	string file_dt;
	address.Layout_Clean_Name;
	unsigned8 nid;
	address.Layout_Clean182;
	AID.Common.xAID		RawAID;		
	AID.Common.xAID   ACEAID;
	unsigned did := 0;
	unsigned did_score := 0;
END;

EXPORT Input := project(DATASET(data_services.foreign_prod + 'thor_data400::in::cell_test_20140606_OUT',Layout_In,
										CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(100000))) (EID_3261STRING in ['2', '3', '4'] ),
										transform({Layout_in, string file_dt}, self.file_dt := '20140606', self := left));
										


//Clean name and addresses
NID.Mac_CleanFullNames(Input,cleanNames,name_last_first);
//clean address
cleanNames_t := project(cleanNames, transform({recordof(cleanNames), string orig_addr1, string orig_addr2, unsigned rawaid},
																		self.rawaid := 0,
																		self.orig_addr1 := trim(stringlib.stringfilterout(left.addressline1 + ' ' +  left.addressline2 ,'.^!$+<>@=%?*\''),left,right),			
																		self.orig_addr2 := trim(StringLib.StringCleanSpaces(
																					if(left.city <> '',left.city + ',','')
																					+ ' '+ left.state
																					+ ' '+ if(length(trim(left.zip[..5],all)) = 5,
																										left.zip[..5],''))
																										,left,right),
																		self := left));			
																					
EXPORT addr_prep := cleanNames_t;	
with_addresses := 		addr_prep(orig_addr1 <> '');															
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(with_addresses,orig_addr1,orig_addr2,RawAID,cleanAddr, lFlags);

Layout_Out tr(cleanAddr l) := TRANSFORM
	self.title := l.cln_title;
	self.fname := l.cln_fname;
	self.mname := l.cln_mname;
	self.lname := l.cln_lname;
	self.name_score := '0';
	self.name_suffix := l.cln_suffix;
	self.RawAID     := l.aidwork_rawaid;
	self.ACEAID			:= l.aidwork_acecache.aid;
	self.prim_range := stringlib.stringfilterout(l.aidwork_acecache.prim_range,'.');
	self.prim_name  := stringlib.stringfilterout(l.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
	self.sec_range  := stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
	self.v_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
	self.p_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
	self.zip        := l.aidwork_acecache.zip5;
	self.msa        := if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
	self            := l.aidwork_acecache;
	self            := l;
END;

cleanAdd_t := project(cleanAddr,tr(left)) + project(addr_prep(orig_addr1 = ''), transform(Layout_Out, self := []));
;

EXPORT Cleaned := cleanAdd_t ;

//DID
matchset := ['A','P','Z'];
  DID_Add.MAC_Match_Flex(Cleaned,matchset,foo,foo,
	  fname, mname,lname,name_suffix,
		prim_range, prim_name,sec_range,zip,
    st,phone,DID,
		layout_out,true,DID_Score,75,ind_with_did);
	 
EXPORT DIDED := ind_with_did :persist('~thor_data400::phonesplus::nverification');
end;