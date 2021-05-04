IMPORT doxie,Header;
/*
ds_in := Dataset of LexIds to be used
did_field := LexId field
mod_access := doxie.permissions

bypassTU := skip join to Person Header to integrate Transunion data
returnDates := return date first/last seen, date vendor first/last reported for addresses
slimOutput := remove excess address fields and metadata
isFCRA := if TRUE, use FCRA keys
bypassQH := skip join to Quick Header to integrate QH data
onThor := if TRUE, use Thor function
*/
EXPORT MAC_BestAddr(ds_in, did_field, mod_access, 
																bypassTU = FALSE,
																returnDates = FALSE,
																slimOutput = FALSE,
																isFCRA = FALSE,
																bypassQH = FALSE,
																onThor = FALSE) := FUNCTIONMACRO

local layout_in := doxie.layout_references;

local did_dataset := PROJECT(ds_in,TRANSFORM(layout_in,self.did := left.did_field));

local ds0 := Header.Append_addr_ind(did_dataset,
														 bypassTU,
														 TRUE,//return Ins data - filtered later
														 returnDates,
														 TRUE, //use PR dates
														 slimOutput,
														 isFCRA,
														 bypassQH);
														 
local ds0_thor := Header.Append_addr_ind_thor(did_dataset,
														 bypassTU,
														 TRUE,//return Ins data - filtered later
														 returnDates,
														 TRUE, //use PR dates
														 slimOutput,
														 isFCRA,
														 bypassQH);

local ds := #IF(onThor = TRUE) ds0_thor; #ELSE ds0; #END

local final_result := Consumer_Header_Best.fn_filtPerms(ds,permissions_ds,mod_access);

RETURN SORT(final_result,did,(unsigned)addr_ind,(unsigned)best_addr_rank);

ENDMACRO;