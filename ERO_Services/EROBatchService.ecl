/*--SOAP--
<message name="EROBatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
  <separator/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask"  type="xsd:string"/>
  <part name="IncludeMinors"       type="xsd:boolean"/>
  <part name="MaxPhoneCount" type="xsd:unsignedInt" default="5"/>
  <part name="CountType1_Es_EDASEARCH" type="xsd:unsignedInt" default="5"/>
  <part name="CountType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt" default="5"/>
  <part name="CountType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt" default="5"/>
	<part name="GetSSNBest"           type="xsd:boolean"/>
  <separator/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
/*--HELP-- 
<pre>
&lt;batchIn&gt;
 &lt;Row&gt;
&lt;acctno&gt;&lt;/acctno&gt;
&lt;did&gt;&lt;/did&gt;
&lt;ssn&gt;&lt;/ssn&gt;
&lt;dob&gt;&lt;/dob&gt;
&lt;name_first&gt;&lt;/name_first&gt; 
&lt;name_middle&gt;&lt;/name_middle&gt;
&lt;name_last&gt;&lt;/name_last&gt; 
&lt;name_suffix&gt;&lt;/name_suffix&gt;
&lt;prim_range&gt;&lt;/prim_range&gt;
&lt;predir&gt;&lt;/predir&gt;
&lt;prim_name&gt;&lt;/prim_name&gt;	
&lt;addr_suffix&gt;&lt;/addr_suffix&gt;
&lt;postdir&gt;&lt;/postdir&gt; 
&lt;unit_desig&gt;&lt;/unit_desig&gt;
&lt;sec_range&gt;&lt;/sec_range&gt;	
&lt;p_city_name&gt;&lt;/p_city_name&gt;
&lt;st&gt;&lt;/st&gt;
&lt;z5&gt;&lt;/z5&gt;	
&lt;zip4&gt;&lt;/zip4&gt;
&lt;county_name&gt;&lt;/county_name&gt;
&lt;Filler1&gt;&lt;/Filler1&gt;
&lt;Gender&gt;&lt;/Gender&gt;
&lt;DL_Number&gt;&lt;/DL_Number&gt;
&lt;DL_State&gt;&lt;/DL_State&gt;
&lt;VEH_Plate&gt;&lt;/VEH_Plate &gt;
&lt;VEH_State&gt;&lt;/VEH_State &gt;
&lt;FBI_Num&gt;&lt;/FBI_Num&gt; 
&lt;State_Crim_Num&gt;&lt;/State_Crim_Num&gt;
&lt;Relative_Last_Name&gt;&lt;/Relative_Last_Name&gt;
&lt;Relative_First_Name&gt;&lt;/Relative_First_Name&gt;
&lt;LexID_Suppression_1&gt;&lt;/LexID_Suppression_1&gt;
&lt;LexID_Suppression_2&gt;&lt;/LexID_Suppression_2&gt;
&lt;Dedupe_Address_1&gt;&lt;/Dedupe_Address_1&gt;
&lt;Dedupe_City_1&gt;&lt;/Dedupe_City_1&gt;  
&lt;Dedupe_State_1&gt;&lt;/Dedupe_State_1&gt; 
&lt;Dedupe_Zip_1&gt;&lt;/Dedupe_Zip_1&gt;   
&lt;Dedupe_Address_2&gt;&lt;/Dedupe_Address_2&gt;
&lt;Dedupe_City_2&gt;&lt;/Dedupe_City_2&gt; 
&lt;Dedupe_State_2&gt;&lt;/Dedupe_State_2&gt; 
&lt;Dedupe_Zip_2&gt;&lt;/Dedupe_Zip_2&gt;   
&lt;/Row&gt;
&lt;/batchInt&gt; </pre>
 */

IMPORT AutoStandardI, Autokey_batch, BatchShare, BatchServices, Doxie, header, Suppress;

EXPORT EROBatchService := MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		boolean useCannedRecs := false;
	 
	  //Defaults to use
		#stored('SSNTypos',TRUE);
		#stored('IncludeNonDMVSources',TRUE);
		boolean GetSSNBest := TRUE  : STORED('GetSSNBest');
		
  	ds_xml_in_raw  	:= DATASET([], ERO_Services.Layouts.BatchIn) : STORED('batch_in', FEW);
		ds_xml_in 			:= if( useCannedRecs, ERO_Services.BatchCannedInput, ds_xml_in_raw);					

		BatchShare.MAC_CapitalizeInput(ds_xml_in, ds_xml_in_cap);
			 //Parse both input dedup address components
		ERO_Services.Layouts.IntermediateData fillDedupParsed(ds_xml_in_cap l) := transform
			citystzip1  := Address.Addr2FromComponents(l.Dedupe_City_1, l.Dedupe_State_1, l.Dedupe_Zip_1);
			citystzip2	:= Address.Addr2FromComponents(l.Dedupe_City_2, l.Dedupe_State_2, l.Dedupe_Zip_2);
			clean_addr1	:= address.GetCleanAddress(l.Dedupe_Address_1,citystzip1,address.Components.country.US);
			addr1				:= clean_addr1.results;
			clean_addr2 := address.GetCleanAddress(l.Dedupe_Address_2,citystzip2,address.Components.country.US);
			addr2				:= clean_addr2.results;
			self.dedupprim_range1 := addr1.prim_range;
			self.dedupprim_name1 := addr1.prim_name;
			self.dedupzip1 := l.Dedupe_Zip_1;
			self.dedupprim_range2 := addr2.prim_range ;
			self.dedupprim_name2 := addr2.prim_name;
			self.dedupzip2 := l.Dedupe_Zip_2;
			self.input_raw_City := l.p_city_name ;
			self.input_raw_St := l.st;
			self.input_raw_zip :=  l.z5;
			self := l;
		end;
		ds_xml_in_saved_csz := project(ds_xml_in_cap, fillDedupParsed(left));
    BatchShare.MAC_SequenceInput(ds_xml_in_saved_csz, ds_xml_in_seq);				
		BatchShare.MAC_CleanAddresses(ds_xml_in_seq, ds_batch_in_addr);

	 	//remove NO NAME in first and last name fields
		ds_xml_in_seq  removeNoName(ds_batch_in_addr l) := transform
		  fNoName := l.name_first[1..7] = ERO_Services.Constants.NameWords.NONAME;
			lNoName := l.name_last[1..7] = ERO_Services.Constants.NameWords.NONAME;
			self.name_first :=  if (fNoName,'',l.name_first);
			self.name_last := if(lNoName, '',l.name_last);
			self := l;
		end;
    ds_batch_in := project(ds_batch_in_addr, removeNoName(LEFT));
    
		//get output results

  	ds_recs_out := ERO_Services.BatchRecords(ds_batch_in,,GetSSNBest);

		// restore orignal acctno
		BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_recs_out, ds_recs_ready)		
    
		// restrictions for LE=Law Enforcement
		Suppress.MAC_Suppress(ds_recs_ready,	ds_recs_sup_1, 'LE',,,Suppress.Constants.LinkTypes.DID, did);			
		Suppress.MAC_Suppress(ds_recs_sup_1,ds_recs_sup_2, 'LE',,,Suppress.Constants.LinkTypes.SSN, subject_ssn);			
    
		// sort results, converted to integer because string numbers don't sort correctly.  1, 10, 2 ,20..etc.
	  results	:= sort(ds_recs_sup_2, (integer)acctno, (integer)did);
		output(results, named('Results'));

ENDMACRO;	
