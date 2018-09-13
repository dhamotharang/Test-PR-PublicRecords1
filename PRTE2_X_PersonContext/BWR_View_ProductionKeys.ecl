/* ***********************************************************************************************
PRTE2_X_PersonContext.BWR_View_ProductionKeys.BWR_View_ProductionKeys
add whatever limitations you might want to view
************************************************************************************************/

IMPORT PersonContext, PRTE2_Common_DevOnly;

// OUTPUT(PersonContext.Keys.KEY_LexID);
OUTPUT(PRTE2_Common_DevOnly.MAC_CrossTabCount(PersonContext.Keys.KEY_RecID,datagroup));
OUTPUT(CHOOSEN(PersonContext.Keys.KEY_RecID,500));
COUNT(PersonContext.Keys.KEY_RecID);