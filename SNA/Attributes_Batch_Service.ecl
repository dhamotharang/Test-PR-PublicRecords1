/*--SOAP--
<message name="SNA Attributes Batch Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
</message>
*/
/*--INFO-- SNA Attributes batch service */
/*--HELP-- 
<pre>&lt;Dataset&gt;
   &lt;Row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;

      &lt;did1&gt;&lt;/did1&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;Prim_Range&gt;&lt;/Prim_Range&gt;
      &lt;Predir&gt;&lt;/Predir&gt;
      &lt;Prim_Name&gt;&lt;/Prim_Name&gt;
      &lt;Suffix&gt;&lt;/Suffix&gt;
      &lt;Postdir&gt;&lt;/Postdir&gt;
      &lt;Unit_Desig&gt;&lt;/Unit_Desig&gt;
      &lt;Sec_Range&gt;&lt;/Sec_Range&gt;
      &lt;p_City_name&gt;&lt;/p_City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
      &lt;Home_Phone&gt;&lt;/Home_Phone&gt;

      &lt;did2&gt;&lt;/did2&gt;
      &lt;SSN2&gt;&lt;/SSN2&gt;
      &lt;unParsedFullName2&gt;&lt;/unParsedFullName2&gt;
      &lt;Name_First2&gt;&lt;/Name_First2&gt;
      &lt;Name_Middle2&gt;&lt;/Name_Middle2&gt;
      &lt;Name_Last2&gt;&lt;/Name_Last2&gt;
      &lt;Name_Suffix2&gt;&lt;/Name_Suffix2&gt;
      &lt;DOB2&gt;&lt;/DOB2&gt;
      &lt;street_addr2&gt;&lt;/street_addr2&gt;
      &lt;Prim_Range2&gt;&lt;/Prim_Range2&gt;
      &lt;Predir2&gt;&lt;/Predir2&gt;
      &lt;Prim_Name2&gt;&lt;/Prim_Name2&gt;
      &lt;Suffix2&gt;&lt;/Suffix2&gt;
      &lt;Postdir2&gt;&lt;/Postdir2&gt;
      &lt;Unit_Desig2&gt;&lt;/Unit_Desig2&gt;
      &lt;Sec_Range2&gt;&lt;/Sec_Range2&gt;
      &lt;p_City_name2&gt;&lt;/p_City_name2&gt;
      &lt;St2&gt;&lt;/St2&gt;
      &lt;Z52&gt;&lt;/Z52&gt;
      &lt;Home_Phone2&gt;&lt;/Home_Phone2&gt;

      &lt;HistoryDateYYYYMM&gt;&lt;/HistoryDateYYYYMM&gt;
   &lt;/Row&gt;
&lt;/Dataset&gt;
</pre>
*/

import address, risk_indicators, SNA, AutoStandardI, Doxie, Didville, STD;


EXPORT Attributes_Batch_Service := MACRO

  layout_in := record
    unsigned4 seq;
    STRING30  acctno;

    unsigned  did1;
    STRING9   SSN;
    STRING120 unParsedFullName;
    STRING30  Name_First;
    STRING30  Name_Middle;
    STRING30  Name_Last;
    STRING5   Name_Suffix;
    STRING8   DOB;
    STRING65  street_addr;
    string10  Prim_Range;
    string2   Predir;
    string28  Prim_Name;
    string4   Suffix;
    string2   Postdir;
    string10  Unit_Desig;
    string8   Sec_Range;
    STRING25  p_City_name;
    STRING2   St;
    STRING5   Z5;
    STRING10  Home_Phone;

    unsigned  did2;
    STRING9   SSN2;
    STRING120 unParsedFullName2;
    STRING30  Name_First2;
    STRING30  Name_Middle2;
    STRING30  Name_Last2;
    STRING5   Name_Suffix2;
    STRING8   DOB2;
    STRING65  street_addr2;
    string10  Prim_Range2;
    string2   Predir2;
    string28  Prim_Name2;
    string4   Suffix2;
    string2   Postdir2;
    string10  Unit_Desig2;
    string8   Sec_Range2;
    STRING25  p_City_name2;
    STRING2   St2;
    STRING5   Z52;
    STRING10  Home_Phone2;
    
    unsigned3 HistoryDateYYYYMM;
  END;



  batch_in_preseq := dataset( [], layout_in ) : stored('batch_in',few);
	unsigned1 DPPA := 0 : stored('DPPAPurpose');
	unsigned1 GLB  := AutoStandardI.Constants.GLBPurpose_default : stored('GLBPurpose');
  
    //CCPA fields
    unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
    string TransactionID := '' : STORED('_TransactionId');
    string BatchUID := '' : STORED('_BatchUID');
    unsigned6 GlobalCompanyId := 0 : STORED('_GCID');
    
    mod_access := MODULE(Doxie.IDataAccess)
	EXPORT glb := ^.glb;
	EXPORT dppa := ^.dppa;
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
END;
	// can't have duplicate definitions for the Stored value DataRestrictionMask, 
	// so we need workaround to check if datarestriction stored is the global default
	// if restriction=global default of '1    0', then use risk_indicators default instead
  string50 DataRestriction_temp := AutoStandardI.GlobalModule().DataRestrictionMask;
	string50 DataRestriction := if(DataRestriction_temp=AutoStandardI.Constants.DataRestrictionMask_default, risk_indicators.iid_constants.default_DataRestriction, DataRestriction_temp);
	
  history_date := 999999; // hard-coding a 'global' history date that will be used if the record-level value isn't present. as of now, we don't even use history date, so whatever.

  batch_in := project( batch_in_preseq, transform( layout_in, self.seq := counter, self := left ) );

  layout_batch_in_with_did := record
    risk_indicators.Layout_Batch_In;
    unsigned did;
  end;

  layout_batch_in_with_did flatten( batch_in le, integer1 picker ) := TRANSFORM
    self.seq                := le.seq * 2 + (picker-1);
    self.AcctNo             := le.AcctNo;

    self.did                := if( picker=1, le.did1,             le.did2 );

    self.SSN                := if( picker=1, le.SSN,              le.SSN2 );
    self.unParsedFullName   := if( picker=1, le.unParsedFullName, le.unParsedFullName2 );
    self.Name_First         := if( picker=1, le.Name_First,       le.Name_First2 );
    self.Name_Middle        := if( picker=1, le.Name_Middle,      le.Name_Middle2 );
    self.Name_Last          := if( picker=1, le.Name_Last,        le.Name_Last2 );
    self.Name_Suffix        := if( picker=1, le.Name_Suffix,      le.Name_Suffix2 );
    self.DOB                := if( picker=1, le.DOB,              le.DOB2 );
    self.street_addr        := if( picker=1, le.street_addr,      le.street_addr2 );
    self.Prim_Range         := if( picker=1, le.Prim_Range,       le.Prim_Range2 );
    self.Predir             := if( picker=1, le.Predir,           le.Predir2 );
    self.Prim_Name          := if( picker=1, le.Prim_Name,        le.Prim_Name2 );
    self.Suffix             := if( picker=1, le.Suffix,           le.Suffix2 );
    self.Postdir            := if( picker=1, le.Postdir,          le.Postdir2 );
    self.Unit_Desig         := if( picker=1, le.Unit_Desig,       le.Unit_Desig2 );
    self.Sec_Range          := if( picker=1, le.Sec_Range,        le.Sec_Range2 );
    self.p_City_name        := if( picker=1, le.p_City_name,      le.p_City_name2 );
    self.St                 := if( picker=1, le.St,               le.St2 );
    self.Z5                 := if( picker=1, le.Z5,               le.Z52 );
    // self.Age                := if( picker=1, le.Age,              le.Age2 );
    // self.DL_Number          := if( picker=1, le.DL_Number,        le.DL_Number2 );
    // self.DL_State           := if( picker=1, le.DL_State,         le.DL_State2 );
    self.Home_Phone         := if( picker=1, le.Home_Phone,       le.Home_Phone2 );
    // self.Work_Phone         := if( picker=1, le.Work_Phone,       le.Work_Phone2 );
    // self.ip_addr            := le.ip_addr;
    self.HistoryDateYYYYMM  := if( le.HistoryDateYYYYMM=0, history_date, le.HistoryDateYYYYMM );
    
    self := [];
  END;

  flattened := normalize( batch_in, 2, flatten(left,counter) );

	Risk_Indicators.Layout_Input cleanup( flattened le ) := TRANSFORM
		// save input data for output
		// self.acctno := le.acctno;
	
		self.seq := le.seq; // input seq is overwritten. abandon all hope, ye who enter here.
    self.did := le.did;
		historydate := if(le.HistoryDateYYYYMM=0, history_date, le.HistoryDateYYYYMM);
		self.historydate := historydate;
		self.ssn := le.ssn;
		self.dob := le.dob;
		// self.age := if ((integer)le.age = 0 and (integer)le.dob != 0,
						// (STRING3)ut.GetAgeI_asOf((unsigned)le.dob, (unsigned)risk_indicators.iid_constants.myGetDate(history_date)), 
						// le.age);
		self.phone10  := le.home_phone;
		// self.wphone10 := le.work_phone;

		cleaned_name := address.CleanPerson73(le.UnParsedFullName);
		boolean valid_cleaned := le.UnParsedFullName <> '';
		
		self.fname  := STD.Str.ToUppercase(if(le.Name_First=''   AND valid_cleaned, cleaned_name[6..25], le.Name_First));
		self.lname  := STD.Str.ToUppercase(if(le.Name_Last=''    AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
		self.mname  := STD.Str.ToUppercase(if(le.Name_Middle=''  AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
		self.suffix := STD.Str.ToUppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
		self.title  := STD.Str.ToUppercase(if(valid_cleaned, cleaned_name[1..5],''));

		street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
		clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											


		SELF.in_streetAddress := street_address;
		SELF.in_city          := le.p_City_name;
		SELF.in_state         := le.St;
		SELF.in_zipCode       := le.Z5;
			
		self.prim_range    := clean_a2[1..10];
		self.predir        := clean_a2[11..12];
		self.prim_name     := clean_a2[13..40];
		self.addr_suffix   := clean_a2[41..44];
		self.postdir       := clean_a2[45..46];
		self.unit_desig    := clean_a2[47..56];
		self.sec_range     := clean_a2[57..65];
		self.p_city_name   := clean_a2[90..114];
		self.st            := clean_a2[115..116];
		self.z5            := clean_a2[117..121];
		self.zip4          := clean_a2[122..125];
		self.lat           := clean_a2[146..155];
		self.long          := clean_a2[156..166];
		self.addr_type     := clean_a2[139];
		self.addr_status   := clean_a2[179..182];
		self.county        := clean_a2[143..145];
		self.geo_blk       := clean_a2[171..177];

		// self.dl_number := STD.Str.ToUppercase(riskwise.cleanDL_num(le.dl_number));
		// self.dl_state  := STD.Str.ToUppercase(le.dl_state);

		// SELF.ip_address := le.ip_addr;
		self := [];
	END;
	iid_prep_acct := PROJECT(flattened, cleanup(LEFT));


  // append the did. code shamelessly stolen from iid_getDID_prepOutput
  isFCRA := false;
	glb_ok := risk_indicators.iid_constants.glb_ok(glb, isFCRA);
	dppa_ok := risk_indicators.iid_constants.dppa_ok(dppa, isFCRA);
	fz := '4GZ';
	dedup_these := true;	// allow multiple DID's for bsVersion > 2
	allscores := false;
	
	didprep := PROJECT(iid_prep_acct(did=0), didville.Layout_Did_OutBatch);
	didville.Mac_DIDAppend(didprep, resu, dedup_these, fz, allscores);

  resu_did := resu + project( iid_prep_acct( did != 0 ), didville.Layout_Did_OutBatch );

  // attributes for each person
    attribs := SNA.GetAttributes( ungroup(resu_did), GLB, DPPA, DataRestriction, mod_access );
    attribs0 := attribs( seq % 2 = 0 );
    attribs1 := attribs( seq % 2 = 1 );

    SNA.Layouts.Layout_Attributes_v1 joinback( attribs0 le, attribs1 ri ) := TRANSFORM
      self.seq            := if(le.seq != 0, le.seq, ri.seq - 1); // the original seq*2, which will match up with the p2p seq      
      self.Prop1          := le.prop1;
      self.person1        := le.person1;
      self.totalcnt1      := le.totalcnt1;
      self.firstdegrees1  := le.firstdegrees1;
      self.seconddegrees1 := le.seconddegrees1;
      self.cohesivity1    := le.cohesivity1;
      
      self.Prop2          := ri.prop1;
      self.person2        := ri.person1;
      self.totalcnt2      := ri.totalcnt1;
      self.firstdegrees2  := ri.firstdegrees1;
      self.seconddegrees2 := ri.seconddegrees1;
      self.cohesivity2    := ri.cohesivity1;
      
      self := []; // remaining components are person-to-person
    END;
    attribs_both := join( attribs0, attribs1, left.seq+1 = right.seq, joinback(left,right), full outer );
  //
  
  // get attributes relating to the combination of two people
    resu0 := resu_did( seq % 2 = 0, did != 0 );
    resu1 := resu_did( seq % 2 = 1, did != 0 );
    SNA.Layouts.Layout_PersonToPerson p2p( resu0 le, resu1 ri ) := TRANSFORM
      self.seq := le.seq;
      self.person1 := le.did;
      self.person2 := ri.did;
      self := [];
    END;
    // one or the other may have no did (either not input or unable to did-append), so do an inner join here
    with2dids := join( resu0, resu1, left.seq+1 = right.seq /* and left.did!=right.did (?) */, p2p(left,right), keep(1) );
    attributes_p2p := SNA.PersonToPersonAttributes( with2dids, GLB, DPPA, DataRestriction, mod_access);
  //

  SNA.Layouts.Layout_Batch_Attributes_v1 batchify( attribs_both le, attributes_p2p ri ) := TRANSFORM
    self.AcctNo                                                  := (string20)le.seq;
    self.person1                                                 := (string20)le.person1;
    self.totalcnt1                                               := (string5)le.totalcnt1;
    self.firstdegrees1                                           := (string5)le.firstdegrees1;
    self.seconddegrees1                                          := (string5)le.seconddegrees1;
    self.cohesivity1                                             := ((string)le.cohesivity1)[1..6];
    self.person2                                                 := (string20)le.person2;
    self.totalcnt2                                               := (string5)le.totalcnt2;
    self.firstdegrees2                                           := (string5)le.firstdegrees2;
    self.seconddegrees2                                          := (string5)le.seconddegrees2;
    self.cohesivity2                                             := ((string)le.cohesivity2)[1..6];
    self.connected_associate1                                    := (string20)ri.connected_associate1;
    self.connected_associate1_paths                              := (string3)ri.connected_associate1_paths;
    self.connected_associate2                                    := (string20)ri.connected_associate2;
    self.connected_associate2_paths                              := (string3)ri.connected_associate2_paths;
    self.connected_associate3                                    := (string20)ri.connected_associate3;
    self.connected_associate3_paths                              := (string3)ri.connected_associate3_paths;
    
    self.prim_range1                                             := ri.prim_range1;
    self.prim_name1                                              := ri.prim_name1;
    self.sec_range1                                              := ri.sec_range1;
    self.zip1                                                    := ri.zip1;
    self.shared_did_count1                                       := (string3)ri.shared_did_count1;
    self.best_combined_degree1                                   := ((string)ri.best_combined_degree1)[1..6];
    
    self.prim_range2                                             := ri.prim_range2;
    self.prim_name2                                              := ri.prim_name2;
    self.sec_range2                                              := ri.sec_range2;
    self.zip2                                                    := ri.zip2;
    self.shared_did_count2                                       := (string3)ri.shared_did_count2;
    self.best_combined_degree2                                   := ((string)ri.best_combined_degree2)[1..6];
    
    self.prim_range3                                             := ri.prim_range3;
    self.prim_name3                                              := ri.prim_name3;
    self.sec_range3                                              := ri.sec_range3;
    self.zip3                                                    := ri.zip3;
    self.shared_did_count3                                       := (string3)ri.shared_did_count3;
    self.best_combined_degree3                                   := ((string)ri.best_combined_degree3)[1..6];
    
    self.prop1__cluster_sales_count                              := (string8)le.prop1.cluster_sales_count;
    self.prop1__cluster_flip_count                               := (string8)le.prop1.cluster_flip_count;
    self.prop1__cluster_flip_count10                             := (string8)le.prop1.cluster_flip_count10;
    self.prop1__cluster_flip_count30                             := (string8)le.prop1.cluster_flip_count30;
    self.prop1__cluster_flip_count60                             := (string8)le.prop1.cluster_flip_count60;
    self.prop1__cluster_flip_count120                            := (string8)le.prop1.cluster_flip_count120;
    self.prop1__cluster_flip_count180                            := (string8)le.prop1.cluster_flip_count180;
    self.prop1__cluster_flip_0_degree                            := (string8)le.prop1.cluster_flip_0_degree;
    self.prop1__cluster_flip_1_degree                            := (string8)le.prop1.cluster_flip_1_degree;
    self.prop1__cluster_flip_2_degree                            := (string8)le.prop1.cluster_flip_2_degree;
    self.prop1__cluster_flip_business_count                      := (string8)le.prop1.cluster_flip_business_count;
    self.prop1__cluster_flop_count                               := (string8)le.prop1.cluster_flop_count;
    self.prop1__cluster_flop_person_count                        := (string8)le.prop1.cluster_flop_person_count;
    self.prop1__cluster_flop_person_busines_count                := (string8)le.prop1.cluster_flop_person_busines_count;
    self.prop1__cluster_in_network_count                         := (string8)le.prop1.cluster_in_network_count;
    self.prop1__cluster_in_network_count_0_degree                := (string8)le.prop1.cluster_in_network_count_0_degree;
    self.prop1__cluster_in_network_count_1_degree                := (string8)le.prop1.cluster_in_network_count_1_degree;
    self.prop1__cluster_in_network_count_2_degree                := (string8)le.prop1.cluster_in_network_count_2_degree;
    self.prop1__cluster_in_network_flip_business_count           := (string8)le.prop1.cluster_in_network_flip_business_count;
    self.prop1__cluster_in_network_flop                          := (string8)le.prop1.cluster_in_network_flop;
    self.prop1__cluster_in_network_flip_count                    := (string8)le.prop1.cluster_in_network_flip_count;
    self.prop1__cluster_in_network_flip_count_0_degree           := (string8)le.prop1.cluster_in_network_flip_count_0_degree;
    self.prop1__cluster_in_network_flip_count_1_degree           := (string8)le.prop1.cluster_in_network_flip_count_1_degree;
    self.prop1__cluster_in_network_flip_count_2_degree           := (string8)le.prop1.cluster_in_network_flip_count_2_degree;
    self.prop1__cluster_high_profit_count                        := (string8)le.prop1.cluster_high_profit_count;
    self.prop1__cluster_high_profit_count_0_degree               := (string8)le.prop1.cluster_high_profit_count_0_degree;
    self.prop1__cluster_high_profit_count_1_degree               := (string8)le.prop1.cluster_high_profit_count_1_degree;
    self.prop1__cluster_high_profit_count_2_degree               := (string8)le.prop1.cluster_high_profit_count_2_degree;
    self.prop1__cluster_in_network_high_profit                   := (string8)le.prop1.cluster_in_network_high_profit;
    self.prop1__cluster_in_network_high_profit_0_degree          := (string8)le.prop1.cluster_in_network_high_profit_0_degree;
    self.prop1__cluster_in_network_high_profit_1_degree          := (string8)le.prop1.cluster_in_network_high_profit_1_degree;
    self.prop1__cluster_in_network_high_profit_2_degree          := (string8)le.prop1.cluster_in_network_high_profit_2_degree;
    self.prop1__cluster_in_network_high_profit_flip_count        := (string8)le.prop1.cluster_in_network_high_profit_flip_count;
    self.prop1__cluster_default_count                            := (string8)le.prop1.cluster_default_count;
    self.prop1__cluster_foreclosure_count                        := (string8)le.prop1.cluster_foreclosure_count;
    self.prop1__cluster_foreclosure_default_count_0_degree       := (string8)le.prop1.cluster_foreclosure_default_count_0_degree;
    self.prop1__prop_network_cohesivity                          := ((string)le.prop1.prop_network_cohesivity)[1..6];
    self.prop1__prop_1st_degrees                                 := (string8)le.prop1.prop_1st_degrees;
    self.prop1__prop_2nd_degrees                                 := (string8)le.prop1.prop_2nd_degrees;
    self.prop1__sales_count_stdd                                 := ((string)le.prop1.sales_count_stdd)[1..6];
    self.prop1__flip_count_actors                                := (string8)le.prop1.flip_count_actors;
    self.prop1__flip_count_stdd                                  := ((string)le.prop1.flip_count_stdd)[1..6];
    self.prop1__cluster_ends_in_default_foreclosure              := (string8)le.prop1.cluster_ends_in_default_foreclosure;
    self.prop1__cluster_fha_count                                := (string8)le.prop1.cluster_fha_count;
    self.prop1__cluster_va_count                                 := (string8)le.prop1.cluster_va_count;
    self.prop1__prop_people_count                                := (string8)le.prop1.prop_people_count;
    self.prop1__distinct_property_count                          := (string8)le.prop1.distinct_property_count;
    self.prop1__high_incidence_flip_count                        := (string8)le.prop1.high_incidence_flip_count;
    self.prop1__high_incidence_in_network_count                  := (string8)le.prop1.high_incidence_in_network_count;
    self.prop1__high_incidence_in_network_flip_count             := (string8)le.prop1.high_incidence_in_network_flip_count;
    self.prop1__high_incidence_high_profit_count                 := (string8)le.prop1.high_incidence_high_profit_count;
    self.prop1__high_incidence_in_network_high_profit_count      := (string8)le.prop1.high_incidence_in_network_high_profit_count;
    self.prop1__high_incidence_in_network_high_profit_flip_count := (string8)le.prop1.high_incidence_in_network_high_profit_flip_count;
    self.prop1__p_city_name                                      := le.prop1.p_city_name;
    
    self.prop2__cluster_sales_count                              := (string8)le.prop2.cluster_sales_count;
    self.prop2__cluster_flip_count                               := (string8)le.prop2.cluster_flip_count;
    self.prop2__cluster_flip_count10                             := (string8)le.prop2.cluster_flip_count10;
    self.prop2__cluster_flip_count30                             := (string8)le.prop2.cluster_flip_count30;
    self.prop2__cluster_flip_count60                             := (string8)le.prop2.cluster_flip_count60;
    self.prop2__cluster_flip_count120                            := (string8)le.prop2.cluster_flip_count120;
    self.prop2__cluster_flip_count180                            := (string8)le.prop2.cluster_flip_count180;
    self.prop2__cluster_flip_0_degree                            := (string8)le.prop2.cluster_flip_0_degree;
    self.prop2__cluster_flip_1_degree                            := (string8)le.prop2.cluster_flip_1_degree;
    self.prop2__cluster_flip_2_degree                            := (string8)le.prop2.cluster_flip_2_degree;
    self.prop2__cluster_flip_business_count                      := (string8)le.prop2.cluster_flip_business_count;
    self.prop2__cluster_flop_count                               := (string8)le.prop2.cluster_flop_count;
    self.prop2__cluster_flop_person_count                        := (string8)le.prop2.cluster_flop_person_count;
    self.prop2__cluster_flop_person_busines_count                := (string8)le.prop2.cluster_flop_person_busines_count;
    self.prop2__cluster_in_network_count                         := (string8)le.prop2.cluster_in_network_count;
    self.prop2__cluster_in_network_count_0_degree                := (string8)le.prop2.cluster_in_network_count_0_degree;
    self.prop2__cluster_in_network_count_1_degree                := (string8)le.prop2.cluster_in_network_count_1_degree;
    self.prop2__cluster_in_network_count_2_degree                := (string8)le.prop2.cluster_in_network_count_2_degree;
    self.prop2__cluster_in_network_flip_business_count           := (string8)le.prop2.cluster_in_network_flip_business_count;
    self.prop2__cluster_in_network_flop                          := (string8)le.prop2.cluster_in_network_flop;
    self.prop2__cluster_in_network_flip_count                    := (string8)le.prop2.cluster_in_network_flip_count;
    self.prop2__cluster_in_network_flip_count_0_degree           := (string8)le.prop2.cluster_in_network_flip_count_0_degree;
    self.prop2__cluster_in_network_flip_count_1_degree           := (string8)le.prop2.cluster_in_network_flip_count_1_degree;
    self.prop2__cluster_in_network_flip_count_2_degree           := (string8)le.prop2.cluster_in_network_flip_count_2_degree;
    self.prop2__cluster_high_profit_count                        := (string8)le.prop2.cluster_high_profit_count;
    self.prop2__cluster_high_profit_count_0_degree               := (string8)le.prop2.cluster_high_profit_count_0_degree;
    self.prop2__cluster_high_profit_count_1_degree               := (string8)le.prop2.cluster_high_profit_count_1_degree;
    self.prop2__cluster_high_profit_count_2_degree               := (string8)le.prop2.cluster_high_profit_count_2_degree;
    self.prop2__cluster_in_network_high_profit                   := (string8)le.prop2.cluster_in_network_high_profit;
    self.prop2__cluster_in_network_high_profit_0_degree          := (string8)le.prop2.cluster_in_network_high_profit_0_degree;
    self.prop2__cluster_in_network_high_profit_1_degree          := (string8)le.prop2.cluster_in_network_high_profit_1_degree;
    self.prop2__cluster_in_network_high_profit_2_degree          := (string8)le.prop2.cluster_in_network_high_profit_2_degree;
    self.prop2__cluster_in_network_high_profit_flip_count        := (string8)le.prop2.cluster_in_network_high_profit_flip_count;
    self.prop2__cluster_default_count                            := (string8)le.prop2.cluster_default_count;
    self.prop2__cluster_foreclosure_count                        := (string8)le.prop2.cluster_foreclosure_count;
    self.prop2__cluster_foreclosure_default_count_0_degree       := (string8)le.prop2.cluster_foreclosure_default_count_0_degree;
    self.prop2__prop_network_cohesivity                          := ((string)le.prop2.prop_network_cohesivity)[1..6];
    self.prop2__prop_1st_degrees                                 := (string8)le.prop2.prop_1st_degrees;
    self.prop2__prop_2nd_degrees                                 := (string8)le.prop2.prop_2nd_degrees;
    self.prop2__sales_count_stdd                                 := ((string)le.prop2.sales_count_stdd)[1..6];
    self.prop2__flip_count_actors                                := (string8)le.prop2.flip_count_actors;
    self.prop2__flip_count_stdd                                  := ((string)le.prop2.flip_count_stdd)[1..6];
    self.prop2__cluster_ends_in_default_foreclosure              := (string8)le.prop2.cluster_ends_in_default_foreclosure;
    self.prop2__cluster_fha_count                                := (string8)le.prop2.cluster_fha_count;
    self.prop2__cluster_va_count                                 := (string8)le.prop2.cluster_va_count;
    self.prop2__prop_people_count                                := (string8)le.prop2.prop_people_count;
    self.prop2__distinct_property_count                          := (string8)le.prop2.distinct_property_count;
    self.prop2__high_incidence_flip_count                        := (string8)le.prop2.high_incidence_flip_count;
    self.prop2__high_incidence_in_network_count                  := (string8)le.prop2.high_incidence_in_network_count;
    self.prop2__high_incidence_in_network_flip_count             := (string8)le.prop2.high_incidence_in_network_flip_count;
    self.prop2__high_incidence_high_profit_count                 := (string8)le.prop2.high_incidence_high_profit_count;
    self.prop2__high_incidence_in_network_high_profit_count      := (string8)le.prop2.high_incidence_in_network_high_profit_count;
    self.prop2__high_incidence_in_network_high_profit_flip_count := (string8)le.prop2.high_incidence_in_network_high_profit_flip_count;
    self.prop2__p_city_name                                      := le.prop2.p_city_name;
  END;



  pre_acct := join( attribs_both, attributes_p2p, left.seq=right.seq, batchify(left,right), left outer, keep(1) );
  
  final := join( pre_acct, batch_in, (unsigned)left.AcctNo=right.seq*2,
    transform( SNA.Layouts.Layout_Batch_Attributes_v1, self.AcctNo := right.acctno, self := left ), keep(1) );

  output(final, named('Results'));
ENDMACRO;
// SNA.Attributes_Batch_Service()