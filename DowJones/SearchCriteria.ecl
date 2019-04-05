EXPORT SearchCriteria := MODULE

export unicode Common := 
		 '<group id="4" name="Entity Type">' +
     '<value id="1" name="Politically Exposed Person" />\r\n' +
     '<value id="2" name="Relative or Close Associate" />\r\n' +
     '<value id="4" name="Special Interest Entity" />\r\n' +
     '<value id="3" name="Special Interest Person" />\r\n' +
    '</group>\r\n' +
    '<group id="2" name="Current Occupation">\r\n' +
     '<value id="99" name="No Value" />\r\n' +
     '<value id="18" name="City Mayors" />\r\n' +
     '<value id="6" name="Embassy and Consular Staff" />\r\n' +
     '<value id="1" name="Heads and Deputies State/National Government" />\r\n' +
     '<value id="13" name="Heads and Deputy Heads of Regional Government" />\r\n' +
     '<value id="17" name="International Organization Officials" />\r\n' +
     '<value id="26" name="International Sporting Organisation Officials" />\r\n' +
     '<value id="22" name="Local Public Officials" />\r\n' +
     '<value id="3" name="Members of the National Legislature" />\r\n' +
     '<value id="2" name="National Government Ministers" />\r\n' +
     '<value id="21" name="National NGO Officials" />\r\n' +
     '<value id="20" name="Other" />\r\n' +
     '<value id="16" name="Political Party Officials" />\r\n' +
     '<value id="19" name="Political Pressure and Labour Group Officials" />\r\n' +
     '<value id="14" name="Regional Government Ministers" />\r\n' +
     '<value id="15" name="Religious Leaders" />\r\n' +
     '<value id="4" name="Senior Civil Servants-National Government" />\r\n' +
     '<value id="5" name="Senior Civil Servants-Regional Government" />\r\n' +
     '<value id="7" name="Senior Members of the Armed Forces" />\r\n' +
     '<value id="10" name="Senior Members of the Judiciary" />\r\n' +
     '<value id="8" name="Senior Members of the Police Services" />\r\n' +
     '<value id="9" name="Senior Members of the Secret Services" />\r\n' +
     '<value id="12" name="State Agency Officials" />\r\n' +
     '<value id="11" name="State Corporation Executives" />\r\n' +
    '</group>\r\n' +
    '<group id="5" name="Special Interest Type">\r\n' +
     '<value id="99" name="No Value" />\r\n' +
     '<value id="10" name="Additional Domestic Screening Requirement" />\r\n' +
     '<value id="1" name="Associated Entity" x="1" />\r\n' +
     '<value id="2" name="Corruption" />\r\n' +
     '<value id="12" name="Enhanced Country Risk" />\r\n' +
     '<value id="3" name="Financial Crime" />\r\n' +
     '<value id="4" name="Organized Crime" />\r\n' +
     '<value id="11" name="Organized Crime Japan" />\r\n' +
     '<value id="5" name="Other Official Lists" />\r\n' +
		 '<value id="34" name="Sanctions Control and Ownership" />\r\n' + //Bug 20372
		 $.SearchCriteria3.Sanctions[1].criterion +
     '<value id="6" name="Sanctions Lists" />\r\n' +
		 '<value id="13" name="Tax Crime" />\r\n' + // Bug: 156981     
		 '<value id="7" name="Terror" />\r\n' +
     '<value id="8" name="Trafficking" />\r\n' +
     '<value id="9" name="War Crimes" />\r\n' +
     '</group>\r\n' +
    '<group id="1" name="Deceased State">\r\n' +
     '<value id="9" name="No Value" />\r\n' +
     '<value id="2" name="Alive" />\r\n' +
     '<value id="1" name="Deceased" />\r\n' + 
     '</group>\r\n' +
		'<group id="3" name="Active Status">\r\n' +
     '<value id="9" name="No Value" />\r\n' +
		 '<value id="1" name="Active" />\r\n' + 
     '<value id="2" name="Inactive" />\r\n' +
     '</group>\r\n' +
		
		BuildSourceCriteria;
		 
// geographical seaches
// Middle East me
unicode CriteriaME :=		
  U'<group id="6" name="Country">'+
     '<value id="2" name="Afghanistan" />'+
     '<value id="11" name="Armenia" />'+
     '<value id="15" name="Azerbaijan" />'+
     '<value id="17" name="Bahrain" />'+
     '<value id="54" name="Cyprus" />'+
     '<value id="98" name="Iran" />'+
     '<value id="99" name="Iraq" />'+
     '<value id="101" name="Israel" />'+
     '<value id="105" name="Jordan" />'+
     '<value id="112" name="Kuwait" />'+
     '<value id="110" name="Kyrgyzstan" />'+
     '<value id="115" name="Lebanon" />'+
     '<value id="160" name="Oman" />'+
     '<value id="161" name="Pakistan" />'+
     '<value id="163" name="Palestine" />'+
     '<value id="174" name="Qatar" />'+
     '<value id="179" name="Saudi Arabia" />'+
     '<value id="207" name="Syria" />'+
     '<value id="208" name="Tajikistan" />'+
     '<value id="221" name="Turkey" />'+
     '<value id="252" name="Turkish Republic of Northern Cyprus" />'+
     '<value id="222" name="Turkmenistan" />'+
     '<value id="224" name="United Arab Emirates" />'+
     '<value id="231" name="Uzbekistan" />'+
     '<value id="239" name="Yemen" />'+
     '</group>\r\n';
		 
// Africa afr
unicode CriteriaAFR :=	
		U'<group id="6" name="Country">' +
		U'<value id="4" name="Algeria" /><value id="7" name="Angola" /><value id="22" name="Benin" /><value id="27" name="Botswana" /><value id="28" name="Bouvet Island" /><value id="228" name="Burkina Faso" /><value id="34" name="Burundi" /><value id="38" name="Cameroon" /><value id="53" name="Cape Verde" /><value id="37" name="Central African Republic" /><value id="41" name="Chad" /><value id="47" name="Comoros" /><value id="48" name="Congo Republic" /><value id="95" name="Cote d\'Ivoire" /><value id="241" name="Democratic Republic of the Congo" /><value id="209" name="Djibouti" /><value id="60" name="Egypt" /><value id="62" name="Equatorial Guinea" /><value id="63" name="Eritrea" /><value id="204" name="Eswatini" /><value id="65" name="Ethiopia" /><value id="74" name="Gabon" /><value id="75" name="Gambia" /><value id="77" name="Ghana" /><value id="87" name="Guinea" /><value id="86" name="Guinea-Bissau" /><value id="108" name="Kenya" /><value id="116" name="Lesotho" /><value id="117" name="Liberia" /><value id="118" name="Libya" /><value id="124" name="Madagascar" /><value id="125" name="Malawi" /><value id="128" name="Mali" /><value id="131" name="Mauritania" /><value id="133" name="Mayotte" /><value id="141" name="Morocco" /><value id="142" name="Mozambique" /><value id="143" name="Namibia" /><value id="151" name="Niger" /><value id="150" name="Nigeria" /><value id="175" name="Reunion" /><value id="178" name="Rwanda" /><value id="197" name="Saint Helena" /><value id="172" name="Sao Tome and Principe" /><value id="181" name="Senegal" /><value id="182" name="Seychelles" /><value id="184" name="Sierra Leone" /><value id="193" name="Somalia" /><value id="180" name="South Africa" /><value id="253" name="South Sudan" /><value id="200" name="Sudan" /><value id="211" name="Tanzania" /><value id="216" name="Togo" /><value id="220" name="Tunisia" /><value id="225" name="Uganda" /><value id="195" name="Western Sahara" /><value id="242" name="Zambia" /><value id="243" name="Zimbabwe" /></group>\r\n';
// Asia asia
unicode CriteriaASIA :=	
		U'<group id="6" name="Country">' +
		U'<value id="5" name="American Samoa" /><value id="1" name="Antarctica" /><value id="14" name="Australia" /><value id="18" name="Bangladesh" /><value id="24" name="Bhutan" /><value id="25" name="British Indian Ocean Territory" /><value id="30" name="Brunei" /><value id="106" name="Cambodia" /><value id="43" name="China" /><value id="44" name="Christmas Island" /><value id="45" name="Cocos (Keeling) Islands" /><value id="49" name="Cook Islands" /><value id="70" name="Fiji" /><value id="72" name="French Polynesia" /><value id="84" name="Guam" /><value id="90" name="Heard and McDonald Islands" /><value id="91" name="Hong Kong" /><value id="96" name="India" /><value id="97" name="Indonesia" /><value id="104" name="Japan" /><value id="107" name="Kazakhstan" /><value id="109" name="Kiribati" /><value id="113" name="Laos" /><value id="122" name="Macau" /><value id="126" name="Malaysia" /><value id="127" name="Maldives" /><value id="123" name="Marshall Islands" /><value id="132" name="Mauritius" /><value id="68" name="Micronesia" /><value id="139" name="Mongolia" /><value id="33" name="Myanmar" /><value id="145" name="Nauru" /><value id="146" name="Nepal" /><value id="148" name="New Caledonia" /><value id="159" name="New Zealand" /><value id="152" name="Niue" /><value id="156" name="Norfolk Island" /><value id="153" name="North Korea" /><value id="154" name="Northern Mariana Islands" /><value id="162" name="Palau" /><value id="165" name="Papua New Guinea" /><value id="168" name="Philippines" /><value id="169" name="Pitcairn" /><value id="238" name="Samoa" /><value id="185" name="Singapore" /><value id="192" name="Solomon Islands" /><value id="183" name="South Georgia and South Sandwich Islands" /><value id="187" name="South Korea" /><value id="196" name="Sri Lanka" /><value id="210" name="Taiwan" /><value id="213" name="Thailand" /><value id="214" name="Tibet" x="1" /><value id="215" name="Timor Leste" /><value id="217" name="Tokelau" /><value id="218" name="Tonga" /><value id="223" name="Tuvalu" /><value id="232" name="Vanuatu" /><value id="236" name="Vietnam" /><value id="237" name="Wallis and Futuna Islands" /></group>\r\n';
		
// Canada can
unicode CriteriaCANADA :=	
		U'';
		
// Europe europe
unicode CriteriaEUROPE :=	
		U'<group id="6" name="Country"><value id="251" name="Abkhazia" /><value id="3" name="Albania" /><value id="6" name="Andorra" /><value id="13" name="Austria" /><value id="36" name="Belarus" /><value id="20" name="Belgium" /><value id="31" name="Bosnia and Herzegovina" /><value id="32" name="Bulgaria" /><value id="51" name="Croatia" /><value id="55" name="Czech Republic" /><value id="56" name="Denmark" /><value id="64" name="Estonia" /><value id="66" name="Faeroe Islands" /><value id="71" name="Finland" /><value id="73" name="France" /><value id="82" name="Georgia" /><value id="76" name="Germany" /><value id="78" name="Gibraltar" /><value id="79" name="Greece" /><value id="246" name="Guernsey" /><value id="93" name="Hungary" /><value id="94" name="Iceland" /><value id="100" name="Ireland" /><value id="248" name="Isle of Man" /><value id="102" name="Italy" /><value id="247" name="Jersey" /><value id="111" name="Kosovo" /><value id="114" name="Latvia" /><value id="119" name="Liechtenstein" /><value id="120" name="Lithuania" /><value id="121" name="Luxembourg" /><value id="134" name="Macedonia" /><value id="129" name="Malta" /><value id="137" name="Moldova" /><value id="138" name="Monaco" /><value id="136" name="Montenegro" /><value id="147" name="Netherlands" /><value id="157" name="Norway" /><value id="170" name="Poland" /><value id="171" name="Portugal" /><value id="176" name="Romania" /><value id="177" name="Russia" /><value id="191" name="San Marino" /><value id="240" name="Serbia" /><value id="189" name="Slovakia" /><value id="190" name="Slovenia" /><value id="250" name="South Ossetia" /><value id="194" name="Spain" /><value id="202" name="Svalbard and Jan Mayen Islands" /><value id="205" name="Sweden" /><value id="206" name="Switzerland" /><value id="227" name="Ukraine" /><value id="226" name="United Kingdom" /><value id="233" name="Vatican City" /></group>\r\n';
		
// North America na
unicode CriteriaNA :=	
		U'<group id="6" name="Country"><value id="8" name="Anguilla" /><value id="9" name="Antigua and Barbuda" /><value id="12" name="Aruba" /><value id="16" name="Bahamas" /><value id="19" name="Barbados" /><value id="21" name="Belize" /><value id="23" name="Bermuda" /><value id="35" name="British Virgin Islands" /><value id="40" name="Cayman Islands" /><value id="50" name="Costa Rica" /><value id="52" name="Cuba" /><value id="57" name="Dominica" /><value id="58" name="Dominican Republic" /><value id="61" name="El Salvador" /><value id="80" name="Greenland" /><value id="81" name="Grenada" /><value id="83" name="Guadeloupe" /><value id="85" name="Guatemala" /><value id="89" name="Haiti" /><value id="92" name="Honduras" /><value id="103" name="Jamaica" /><value id="130" name="Martinique" /><value id="135" name="Mexico" /><value id="140" name="Montserrat" /><value id="144" name="Netherlands Antilles - Curaçao" /><value id="149" name="Nicaragua" /><value id="164" name="Panama" /><value id="173" name="Puerto Rico" /><value id="186" name="Saint Kitts and Nevis" /><value id="188" name="Saint Lucia" /><value id="245" name="Saint Barthelemy" /><value id="249" name="Saint Maarten" /><value id="198" name="Saint Martin" /><value id="199" name="Saint Pierre and Miquelon" /><value id="203" name="Saint Vincent and the Grenadines" /><value id="219" name="Trinidad and Tobago" /><value id="212" name="Turks and Caicos Islands" /><value id="235" name="US Virgin Islands" /></group>\r\n';
		
// South America sa
unicode CriteriaSA :=	
		U'<group id="6" name="Country"><value id="10" name="Argentina" /><value id="26" name="Bolivia" /><value id="29" name="Brazil" /><value id="42" name="Chile" /><value id="46" name="Colombia" /><value id="59" name="Ecuador" /><value id="67" name="Falkland Islands" /><value id="69" name="French Guiana" /><value id="88" name="Guyana" /><value id="166" name="Paraguay" /><value id="167" name="Peru" /><value id="201" name="Suriname" /><value id="229" name="Uruguay" /><value id="234" name="Venezuela" /></group>\r\n';
		
// Unknown UNK
unicode CriteriaUNK :=	
		U'<group id="6" name="Country"><value id="158" name="Not Known" /></group>\r\n';

// unk usa not used
	export unicode CriteriaCountries(string region) := CASE(region,
'COUNTRY_GROUP_AFR'						=> CriteriaAfr,
'COUNTRY_GROUP_ASIA'							=> CriteriaAsia,
'COUNTRY_GROUP_CANADA'						=> CriteriaCanada,
'COUNTRY_GROUP_EURO'						=> CriteriaEurope,
'COUNTRY_GROUP_ME'				=> CriteriaME,
'COUNTRY_GROUP_NA'			=> CriteriaNA,
'COUNTRY_GROUP_SA'			=> CriteriaSA,
'COUNTRY_GROUP_UNK'						=> '',//Production
//'COUNTRY_GROUP_UNK'						=> CriteriaUNK,//Test
'COUNTRY_GROUP_USA'								=> '',
	'');

END;