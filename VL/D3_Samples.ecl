//---------------------------------------------------------------------------
// NOTE: THE GRAPHICS PACKAGE USD BY D3 IS *NOT* COMPATIBLE WITH INTERNET
// EXPLORER.  RESULTS FROM THESE EXAMPLES MUST BE VIEWED IN ANOTHER BROWSER
// SUCH AS CHROME OR FIREFOX.
//---------------------------------------------------------------------------
IMPORT VL;
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
  {5367,'David Breyer',236234},
  {470,'Meredith Breyer',16890},
  {555,'Madeline Kennedy',21},
  {21,'Leah Kennedy',236234},
  {198,'Nathan Breyer',236234},
  {5423,'Mackenzie Breyer',198},
  {7890,'Jaidyn Breyer',198},
  {236234,'Donna Breyer',7534},
  {567,'Luca Breyer',5367},
  {8887,'Iago Breyer',5367},
  {80123,'Hannah Breyer',16890},
  {165879,'Alice Alito',7534},
  {2422,'Trevor Breyer',16890},
  {2424,'Hayes Breyer',16890},
  {7769,'Eliza Kennedy',21},
  {16890,'Andrew Breyer',236234},
  {9023,'Shay Thomas',236234},
  {7534,'Clarence Ginsburg Jr.',0},
  {123456,'Kris Roberts',83265},
  {705948,'Lindsay Roberts',123456},
  {83265,'Sandra Sotomayor',7534},
  {2345,'Ty Kagan',675645},
  {27,'Brice Kagan',675645},
  {20,'Bret Roberts',123456},
  {675645,'Joy Kagan',83265},
  {80124,'Kelsey Roberts',123456},
  {43546,'Tracy Scalia',83265},
  {3000,'Sarah Scalia',43546},
  {1024,'Matthew Scali',43546}
],{UNSIGNED id;STRING name;UNSIGNED parent;});

dLabels:=PROJECT(dRelatives,TRANSFORM(VL.Types.GraphLabels,SELF.label:=LEFT.name;SELF:=LEFT;));
dRelationships:=PROJECT(dRelatives,TRANSFORM(VL.Types.GraphRelationships,SELF.id:=LEFT.parent;SELF.linkid:=LEFT.id;));

VL.D3.Graph('Tree','FamilyTree',dLabels,dRelationships);
VL.D3.Graph('VerticalTree','VerticalTree',dLabels,dRelationships);
VL.D3.Graph('Chord','FamilyChord',dLabels,dRelationships);
// dLabels;
// dRelationships;

    // dParentLabels:=JOIN(dRelationships,TABLE(dLabels,{id;STRING parent:=label;}),LEFT.id=RIGHT.id);
    // dChildLabels:=JOIN(dParentLabels,TABLE(dLabels,{id;STRING child:=label;}),LEFT.linkid=RIGHT.id);
    // dWithJson:=TABLE(dChildLabels,{dChildLabels;UNSIGNED level:=0;STRING json:='';});

    // RECORDOF(dWithJson) tGetLevels(DATASET(RECORDOF(dWithJson)) d,UNSIGNED i):=FUNCTION
      // dTop:=PROJECT(JOIN(d(level=0),d(level=0),LEFT.id=RIGHT.linkid,TRANSFORM(LEFT),LEFT ONLY),TRANSFORM(RECORDOF(LEFT),SELF.level:=i;SELF:=LEFT;));
      // RETURN IF(COUNT(d(level=0))=0,d,d(level>0)+dTop+JOIN(d(level=0),dTop,LEFT.id=RIGHT.id,LEFT ONLY));
    // END;
    // dWithLevels:=LOOP(dWithJson,100,tGetLevels(ROWS(LEFT),COUNTER));
// OUTPUT(dWithLevels,ALL);
    
    // iLowestLevel:=MAX(dWithLevels,level);
// iLowestLevel;
    // RECORDOF(dWithLevels) tConstructJson(DATASET(RECORDOF(dWithLevels)) d,UNSIGNED i):=FUNCTION
      // dLowest:=PROJECT(d(level=i),TRANSFORM(RECORDOF(LEFT),SELF.json:=IF(LEFT.json='','{"name":"'+LEFT.child+'"}',LEFT.json);SELF:=LEFT;));
      // dRolled:=ROLLUP(SORT(dLowest,id),LEFT.id=RIGHT.id,TRANSFORM(RECORDOF(LEFT),SELF.json:=LEFT.json+','+RIGHT.json;SELF:=LEFT;));
      // dJoined:=JOIN(d(level<i),dRolled,LEFT.linkid=RIGHT.id,TRANSFORM(RECORDOF(LEFT),SELF.json:=IF(RIGHT.json='','','{"name":"'+LEFT.child+'","children":['+RIGHT.json+']}');SELF:=LEFT;),LEFT OUTER);
      // dFinal:=PROJECT(dRolled,TRANSFORM(RECORDOF(LEFT),SELF.json:='{"name":"'+LEFT.parent+'","children":['+LEFT.json+']}';SELF:=LEFT;));
      // RETURN IF(COUNT(dJoined)=0,dFinal,dJoined);
    // END;
    // dJson:=LOOP(dWithLevels,1,tConstructJson(ROWS(LEFT),iLowestLevel-COUNTER+1));
// dJson;
// dJson[1].json;