// #stored('did_add_force','thor');
import address, business_header_ss, business_header, did_add, standard;

export Proc_Build_Base(string8 filedate) := function

trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;  
		
ds1 := distribute(CourtLink.PreprocessInput,hash(filepos));

// a Reference child dataset layout having a linking-id in each record 
ReferenceChildRec := record,maxlength(10000)
        unsigned8 filepos; 
		string Reference;
		end;

// normalize transform...take the Reference child dataset & break into a flat file - assign a 'linking-id' to each record.
ReferenceChildRec NewReferenceChildren(GSA.Layouts_GSA.layout_Record l, GSA.Layouts_GSA.layout_Reference r) := transform
		 self.filepos := l.filepos;
		 self         := r;
		 end;

// call to normalize the Reference child dataset. left parameter is the parent record, right parameter is the Reference child dataset.
xNewReferenceChilds := normalize(ds1,left.References,NewReferenceChildren(left,right),local);

grpNewReferenceChilds := group(xNewReferenceChilds,filepos,all,local);
NewReferenceChilds := dedup(group(grpNewReferenceChilds,local),all,local);

s1 := sort(NewReferenceChilds,filepos,local);

// an Address child dataset layout having a linking-id in each record 
AddressChildRec := record,maxlength(10000)
        unsigned8 filepos; 
		string Street1;					
		string Street2;					
		string Street3;					
		string City;					
		string ZIP;						
		string Province;				
		string State;					
		string Country;					
		string DUNS;					
		end;
		
		
		
// normalize transform...take the Address child dataset & break into a flat file - assign a 'linking-id' to each record.		
AddressChildRec NewAddressChildren(GSA.Layouts_GSA.layout_Record l, GSA.Layouts_GSA.layout_Address r) := transform
		 self.filepos := l.filepos;
		 self         := r;
		 end;

// call to normalize the Address child dataset. left parameter is the parent record, right parameter is the Address child dataset.
NewAddressChilds := normalize(ds1,left.Addresses,NewAddressChildren(left,right),local);
grpNewAddressChilds := group(NewAddressChilds,filepos,all,local);
ddgrpNewAddressChilds := dedup(group(grpNewAddressChilds,local),all,local);

// an Action child dataset layout having a linking-id in each record 
ActionChildRec := record,maxlength(10000)
        unsigned8 filepos; 
		string ActionDate;				 
		string TermDate;					 
		string TermType;					 
		string CTCode;					 
		string AgencyComponent;			 
		string oldCTCode;				 
		string oldAgencyComponent;		 
		string ActionStatus;				 
		string EPLSCreateDate;			 
		string EPLSModDate;						
		end;

// normalize transform...take the Action child dataset & break into a flat file - assign a 'linking-id' to each record.
ActionChildRec NewActionChildren(GSA.Layouts_GSA.layout_Record l, GSA.Layouts_GSA.layout_Action r) := transform
		 self.filepos := l.filepos;
		 self         := r;
		 end;

// call to normalize the Action child dataset. left parameter is the parent record, right parameter is the Action child dataset.
NewActionChilds := normalize(ds1,left.Actions,NewActionChildren(left,right),local);

grpNewActionChilds := group(NewActionChilds,filepos,all,local);
ddGrpNewActionChilds := dedup(group(grpNewActionChilds,local),all,local);

// an AgencyIdentifier child dataset layout having a linking-id in each record 
AgencyIdentifierChildRec := record,maxlength(10000)
        unsigned8 filepos; 
		string dType;					 
		string dValue;						
		end;

// normalize transform...take the AgencyIdentifier child dataset & break into a flat file - assign a 'linking-id' to each record.
AgencyIdentifierChildRec NewAgencyIdentifierChildren(GSA.Layouts_GSA.layout_Record l, GSA.Layouts_GSA.layout_AgencyIdentifier r) := transform
		 self.filepos := l.filepos;
		 self         := r;
		 end;

// call to normalize the AgencyIdentifier child dataset. left parameter is the parent record, right parameter is the AgencyIdentifier child dataset.
NewAgencyIdentifierChilds := normalize(ds1,left.AgencyIdentifiers,NewAgencyIdentifierChildren(left,right),local);
grpNewAgencyIdentifierChilds := group(NewAgencyIdentifierChilds,filepos,all,local);
ddGrpNewAgencyIdentifierChilds := dedup(group(grpNewAgencyIdentifierChilds,local),all,local);

 slim_main_lo := record,maxlength(10000)
                unsigned8 filepos;
				string1 primary_aka_name;
				string Name;  							 
				string Classification;					         
				string CTType;							 				 
				string Description;				  	 				 
				end;
				
 main_addrs_lo := record,maxlength(10000)
				slim_main_lo;			
				string Street1;					
				string Street2;					
				string Street3;					
				string City;					
				string ZIP;						
				string Province;				
				string State;					
				string Country;					
				string DUNS;				
				end;
				
 main_addrs_agency_lo := record,maxlength(10000)
				main_addrs_lo;
				string dType;					 
				string dValue;
				end;
				
 main_addrs_agency_action_lo := record,maxlength(10000)
				main_addrs_agency_lo;												
				string ActionDate;				 
				string TermDate;
				string1 TermDateIndefinite;
				string1 TermDatePermanent;
				string TermType;					 
				string CTCode;					 
				string AgencyComponent;			 
				string oldCTCode;				 
				string oldAgencyComponent;		 
				string ActionStatus;				 
				string EPLSCreateDate;			 
				string EPLSModDate;		
				end;
				
 lo_with_bdid := record,maxlength(10000)
    integer8 uniqueID := 0;
	unsigned6 bdid := 0;
	unsigned6 did  := 0;
	main_addrs_agency_action_lo;
	end;
	
 slim_main_lo setMain(ds1 l) := transform
	self.primary_aka_name := 'P';
	self.name             := trimUpper(l.name);
	self                  := l;
	end;

//set the primary_aka_name field to 'P'rimary, to identify each original Name record
slim_main := project(ds1,setMain(left));   //distribution retained				

slim_main_lo joinRefs(slim_main l,NewReferenceChilds r) := transform,
		   skip(r.reference='')  
		   name1                 := trimUpper(regexreplace('^aka ',r.reference,'',nocase));
		   name2                 := regexreplace('\\(PRIMARY RECORD\\)',name1,'');
		   self.name             := name2;
		   self.primary_aka_name := if(regexfind('^aka ',r.reference,nocase),
									  'A',
									  'R');
		   self := l;
		   end;

slim_main_ref := join(slim_main,NewReferenceChilds,
					   left.filepos = right.filepos,
					   joinRefs(left,right),
					   left outer,local);

all_main_refs := sort(slim_main_ref + slim_main,filepos,primary_aka_name,local);
					  
main_addrs_lo joinAddrs(all_main_refs l,ddgrpNewAddressChilds r) := transform
           self := l;
		   self.State := if(r.State='XX',
		                    '',
							r.State);
		   self := r;
		   end;			
		   		   
main_addrs := join(all_main_refs,ddgrpNewAddressChilds,
					  left.filepos = right.filepos,
					  joinAddrs(left,right),
					  left outer,local);

main_addrs_agency_lo joinAgency(main_addrs l,ddGrpNewAgencyIdentifierChilds r) := transform
           self := l;
		   self := r;
		   end;			
		   
main_addrs_agency := join(main_addrs,ddGrpNewAgencyIdentifierChilds,
					  left.filepos = right.filepos,
					  joinAgency(left,right),
					  left outer,local);
					  
main_addrs_agency_action_lo joinAction(main_addrs_agency l,ddGrpNewActionChilds r) := transform
           self := l;
		   self.termDateIndefinite := if(regexfind('indef',r.termDate,NOCASE),'Y','');
		   self.termDatePermanent  := if(regexfind('perm',r.termDate,NOCASE),'Y','');
		   self.actionDate := GSA.dateDDMMMYYYY(r.actionDate);
		   self.termDate := GSA.dateDDMMMYYYY(r.termDate);
		   self.EPLSCreateDate := GSA.dateDDMMMYYYY(r.EPLSCreateDate);
		   self.EPLSModDate := GSA.dateDDMMMYYYY(r.EPLSModDate);
		   self := r;
		   end;			
		   
main_addrs_agency_action := join(main_addrs_agency,ddGrpNewActionChilds,
					  left.filepos = right.filepos,
					  joinAction(left,right),
					  left outer,local);
					  
ds := main_addrs_agency_action : persist('~thor_data400::persist::GSA::all_recs');			    			  			  

//Process the joined xml input

lo_with_bdid initBDID(ds l,unsigned8 cntr) := transform
	self.uniqueID   := cntr;
	self.name    := trimUpper(l.name);
	self.street1 := trimUpper(l.street1);
	self.street2 := trimUpper(l.street2);
	self.street3 := trimUpper(l.street3);
	self.city    := trimUpper(l.city);
	self.state   := trimUpper(l.state);
	self         := l;
	end;	
	
Layout_Clean182 := record
	string10        prim_range; 	// [1..10]
	string2         predir;		// [11..12]
	string28        prim_name;	// [13..40]
	string4         addr_suffix;  // [41..44]
	string2         postdir;		// [45..46]
	string10        unit_desig;	// [47..56]
	string8         sec_range;	// [57..64]
	string25        p_city_name;	// [65..89]
	string25        v_city_name;  // [90..114]
	string2         st;			// [115..116]
	string5         zip5;		// [117..121]
	string4         zip4;		// [122..125]
	string4         cart;		// [126..129]
	string1         cr_sort_sz;	// [130]
	string4         lot;		// [131..134]
	string1         lot_order;	// [135]
	string2         dbpc;		// [136..137]
	string1         chk_digit;	// [138]
	string2         rec_type;	// [139..140]
	string5         county;		// [141..145]
	string10        geo_lat;		// [146..155]
	string11        geo_long;	// [156..166]
	string4         msa;		// [167..170]
	string7         geo_blk;		// [171..177]
	string1         geo_match;	// [178]
	string4         err_stat;	// [179..182]
	end;

clean_gsa := record,maxlength(10000)
	integer8 uniqueID;
	string1 business_person := '';
	unsigned6 bdid := 0;
	unsigned6 did  := 0;
	string8   dt_last_seen;  //process date
	main_addrs_agency_action_lo;
	standard.Name;	
	Layout_Clean182;
	end;

slim_clean_gsa_bdid := record,maxlength(10000)
    lo_with_bdid.bdid;
	integer8 uniqueID;
	string Name;	
	standard.Addr.prim_range;
	standard.Addr.prim_name;
	standard.Addr.sec_range;
	standard.Addr.st;
	standard.Addr.zip5;	
	end;

slim_clean_gsa_did := record,maxlength(10000)
    lo_with_bdid.did;
	integer8 uniqueID;
	standard.Name.fname;
	standard.Name.mname;
	standard.Name.lname;
	standard.Name.name_suffix;	
	standard.Addr.prim_range;
	standard.Addr.prim_name;
	standard.Addr.sec_range;
	standard.Addr.st;
	standard.Addr.zip5;	
	end;
	
clean_gsa cleanRecs(ds L, unsigned8 cntr) := transform
    order := if(stringlib.stringfind(L.name,' ',1)=stringlib.stringfind(L.name,',',1)+1,
			'L',
            'F');
	cn := address.Clean_n_Validate_Name(L.name,order);	
	self.uniqueID  	  := cntr;
	self.business_person := if(cn.full_name='',
	                           'B',
							   'P');
	self.name         := trimUpper(l.name);
	self.title		  := cn.title;
	self.fname		  := cn.fname;
	self.mname		  := cn.mname;
	self.lname		  := cn.lname;
	self.name_suffix  := cn.name_suffix;
	self.name_score	  := cn.name_score;		
	self.street1      := trimUpper(l.street1);
	self.street2      := trimUpper(l.street2);
	self.street3      := trimUpper(l.street3);
	self.city         := trimUpper(l.city);
	self.state        := trimUpper(l.state);
	string address1   := l.Street1 + ' ' +
					     l.Street2 + ' ' +
				         l.Street3;
	string address2   := address.Addr2FromComponents(l.city,l.state,l.zip);
	string182 ca      := addrcleanlib.cleanaddress182(address1,address2);
	self.prim_range   := ca[1..10];
	self.predir       := ca[11..12];
	self.prim_name    := ca[13..40];
	self.addr_suffix  := ca[41..44];
	self.postdir      := ca[45..46];
	self.unit_desig   := ca[47..56];
	self.sec_range    := ca[57..64];
	self.p_city_name  := ca[65..89];
	self.v_city_name  := ca[90..114];
	self.st           := if(ca[115..116]='',						  
						    ziplib.ZipToState2(ca[117..121]),
						    ca[115..116]);
	self.zip5         := ca[117..121];
	self.zip4         := ca[122..125];
	self.cart         := ca[126..129];
	self.cr_sort_sz   := ca[130];
	self.lot          := ca[131..134];
	self.lot_order    := ca[135];
	self.dbpc         := ca[136..137];
	self.chk_digit    := ca[138];
	self.rec_type     := ca[139..140];
	self.county       := ca[141..145];
	self.geo_lat      := ca[146..155];
	self.geo_long     := ca[156..166];
	self.msa          := ca[167..170];
	self.geo_blk      := ca[171..177];
	self.geo_match    := ca[178];
	self.err_stat     := ca[179..182];
	self.dt_last_seen := filedate;
	self              := l;	
	self              := [];
	end;	

clean_recs := project(ds,cleanRecs(left,counter));
// count(clean_recs);
// output(choosen(clean_recs,200));

slim_business_recs := project(clean_recs(business_person='B'),slim_clean_gsa_bdid);

business_matchset := ['A','N'];

Business_Header_SS.MAC_Add_BDID_FLEX(
	slim_business_recs, 
	business_matchset,
	name, 
	prim_range, prim_name, zip5, 
	sec_range, st,
	'', '',
	bdid,	
	slim_clean_gsa_bdid,
	false, score_field,  //these should default to zero in definition
	bdidOut);
	
// count(slim_business_recs);
// bdidOut := slim_business_recs;
newBdid  := bdidOut;

output(choosen(newBdid,500));
count(newBdid);	
				
dist_clean_recs1 := distribute(clean_recs,hash(uniqueID));
dist_bdidOut := distribute(bdidOut,hash(uniqueID));	

clean_gsa joinBDID(clean_recs L,bdidOut R) := transform
		self.bdid := R.bdid;
		self := L;
		end;	

full_recs1 := join(dist_clean_recs1,dist_bdidOut,
                           left.uniqueID = right.uniqueID,
						   joinBDID(left,right),
						   left outer,local);
						   
output(choosen(full_recs1,200)); 

slim_person_recs := project(full_recs1(business_person='P'),slim_clean_gsa_did);						  

person_matchset := ['A'];
			
// did_Add.MAC_Match_Flex(
	// slim_person_recs, 
	// person_matchset,
	// '','', 
	// fname, mname, lname, name_suffix, 
	// prim_range, prim_name, sec_range, zip5, st, '',
	// did,
	// slim_clean_gsa_did, 
	// false, bdid_score,
	// 75,
	// didOut);
	
count(slim_person_recs);
didOut := slim_person_recs;
newDid := didOut;

output(choosen(newDid,500));
count(newDid);		

dist_clean_recs2 := distribute(full_recs1,hash(uniqueID));	
dist_didOut := distribute(didOut,hash(uniqueID));
		
clean_gsa joinDID(clean_recs L,didOut R) := transform
		self.did := R.did;
		self := L;
		end;		

full_recs2 := join(dist_clean_recs2,dist_didOut,
                           left.uniqueID = right.uniqueID,
						   joinDID(left,right),
						   left outer,local);

count(full_recs2);
output(choosen(full_recs2,200));	

all_recs := full_recs2 : persist('~thor_data400::persist::GSA::all_recs5');	
				   
				
return ds;
end;