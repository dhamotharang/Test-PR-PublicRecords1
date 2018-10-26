//---------------------------------------------------------------------------
// NOTE: THE GRAPHICS PACKAGE USD BY D3 IS *NOT* COMPATIBLE WITH INTERNET
// EXPLORER.  RESULTS FROM THESE EXAMPLES MUST BE VIEWED IN ANOTHER BROWSER
// SUCH AS CHROME OR FIREFOX.
//---------------------------------------------------------------------------
IMPORT BIPV2_BlockLink;
prox_base:=BIPV2_Blocklink.ManualOverlinksPROXID.reducedlayout;
/*--RESULT--
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="yes"/>
  
  <xsl:template match="Dataset[starts-with(@name,'CHART_')]" mode="generate_body">
    <xsl:for-each select="Row[chartelementtype='CHARTCODE']">
      <xsl:value-of disable-output-escaping="yes" select="s"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="node()/Results/Result"/>
  </xsl:template>

  <xsl:template match="Result">
    <xsl:apply-templates select="Dataset" mode="generate_body"/>
  </xsl:template>

  <xsl:template match="text()"/>
</xsl:stylesheet>
*/

// Fictitious Family tree relationship data
dRelatives:=DATASET([
  {58797373,'endding prox 58797373 in version 20160722 in iter 286',0,'1'},
  {163995359,'proxid 163995359-->58797373 in version 20160722 in iter 286',58797373,'2'},
  {164090720,'proxid 164090720-->163995359 in version 20160722 in iter 281',163995359,'3'},
  {165293188,'proxid 165293188-->163995359 in version 20160722 in iter 285',163995359,'3'},
  {191562726,'proxid 191562726-->58797373 in version 20160722 in iter 280',58797373,'2'},
  {539446930,'proxid 539446930-->164090720 in version 20160722 in iter 280',164090720,'4'},
  {787248771,'proxid 787248771-->58797373 in version 20160722 in iter 281',58797373,'2'}
],{UNSIGNED id;STRING name;UNSIGNED parent;STRING relationship;});

dDet:=dataset([
  {58797373,''},
  {163995359,'<table border=1><tr><td>rcid1</td><td>Left Company_name</td><td>IsMJ6?</td><td>Threshold</td></tr><tr><td>20159061890</td><td>MCLAGAN PARTNERS, INC.</td><td>false</td><td>30</td></tr><tr><td>rcid2</td><td>Right Company_name</td><td>attribute_conf</td><td>conf</td></tr><tr><td>95532281596</td><td>GE ASSET MANAGEMENT INCORPORATED</td><td>0</td><td>41</td></tr></table><table border=1><tr><td>field_name</td><td>field1</td><td>field2</td><td>score</td></tr><tr><td>cnp_name</td><td>MCLAGAN PARTNERS</td><td>GE ASSET MANAGEMENT</td><td>2580</td></tr><tr><td>prim_range</td><td>1600</td><td>1600</td><td>0</td></tr><tr><td>prim_name_derived</td><td>SUMMER</td><td>SUMMER</td><td>581</td></tr><tr><td>st</td><td>CT</td><td>CT</td><td>0</td></tr><tr><td>zip</td><td>06905</td><td>06905</td><td>0</td></tr><tr><td>company_phone</td><td>2033592878</td><td>2033262300</td><td>0</td></tr><tr><td>active_duns_number</td><td></td><td></td><td>-2574</td></tr><tr><td>company_fein</td><td>203378496</td><td>203378496</td><td>2580</td></tr><tr><td>sec_range</td><td></td><td></td><td>-591</td></tr><tr><td>v_city_name</td><td>STAMFORD</td><td>STAMFORD</td><td>0</td></tr><tr><td>company_csz</td><td>v_city_name:st:zip</td><td>v_city_name:st:zip</td><td>866</td></tr><tr><td>cnp_btype</td><td>INC</td><td>INC</td><td>215</td></tr></table>'},
  {164090720,'<table border=1><tr><td>rcid1</td><td>Left Company_name</td><td>IsMJ6?</td><td>Threshold</td></tr><tr><td>164090720</td><td>MCLAGAN PARTNERS INC</td><td>false</td><td>30</td></tr><tr><td>rcid2</td><td>Right Company_name</td><td>attribute_conf</td><td>conf</td></tr><tr><td>165395637</td><td>MCLAGAN PARTNERS ASIA INC</td><td>0</td><td>88</td></tr></table><table border=1><tr><td>field_name</td><td>field1</td><td>field2</td><td>score</td></tr><tr><td>cnp_name</td><td>MCLAGAN PARTNERS</td><td>MCLAGAN PARTNERS ASIA</td><td>853</td></tr><tr><td>prim_range</td><td>1600</td><td>1600</td><td>0</td></tr><tr><td>prim_name_derived</td><td>SUMMER</td><td>SUMMER</td><td>0</td></tr><tr><td>st</td><td>CT</td><td>CT</td><td>0</td></tr><tr><td>zip</td><td>06905</td><td>06905</td><td>0</td></tr><tr><td>company_phone</td><td>2033592879</td><td>2033592879</td><td>2606</td></tr><tr><td>active_duns_number</td><td>140868394</td><td>140868394</td><td>2638</td></tr><tr><td>sec_range</td><td>601</td><td>601</td><td>0</td></tr><tr><td>v_city_name</td><td>STAMFORD</td><td>STAMFORD</td><td>0</td></tr><tr><td>company_address</td><td>company_addr1:company_csz</td><td>company_addr1:company_csz</td><td>2521</td></tr><tr><td>cnp_btype</td><td>INC</td><td>INC</td><td>215</td></tr></table>'},
  {165293188,'<table border=1><tr><td>rcid1</td><td>Left Company_name</td><td>IsMJ6?</td><td>Threshold</td></tr><tr><td>165293188</td><td>MC LAGAN PARTNERS INC</td><td>false</td><td>30</td></tr><tr><td>rcid2</td><td>Right Company_name</td><td>attribute_conf</td><td>conf</td></tr><tr><td>165983289</td><td>MCLAGAN PARTNERS INC</td><td>0</td><td>75</td></tr></table><table border=1><tr><td>field_name</td><td>field1</td><td>field2</td><td>score</td></tr><tr><td>cnp_name</td><td>MC LAGAN PARTNERS</td><td>MCLAGAN PARTNERS</td><td>2334</td></tr><tr><td>prim_range</td><td>1600</td><td>1600</td><td>0</td></tr><tr><td>prim_name_derived</td><td>SUMMER</td><td>SUMMER</td><td>0</td></tr><tr><td>st</td><td>CT</td><td>CT</td><td>0</td></tr><tr><td>zip</td><td>06905</td><td>06905</td><td>0</td></tr><tr><td>company_phone</td><td>2033592878</td><td>2033592878</td><td>2447</td></tr><tr><td>active_duns_number</td><td></td><td>072144306</td><td>0</td></tr><tr><td>sec_range</td><td>601</td><td>601</td><td>0</td></tr><tr><td>v_city_name</td><td>STAMFORD</td><td>STAMFORD</td><td>0</td></tr><tr><td>company_address</td><td>company_addr1:company_csz</td><td>company_addr1:company_csz</td><td>2521</td></tr><tr><td>cnp_btype</td><td>INC</td><td>INC</td><td>215</td></tr></table>'},
  {191562726,'<table border=1><tr><td>rcid1</td><td>Left Company_name</td><td>IsMJ6?</td><td>Threshold</td></tr><tr><td>47793342575</td><td>GE INVESTMENTS</td><td>false</td><td>30</td></tr><tr><td>rcid2</td><td>Right Company_name</td><td>attribute_conf</td><td>conf</td></tr><tr><td>95532281596</td><td>GE ASSET MANAGEMENT INCORPORATED</td><td>0</td><td>125</td></tr></table><table border=1><tr><td>field_name</td><td>field1</td><td>field2</td><td>score</td></tr><tr><td>cnp_name</td><td>GE INVESTMENTS</td><td>GE ASSET MANAGEMENT</td><td>2638</td></tr><tr><td>prim_range</td><td>1600</td><td>1600</td><td>0</td></tr><tr><td>prim_name_derived</td><td>SUMMER</td><td>SUMMER</td><td>0</td></tr><tr><td>st</td><td>CT</td><td>CT</td><td>0</td></tr><tr><td>zip</td><td>06905</td><td>06905</td><td>0</td></tr><tr><td>company_phone</td><td>2033262300</td><td>2033262300</td><td>2219</td></tr><tr><td>active_duns_number</td><td>180031908</td><td></td><td>2638</td></tr><tr><td>company_fein</td><td></td><td>203378496</td><td>2580</td></tr><tr><td>sec_range</td><td>3</td><td></td><td>0</td></tr><tr><td>v_city_name</td><td>STAMFORD</td><td>STAMFORD</td><td>0</td></tr><tr><td>company_address</td><td>company_addr1:company_csz</td><td>company_addr1:company_csz</td><td>2521</td></tr><tr><td>cnp_btype</td><td></td><td>INC</td><td>0</td></tr></table>'},
  {539446930,'<table border=1><tr><td>rcid1</td><td>Left Company_name</td><td>IsMJ6?</td><td>Threshold</td></tr><tr><td>7004369800</td><td>TOASTMASTERS INTERNATIONAL</td><td>false</td><td>30</td></tr><tr><td>rcid2</td><td>Right Company_name</td><td>attribute_conf</td><td>conf</td></tr><tr><td>14880567104</td><td>MCLAGAN PARTNERS, INC.</td><td>0</td><td>95</td></tr></table><table border=1><tr><td>field_name</td><td>field1</td><td>field2</td><td>score</td></tr><tr><td>cnp_name</td><td>TOASTMASTERS INTERNATIONAL</td><td>MCLAGAN PARTNERS</td><td>2606</td></tr><tr><td>prim_range</td><td>1600</td><td>1600</td><td>0</td></tr><tr><td>prim_name_derived</td><td>SUMMER</td><td>SUMMER</td><td>573</td></tr><tr><td>st</td><td>CT</td><td>CT</td><td>0</td></tr><tr><td>zip</td><td>06905</td><td>06905</td><td>0</td></tr><tr><td>company_phone</td><td>2033592878</td><td>2033592878</td><td>2447</td></tr><tr><td>company_fein</td><td>208980366</td><td>208980366</td><td>2606</td></tr><tr><td>v_city_name</td><td>STAMFORD</td><td>STAMFORD</td><td>0</td></tr><tr><td>company_csz</td><td>v_city_name:st:zip</td><td>v_city_name:st:zip</td><td>836</td></tr><tr><td>cnp_btype</td><td></td><td>INC</td><td>0</td></tr></table>'},
  {787248771,'<table border=1><tr><td>rcid1</td><td>Left Company_name</td><td>IsMJ6?</td><td>Threshold</td></tr><tr><td>35715809751</td><td>GE INVESTMENT MANAGEMENT INCORPORATED</td><td>false</td><td>30</td></tr><tr><td>rcid2</td><td>Right Company_name</td><td>attribute_conf</td><td>conf</td></tr><tr><td>205154960</td><td>GE INVESTMENTS</td><td>0</td><td>51</td></tr></table><table border=1><tr><td>field_name</td><td>field1</td><td>field2</td><td>score</td></tr><tr><td>cnp_name</td><td>GE INVESTMENT MANAGEMENT</td><td>GE INVESTMENTS</td><td>1130</td></tr><tr><td>prim_range</td><td>1600</td><td>1600</td><td>0</td></tr><tr><td>prim_name_derived</td><td>SUMMER</td><td>SUMMER</td><td>594</td></tr><tr><td>st</td><td>CT</td><td>CT</td><td>0</td></tr><tr><td>zip</td><td>06905</td><td>06905</td><td>0</td></tr><tr><td>foreign_corp_key</td><td>48-0009249206</td><td></td><td>0</td></tr><tr><td>company_phone</td><td></td><td>2033262300</td><td>0</td></tr><tr><td>active_duns_number</td><td></td><td>180031908</td><td>0</td></tr><tr><td>company_fein</td><td></td><td></td><td>2468</td></tr><tr><td>sec_range</td><td></td><td>3</td><td>-451</td></tr><tr><td>v_city_name</td><td>STAMFORD</td><td>STAMFORD</td><td>0</td></tr><tr><td>company_csz</td><td>v_city_name:st:zip</td><td>v_city_name:st:zip</td><td>861</td></tr><tr><td>cnp_btype</td><td>INC</td><td></td><td>0</td></tr></table>'}
	],{UNSIGNED id;STRING det;});
	
overlink_reduced:=dataset([
{1, 58797373, 'GE ASSET MANAGEMENT', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'E6', '261180837', ' ', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'Q3', '', '2033262300', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '700186833', '', '', '', '', 'ER', '', '2033262300', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '700186833', '', '', '', '', 'ER', '', '2033262404', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'BC', '', '2033262473', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'U2', '', ' ', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '06-02345440', '', 'C,', '', ' ', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '09-0853304 ', '', 'C.', '', ' ', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'DN', '203378496', '2033262300', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'BC', '', '2033262473', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '830154568', '', '', '', '', '', '', '', '', 'D ', '', '2037083193', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06927', '', '', '', '', '', '', '', '06-02345440', '', 'C,', '', ' ', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', '3', 'STAMFORD', 'CT', '06905', '180031908', '', '', '', '', '', '', '', '', 'D ', '', '2033262300', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', '3', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'DN', '061238874', '2037083193', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', '3', 'STAMFORD', 'CT', '06905', '830154568', '', '', '', '', '', '', '', '', 'D ', '', '2037083193', true}, 
{1, 58797373, 'GE ASSET MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', '6', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '17-C-60580472', '', 'C4', '061238874', ' ', true}, 
{1, 58797373, 'GE INVESTMENT MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '48-0009249206', '', 'CN', '', ' ', true}, 
{1, 58797373, 'GE INVESTMENT MANAGEMENT', '', 'INC', '1600 ', 'SUMMER ', '6', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '17-C-60580472', '', 'C4', '061238874', ' ', true}, 
{1, 58797373, 'GE INVESTMENTS', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'DN', '203378496', '2033262300', true}, 
{1, 58797373, 'GE INVESTMENTS', '', ' ', '1600 ', 'SUMMER ', '3', 'STAMFORD', 'CT', '06905', '180031908', '', '', '', '', '', '', '', '', 'D ', '', '2033262300', true}, 
{1, 58797373, 'MC LAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'D ', '', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'U2', '', ' ', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'DN', '203378496', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'DN', '208980366', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '072144306', '', '', '', '', '', '', '', '', 'D ', '', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '1', 'STAMFORD', 'CT', '06905', '140868394', '', '', '', '', '', '', '', '', 'D ', '', '2033592879', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'Y ', '', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'DN', '362609607', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '', '', '1579483', '', '', '', '', '', '', 'DF', '', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '041944117', '', '', '', '', '', '', '', '', 'D ', '', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '072144306', '', '', '', '', '', '', '', '', 'D ', '', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'Y ', '', '2033592879', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '140868394', '', '', '', '', '', '', '', '', 'D ', '', '2033592879', true}, 
{1, 58797373, 'MCLAGAN PARTNERS', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '041944117', '', '', '', '', '', '', '', '', 'D ', '', '3123819700', true}, 
{1, 58797373, 'MCLAGAN PARTNERS ASIA', '', 'INC', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '140868394', '', '', '', '', '', '', '', '', 'D ', '', '2033592879', true}, 
{1, 58797373, 'MCLAGAN PARTNERS ASIA', '', 'INC', '1600 ', 'SUMMER ', '1', 'STAMFORD', 'CT', '06905', '140868394', '', '', '', '', '', '', '', '', 'D ', '', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS ASIA', '', 'INC', '1600 ', 'SUMMER ', '1', 'STAMFORD', 'CT', '06905', '140868394', '', '', '', '', '', '', '', '', 'D ', '', '2033592879', true}, 
{1, 58797373, 'MCLAGAN PARTNERS ASIA', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '140868394', '', '', '', '', '', '', '', '', 'D ', '', '2033592878', true}, 
{1, 58797373, 'MCLAGAN PARTNERS ASIA', '', 'INC', '1600 ', 'SUMMER ', '601', 'STAMFORD', 'CT', '06905', '140868394', '', '', '', '', '', '', '', '', 'D ', '', '2033592879', true}, 
{1, 58797373, 'TOASTMASTERS INTERNATIONAL', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'IN', '208980366', ' ', true}, 
{1, 58797373, 'TOASTMASTERS INTERNATIONAL', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'DN', '208980366', '2033262300', true}, 
{1, 58797373, 'TOASTMASTERS INTERNATIONAL', '', ' ', '1600 ', 'SUMMER ', ' ', 'STAMFORD', 'CT', '06905', '', '', '', '', '', '', '', '', '', 'DN', '208980366', '2033592878', true}
],prox_base);

dLabels:=PROJECT(dRelatives,TRANSFORM(BIPV2_BlockLink.Types.GraphLabels,SELF.label:=LEFT.name;SELF:=LEFT;));
dRelationships:=PROJECT(dRelatives,TRANSFORM(BIPV2_BlockLink.Types.GraphRelationships,SELF.id:=LEFT.parent;SELF.linkid:=LEFT.id;SELF.linklabel:=LEFT.relationship;));
BIPV2_BlockLink.D3.Graph('VerticalTree','VerticalTree','P',dLabels,dRelationships,dDet,overlink_reduced);
