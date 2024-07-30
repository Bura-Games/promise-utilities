--!optimize 2
--!strict

--# selene: allow(mixed_table)

local Promise = require(script.Parent.Parent.Promise)

local function PackResults<T...>(status: Promise.Status, ...: T...)
	-- table.pack cringes with typed varargs, so we do this instead.
	return status, {
		n = select("#", ...);
		select(1, ...);
	}
end

--[=[
	The functionality of this is meant to be the same as the `await` keyword in
	ECMAScript. This allows returning multiple values!

	```lua
	local function PromiseUpperAndLower(value: string): Promise<string, string>
		return Promise.new(function(resolve)
			resolve(string.upper(value), string.lower(value))
		end)
	end
	local upper, lower = PromiseUtilities.AwaitMulti(PromiseUpperAndLower("hi"))
	```

	:::tip Behavior
	This function is almost entirely identical to `Promise.expect`. You can
	probably just use that instead!
	:::

	@function AwaitMulti
	@within PromiseUtilities

	@error CancelledError -- Thrown if the Promise was cancelled.
	@error RejectedError -- Thrown if the Promise was rejected.

	@yields
	@param ... T | Promise<T...>
	@return T
]=]
local function AwaitMulti<T...>(...: any): T...
	local promise: Promise.TypedPromise<T...> = ...
	if not Promise.is(promise) then
		return ...
	end

	local status, values = PackResults(promise:awaitStatus())
	if status == Promise.Status.Resolved then
		return table.unpack(values, 1, values.n)
	end

	if status == Promise.Status.Rejected then
		error(values[1] or "Unknown rejection?", 2)
	end

	error("The awaited Promise was cancelled", 2)
end

return AwaitMulti
