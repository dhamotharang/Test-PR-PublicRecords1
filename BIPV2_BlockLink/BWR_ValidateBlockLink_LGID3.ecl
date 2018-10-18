import BIPV2_Blocklink,BIPV2;
#workunit('name','Validate LGID3 Blocklink'); //Open in a build window to run this.
copy_Record :=BIPV2_Blocklink.ManualOverlinksLGID3.reducedlayout;
//Copy the candidates below as "copy_Dataset". Note, the record structure of the "copy_Dataset" must be "copy_Record"
//a fake Example below:
copy_Dataset :=
  dataset([
{1, 46640408, '', '', 'EARTH-WORKS ', '', ' ', ' ', '127508218', '', '', '', true}, 
{1, 46640408, '', '', 'EARTHQUAKE', '', ' ', ' ', ' ', '', '', '', true}, 
{1, 46640408, '', '', 'EARTHQUAKE EXCAVATING & CLEAR ', '', ' ', '557107112', ' ', '', '', '', true}, 
{1, 46640408, '', '', 'EARTHQUAKE EXCAVATING & LAND CLEARI ', '', ' ', ' ', ' ', '', '', '', true},
{1, 46640408, '', '', 'WORKS EARTH ', '', ' ', ' ', ' ', '', '', '', false}
], copy_Record);
 
//If the following output "Failed_clusters" is not empty then the blocklink maybe failed. 
ds:=BIPV2_Blocklink.ValidateBlocklink.Lgid3Blocklink(copy_Dataset,BIPV2.CommonBase.ds_built);
output(ds, named('Failed_clusters'));