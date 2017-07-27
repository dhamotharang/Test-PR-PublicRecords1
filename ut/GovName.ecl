export GovName(string s) :=
  stringlib.stringfind(s,'CITY OF',1) <> 0 or
       stringlib.stringfind(s,'DISTRICT OF',1) <> 0 or
       stringlib.stringfind(s,'STATE OF',1) <> 0 or
       stringlib.stringfind(s,'TOWN OF',1) <> 0 or
       stringlib.stringfind(s,'TOWNSHIP',1) <> 0 or
       stringlib.stringfind(s,'VILLAGE OF',1) <> 0 or
       stringlib.stringfind(s,'COUNTY',1) <> 0 or
       stringlib.stringfind(s,'COMMONWEALTH OF',1) <> 0 or
       stringlib.stringfind(s,'STATE POLICE',1) <> 0 or
       stringlib.stringfind(s,'PUBLIC LIBRARY',1) <> 0 or
       stringlib.stringfind(s,'FIRE DEPT',1) <> 0 or
       stringlib.stringfind(s,'FIRE DEPARTMENT',1) <> 0 or
       stringlib.stringfind(s,'POLICE DEPARTMENT',1) <> 0 or
       stringlib.stringfind(s,'HOUSING AUTHORITY',1) <> 0 or
       stringlib.stringfind(s,'COMMUNITY COLLEGE',1) <> 0 or
       stringlib.stringfind(s,'CITY UNIVERSITY',1) <> 0 or
       stringlib.stringfind(s,'STATE COLLEGE',1) <> 0 or 
       stringlib.stringfind(s,'JAIL',1) <> 0 or
       stringlib.stringfind(s,'PUBLIC UTILITIES',1) <> 0 or
       stringlib.stringfind(s,'SHERRIFF',1) <> 0 or
       stringlib.stringfind(s,'MUNICIPAL',1) <> 0 or
       stringlib.stringfind(s,'GOVT ',1) <> 0 or
       stringlib.stringfind(s,'GOVERNMENT',1) <> 0;

