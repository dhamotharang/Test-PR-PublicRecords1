/* Generate a Profile Report for the supplied dataset
 * 
 * @param inFile                         the dataset
 * @param id_field            [optional] numeric cluster identifier (usually UNSIGNED6)
 * @param src_field           [optional] source identifier (usually STRING2)
 * @param CorrelateSampleSize [optional] max records to compare when running a field correlation analysis
 * @param out_prefix          [optional] output name prefix (allows multiple MAC_Profile calls per workunit)
 * @param maxFieldCorr        [optional] max fields allowable to run a field correlation analysis
 * @return                               no return value - this is an action with several outputs
 * 
 * Examples:
 *   SALT311.MAC_Profile(my_dataset);
 *   SALT311.MAC_Profile(my_dataset,pid,source);
 *   SALT311.MAC_Profile(my_dataset,maxFieldCorr:=75);
 */
EXPORT MAC_Profile(inFile,id_field='',src_field='',CorrelateSampleSize=100000000,out_prefix='',maxFieldCorr=50) := MACRO
  SALT311.MOD_Profile(inFile,id_field,src_field,CorrelateSampleSize,out_prefix,maxFieldCorr).out;
ENDMACRO;
