// -- not perfect, but will get a workunit result that is a set.  limitations are if the set contains elements that have embedded commas
import std;
EXPORT get_Set_Result(string wuid,string pNamedOutput,string pesp = _Config.LocalEsp) :=
function

  get_scalar := WorkMan.get_Scalar_Result(wuid  ,pNamedOutput ,pesp);
  return_set := if(length(trim(get_scalar)) <= 2  //blank set
              ,[]
              ,STD.Str.SplitWords(get_scalar[2..length(trim(get_scalar)) - 1],',')
           );

  return return_set;
  
end;