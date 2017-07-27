/*--HTML--

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:template match="/">
		<html>
		  <head>
			  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		  </head>
			<body>
				<xsl:for-each select="//part">
					<br><xsl:value-of select="name()"/><br>
					<xsl:text disable-output-escaping="yes">&lt;input type="text" name="<xsl:value-of select="name()"/>" &gt;</xsl:text>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
*/