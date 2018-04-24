/* ********************************************************************************************
PRTE2_Header_Ins.BWR_Spray_Alpha_Base
***********************************************************************************************
NOTE: to add new records - must be added to Alpha IHDR, then moved thru the MHDR and then into
PRTE2_Header_Ins_Data_Work.BWR_Add_New_Alp_MHDR_to_Alp_Base to then add them in here.
This needs to become more streamlined after Data1 project - when that is complete we can
move the logic from Alpharetta's CustomerTest_IHDR_MHDR_BHDR.BWR_IHDR_Add_to_MHDR into Boca and
COMBINE those two programs logic to:
1. Read all IHDR foreign and select any new LexIDs that do not exist in this base file.
2. Run those IHDR records thru CustomerTest_IHDR_MHDR_BHDR.BWR_IHDR_Add_to_MHDR logic
3. Run those prepared records thru PRTE2_Header_Ins_Data_Work.BWR_Add_New_Alp_MHDR_to_Alp_Base logic (or combine those)
4. Append the results to the Alpharetta base file (Check if there is there any preprocessing missing???)
***********************************************************************************************

 BWR_Spray_Alpha_Base - NEW FOR Boca Business Case changes...    
 This is for initial Header data for Alpharetta
  Must Spray, do data prep, then save using the same base file and name for now.
1/26/17 - I just need to review this - I think that the data prep was part of the spray/base file 
steps and if so... we're good.  If not, I need to add those into the spray step.

Nov 2017, altered Constants for new LZ and this had no problem with a compile - have not tested spray.
Feb 2018, check with Gabriel - do they use our relations base file or is this not needed?
... talked with Gabriel, I don't think so but somewhat concerned to alter it for now. The *DO*
read from the relative file, but Gabriel says they blank out the relative_title which kinda starts
over.  Check out PRTE2_Header.file_relatives, Relationship.file_relative, Relationship.key_relatives_v3
NOTE: in the boca build, our data somes in with "Legacy" data from: 
					PRTE2_Header.file_header_base references: PRTE.File_PRTE_Header,
					PRTE2_Header.file_relatives references: PRTE.Get_Header_Base.payload, 
					PRTE2_Header.files references: PRTE.Get_payload.header
*********************************************************************************************** */


IMPORT ut, PRTE2_Header_Ins, PRTE2_Common;
#workunit('name', 'Spray PRCT Alpharetta Person-Header File');
#OPTION('multiplePersistInstances',FALSE);

fileVersion	:= PRTE2_Common.Constants.TodayString+'';
CSVName := 'PersonHeader_Alpha_DEV_AfterAdds_20180212.csv';

BuildFile := PRTE2_Header_Ins.fn_Spray_Alpharetta_Base( CSVName, fileVersion );

SEQUENTIAL (BuildFile);
