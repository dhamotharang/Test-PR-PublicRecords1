/* **********************************************************************************
PRTE2_Gong_Ins.U_BWR_Special_Spray_Boca_Layout_CSV
This is because Linda handed us some data in the final Boca layout and no one noticed.
So I have to convert it to our layout too.  Differences from the standard Fn_Spray_And_Build_BaseMain:
1. We spray a CSV file which is in Boca layout
2. We read that temp CSV file
3. We transform it into our Layouts.Alpha_CSV_Layout (note all 'x' fields were lost!)
4. We save this as a new Files.Gong_Base_CSV
5. We also save the sprayed in file as the Boca base (since that's how it originally was)

 *** We have lost any special Alpha-only CSV fields and need to refill them.
***************************************************************************************** */

IMPORT ut, PRTE2_Gong_Ins, PRTE2_Common;
#workunit('name', 'Alpha PRCT special gong File Spray');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'';
CSVName := 'gong_0626_upd2.csv';

BuildFile := PRTE2_Gong_Ins.U_Fn_Special_Spray_Boca_Layout( CSVName, fileVersion );

SEQUENTIAL (BuildFile);