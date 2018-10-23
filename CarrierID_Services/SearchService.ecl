
/*--SOAP--
<message name="SearchService" wuTimeout="300000">
 <separator />  
  <part name="DID"                 type="xsd:string"/>  
  <part name="FirstName"           type="xsd:string"/>
  <part name="AllowNickNames"      type="xsd:boolean"/>
  <part name="LastName"            type="xsd:string"/>
  <part name="MiddleName"          type="xsd:string"/>
  <part name="SSN"                 type="xsd:string"/>
  <part name="DOB"                 type="xsd:integer"/>
  <part name="DriverLicenseNumber" type="xsd:string"/>
  <part name="DriverLicenseState"  type="xsd:string"/>
  <part name="Addr"                type="xsd:string"/>
  <part name="City"                type="xsd:string"/>
  <part name="State"               type="xsd:string"/>
  <part name="Zip"                 type="xsd:string"/>
 <separator />
  <part name="VIN"                 type="xsd:string"/>
  <part name="DateOfLoss"          type="xsd:string"/>
  <part name="AccidentNumber"      type="xsd:string"/>
 <separator />
  <part name="StartingRecord"      type="xsd:unsignedInt"/>
  <part name="ReturnCount"         type="xsd:unsignedInt"/>
  <part name="MaxResults"          type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime"  type="xsd:unsignedInt"/>
  <part name="SkipRecords"         type="xsd:unsignedInt"/>
  <part name="DPPAPurpose"         type="xsd:byte"/>
  <part name="GLBPurpose"          type="xsd:byte"/> 
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
  
  <part name="CarrierIDSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Searches Against the CarrierID Search Service*/
/*--HELP-- 
<pre>
&lt;CarrierIDSearchRequest&gt;
 &lt;Row&gt;
   &lt;User&gt;
    &lt;GLBPurpose&gt;1&lt;/GLBPurpose&gt;
    &lt;DLPurpose&gt;1&lt;/DLPurpose&gt;
   &lt;/User&gt;
  &lt;Options&gt;
   &lt;StartingRecord&gt;&lt;/StartingRecord&gt;
   &lt;ReturnCount&gt;&lt;/ReturnCount&gt;
  &lt;/Options&gt;	 
   &lt;SearchBy&gt;
     &lt;VIN&gt;&lt;/VIN&gt;
     &lt;DateOfLoss&gt;  
       &lt;Year&gt;&lt;/Year&gt;
       &lt;Month&gt;&lt;/Month&gt;
       &lt;Day&gt;&lt;/Day&gt;
     &lt;/DateOfLoss&gt;
     &lt;AccidentNumber&gt;&lt;/AccidentNumber&gt;
     &lt;DID&gt;&lt;/DID&gt;
     &lt;Name&gt; 
       &lt;Full&gt;&lt;/Full&gt; 
     	 &lt;First&gt;&lt;/First&gt; 
     	 &lt;Middle&gt;&lt;/Middle&gt; 
     	 &lt;Last&gt;&lt;/Last&gt;
     	 &lt;Suffix&gt;&lt;/Suffix&gt;
       &lt;Prefix&gt;&lt;/Prefix&gt;
     &lt;/Name&gt;
     &lt;SSN&gt;&lt;/SSN&gt;
     &lt;DOB&gt;
       &lt;Year&gt;&lt;/Year&gt;
       &lt;Month&gt;&lt;/Month&gt;
       &lt;Day&gt;&lt;/Day&gt;
     &lt;/DOB&gt;
     &lt;Address&gt; 
       &lt;StreetName&gt;&lt;/StreetName&gt;
     	 &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
     	 &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
     	 &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
     	 &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
     	 &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
     	 &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
     	 &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
     	 &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
     	 &lt;State&gt;&lt;/State&gt;
     	 &lt;City&gt;&lt;/City&gt;
     	 &lt;Zip5&gt;&lt;/Zip5&gt;
     	 &lt;Zip4&gt;&lt;/Zip4&gt;
     	 &lt;County&gt;&lt;/County&gt;
     	 &lt;PostalCode&gt;&lt;/PostalCode&gt;
	     &lt;StateCityZip&gt;&lt;/StateCityZip&gt;
     &lt;/Address&gt; 
   &lt;/SearchBy&gt;
 &lt;/Row&gt;
&lt;/CarrierIDSearchRequest&gt;
</pre>
*/

import AutoStandardI,iesp,ut, Address;
export SearchService := macro
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		#stored('PhoneticMatch','true');

    //get xml input 
    rec_in    := iesp.carrierid.t_CarrierIDSearchRequest;
    ds_in     := dataset([],rec_in) : stored ('CarrierIDSearchRequest', FEW);
    first_row := ds_in[1] : independent;

    //set options
    iesp.ECL2ESP.SetInputBaseRequest(first_row);
    Search_opt := global(first_row.Options);

    //set search criteria
    search_by 			 := global(first_row.searchBy);
		
		//Clean Input:
		iesp.bpsreport.t_BpsReportBy xformCleanInput(iesp.carrierid.t_CarrierIDSearchBy aInputData) := transform
				/* --- ADDRESS INFORMATION --- */
				addr1			 								:= map(aInputData.Address.StreetAddress1 <> '' => aInputData.Address.StreetAddress1,
																				Address.Addr1FromComponents(aInputData.Address.StreetNumber, aInputData.Address.StreetPreDirection, aInputData.Address.StreetName,
		                                     aInputData.Address.StreetSuffix, aInputData.Address.StreetPostDirection, 
																				 '', aInputData.Address.UnitNumber));
																				 
				addr2 										:= map(aInputData.Address.StateCityZip <> '' => aInputData.Address.StateCityZip,
																				Address.Addr2FromComponents(aInputData.Address.City, aInputData.Address.State, aInputData.Address.Zip5));
				
				clean_addr 								:= address.GetCleanAddress(addr1, addr2, address.Components.Country.US);
				ca												:= clean_addr.results;
				
				self.Address := iesp.ECL2ESP.SetAddress (
															ca.prim_name, ca.prim_range, ca.predir, ca.postdir, ca.suffix, ca.unit_desig, ca.sec_range,
															ca.p_city, ca.state, ca.zip, ca.zip4, ca.county, '',
															Address.Addr1FromComponents(ca.prim_range, ca.predir, ca.prim_name, ca.suffix, ca.postdir, ca.unit_desig, ca.sec_range),
															'',
															Address.Addr2FromComponents(ca.p_city, ca.state, ca.zip));	

				self := aInputData;
				self := [];
		end;
		
		reportby_clean := row(search_by, xformCleanInput(left));
		
		#stored('VIN',                stringlib.stringtouppercase(search_by.VIN));
		#stored('DriverLicenseNumber',stringlib.stringtouppercase(search_by.DriverLicenseNumber));
		#stored('DriverLicenseState', stringlib.stringtouppercase(search_by.DriverLicenseState));
		#stored('DateOfLoss',         if(search_by.dateofloss.year>0,(string)search_by.DateOfLoss.Year+(intformat(search_by.DateOfLoss.Month,2,1))+(intformat(search_by.DateOfLoss.Day,2,1)),''));			
		
		iesp.ECL2ESP.SetInputReportBy(reportby_clean);
		iesp.ECL2ESP.Marshall.Mac_Set(Search_opt);
			
    tempmod := module(project(AutoStandardI.GlobalModule(), 
        CarrierID_Services.IParam.searchrecords,opt));
        export string   AccidentNumber_raw  :='' : stored('AccidentNumber');
				export string   AccidentNumber 			    := stringlib.stringfilter(stringlib.stringtouppercase(AccidentNumber_raw),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
				export string   DateOfLoss          :='' : stored('DateOfLoss');
				export string30 VIN 			          :='' : stored('VIN');
				export string24 DriverLicenseNumber :='' : stored('DriverLicenseNumber');
				export string2  DriverLicenseState  :='' : stored('DriverLicenseState');
				export boolean  IsDeepDive          := true;
    end;

		recs := CarrierID_Services.Records(tempmod);
	
    iesp.carrierid.t_CarrierIDSearchResponse marshall() := transform	
		  self._Header                   := row([],iesp.share.t_ResponseHeader);
			self.recap.vin                 := tempmod.vin;
			//not recognizing the namesuffix global
			self.recap.name                := iesp.ecl2esp.setnameandcompany(tempmod.firstname,tempmod.middlename,tempmod.lastname,'','','','');
			//we want to echo the user input and not the clean address per Product
			self.recap.address             := search_by.address;
			self.recap.ssn                 := tempmod.ssn;
			self.recap.dob                 := iesp.ecl2esp.toDatestring8((string)tempmod.dob);
			self.recap.driverlicensenumber := tempmod.driverlicensenumber;
			self.recap.driverlicensestate  := tempmod.driverlicensestate;
			self.recap.dateofloss          := iesp.ecl2esp.toDatestring8((string)tempmod.dateofloss);
      self.RecordCount               := count(recs);
			self.LegalDisclaim             := '';
			self.records                   := recs;
		end;
		
    results := dataset([marshall()]);
		output(results,named('Results'));
ENDMACRO;
// carrierid_services.searchservice();