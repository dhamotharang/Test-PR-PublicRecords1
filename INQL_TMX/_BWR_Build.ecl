// pversion := '20190107';
pversion := '20190131a';
#workunit('name', 'INQL TMX Build ' + pversion);

// KJE - KEY build
// Build_Keys(pversion, false, false).all;

// KJE - Daily build
INQL_TMX.Build_All(pversion);

// KJE - Full build
// INQL_TMX.Build_All(pversion,, true);