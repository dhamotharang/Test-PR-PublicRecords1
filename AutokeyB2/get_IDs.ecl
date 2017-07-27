import Autokey, autokeyb;

export get_IDs(
	STRING t, 
	string typestr='AK', 
	set of STRING1 get_skip_set=[], 
	boolean workHard = true,
	boolean nofail =true,
  Autokey.IFetch visitor_person = MODULE (Autokey.IFetch) END,
  AutokeyB.IFetch visitor_business = MODULE (AutokeyB.IFetch) END) := 
FUNCTION

ids := AutoKeyB.get_IDs(
	t, 
	typestr, 
	get_skip_set, 
	workHard,
	nofail,
	useAllLookups := true,
  visitor := visitor_person,
  visitorb := visitor_business
); //useAllLookups is the fundamental diff bw b and b2

return ids;

END;
