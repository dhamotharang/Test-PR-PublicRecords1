// Unit test case for EditsV2 Parser (Runnable in builder window)
#WORKUNIT('NAME', 'EditsV2 ParseOrder');

IMPORT EditsV2, iesp;

SHARED Layout_Order := EditsV2.Layouts_Order.Order;
SHARED Layout_StrArrayItem := iesp.share.t_StringArrayItem;

// Edits Inquiry or Order
EditsOrder := DATASET([
											 {'000RI01472585SEA               000035909733620000030000                                    0353       HU         0204102009'},
											 {'001PI01RS    MONAT                       CHARLES             S                 05091944   M072349395             Y'},
											 {'001AL01LA 57663    GOLDEN EAGLE LN          SUNRIVER            OR97707000000000000000000000000'},
											 {'001DL01RSSJ861876                 OH'}
											], Layout_StrArrayItem);


Layout_Order Order := EditsV2.Mod_Parser.ParseEditsOrder(EditsOrder);

OUTPUT(EditsOrder, NAMED('EditsOrder'));
OUTPUT(Order, NAMED('Order'));

/**
	Expected Result:
		A new recordset of type EditsV2.Layouts_Order.Order is created.
		RI record (first edits record) should be available under Order.RI01_Recs
		PI record (second edits record) should be available under Order.PI01_Recs
		AL record (third edits record) should be available under Order.AL01_Recs
		DL record (fourth edits record) should be available under Order.DL01_Recs
 */
