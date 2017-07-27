/*--XSLT--

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:template match="/">
		<html>
		  <head>
			  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		  </head>
			<body>
				<xsl:for-each select="//Dataset">
					<xsl:for-each select="Row">
						<xsl:if test="position()=1">
							<xsl:text disable-output-escaping="yes">&lt;table border="1" cellspacing="0" &gt;</xsl:text>
							<tr>
								<xsl:for-each select="*">
									<th>
										<xsl:value-of select="name()"/>
									</th>
								</xsl:for-each>
							</tr>
						</xsl:if>
						<tr>
							<xsl:for-each select="*">
								<td align="center">
									<xsl:value-of select="."/>
								</td>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
					<xsl:if test="position()=last()">
						<xsl:text disable-output-escaping="yes">&lt;/table&gt;</xsl:text>
					</xsl:if>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
*/