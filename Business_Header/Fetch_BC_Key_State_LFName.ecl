/*2010-10-18T20:49:49Z (Dave QI)
bug 64620 : use both old and new preferred first function
*/
import NID;

export Fetch_BC_Key_State_LFName(
	STRING2 state_key,
	STRING20 firstname_key,
	STRING20 lastname_key,
	boolean f_loose=false,
	boolean l_loose=false) :=
	project(
		choosen(
			Business_Header.Key_Business_Contacts_State_LFName(
				keyed(state_key = '' or state = state_key) and
				keyed(dph_lname = metaphonelib.DMetaPhone1(lastname_key)) and
				keyed(lastname_key != '' and (l_loose or lastname_key = lname)) and
				keyed(length(trim(firstname_key)) < 2 or 
				      pfname[1..length(trim(NID.mod_PFirstTools.PF(firstname_key)[1]))] = NID.mod_PFirstTools.PF(firstname_key)[1] or 
							NID.mod_PFirstTools.PF(firstname_key)[2] <>'' and 
							pfname[1..length(trim(NID.mod_PFirstTools.PF(firstname_key)[2]))] = NID.mod_PFirstTools.PF(firstname_key)[2]
				      ) and
				keyed(f_loose or fname[1..length(trim(firstname_key))] = firstname_key)),
			5000),
		transform(
			Business_Header.layout_filepos,
			self := left));
