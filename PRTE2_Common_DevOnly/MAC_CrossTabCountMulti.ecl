/* ************************************************************************************** 
simplify cross tab reports by multiple fields figure any better syntax for multiple fields????
This isn't pretty way to have flexible number of fields sent in .... HELP THINK!
Returns a simplified table with X fields:  {how ever many fields you send in} + GroupCount

***************************************************************************************************************** 
******** OPEN FOR IDEAS - NOT MUCH TIME TO THINK THIS THROUGH - ANYONE WITH AN IDEA PLEASE SPEAK UP *************
***************************************************************************************************************** 

SAMPLE USE:
DataIn := CustomerTest_VIN.Files.VIN_Base_DS;
DSNewWay := CustomerTest_Common_Dev.MAC_CrossTabCountMulti.ThreeFields(DataIn, Make,Model,Year);
OUTPUT(DSNewWay);
OUTPUT(SORT(DSNewWay,-GroupCount));
OUTPUT(SORT(DSNewWay,Make,Model,Year));

DataIn := CustomerTest_InsHeader_DL_Death.Files.InsHead_Base_DS_PROD;
DSNewWay := CustomerTest_Common_Dev.MAC_CrossTabCountMulti.SevenFields(DataIn,fb_house_num,fb_predir,fb_street,fb_postdir,fb_city,fb_state,fb_unit_no);
OUTPUT(DSNewWay);
OUTPUT(SORT(DSNewWay,-GroupCount));

DSNewWay := CustomerTest_Common_Dev.MAC_CrossTabCountMulti.TwoFields()
DSNewWay := CustomerTest_Common_Dev.MAC_CrossTabCountMulti.ThreeFields()
DSNewWay := CustomerTest_Common_Dev.MAC_CrossTabCountMulti.SevenFields()

************************************************************************************** */

EXPORT MAC_CrossTabCountMulti := MODULE

		// Here's a version without the GroupBy, this also allows us to not TRIM therefore we can take fields that are not STRING
			EXPORT TwoFields(infile,infield1,inField2) := FUNCTIONMACRO
				#uniquename(rec_mac2)
				%rec_mac2% := RECORD
						infile.infield1;
						infile.infield2;
						INTEGER GroupCount := COUNT(GROUP);
				END;			
				// Table has recordset, layout, expression - where expression is used for a GROUP
				// let the caller decide how to sort and display counts.
				RETURN TABLE(infile,%rec_mac2%,inField1,inField2);
			ENDMACRO;

			EXPORT ThreeFields(infile,infield1,inField2, inField3) := FUNCTIONMACRO
				#uniquename(rec_mac3)
				%rec_mac3% := RECORD
						infile.infield1;
						infile.infield2;
						infile.infield3;
						INTEGER GroupCount := COUNT(GROUP);
				END;			
				// Table has recordset, layout, expression - where expression is used for a GROUP
				// let the caller decide how to sort and display counts.
				RETURN TABLE(infile,%rec_mac3%,inField1,inField2,inField3);
			ENDMACRO;


		// Here's a version without the GroupBy, this also allows us to not TRIM therefore we can take fields that are not STRING
			EXPORT SevenFields(infile,infield1,inField2,infield3,inField4,infield5,inField6,infield7) := FUNCTIONMACRO
				#uniquename(rec_mac7)
				%rec_mac7% := RECORD
						infile.infield1;
						infile.infield2;
						infile.infield3;
						infile.infield4;
						infile.infield5;
						infile.infield6;
						infile.infield7;
						INTEGER GroupCount := COUNT(GROUP);
				END;			
				// Table has recordset, layout, expression - where expression is used for a GROUP
				// let the caller decide how to sort and display counts.
				RETURN TABLE(infile,%rec_mac7%,inField1,inField2,inField3,inField4,inField5,inField6,inField7);
			ENDMACRO;

END;