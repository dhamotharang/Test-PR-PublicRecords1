/*
	Data relation defines the "view" types supported by ATACRAIDS.

	Primary view only allows searches and viewing against the "primary" record. The primary record is defined by the STAMP property equaling 0.
	Secondary View allows for searching the entire case, but only displaying the single matching record.
	Relational View allows searches and viewing on the entire case. This allows users to search against any case with any stamp.
	All views allow searching and displaying any record.

*/
import iesp;
EXPORT DataRelation := MODULE
	EXPORT View := ENUM(UNSIGNED1, None=-1, Primary=0, Secondary=1, Relational=2, AllView=3);
	EXPORT BOOLEAN IsPrimaryView(unsigned1 dr) := dr = View.Primary;
	EXPORT BOOLEAN IsSecondaryView(unsigned1 dr) := dr = View.Secondary;
	EXPORT BOOLEAN IsRelationalView(unsigned1 dr) := dr = View.Relational;
	EXPORT BOOLEAN IsAllView(unsigned1 dr) := dr = View.AllView;
	EXPORT BOOLEAN FetchAll(unsigned1 dr) := dr in [View.None, View.Relational];
	EXPORT SearchFilter(integer stamp, integer dr) := 
		MAP(		
		FetchAll(dr) => true, 
		dr = View.Primary and stamp = 0 => true,
		dr = View.Secondary => true,		
		dr = View.AllView => true,
		false
	);
	EXPORT FetchFilter(integer lstamp, integer rstamp, integer dr) := 
		MAP(		
		FetchAll(dr) => true, 
		lstamp = rstamp => true,
		// dr = View.Primary and lstamp = rstamp => true,
		// dr = View.Secondary and lstamp = rstamp => true, 
		// dr = View.AllView => true,
		false
	);
	EXPORT FromInput(iesp.bair_share.t_BAIRDataRelation inDR) := MAP(
			inDR.Primary => View.Primary,
			inDR.Secondary => View.Secondary,
			inDR.Relational => View.Relational,
			inDR.AllView => View.AllView,
			View.Primary
			);				
END;