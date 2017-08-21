IMPORT BIPV2_BlockLink,BIPV2_FindLinks;
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
aa:=BIPV2_FindLinks.VisualLinking_ProxId(58797373, '20160722');//proxid and build version as inputs.
aa;