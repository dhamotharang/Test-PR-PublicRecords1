// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

#OPTION('multiplePersistInstances',FALSE);

pversion    := '';
//////////////////////////////////////////////////////////////////
// The DL data for MN is now coming from insurance via OKC.  This
// attribute reads the data from insurance's thor and builds the
// file needed for the business group's MN DL process.
// 
// -- Quick Documentation
// --    1. Leave pversion blank in order to reference the rundate
//					from the base files that exists on Alpharetta's thor.
//					
//					However, if you need to run/rerun the build with a dif-
//					ferent pversion, you can override by adding a pversion
//					located at the top of this attribute.
//////////////////////////////////////////////////////////////////
#workunit('name', 'Copy & Preprocess MN RESTRICTED Raw Data');

DriversV2.Proc_Build_DL_MN_RESTRICTED_In_Files(DriversV2.fn_Get_MN_RESTRICTED_RunDate(pversion)).all;