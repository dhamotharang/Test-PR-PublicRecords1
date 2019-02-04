/*--SOAP--
<message name="RealTimePhones_BatchService">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>  
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="StrictSSN" type="xsd:boolean"/> 
  <part name="SearchType" type="xsd:string"/> 
  <part name="UID" type="xsd:string"/> 
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
</message>
*/
/*--INFO--
acctno is required and must be unique for each row

<pre>
&lt;batch_in&gt;
&lt;row&gt;
  &lt;acctno&gt;&lt;/acctno&gt;
  &lt;phoneno&gt;&lt;/phoneno&gt;
  &lt;ssn&gt;&lt;/ssn&gt;
  &lt;did&gt;&lt;/did&gt;
  &lt;unparsedfullname&gt;&lt;/unparsedfullname&gt;
  &lt;name_first&gt;&lt;/name_first&gt;
  &lt;name_last&gt;&lt;/name_last&gt;
  &lt;unparsedaddr1&gt;&lt;/unparsedaddr1&gt;
  &lt;unparsedaddr2&gt;&lt;/unparsedaddr2&gt;
  &lt;p_city_name&gt;&lt;/p_city_name&gt;
  &lt;st&gt;&lt;/st&gt;
  &lt;zip5&gt;&lt;/zip5&gt;
&lt;/row&gt;  
&lt;/batch_in&gt;
</pre>
*/

import Gateway,   AutoStandardI,  BatchServices, address, Royalty, Phones;
export RealTimePhones_BatchService := macro
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);  
	max_results := BatchServices.Constants.RealTime.REALTIME_PHONE_LIMIT : stored('max_results_per_acct');
	store_max := if (max_results > BatchServices.Constants.RealTime.REALTIME_PHONE_LIMIT or max_results = 0,BatchServices.Constants.RealTime.REALTIME_PHONE_LIMIT,max_results);
	#stored('MaxResults', store_max);
  in_gateways := Gateway.Configuration.get();
	f_in := dataset([], BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input) : stored('batch_in');
	in_mod := module(BatchServices.RealTimePhones_Params.Params)
		 export string12	searchType := batchServices.constants.REALTIME.SEARCHTYPE.SEARCH_INPUT :stored('SearchType');// Constants to be created 1-6 phone/nameAddr/ssn/addronly/linkid/waterfall
		 export boolean	strictSSN := false : stored('StrictSSN'); // option to set strict match  FALSE means to WATERFALL
		 export string UID := '' : stored('UID'); // Job Id coming in from batch for tracking the gateway hits
	end;
	g_mod := PROJECT(AutoStandardI.GlobalModule(), in_mod, OPT);	
	f_in upper_trans ( f_in L, integer c) := transform
	   self.phoneno  := if (L.phoneno[1] = '1', L.phoneno[2..15], L.phoneno);
     cleaned_name 			:= address.CleanPerson73(L.unparsedfullname);
     clean_first  			:= cleaned_name[6..25];
     clean_last   			:= cleaned_name[46..65];
	   self.name_first := StringLib.StringToUpperCase(if (length(trim(L.name_first)) > 0, L.name_first, clean_first));
	   self.name_last := StringLib.StringToUpperCase(if (length(trim(L.name_last)) > 0,  L.name_last, clean_last));
	   self.unparsedfullname := StringLib.StringToUpperCase(L.unparsedfullname);
		 addrline2 := L.p_city_name + ' '+ l.st + ' ' +L.zip5;
		 clean_add := Address.GetCleanAddress(trim(L.unparsedaddr1)+' '+l.unparsedaddr2,addrline2, address.Components.Country.US);
	   self.unparsedaddr1 := StringLib.StringCleanSpaces(clean_add.results.prim_range + ' ' + clean_add.results.predir + 
																	' ' + clean_add.results.prim_name + ' ' + clean_add.results.suffix +
															' ' + clean_add.results.postdir + ' ' + clean_add.results.sec_range);
	   self.unparsedaddr2 := '';
		 self.prim_name := clean_add.results.prim_name;
		 self.prim_range := clean_add.results.prim_range;
	   self.p_city_name := clean_add.results.p_city;
	   self.st := clean_add.results.state;
		 self.zip5 := clean_add.results.zip;
		 self.ssn := intformat((integer)stringlib.stringfilter(L.ssn,'0123456789'),9,1);
		 self.acctno := if(L.acctno = '', 'Z'+intformat(c,4,1) , L.acctno);
		 self := L;
	end;
	u_in := project(f_in,upper_trans(left,counter));
	batch_out :=  BatchServices.RealTimePhones_BatchService_Records(u_in, in_gateways, g_mod);
	BatchServices.Layouts.RTPhones.rec_output_internal norm_tran(BatchServices.Layouts.RTPhones.rec_output_internal Lin) := transform
		self := Lin;
	end;
	results := normalize(batch_out,left.results,norm_tran(right));
  doxie.MAC_Header_Field_Declare()

	dids_for_best_in	:= dedup(sort(project(results(did<>''),transform(doxie.layout_references,self.did := (integer)left.did) ),did),did);
	doxie.mac_best_records(dids_for_best_in,did,outfile,dppa_ok,glb_ok,,doxie.DataRestriction.fixed_DRM);
	BatchServices.Layouts.RTPhones.rec_batch_RTPhones_out trans_best(results l,outfile r) := transform
		self.ssn := if (l.ssn = ' ',r.ssn,l.ssn);
		self := l;
	end;
	results_best:= join(results,outfile,(integer)left.did = right.did and left.ssn = '',
										trans_best(left,right),left outer,keep(1),limit(0));
										
	Suppress.MAC_Mask(results_best, final_res, ssn, blank, true, false,,,,SSN_mask_value);		

	// ---- Royalties
	boolean ReturnDetailedRoyalties := false : stored('ReturnDetailedRoyalties');
	dQSentRecs := results(typeflag=Phones.Constants.TypeFlag.DataSource_PV or typeflag=Phones.Constants.TypeFlag.DataSource_iQ411);
	// The final result may contain multiple records with data pulled from a single gateway record.
	// I'm deduping by phoneno+typeflag to only account for gateway records here.
	dRoyaltiesQSent	:= 
		dedup(sort(dQSentRecs, acctno, phone, typeflag), acctno, phone, typeflag)
		+ results(vendor_id=MDR.sourceTools.src_Inhouse_QSent, typeflag=''); // inhouse QT 
	
	dRoyaltiesByAcctno 	:= Royalty.RoyaltyQSent.GetBatchRoyaltiesByAcctno(f_in, dRoyaltiesQSent,,,, acctno);
	dRoyalties 					:= Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);
	// ----
	
	Output(final_res , NAMED('Results') );		
	Output(dRoyalties , NAMED('RoyaltySet') );		
endmacro;
// BatchServices.RealTimePhones_BatchService();
//RealTimePhones_BatchService();
//sample request datasets below:
/*
<batch_in>
<row>
  <acctno></acctno>
  <phoneno></phoneno>
  <unparsedfullname></unparsedfullname>
  <name_first></name_first>
  <name_last></name_last>
  <unparsedaddr1></unparsedaddr1>
  <unparsedaddr2></unparsedaddr2>
  <p_city_name></p_city_name>
  <st></st>
  <zip5></zip5>
</row>  
</batch_in>


<Gateways>
 <row>
 <servicename>qsent</servicename>
 <url>http://web_bps_roxie:[PASSWORD_REDACTED]@lt-esponline01:8091/wsGateway</url>
 </row>
</Gateways>
*/