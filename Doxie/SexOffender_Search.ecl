/*--SOAP-- 
<message name="SexOffender_Search" wuTimeout="240000">
 <part name="SSN" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="OtherCity1" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="OtherState1" type="xsd:string"/>
  <part name="OtherState2" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Radius" type="xsd:unsignedInt"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="SearchAroundAddress" type="xsd:boolean"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="ApplicationType"     type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="Raw" type="xsd:boolean"/>
  <part name="SeisintAdlService" type="xsd:string"/>
  <part name="IsANeighbor" type="xsd:boolean"/>
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="SeisintPrimaryKey" type="xsd:string"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
	<part name="IncludeHistoricalAltAddresses" type="xsd:boolean"/>
	<part name="IncludeRelativeAltAddresses" type="xsd:boolean"/>	
	<part name="ExcludeRegisteredAltAddresses" type="xsd:boolean"/>		
	<part name="IncludeNonRegisteredAltAddresses" type="xsd:boolean"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>	
</message>
*/
/*--INFO-- This service pulls from the Sex Offenders file.*/
import SexOffender, Alerts;

export SexOffender_Search := macro
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#STORED('LookupType','SEX');
#STORED('ScoreThreshold',20);

WSInput.MAC_SexOffender_Search();
SexOffender.MAC_Header_Field_Declare();

f_raw := doxie.sexoffender_search_people_records ();
f_searchperson := project(f_raw(st<>''),  
             transform(doxie.layout_sexoffender_searchperson, 
                               self.did := if(doxie.FN_Tra_Penalty_Addr(left.predir,left.prim_range,
	 			  		                                           left.prim_name,left.addr_suffix,
						                                           left.postdir,left.sec_range,
						                                           left.v_city_name,left.st,left.zip5)
														   >=10 and ~EXISTS(left.addresses) and ~SearchAroundAddress_value, skip, left.did);
             self.name_orig := address.NameFromComponents(left.fname,left.mname,left.lname,left.name_suffix);
						 self := left)) + f_raw(st='');

doxie.Layout_SexOffender_NameScore get_name_score(doxie.layout_sexoffender_searchperson le) := transform
	self.name_score  := IF(fname_val='' AND lname_val='',0,
												 datalib.namematch(le.fname,le.mname,le.lname,fname_val,mname_val,lname_val));
	SELF.Alternate_Address_Search_Results := le.addresses;
	self.name := [];
	self.addr_score := min(IF(~EXISTS(le.addresses),10,MIN(le.addresses,IF(alt_type='H',10,addrScore))), 
															doxie.FN_Tra_Penalty_Addr(le.predir,le.prim_range,
																							 le.prim_name,le.addr_suffix,
																							 le.postdir,le.sec_range,
																							 le.v_city_name,le.st,le.zip5));
	self.Best_Mismatch := IF(COUNT(le.addresses(isMismatched))>0,1,0);
	self.addr_pref := MAX(le.addresses,addrpref);
	self.penalt := self.addr_score+self.name_score;
	self.clean_address_description := le.record_type;
	self             := le;
end;

f_score := project(f_searchperson, get_name_score(left));

f_sort  := sort(f_score, seisint_primary_key, -(length(trim(lname)) > 0),
                                              -(length(trim(fname)) > 0), 
									  name_score, 
									 -(unsigned4)score,
									 -addr_dt_last_seen,
									 -ssn_appended,
									 -clean_address_description);
									 
f_group := group(f_sort, seisint_primary_key);

// get best name record
f_best_name := dedup(f_group, seisint_primary_key);


// get one record per "person"
f_dedup := dedup(f_group, except lname, except fname, except mname, except name_suffix, 
                          except name_orig, except name_type, except name_score, 
					 except score, except did, 
					 except ssn_appended, except clean_address_description, 
					 except penalt, except addr_dt_last_seen, all);

chooseNSort := SORT(GROUP(f_dedup), -addr_pref, penalt, seisint_primary_key);

// moved Mac_Marshall to the end, and replace it with the choosen here to limit results;
// will marshall after the alert calculation
FinalN := CHOOSEN(chooseNSort,MaxResults_val);

doxie.Layout_SexOffender_NameScore get_best_name(doxie.Layout_SexOffender_NameScore l, doxie.Layout_SexOffender_NameScore r) := transform
     self.Alternate_Address_Search_Results := SORT(l.Alternate_Address_Search_Results, -alt_addr_dt_last_seen);
    	self.name_orig   := r.name_orig;
     self.lname       := r.lname;
     self.fname       := r.fname;
     self.mname       := r.mname;
     self.name_suffix := r.name_suffix;
     self.name_type   := r.name_type;
		 self.age         := (string)ut.Age((integer)l.dob);
	   self             := l;
end;

Fetched := join(FinalN, f_best_name,
               left.seisint_primary_key = right.seisint_primary_key, 
               get_best_name(left, right), left outer);

/* ******************** Add AKA's Back ******************* */
//  Get the spk and name fields
layout_spk_name := record
   string60 	seisint_primary_key := '';
   string50 	name_orig := '';
   string30 	lname := '';
   string30 	fname := '';
   string20 	mname := '';
   string20 	name_suffix := '';
   string1 	  name_type := '';
end;

layout_spk_name get_spk_name(doxie.layout_sexoffender_searchperson l) := transform
	self := l;
end;

f_spk_name := project(f_searchperson, get_spk_name(left));

//  Add name field
doxie.Layout_SexOffender_NameScore get_aka_name(doxie.Layout_SexOffender_NameScore l, layout_spk_name r) := transform
     self.name := l.name + project(r,transform(doxie.layout_sexoffender_name,self:=left));
     self := l;
end;

f_final   := denormalize(Fetched, dedup(f_spk_name,seisint_primary_key,name_orig,all), 
                        left.seisint_primary_key = right.seisint_primary_key and
                       (left.name_orig <> right.name_orig or
                        left.lname <> right.lname or
                        left.fname <> right.fname or
                        left.mname <> right.mname or
                        left.name_suffix <> right.name_suffix or
                        left.name_type <> right.name_type), 
                        get_aka_name(left, right));


Alerts.mac_ProcessAlerts(f_final,doxie.SexOffender_alert,f_final_alert);

// add offense convictions child dataset
layout_offenses := record
	SexOffender.Layout_common_Offense and not Seisint_Primary_Key;
end;

Layout_SexOffender_with_Offenses := record
	doxie.Layout_SexOffender_NameScore;
	dataset(layout_offenses) convictions;
end;

Layout_SexOffender_with_Offenses addOffenseChildren(doxie.Layout_SexOffender_NameScore L,dataset(doxie.layout_sexoffender_searchevents) R) := transform
	self.convictions := project(R,layout_offenses);
	self := L;
end;

offenses := doxie.sexoffender_search_events_records(f_searchperson);
f_final_with_offenses := denormalize(f_final_alert,offenses,left.Seisint_Primary_Key=right.Seisint_Primary_Key,group,addOffenseChildren(left,rows(right)));

doxie.MAC_Marshall_Results(f_final_with_offenses,results, 200000);

output(results,named('Results'));

endmacro;