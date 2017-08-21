//---------------------------------------------------------------------------
// IMPORTANT:
// Make sure that the "constants" file has been updated to reflect
// a new sVersion (the date the files were recevied from MyLife in YYYYMMDD).
// Also ensure that the files are in the appropriate place in the landing
// zone (\hds_4\mylife\sVersion\, where sVersion is the date mentioned above)
// and that the files are named MyLife1.dat, MyLife2.dat, etc. where MyLife1
// is the primary customer file and the others are the subordinate ones.
//
// To spray the files in:
//   Reunion.mSpray.actionSprayFiles;
//
// To Run the build:
//   Reunion.actionBuildReunion;
//
// To produce statistics from the build:
//   Reunion.mStats.actionShowAll;
//
// To DeSpray the results:
//   Reunion.mSpray.actionDesprayAll;
//
// Space constraints may require that the de-spray is done piecemeal, in
// which case the de-sprays can be called individually using:
//   Reunion.mSpray.actionDesprayCustomer;
//   Reunion.mSpray.actionDesprayThirdParty;
//   etc...
//
// There are two helper scripts on the LZ to encrypt and send the files back
// to MyLife, named "encryptit" and "sendit" (located at \hds_4\mylife).
// Move these scripts to the location of the output files, and then do the
// following:
// Calling "./encryptit main.dat", for example, will create the encrypted
// file "main.dat.gpg" which is the file in the format expected by MyLife.
// Calling "./sendit main.dat.gpg" will send that file to their FTP server.
// Note that you will need to change the folder information in this script
// to accommodate the sVersion, and that the folder you are uploading to must
// already exist on the FTP server.
//---------------------------------------------------------------------------
export _DOCUMENTATION_ := '';