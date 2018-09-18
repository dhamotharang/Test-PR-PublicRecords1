/*
	This service does a batch like search of the header file.
	<part name="FullNames" type="tns:XmlDataSet" cols="75" rows="25"/>
	<part name="FullAddrs" type="tns:XmlDataSet" cols="75" rows="25"/>
  <part name="phones" type="tns:EspStringArray"/>
	<part name="SSNS" type="tns:EspStringArray"/>
	<part name="DOBS" type="tns:EspIntArray"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
	<part name="ScoreThreshold" type="xsd:unsignedInt"/>
	<part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="PhoneticMatch" type="xsd:boolean"/>
	<part name="AllowNickNames" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:unsignedInt"/>
	<part name="GLBPurpose" type="xsd:unsignedInt"/>
	<part name="ProbationOverride" type="xsd:boolean"/>
	<part name="LNBranded" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
*/

import doxie, autokey, ut, header, suppress;

doxie.MAC_Header_Field_Declare();
mod_access := doxie.functions.GetGlobalDataAccessModule ();

Layout_Names := RECORD
	STRING30  name_first;
	STRING30  name_middle;
	STRING30  name_last;
END;
fullnames := dataset([],Layout_Names) : stored('FullNames',few);
//output(fullnames, NAMED('FullNames'));

Layout_Addrs := RECORD
	STRING200  addr;
	STRING25  city;
	STRING2  state;
	STRING5  zip;
END;	
fulladdrs := dataset([],Layout_Addrs) : stored('FullAddrs',few);
//output(fulladdrs, NAMED('FullAddrs'));

set of string10 phone_values := [] : stored('Phones',few);
set of string9 ssn_values := [] : stored('SSNS',few);
set of unsigned8 dob_values := [] : stored('DOBS',few);
// get these input values into datasets
phones := dataset(phone_values,{string10 phone_value});
ssns := dataset(ssn_values,{string9 ssn_value});
dobs := dataset(dob_values,{unsigned8 dob_value});

// -----------------------
// Combine the records?

CombinedInputRec := RECORD
	header.Layout_Header;
END;
dummyrec := DATASET([{'X','X','X'}],Layout_Names);
CombinedInputRec JoinNames (Layout_Names l, Layout_Names r) := TRANSFORM
	SELF.fname := stringlib.stringtouppercase(r.name_first);
	SELF.mname := stringlib.stringtouppercase(r.name_middle);
	SELF.lname := stringlib.stringtouppercase(r.name_last);
	SELF.rid := 0;
	SELF.src := '';
	SELF.dt_first_seen := 0;
	SELF.dt_last_seen := 0;
	SELF.dt_vendor_last_reported := 0;
	SELF.dt_vendor_first_reported := 0;
	SELF.dt_nonglb_last_seen := 0;
	SELF.rec_type := '';
	SELF.vendor_id := '';
	SELF.phone := '';
	SELF.ssn:= '';
	SELF.dob:= 0;
	SELF.title := '';
	SELF.name_suffix := '';
	SELF.prim_range := '';
	SELF.predir:= '';
	SELF.prim_name := '';
	SELF.suffix := '';
	SELF.postdir := '';
	SELF.unit_desig := '';
	SELF.sec_range := '';
	SELF.city_name := '';
	SELF.st := '';
	SELF.zip := '';
	SELF.zip4 := '';
	SELF.county := '';
	SELF.geo_blk := '';
	
END;
CombinedInputRec JoinAddrs (CombinedInputRec l, Layout_Addrs r) := TRANSFORM
	local_clean_address := IF(r.addr <> '' OR r.city <> '', 
				doxie.cleanaddress182(r.addr,
									    IF(r.city<>'' AND r.state<>'',
										  TRIM(r.city) + ' ' + TRIM(r.state),
										  'New York NY')), 
				'') ;
	SELF.predir := local_clean_address[11..12];
	SELF.prim_range := local_clean_address[1..10];
	SELF.prim_name := doxie.StripOrdinal(local_clean_address[13..40]);
	SELF.suffix := local_clean_address[41..44];
	SELF.postdir := local_clean_address[45..46];
	SELF.sec_range := local_clean_address[57..64];
	city_value := IF(r.city<>'' AND r.state<>'', local_clean_address[90..114], stringlib.stringtouppercase(r.city)) ;

	SELF.city_name := city_value;
	state_value := IF( r.city='' and r.state='' and r.zip<>'', ziplib.ZipToState2(r.zip),
                     stringlib.stringtouppercase(r.state));
	SELF.st := state_value;
	SELF.zip := r.zip;
	SELF := l;
END;
CombinedInputRec JoinPhones (CombinedInputRec l, phones r) := TRANSFORM
	SELF.phone := r.phone_value;
	SELF := l;
END;
CombinedInputRec JoinSSNS (CombinedInputRec l, ssns r) := TRANSFORM
	SELF.ssn := r.ssn_value;
	SELF := l;
END;
CombinedInputRec JoinDOBs (CombinedInputRec l, dobs r) := TRANSFORM
	SELF.dob := MAP(r.dob_value < 10000 => r.dob_value * 10000,
									r.dob_value < 1000000 => r.dob_value * 100,
									r.dob_value);
	SELF := l;
END;

CombinedInputRecsNoRid :=  JOIN(
												JOIN(
													JOIN( 		
														JOIN(
															JOIN(dummyrec,fullnames,true,JoinNames(LEFT,RIGHT),LEFT OUTER,all),
														fulladdrs,true,JoinAddrs(LEFT,RIGHT),LEFT OUTER,all),
													phones,true,JoinPhones(LEFT,RIGHT),LEFT OUTER,all),
												ssns,true,JoinSSNs(LEFT,RIGHT),LEFT OUTER,all),
											dobs,true,JoinDOBS(LEFT,RIGHT),LEFT OUTER,all);
CombinedInputRecsNoRid doCombinedInputRecs(CombinedInputRecsNoRid l, integer c) := TRANSFORM
	self.rid := c;
	self := l;
END;
CombinedInputRecs := project(CombinedInputRecsNoRid, doCombinedInputRecs(LEFT,COUNTER));
//output(count(CombinedInputRecs),NAMED('CombinedInputRecsCount'));
//output(CombinedInputRecs,NAMED('CombinedInputRecs'));
// -----------------------
// Get some dids for the input parameters
// get pile of names
JoinedExactNameRecs := Header_Services.Did_From_Name(CombinedInputRecs,false,false,false);
//output(count(JoinedExactNameRecs.outrecs),NAMED('JoinedExactNameRecsCount'));
//output(JoinedExactNameRecs.outrecs,NAMED('JoinedExactNameRecs'));
JoinedNameRecs := Header_Services.Did_From_Name(CombinedInputRecs,false,phonetics,nicknames);
//output(count(JoinedNameRecs.outrecs),NAMED('JoinedNameRecsCount'));
//output(JoinedNameRecs.outrecs,NAMED('JoinedNameRecs'));
// get pile of addresses
 JoinedAddressRecs := Header_Services.Did_From_Address(CombinedInputRecs,false,phonetics,zipradius_value); 
//output(count(JoinedAddressRecs),NAMED('JoinedAddressRecsCount'));
//output(JoinedAddressRecs,NAMED('JoinedAddressRecs'));
// get pile of ssns
JoinedSSNRecs := Header_Services.Did_From_SSN(CombinedInputRecs,false,score_threshold_value);							
//output(count(JoinedSSNRecs),NAMED('JoinedSSNRecsCount'));
//output(JoinedSSNRecs,NAMED('JoinedSSNRecs'));

// get pile of phones
JoinedPhoneRecs := Header_Services.Did_From_Phone(CombinedInputRecs,false);							
//output(count(JoinedPhoneRecs),NAMED('JoinedPhoneRecsCount'));
//output(JoinedPhoneRecs,NAMED('JoinedPhoneRecs'));

CombinedRecs := SORT(JoinedNameRecs.outrecs + JoinedExactNameRecs.outrecs + JoinedAddressRecs.outrecs 
								+ JoinedPhoneRecs + JoinedSSNRecs,did);
//output(count(CombinedRecs),NAMED('CombinedRecsCount'));
//output(CombinedRecs,NAMED('CombinedRecs'));
// -----------------------
//Get the records from the header file by the dids?
header.Layout_Header doKeyHeaderJoin(doxie.Key_Header r) := TRANSFORM
	SELF := r;
END;
DedupedCombinedRecs := Dedup(CombinedRecs,did);
UncleanHeaderRecs := JOIN(DedupedCombinedRecs,doxie.Key_Header,
									KEYED(LEFT.did = RIGHT.s_did)
									, doKeyHeaderJoin(RIGHT)
									);
// output(count(HeaderRecs),NAMED('HeaderRecsCount'));
// output(HeaderRecs,NAMED('HeaderRecs'));
header.MAC_GlbClean_Header(UncleanHeaderRecs,BigHeaderRecs, , , mod_access);
header.Layout_Header doBigHeaderProject(BigHeaderRecs l) := TRANSFORM
	SELF := l;
END;
HeaderRecs := project(BigHeaderRecs, doBigHeaderProject(LEFT));
// Score the results?
// Calculate_Penalty(DATASET(header.Layout_Header)l_rec, DATASET(header.Layout_Header) r_rec,
//												unsigned1 score_threshold_value, unsigned2 zipradius_value) 

ScoredHeaderRecs := Calculate_Penalty(HeaderRecs,CombinedInputRecs,score_threshold_value,zipradius_value,application_type_value);
//output(count(ScoredHeaderRecs),NAMED('ScoredHeaderRecsCount'));
//output(ScoredHeaderRecs,NAMED('ScoredHeaderRecs'));

// Take the best score for each header record?
SortedByDIDScoredHeaderRecs := SORT(ScoredHeaderRecs,did);
Layout_HeaderOut_Calculate_Penalty doHeaderRollupByDID(Layout_HeaderOut_Calculate_Penalty l, Layout_HeaderOut_Calculate_Penalty r) := TRANSFORM
		SELF.penlty := IF(l.penlty < r.penlty, l.penlty,r.penlty);
		SELF := l;
END;
RolledScoredHeaderRecs := ROLLUP(SortedByDIDScoredHeaderRecs,doHeaderRollupByDID(LEFT,RIGHT), did);

// Keep the MaxResults count of dids for the best scored records 
Layout_FAPMulti_Out := RECORD
			integer penlty;
			unsigned6 did;
END;
SortedRolledScoredHeaderRecs := TOPN(RolledScoredHeaderRecs,maxresults_val,penlty);

Layout_FAPMulti_Out doOutputProject (Layout_HeaderOut_Calculate_Penalty l) := TRANSFORM
	SELF := l;
END;
FAPMulti_Out := project(SortedRolledScoredHeaderRecs,doOutputProject(LEFT));

LAFNRecs := SORT(JoinedNameRecs.LAFNRecs 
							+ JoinedExactNameRecs.LAFNRecs
							+ JoinedAddressRecs.LAFNRecs,rid);
							
LAFNRecs doRolledLAFNRecs(LAFNRecs l,LAFNRecs r) := TRANSFORM
	SELF.lafn := if(l.lafn = true and r.lafn = true,true,false);
	SELF := r;
END;
							
RolledLAFNRecs := ROLLUP(LAFNRecs, LEFT.rid = RIGHT.rid,doRolledLAFNRecs(LEFT,RIGHT));
//output(RolledLAFNRecs,Named('RolledLAFNRecs'));
LAFN := if(Exists(RolledLAFNRecs(lafn = true)),203,0);

output(LAFN,named('Status'));

export Fetch_Header_File_FAPMulti := FAPMulti_Out;







