/*--RESULT--
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:param name="firstRow" select="0"/>
	<xsl:param name="lastRow" select="0"/>
	<xsl:param name="showCount" select="1"/>
	<xsl:param name="countFG" select="'#DFEFFF'"/>
	<xsl:param name="countBG" select="'#0066CC'"/>
	<xsl:param name="showHeader" select="1"/>
	<xsl:param name="headerFG" select="'#DFEFFF'"/>
	<xsl:param name="headerBG" select="'#0066CC'"/>
	<xsl:param name="cellFG" select="'#000000'"/>
	<xsl:variable name="cellBG" select="'#DFEFFF'"/>
	<xsl:template match="/">
		<html>
		  <head>
			  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		  </head>
			<body>
				<xsl:for-each select="//Exception">
					Exception: <br/>
                    Reported by: <xsl:value-of select="Source"/><br/>
                    Message: <xsl:value-of select="Message"/><br/>
				</xsl:for-each>
				<xsl:for-each select="//Dataset">
					<xsl:for-each select="Row">
						<xsl:variable name="rowpos" select="position()"/>
						<xsl:if test="position()=1">
							<xsl:text disable-output-escaping="yes">&lt;table bordercolor="#0066CC" border="1" cellspacing="0" cellpadding="0" &gt;&lt;tr&gt;&lt;td &gt;&lt;table border="1" bordercolor="#0066CC" cellspacing="0" cellpadding="0" &gt;</xsl:text>
							  <xsl:if test="$showHeader=1">
								<tr>
									<xsl:if test="$showCount=1">
										<xsl:text disable-output-escaping="yes">&lt;td bgcolor="</xsl:text>
										<xsl:value-of select="$headerBG"/>
										<xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
										<font face="Verdana" size="2">&#160;</font>
										<xsl:text disable-output-escaping="yes">&lt;/td&gt;</xsl:text>
									</xsl:if>
									<xsl:for-each select="*">
										<xsl:text disable-output-escaping="yes">&lt;td align="center" bgcolor="</xsl:text>
										<xsl:value-of select="$headerBG"/>
										<xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
											<xsl:text disable-output-escaping="yes">&lt;font face="Verdana" size="2" color="</xsl:text>
											<xsl:value-of select="$headerFG"/>
											<xsl:text disable-output-escaping="yes">"&gt;&lt;b&gt;</xsl:text>
												<xsl:value-of select="name()"/>
											<xsl:text disable-output-escaping="yes">&lt;/b&gt;&lt;/font&gt;</xsl:text>
										<xsl:text disable-output-escaping="yes">&lt;/td&gt;</xsl:text>
									</xsl:for-each>
								</tr>
							  </xsl:if>
						</xsl:if>
						<xsl:if test="(position()>=$firstRow) and (($lastRow=0) or ($lastRow >= position()))">
							<tr>
								<xsl:if test="$showCount=1">
									<xsl:text disable-output-escaping="yes">&lt;td align="center" bgcolor="</xsl:text>
									<xsl:value-of select="$countBG"/>
									<xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
										<font face="Verdana" size="2" color="#DFEFFF">
											<xsl:value-of select="position()"/>
										</font>
									<xsl:text disable-output-escaping="yes">&lt;/td&gt;</xsl:text>
								</xsl:if>
								<xsl:for-each select="*">
									<xsl:text disable-output-escaping="yes">&lt;td align="center" bgcolor="</xsl:text>
									<xsl:call-template name="cellbgcolor">
										<xsl:with-param name="rpos" select="$rowpos"/>
									</xsl:call-template>
									<xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
										<font face="Verdana" size="2">
											<xsl:text>&#160;</xsl:text>
											<xsl:call-template name="collinkbegin" />
											<xsl:value-of select="."/>
											<xsl:call-template name="collinkend" />
										</font>
									<xsl:text disable-output-escaping="yes">&lt;/td&gt;</xsl:text>
								</xsl:for-each>
							</tr>
						</xsl:if>
					</xsl:for-each>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">&lt;/table&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;</xsl:text>
					</xsl:if>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="cellbgcolor">
		<xsl:param name="rpos"/>
		<xsl:if test="$rpos mod 2=0">
			<xsl:value-of select="$cellBG"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="collinkbegin">
      <xsl:if test="name()='word2'">
		<xsl:text disable-output-escaping="yes">&lt;a href="/TEXT_TEST/KJV_WordService?Word=</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
	  </xsl:if>
      <xsl:if test="name()='did'">
		<xsl:text disable-output-escaping="yes">&lt;a href="/DOXIE/HEADERFILESEARCHSERVICE?DID=</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
	  </xsl:if>
      <xsl:if test="name()='ssn'">
		<xsl:text disable-output-escaping="yes">&lt;a href="/DOXIE/HEADERFILESEARCHSERVICE?SSN=</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
	  </xsl:if>
	</xsl:template>
	<xsl:template name="collinkend">
      <xsl:if test="name()='did' or name()='ssn' or name()='word2'">
		<xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
	  </xsl:if>
	</xsl:template>
</xsl:stylesheet>
*/