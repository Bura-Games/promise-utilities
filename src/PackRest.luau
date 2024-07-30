--!optimize 2
--!strict

--# selene: allow(mixed_table)

local function PackRest<S, T...>(statusOrSuccess: S, ...: T...)
	-- table.pack cringes with typed varargs, so we do this instead.
	return statusOrSuccess, {
		n = select("#", ...);
		select(1, ...);
	}
end

return PackRest
