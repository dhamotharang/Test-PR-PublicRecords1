/* 
NOTES:
UU utilities were to change from the old terrible "response layout" which the gateway data group sent us.
	(PRTE2_LNProperty.z_Layout_Batch_in)
The new layout Layouts_V2.LN_spreadsheet began with Layouts.layout_LNP_V2_expanded_payload which is the final 
pre-key-build layout that matches Boca data.  That is the final layout from which each key can pull it's fields.
I started with that layout, removed fields that obviously just need to be generated for keys, and altered the field order
to make it more managable for Nancy as a spreadsheet.  I think I added a couple fields that seemed might be helpful, but not many.

PRIOR to doing this the V_ Utilities had filled pretty much all code fields except standardized_land_use_code
They enhanced the old batch_in enough to give reasonable matching and then tied them to XREF, paired address, then production data.
NOTE: V_ utility ONLY read and updated ASSESSMENT type data.  The 250 or so DEED records that we had are still dirty or incomplete.
VV_Refresh_Data_After_UU can be completed and used to update more fields if we find we need them.


ALSO: PLEASE NOTE - moving to this new layout probably has broken all of the existing U_* utility scripts.
And many of them are probably completely obsolete now too after the code fixes from V_*.

*/