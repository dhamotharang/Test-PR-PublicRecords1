/*--SOAP--
<message name="Image_DateRange">
	<part name="state" type="xsd:string">
        <html>
          <td width="25%"><font face="Verdana" size="2">States:</font></td>
          <td><font face="Verdana" size="2">
            <select name="states">
                        <Option value=""></Option>
                        <Option value="AL">ALABAMA</Option>
                        <Option value="AK">ALASKA</Option>
                        <Option value="AZ">ARIZONA</Option>
                        <Option value="AR">ARKANSAS</Option>
                        <Option value="CA">CALIFORNIA</Option>
                        <Option value="CO">COLORADO</Option>
                        <Option value="CT">CONNECTICUT</Option>
                        <Option value="DE">DELAWARE</Option>
                        <Option value="FL">FLORIDA</Option>
                        <Option value="GA">GEORGIA</Option>
                        <Option value="HI">HAWAII</Option>
                        <Option value="ID">IDAHO</Option>
                        <Option value="IL">ILLINOIS</Option>
                        <Option value="IN">INDIANA</Option>
                        <Option value="IA">IOWA</Option>
                        <Option value="KS">KANSAS</Option>
                        <Option value="KY">KENTUCKY</Option>
                        <Option value="LA">LOUISIANA</Option>
                        <Option value="ME">MAINE</Option>
                        <Option value="MD">MARYLAND</Option>
                        <Option value="MA">MASSACHUSETTS</Option>
                        <Option value="MI">MICHIGAN</Option>
                        <Option value="MN">MINNESOTA</Option>
                        <Option value="MS">MISSISSIPPI</Option>
                        <Option value="MO">MISSOURI</Option>
                        <Option value="MT">MONTANA</Option>
                        <Option value="NE">NEBRASKA</Option>
                        <Option value="NV">NEVADA</Option>
                        <Option value="NH">NEW HAMPSHIRE</Option>
                        <Option value="NJ">NEW JERSEY</Option>
                        <Option value="NM">NEW MEXICO</Option>
                        <Option value="NY">NEW YORK</Option>
                        <Option value="NC">NORTH CAROLINA</Option>
                        <Option value="ND">NORTH DAKOTA</Option>
                        <Option value="OH">OHIO</Option>
                        <Option value="OK">OKLAHOMA</Option>
                        <Option value="OR">OREGON</Option>
                        <Option value="PA">PENNSYLVANIA</Option>
                        <Option value="RI">RHODE ISLAND</Option>
                        <Option value="SC">SOUTH CAROLINA</Option>
                        <Option value="SD">SOUTH DAKOTA</Option>
                        <Option value="TN">TENNESSEE</Option>
                        <Option value="TX">TEXAS</Option>
                        <Option value="UT">UTAH</Option>
                        <Option value="VT">VERMONT</Option>
                        <Option value="VA">VIRGINIA</Option>
                        <Option value="WA">WASHINGTON</Option>
                        <Option value="WV">WEST VIRGINIA</Option>
                        <Option value="WI">WISCONSIN</Option>
                        <Option value="WY">WYOMING</Option>
                </select>                              
           </font></td>
        </html>
	</part>
	<part name="rtype" type="xsd:string"/>
	<part name="id" type="xsd:string"/>
	<part name="did" type="xsd:string"/>
	<part name="dids" type="tns:EspStringArray"/>
	<part name="didData" type="tns:XmlDataSet"/>
	<part name="b_date" type="xsd:string"/>
	<part name="e_date" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="NeighborService" type="tns:EspStringArray"/>
	<part name="NeighborData" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="IsANeighbor" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Image Date Range
*/
export Image_DateRange := MACRO

output(Images.Image_Records, NAMED('results'))

ENDMACRO;