/*--SOAP--
<message name="Address_Research">
	<part name="Zip" type="xsd:string"/>
	<part name="ResidenceType" type="xsd:string">
        <html>
          <td width="25%"><font face="Verdana" size="2">ResidenceType:</font></td>
          <td><font face="Verdana" size="2">
            <select name="ResidenceType">
                    <Option value="SML">Small Apt. Building</Option>
                    <Option value="MDM">Medium Apt. Building</Option>
                    <Option value="LGR">Large Apt. Building</Option>
            </select>                              
           </font></td>
        </html>
	</part>
	<part name="DateFrom" type="xsd:unsignedInt"/>
	<part name="DateTo" type="xsd:unsignedInt"/>
	<part name="MaxAddressCount" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the header address, then appends census and area code/exchanges info.*/

export Address_Research := MACRO

integer4 max_addr_val := 2000 : stored('MaxAddressCount');
   
out_raw := Header_Services.Address_Research_Records;
out_recs := sort(out_raw, if(prim_range<>'', 0, 1), prim_name, prim_range);

output(choosen(out_recs, max_addr_val), named('Results'));

ENDMACRO;

