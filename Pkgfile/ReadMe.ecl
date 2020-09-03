///////// Module to handle package files via ECL //////////

//////////////////// IMPORTANT Prerequisites ////////////////

///// Always set the stored cluster value to ensure 
///// you are working with correct cluster
///// For example if working with dev194 use the following line of code 
///// followed by actions

// #stored('cluster','dev194'); or pass the clustername as paramater

//////////////////// IMPORTANT Prerequisites////////////////


//// To refresh package from a landing zone (databuilddev01.risk.regn.net)

// Run - Pkgfile.PopulateFromPackage;


//////// Reading Package File in Flat format /////////

// output(Pkgfile.files('flat').getflatpackage);

//////// Reading Package File in XML format //////// 

// output(Pkgfile.files('xml').getxmlpackage);

//////// Adding Query //////// 

// Pkgfile.add.Queries('<Query name>',,'1','true');

//////// Adding Environment Variables //////// 

// See Pkgfile.ExampletoUpdateQueries

//////// Adding Keys //////// 

// See Pkgfile.ExampleToUpdateData

//////// Deleting Queries, Keys, Environment //////// 

// Pkgfile.delete.packageid('<Query name or dataset name>'); 
// Pkgfile.delete.superfile('<superfilename>');
// Pkgfile.delete.environment('<environment id>');  
// Pkgfile.delete.subfile('<subfile name>'); 

//////// Create XML file on thor //////// 

// Pkgfile.RoxiePackage.BuildPromotePackage(); 

//////// Despray the XML file to databuilddev01 (default) for deployment //////// 

// Pkgfile.RoxiePackage.GetPackage(); 