export IParams := module

		export getServiceParams() := function
			in_mod := module
				export boolean SearchRegisteredAgents := false : stored('SearchRegisteredAgents');
				export boolean SimplifiedContactReturn := false : stored('SimplifiedContactReturn');
				export boolean LatestForMAs := false : stored('LatestForMAs');
			end;
			return in_mod;
		end;

end;
