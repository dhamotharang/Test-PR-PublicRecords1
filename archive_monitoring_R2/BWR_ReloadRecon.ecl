// Standard Recon (R) procedure 

// Use !!!PRODUCTION REPOSITORY!!! Monitoring.Environment.ip to get location of the scripts
//    (currently thorprodspray01.br.seisint.com);
// scripts are run from 'newnfsbatch/THORMonitoring/bin';
// Generally, scripts use Monitoring.Proc_NCO_UpdateBase, and
// Proc_NCO_Reload is very similar to it, the main difference is that
// it is (and can be more) tweaked for efficiency sake.

// R files can be found at 'newnfsbatch/recon/'. Each folder corresponds to a particular
// NCO source. Inside each folder can be files of 2 types: NCO input file(s) and one
// consolidated file: '..._recon.txt'. The only real difference is that NCO files have
// trailing records, which is not a big deal (will be filtered out as errors during
// validation process), meaning that any type can be used. If source is not very large,
// say, not more than 5-6 million records, then 'recon.txt' better be used, otherwise,
// several NCO files processed one after another might be preferrable. Using 'recon.txt'
// MAY require modification of Proc_NCO_Reload (NCO source id is taken from a file name).

// When doing R, stop Monitor DB updates. it can be done by running 
//   "./stopStart.sh STOP Vladimir" (where Vladimir is a "user" name; required)

// After processing input R file(s), be sure to process all transactions which were
// delivered AFTER NCO provided us with R files: NCO usually will stop sending updates
// right before sending R file to us, and will resume it about 24 hours later.
// Therefore, by date-time stamp in R files' names, we can decide which transactions
// are to be reprocessed again (using different script): 
//   a) find all input files for this source, which came later than R file (*::in::*<source>*), 
//   b) create a file(s) containing a list of all such filenames (ascending, oldest first), then
//   c) put this file into 'newnfsbatch/THORMonitoring/in.reload/'
//   d) run "./runReload.sh "<filename>" "FALSE"  (false="do not spray", they're already in THOR)

// When R is done, resume DB updates by running
//   "./stopStart.sh START Vladimir"

// ===============  RECON PROC IN DETAILS ===============
string6 nco_id := 'zzz'; // fake, should be like 'N07064'

//1. just on case: backup this NCO source before R
//Monitoring.Tools.BackupNCO (nco_id, '_reload');

//2. Clean given NCO source; FALSE means that short-term history will not be cleaned.
//Monitoring.Tools.CleanNCO (nco_id, FALSE);

//3. Recon; Process files in order base on a filename
// Monitoring.Proc_NCO_Reload ('NCO', 'RC<source>_<YYYYMMDD>_<HHMM|number>.csv', FALSE);
// Monitoring.Proc_NCO_Reload ('NCO', '... etc.');

//OR use single input file
// Monitoring.Proc_NCO_Reload ('NCO', '..._recon.txt');

//4. In case of some errors (like processing a wrong file), rolling back can be helpful:
//Monitoring.Tools.RollbackNCO (nco_id);
// ======================================================

// Just example of taking something from, say, backup, and copying it into working dir
// f_in := Monitoring.Files.Names.BACKUP_DIR + 'nco::nco_n07064::sth_phone_w20080423-104453_reload';
// f_out := Monitoring.Files.Names.THOR_ROOT + 'nco::nco_n07064::sth_phone_saved';
// FileServices.Copy (f_in, Monitoring.Environment.GROUP_NAME, f_out);

/*
//------------------------------------------------------------------
//N07013 (see W20080210-181440)
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN07013_20080207_0928');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN07013_20080207_0929');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN07013_20080207_0930');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN07013_20080207_0931');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN07013_20080207_0951');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN07013_20080207_1007');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN07013_20080207_1028');


//------------------------------------------------------------------------------
//N01037 (W20080211-121243)
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN01037_20080207_1.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN01037_20080207_2.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN01037_20080207_3.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN01037_20080207_4.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN01037_20080207_5.csv');
/* 
UPN01037_20080207_1_appended
UPN01037_20080207_2_appended
UPN01037_20080207_3_appended
UPN01037_20080207_4_appended
UPN01037_20080207_5_appended
UPN01037_20080207_6_appended
NBN01037_20080207_1_appended
UPN01037_20080207_7_appended
UPN01037_20080207_8_appended
UPN01037_20080208_1_appended
UPN01037_20080208_2_appended
UPN01037_20080208_3_appended
UPN01037_20080208_4_appended
UPN01037_20080208_5_appended
UPN01037_20080208_6_appended
UPN01037_20080208_7_appended
DLN01037_20080208_1_appended
UPN01037_20080209_1_appended
UPN01037_20080209_2_appended
UPN01037_20080209_3_appended
UPN01037_20080212_1_appended
UPN01037_20080212_2_appended
UPN01037_20080212_3_appended
UPN01037_20080213_1_appended
UPN01037_20080213_2_appended
NBN01037_20080213_1_appended
UPN01037_20080213_3_appended
UPN01037_20080213_4_appended
UPN01037_20080213_5_appended
*/

//------------------------------------------------------------------------------
//N03051 (W20080211-161120)
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN03051_20080204_1.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN03051_20080204_2.csv');

//------------------------------------------------------------------------------
//N01063 (W20080211-170345)
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN01063_20080208_1.csv');

//------------------------------------------------------------------------------
//N06099 (W20080220-215113)
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1705.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1706.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1707.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1708.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1710.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1711.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1712.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1713.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1714.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_1953.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_2010.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_2021.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_2038.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_2116.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_2119.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_2140.csv');
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCN06099_20080218_2210.csv');

//------------------------------------------------------------------------------
//N07016 (W20080314-093609)
//   Monitoring.Proc_NCO_Recon ('NCO', 'RCN07016_20080313_1015.csv');

//------------------------------------------------------------------------------
//N09023 (W20080314-095052, W20080314-101356)
//   Monitoring.Proc_NCO_Recon ('NCO', 'RCN09023_20080313_1018.csv');
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'dln09023_20080313_1800_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'nbn09023_20080313_1800_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'upn09023_20080313_1800_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'nbn09023_20080314_0500_appended', false);

//------------------------------------------------------------------------------
//U15080 (W20080314-101715, W20080314-102729)
//   Monitoring.Proc_NCO_Recon ('NCO', 'RCU15080_20080313_1017.csv');
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'dlu15080_20080313_1801_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'nbu15080_20080313_1801_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'upu15080_20080313_1801_appended', false);

//------------------------------------------------------------------------------
//U15081 (W20080314-103120) repeated later
//   Monitoring.Proc_NCO_Recon ('NCO', 'RCU15081_20080313_1020.csv');
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'dlu15081_20080313_1800_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'nbu15081_20080313_1800_appended', false);


//------------------------------------------------------------------------------
//N07022 (W20080314-153837, 
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1744.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1745.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1746.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1747.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1748.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1749.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1924.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1927.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07022_20080304_1931.csv');
/*
NBN07022_20080306_1200_appended
DLN07022_20080306_1800_appended
NBN07022_20080306_1800_appended
UPN07022_20080306_1800_appended
DLN07022_20080307_1805_appended
NBN07022_20080307_1805_appended
UPN07022_20080307_1805_appended
DLN07022_20080308_1801_appended
NBN07022_20080308_1801_appended
UPN07022_20080308_1801_appended
DLN07022_20080309_0510_appended
NBN07022_20080309_0510_appended
UPN07022_20080309_0510_appended
DLN07022_20080310_1800_appended
DLN07022_20080311_1800_appended
NBN07022_20080311_1800_appended
UPN07022_20080311_1800_appended
NBN07022_20080312_1200_appended
DLN07022_20080312_1800_appended
NBN07022_20080312_1800_appended
UPN07022_20080312_1800_appended
DLN07022_20080313_1801_appended
NBN07022_20080313_1801_appended
*/


//------------------------------------------------------------------------------
//U15081 (W20080403-102447)
//   Monitoring.Proc_NCO_UpdateBase ('NCO', 'RCU15081_20080313_1020.csv', false); (no history)
// file list : newnfsbatch/THORMonitoring/in.reload/U15081.list (no spray)

//(with history (previous history was taken by Monitor)
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'nbu15081_20080401_1801_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'dlu15081_20080402_1802_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'nbu15081_20080402_1802_appended', false);
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'nbu15081_20080402_1700_appended', false); W20080403-114504


//------------------------------------------------------------------------------
// U15015 (W20080404-173314)
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCU15015_20080226_0953.csv', false);
// file list : newnfsbatch/THORMonitoring/in.reload/U15015.list (no spray)


//------------------------------------------------------------------------------
// N07017
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07017_20080306_1513.csv'); //W20080421-114022
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07017_20080306_1542.csv'); //W20080421-120943
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07017_20080306_1559.csv'); //W20080421-124323
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07017_20080306_1616.csv'); //W20080421-130304
// file list : newnfsbatch/THORMonitoring/in.reload/N07017.list (no spray)


//------------------------------------------------------------------------------
// N07064 (W20080423-152438)
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07064_20080307_recon.txt', false); 
// file list : newnfsbatch/THORMonitoring/in.reload/N07064-1.list (no spray)

//------------------------------------------------------------------------------
//   N07064 again (W20080426-172624)
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07064_20080425_1716.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07064_20080425_1727.csv');
//   Monitoring.Proc_NCO_Reload ('NCO', 'RCN07064_20080425_1737_New.csv');
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'NB07064_20080425_0500_appended', false); //W20080426-175604
// Monitoring.Proc_NCO_UpdateBase ('NCO', 'NB07064_20080425_1204_appended', false); //W20080426-180237


//N04035 (W20081118-151658)
// Monitoring.Proc_NCO_Reload ('NCO', 'RCN04035_20081117_1.csv', FALSE);

  // Monitoring.Proc_NCO_UpdateBase ('NCO', 'DLN04035_20081118_1_appended.csv', true);
  // Monitoring.Proc_NCO_UpdateBase ('NCO', 'upn04035_20081118_1_appended', FALSE);
  // Monitoring.Proc_NCO_UpdateBase ('NCO', 'nbn0403 5_20081118_1_appended', FALSE);
  // Monitoring.Proc_NCO_UpdateBase ('NCO', 'dln04035_20081118_2_appended', FALSE);
  // Monitoring.Proc_NCO_UpdateBase ('NCO', 'upn04035_20081118_2_appended', FALSE);


//N03033 (W20081118-160736)
// Monitoring.Proc_NCO_Reload ('NCO', 'RCN03033_recon.txt');
  // Monitoring.Proc_NCO_UpdateBase ('NCO', 'dln03033_20081118_0913_appended', FALSE);
  // Monitoring.Proc_NCO_UpdateBase ('NCO', 'upn03033_20081118_0913_appended', FALSE);
