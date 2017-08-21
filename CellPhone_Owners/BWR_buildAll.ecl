// Documentation to run this is available at location: \\home\shared\Data Factory\Data Operations\2) Build Documentation\Cellphone Owners\Cellphone Ownership Build.docx

filedate := '20140905';  //today's running date - used in starta outputs
 #workunit('name','CellphoneOwners BaseFile ' + filedate + ' update');

Sequential(
FileServices.ClearSuperFile('~thor_data400::in::cellphoneowners'), // clearing the existing infile updates in the in-superfile before proceeding with spray and building basefile

/* For One Update */
CellPhone_Owners.fSprayInput('20140906_batchr3prod05_cellphone_id'), //<UPDATENAME> is the filename without .CSV from edata12/hds_180/PhoneOwnership

 
 /* for multiple updates : 
(1)  UPDATE DATE should be YYYYMMDD format  ******* Imp ********
(2)  Comment out the above line " CellPhone_Owners.fSprayInput('<UPDATENAME>');" and add as many fsprays as needed.
(3)  Copy and paste all the filenames in the edata12/hds_180/PhoneOwnership
Eg:*/
// CellPhone_Owners.fSprayInput('20140721_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140722_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140723_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140724_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140725_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140726_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140727_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140728_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140729_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140730_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140731_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140801_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140802_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140803_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140804_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140805_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140806_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140807_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140808_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140809_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140811_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140812_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140813_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140814_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140815_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140816_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140817_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140818_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140819_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140820_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140821_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140822_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140824_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140825_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140826_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140827_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140828_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140828_batchr3prod06_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140829_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140901_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140901_batchr3prod06_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140902_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140902_batchr3prod06_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140903_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140904_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140904_batchr3prod06_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140905_batchr3prod05_cellphone_id'),
// CellPhone_Owners.fSprayInput('20140906_batchr3prod05_cellphone_id'),



 CellPhone_Owners.Proc_Build_All(filedate));
 
 